@echo off
setlocal EnableDelayedExpansion

set sair=
set /a contador1=0
:menu
cls
date /t & time /t
echo **********************************************
echo  	        Escolha uma opcao:                
echo 	       [1] Configurar DHCP                
echo 	       [2] ADD IPs estaticos              
echo 	       [3] Ver lista de IPs adicionados   
echo 	       [4] Ver IP atual                   
echo  	       [5] Apagar IPs adicionados          
echo.                                             
echo **********************************************
echo.
set /p opcao=

if !opcao! == 1 (
    netsh interface ip set address name="Ethernet" source=dhcp
    echo.
    timeout 2
    goto fim
) else if !opcao! == 2 (
    
    set /p ip=Informe o novo endereco IP: 
    set /p mascara=Informe a mascara de sub-rede: 
    set /p gateway=Informe o endereco do gateway padrao: 
   
    mkdir C:\temp000
    echo !ip! >> C:\temp000\ip0.txt
    echo !mascara! >> C:\temp000\mascara0.txt
    echo !gateway! >> C:\temp000\gateway0.txt
    
    set /p add=Deseja adicionar mais IPs? [S/N]:
    if "!add!" == "s" (
       
       set /a contador=1
       :loop
       set /p ip=Informe o novo endereco IP: 
       set /p mascara=Informe a mascara de sub-rede: 
       set /p gateway=Informe o endereco do gateway padrao: 
       
       echo !ip! >> C:\temp000\ip!contador!.txt
       echo !mascara! >> C:\temp000\mascara!contador!.txt
       echo !gateway! >> C:\temp000\gateway!contador!.txt
       
       set /a contador+=1
       
       set /p add=Deseja adicionar mais IPs? [S/N]:
       if "!add!" == "s" goto loop
   )
    goto fim
    
) else if !opcao! == 3 (
    
    
    :e
    if not !contador1! == 3 (
       set /p ip= < C:\temp000\ip!contador1!.txt
       set /p mascara= < C:\temp000\mascara!contador1!.txt
       set /p gateway= < C:\temp000\gateway!contador1!.txt
       
       echo [!contador1!]
       type C:\temp000\ip!contador1!.txt 
       type C:\temp000\mascara!contador1!.txt
       type C:\temp000\gateway!contador1!.txt
       set /a contador1+=1
       goto e
    )
    set /p selecao= Selecione qual IP deseja utilizar :
    set /p ip1= < C:\temp000\ip!selecao!.txt
    set /p mascara1= < C:\temp000\mascara!selecao!.txt
    set /p gateway1= < C:\temp000\gateway!selecao!.txt

    netsh interface ip set address name="Ethernet" static !ip1! !mascara1! !gateway1! 1     
    set /a contador1=0
    
    goto fim

) else if !opcao! == 4 (
    ipconfig 
    pause
    goto fim
) else if !opcao! == 5 (
    del C:\temp000 /f
)
:fim
if not "!sair!" == "S" goto menu
