%Validaçao do processo numerico do TCC
%Validação da parte matemática do TCC
%abrir a tabela do csv
CSV=readtable('C:\Users\SAMSUNG\Documents\MedidasAutocadParaMatlab.csv','NumHeaderLines',1)
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
    difX=CotBA(1,n)-OmbroBA(1,n)
    difY=CotBA(2,n)-OmbroBA(2,n)
    S1=inv([difX, difY;difY, difX])*[1;0]
    S2=inv([difY, difX;difX, difY])* [0;1]   
    
    
    MMB=[S1(1) S2(1) 0;S1(2) S2(2) 0;0 0 1]
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
OmbroBNX=OmbroBN(1,:);
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
NUM = (OmbroX-CotX).*(PunhoX-CotX)+(OmbroY-CotY).*(PunhoY-CotY)+(OmbroZ-CotZ).*(PunhoZ-CotZ);
%NUM=sqrt(NUM.^2)

RaizD1=(OmbroX-CotX).^2+(OmbroY-CotY).^2+(OmbroZ-CotZ).^2;
RaizD2=(PunhoX-CotX).^2+(PunhoY-CotY).^2+(PunhoZ-CotZ).^2;
ThetaRad=NUM./(sqrt(RaizD1).*sqrt(RaizD2));
ThetaRad=acos(ThetaRad)
%esse debaixo vai dar o menor angulo entre as retas em graus
ThetaGraus=(ThetaRad.*360)./(2*pi)