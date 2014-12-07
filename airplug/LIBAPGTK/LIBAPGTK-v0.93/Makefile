# license type: free of charge license for academic and research purpose
# see license.txt
# author: Bertrand Ducourthial
# revision: 23/03/2012

# Makefile of the Airplug Software Distribution.
# Layer 3 Makefile for TclTk applications in the skeleton distribution.
# Generic makefile: no adaptation for a given application.

# NB: adding a new module or a new file to the application does not require
#     to adapt the Makefile providing the file has been named according to
#     the rule: nameoftheapplication-nameofthemodule.tk
#     In the converse, the TGZ_PUB and TGZ_DEV should be adapted and the
#     Makefile is no more generic (this should be precised line 6).

# To avoid any problem from the inheritage of SHELL variable from the
# environment
SHELL = /bin/bash

# Language (if the LANGUAGE env variable contains fr, then french, else english)
TEXT = $(shell if [ x`env | grep LANGUAGE | grep fr` = x ] ; then echo "english" ; else echo "french" ; fi )

# Name of the application (= name of the directory in lower cases)
# NB: taking the name of the parent directory to avoid including version number.
OUTPUT = $(shell pwd | rev | cut -d'/' -f 2 | rev | tr '[:upper:]' '[:lower:]')

# Current directory (without version suffix)
# NB: inherited from parent Makefile (see -e make option in ../Makefile)
DIR = $(shell pwd | rev | cut -d'/' -f 2 | rev)

# Real current directory name (for display purpose)
DIRNAME = $(shell pwd | rev | cut -d'/' -f 1 | rev)

# Install directory of the whole distribution
export DIR_INSTALL = ../..

# SOURCES stands for all sources files belonging to the application
# whenever the naming rules are fulfilled
#  RC is either empty or equal to rc-$(OUTPUT).tk if it exists
RC = $(shell if [ -e rc-$(OUTPUT).tk ] ; then echo rc-$(OUTPUT).tk ; else echo "" ; fi )
#  LIB designates all required sub-libraries
LIB = $(shell find  libapg-???.tk -type f )
SOURCES = libapg.tk $(LIB) $(RC)

# List of all files for the public archive
TGZ_PUB = Makefile license.txt README.pub tgz-history.txt \
	$(SOURCES)

# List of all files for the devel archive
TGZ_DEV = $(TGZ_PUB) \
	README.dev	

# List of all files for the distribution skeleton archive
TGZ_SKL = $(TGZ_PUB)

MAKE = make

# make options:
# -s : silent
# -e : variables which are exported here predominates those initialized in sub-makefiles
MFLAGS = -s -e

# tgif program for generating icons
TGIF = tgif

# To avoid any problem in case a file has the name of a rule
.PHONY: build clean depend icon files-tgz-dev files-tgz-skl files-tgz-pub \
	help icon incr install list mod-version new-version print-tgz-dev reset \
	show-version tgz-pub tgz-dev tgz-skl

# First rule = default rule (help)
help:
	@if [ $(TEXT) = "french" ]; then \
		echo "  ++ $(DIR) : aide pour le Makefile de la Suite logicielle Airplug" ; \
		echo "     make build        : compilation" ; \
		echo "     make clean        : suppression des fichiers temporaires" ; \
		echo "     make depend       : calcul des dependances (avant compilation)" ; \
		echo "     make help         : affiche cette aide"; \
		echo "     make icon         : creation de l'icone de l'application" ; \
		echo "     make incr         : similaire a make new-version" ; \
		echo "     make install      : installation du programme (apres compilation)" ; \
		echo "     make list         : liste des fichiers" ; \
		echo "     make mod-version  : modifie la version courante de l'application" ; \
		echo "     make new-version  : cree une nouvelle version de l'application" ; \
		echo "     make reset        : clean + suppression des executables compiles" ; \
		echo "     make show-version : affichage de la version, du type de license et des auteurs" ; \
		echo "     make tgz-pub      : archivage des sources pour distribution publique" ; \
		echo "     make tgz-dev      : archivage des sources pour distribution de developpement" ; \
		echo "     make tgz-skl      : archivage des sources pour embryon de distribution" ; \
	else \
		echo "  ++ $(DIR) : help for Makefile of the Airplug Software Distribution" ; \
		echo "     make build        : compilation" ; \
		echo "     make clean        : delete temporary files" ; \
		echo "     make depend       : compute the dependencies (before compilation)" ; \
		echo "     make help         : display this help"; \
		echo "     make icon         : create the application icon" ; \
		echo "     make incr         : same as make new-version" ; \
		echo "     make install      : install the program (after compilation)" ; \
		echo "     make list         : list the files" ; \
		echo "     make mod-version  : modify the current version of the application" ; \
		echo "     make new-version  : create a new version of the application" ; \
		echo "     make reset        : clean + delete the compiled executables" ; \
		echo "     make show-version : display the version, the license type and the authors" ; \
		echo "     make tgz-pub      : archive sources for the public distribution" ; \
		echo "     make tgz-dev      : archive sources for the devel distribution" ; \
		echo "     make tgz-skl      : archive sources for the skeleton distribution" ; \
	fi ;


