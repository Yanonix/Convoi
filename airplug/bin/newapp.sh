#!/bin/bash

# This shell script is part of the Airplug Software Distribution.

# license type: free of charge license for academic and research purpose
# see license.txt
# author: Bertrand Ducourthial
# revision : 16/03/2012

# Aim: this shell script allows to easily create a new application
#      starting from a given existing application taken as an example.
#  
#  Usage: newapp.sh -v -i=exampleapp -o=newapp


#set -u
#set -o nounset
#set -e

VERSION=0.2
INPUT=""
OUTPUT=""
# Default verbose level (0 can be obtained by -q)
VERBOSE=1
EXE=`basename $0`
COMMAND_LINE="$0 $*"

# Decoding command line options ----------------------------------------------#
while [ x"$1" != x ]; do
		case "$1" in
				-q)
						VERBOSE=0
						;;

				-v)
						VERBOSE=`echo 1 + $VERBOSE | bc`
						;;

				-vv)
						VERBOSE=`echo 2 + $VERBOSE | bc`
						;;

				-vvv)
						VERBOSE=`echo 3 + $VERBOSE | bc`
						;;
	
				-i=*)
						INPUT=`echo $1 | sed s/-i=//`
						;;

				-o=*)
						OUTPUT=`echo $1 | sed s/-o=//`
						;;
				
				-h|--help)
						echo "+ $EXE: help:"
						echo "    Create a new Airplug application of name newapp starting from Application app."
						echo "    Usage: in the Airplug distribution directory, bin/$EXE -i=app -o=newapp -vv"
						echo "    -v: verbose mode (up to three verbose levels, default level=1)"
						echo "    -q: quiet mode (no output displayed)"
						echo "    --version : version number"
						echo "    -i: input string"
						echo "    -o: output string"
						echo "    -h or --help: this help"
						exit
						;;
				
				--version)
						echo "+ $EXE: version $VERSION"
						exit
						;;
				*)
						echo "- $EXE: unknown option $1. Try $EXE --help" ;
						exit 1
						;;
    esac
    shift
done

# Welcome message ------------------------------------------------------------#
if [ $VERBOSE -ge 1 ] ; then
		echo "+ $EXE: Creating a new application in the Airplug Software Distribution"
fi

# Checking the input application ---------------------------------------------#
if [ $VERBOSE -ge 1 ]; then echo -n "+ $EXE:   checking the input application"; fi;
if [ $VERBOSE -ge 2 ]; then echo ""; fi;

# Checking the presence of -i option
if [ "$INPUT" = "" ] ; then
		echo "";
		echo "- $EXE: missing input application. Try $EXE --help" ;
		exit 1
else
		if [ $VERBOSE -ge 2 ] ; then
				echo "+ $EXE:     input application: $INPUT"
		fi
fi

# Checking for the existence of INPUT directory
if [ -e $INPUT ]; then
		if [ $VERBOSE -ge 2 ]; then echo "+ $EXE:     $INPUT found"; fi;
else
		echo "- $EXE: $INPUT not found. Try $EXE --help" ;
		exit 1
fi

# Checking for the existence of INPUT/INPUT
# This indicates that we are in the good place in the Airplug directories.
if [ -e $INPUT/$INPUT ]; then
		if [ $VERBOSE -ge 2 ]; then echo "+ $EXE:     $INPUT/$INPUT found"; fi;
else
		echo "- $EXE: $INPUT/$INPUT not found" ;
		echo "  $EXE: try $EXE --help" ;
		exit 1
fi

if [ $VERBOSE -eq 1 ]; then echo -n "... done"; echo ; fi;
#-----------------------------------------------------------------------------#

# Checking the output application ---------------------------------------------#
if [ $VERBOSE -ge 1 ]; then echo -n "+ $EXE:   checking the output application"; fi;
if [ $VERBOSE -ge 2 ]; then echo ""; fi;

# Checking the presence of -o option
if [ "$OUTPUT" = "" ] ; then
		echo "- $EXE: missing output application. Try $EXE --help" ;
		exit 1
