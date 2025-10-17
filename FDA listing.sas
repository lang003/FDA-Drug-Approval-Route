data FDA;
	set Import;

run;


proc contents data=fda; run;

proc print data=fda(obs=500);
    var Route;
run;

proc freq data=import;
table DF;
*table Route;
run;


data _df_clean0;
  set FDA;
  length DF $200;
  /* collapse repeated consecutive tokens (very simple pass) */
  DF = prxchange('s/\b([A-Z0-9,\/\-\s]+)\s+\1+\b/$1/i', -1, strip(DF));
run;

data want_df;
  set _df_clean0;

  length DF_NORM $200 DF_BASE $40 DF_MOD $120 DF_CANON $120;
  DF_NORM = upcase(compbl(strip(DF)));

  /* index(string, substring) 
  select when is much like if-then statments but with multiple mutually exculsive conditions*/
  select;
    when (index(DF_NORM,'TABLET'))               DF_BASE='TABLET';
    when (index(DF_NORM,'CAPSULE'))              DF_BASE='CAPSULE';
    when (index(DF_NORM,'INJECTABLE'))           DF_BASE='INJECTABLE';
    when (index(DF_NORM,'SOLUTION/DROPS'))       DF_BASE='SOLUTION';
    when (index(DF_NORM,'SUSPENSION/DROPS'))     DF_BASE='SUSPENSION';
    when (index(DF_NORM,'SOLUTION'))             DF_BASE='SOLUTION';
    when (index(DF_NORM,'SUSPENSION'))           DF_BASE='SUSPENSION';
    when (index(DF_NORM,'ELIXIR'))               DF_BASE='ELIXIR';
    when (index(DF_NORM,'SYRUP'))                DF_BASE='SYRUP';
    when (index(DF_NORM,'DROPS'))                DF_BASE='DROPS';         /* if standalone */
    when (index(DF_NORM,'CREAM'))                DF_BASE='CREAM';
    when (index(DF_NORM,'OINTMENT'))             DF_BASE='OINTMENT';
    when (index(DF_NORM,'LOTION'))               DF_BASE='LOTION';
    when (index(DF_NORM,'GEL'))                  DF_BASE='GEL';
    when (index(DF_NORM,'AEROSOL, FOAM'))        DF_BASE='AEROSOL, FOAM';
    when (index(DF_NORM,'AEROSOL'))              DF_BASE='AEROSOL';
    when (index(DF_NORM,'SPRAY'))                DF_BASE='SPRAY';
    when (index(DF_NORM,'POWDER'))               DF_BASE='POWDER';
    when (index(DF_NORM,'GRANULE'))              DF_BASE='GRANULE';
    when (index(DF_NORM,'PELLET'))               DF_BASE='PELLET';
    when (index(DF_NORM,'FILM'))                 DF_BASE='FILM';
    when (index(DF_NORM,'PATCH'))                DF_BASE='PATCH';
    when (index(DF_NORM,'RING'))                 DF_BASE='RING';
    when (index(DF_NORM,'INSERT'))               DF_BASE='INSERT';
    when (index(DF_NORM,'IMPLANT'))              DF_BASE='IMPLANT';
    when (index(DF_NORM,'SUPPOSITORY'))          DF_BASE='SUPPOSITORY';
    when (index(DF_NORM,'ENEMA'))                DF_BASE='ENEMA';
    when (index(DF_NORM,'GUM, CHEWING'))         DF_BASE='GUM';
    when (index(DF_NORM,'LIQUID'))               DF_BASE='LIQUID';
    when (index(DF_NORM,'OIL/DROPS'))            DF_BASE='OIL';
    when (index(DF_NORM,'OIL'))                  DF_BASE='OIL';
    when (index(DF_NORM,'DISC'))                 DF_BASE='DISC';
    when (index(DF_NORM,'DRESSING'))             DF_BASE='DRESSING';
    when (index(DF_NORM,'SPONGE'))               DF_BASE='SPONGE';
    when (index(DF_NORM,'SWAB'))                 DF_BASE='SWAB';
    when (index(DF_NORM,'SHAMPOO'))              DF_BASE='SHAMPOO';
    when (index(DF_NORM,'SOAP'))                 DF_BASE='SOAP';
    when (index(DF_NORM,'TAMPON'))               DF_BASE='TAMPON';
    when (index(DF_NORM,'TAPE'))                 DF_BASE='TAPE';
    when (index(DF_NORM,'SYSTEM'))               DF_BASE='SYSTEM';
    when (index(DF_NORM,'PASTILLE'))             DF_BASE='PASTILLE';
    when (index(DF_NORM,'JELLY'))                DF_BASE='JELLY';
    when (index(DF_NORM,'GAS'))                  DF_BASE='GAS';
    when (index(DF_NORM,'DRUG-ELUTING CONTACT LENS')) DF_BASE='CONTACT LENS';
    when (index(DF_NORM,'INTRAUTERINE DEVICE'))  DF_BASE='DEVICE';
    when (index(DF_NORM,'INHALANT'))             DF_BASE='INHALANT';
    when (index(DF_NORM,'BAR, CHEWABLE'))        DF_BASE='BAR';
    otherwise DF_BASE=''; 
  end;

  /* ---- MODIFIERS (may accumulate, comma-separated) ---- */
  length mods $200;
  mods = '';

 /*catx function combines strings and seperate them with a delimiter*/
  
  if index(DF_NORM,'EXTENDED RELEASE')      then mods = catx(', ', mods, 'ER');
  if index(DF_NORM,'DELAYED RELEASE')       then mods = catx(', ', mods, 'DR');
  if index(DF_NORM,'ORALLY DISINTEGRATING') then mods = catx(', ', mods, 'ODT');

  if index(DF_NORM,'COATED PARTICLES')      then mods = catx(', ', mods, 'COATED PARTICLES');
  if index(DF_NORM,'COATED PELLETS')        then mods = catx(', ', mods, 'COATED PELLETS');
  if index(DF_NORM,'PELLETS') and DF_BASE^='PELLET'
                                           then mods = catx(', ', mods, 'PELLETS');
  if index(DF_NORM,'PULSED')                then mods = catx(', ', mods, 'PULSED');

  /* delivery qualifiers */
  if index(DF_NORM,'METERED')               then mods = catx(', ', mods, 'METERED');
  if index(DF_NORM,'AUGMENTED')             then mods = catx(', ', mods, 'AUGMENTED');
  if index(DF_NORM,'LIPOSOMAL')             then mods = catx(', ', mods, 'LIPOSOMAL');
  if index(DF_NORM,'LIPID COMPLEX')         then mods = catx(', ', mods, 'LIPID COMPLEX');
  if index(DF_NORM,'GEL FORMING/DROPS')     then mods = catx(', ', mods, 'GEL FORMING/DROPS');
  if index(DF_NORM,'FOR SUSPENSION')        then mods = catx(', ', mods, 'FOR SUSPENSION');
  if index(DF_NORM,'FOR SOLUTION')          then mods = catx(', ', mods, 'FOR SOLUTION');
  if index(DF_NORM,'FOR SLUSH')             then mods = catx(', ', mods, 'FOR SLUSH');

  /* specialty */
  if index(DF_NORM,'CHEWABLE')              then mods = catx(', ', mods, 'CHEWABLE');
  if index(DF_NORM,'EFFERVESCENT')          then mods = catx(', ', mods, 'EFFERVESCENT');
  if index(DF_NORM,'DISPERSIBLE')           then mods = catx(', ', mods, 'DISPERSIBLE');

  /* build outputs */
  DF_MOD = mods;
  if not missing(DF_BASE) then do;
    if missing(DF_MOD) then DF_CANON = DF_BASE;
    else DF_CANON = cats(DF_BASE,' (',DF_MOD,')');
  end;
  else DF_CANON = ''; 
  
  drop DF_NORM mods;
