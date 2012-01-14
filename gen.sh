#!/bin/bash

DIR="$1"
DOWNLOAD="$2"

if [ -z "$DIR" ]; then
	echo 'Usage: gen.sh DATA_DIR DOWNLOAD'
	echo ''
	echo '  DATA_DIR ... path to data directory'
	echo '  DOWNLOAD ... 1 (do download with wget) or 0 (use already downloaded files)'
	echo ''
	echo 'Example:'
	echo '  ./gen.sh data 1'
	echo ''
	exit
fi

if [ ! -d "$DIR" ]; then
	echo "Directory '$DIR' not found."
	exit;
fi

if [ -z "$DOWNLOAD" ]; then
	echo "No download parameter not specified."
	exit;
fi


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

YEARS="2012 2011 2010 2009 2008 2007 2006 2005 2004 2003 2002 2001 2000"
SECTION=2

for YEAR in ${YEARS}; do

	INPUT_FILE="${DIR}/links${YEAR}.wiki"
	OUTPUT_FILE="${DIR}/links${YEAR}-filtered.wiki"
	DIFF_FILE="${DIR}/links${YEAR}-diff.txt"
	YEAR_URL="http://perl6.cz/w/index.php?title=Perl_6_and_Parrot_links&action=raw&section=$SECTION"
	
	if [ "$DOWNLOAD" == "1" ]; then
		echo "Downloading $YEAR (section <a href=\"${YEAR_URL}\">$SECTION</a>)"
		wget -q -O $INPUT_FILE "${YEAR_URL}"
		((SECTION = SECTION + 1))
	fi


	perl filter.pl $INPUT_FILE > $OUTPUT_FILE

	diff --text -y $OUTPUT_FILE $INPUT_FILE > $DIFF_FILE

	echo "Year $YEAR:"

	echo -n "  links: "
	cat $OUTPUT_FILE | wc -l

	echo -n "  all lines: " 
	cat $INPUT_FILE | wc -l

	echo " "
done

echo "</pre>"

echo '<a href="./data">Data</a><br>'
echo '<a href="https://github.com/mj41/Perl-6-GD">Source code on GitHub</a><br>'

echo "</body>"
echo "</html>"
