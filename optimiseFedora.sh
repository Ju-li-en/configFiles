#!/bin/bash

while true
    do
    echo -e "Que souhaitez-vous faire\n 
                1) Analyser le temps de réponse \n 
                2) Analyser les processus les plus longs à charger \n 
                3) Analyser les goulets d'étranglement\n 
                4) Analyser les processus actifs\n 
                5) Analyser la taille des journaux\n 
                6) Réduire la taille des journaux à 2 jours\n 
                7) Reconstruit un Initramfs Image\n 
                8) Reconstruit un grub avec les derniers kernels\n 
                q) Quitter\n "
    read reponse
    
    case $reponse in 
        1)echo -e "\nsystemd-analyze time\n"
          systemd-analyze;;
      2)echo -e "\nLes processus les plus longs\n"
          systemd-analyze blame;;
      3)echo -e "\nLes goulets d'étranglement\n"
          systemd-analyze critical-chain;;
      4)echo -e "\nProcessus chargés au démarrage\n"
          systemctl list-units --type service;;
      5)echo -e "\ntaille des journaux\n"
          journalctl --disk-usage;;
      6)echo -e "\nRéduire la taille des journaux\n"
          journalctl --vacuum-time=2d;;
      7)echo -e "\n Reconstruit Initramfs\n"
          dracut -f -v;;
      8)echo -e "\n Reconstruit GRUB\n"
          grub2-mkconfig -o /boot/grub2/grub.cfg;;
    q)echo "Quitter"
          exit;;
    *)echo "Réponse non comprise"
    esac
done