run;


data FDAIngredient2;
	set Want_df;
	if DF_Canon= " " then Ingredient2= DF;
	if DF_Canon= " " then DF_Canon= Route;
	keep Appl_No Appl_Type Applicant Applicant_Full_Name Approval_Date DF DF_Canon Ingredient Ingredient2
	Product_No Route RS RLD Trade_Name Type strength;
	run;
proc freq data=FDAIngredient2;
	Table DF_Canon;
	run;


data ob_done;
  set FDAIngredient2;   

  length INGREDIENT3 $200 DF_BASE $100;

  
  length _canon $300;
  /* compbl is much like strip
  the coalesce function is used to select the first non-missing value
  in a list of numeric variables. Returns the first non-blank value
  */
  _canon = upcase(compbl(strip(coalescec(DF_CANON, '')))); *the  '' represent the default value to return if
  all values are missing;
  if index(_canon,'(') then DF_BASE = strip(scan(_canon,1,'('));
  else if index(_canon,',') then DF_BASE = strip(scan(_canon,1,','));
  else DF_BASE = _canon;

  select (DF_BASE);
    when ('AEROSOL','BAR','CAPSULE','CONTACT LENS','CREAM','DISC','DRESSING','DROPS',
          'ELIXIR','ENEMA','FILM','GAS','GEL','GRANULE','GUM','IMPLANT','INHALANT',
          'INJECTABLE','INSERT','JELLY','LIQUID','LOTION','OINTMENT','PASTE',
          'PASTILLE','PATCH','PELLET','PELLETS','POWDER','SHAMPOO','SOAP','SOLUTION',
          'SPONGE','SPRAY','SUPPOSITORY','SUSPENSION','SWAB','SYRUP','SYSTEM','TABLET',
          'TAMPON','TAPE','RING', 'FOR SUSPENSION', 'DENTAL', 'DEVICE', 'SOLUTION/DROPS', 
          'SUSPENSION/DROPS', 'TOPICAL', 'INTRAVENOUS')
      do;  end;

    otherwise do;  
      INGREDIENT3 = coalescec(DF_CANON, DF);
      call missing(DF_CANON);     
    end;
  end;

  drop _canon;
