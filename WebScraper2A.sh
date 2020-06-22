#!/bin/bash

# Variables
outputfile3=sao23.txt
outputfile4=sao24.txt
url=https://www.cyber.gov.au/news

# colour variables
BOLDRED='\033[1;31m'
BOLDGREEN='\033[1;32m'
YELLOW='\033[0;33m'
LBLUE='\033[1;34m'
NC='\033[0m'

# clear terminal
clear

# Title echo with tab by \t
echo -e "\t ${BOLDGREEN}===============--------------------------===============${NC}"
echo -e "\t   Welcome to the ACSC ${BOLDRED}CYBER NEWS${NC} advisory information"
echo -e "\t ${BOLDGREEN}===============--------------------------===============${NC}"
echo
echo -e "${YELLOW}This following 'Cyber News' information has been extracted by web scraping the Australian Government Cyber Security website.${NC}"
echo
echo -e "${YELLOW}The entire webpage information can be gained by visiting https://www.cyber.gov.au/news. ${NC}"
echo

# Call on the requested webpage and output to the nominated file, remove webpage download info
function dump_webpage() {
    curl "$url" -o "$outputfile3" &>/dev/null

}
dump_webpage

# Clean the html document of tags and blank lines
function clean_webpage() {
    grep -A 4 -e 'views-field views-field-title' "$outputfile3" | sed 's/<[^>]*>//g' | awk 'NF' > "$outputfile4"

}
clean_webpage

# Utilise sed to replace web page characters with new characters, new lines to provide clean test output formatting
sed -i 's/^--/\n==========================================================\n/g' "$outputfile4"
sed -i 's/^ -/\n. . . . . . . . . . . . . .\n/g' "$outputfile4"
sed -i 's/Jan\b/\nJanuary/;s/Feb\b/\nFebruary/;s/Mar\b/\nMarch/;s/\Apr\b/\nApril/;s/May\b/\nMay/;s/Jun\b/\nJune/;s/Jul\b/\nJuly/;s/Aug\b/\nAugust/;s/Sep\b/\nSeptember/;s/Oct\b/\nOctober/;s/Nov\b/\nNovember/;s/Dec\b/\nDecember/'  "$outputfile4"

# Check the original page downloaded correctly
function error_check() {
    [ $? -ne 0 ] && echo "${BOLDRED}There has been an error in loading the webpage.${NC}" && exit 1

}
error_check

# print the cleaned web data in text format to the users screen
cat "$outputfile4"

# Request user input on main menu return or exit
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






