	A integração entre ROS2 e Unreal Engine foi estabelecida via WebSocket, permitindo que a odometria do tópico /SM2/pose atualize a posição de um Pawn na simulação. Para garantir a conectividade com o ambiente ROS2 rodando em WSL2, que possui um IP dinâmâmico, foi implementado um script PowerShell. Este script utiliza netsh portproxy para encaminhar a porta 8080 do host Windows para o guest WSL2, exigindo que o cliente Unreal se conecte a ws://localhost:8080.
	
	Antes de rodar o configurarportawsl.ps1, há de executar o seguinte comando:
	Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser (dentro do PS como administrador)
	Para que o mesmo consiga executar o configurarportawsl.ps1
	Então, acessar a pasta onde o mesmo está localizado e rodar:
	cd C:\Users\Voris\Documents\docunreal\vorisvr1\configurarportawsl.ps1 (o PS já abre nativo sendo a porta SYSTEM32 então há de dar cd ..)

	Então, a porta já estará sendo redirecionada. O mesmo foi feito com o Foxglove então, para visualizar a bag dentro do software, também necessita executar o arquivo.


	Foi identificada e corrigida uma distorção na rotação do Pawn, causada pela incompatibilidade entre o sistema de coordenadas destro do ROS e o canhoto da Unreal Engine. A solução consiste na conversão dos dados recebidos, invertendo o componente Y do vetor de posição e do quaternião de orientação. Essa lógica de transformação foi implementada na função URosBridge::ParseOdometry do código C++.