%programa para abrir o csv que o python gerou e obter os vetores uteis para
%calculo
%abrir a tabela do csv
CSV=readtable('C:\Users\SAMSUNG\Documents\MedidaTCC90graus.csv','NumHeaderLines',1)
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

%a partir daqui começa o processamento numérico
% aqui vai ser para fazer a mudança de base do mediapipe para a base
Quantidade_dados = length(PunhoX)
PunhoBA = vertcat(PunhoX',PunhoY');
PunhoBA=vertcat(PunhoBA,PunhoZ')
CotBA=vertcat(CotX',CotY');
CotBA=vertcat(CotBA,CotZ')
OmbroBA=vertcat(OmbroX',OmbroY');
OmbroBA=vertcat(OmbroBA,OmbroZ')
PunhoBN=[]
CotBN=[]
OmbroBN=[]
% matrizMB deois ir atualizando a coluna no for
for n = 1:Quantidade_dados
    difX=PunhoBA(1,n)-CotBA(1,n)
    difY=PunhoBA(2,n)-CotBA(2,n)
    MMB=[difX difY 0;difY difX 0;0 0 1]
    PunhoBN=horzcat(PunhoBN,MMB*PunhoBA(:,n))
    CotBN = horzcat(CotBN,MMB*CotBA(:,n))
    OmbroBN=horzcat(OmbroBN,MMB*OmbroBA(:,n))
end
%com os pontos na base nova, coloca-los como colunas individuais novamente
PunhoBNX=PunhoBN(1,:)
PunhoBNY=PunhoBN(2,:)
PunhoBNZ=PunhoBN(3,:)
CotBNX=CotBN(1,:)
CotBNY=CotBN(2,:)
CotBNZ=CotBN(3,:)
OmbroBNX=OmbroBN(1,:)
OmbroBNY=OmbroBN(2,:)
OmbroBNZ=OmbroBN(3,:)
%agora transpor esses vetores linha para colunas
PunhoBNX=PunhoBNX'
PunhoBNY=PunhoBNY'
PunhoBNZ=PunhoBNZ'
CotBNX=CotBNX'
CotBNY=CotBNY'
CotBNZ=CotBNZ'
OmbroBNX=OmbroBNX'
OmbroBNY=OmbroBNY'
OmbroBNZ=OmbroBNZ'
% a parte abaixo foi confirmada em testes dia 06/08/2022
NUM = (OmbroBNX-CotBNX).*(PunhoBNX-CotBNX)+(OmbroBNY-CotBNY).*(PunhoBNY-CotBNY)+(OmbroBNZ-CotBNZ).*(PunhoBNZ-CotBNZ);
%NUM=sqrt(NUM.^2)

RaizD1=(OmbroBNX-CotBNX).^2+(OmbroBNY-CotBNY).^2+(OmbroBNZ-CotBNZ).^2;
RaizD2=(PunhoBNX-CotBNX).^2+(PunhoBNY-CotBNY).^2+(PunhoBNZ-CotBNZ).^2;
ThetaRad=NUM./(sqrt(RaizD1).*sqrt(RaizD2));
ThetaRad=acos(ThetaRad)
%esse debaixo vai dar o menor angulo entre as retas em graus
ThetaGraus=(ThetaRad.*360)./(2*pi)