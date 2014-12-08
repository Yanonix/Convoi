#!/bin/bash

#Creation Dossier application Convoi(BAS)
bin/newapp.sh -v -i=BAS -o=CON
#Renaming
bin/replacestr.sh -v -i=bas -o=con -s CON/CON/rc-con.tk CON/CON/con.tk CON/CON/con-???.tk
bin/replacestr.sh -v -i=BAS -o=CON -s CON/CON/rc-con.tk CON/CON/con.tk CON/CON/con-???.tk
cd CON
make install
cd ..

#Création dossier application routage (NET)
bin/newapp.sh -v -i=NET -o=RTE
#renaming
bin/replacestr.sh -v -i=net -o=rte -s RTE/RTE/rc-rte.tk RTE/RTE/rte.tk RTE/RTE/rte-???.tk
bin/replacestr.sh -v -i=NET -o=RTE -s RTE/RTE/rc-rte.tk RTE/RTE/rte.tk RTE/RTE/rte-???.tk
cd RTE
make install
cd ..


#Création dossier application Physique ( Net )
bin/newapp.sh -v -i=NET -o=PHY
#renaming
bin/replacestr.sh -v -i=net -o=phy -s PHY/PHY/rc-phy.tk PHY/PHY/phy.tk PHY/PHY/phy-???.tk
bin/replacestr.sh -v -i=NET -o=PHY -s PHY/PHY/rc-phy.tk PHY/PHY/phy.tk PHY/PHY/phy-???.tk
cd PHY
make install
cd ..


