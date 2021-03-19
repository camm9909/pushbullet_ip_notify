# Pushbullet notifications on remote IP Change

![alt text](https://github.com/ckbaudio/pushbullet_ip_notify/blob/main/pb_screenshot.jpg)


Simple bash script that allows for [Pushbullet](https://www.pushbullet.com/) notifications to mobile/desktop apps whenever a remote IP changes. Useful for SSHing remote home connections that have dynamically-assigned IP's. Originally made so I could manage a relatives home media server remotely, for anything else use a Dynamic DNS.

This example is with Pushbullet but you can use alternative notification services so long as they support API calls. 

## Usage
1. Create an account with [Pushbullet](https://www.pushbullet.com/)
2. Install their mobile app or desktop/browser extension
3. On your remote machine, in any directory of your choosing, use: 
   * `wget -L https://raw.githubusercontent.com/ckbaudio/pushbullet_ip_notify/main/pb_ipcheck.sh` 
4. [Create a token](https://www.pushbullet.com/#settings) in Pushbullet
5. Paste your token inside `pb_ipcheck.sh` via replacing `pbapi="ur_token_here"`
   * Additionally, you can change the location of the ip.txt (default is script location).
6. Make the script executable: `sudo chmod +x pb_ipcheck.sh`
7. Create a scheduled task as root via `sudo crontab -e` with `0 */6 * * * ./home/usrname/pb_ipcheck.sh`
   * This example will run a check every 6 hours
