import subprocess
import os


class DEVICES:
    EARPIECE = "Top Digital PCM Volume"
    SPEAKER = "Bottom Digital PCM Volume"


class CALL_STATE:
    PATH = "/tmp/call/call_state"
    ACTIVE = 2
    INACTIVE = 0
    PENDING = 1


lastState = CALL_STATE.INACTIVE


def getVolume():
    unparsedVolume = subprocess.getoutput(
        "wpctl get-volume @DEFAULT_AUDIO_SINK@")

    return int(''.join(i for i in unparsedVolume if i.isdigit()))


def setDeviceVolume(device, volume):
    subprocess.getoutput(
        "amixer -c 0 cset name='{}' '{}%'".format(device, volume))

    print("Set {} to {}%".format(device, volume))


def setActiveDevice(device):
    match device:
        case DEVICES.EARPIECE:
            setDeviceVolume(DEVICES.EARPIECE, 85)
            setDeviceVolume(DEVICES.SPEAKER, 0)
        case DEVICES.SPEAKER:
            setDeviceVolume(DEVICES.SPEAKER, 85)
            setDeviceVolume(DEVICES.EARPIECE, 85)

    print("Current device set to {}".format(device))


def toggleCallState(state):
    global lastState

    match state:
        case CALL_STATE.INACTIVE:
            lastState = CALL_STATE.INACTIVE
            setActiveDevice(DEVICES.SPEAKER)
            print("Call ended")
        case CALL_STATE.ACTIVE:
            lastState = CALL_STATE.ACTIVE
            setActiveDevice(DEVICES.EARPIECE)
            print("Call started")


def watchBashCommand(command):
    process = subprocess.Popen(
        command, stdout=subprocess.PIPE, universal_newlines=True)

    for line in iter(process.stdout.readline, ""):
        yield line

    process.stdout.close()
    return_code = process.wait()

    if return_code:
        raise subprocess.CalledProcessError(return_code, command)


def initializeCallStateFile():
    if not os.path.exists(CALL_STATE.PATH):
        os.makedirs(CALL_STATE.PATH.strip("call_state"), exist_ok=True)
        open(CALL_STATE.PATH, "x")


def watchCallState():
    initializeCallStateFile()

    for _ in watchBashCommand(["inotifywait", "-m", CALL_STATE.PATH, "-q", "-e", "close_write"]):
        state_file = open(CALL_STATE.PATH, "r")
        current_state = int(state_file.read())
        state_file.close()

        if (current_state != lastState):
            toggleCallState(current_state)


print("Call audio handle running")
watchCallState()
