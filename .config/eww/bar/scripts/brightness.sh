FILE="/sys/class/backlight/intel_backlight/actual_brightness"
max_brightness=$(cat /sys/class/backlight/intel_backlight/max_brightness)

get_brightness() {
  echo $1
  echo $max_brightness
  echo $(($1 * 100 / $max_brightness))
}

if [ ! -e "$FILE" ]; then
  echo "File $FILE does not exist."
  exit 1
fi

echo "Watching $FILE for changes..."

# Initial read
get_brightness $(cat "$FILE")

# Monitor for changes
while inotifywait -e modify "$FILE" > /dev/null; do
  get_brightness $(cat "$FILE")
done