else
		if [ $VERBOSE -ge 2 ] ; then
				echo "+ $EXE:     output application: $OUTPUT"
		fi
fi

# Checking for the non existence of OUTPUT directory
if ! [ -e $OUTPUT ]; then
		if [ $VERBOSE -ge 2 ]; then echo "+ $EXE:     no $OUTPUT found, ok"; fi;
else
		echo "- $EXE: $OUTPUT already exists in your Airplug distribution" ;
		echo "  $EXE: try $EXE --help" ;
		exit 1
fi

if [ $VERBOSE -eq 1 ]; then echo -n "... done"; echo ; fi;
#-----------------------------------------------------------------------------#


# Creating the OUTPUT directories --------------------------------------------#
if [ $VERBOSE -ge 1 ]; then echo -n "+ $EXE:   creating $OUTPUT directories"; fi;
if [ $VERBOSE -ge 2 ]; then echo ""; fi;

mkdir $OUTPUT
if [ "$?" -ne 0 ]; then
		echo "- $EXE: failed when creating $OUTPUT directory"
		exit 1
else
		if [ $VERBOSE -ge 2 ]; then echo "+ $EXE:     $OUTPUT directory created"; fi;
fi

mkdir $OUTPUT/$OUTPUT-v0.1
if [ "$?" -ne 0 ]; then
		echo "- $EXE: failed when creating $OUTPUT directory"
		exit 1
else
		if [ $VERBOSE -ge 2 ]; then echo "+ $EXE:     $OUTPUT/$OUTPUT-v0.1 directory created"; fi;
fi

ln -s $OUTPUT-v0.1 -T $OUTPUT/$OUTPUT
if [ "$?" -ne 0 ]; then
		echo "- $EXE: failed when creating $OUTPUT/$OUTPUT link"
		exit 1
else
		if [ $VERBOSE -ge 2 ]; then echo "+ $EXE:     $OUTPUT/$OUTPUT link created"; fi;
fi

if [ $VERBOSE -eq 1 ]; then echo -n "... done"; echo ; fi;
#------------------------------------------------------------------------------#

# Copying files into OUTPUT directory ----------------------------------------#
if [ $VERBOSE -ge 1 ]; then echo -n "+ $EXE:   copying files into $OUTPUT directory"; fi;
if [ $VERBOSE -ge 2 ]; then echo ""; fi;

INPUT_FILES=`cd $INPUT ; make print-tgz-dev`
if [ "$?" -ne 0 ]; then
		echo "- $EXE: failed when executing make print-tgz-dev in $INPUT"
		echo "- $EXE: please upgrade to the last distribution in order to have up-to-date Makefiles" 
		exit 1
else
		if [ $VERBOSE -ge 2 ]; then echo "+ $EXE:     files to be copied = $INPUT_FILES"; fi;
fi

for F in $INPUT_FILES; do
		if ! [ -e $INPUT/$F ]; then
				echo "* $EXE:     $INPUT/$F not found"
		else
				cp --preserve=all $INPUT/$F $OUTPUT
				if [ "$?" -ne 0 ]; then
						echo "- $EXE: failed when copying file $INPUT/$F into $OUTPUT"
						exit 1
				fi
		fi
done

if [ $VERBOSE -ge 2 ]; then echo "+ $EXE:     done"; fi;
if [ $VERBOSE -eq 1 ]; then echo -n "... done"; echo ; fi;
#------------------------------------------------------------------------------#

# Copying files into OUTPUT/OUTPUT directory ----------------------------------#
if [ $VERBOSE -ge 1 ]; then echo -n "+ $EXE:   copying and renaming files into $OUTPUT/$OUTPUT directory"; fi;
if [ $VERBOSE -ge 2 ]; then echo ""; fi;

INPUT_FILES=`cd $INPUT/$INPUT ; make print-tgz-dev`
if [ "$?" -ne 0 ]; then
		echo "- $EXE: failed when executing make print-tgz-dev in $INPUT/$INPUT"
		echo "- $EXE: please upgrade to the last distribution in order to have up-to-date Makefiles" 
		exit 1
