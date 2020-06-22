#!/bin/bash

# variables
outputfile1=sao11.txt
outputfile2=sao12.txt
url=https://www.cyber.gov.au/threats

# colour variables
BOLDRED='\033[1;31m'
BOLDGREEN='\033[1;32m'
YELLOW='\033[0;33m'
LBLUE='\033[1;34m'
NC='\033[0m'

# Clear terminal
clear

# Title echo with tab by \t
echo -e "\t ${BOLDGREEN}===============--------------------------===============${NC}"
echo -e "\t    Welcome to the ACSC ${BOLDRED}CYBER THREAT${NC} advisory information"
echo -e "\t ${BOLDGREEN}===============--------------------------===============${NC}"
echo
echo -e "${YELLOW}Thie following current 'Cyber Threat' advisory information has been extracted by web scraping the Australian Government Cyber Threats website."
echo
echo -e "${YELLOW}The entire webpage information can be gained by visiting https://www.cyber.gov.au/threats. ${NC}"
echo

# Call on the requested webpage and output to the nominated file, remove webpage download info
function dump_webpage() {
    curl "$url" -o "$outputfile1" &>/dev/null

}
dump_webpage

# Clean the html document of blank lines, call on muliple lines to be read
function clean_webpage() {
    grep -A 4 -e 'views-field views-field-title' "$outputfile1" | awk 'NF' > "$outputfile2"
    
}
clean_webpage

# A sed variable to handle the " " in the sed search commands
sedv1='hreflang="en">'

# Replace defined strings with new text, removing html tags, line breaks to format in a clean output
sed -i "
s/$sedv1/$sedv1\n==========================================================\n\n/g;
s/<[^>]*>//g;
s/^ -/\n. . . . . . . . . . . . . .\n/g;
s/^--//g;
s/Jan\b/\nJanuary/;s/Feb\b/\nFebruary/;s/Mar\b/\nMarch/;s/\Apr\b/\nApril/;s/May\b/\nMay/;
s/Jun\b/\nJune/;s/Jul\b/\nJuly/;s/Aug\b/\nAugust/;s/Sep\b/\nSeptember/;s/Oct\b/\nOctober/;
s/Nov\b/\nNovember/;s/Dec\b/\nDecember/" "$outputfile2"

# Ensure the webpage has downlloaded correctly
function error_check() {
    [ $? -ne 0 ] && echo "${BOLDRED}There has been an error in loading the webpage.${NC}" && exit 1
    
}
error_check

# Display the cleaned text to the users display
cat "$outputfile2"

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


