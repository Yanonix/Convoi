#!/bin/bash

# Nombre de véhicules
NB=`echo {1..4}`

# Création des listes fifo
for i in $NB
do
	echo "Véhicule $i "

	mkfifo "/tmp/in${i}_con" "/tmp/out${i}_con"
	mkfifo "/tmp/in${i}_rte" "/tmp/out${i}_rte"
	mkfifo "/tmp/in${i}_phy" "/tmp/out${i}_phy"

done

mkfifo "/tmp/in_sim" "/tmp/out_sim"
	
convoi=0
adresse=0

str2=""

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

	str2="/tmp/in${i}_con ${str2}"

	cat /tmp/out${i}_con | tee /tmp/in${i}_rte /tmp/in_sim & 
	cat /tmp/out${i}_rte | tee /tmp/in${i}_con /tmp/in${i}_phy &
	cat /tmp/out${i}_phy | tee $str /tmp/in${i}_rte &



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
	./con.tk -geometry +0+${y} --whatwho --ident=${i} --adresse=${adresse}:${convoi} --pos=`expr ${i} \* 2`:0  --auto --dest=RTE > /tmp/out${i}_con < /tmp/in${i}_con &
	./rte.tk -geometry +900+${y} --whatwho --ident=${i} --auto --dest=PHY --source=CON > /tmp/out${i}_rte < /tmp/in${i}_rte &
	./phy.tk -geometry +1500+${y} --whatwho --ident=${i} --auto --dest=PHY --source=RTE > /tmp/out${i}_phy < /tmp/in${i}_phy &


done

cat /tmp/out_sim | tee $str2 &

./sim.tk --whatwho --auto > /tmp/out_sim < /tmp/in_sim & 
	

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

	rm "/tmp/in_sim" "/tmp/out_sim"
	
	exit
}

while :
do
	sleep 2
done