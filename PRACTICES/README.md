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
 

(Still writing... ~실습4)
