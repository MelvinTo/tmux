#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

HOSTS="fire.walla 223.5.5.5 google.com github.com example.com"

get_ssid()
{
  # Check OS
  case $(uname -s) in
    Linux)
      SSID=$(iw dev | sed -nr 's/^\t\tssid (.*)/\1/p')
      if [ -n "$SSID" ]; then
        printf '%s' "$SSID"
      else
        echo 'Ethernet'
      fi
      ;;

    Darwin)
      if /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | grep -E ' SSID' | cut -d ':' -f 2 | sed 's/^[[:blank:]]*//g' &> /dev/null; then
        SSID="$(/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | grep -E ' SSID' | cut -d ':' -f 2 | sed 's/^[[:blank:]]*//g')"
        RSSI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | grep -E ' agrCtlRSSI' | cut -d ':' -f 2 | sed 's/^[[:blank:]]*//g')"
        RATE="$(/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | grep -E ' lastTxRate' | cut -d ':' -f 2 | sed 's/^[[:blank:]]*//g')"
        printf '%s (%s, %smbps)' "$SSID" "$RSSI" "$RATE"
      else
        echo 'Ethernet'
      fi
      ;;

    CYGWIN*|MINGW32*|MSYS*|MINGW*)
      # leaving empty - TODO - windows compatability
      ;;

    *)
      ;;
  esac

}

main()
{
  network="Offline"
  for host in $HOSTS; do
    if ping -q -c 1 -W 1 $host &>/dev/null; then
      network="$(get_ssid)"
      break
    fi
  done

  echo "$network"
}

#run main driver function
main
