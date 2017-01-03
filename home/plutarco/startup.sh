rm /home/plutarco/test.txt
echo "Init at : " $(date) >> /home/plutarco/test.txt
x=0
while ! ifconfig | grep -qF "192.168." ; do
    echo $(date) " no nework"  >> /home/plutarco/test.txt
    if [ "$x" -gt 200]; then
        #Time out here
	echo " . "  >> /home/plutarco/test.txt
        exit 1
    x=$((x+1))
    sleep 1
    fi
done

echo "##########################################################" >> /home/plutarco/test.txt
sleep 3
echo "Start uPnp command at "$(date) >> /home/plutarco/test.txt
/usr/bin/upnpc -r 22 tcp >> /home/plutarco/test.txt

echo "##########################################################" >> /home/plutarco/test.txt
sleep 3
echo "Start noip command at "$(date) >> /home/plutarco/test.txt
/usr/local/bin/noip2  >> /home/plutarco/test.txt

echo "##########################################################" >> /home/plutarco/test.txt
sleep 3
echo "Script ended at " $(date) >> /home/plutarco/test.txt
