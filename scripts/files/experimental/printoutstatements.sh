#!/data/data/com.termux/files/usr/bin/bash -e
# Copyright 2017 by SDRausty. All rights reserved.
# Website for this project at https://sdrausty.github.io/TermuxArch 
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You! 
# 🕧🕐🕜🕑🕝🕒🕞🕓🕟🕔🕠🕕🕡🕖🕢🕗🕣🕘🕤🕙🕥🕚🕦🕛
# Printout statement subroutines for `setupTermuxArch.sh`.
################################################################################

printdetectedsystem ()
{
	printf "\n\033[36;1m 🕑 < 🕛 \033[1;34mDetected $(uname -m) " 
	detectsystem2p 
}

printdownloading ()
{
	printf "\n\033[36;1m 🕝 < 🕛 \033[1;34mActivating termux-wake-lock.  Now downloading \033[36;1m$file \033[1;34mand the corresponding checksum.  \033[37;1mThis may take a long time depending on your Internet connection.  \n\n\033[36;1m"'\033]2;  🕝 < 🕛 Now downloading the system image file and the corresponding checksum.  \007'
}

printconfigq ()
{
	printf "\n\033[36;1m 🕙 < 🕛 \033[1;34mYour Arch Linux in Termux is installed! Please answer the following questions to complete the Arch Linux configuration.  \n\n\033[0m"'\033]2; 🕙 < 🕛 Your Arch Linux in Termux is installed! Please complete the Arch Linux configuration.  📲  \007'
}

printmd5check ()
{
	printf "\n\033[36;1m 🕠 < 🕛 \033[1;34mChecking download integrity with md5sum.  \033[37;1mThis may take a little while.  \n\n\033[36;1m"
}

printmd5error ()
{
	printf "\n\033[07;1m\033[31;1m 🔆 ERROR md5sum mismatch! The download was corrupt! Removing failed download.\033[36;1m  Run setupTermuxArch.sh again!  See https://sdrausty.github.io/TermuxArchPlus/md5sums for more information.  This kind of error can go away, sort of like magic.  Waiting a few minutes before executing again is recommended. There are many reasons that generate checksum errors.  Proxies are one reason.  Mirroring and mirrors are another explaination for md5sum errors.  Either way it means this download was corrupt.  If this keeps repeating, please change your mirror with an editor like vi in \033[37;1mknownconfigurations.sh\033[36;1m.  See https://sdrausty.github.io/TermuxArchPlus/mirrors for more information.  \n\n	Run setupTermuxArch.sh again. \033[31;1mExiting...  \n\033[0m"
	exit 
}

printmd5success ()
{
	printf '\033]2;  🕡 < 🕛 Now uncompressing the system image file.  This will take much longer!  Be patient.  \007'"\n\033[36;1m 🕕 < 🕛 \033[1;34mDownloaded files integrity: \033[36;1mOK  \n\n\033[36;1m 🕡 < 🕛 \033[1;34mNow uncompressing \033[36;1m$file\033[37;1m.  This will take much longer!  Be patient.  \n\033[0m"
}

printmismatch ()
{
	printf "\n\033[07;1m\033[31;1m 🔆 ERROR Unknown configuration!  Did not find an architecture and operating system match in\033[37;1m knownconfigurations.sh\033[31;1m!  \033[36;1mDetected $(uname -mo).  There still is hope.  Check at http://mirror.archlinuxarm.org/os/ and https://www.archlinux.org/mirrors/ for other available images and see if any match your device.  If you find a match, then please \033[37;1msubmit a pull request\033[36;1m at https://github.com/sdrausty/TermuxArch/pulls with script modifications.  Alternatively, \033[37;1msubmit a modification request\033[36;1m at https://github.com/sdrausty/TermuxArch/issues if you find a configuration match.  Please include output from \033[37;1muname -mo\033[36;1m on the device in order to expand autodetection for \033[37;1msetupTermuxArch.sh\033[36;1m.  See https://sdrausty.github.io/TermuxArchPlus/Known_Configurations for more information.  \n\n	\033[36;1mRun setupTermuxArch.sh again. \033[31;1mExiting...  \n\033[0m"
	exit 
}

printfooter ()
{
	printf "\n\033[36;1m 🕥 < 🕛 \033[1;34mUse \033[32;1m./arch/$bin\033[1;34m from your \033[32;1m\$HOME\033[1;34m directory to launch Arch Linux in Termux for future sessions.   Alternatively copy \033[32;1m$bin\033[1;34m to your \033[32m\$PATH\033[1;34m which is, \033[37m\"$PATH\"\033[0m.  \n\n"'\033]2;  Thank you for using `setupTermuxArch.sh` to install Arch Linux in Termux 📲  \007'
	copybin2path
	printf "\033[1;32m 🕛 = 🕛 \033[1;34mTermux-wake-lock released.  Your Arch Linux in Termux is installed and updated.  Use \033[32;1m\`tzselect\`\033[1;34m to assit in setting your time zone.  See https://github.com/sdrausty/TermuxArch/issues/25 "Starting Arch Linux from Termux?" for more information.  \n\n\033[0m"
}

