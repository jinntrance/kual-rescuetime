# kual-rescuetime
Log your Kindle e-reader's reading metrics to RescueTime with IFTTT

## Installation

- JailBreak your Kindle and install [KUAL2](https://www.mobileread.com/forums/showthread.php?t=203326).
- Download [KUAL RescueTime](https://github.com/jinntrance/kual-rescuetime/archive/master.zip) and unzip it.
- Create your own [IFTTT RescueTime applet](https://ifttt.com/applets/86337494d-log-kindle-reading-duration-to-rescuetime).
- Then look at [Documentations](https://ifttt.com/maker_webhooks) to find you key.
- Replace your key within file at `bin/env.sh`
- Check the log file location in file `etc/rescuetime.conf`
- Rename the folder to `kual-rescuetime` and copy it into Kindle's directory named `extensions`
- `Enable RescueTime Log` within KUAL and it will try to sync every an hour. Or you can `Sync Manually` when Kindle is connected to the Internet.

## References

1. [KUAL What's New](https://wiki.mobileread.com/wiki/KUAL_What%27s_New#Sample_json.menu_And_Template_Migration)
2. [Kykky: Know our kindle, know yourself](https://github.com/KangbingZhao/kykky)
