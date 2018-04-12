## -*- coding: utf-8 -*-
#This is a python Mako template for a FlUTE config file.

#infrastructural parameters
label ${label}
seed ${seed}

#disable log file
logfile 0

#basic parameters
R0 ${R0}
runlength ${run_length}
datafile ${data_file}

#parameters further down the script:
# - population_size
# - vaccine_priorities:
#       comma-separated set of identifiers 
#       (preschool, school, young-adults, older-adults, elderly)

seedinfected 10
seedinfecteddaily 0

#People ARE vaccinated prior to the epidemic.
prestrategy prevaccinate
#There is no reactive strategy
reactivestrategy none 

vaccinationfraction 1
vaccinedoses 0 ${doses} 

#Vaccine definition
#vaccine_id VE_S VE_I VE_P "6 age groups"
#This definition is based on [1], 
#but only the age group <6 months is excluded in this setup.
#VE_S,VE_I: CDC overview
#VE_P [1]
vaccinedata 0 0.5 0.5 0.67 1 0 0 0 0 0 0

#Vector of 13 priorities,
#the 5 last entries encompass age-specific priorities:
#all preschoolers, all school-age children, all young adults, 
#all older adults, all elderly.
#Priorities are determined numerically:
#a value of 1 indicates highest priority, 2 is the next-highest priority, etc. 
#0 indicates that this category is not prioritized to get vaccine.
#In this script, we are interested in targeting a combination of these 
#age groups to prioritize.
#These can be controlled by passing a comma separated vector of numerals.
<%
    priorities = [0]*8
%>
vaccinepriorities ${" ".join(map(str, priorities)) + " " + vaccine_priorities.replace(","," ")}

#References
#[1] Yang, Yang, et al. "The transmissibility and control of pandemic influenza A (H1N1) virus." Science 326.5953 (2009): 729-733.
