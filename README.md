# ps
ps = ping sweep

just some note will add here
# 
```bash
for i in {1..255} ;do (ping -c 1 172.16.1.$i | grep "bytes from"|cut -d ' ' -f4|tr -d ':' &);done
```
