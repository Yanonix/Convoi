#!/bin/bash

#Creation Dossier application Convoi(BAS)
bin/newapp.sh -v -i=BAS -o=CON
#Renaming
bin/replacestr.sh -v -i=bas -o=con -s CON/CON/rc-con.tk CON/CON/con.tk CON/CON/con-???.tk

#Création dossier application routage (NET)
bin/newapp.sh -v -i=NET -o=RTE
#renaming
bin/replacestr.sh -v -i=net -o=rte -s RTE/RTE/rc-rte.tk RTE/RTE/rte.tk RTE/RTE/rte-???.tk

#Création dossier application Physique ( Net )
bin/newapp.sh -v -i=NET -o=PHY
#renaming
bin/replacestr.sh -v -i=net -o=phy -s PHY/PHY/rc-phy.tk PHY/PHY/phy.tk PHY/PHY/phy-???.tk

