# GoDaddy-DDNS-Automation
This script implements DDNS through GoDaddy; updating records with the current public IP of your network.

This project is under the [MIT License.](https://opensource.org/licenses/MIT)

# Running the script
## Prerequisites
* A GoDaddy account with a domain.
* A production key/secret combination. This can be obtained through [GoDaddy's API Keys site](https://developer.godaddy.com/keys/).
## Windows Powershell
The script requires the following arguments:

* domain - The domain name; example.com.
* recordType - The type of record; A, CNAME, MX, etc.
* record - The name of the Record; @, server, mail, vpn, etc.
* key - The production Key generated from [GoDaddy's API Keys site](https://developer.godaddy.com/keys/)
* secret - The Secret that corresponds to the key generated above.

The following arguments are optional:

* ttl - The TTL in seconds. The script defaults to 600, but GoDaddy defaults to 3600.

If the values are not specified as arguments, then the user will be prompted for them.

# Issue, comments, and contributions

If you experience an issue running this script, please log it in [GitHub](https://github.com/chadbirch/GoDaddy-DDNS-Automation/issues). I'll try to respond when I'm free, but I make no guarantee regarding a timeline.

The same goes for any questions or discussion topics.

If you would like to contribute to this project, please feel free. Some areas to focus on are:

* Improving the Powershell script
* Porting the Powershell script to Unix/Linux.
* Providing modifications that enable the Unix/Linux script to run on routers such as [dd-wrt](http://www.dd-wrt.com/), [OpenWrt](https://openwrt.org/), and [Tomato](http://www.polarcloud.com/tomato).