run;

/* QC: verify the move */
proc freq data=ob_done order=freq;
  tables  INGREDIENT3 / missing;
run;

data FDARoute;
	set ob_done;
	drop DF;
	If Route=DF_Canon then Route1=Trade_Name;
	if Route= DF_Base then Route1= Applicant;
	if Route= "TRANSMUCOSAL" then Route1= "TRANSMUCOSAL";
	if Trade_Name= "SUBLINGUAL" then Route1= "SUBLINGUAL";
	if Route= "ORAL" then Route1 = "ORAL";
	if Trade_Name= "ORAL-28" then Route1 = "ORAL";
	if Trade_Name= "ORAL-21" then Route1 = "ORAL";
	If Trade_Name= "ORAL" then Route1= "ORAL";
	if Trade_Name= "INJECTION" then Route1= "INJECTION";
	if Trade_Name= "INHALATION" then Route1= "INHALATION";
	if Trade_Name= "TOPICAL" then Route1= "TOPICAL";
	if Trade_Name= "OPHTHALMIC" then Route1= "OPHTHALMIC";
	if Trade_Name = "INTRAVENOUS" then Route1= "INTRAVENOUS";
	if Trade_Name= "SUBCUTANEOUS" then Route1= "SUBCUTANEOUS";
	if Route= "SOLUTION" then Route1= "SOLUTION";
	if Route= "OPHTHALMIC" then Route1= "OPHTHALMIC";
	if Route= "TOPICAL" then Route1= "TOPICAL";
	if Route= "SOLUTION/DROPS" then Route1= "SOLUTION/DROPS";
	if Trade_Name= "VAGINAL" then Route1= "VAGINAL";
	if Trade_Name= "TRANSDERMAL" then Route1= "TRANSDERMAL";
	if Route= "DENTAL" then Route1= "DENTAL";
	if Trade_Name= "CHOLECALCIFEROL" then Route1= "INTRAVENOUS";
	if Route= "SUBCUTANEOUS" then Route1="SUBCUTANEOUS";
	if Route= "INJECTABLE" then Route1= "INJECTABLE";
	if Trade_Name= "BUCCAL" then Route1= "BUCCAL";
	if Trade_Name= "BUCCAL, SUBLINGUAL" then Route1= "BUCCAL, SUBLINGUAL";
	if Trade_Name= "RECTAL" then Route1= "RECTAL";
	if Route= "DENTAL" then Route1= "DENTAL";
	if Trade_Name= "TITANIUM DIOXIDE" then Route1= "TOPICAL";
	if Trade_Name= "SOYBEAN OIL" then Route1= "INTRAVENOUS";
	if Trade_Name= "ORAL-20" then Route1= "ORAL";
	if Trade_Name= "ERGOCALCIFEROL" then Route1= "ERGOCALCIFEROL";
	if Trade_Name- "SODIUM CHLORIDE" then Route1= "ORAL";
	if Route= "SUSPENSION/DROPS" then Route1= "OPHTHALMIC";
	if Route1= "CHIESI" then Route1= "ORAL";
	if Route1= "CAPSULE, EXTENDED RELEASE" then Route1= "ORAL";
	If Route= "PASTE" then Route1="DENTAL";
	If Route= "SUSPENSION" then Route1= "ENTERAL";
	if Route= "SODIUM BICARBONATE" then Route1= "ORAL";
	if Route= "INTRAVENOUS" then Route1="INTRAVENOUS";
	if Route= "INTRAUTERINE" then Route1= "INTRAUTERINE";
	if Route= "PATCH" then Route1= "TOPICAL";
	if Route = "DEXTROAMPHETAMINE SACCHARATE" then Route1= "ORAL";
	if Route= "EMTRICITABINE" then Route1= "EMTRICITABINE";
	if Route= "SOLUTION/DROPS" then Route1= "OPHTHALMIC";
	if Ingredient2= "POTASSIUM PHOSPHATE, MONOBASIC" then Route1= "INTRAVENOUS";
	if Ingredient2= "IPRATROPIUM BROMIDE" then Route1= "INHALATION";
	if Route= "SELENIOUS ACID" then Route1= "INTRAVENOUS";
	if Route= "SODIUM CHLORIDE"  then Route1="IRRIGATION"; /*POTASSIUM CHLORIDE*/
	if Trade_Name= "IRRIGATION" then Route1= "IRRIGATION";
	if Trade_Name= "ORAL" then Route1=  "ORAL";
	if Trade_Name= "INTRAVENOUS" then Route1= "INTRAVENOUS";
	if Trade_Name= "INTRAUTERINE" then Route1= "INTRAUTERINE";
	if Trade_Name= "ORAL, RECTAL" then Route1= "ORAL, RECTAL";
	if Trade_Name= "SODIUM OXYBATE" then Route1= "ORAL";
	if Trade_Name= "N/A" then Route1= "N/A";
	if Trade_Name= "TOPICAL" then Route1= "TOPICAL";
	if Route= "POTASSIUM CHLORIDE" then Route1= "INJECTABLE";
	if Route= "POTASSIUM OXYBATE" then Route1= "ORAL";
	if Route= "NEOMYCIN SULFATE" then Route1= "OPHTHALMIC";
	if Route= "PARITAPREVIR" then Route1= "ORAL";
	if Ingredient2= "MAGNESIUM CHLORIDE" then Route1= "IRRIGATION";
	if Route= "LACTIC ACID" then Route1= "INJECTABLE";
	if Trade_Name= "MAGNESIUM CHLORIDE" then Route1= "INJECTABLE";
	if Trade_Name= "POTASSIUM CHLORIDE" then Route1= "INJECTABLE";
	if Trade_Name= "POTASSIUM ACETATE" then Route1= "INJECTABLE";
	if Trade_Name= "SODIUM ACETATE" then Route1= "INJECTABLE";
	if Applicant= "	CAPSULE" then Route1= "ORAL";
	if Trade_Name= "INJECTABLE" then Route1= "INJECTABLE";
	if Route= "PERIODONTAL" then Route1= "PERIODONTAL";
	if Route= "DEXTROAMPHETAMINE ADIPATE" then Route1="ORAL";
	if Trade_Name= "OTIC" then Route1= "OTIC";
	if Route= "	MAGNESIUM CHLORIDE" then Route1= "INTRAVENOUS";
	if Strength= "INJECTABLE" then Route1="INJECTABLE";
	if Appl_Type= "IRRIGATION" then Route1= "IRRIGATION";
	if Applicant= "SODIUM ACETATE" then Route1="INJECTABLE";
	if Applicant= "SODIUM CHLORIDE" then Route1= "INJECTABLE";
	if prxmatch("/Irrig/i", Appl_Type ) > 0 then Route1= "IRRIGATION";
	if prxmatch("/Intra/i",  Appl_Type) > 0 then Route1= "INTRAVENOUS";
	if prxmatch("/inject/i", Appl_Type) >0 then Route1= "INJECTABLE";
	if prxmatch("/	CALCIUM CHLORIDE/i", Ingredient2) 
	then Route1= "INJECTABLE";
	if Appl_No = "SOYBEA" then Route1= "INTRAVENOUS";
	if Appl_No = "SODIUM"  then Route1= "INJECTION";
	if prxmatch ("/epinephrine/i", Ingredient) >0 then Route1= "INJECTABLE";
	if Trade_Name= "INTRAMUSCULAR" then Route1= "INTRAMUSCULAR";
	if prxmatch ("/potassium phosphate/i", Applicant) > 0 then Route1= "INJECTABLE";
	if prxmatch ("/potassium chloride/i", Applicant) > 0 then Route1= "INJECTABLE";
	if Ingredient= "AMINO ACIDS" and Ingredient2= "CALCIUM ACETATE" then Route1= "INJECTABLE";
	if prxmatch ("/CODEINE PHOSPHATE/i", Trade_Name) > 0 then Route1= "ORAL";
	if Ingredient= "ACETYLCYSTEINE" and Ingredient2= "ISOPROTERENOL HYDROCHLORIDE" then Route1= "INHALATION";
	if Trade_Name= "SUBCUTANEOUS" then Route1= "SUBCUTANEOUS";
	if Ingredient= "CALCIUM CHLORIDE" and ingredient3 = "MAGNESIUM SULFATE" then Route1= "PERFUSION";
	if Applicant= "ORAQIX" then Route1= "PERIODONTAL";
	if Applicant= "ORAL-28" then Route1= "ORAL";
	if Ingredient= "ASORBIC ACID" and Route= "CHOLECALCIFEROL" then Route1= "INJECTABLE, INRAVENOUS";
	if Ingredient= "COBICISTAT" and Ingredient3= "EMTRICITABINE" then Route1= "ORAL";
	if Ingredient= "ASCORBIC ACID" and Ingredient3= "CYANOCOBALAMIN" then Route1= "INJECTABLE";
	if prxmatch ("/INJEC/i", type) >0 then Route1= "INJECTABLE";
	if Route= "ORAL" then Route1= "ORAL";
	if Route= "ORAL-28" then Route1= "ORAL";
	run;

 /*ingredient ingredient2 ingredient3 are not completely cleaned*/
