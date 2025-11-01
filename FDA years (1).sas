data year;
 	set organizing2;
 approval_character= strip(Approval_Date);
*if RLD not in ("Yes", "No") then Approval_Date1= RLD;
*if RS not in ("Yes", "No") then Approval_Date2= RS; /* full date*/
if prxmatch ('/apr /i', approval_character) > 0 then Approval_Date1= approval_character;
if prxmatch ('/jan /i', approval_character) > 0 then Approval_Date1= approval_character;
if prxmatch ('/feb /i', approval_character) > 0 then Approval_Date1= approval_character;
if prxmatch ('/mar /i', approval_character) > 0 then Approval_Date1= approval_character;
if prxmatch ('/may /i', approval_character) > 0 then Approval_Date1= approval_character;
if prxmatch ('/jun /i', approval_character) > 0 then Approval_Date1= approval_character;
if prxmatch ('/jul /i', approval_character) > 0 then Approval_Date1= approval_character;
if prxmatch ('/aug /i', approval_character) > 0 then Approval_Date1= approval_character;
if prxmatch ('/sep /i', approval_character) > 0 then Approval_Date1= approval_character;
if prxmatch ('/oct /i', approval_character) > 0 then Approval_Date1= approval_character;
if prxmatch ('/nov /i', approval_character) > 0 then Approval_Date1= approval_character;
if prxmatch ('/dec /i', approval_character) > 0 then Approval_Date1= approval_character;

if prxmatch ('/oct /i', var16) > 0 then Approval_Date1= var16;

if prxmatch ('/apr /i', var17) > 0 then Approval_Date1= var17;
if prxmatch ('/jan /i', var17) > 0 then Approval_Date1= var17;
if prxmatch ('/feb /i', var17) > 0 then Approval_Date1= var17;
if prxmatch ('/mar /i', var17) > 0 then Approval_Date1= var17;
if prxmatch ('/may /i', var17) > 0 then Approval_Date1= var17;
if prxmatch ('/jun /i', var17) > 0 then Approval_Date1= var17;
if prxmatch ('/jul /i', var17) > 0 then Approval_Date1= var17;
if prxmatch ('/aug /i', var17) > 0 then Approval_Date1= var17;
if prxmatch ('/sep /i', var17)> 0 then Approval_Date1= var17;
if prxmatch ('/oct /i', var17) > 0 then Approval_Date1= var17;
if prxmatch ('/nov /i', var17) > 0 then Approval_Date1= var17;
if prxmatch ('/dec /i', var17) > 0 then Approval_Date1= var17;

if prxmatch ('/jan /i', var18) > 0 then Approval_Date1= var18;

if prxmatch ('/apr /i', var19) > 0 then Approval_Date1= var19;
if prxmatch ('/jan /i', var19) > 0 then Approval_Date1= var19;
if prxmatch ('/feb /i', var19) > 0 then Approval_Date1= var19;
if prxmatch ('/mar /i', var19) > 0 then Approval_Date1= var19;
if prxmatch ('/may /i', var19) > 0 then Approval_Date1= var19;
if prxmatch ('/jun /i', var19) > 0 then Approval_Date1= var19;
if prxmatch ('/jul /i', var19) > 0 then Approval_Date1= var19;
if prxmatch ('/aug /i', var19) > 0 then Approval_Date1= var19;
if prxmatch ('/sep /i', var19)> 0 then Approval_Date1= var19;
if prxmatch ('/oct /i', var19) > 0 then Approval_Date1= var19;
if prxmatch ('/nov /i', var19) > 0 then Approval_Date1= var19;
if prxmatch ('/dec /i', var19) > 0 then Approval_Date1= var19;

if prxmatch ('/apr /i', var21) > 0 then Approval_Date1= var21;
if prxmatch ('/jan /i', var21) > 0 then Approval_Date1= var21;
if prxmatch ('/feb /i', var21) > 0 then Approval_Date1= var21;
if prxmatch ('/mar /i', var21) > 0 then Approval_Date1= var21;
if prxmatch ('/may /i', var21) > 0 then Approval_Date1= var21;
if prxmatch ('/jun /i', var21) > 0 then Approval_Date1= var21;
if prxmatch ('/jul /i', var21) > 0 then Approval_Date1= var21;
if prxmatch ('/aug /i', var21) > 0 then Approval_Date1= var21;
if prxmatch ('/sep /i', var21)> 0 then Approval_Date1= var21;
if prxmatch ('/oct /i', var21) > 0 then Approval_Date1= var21;
if prxmatch ('/nov /i', var21) > 0 then Approval_Date1= var21;
if prxmatch ('/dec /i', var21) > 0 then Approval_Date1= var21;

