# Armies

from
[HackerRank](https://www.hackerrank.com/challenges/fighting-armies/problem)

Your country is at war!

As a General, you initially have  armies numbered from  to  under your command. Each army consists of some number of soldiers, and each soldier is assigned an integer, , representative of his or her combat ability. Since, you are responsible for all of them, you want to give orders to your armies and query them about their current state. You must handle  events, where each event is one of the  following types:

 - Print the maximum combat ability of any soldier in army .
 - A soldier with the maximum combat ability among all soldiers in army  has died, so the soldier is removed from the army.
 - A soldier with combat ability  has joined army .
 - Armies  and  are merged into a single army , and army  is removed (ceases to exist).
Note: The input can be quite large, so we suggest you use fast I/O methods.

Input Format

The first line contains  space-separated integers,  (the number of armies you command) and  (the number of events taking place), respectively. Each of the  subsequent lines describes a single event.

Each event first contains an integer, , describing the event type.
If  or , the line contains  more integer denoting the parameter of the event.
If  or , the line contains  more integers denoting the respective parameters of the event.

Constraints

Output Format

For each event of type , print a single line containing  integer denoting the answer for the event.
