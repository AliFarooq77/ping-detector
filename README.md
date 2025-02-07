# Ping Detector

A security monitoring tool that detects ping attempts to your machine and sends email notifications to system administrator.

## Overview

The Ping Detector consists of two main components:
1. A bash script (`ping_detector.sh`) that monitors incoming ICMP ping requests
2. A Python script (`send_mail.py`) that handles email notifications

When a ping attempt is detected, the system immediately notifies the configured administrator via email.

## Prerequisites

- Linux-based operating system
- `tcpdump` package installed
- Python 3.x
- Gmail account for sending notifications (with App Password configured)

## Installation

1. Clone or download both scripts to your local machine
2. Make the bash script executable:
```bash
chmod +x ping_detector.sh
```

## Configuration

### Email Setup

Before running the script, you need to configure the email settings in `send_mail.py`:

1. Open `send_mail.py` in a text editor
2. Fill in the following fields:
   - `email`: Your Gmail address
   - `receiver_email`: The administrator's email address
   - Add your Gmail App Password in the `server.login()` function

**Note**: For security reasons, you must use an App Password instead of your regular Gmail password.

### Network Interface

The script currently monitors the `wlp0s20f3` interface. If your network interface is different:

1. Open `ping_detector.sh`
2. Replace `wlp0s20f3` with your network interface name
3. Update the IP address (`192.168.0.207`) to match your machine's IP

You can find your network interface name using:
```bash
ip addr show
```

## Usage

Run the script with sudo privileges:

```bash
sudo ./ping_detector.sh
```

The script will:
1. Monitor incoming ping requests
2. Create a temporary file (`ping_result.txt`) to store detection results
3. Send an email notification when a ping is detected
4. Clean up processes and temporary files automatically

## Output

- Console output will show when ping attempts are detected
- Email notifications will be sent to the configured administrator
- The subject line will be "Ping Detected"
- The message will indicate that someone is attempting to ping the machine

## Troubleshooting

1. If you see "Python script failed!":
   - Check your email configuration
   - Verify your App Password is correct
   - Ensure you have internet connectivity

2. If the script isn't detecting pings:
   - Verify you're running with sudo privileges
   - Confirm the network interface name is correct
   - Check that tcpdump is installed and working

## Author

Ali Farooq

## Version

1.0

## License

This script is licensed under the GPL License. See LICENSE for more details.