if prxmatch ('/apr /i', var23) > 0 then Approval_Date1= var23;
if prxmatch ('/jan /i', var23) > 0 then Approval_Date1= var23;
if prxmatch ('/feb /i', var23) > 0 then Approval_Date1= var23;
if prxmatch ('/mar /i', var23) > 0 then Approval_Date1= var23;
if prxmatch ('/may /i', var23) > 0 then Approval_Date1= var23;
if prxmatch ('/jun /i', var23) > 0 then Approval_Date1= var23;
if prxmatch ('/jul /i', var23) > 0 then Approval_Date1= var23;
if prxmatch ('/aug /i', var23) > 0 then Approval_Date1= var23;
if prxmatch ('/sep /i', var23)> 0 then Approval_Date1= var23;
if prxmatch ('/oct /i', var23) > 0 then Approval_Date1= var23;
if prxmatch ('/nov /i', var23) > 0 then Approval_Date1= var23;
if prxmatch ('/dec /i', var23) > 0 then Approval_Date1= var23;

if prxmatch ('/apr /i', var25) > 0 then Approval_Date1= var25;
if prxmatch ('/jan /i', var25) > 0 then Approval_Date1= var25;
if prxmatch ('/feb /i', var25) > 0 then Approval_Date1= var25;
if prxmatch ('/mar /i', var25) > 0 then Approval_Date1= var25;
if prxmatch ('/may /i', var25) > 0 then Approval_Date1= var25;
if prxmatch ('/jun /i', var25) > 0 then Approval_Date1= var25;
if prxmatch ('/jul /i', var25) > 0 then Approval_Date1= var25;
if prxmatch ('/aug /i', var25) > 0 then Approval_Date1= var25;
if prxmatch ('/sep /i', var25)> 0 then Approval_Date1= var25;
if prxmatch ('/oct /i', var25) > 0 then Approval_Date1= var25;
if prxmatch ('/nov /i', var25) > 0 then Approval_Date1= var25;
if prxmatch ('/dec /i', var25) > 0 then Approval_Date1= var25;

if prxmatch ('/apr /i', var33) > 0 then Approval_Date1= var33;
if prxmatch ('/jan /i', var33) > 0 then Approval_Date1= var33;
if prxmatch ('/feb /i', var33) > 0 then Approval_Date1= var33;
if prxmatch ('/mar /i', var33) > 0 then Approval_Date1= var33;
if prxmatch ('/may /i', var33) > 0 then Approval_Date1= var33;
if prxmatch ('/jun /i', var33) > 0 then Approval_Date1= var33;
if prxmatch ('/jul /i', var33) > 0 then Approval_Date1= var33;
if prxmatch ('/aug /i', var33) > 0 then Approval_Date1= var33;
if prxmatch ('/sep /i', var33)> 0 then Approval_Date1= var33;
if prxmatch ('/oct /i', var33) > 0 then Approval_Date1= var33;
if prxmatch ('/nov /i', var33) > 0 then Approval_Date1= var33;
if prxmatch ('/dec /i', var33) > 0 then Approval_Date1= var33;

if prxmatch ('/apr /i', var35) > 0 then Approval_Date1= var35;
if prxmatch ('/jan /i', var35) > 0 then Approval_Date1= var35;
if prxmatch ('/feb /i', var35) > 0 then Approval_Date1= var35;
if prxmatch ('/mar /i', var35) > 0 then Approval_Date1= var35;
if prxmatch ('/may /i', var35) > 0 then Approval_Date1= var35;
if prxmatch ('/jun /i', var35) > 0 then Approval_Date1= var35;
if prxmatch ('/jul /i', var35) > 0 then Approval_Date1= var35;
if prxmatch ('/aug /i', var35) > 0 then Approval_Date1= var35;
if prxmatch ('/sep /i', var35)> 0 then Approval_Date1= var35;
if prxmatch ('/oct /i', var35) > 0 then Approval_Date1= var35;
if prxmatch ('/nov /i', var35) > 0 then Approval_Date1= var35;
if prxmatch ('/dec /i', var35) > 0 then Approval_Date1= var35;

