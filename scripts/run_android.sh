#!/bin/bash

# Change to the Flutter project directory
cd "$(dirname "$0")/.."

# Function to check if Android emulator is running
is_emulator_running() {
    adb devices | grep -i "emulator" > /dev/null
    return $?
}

# Function to get the first available Android emulator
get_android_emulator() {
    flutter emulators | grep -i "api" | head -n 1 | awk '{print $1}'
}

# Function to get the running emulator device ID
get_running_emulator_id() {
    adb devices | grep -i "emulator" | awk '{print $1}'
}

# Check if emulator is already running
if ! is_emulator_running; then
    echo "Starting Android Emulator..."
    # Get the first available Android emulator
    EMULATOR_ID=$(get_android_emulator)
    
    if [ -z "$EMULATOR_ID" ]; then
        echo "No Android emulator found. Please create one using Android Studio."
        exit 1
    else
        echo "Launching $EMULATOR_ID..."
        flutter emulators --launch "$EMULATOR_ID"
    fi
    
    # Wait for emulator to boot
    echo "Waiting for emulator to boot..."
    # Wait until the emulator is fully booted
    while ! adb shell getprop sys.boot_completed 2>/dev/null | grep -q "1"; do
        sleep 2
        echo "Still waiting for emulator to boot..."
    done
    echo "Emulator is ready!"
fi

# Get the running emulator device ID
DEVICE_ID=$(get_running_emulator_id)
if [ -z "$DEVICE_ID" ]; then
    echo "Error: Could not find running emulator device ID"
    exit 1
fi

# Run the Flutter app
echo "Running Flutter app on $DEVICE_ID..."
flutter run -d "$DEVICE_ID" 