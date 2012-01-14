#!/bin/bash

echo "<html>"
echo "<head>"
echo "<title>Perl 6 and Parrot links statistics</title>"
echo "</head>"
echo "<body>"

echo "<br />"
echo "<a href=\"http://perl6.cz/wiki/Perl_6_and_Parrot_links\">Perl 6 and Parrot links</a> statistics"

echo "<pre>"

DATE=`date`
echo "Date: $DATE"
echo " "

DIR="/home/jurosz/dalsi/P6aP-links/"

YEARS="2012 2011 2010 2009 2008 2007 2006 2005 2004 2003 2002 2001 2000"
SECTION=2

for YEAR in ${YEARS}; do

	INPUT_FILE="${DIR}links${YEAR}.wiki"
	OUTPUT_FILE="${DIR}links${YEAR}-filtered.wiki"
	DIFF_FILE="${DIR}links${YEAR}-diff.txt"
	YEAR_URL="http://perl6.cz/w/index.php?title=Perl_6_and_Parrot_links&action=raw&section=$SECTION"
	
	if [ "$1" = "1" ]; then
		echo "Downloading $YEAR (section <a href=\"${YEAR_URL}\">$SECTION</a>)"
		wget -q -O $INPUT_FILE "${YEAR_URL}"
		((SECTION = SECTION + 1))
	fi


	perl ${DIR}filter.pl $INPUT_FILE > $OUTPUT_FILE

	diff --text -y $OUTPUT_FILE $INPUT_FILE > $DIFF_FILE

	echo "Year $YEAR:"

	echo -n "  links: "
	cat $OUTPUT_FILE | wc -l

	echo -n "  all lines: " 
	cat $INPUT_FILE | wc -l

	echo " "
done

echo "</pre>"
echo "</body>"

echo "<a href=\"./\">data and scripts</a>"
echo "</html>"