if prxmatch ('/apr /i', Type) > 0 then Approval_Date2= Type;
if prxmatch ('/jan /i', Type) > 0 then Approval_Date2= Type;
if prxmatch ('/feb /i', Type) > 0 then Approval_Date2= Type;
if prxmatch ('/mar /i', Type) > 0 then Approval_Date2= Type;
if prxmatch ('/may /i', Type) > 0 then Approval_Date2= Type;
if prxmatch ('/jun /i', Type) > 0 then Approval_Date2= Type;
if prxmatch ('/jul /i', Type) > 0 then Approval_Date2= Type;
if prxmatch ('/aug /i', Type) > 0 then Approval_Date2= Type;
if prxmatch ('/sep /i', Type) > 0 then Approval_Date2= Type;
if prxmatch ('/oct /i', Type) > 0 then Approval_Date2= Type;
if prxmatch ('/nov /i', Type) > 0 then Approval_Date2= Type;
if prxmatch ('/dec /i', Type) > 0 then Approval_Date2= Type;

if prxmatch ('/apr /i', RS) > 0 then Approval_Date2= RS;
if prxmatch ('/jan /i', RS) > 0 then Approval_Date2= RS;
if prxmatch ('/feb /i', RS) > 0 then Approval_Date2= RS;
if prxmatch ('/mar /i', RS) > 0 then Approval_Date2= RS;
if prxmatch ('/may /i', RS) > 0 then Approval_Date2= RS;
if prxmatch ('/jun /i', RS) > 0 then Approval_Date2= RS;
if prxmatch ('/jul /i', RS) > 0 then Approval_Date2= RS;
if prxmatch ('/aug /i', RS) > 0 then Approval_Date2= RS;
if prxmatch ('/sep /i', RS) > 0 then Approval_Date2= RS;
if prxmatch ('/oct /i', RS) > 0 then Approval_Date2= RS;
if prxmatch ('/nov /i', RS) > 0 then Approval_Date2= RS;
if prxmatch ('/dec /i', RS) > 0 then Approval_Date2= RS;
if prxmatch('/mar /i', Applicant_Full_Name) >0 then Approval_Date2= Applicant_Full_Name;
if prxmatch('/Jan /i', Applicant_Full_Name) >0 then Approval_Date2= Applicant_Full_Name;
if prxmatch('/Feb /i', Applicant_Full_Name) >0 then Approval_Date2= Applicant_Full_Name;
if prxmatch('/apr /i', Applicant_Full_Name) >0 then Approval_Date2= Applicant_Full_Name;
if prxmatch('/may /i', Applicant_Full_Name) >0 then Approval_Date2= Applicant_Full_Name;
if prxmatch('/jun /i', Applicant_Full_Name) >0 then Approval_Date2= Applicant_Full_Name;
if prxmatch('/jul /i', Applicant_Full_Name) >0 then Approval_Date2= Applicant_Full_Name;
if prxmatch('/aug /i', Applicant_Full_Name) >0 then Approval_Date2= Applicant_Full_Name;
if prxmatch('/sep /i',Applicant_Full_Name) >0 then Approval_Date2= Applicant_Full_Name;
if prxmatch('/oct /i',Applicant_Full_Name) >0 then Approval_Date2= Applicant_Full_Name;
if prxmatch('/nov /i',Applicant_Full_Name) >0 then Approval_Date2= Applicant_Full_Name;
if prxmatch('/dec /i',Applicant_Full_Name) >0 then Approval_Date2= Applicant_Full_Name;
Routeone= scan(route1, 1, ",");
	Routetwo= scan(route1, 2, ",");
	Routethree= scan(route1, 3, ",");
	drop Route Route1 Var16 Var17 var18 var19 var20 var21 var22 var23
	var24 var25 var26 var27 var28 var29 var30 var31 var32 var33 var34 var35 var36 var37 var38 var39 var40;;
 run;

 
data year1;
	set year;
if missing(Approval_Date1) then Approval_Date1= Approval_Date2;
if approval_character= "Approved Prior" then Approval_Date1= "Jan 1, 1982";
if Approval_Date2= "Approved Prior to Jan 1, 1982" then Approval_Date1= "Jan 1, 1982";
*if Approval_Date1= "Approved Prior to Jan 1, 1982" then Approval_Date1= "Jan 1, 1982";

	run;

data yearclean;
	set year1;
	keep routeone routetwo route3 approval_date1 year year1;
	year=substr(approval_date1, length(approval_date1)-4); *tells sas how long the string is;
	if approval_date1="Approved Prior" then year= "1982";
	year1= put(year, 5.);
	run;
	

proc freq data= yearclean;
table year1 * routeone / nocol nopercent nocum norow out=yearclean1;
run;

/*proc sort data=year1 out=missing_sorted;
	by ingredient; run;
data missingdate;
    set missing_sorted;
    if missing(Approval_Date1);
run;

proc print data=missingdate;
run;


proc freq data= year;
table route1;
run;*/

 