# s2a

**s2a** is a simple Bash script that lets you quickly send images from your PC to an Android device or emulator. It works with single images or entire directories and automatically triggers a media scan on the device so images appear immediately.

## Features

- Push a single image or multiple images from a folder  
- Automatically triggers Android media scan  
- Works with both physical devices and emulators via `adb`  
- Robust handling of spaces in filenames, empty directories, and common errors  

## Requirements

- **Bash** (Linux, macOS, or WSL on Windows)  
- **ADB (Android Debug Bridge)** installed and in your `PATH`  
- Android device or emulator connected  

## Installation

1. Clone the repository:

```bash
git clone https://github.com/yourusername/s2a.git
cd s2a
```

2. Make the script executable:

```bash
chmod +x s2a.sh
```

3. Move the script to a folder in your system **PATH** to use it globally:

```bash
sudo mv s2a.sh /usr/local/bin/s2a
```

> Now you can run it as `s2a` from anywhere.

---

## Usage

### Send a single image:

```bash
s2a /path/to/image.jpg
```

### Send all images in a directory:

```bash
s2a /path/to/images_directory
```

- Images are sent to `/sdcard/Pictures/` on your Android device  
- The script automatically triggers a media scan so the images appear in the gallery immediately  

## Example

```bash
# Send a single image
s2a ~/Pictures/photo.png

# Send an entire folder
s2a ~/Downloads/Images
```
