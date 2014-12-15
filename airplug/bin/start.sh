#!/bin/bash

# Nombre de véhicules
NB=`echo {1..2}`

# Création des listes fifo
for i in $NB
do
	echo "Véhicule $i "

	mkfifo "/tmp/in${i}_con" "/tmp/out${i}_con"
	mkfifo "/tmp/in${i}_rte" "/tmp/out${i}_rte"
	mkfifo "/tmp/in${i}_phy" "/tmp/out${i}_phy"
done

convoi=0
adresse=0

for i in $NB
do

	# Création des liens de communications
	str=""
	for j in $NB
	do
		if [ $i != $j ]; then
			echo "Lien $i vers $j"
			str="/tmp/in${j}_phy ${str}"
		fi
	done

	cat /tmp/out${i}_phy | tee $str /tmp/in${i}_rte &

	cat /tmp/out${i}_con > /tmp/in${i}_rte &
	cat /tmp/out${i}_rte | tee /tmp/in${i}_con /tmp/in${i}_phy &



	# Lancement de l'application
	#./wha.tk --auto --ident=car$i < /tmp/in$i > /tmp/out$i &
	#adresse=`expr ${adresse} + 1`

	# if [ ${adresse} == 4 ]; then
	# 	adresse=1
	# 	convoi=${i}
	# fi
	
	convoi=`expr ${convoi} + 1`
	adresse=1

	y=`expr \`expr ${i} - 1 \` \* 250`
	./con.tk -geometry +0+${y} --whatwho --ident=${i} --adresse=${adresse}:${convoi} --pos=${i}:0  --auto --dest=RTE > /tmp/out${i}_con < /tmp/in${i}_con &
	./rte.tk -geometry +900+${y} --whatwho --ident=${i} --auto --dest=PHY --source=CON > /tmp/out${i}_rte < /tmp/in${i}_rte &
	./phy.tk -geometry +1500+${y} --whatwho --ident=${i} --auto --dest=PHY --source=RTE > /tmp/out${i}_phy < /tmp/in${i}_phy &


done


trap ctrl_c INT

function ctrl_c() {
	echo "Fin du script"
	killall tee cat wish
	for i in $NB
	do
		rm "/tmp/in${i}_con" "/tmp/out${i}_con"
		rm "/tmp/in${i}_rte" "/tmp/out${i}_rte"
		rm "/tmp/in${i}_phy" "/tmp/out${i}_phy"
	done
	exit
}

while :
do
	sleep 2
done