data organizing;
	retain Ingredient Ingredient2 Ingredient3 DF_Canon Route
	Route1 Trade_Name Applicant;
	set fdaroute;
	run;
	
proc freq data=organizing;
table Route1;
run;

data organizing2;
	set organizing;
	if Route1= " " then Route1=Route;
	if prxmatch("/Rectal Rectal/i", Route) >0 then Route1 = "RECTAL";
	if Route= "INTRAVENOUS" then Route1= "INTRAVENOUS";
	if Trade_Name= "INTRAVENOUS" then Route1= "INTRAVENOUS";
	if prxmatch("/INTRAMUSCULAR,/i", Route) >0 then Route1=Route;
	if Route= "INJECTABLE" and Trade_Name= "INJECTION" then Route1= "INJECTABLE, INJECTION";
	if Trade_Name= "INJECTABLE" and Applicant= "INJECTION" then Route1= "INJECTABLE, INJECTION";
	if prxmatch("/oral,/i", Route) >0 then Route1= Route;
	if Ingredient= "EPINEPHRINE" and Ingredient2= "LIDOCAINE HYDROCHLORIDE" and Applicant= "IONTOCAINE" 
	then Route1= "INJECTABLE, IONTOPHORESIS ";
	if Ingredient= "EPINEPHRINE" and Ingredient2= "LIDOCAINE HYDROCHLORIDE" and Trade_Name= "IONTOPHORESIS, TOPICAL" 
	then Route1= "INJECTABLE, IONTOPHORESIS, TOPICAL";
	if Ingredient= "CALCIUM CHLORIDE" and Appl_No= "IRRIGA" then Route1= "IRRIGATION";
	if Strength= "INJECTABLE" and Appl_Type= "INJEC" then Route1= "INJECTABLE, INJECTION";
	if Appl_Type= "INJEC" and Appl_No= "INJECT" then Route1= "INJECTABLE, INJECTION";
	if Strength= "INJECTABLE" and Appl_Type= "INJEC" then Route1= "INJECTABLE, INJECTION";
	if DF_Canon= "INJECTABLE" and Route= "INJECTION" then Route1= "INJECTABLE, INJECTION";
	/*injection check*/
	run;

