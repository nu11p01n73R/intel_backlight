
#!/bin/bash

folder="/sys/class/backlight/intel_backlight"

cd "$folder"

value=3000
max=4882
min=100

if (($EUID != 0))
then
	echo "You do not have required previlages to run the script!!!"
	exit 1
fi

while true
do
	read -n3 -s  key
	echo -n "$key" | grep "\[B" 
	if [ "$?" -eq 0 ]
	then
		if (($value < 100))
		then
			value=100
			continue
		fi
		echo $value
		echo -n $value > brightness  
		value=$[$value-100]
	fi
	echo -n "$key" | grep "\[A"  
	if [ "$?" -eq 0 ]
	then
		if (($value > 4000))
		then
			continue
		fi
		echo $value
		echo -n $value > brightness  
		value=$[$value+100]
	fi
	clear
done
