# Keywords

### Basic
　**SELECT**: retrieve data from one or more tables  
　　~ **FROM**: specify the objects from which data is selected  
　　~ **WHERE**: restricts the retrieval to one or more partitions of table  
　　~ **ORDER BY**: sort the records in your result set  
　　~ **GROUP BY**: collect data across multiple records and group the results by one or more columns  
　　　~ **HAVING**: restrict the groups of returned rows to only those whose the condition is TRUE  
　**AS**: give an alias name to EQL attributes and results  
　**LIKE**: perform pattern matching  
　**CASE**: let you use IF ... THEN ... ELSE logic in SQL statements without having to invoke procedures  
　　~ **WHEN**: condition of IF  
　　　~ **THEN**: return value of IF when the condition is TRUE  
　　　~ **ELSE**: return value of IF when the condition is FALSE  
　　~ **END**: end of the case  
  
### Logical
　**NOT**: negate a condition  
　**AND**: test for two or more conditions  
　　~ **BETWEEN**: retrieve values within a range  
　**OR**: test multiple conditions where records are returned when any one of the conditions are met  
　**IN**: help reduce the need to use multiple OR conditions  

### Aggregate
　**SUM**: returns the sum of all or distinct values in a set of values   
　**MIN**: returns the minimum value of a set  
　**MAX**: returns the maximum value of a set  
　**AVG**: accepts a list of values and returns the average  
　**COUNT**: returns the number of items in a group, including NULL and duplicate values  
　　~ **DISTINCT**: filter duplicate rows in the result set  
　**ROUND**: returns a number rounded to a certain number of decimal places
　
### Type
　**NULL**: represents a lack of data  
　　~ **IGNORE NULLS**: let null values of expr are eliminated from the calculation  
　**NVL**: allows you to replace null with a more meaningful alternative in the results of a query  
　**EXTRACT**: extracts and returns the value of a specified datetime field from a datetime or interval value expression  
　　~ **YEAR**: extract only YEAR  
　　~ **MONTH**: extract only MONTH  
　**TO_CHAR**: converts a number or date to a string  
　**SUBSTR**: extract a substring from a string  
　**INSTR**: search for a substring within a string, and return the position at which the substring is found  
　**LPAD**: pad the left side of a string with a specified set of characters
 
### Set Operators
　**UNION**: combines result sets of two or more SELECT statements into a single result set  
　　~ **ALL**: retain the duplicate rows  
　**MINUS**: return all rows in the first SELECT statement that are not returned by the second SELECT statement  
　**INTERSECT**: compares the result of two queries and returns the distinct rows that are output by both queries  
 
### Symbols
　**=** : Equality test  
　**<>** : Inequality test   
　**(+)** : perform outer joins on two or more tables  
　**%** : matches any string of zero or more characters except null   
　**_** : matches any single character   
　**||** : concatenate 2 or more strings together  
 
### Grouping Functions
　**ROLLUP**: produces group subtotals from right to left and a grand total  
　**CUBE**: generate subtotals for all combinations of the dimensions specified  

### Hierarchical Queries
　**START WITH**: specifies the root row(s) of the hierarchy  
　**CONNECT BY**: specifies the relationship between parent rows and child rows of the hierarchy  
　　~ **CONNECT_BY_ROOT**: returning not only the immediate parent row but all ancestor rows in the hierarchy  
　　~ **CONNECT_BY_ISLEAF**: returns a 1 if the row is a leaf in the hierarchy as defined by the CONNECT BY clause  
　**PRIOR**: evaluates the immediately following expression for the parent row of the current row in a hierarchical query  
　**LEVEL**: returns 1 for a root row, 2 for a child of a root, and so on for each row returned by a hierarchical query  
　**ORDER SIBLINGS BY**: specifies an order that first sorts the parent rows, and then sorts the child rows of each parent for every level within the hierarchy  

### Pivot
　**PIVOT**: transform rows into columns  
　**UNPIVOT**: transform data from columns to rows  
　　~**FOR**: limits the query to only specified values  

(Still writing... ~실습8)
