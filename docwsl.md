-------------------------------------------------------------

com o wsl já setado:

abrir powershell
1. wsl (abre a máquina virtual Ubunto dentro do PowerShell, o comando wsl abre automaticamente o wsl ubunto 22.04 pois o mesmo foi setado para isso.

2. os comandos a seguir tem atalhos (como indicado)
cw = 'cd ~/ros2_ws' (abre a workspace do ros2 dentro da máquina)
cs = 'cd ~/ros2_ws/src' (abre a pasta src dentro da workspace, que é onde tem todos os nodes do ros2 que o pessoal já upou)
cb = 'cd ~/ros2_ws && colcon build'(ele compila os pacotes c++ dentro do src)

-------------------------------------------------------------

na home (/home/voris/ = ~) setar arquivo .bashrc (variáveis de ambiente)

adicionar:

	# ROS2 variables
	export ROS_DOMAIN_ID=1
	export ROS_LOCALHOST_ONLY=0
	source /opt/ros/humble/setup.bash
	source ~/ros2_ws/install/setup.bash

	alias cw='cd ~/ros2_ws'
	alias cs='cd ~/ros2_ws/src'
	alias cb='cd ~/ros2_ws && colcon build'


-------------------------------------------------------------

rqt_gaph - interface de visualização para comunicação entre nós e tópicos

ros2 launch voris_bringup rosbag_ue_system.launch.py (abre os nós para processar Camera info, SLAM, Mapa de Disparidade, URDF)
ros2 run voris_log point_cloud_csv.py (le tópico de nuvem de pontos (PointCloud2) e salva em arquivo .csv em um determinado folder)
ros2 run ros2_unreal_bridge pose_unreal_bridge (faz ponte websocket do tópico de Pose (SLAM) para o json/odometria UE)

Para abrir BAG:
	- cd /mnt/c/Users/Voris/Downloads (caminho onde a bag está localizada)
	- ros2 bag play 08 (roda a bag 08 que está localizada no respectivo caminho)




