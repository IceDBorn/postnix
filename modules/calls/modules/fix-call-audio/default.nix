{
  pkgs,
  ...
}:

{
  home.packages = [
    (pkgs.writeShellScriptBin "fix-call-audio" ''
      STATE_FOLDER="$XDG_RUNTIME_DIR/fix-call-audio"
      ACTIVE_CALL="$STATE_FOLDER/active-call"
      CURRENT_DEVICE="$STATE_FOLDER/current-device"
      EARPIECE="Top Digital PCM Volume"
      SPEAKER="Bottom Digital PCM Volume"

      mkdir -p "$STATE_FOLDER"

      getVolume () {
        volume=$(wpctl get-volume "@DEFAULT_AUDIO_SINK@" | grep -Eo "[0-9]+(\.[0-9]+)?")
        percent=''${volume:0:1}
        value=''${volume: -2}

        if [ "$value" = "00" ]; then
            if [ "$percent" = "1" ]; then
                volume="100"
            else
                volume="0"
            fi
        else
            volume="$value"
        fi

        echo "$volume"
      }

      setDeviceVolume () {
        amixer -c 0 cset name="$1" "$2%" >/dev/null
        echo "Set $1 to $2% volume"
      }

      getActiveCall () {
        if [ -f "$ACTIVE_CALL" ]; then
          echo true
        else
          echo false
        fi
      }

      toggleActiveCall () {
        if [ -f "$ACTIVE_CALL" ]; then
          setCurrentDevice "$SPEAKER"
          setDeviceVolume "$EARPIECE" "0"
          setDeviceVolume "$SPEAKER" "80"
          rm "$ACTIVE_CALL"
          echo "Call Ended"
        else
          setCurrentDevice "$EARPIECE"
          setDeviceVolume "$EARPIECE" "$(getVolume)"
          setDeviceVolume "$SPEAKER" "0"
          touch "$ACTIVE_CALL"
          echo "Call Started"
        fi
      }

      setCurrentDevice () {
        echo "$1" > "$CURRENT_DEVICE"
      }

      getCurrentDevice () {
        cat "$CURRENT_DEVICE"
      }

      toggleDevice () {
        if [ "$(getCurrentDevice)" = "$SPEAKER" ]; then
          setCurrentDevice "$EARPIECE"
          setDeviceVolume "$EARPIECE" "$(getVolume)"
          setDeviceVolume "$SPEAKER" "0"
        else
          setCurrentDevice "$SPEAKER"
          setDeviceVolume "$EARPIECE" "0"
          setDeviceVolume "$SPEAKER" "$(getVolume)"
        fi

        echo "Current device set to $(getCurrentDevice)"
      }

      setCurrentDevice "$SPEAKER"
      echo "Fix call audio running"

      while read -r line; do
        echo "$line" | tee \
          >(grep -Eq 'Accept|Hangup' && toggleActiveCall) \
          >(grep -q 'EnableSpeaker' && getActiveCall && toggleDevice) \
          >(grep -q 'ShowOSD' && getActiveCall && setDeviceVolume "$(getCurrentDevice)" "$(getVolume)") >/dev/null
      done < <(dbus-monitor --profile)
    '')
  ];
}