proc freq data= organizing2;
table Route1;
run;

data routeclean;
	set organizing2;
	keep route1;
	run;
	

data route2;
	set routeclean;
	Route= scan(route1, 1, ",");
	Route2= scan(route1, 2, ",");
	Route3= scan(route1, 3, ",");
	drop route1;
	rename Route=Route1;

	run;
	
	/* Map granular route_part -> route_group */
data routes_grouped;
  set route2;
  length route_group $20;

  select (route1);
    when ('ORAL','SUBLINGUAL','BUCCAL','TRANSMUCOSAL')                   route_group='ORAL/MUCOSAL';
    when ('INJECTION','INJECTABLE','INTRAMUSCULAR','INTRAVENOUS'
          ,'SUBCUTANEOUS','INTRA-ARTERIAL','INTRATHECAL','INTRADERMAL'
          ,'INTRAVITREAL','INTRACAVITARY','INTRA-ANAL','INTRAOCULAR'
          ,'INTRATRACHEAL','INTRAPERITONEAL','INTRAPLEURAL'
          ,'INTRAUTERINE','INTRAVESICAL','INTRACAMERAL','INTRACRANIAL'
          ,'PERIARTICULAR','SPINAL','INTRALYMPHATIC')                     route_group='INJECTION/INTRA-*';
    when ('TOPICAL','TRANSDERMAL','IONTOPHORESIS')                        route_group='TOPICAL/DERMAL';
    when ('INHALATION','NASAL')                                           route_group='RESPIRATORY';
    when ('RECTAL')                                                       route_group='RECTAL';
    when ('VAGINAL','ENDOCERVICAL')                                       route_group='VAGINAL/CERVICAL';
    when ('OPHTHALMIC')                                                   route_group='OPHTHALMIC';
    when ('OTIC')                                                         route_group='OTIC';
    when ('ENTERAL')                                                      route_group='ENTERAL';
    when ('IRRIGATION')                                                   route_group='IRRIGATION';
    when ('PERFUSION','PERFUSION, BILIARY')                               route_group='PERFUSION';
    when ('IMPLANTATION')                                                 route_group='IMPLANTATION';
    when ('URETHRAL','URETERAL','PYELOCALYCEAL')                          route_group='UROLOGICAL';
    otherwise route_group='OTHER';
  end;
run;

proc freq data=routes_grouped order=freq;
  tables route_group / nocum;
run;



