Configuração Inicial do WSL e ROS2
Acesse o ambiente ROS2 abrindo o PowerShell ou Terminal do Windows e digitando wsl.

Para configurar os atalhos e variáveis de ambiente (1ra configuração) edite o arquivo .bashrc no seu diretório home. Digite nano ~/.bashrc e adicione o seguinte conteúdo no final do arquivo:

Variáveis do ROS2
export ROS_DOMAIN_ID=1
export ROS_LOCALHOST_ONLY=0
source /opt/ros/humble/setup.bash
source ~/ros2_ws/install/setup.bash

Alias personalizados 
alias cw='cd ~/ros2_ws'
alias cs='cd ~/ros2_ws/src'
alias cb='cd ~/ros2_ws && colcon build'

Atalhos e Comandos
Use os seguintes atalhos para navegar e gerenciar seu projeto.

cw - Acessa o diretório principal do seu espaço de trabalho do ROS2.
cs - Acessa a pasta src onde estão os pacotes.
cb - Compila todos os pacotes do projeto.
rqt_graph - Abre a interface visual de comunicação entre nós e tópicos.

Execução de Processos
ros2 launch voris_bringup rosbag_ue_system.launch.py - Inicia os nós essenciais para processamento do sistema.
ros2 run voris_log point_cloud_csv.py - Lê dados do tópico de nuvem de pontos e os salva em um arquivo .csv.
ros2 run ros2_unreal_bridge pose_unreal_bridge - Cria uma ponte para enviar dados de pose para a Unreal Engine.

Para reproduzir um arquivo .bag, primeiro navegue até a pasta onde ele está localizado.
cd /mnt/c/Users/Voris/Downloads
ros2 bag play 08

Abrir Visual Studio com os códigos WSL:

cw
code .