#!/bin/bash

# colour variables
BOLDRED='\033[1;31m'
BOLDGREEN='\033[1;32m'
YELLOW='\033[0;33m'
LBLUE='\033[1;34m'
NC='\033[0m'

curl https://portal.aisi.gov.au/static/data/aisi_malware_totals.csv -o TMGtesta.txt &>/dev/null

# Format the csv file into a colum of data
sed -i 's/,/,\n/g' TMGtesta.txt

# Delete all lines from the first line up to the word Malware to leave malware instances data only
sed '1,/Malware/d' TMGtesta.txt > malwareinfo.txt


# Delete all lines from the word Malware to the end of the file to leave date data alone
sed '/Malware/,$d' TMGtesta.txt > dateinfo.txt
sed -i '/^date/d' dateinfo.txt > dateinfo2.txt

sed -i '$s/.$/\,/;' dateinfo.txt
sed -i '$s/.$/\,/;' malwareinfo.txt

sed -i 's/,$//g' combineddata.txt

paste -d '' dateinfo.txt malwareinfo.txt > combineddata.txt

clear

echo
echo
echo -e "\t ${BOLDGREEN}===============--------------------------===============${NC}"
echo -e "\t    The following table details the latest daily AISI"
echo -e "\t        ${BOLDRED}( Australian Internet Security Initiative )${NC}"
echo -e "\t            Malware Observation Statistics"
echo -e "\t ${BOLDGREEN}===============--------------------------===============${NC}"
echo
echo -e "${YELLOW}The following current 'Malware Incident Statistics' have been extracted by web scraping the Australian Government ACSC website."
echo
echo -e "${YELLOW}The entire webpage information can be gained by visiting https://www.cyber.gov.au/aisi/statistics/malware-statistics. ${NC}"
echo

awk 'BEGIN {
    FS=",";
    print "____________________________________";
    print "| \033[34mDate              \033[0m | \033[34mObservations\033[0m |";
    print "____________________________________";
}
{
    printf("| \033[33m%-18s\033[0m | \033[35m%-12s\033[0m |\n", $1, $2);
}
END {
    print("___________________________");
}' combineddata.txt

# Request the users input on main menu return or exit
    echo
    PS3=$'\e[01;33mPlease make your selection > \e[0m'
    echo
    echo -e "${BOLDGREEN}Would you like to return to the main menu?${NC}"
    
select yn in "Yes" "No"; do

    case $yn in
        Yes ) exec ./WebScrapeMenuA.sh;;
        No ) echo -e "${LBLUE}Have a nice day :-)${NC}" && exit 1
    esac

done