else
		if [ $VERBOSE -ge 2 ]; then echo "+ $EXE:     files to be copied = $INPUT_FILES"; fi;
fi

INPUT_LOWER=`echo $INPUT | tr '[:upper:]' '[:lower:]'`
OUTPUT_LOWER=`echo $OUTPUT | tr '[:upper:]' '[:lower:]'`

for F in $INPUT_FILES; do
		if ! [ -e $INPUT/$INPUT/$F ]; then
				echo "* $EXE:     $INPUT/$INPUT/$F not found"
		else
				# NB: we try to avoid unwanted replacement such license.txt becoming
				#     liceaaa.txt if an application is named nse...
				#     A global replacement of INPUT_LOWER by OUTPUT_LOWER is then
				#     not a good idea.
				#     Strings to be replaced are then searched near . or -
				# INPUT_LOWER.xxx is replaced by OUTPUT_LOWER.xxx
				G=${F/#$INPUT_LOWER./$OUTPUT_LOWER.}
				# INPUT_LOWER-xxx.yyy is replaced by OUTPUT_LOWER-xxx.yyy
				G=${G/#$INPUT_LOWER-/$OUTPUT_LOWER-}
				# xxx-INPUT_LOWER.yyy is replaced by xxx-OUTPUT_LOWER.yyy
				G=${G/-$INPUT_LOWER./-$OUTPUT_LOWER.}

				cp --preserve=all $INPUT/$INPUT/$F $OUTPUT/$OUTPUT/$G
				if [ "$?" -ne 0 ]; then
						echo "- $EXE: failed when copying file $INPUT/$INPUT/$F to $OUTPUT/$OUTPUT/$G"
						exit 1
				else
						if [ $VERBOSE -ge 3 ]; then echo "+ $EXE:     $INPUT/$INPUT/$F --> $OUTPUT/$OUTPUT/$G" ; fi;
				fi
		fi
done

if [ $VERBOSE -ge 2 ]; then echo "+ $EXE:     done"; fi;
if [ $VERBOSE -eq 1 ]; then echo -n "... done"; echo ; fi;
#------------------------------------------------------------------------------#

# Updating OUTPUT/tgz-history.txt ---------------------------------------------#
if [ $VERBOSE -ge 1 ]; then echo -n "+ $EXE:   updating $OUTPUT/tgz-history.txt"; fi;
if [ $VERBOSE -ge 2 ]; then echo ""; fi;

HIST="$COMMAND_LINE on `hostname`, `date +%A" "%d" "%B" "%Y" at "%k"h"%M":"%S`"

echo $HIST >> $OUTPUT/tgz-history.txt

if [ "$?" -ne 0 ]; then
		echo "- $EXE: failed when updating $OUTPUT/tgz-history.txt"
		exit 1
else
		if [ $VERBOSE -ge 2 ]; then echo "+ $EXE:     $OUTPUT/tgz-history.txt updated with \"$HIST\"" ; fi;
fi

if [ $VERBOSE -ge 2 ]; then echo "+ $EXE:     done"; fi;
if [ $VERBOSE -eq 1 ]; then echo -n "... done"; echo ; fi;
#------------------------------------------------------------------------------#

if [ $VERBOSE -ge 1 ]; then
		echo "+ $EXE: New application $OUTPUT created from application $INPUT"
		echo "+ $EXE: You may want to replace $INPUT_LOWER strings by $OUTPUT_LOWER strings in $OUTPUT/$OUTPUT files."
		echo "+ $EXE:   This can be done using the bin/replacestr.sh shell script"
		echo "+ $EXE:   Note however that abusive string replacements may appear with such systematic string processing."
		echo "+ $EXE: You may want to create the $OUTPUT icon"
		echo "+ $EXE:   This can be done by using make icon in $OUTPUT directory"
		echo "+ $EXE: You may want to install the $OUTPUT application"
		echo "+ $EXE:   This can be done by using make install in $OUTPUT directory"
fi


