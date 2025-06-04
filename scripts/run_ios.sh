#!/bin/bash

# Change to the Flutter project directory
cd "$(dirname "$0")/.."

# Function to check if iOS simulator is running
is_simulator_running() {
    xcrun simctl list devices | grep -i "iphone" | grep -i "booted" > /dev/null
    return $?
}

# Function to get the first available iPhone simulator
get_iphone_simulator() {
    xcrun simctl list devices | grep -i "iphone" | grep -i "shutdown" | head -n 1 | sed -E 's/.*"([^"]+)".*/\1/'
}

# Check if simulator is already running
if ! is_simulator_running; then
    echo "Starting iOS Simulator..."
    # Get the first available iPhone simulator
    SIMULATOR_NAME=$(get_iphone_simulator)
    
    if [ -z "$SIMULATOR_NAME" ]; then
        echo "No iPhone simulator found. Launching default simulator..."
        flutter emulators --launch apple_ios_simulator
    else
        echo "Launching $SIMULATOR_NAME..."
        xcrun simctl boot "$SIMULATOR_NAME"
        open -a Simulator
    fi
    
    # Wait for simulator to boot
    echo "Waiting for simulator to boot..."
    sleep 5
fi

# Run the Flutter app
echo "Running Flutter app..."
flutter run -d "iPhone" 