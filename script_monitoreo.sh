
clear

unset tecreset os architecture kernelrelease internalip externalip nameserver loadaverage nconect routes

if [[ $# -eq 0 ]]
then
{

tecreset=$(tput sgr0)
ping -c 1 google.com &> /dev/null && echo -e '\E[34m'"Internet: $tecreset Conectado" || echo -e '\E[34m'"Internet: $tecreset Desconectado"

os=$(uname -o)
echo -e '\E[34m'"Sistema Operativo :" $tecreset $os

cat /etc/os-release | grep 'NAME\|VERSION' | grep -v 'VERSION_ID' | grep -v 'PRETTY_NAME' > /tmp/osrelease
echo -n -e '\E[34m'"Distribucion :" $tecreset  && cat /tmp/osrelease | grep -v "VERSION" | cut -f2 -d\"
echo -n -e '\E[34m'"Version :" $tecreset && cat /tmp/osrelease | grep -v "NAME" | cut -f2 -d\"

architecture=$(uname -m)
echo -e '\E[34m'"Arquitectura :" $tecreset $architecture

kernelrelease=$(uname -r)
echo -e '\E[34m'"Version del Kernel:" $tecreset $kernelrelease

echo -e '\E[34m'"Nombre de Equipo :" $tecreset $HOSTNAME

internalip=$(hostname -I)
echo -e '\E[34m'"IP Interna :" $tecreset $internalip

externalip=$(curl -s ipecho.net/plain;echo)
echo -e '\E[34m'"IP Publica : $tecreset "$externalip

nameservers=$(cat /etc/resolv.conf | sed '1 d' | awk '{print $2}')
echo -e '\E[34m'"Servidor DNS :" $tecreset $nameservers 

who>/tmp/who
echo -e '\E[34m'"Usuarios Activos :" $tecreset && cat /tmp/who 

free -h | grep -v + > /tmp/ramcache
echo -e '\E[34m'"Uso de RAM :" $tecreset
cat /tmp/ramcache | grep -v "Swap"
echo -e '\E[34m'"Uso de SWAP :" $tecreset
cat /tmp/ramcache | grep -v "Mem"

df -h| grep 'Filesystem\|/dev/sda*' > /tmp/diskusage
echo -e '\E[34m'"Utilizacion de Disco:" $tecreset 
cat /tmp/diskusage

loadaverage=$(top -n 1 -b | grep "load average:" | awk '{print $10 $11 $12}')
echo -e '\E[34m'"Uso de CPU :" $tecreset $loadaverage

tecuptime=$(uptime | awk '{print $3,$4}' | cut -f1 -d,)
echo -e '\E[34m'"Tiempo Activo Dias/(HH:MM) :" $tecreset $tecuptime

netstat -atun | grep -v Active > /tmp/con1
echo -e '\E[34m'"Conexiones de Red Activa:" $tecreset 
cat /tmp/con1

ss -s > /tmp/con1 
echo -e '\E[34m'"Resumen de Conexiones:" $tecreset
cat /tmp/con1 

route > /tmp/con1
echo -e '\E[34m'"Tabla de Ruteo:" $tecreset 
cat /tmp/con1
 
unset tecreset os architecture kernelrelease internalip externalip nameserver loadaverage

rm /tmp/osrelease /tmp/who /tmp/ramcache /tmp/diskusage /tmp/con1
}
fi
shift $(($OPTIND -1))




