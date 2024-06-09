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
