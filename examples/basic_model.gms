$title Basic GAMS Model Example

* This is a basic GAMS model to demonstrate syntax highlighting
* Sets, parameters, variables, and equations are highlighted

sets
    i "sources" / 1*3 /
    j "destinations" / 1*4 /
;

parameters
    supply(i) "supply at source i" / 1 100, 2 150, 3 200 /
    demand(j) "demand at destination j" / 1 80, 2 90, 3 120, 4 160 /
    cost(i,j) "unit cost of transport"
;

* Initialize cost matrix
cost(i,j) = uniform(10, 50);

variables
    x(i,j) "shipment quantities"
    z "total cost"
;

equations
    supply_balance(i) "supply limit"
    demand_balance(j) "demand requirement"
    objective "total cost"
;

* Define constraints
supply_balance(i).. sum(j, x(i,j)) =l= supply(i);

demand_balance(j).. sum(i, x(i,j)) =g= demand(j);

objective.. z =e= sum((i,j), cost(i,j) * x(i,j));

* Model definition and solve
model transport / all /;

* Solve the model
solve transport using lp minimizing z;

* Display results
display x.l, z.l; 