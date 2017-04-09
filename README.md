# Bowling game script


### To use:

 * Make sure you have `ruby` installed, check https://www.tutorialspoint.com/ruby-on-rails/rails-installation.htm for more details
 * Download or clone the repository
 * Extract the repository and change directory to the extracted folder
 * Run the ruby script command!  :+1:

### Sample usage:

```
ruby run_game.rb [[6,2],[9,1],[1,8],[10],[4,1],[5,2],[0,3],[10],[7,0],[10,7,2]]
ruby run_game.rb [[10],[10],[10],[10],[10],[10],[10],[10],[10],[10,10,10]]
```
sample output:
> **[8, 18, 27, 42, 47, 54, 57, 74, 81, 100]**  


---


### Rules/Assumptions/Errors handled:
 
 * Game can only have 10 frames
 * A frame is invalid if (you can try the commands included):
   1. It is empty  
   	```
    ruby run_game.rb [[],[],[],[],[],[],[],[],[],[]]
    ```
   2. It has invalid number of inputs for **Strike/Non-Strike** frames  
    ```
    ruby run_game.rb [[6],[9,1],[1,8],[10],[4,1],[5,2],[0,3],[10],[7,0],[10,7,2]]  
    ruby run_game.rb [[10,7,2],[9,1],[1,8],[10],[4,1],[5,2],[0,3],[10],[7,0],[10,7,2]]
    ruby run_game.rb [[6,2],[9,1],[1,8],[10],[4,1],[5,2],[0,3],[10],[7,0],[1,1,1]]  
    ruby run_game.rb [[6,2],[9,1],[1,8],[10],[4,1],[5,2],[0,3],[10],[7,0],[10]]
    ```  
   3. It has more than 2 values inside for frames 1-9  
    ```
    ruby run_game.rb [[1,1,1],[2,2,2],[3,3,3],[4,4,4],[4,1],[5,2],[0,3],[10],[7,0],[10,7,2]]
    ```
   4. It has more than 3 values inside for all frames  
    ```
    ruby run_game.rb [[1,1,1,1],[2,2,2,2],[3,3,3],[4,4,4],[4,1],[5,2],[0,3],[10],[7,0],[10,10,10,10]]
    ```  
   5. It has values inside that are either negative, or > 10  
    ```
    ruby run_game.rb [[-6,2],[9,11],[11,8],[10],[4,1],[5,2],[0,3],[10],[7,0],[10,7,2]]
    ``` 