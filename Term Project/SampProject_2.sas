/* Bring in data */
data tuition;
  set statsamp.TUITION;
run;

/*
proc print data = tuition;
run;
*/

/*SRS select sample*/
proc surveyselect data = tuition 
out = srssample1
sampsize = 91
seed = 16 stats;
title "Simple Random Sample";
run;

/*
proc print data = srssample1;
run;
*/

/*mean for simple random sample*/
proc surveymeans data = srssample1 total = 2640 mean clm;
var Tuition;
weight SamplingWeight;
title "Simple Random Sample";
run;

/*Stratified Sample data step*/
data tuition_st;
set tuition;
if Sector_name = "4-year public" then stratum = 1;
else if Sector_name = "4-year pnfp" then stratum = 2;
else stratum = 3;
run;

/*
proc print data = tuition_st;
run;
*/

/*select stratified sample based on proportional allocation*/
proc surveyselect data = tuition_st method = srs out = strsample1 sampsize = (23,46,22) seed = 816;
strata stratum;
title "Proportional Allocation";
run;

/*
proc print data = strsample1;
run;
*/

/*set up totals for strata*/
data strsizes;
input stratum _total_;
datalines;
1 676
2 1322
3 642
;
run;

/*mean for stratified design*/
proc surveymeans data = strsample1 total = strsizes mean clm;
var Tuition;
weight SamplingWeight;
title "Proportional Allocation";
run;


/*******************************************
** Stratified Sampling: Neyman Allocation **
*******************************************/

/* Create Strata */
data tuition_stn;
set tuition_st;
run;
proc print data=tuition_stn;
run;

/* STD for Neyman Allocation */
/* Sort data first */
proc sort data=tuition_stn;
by Sector_name;
run;

proc surveymeans data=tuition_stn total=2640 mean std clm;
var Tuition;
by Sector_name;
run;

/* Select sample size based on Neyman Allocation */
/* Re-sort the data by stratum*/ 
proc sort data=tuition_stn;
by stratum;
run;

proc surveyselect data=tuition_stn method=SRS out=NeymanAllocation sampsize=(14, 60, 17) seed=1111;
strata Stratum;
title "Neyman Allocation";
run;

/*
proc print data=NeymanAllocation;
run;
*/

/* Set the totals for each strata */
data strsizes;
input stratum _total_;
datalines; 
1 676
2 1322
3 642
;
run;

/* Analyzing the sample */
proc surveymeans data=NeymanAllocation mean clm sum clsum total=strsizes;
var Tuition;
weight SamplingWeight;
strata Stratum;
title "Neyman Allocaiton";
run;

/**********5 iterations of Neyman*************/
proc surveyselect data=tuition_stn method=SRS out=NeymanAllocation1 sampsize=(14, 60, 17) seed=2222;
strata Stratum;
title "Neyman Allocation1";
run;

proc surveymeans data=NeymanAllocation1 mean clm sum clsum total=strsizes;
var Tuition;
weight SamplingWeight;
strata Stratum;
title "Neyman Allocaiton1";
run;

proc surveyselect data=tuition_stn method=SRS out=NeymanAllocation2 sampsize=(14, 60, 17) seed=487;
strata Stratum;
title "Neyman Allocation2";
run;

proc surveymeans data=NeymanAllocation2 mean clm sum clsum total=strsizes;
var Tuition;
weight SamplingWeight;
strata Stratum;
title "Neyman Allocaiton2";
run;

proc surveyselect data=tuition_stn method=SRS out=NeymanAllocation3 sampsize=(14, 60, 17) seed=892;
strata Stratum;
title "Neyman Allocation3";
run;

proc surveymeans data=NeymanAllocation3 mean clm sum clsum total=strsizes;
var Tuition;
weight SamplingWeight;
strata Stratum;
title "Neyman Allocaiton3";
run;

proc surveyselect data=tuition_stn method=SRS out=NeymanAllocation4 sampsize=(14, 60, 17) seed=5832;
strata Stratum;
title "Neyman Allocation4";
run;

proc surveymeans data=NeymanAllocation4 mean clm sum clsum total=strsizes;
var Tuition;
weight SamplingWeight;
strata Stratum;
title "Neyman Allocaiton4";
run;

proc surveyselect data=tuition_stn method=SRS out=NeymanAllocation5 sampsize=(14, 60, 17) seed=1683;
strata Stratum;
title "Neyman Allocation5";
run;

proc surveymeans data=NeymanAllocation5 mean clm sum clsum total=strsizes;
var Tuition;
weight SamplingWeight;
strata Stratum;
title "Neyman Allocaiton5";
run;


/**********5 iterations of SRS*************/
proc surveyselect data = tuition 
out = srssample2
sampsize = 91
seed = 456 stats;
title "Simple Random Sample1";
run;
/*mean for simple random sample*/
proc surveymeans data = srssample2 total = 2640 mean clm;
var Tuition;
weight SamplingWeight;
title "Simple Random Sample1";
run;

proc surveyselect data = tuition 
out = srssample3
sampsize = 91
seed = 789 stats;
title "Simple Random Sample2";
run;
/*mean for simple random sample*/
proc surveymeans data = srssample3 total = 2640 mean clm;
var Tuition;
weight SamplingWeight;
title "Simple Random Sample2";
run;

proc surveyselect data = tuition 
out = srssample4
sampsize = 91
seed = 6042 stats;
title "Simple Random Sample3";
run;
/*mean for simple random sample*/
proc surveymeans data = srssample4 total = 2640 mean clm;
var Tuition;
weight SamplingWeight;
title "Simple Random Sample3";
run;

proc surveyselect data = tuition 
out = srssample5
sampsize = 91
seed = 9734 stats;
title "Simple Random Sample4";
run;
/*mean for simple random sample*/
proc surveymeans data = srssample5 total = 2640 mean clm;
var Tuition;
weight SamplingWeight;
title "Simple Random Sample4";
run;

proc surveyselect data = tuition 
out = srssample6
sampsize = 91
seed = 7742 stats;
title "Simple Random Sample5";
run;
/*mean for simple random sample*/
proc surveymeans data = srssample6 total = 2640 mean clm;
var Tuition;
weight SamplingWeight;
title "Simple Random Sample5";
run;