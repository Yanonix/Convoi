#!/bin/bash

# Nombre de véhicules
NB=`echo {1..3}`

# Création des listes fifo
for i in $NB
do
	echo "Véhicule $i"
	rm -f "/tmp/in$i" "/tmp/out$i"
	mkfifo "/tmp/in$i" "/tmp/out$i"
done

for i in $NB
do
	# Lancement de l'application
	./wha.tk --auto --ident=car$i < /tmp/in$i > /tmp/out$i &

	# Création des liens de communications
	str=""
	for j in $NB
	do
		if [ $i != $j ]; then
			echo "Lien $i vers $j"
			str="/tmp/in${j} ${str}"
		fi
	done

	cat /tmp/out$i | tee $str &

done