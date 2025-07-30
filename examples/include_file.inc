* GAMS Include File Example
* This file contains common definitions used across multiple models

* Common sets
sets
    time_periods / 1*12 /
    regions / north, south, east, west /
    technologies / solar, wind, hydro, thermal /
;

* Common parameters
parameters
    discount_rate "annual discount rate" / 0.05 /
    max_capacity(technologies) "maximum capacity by technology"
    min_capacity(technologies) "minimum capacity by technology"
;

* Technology-specific parameters
max_capacity('solar') = 1000;
max_capacity('wind') = 800;
max_capacity('hydro') = 500;
max_capacity('thermal') = 2000;

min_capacity('solar') = 0;
min_capacity('wind') = 0;
min_capacity('hydro') = 50;
min_capacity('thermal') = 100;

* Common variables (if needed)
variables
    investment(technologies, regions) "investment in technology"
    operation(technologies, regions, time_periods) "operation level"
;

* Common equations (if needed)
equations
    capacity_limit(technologies, regions) "capacity constraint"
    demand_balance(regions, time_periods) "demand satisfaction"
; 