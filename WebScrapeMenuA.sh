#!/bin/bash

# Set execute commands for child scripts
chmod a+x ./WebScrapeMenuA.sh
chmod a+x ./WebScraper1A.sh
chmod a+x ./WebScraper2A.sh
chmod a+x ./AISIStats.sh


# colour variables
BOLDRED='\033[1;31m'
BOLDGREEN='\033[1;32m'
YELLOW='\033[0;33m'
LBLUE='\033[1;34m'
NC='\033[0m'


# Clear terminal
clear

# General page text info
echo -e "\t ${BOLDRED}***************************************************************************************${NC} "
echo -e "\t                WELCOME TO MY FINAL ASSIGNMENT WEB SCRAPING SCRIPT MENU "
echo -e "\t ${LBLUE} PLEASE SELECT WHICH WEB SCRAPING SCRIPT YOU WOULD LIKE TO RUN FROM THE FOLLOWING MENU${NC}"
echo -e "\t ${BOLDRED}***************************************************************************************${NC}"

# Provide a command line request text
PS3=$'\n\033[0;33mPlease make your selection > \033[0m'
echo

echo -e "${BOLDGREEN}Type '1' to view the most recent 'WEB THREAT' updates provided by the ACSC"
echo 
echo -e "Type '2' to view the most recent 'WEB CYBER NEWS' updates provided by the ACSC"
echo
echo -e "Type '3' to view the latest AISI Daily Malware Statistics"
echo
echo -e "Type '4' to exit this program${NC}"
echo
echo


# The two scripts and exit are called upon from
select ws in ACSC\ WEB\ THREATS ACSC\ CYBER\ NEWS AISI\ DAILY\ MALWARE\ STATISTICS EXIT; do

    case $ws in

    # The four case values are declared here calling on child script, note the exec 
    # Command used so as to enable exit functions to work correctly by giving the child the 
    # pid, killing previous instances and creating new ones
    ACSC\ WEB\ THREATS )
        exec ./WebScraper1A.sh
        
    ;;

    ACSC\ CYBER\ NEWS )
        exec ./WebScraper2A.sh
        
    ;;

        AISI\ DAILY\ MALWARE\ STATISTICS )
        exec ./AISIStats.sh
        
    ;;

    # The exit option is here
    EXIT )
        echo -e "${LBLUE}Goodbye, have a great day !${NC}"
        exit 1

    ;;

    # invalid data
    *)
        echo "Invalid entry please input a section from 1 to 4."
        echo
    ;;
    
    esac

done

exit 0

