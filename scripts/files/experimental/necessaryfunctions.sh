#!/data/data/com.termux/files/usr/bin/bash -e
# Copyright 2017 by SDRausty. All rights reserved.
# Website for this project at https://sdrausty.github.io/TermuxArch
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You 
################################################################################

adjustmd5file ()
{
	if [ $(uname -m) = x86_64 ] || [ $(uname -m) = i686 ];then
		wget -q -N --show-progress http://$mirror${path}md5sums.txt
		filename=$(ls *tar.gz)
		sed '2q;d' md5sums.txt > $filename.md5
		rm md5sums.txt
	else
		wget -q -N --show-progress http://$mirror$path$file.md5
	fi
}

callsystem ()
{
	mkdir -p $HOME/arch
	cd $HOME/arch
	detectsystem
}

copybin2path ()
{
	printf " 🕚 \033[36;1m<\033[0m 🕛 "
	while true; do
	read -p "Copy \`$bin\` to your \`\$PATH\`? [y|n]  " answer
	if [[ $answer = [Yy]* ]];then
		cp $HOME/arch/$bin $PREFIX/bin
		printf "\n 🕦 \033[36;1m<\033[0m 🕛 Copied \033[32;1m$bin\033[0m to \033[1;34m$PREFIX/bin\033[0m.\n\n"
		break
	elif [[ $answer = [Nn]* ]];then
		printf "\n"
		break
	elif [[ $answer = [Qq]* ]];then
		printf "\n"
		break
	else
		printf "\n 🕚 \033[36;1m<\033[0m 🕛 You answered \033[33;1m$answer\033[0m.\n"
		printf "\n 🕚 \033[36;1m<\033[0m 🕛 Answer Yes or No (y|n).\n\n"
	fi
	done
}

detectsystem ()
{
	printdetectedsystem
	if [ $(getprop ro.product.cpu.abi) = armeabi ];then
		armv5l
	elif [ $(getprop ro.product.cpu.abi) = armeabi-v7a ];then
		detectsystem2 
	elif [ $(getprop ro.product.cpu.abi) = arm64-v8a ];then
		aarch64
	elif [ $(getprop ro.product.cpu.abi) = x86 ];then
		i686 
	elif [ $(getprop ro.product.cpu.abi) = x86_64 ];then
		x86_64
	else
		printmismatch 
	fi
}

detectsystem2 ()
{
	if [[ $(getprop ro.product.device) == *_cheets ]];then
		armv7lChrome 
	else
		armv7lAndroid  
	fi
}

detectsystem2p ()
{
	if [[ $(getprop ro.product.device) == *_cheets ]];then
	printf "Chromebook.  \n\033[0m"
	else
	printf "$(uname -o) Operating System.  \n\033[0m"
	fi
}

getimage ()
{
	# Get latest image for x86_64 wants refinement.  __Continue does not work.__ 
	if [ $(getprop ro.product.cpu.abi) = x86_64 ];then
		wget -A tar.gz -m -nd -np http://$mirror$path
	else
		wget -q -c --show-progress http://$mirror$path$file
	fi
}

makebin ()
{
	makestartbin 
	printconfigq 
	touchupsys 
}

makesystem ()
{
	printdownloading 
	termux-wake-lock 
	getimage
	adjustmd5file 
	printmd5check
	if md5sum -c $file.md5 ; then
		printmd5success
		preproot 
	else
		rm -rf $HOME/arch
		printmd5error
	fi
	rm *.tar.gz *.tar.gz.md5
	makebin 
}

preproot ()
{
	if [ $(uname -m) = x86_64 ] || [ $(uname -m) = i686 ];then
		proot --link2symlink bsdtar -xpf $file --strip-components 1 2>/dev/null||:
	else
		proot --link2symlink bsdtar -xpf $file 2>/dev/null||:
	fi
}

touchupsys ()
{
	mkdir -p root/bin
	addbash_profile 
	addbashrc 
	addprofile 
	addga
	addgcl
	addgcm
	addgp
	addgpl
	addmotd
	addresolvconf 
	addt 
	addyt 
	addv 
	setlocalegen
	printf "\n\033[32;1m"
	while true; do
	read -p "Do you want to use \`nano\` or \`vi\` to edit your Arch Linux configuration files [n|v]?  "  nv
	if [[ $nv = [Nn]* ]];then
		ed=nano
		apt-get -qq install nano --yes 
		break
	elif [[ $nv = [Vv]* ]];then
		ed=vi
		break
	else
		printf "\nYou answered \033[36;1m$nv\033[32;1m.\n"
		printf "\nAnswer nano or vi (n|v).  \n\n"
	fi
		printf "\nYou answered \033[36;1m$nv\033[32;1m.\n"
	done	
	printf "\n"
	while true; do
	read -p "Would you like to run \`locale-gen\` to generate the en_US.UTF-8 locale or do you want to edit /etc/locale.gen specifying your preferred language before running \`locale-gen\`?  Answer run or edit [r|e].  " ye
	if [[ $ye = [Rr]* ]];then
		break
	elif [[ $ye = [Ee]* ]];then
		$ed $HOME/arch/etc/locale.gen
		break
	else
		printf "\nYou answered \033[36;1m$ye\033[32;1m.\n"
		printf "\nAnswer run or edit (Rr|Ee).  \n\n"
	fi
	done
	$ed $HOME/arch/etc/pacman.d/mirrorlist
	makefinishsetup
	makesetupbin 
}

