%programa para abrir o csv que o python gerou e obter os vetores uteis para
%calculo
%abrir a tabela do csv
CSV=readtable('C:\Users\SAMSUNG\Documents\MedidaTCC135graus.csv','NumHeaderLines',1)
%Mudar o nome do arquivo sempre que necessário

%tornar a tabela vetores uteis
OmbroX=table2array(CSV(:,1))
OmbroY=table2array(CSV(:,2))
OmbroZ=table2array(CSV(:,3))

CotX=table2array(CSV(:,4))
CotY=table2array(CSV(:,5))
CotZ=table2array(CSV(:,6))

PunhoX=table2array(CSV(:,7))
PunhoY=table2array(CSV(:,8))
PunhoZ=table2array(CSV(:,9))

PunhoX=PunhoX*640
PunhoY=PunhoY*480
CotX=CotX*640
CotY=CotY*480
OmbroX=OmbroX*640
OmbroY=OmbroY*480
%a partir daqui começa o processamento numérico
%usando o pensamento do dia 02/09 que basta subtrair a coordenada y de 1
%oara que a xoordenada agora esteja em base canonica
aux=ones(length(OmbroX),1)
disp('coordenadas mediapipe')
PunhoY
CotY
OmbroY
disp('coordenadas cirrigidas?')
PunhoY=aux-PunhoY
CotY=aux-CotY
OmbroY=aux-OmbroY
% a parte abaixo foi confirmada em testes dia 06/08/2022
NUM = (OmbroX-CotX).*(PunhoX-CotX)+(OmbroY-CotY).*(PunhoY-CotY)+(OmbroZ-CotZ).*(PunhoZ-CotZ);
%NUM=sqrt(NUM.^2)

RaizD1=(OmbroX-CotX).^2+(OmbroY-CotY).^2+(OmbroZ-CotZ).^2;
RaizD2=(PunhoX-CotX).^2+(PunhoY-CotY).^2+(PunhoZ-CotZ).^2;
ThetaRad=NUM./(sqrt(RaizD1).*sqrt(RaizD2));
ThetaRad=acos(ThetaRad)
%esse debaixo vai dar o menor angulo entre as retas em graus
ThetaGraus=(ThetaRad.*360)./(2*pi)