# NB: - No compilation for this TclTk makefile so build and depend rules have
#       no effect here.
#     - Version management has no effect in layer 3 Makefile.
#     - tgz-pub, tgz-dev and tgz-skl should be used on the parent directory.
#     - This directory will not be used for generating a new application so
#       print-tgz-dev is not useful.
#     - No installation for this directory
build depend icon incr instal install mod-version new-version print-tgz-dev show-version tgz-pub tgz-dev tgz-skl:
	@if [ $(TEXT) = "french" ]; then \
		echo "  ++ $(DIRNAME) : regle $@ => sans effet ici" ; \
	else \
		echo "  ++ $(DIRNAME) : $@ rule => no effect here" ; \
	fi ;

# NB: no executable, so clean=reset
clean reset:
	@if [ $(TEXT) = "french" ]; then \
		echo "  ++ $(DIRNAME) : regle $@" ; \
		echo "     suppression des *~ *bak *tgz files-tgz-*.txt" ; \
	else \
		echo "  ++ $(DIRNAME) : $@ rule" ; \
		echo "     deleting *~ *bak *tgz files-tgz-*.txt" ; \
	fi ; \
	rm -f *~ *bak *tgz files-tgz-*.txt ;

list:
	@if [ $(TEXT) = "french" ]; then \
		echo "  ++ $(DIRNAME) : regle $@" ; \
	else \
		echo "  ++ $(DIRNAME) : $@ rule" ; \
	fi ; \
	echo "     Sources : $(SOURCES)" ; \
	for F in $(SOURCES) ; do \
		if ! [ -e $$F ]; then \
			if [ $(TEXT) = "french" ]; then \
				echo "! $(DIRNAME) : $$F manquant" ; \
			else \
				echo "! $(DIRNAME) : $$F not found" ; \
			fi ; \
		fi; \
	done ;


files-tgz-dev:
	@if [ $(TEXT) = "french" ]; then \
		echo "  ++ $(DIRNAME) : regle $@" ; \
	else \
		echo "  ++ $(DIRNAME) : $@ rule" ; \
	fi ; \
	if [ -e ./files-tgz-dev.txt ] ; then \
		rm ./files-tgz-dev.txt ; \
	fi ; \
	for F in $(TGZ_DEV) ; do \
		if [ -e $$F ]; then \
			echo $$F >> ./files-tgz-dev.txt ; \
		else \
			if [ $(TEXT) = "french" ]; then \
				echo "!    $(DIRNAME) : $$F manquant" ; \
			else \
				echo "!    $(DIRNAME) : $$F not found" ; \
			fi ; \
		fi ; \
	done ;

files-tgz-pub:
	@if [ $(TEXT) = "french" ]; then \
		echo "  ++ $(DIRNAME) : regle $@" ; \
	else \
		echo "  ++ $(DIRNAME) : $@ rule" ; \
	fi ; \
	if [ -e ./files-tgz-pub.txt ] ; then \
		rm ./files-tgz-pub.txt ; \
	fi ; \
	for F in $(TGZ_PUB) ; do \
		if [ -e $$F ]; then \
			echo $$F >> ./files-tgz-pub.txt ; \
		else \
			if [ $(TEXT) = "french" ]; then \
				echo "!    $(DIRNAME) : $$F manquant" ; \
			else \
				echo "!    $(DIRNAME) : $$F not found" ; \
			fi ; \
		fi ; \
	done ;

files-tgz-skl:
	@if [ $(TEXT) = "french" ]; then \
		echo "  ++ $(DIRNAME) : regle $@" ; \
	else \
		echo "  ++ $(DIRNAME) : $@ rule" ; \
	fi ; \
	if [ -e ./files-tgz-skl.txt ] ; then \
		rm ./files-tgz-skl.txt ; \
	fi ; \
	for F in $(TGZ_PUB) ; do \
		if [ -e $$F ]; then \
			echo $$F >> ./files-tgz-skl.txt ; \
		else \
			if [ $(TEXT) = "french" ]; then \
				echo "!    $(DIRNAME) : $$F manquant" ; \
			else \
				echo "!    $(DIRNAME) : $$F not found" ; \
			fi ; \
		fi ; \
	done ;

