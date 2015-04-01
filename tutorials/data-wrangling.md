# Data Wrangling with dplyr and tidyr

##Introduction

Data wrangling (sometimes call "munging" or "pre-processing") is the act of converting raw data into a form that is meaningful and analyzable. 

There are two main steps in data wrangling. The first is getting your data in **Tidy** form. The second is organization, mutation, subsetting, selecting, renaming, recategorizing, etc... ( realize there are many aspects of the second step that would suggest its more than a single step, but in the grand scheme of data wrangling, it is a single step). 

An easy way to think about this second step is that it is anything you need to do to your data after it is *tidy* and prior to running complex analytical models. You will spend approximately 60%-80% of your time on this step depending on the type and structure of the data you are working with. 

It is important to note that these two steps are iterative in nature. It may be that you load data and need to format it prior to being able to appropriately tidy the data. 

##Tidy Data

What does tidy data look like? A tidy dataset is one in which every row is an observation and every column is a variable. Depending on the question you are asking and the model you are running, the same dataset may be tidy for one model, but not for another.

With the Fan Graphs data, there isn't any Tidying that actually needs to occur. Typically sports statistics are pretty well organized. If you need to learn to tidy data, go through [this vignette](http://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html). Reading through this vignette and typing in the code should give you an idea of what are ways that seemingly normal looking data can be untidy and the necessary steps you need to take to tidy the data for analysis.

#####A Brief Aside on Long vs. Wide Data
In traditional data analysis, there are two main formats for datasets, *wide* and *long*. Wide and long descriptions for datasets only matters when there are multiple observations for single respondents. For example, having a list of individual player statistics for multiple years, you may either have the players name listed multiple times with each row representing a year/player unit of data observation. This is the long format. You may also have a single row for each player with each year having it's own set of identical columns. This is the wide format.

##Getting Started with Data Wrangling
When starting any project, it is important to know what you actually want to do. This serves two purposes. The obvious purpose is that it keeps your work focused by giving you a goal to work towards. The second purpose is that it forces you to think about the granular steps necessary to accomplish your goal. In R, there are many packages that can make accomplishing almost any goal much easier. If you know what actions you plan on taking, you can identify and load the appropriate R package.

Before you start, make sure you have downloaded the most up-to-date github repository for this project. You can do this by clicking on the `git` icon at the top or the `git` tab in one of the panels. Once you do this, click **pull** to pull the most recent branches. After a minute or so, you should have the most up-to-date version of the project and you should be ready to work.

###Loading Packages
For every project, I always load the same 3 packages to begin with: `tidyr`, `dplyr`, and `ggplot2`. (I'm working on moving from `ggplot2` to `ggvis` but the latter is still lacking some plotting functionality. `ggvis` should be ready to replace and extend `ggplot2` in a year or so.). These three packages facilitate nearly all of the tasks that I normally do to get data prepped for analysis.

To begin, run the following code:

```r
library(tidyr)
library(dplyr)
library(ggplot2)
```

If you get an error, you will need to install the missing packages. Click on the **Packages** tab in R Studio, then click **Install** and type the name of the missing package in the dialog box. Once you have it installed, run the above code again

###Loading Data
Now that you have your libraries initialized, it's time to load your dataset. If you have downloaded the most recent project, you should be able to run the following code:




```r
pitching <- read.csv("data/FanGraphs_StandardPitching_2014.csv", stringsAsFactors = F)
pitching <- tbl_df(pitching)
```

The `read.csv` command should be familiar. This particular version includes an additional keyword/argument -- `stringsAsFactors = F`. If you do not add this, R will import every column it reads as a character column as a factor. While this may be useful for some analysis, it often makes things difficult and it is easy to convert variables to factors later. It is a good habit to always load .CSV data using this keyword/argument pair.

###Inspecting Data
Now that you have your data loaded, it's time to inpect it to make sure it was imported properly. There are several ways to do this and R studio provides a more familiar way as well. 

The easiest way is to visually inspect the data by clicking on the **Environment** tab and then double-clicking on the `pitching` object that is visible. This should bring up a new tab that displays the dataframe in a familiar Excel-like form. You cannot operate on the data in this window. You can only visually inspect it. The most recent version of R Studio actually lets you sort by columns with a simple click, but that isn't always useful.

A second way to inspect the data is to ask R to print the dataframe to the console. You can do this by running the following code. 

```r
pitching
```

```
## Source: local data frame [692 x 20]
## 
##           ï..Name      Team W L SV G GS  IP   K.9 BB.9 HR.9 BABIP    LOB.
## 1  J.P. Arencibia   Rangers 0 0  0 1  0 1.0  0.00 0.00    0 0.250 100.0 %
## 2     Pedro Beato    Braves 0 0  0 3  0 4.1  6.23 6.23    0 0.231 100.0 %
## 3   Curtis Partch      Reds 1 0  0 6  0 7.0  7.71 9.00    0 0.118 100.0 %
## 4    Lyle Overbay   Brewers 0 0  0 1  0 0.1  0.00 0.00    0 0.000 100.0 %
## 5      Joe Savery Athletics 0 0  0 3  0 4.0  0.00 2.25    0 0.214 100.0 %
## 6   Drake Britton   Red Sox 0 0  0 7  0 6.2  5.40 2.70    0 0.238 100.0 %
## 7  Mitch Moreland   Rangers 0 0  0 1  0 1.0  0.00 0.00    0 0.000 100.0 %
## 8  Skip Schumaker      Reds 0 0  0 1  0 1.0  0.00 9.00    0 0.000 100.0 %
## 9     Kyle Drabek Blue Jays 0 0  0 2  0 3.0 15.00 6.00    0 0.333 100.0 %
## 10 Steve Tolleson Blue Jays 0 0  0 2  0 1.0  9.00 0.00    0 0.333 100.0 %
## ..            ...       ... . . .. . .. ...   ...  ...  ...   ...     ...
## Variables not shown: GB. (chr), HR.FB (chr), ERA (dbl), FIP (dbl), xFIP
##   (dbl), WAR (dbl), playerid (int)
```
Check that your data frame looks similar to this. You'll notice R displays the first 10 rows of a subset of the columns. This is because we ran the `tbl_df()` command when we loaded the data. The `tbl_df()` command adds some programming attributes to the table that make it a little easier to work with. One of the things it makes easier is viewing data in the console. It only shows a subset of the data that fits in the window.If there are different columns displaying in your console than in this document, try changing the width of your console window.

This view is useful because you start to get an idea of what the data looks like. For variables that are not shown, you can also see what datatypes are in the variables.

If you want to see a small sample of all of the variables, you can run the following code:

```r
head(pitching, 3)
```

```
## Source: local data frame [3 x 20]
## 
##          ï..Name    Team W L SV G GS  IP  K.9 BB.9 HR.9 BABIP    LOB.
## 1 J.P. Arencibia Rangers 0 0  0 1  0 1.0 0.00 0.00    0 0.250 100.0 %
## 2    Pedro Beato  Braves 0 0  0 3  0 4.1 6.23 6.23    0 0.231 100.0 %
## 3  Curtis Partch    Reds 1 0  0 6  0 7.0 7.71 9.00    0 0.118 100.0 %
## Variables not shown: GB. (chr), HR.FB (chr), ERA (dbl), FIP (dbl), xFIP
##   (dbl), WAR (dbl), playerid (int)
```

```r
tail(pitching, 3)
```

```
## Source: local data frame [3 x 20]
## 
##         ï..Name   Team W L SV G GS  IP K.9 BB.9 HR.9 BABIP   LOB.    GB.
## 1     Josh Wall Angels 0 0  0 2  0 1.0   0 27.0  0.0 0.625 25.0 %  0.0 %
## 2   Trevor Bell   Reds 0 0  0 2  0 0.2   0 27.0  0.0 0.714 28.6 % 42.9 %
## 3 Donnie Joseph Royals 0 0  0 1  0 0.2  27 13.5 13.5 1.000  0.0 % 60.0 %
## Variables not shown: HR.FB (chr), ERA (dbl), FIP (dbl), xFIP (dbl), WAR
##   (dbl), playerid (int)
```

`head()` and `tail()` prints the first(last) X number of rows to the console. In the code above, `head()` prints the first 3 observations and `tail()` prints the last 3 observations. This is good, but its a bit messy. We need a better way to inspect data and datatypes in the console.

We want to see what all of our variables are classified as and what the first few observations of each look like. To do this, run the following command:


```r
glimpse(pitching)
```

```
## Observations: 692
## Variables:
## $ ï..Name  (chr) "J.P. Arencibia", "Pedro Beato", "Curtis Partch", "Ly...
## $ Team     (chr) "Rangers", "Braves", "Reds", "Brewers", "Athletics", ...
## $ W        (int) 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0,...
## $ L        (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
## $ SV       (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0,...
## $ G        (int) 1, 3, 6, 1, 3, 7, 1, 1, 2, 2, 1, 2, 1, 1, 1, 9, 1, 1,...
## $ GS       (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
## $ IP       (dbl) 1.0, 4.1, 7.0, 0.1, 4.0, 6.2, 1.0, 1.0, 3.0, 1.0, 1.0...
## $ K.9      (dbl) 0.00, 6.23, 7.71, 0.00, 0.00, 5.40, 0.00, 0.00, 15.00...
## $ BB.9     (dbl) 0.00, 6.23, 9.00, 0.00, 2.25, 2.70, 0.00, 9.00, 6.00,...
## $ HR.9     (dbl) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
## $ BABIP    (dbl) 0.250, 0.231, 0.118, 0.000, 0.214, 0.238, 0.000, 0.00...
## $ LOB.     (chr) "100.0 %", "100.0 %", "100.0 %", "100.0 %", "100.0 %"...
## $ GB.      (chr) "25.0 %", "23.1 %", "41.2 %", "0.0 %", "50.0 %", "33....
## $ HR.FB    (chr) "0.0 %", "0.0 %", "0.0 %", "0.0 %", "0.0 %", "0.0 %",...
## $ ERA      (dbl) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
## $ FIP      (dbl) 3.13, 3.82, 4.42, 3.13, 3.88, 2.83, 3.13, 6.13, 1.80,...
## $ xFIP     (dbl) 6.84, 6.11, 5.65, 6.84, 5.43, 4.50, 4.37, 8.60, 3.86,...
## $ WAR      (dbl) 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.0, 0.1, 0.0, 0.0...
## $ playerid (int) 697, 1330, 1333, 1617, 2835, 2868, 3086, 3704, 4359, ...
```
When you do this, you should now see all of the variable names down the left hand side of your screen. Next to each variable (column) name, you should see the datatype in parenthesis. After the datatype[^1], you should see a few observations from each column.


[^1]: It's important to know the abbreviations for each datatype in R. in this dataset, you have the following datatypes: `chr`, `int`, and `dbl`. `chr` stands for **character** and tells you that R is reading that column as a list of words. `int` stands for **integer** and tells you that R is reading the column as a list of integers. `dbl` stands for **double-precision floating point** and tells you that R is reading that as a column of numeric variables that require more precision than an integer (i.e., there are decimals present).

    Other datatypes include **factor**, **datetime**, and **boolean**.

As you look through the output, take notice of how each column is classified. Are there any columns that look incorrect? 

Hopefully you identified that `LOB.`, `GB.`, and `HR.FB` are all classified as **character** variables when they should be **floating point**. This happened because there are the `%` sign in the raw data. Since this doesn't have a numeric value, R defaulted to loading the column as text instead of numeric. We'll come back to fixing this in a bit.

Another simple thing to inspect are the column names. In this case, most of the column names make sense. They are easy to understand and easy to type. There is one that looks like it might give us a problem: `i..Name`. It may be fine, but it will be better to rename this column `pitcher.name` to make the dataset and your code easier to read. 

It is extremely important to have informative and simple to understand column names. The primary reason for this is that is makes your code much easier to read if you share it with someone else or if you have to step away from it for a while. As you are building out your code, always think of two things: Does it work now? and Will it be easy for my to come back to it in a few weeks?

###Grammar of Data Manipulation
When starting to think about how to study data, it's useful to have a framework in mind. If you think about dealing with 2 dimensional data, there are really two broad categories of operations. You can operate on either columns or rows. If you want to do anything more complex than that, you can almost always break it down into a series of operations on columns and rows as well.

`dplyr` is a package written to facilitate data maniuplation with this framework in mind. There are three main column operations `select()`, `rename()`, and `mutate()`. And, there are two main row operations `filter()`, and `arrange()`.

####Column Operations

#####`select()`
We're going to start with column operations, specifically the `select()` function. `select()` takes at least two arguments and returns a data frame. In the most basic terms, `select()` subsets a dataframe by selecting specific columns. It is as simple as that. Try the following code to see what happens when we apply the `select()` function on our `pitching` dataframe:

```r
teams <- select(pitching, Team)
teams
```

```
## Source: local data frame [692 x 1]
## 
##         Team
## 1    Rangers
## 2     Braves
## 3       Reds
## 4    Brewers
## 5  Athletics
## 6    Red Sox
## 7    Rangers
## 8       Reds
## 9  Blue Jays
## 10 Blue Jays
## ..       ...
```

If you look in your **Environment** tab, you should see a new data object named `teams`. This is just a subset of the original `pitching` dataframe. We can test that the column in the `pitching` dataframe is identical to the column in the `teams` data frame by running the following code:

```r
all(teams == pitching$Team)
```

```
## [1] TRUE
```

`all()` is a logical test that asks: given a set of logical vectors, are all values TRUE? `teams == pitching$Team` asks if the value in identical positions between the `teams` dataframe and the `Team` column in the `pitching` dataframe are identical. Because the result of this test is TRUE, we know that the two columns are identical.

There are many ways to choose a subset of columns using the `select()` function from `dplyr`. `dplyr` comes with built in helper functions to help minimize the amount of typing required to get the exact columns that you need. 

* `contains("")` - selects columns whose name contains a specific character string
* `ends_with("")` - select columns whose name ends with a specific character string
* `everything()` - selects every column
* `matches("")` - select columns who name matches a [regular expression](http://en.wikipedia.org/wiki/Regular_expression)
* `num_range("", 1:5)` - select columns named with same character and sequential numerical pattern
* `one_of(c("",""))` - selects columns whose names are in a group of names
* `starts_with("")` - selects columns whose name starts with a character string
* `select(df, -COL)` - selects all but a columns

#####`rename()`
`rename()` takes two arguments, a dataset and a pattern to rename columns. As mentioned before, there are some major benefits to having good column names. In addition to the ones mentioned ealier, you can hopefully see how good column naming conventions can help make using the `select()` function much easier through the application of the helper functions listed above. 

Sometimes data doesn't come labelled with strong column naming conventions. In that case, it is necessary to rename the columns. Remember, we're renaming columns to:
1. Make our code easier to read
2. Improve our use of the `select()` function
3. Have a more informative dataset to work with.

A good habit to get into when renaming columns is to use periods in names. R likes periods and it makes using things like the helper functions and tab complete much easier. Before renaming all of your columns, you want to create a taxonomy of variables in your dataset. Doing this on the almighty piece of paper is usually the best place to start. 

To get started with this, let's take another look at the current names we have for our variables:

```r
glimpse(pitching)
```

```
## Observations: 692
## Variables:
## $ ï..Name  (chr) "J.P. Arencibia", "Pedro Beato", "Curtis Partch", "Ly...
## $ Team     (chr) "Rangers", "Braves", "Reds", "Brewers", "Athletics", ...
## $ W        (int) 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0,...
## $ L        (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
## $ SV       (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0,...
## $ G        (int) 1, 3, 6, 1, 3, 7, 1, 1, 2, 2, 1, 2, 1, 1, 1, 9, 1, 1,...
## $ GS       (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
## $ IP       (dbl) 1.0, 4.1, 7.0, 0.1, 4.0, 6.2, 1.0, 1.0, 3.0, 1.0, 1.0...
## $ K.9      (dbl) 0.00, 6.23, 7.71, 0.00, 0.00, 5.40, 0.00, 0.00, 15.00...
## $ BB.9     (dbl) 0.00, 6.23, 9.00, 0.00, 2.25, 2.70, 0.00, 9.00, 6.00,...
## $ HR.9     (dbl) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
## $ BABIP    (dbl) 0.250, 0.231, 0.118, 0.000, 0.214, 0.238, 0.000, 0.00...
## $ LOB.     (chr) "100.0 %", "100.0 %", "100.0 %", "100.0 %", "100.0 %"...
## $ GB.      (chr) "25.0 %", "23.1 %", "41.2 %", "0.0 %", "50.0 %", "33....
## $ HR.FB    (chr) "0.0 %", "0.0 %", "0.0 %", "0.0 %", "0.0 %", "0.0 %",...
## $ ERA      (dbl) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
## $ FIP      (dbl) 3.13, 3.82, 4.42, 3.13, 3.88, 2.83, 3.13, 6.13, 1.80,...
## $ xFIP     (dbl) 6.84, 6.11, 5.65, 6.84, 5.43, 4.50, 4.37, 8.60, 3.86,...
## $ WAR      (dbl) 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.0, 0.1, 0.0, 0.0...
## $ playerid (int) 697, 1330, 1333, 1617, 2835, 2868, 3086, 3704, 4359, ...
```
It looks like we can group these columns into two major categories (could it be more?) - demographic and statistics. A good way to start renaming these variables is to put a descriptive group prefix in front of them. In this case, I'm going to use `demo.` for demographic variables and `stats.` for statistics variables. Let's start by renaming a single variable:

```r
rename(pitching, demo.name = `ï..Name`)
```

```
## Source: local data frame [692 x 20]
## 
##         demo.name      Team W L SV G GS  IP   K.9 BB.9 HR.9 BABIP    LOB.
## 1  J.P. Arencibia   Rangers 0 0  0 1  0 1.0  0.00 0.00    0 0.250 100.0 %
## 2     Pedro Beato    Braves 0 0  0 3  0 4.1  6.23 6.23    0 0.231 100.0 %
## 3   Curtis Partch      Reds 1 0  0 6  0 7.0  7.71 9.00    0 0.118 100.0 %
## 4    Lyle Overbay   Brewers 0 0  0 1  0 0.1  0.00 0.00    0 0.000 100.0 %
## 5      Joe Savery Athletics 0 0  0 3  0 4.0  0.00 2.25    0 0.214 100.0 %
## 6   Drake Britton   Red Sox 0 0  0 7  0 6.2  5.40 2.70    0 0.238 100.0 %
## 7  Mitch Moreland   Rangers 0 0  0 1  0 1.0  0.00 0.00    0 0.000 100.0 %
## 8  Skip Schumaker      Reds 0 0  0 1  0 1.0  0.00 9.00    0 0.000 100.0 %
## 9     Kyle Drabek Blue Jays 0 0  0 2  0 3.0 15.00 6.00    0 0.333 100.0 %
## 10 Steve Tolleson Blue Jays 0 0  0 2  0 1.0  9.00 0.00    0 0.333 100.0 %
## ..            ...       ... . . .. . .. ...   ...  ...  ...   ...     ...
## Variables not shown: GB. (chr), HR.FB (chr), ERA (dbl), FIP (dbl), xFIP
##   (dbl), WAR (dbl), playerid (int)
```
When you run this code, notice that the first column is now named `demo.name` instead of `ï..Name`. To rename columns, you use the pattern: `new.name = old.name`.

If we try and print `pitching` to the console again:

```r
pitching
```

```
## Source: local data frame [692 x 20]
## 
##           ï..Name      Team W L SV G GS  IP   K.9 BB.9 HR.9 BABIP    LOB.
## 1  J.P. Arencibia   Rangers 0 0  0 1  0 1.0  0.00 0.00    0 0.250 100.0 %
## 2     Pedro Beato    Braves 0 0  0 3  0 4.1  6.23 6.23    0 0.231 100.0 %
## 3   Curtis Partch      Reds 1 0  0 6  0 7.0  7.71 9.00    0 0.118 100.0 %
## 4    Lyle Overbay   Brewers 0 0  0 1  0 0.1  0.00 0.00    0 0.000 100.0 %
## 5      Joe Savery Athletics 0 0  0 3  0 4.0  0.00 2.25    0 0.214 100.0 %
## 6   Drake Britton   Red Sox 0 0  0 7  0 6.2  5.40 2.70    0 0.238 100.0 %
## 7  Mitch Moreland   Rangers 0 0  0 1  0 1.0  0.00 0.00    0 0.000 100.0 %
## 8  Skip Schumaker      Reds 0 0  0 1  0 1.0  0.00 9.00    0 0.000 100.0 %
## 9     Kyle Drabek Blue Jays 0 0  0 2  0 3.0 15.00 6.00    0 0.333 100.0 %
## 10 Steve Tolleson Blue Jays 0 0  0 2  0 1.0  9.00 0.00    0 0.333 100.0 %
## ..            ...       ... . . .. . .. ...   ...  ...  ...   ...     ...
## Variables not shown: GB. (chr), HR.FB (chr), ERA (dbl), FIP (dbl), xFIP
##   (dbl), WAR (dbl), playerid (int)
```

Notice that the column name is back to the old name `ï..Name`. This is because we only operated on `pitching` in memory, we didn't update the memory. To update `pitching` so that it keeps the correct new variable name, run the following:

```r
pitching <- rename(pitching, demo.name = `ï..Name`)
```
Now, we can go through and update the rest of the variable names to make them more appropriate by replicating the same code for each existing column name and each new name. This gets a bit tedious and there is a lot of extra typing that needs to happen. Forutnately, the `dplyr` package allows you to enter multiple renaming actions in the `rename()` and other functions. Try the following:

```r
pitching <- rename(pitching, demo.team = Team,
                   stat.win = W,
                   stat.loss = L,
                   stat.save = SV,
                   stat.games = G,
                   stat.starts = GS,
                   stat.innings = IP,
                   stat.Kper9 = K.9,
                   stat.BBper9 = BB.9,
                   stat.HRper9 = HR.9,
                   stat.BBperIP = BABIP,
                   stat.leftonbase = LOB.,
                   stat.batted = GB., #Is this right?
                   stat.HR.FB = HR.FB, #What is this?
                   stat.ERA = ERA,
                   stat.FIP = FIP, #?
                   stat.XFIP = xFIP,
                   stat.WAR = WAR,
                   demo.id = playerid)

glimpse(pitching)
```

```
## Observations: 692
## Variables:
## $ demo.name       (chr) "J.P. Arencibia", "Pedro Beato", "Curtis Partc...
## $ demo.team       (chr) "Rangers", "Braves", "Reds", "Brewers", "Athle...
## $ stat.win        (int) 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1...
## $ stat.loss       (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.save       (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1...
## $ stat.games      (int) 1, 3, 6, 1, 3, 7, 1, 1, 2, 2, 1, 2, 1, 1, 1, 9...
## $ stat.starts     (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.innings    (dbl) 1.0, 4.1, 7.0, 0.1, 4.0, 6.2, 1.0, 1.0, 3.0, 1...
## $ stat.Kper9      (dbl) 0.00, 6.23, 7.71, 0.00, 0.00, 5.40, 0.00, 0.00...
## $ stat.BBper9     (dbl) 0.00, 6.23, 9.00, 0.00, 2.25, 2.70, 0.00, 9.00...
## $ stat.HRper9     (dbl) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.BBperIP    (dbl) 0.250, 0.231, 0.118, 0.000, 0.214, 0.238, 0.00...
## $ stat.leftonbase (chr) "100.0 %", "100.0 %", "100.0 %", "100.0 %", "1...
## $ stat.batted     (chr) "25.0 %", "23.1 %", "41.2 %", "0.0 %", "50.0 %...
## $ stat.HR.FB      (chr) "0.0 %", "0.0 %", "0.0 %", "0.0 %", "0.0 %", "...
## $ stat.ERA        (dbl) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.FIP        (dbl) 3.13, 3.82, 4.42, 3.13, 3.88, 2.83, 3.13, 6.13...
## $ stat.XFIP       (dbl) 6.84, 6.11, 5.65, 6.84, 5.43, 4.50, 4.37, 8.60...
## $ stat.WAR        (dbl) 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.0, 0.1, 0...
## $ demo.id         (int) 697, 1330, 1333, 1617, 2835, 2868, 3086, 3704,...
```
After we run `glimpse()` on the data again, you should be able to see slightly more informative column names that will make your code easier to read and `select()` easier to use as well.

I use `rename()` almost every single time I load a data set. It really helps me keep everything organized and it forces me to think about what underlying types and groups of variables exist in the data set. This helps with understanding and brainstorming types of analysis. 

If you have a hierarchy (or nested taxonomy) of variables, try this type of naming: `grandparent.parent.child` where each successive name gets slightly more granular. Sometimes these get long, but I assure you, it will make your life easier in the long run.

#####`mutate()`
After you have renamed your columns and subsetted your data, you are going to need to either edit exising variables or create new variables. To do this, we are going to use the `mutate()` function from `dplyr`. This is the function that I use the most when working with data.

The first way I use `mutate()` is to reformat existing variables to get them into the proper datatype for analysis. Remember earlier when we identified three variables that should be numeric, but are stored as characters? These are `stat.leftonbase`, `stat.batted`, `stat.HR.FB`. We need to convert these from character variables to numeric float variables. To do this, let's try to use one of R's built in functions `as.numeric()`:

```r
glimpse(mutate(pitching, stat.leftonbase = as.numeric(stat.leftonbase)))
```

```
## Warning in mutate_impl(.data, dots): NAs introduced by coercion
```

```
## Observations: 692
## Variables:
## $ demo.name       (chr) "J.P. Arencibia", "Pedro Beato", "Curtis Partc...
## $ demo.team       (chr) "Rangers", "Braves", "Reds", "Brewers", "Athle...
## $ stat.win        (int) 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1...
## $ stat.loss       (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.save       (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1...
## $ stat.games      (int) 1, 3, 6, 1, 3, 7, 1, 1, 2, 2, 1, 2, 1, 1, 1, 9...
## $ stat.starts     (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.innings    (dbl) 1.0, 4.1, 7.0, 0.1, 4.0, 6.2, 1.0, 1.0, 3.0, 1...
## $ stat.Kper9      (dbl) 0.00, 6.23, 7.71, 0.00, 0.00, 5.40, 0.00, 0.00...
## $ stat.BBper9     (dbl) 0.00, 6.23, 9.00, 0.00, 2.25, 2.70, 0.00, 9.00...
## $ stat.HRper9     (dbl) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.BBperIP    (dbl) 0.250, 0.231, 0.118, 0.000, 0.214, 0.238, 0.00...
## $ stat.leftonbase (dbl) NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA...
## $ stat.batted     (chr) "25.0 %", "23.1 %", "41.2 %", "0.0 %", "50.0 %...
## $ stat.HR.FB      (chr) "0.0 %", "0.0 %", "0.0 %", "0.0 %", "0.0 %", "...
## $ stat.ERA        (dbl) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.FIP        (dbl) 3.13, 3.82, 4.42, 3.13, 3.88, 2.83, 3.13, 6.13...
## $ stat.XFIP       (dbl) 6.84, 6.11, 5.65, 6.84, 5.43, 4.50, 4.37, 8.60...
## $ stat.WAR        (dbl) 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.0, 0.1, 0...
## $ demo.id         (int) 697, 1330, 1333, 1617, 2835, 2868, 3086, 3704,...
```
If you do this, R gives you a warning message. If you look at the glimpsed data, you'll notice the `stat.leftonbase` variable only contains `NA`. In this case, R couldn't recognize what number it was supposed to convert the text to. To get the text to the proper number, we're going to have to do a bit of extra work. Try to run the following code:

```r
glimpse(mutate(pitching, 
               stat.leftonbase = as.numeric(
                   sub(" %", "", stat.leftonbase)
                   )/100
               )
        )
```

```
## Observations: 692
## Variables:
## $ demo.name       (chr) "J.P. Arencibia", "Pedro Beato", "Curtis Partc...
## $ demo.team       (chr) "Rangers", "Braves", "Reds", "Brewers", "Athle...
## $ stat.win        (int) 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1...
## $ stat.loss       (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.save       (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1...
## $ stat.games      (int) 1, 3, 6, 1, 3, 7, 1, 1, 2, 2, 1, 2, 1, 1, 1, 9...
## $ stat.starts     (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.innings    (dbl) 1.0, 4.1, 7.0, 0.1, 4.0, 6.2, 1.0, 1.0, 3.0, 1...
## $ stat.Kper9      (dbl) 0.00, 6.23, 7.71, 0.00, 0.00, 5.40, 0.00, 0.00...
## $ stat.BBper9     (dbl) 0.00, 6.23, 9.00, 0.00, 2.25, 2.70, 0.00, 9.00...
## $ stat.HRper9     (dbl) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.BBperIP    (dbl) 0.250, 0.231, 0.118, 0.000, 0.214, 0.238, 0.00...
## $ stat.leftonbase (dbl) 1.000, 1.000, 1.000, 1.000, 1.000, 1.000, 1.00...
## $ stat.batted     (chr) "25.0 %", "23.1 %", "41.2 %", "0.0 %", "50.0 %...
## $ stat.HR.FB      (chr) "0.0 %", "0.0 %", "0.0 %", "0.0 %", "0.0 %", "...
## $ stat.ERA        (dbl) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.FIP        (dbl) 3.13, 3.82, 4.42, 3.13, 3.88, 2.83, 3.13, 6.13...
## $ stat.XFIP       (dbl) 6.84, 6.11, 5.65, 6.84, 5.43, 4.50, 4.37, 8.60...
## $ stat.WAR        (dbl) 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.0, 0.1, 0...
## $ demo.id         (int) 697, 1330, 1333, 1617, 2835, 2868, 3086, 3704,...
```
This code looks a little complicated, but it's really quite simple. To understand it, we need to work from the inside-out.

First, we are running the `sub()` function on `stat.leftonbase`. The `sub()` function looks for a character string and substitues another character string. In this case, we are looking for `" $"` and replacing it with `""`. For this data, `100.0 %` becomes `100.0`. 

Next, we are converting `100.0` to a numeric value. Since there are no non-numeric characters remaining in this variable, R can do this in a straight forward manner.The `as.numeric()` function takes in a variable and tries to convert it to a numeric value. If R can't figure out what the numeric value is supposed to be, it converts it to an `NA` which is a missing value. It will also throw an error. If you get the same error as above, you know there are a few values that it couldn't figure out and you need to go through and check the raw data to identify the pattern necessary to convert.

Next we divide by 100. This is because we want to store percentages as their true decimal value. 

Next, we save the values we have just computed to the `stat.leftonbase` variable. Since this variable already existing, we save over it[^2]. We can create a new variable by replacing `stat.leftonbase` with a new variable name.

[^2]: We don't really save over it since we don't write over the exisiting data frame. If you were to call `glimpse(pitching)`, you would see that the old values are still there and the variable is still technically a character varaible.

We need to use this same process on the other two variables and we need to save the updated data frame. To do this, run the following code:


```r
pitching <- mutate(pitching, 
               stat.leftonbase = as.numeric(sub(" %", "", stat.leftonbase))/100,
               stat.batted = as.numeric(sub(" %", "", stat.batted))/100,
               stat.HR.FB = as.numeric(sub(" %", "", stat.HR.FB))/100
               )

glimpse(pitching)
```

```
## Observations: 692
## Variables:
## $ demo.name       (chr) "J.P. Arencibia", "Pedro Beato", "Curtis Partc...
## $ demo.team       (chr) "Rangers", "Braves", "Reds", "Brewers", "Athle...
## $ stat.win        (int) 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1...
## $ stat.loss       (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.save       (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1...
## $ stat.games      (int) 1, 3, 6, 1, 3, 7, 1, 1, 2, 2, 1, 2, 1, 1, 1, 9...
## $ stat.starts     (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.innings    (dbl) 1.0, 4.1, 7.0, 0.1, 4.0, 6.2, 1.0, 1.0, 3.0, 1...
## $ stat.Kper9      (dbl) 0.00, 6.23, 7.71, 0.00, 0.00, 5.40, 0.00, 0.00...
## $ stat.BBper9     (dbl) 0.00, 6.23, 9.00, 0.00, 2.25, 2.70, 0.00, 9.00...
## $ stat.HRper9     (dbl) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.BBperIP    (dbl) 0.250, 0.231, 0.118, 0.000, 0.214, 0.238, 0.00...
## $ stat.leftonbase (dbl) 1.000, 1.000, 1.000, 1.000, 1.000, 1.000, 1.00...
## $ stat.batted     (dbl) 0.250, 0.231, 0.412, 0.000, 0.500, 0.333, 0.33...
## $ stat.HR.FB      (dbl) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.ERA        (dbl) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.FIP        (dbl) 3.13, 3.82, 4.42, 3.13, 3.88, 2.83, 3.13, 6.13...
## $ stat.XFIP       (dbl) 6.84, 6.11, 5.65, 6.84, 5.43, 4.50, 4.37, 8.60...
## $ stat.WAR        (dbl) 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.0, 0.1, 0...
## $ demo.id         (int) 697, 1330, 1333, 1617, 2835, 2868, 3086, 3704,...
```
When you inspect the resulting dataframe, you should see that our three variables are now considered to be type `dbl`. This means that we can now do math on these variables if we want.

Another way I use `mutate()` is to create new variables. One variable that is not included in this data set, but that we can compute is the total number of outs a pitcher pitched. 

If we know the number of innings, we can compute the number of outs a pitcher pitched. The total outs a pitcher pitched can be computed as 3 times the whole number of the statistic plus the decimal point of the statistic. 

$$4.1 IP = 13 OUTS$$

$$3*4 + .1*10 = 13$$ 

If we want to compute the number of outs, we need to figure out how to break these two numbers apart so we can implement the equation within our `mutate()` function.

R (and all programming languages) have an arithmetic operations called modulo and integer division. Modulo divides two numbers and, instead of using decimal points, returns the remainder after all of the integers have been divided. where 5/2 is 2.5, 5 modulo 2 is 1. 9 modulo 5 is 4. The modulo operator in R is `%%`. Let's try a few to get the hang of it.


```r
5%%2
```

```
## [1] 1
```

```r
9%%5
```

```
## [1] 4
```

```r
1234%%1
```

```
## [1] 0
```
Related to modulo division is integer division. Integer division returns the integer portion of the same operation. For example, if we did 5 int div 2, it would return 2. 9 int div 5 returns 1. The integer division operator in R is `%/%`. Let's try a few to get the hang of it:


```r
5%/%2
```

```
## [1] 2
```

```r
9%/%5
```

```
## [1] 1
```

```r
1234%/%2
```

```
## [1] 617
```

How can we apply modulo and integer division to the `stat.innings` variable to compute the total numer of outs a pitcher has pitched? *Remember, the formula is the number on the left of the decimal point times three plus the number on the right of the decimal point.*


```r
4.1%/%1
```

```
## [1] 4
```

```r
4.1%%1
```

```
## [1] 0.1
```

```r
4.1%/%1 * 3 + 4.1%%1*10
```

```
## [1] 13
```
It looks like using 1 helps get us exactly what we need! Now, let's apply this to the dataframe and compute a new variable, `stat.outs`.

```r
pitching <- mutate(pitching, stat.outs = stat.innings%/%1*3 + stat.innings%%1*10)
glimpse(pitching)
```

```
## Observations: 692
## Variables:
## $ demo.name       (chr) "J.P. Arencibia", "Pedro Beato", "Curtis Partc...
## $ demo.team       (chr) "Rangers", "Braves", "Reds", "Brewers", "Athle...
## $ stat.win        (int) 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1...
## $ stat.loss       (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.save       (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1...
## $ stat.games      (int) 1, 3, 6, 1, 3, 7, 1, 1, 2, 2, 1, 2, 1, 1, 1, 9...
## $ stat.starts     (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.innings    (dbl) 1.0, 4.1, 7.0, 0.1, 4.0, 6.2, 1.0, 1.0, 3.0, 1...
## $ stat.Kper9      (dbl) 0.00, 6.23, 7.71, 0.00, 0.00, 5.40, 0.00, 0.00...
## $ stat.BBper9     (dbl) 0.00, 6.23, 9.00, 0.00, 2.25, 2.70, 0.00, 9.00...
## $ stat.HRper9     (dbl) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.BBperIP    (dbl) 0.250, 0.231, 0.118, 0.000, 0.214, 0.238, 0.00...
## $ stat.leftonbase (dbl) 1.000, 1.000, 1.000, 1.000, 1.000, 1.000, 1.00...
## $ stat.batted     (dbl) 0.250, 0.231, 0.412, 0.000, 0.500, 0.333, 0.33...
## $ stat.HR.FB      (dbl) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.ERA        (dbl) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.FIP        (dbl) 3.13, 3.82, 4.42, 3.13, 3.88, 2.83, 3.13, 6.13...
## $ stat.XFIP       (dbl) 6.84, 6.11, 5.65, 6.84, 5.43, 4.50, 4.37, 8.60...
## $ stat.WAR        (dbl) 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.0, 0.1, 0...
## $ demo.id         (int) 697, 1330, 1333, 1617, 2835, 2868, 3086, 3704,...
## $ stat.outs       (dbl) 3, 13, 21, 1, 12, 20, 3, 3, 9, 3, 3, 2, 3, 3, ...
```
####Row Operations

There are two main functions that operate on rows: `filter()` and `arrange()`. You can think of `arrange()` as a sort function that re-arranges the rows in a dataframe by some column in either ascending or descending order.I rarely use this but it is sometimes useful.

The `filter()` function subsets the dataset using rows. I use this to create subsets where it selects all the rows in a data set where the value in a column follows some logical operation. 

The logical operations can be found on the cheat sheet. This is only going to cover a few of them just to get the idea of what is going on. 

To test this out, lets select just the Chicago Cubs players from the data set and create a new dataframe. To do this, run the following code:

```r
chicago.cubs <- filter(pitching, demo.team == "Cubs")
glimpse(chicago.cubs)
```

```
## Observations: 20
## Variables:
## $ demo.name       (chr) "John Baker", "Neil Ramirez", "Eric Jokisch", ...
## $ demo.team       (chr) "Cubs", "Cubs", "Cubs", "Cubs", "Cubs", "Cubs"...
## $ stat.win        (int) 1, 3, 0, 2, 4, 7, 10, 0, 4, 0, 5, 2, 5, 0, 8, ...
## $ stat.loss       (int) 0, 3, 0, 4, 4, 2, 5, 3, 4, 2, 2, 3, 7, 0, 13, ...
## $ stat.save       (int) 0, 3, 0, 2, 29, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, ...
## $ stat.games      (int) 1, 50, 4, 65, 64, 13, 25, 58, 13, 2, 73, 61, 4...
## $ stat.starts     (int) 0, 0, 1, 0, 0, 13, 25, 0, 13, 2, 0, 0, 5, 0, 3...
## $ stat.innings    (dbl) 1.0, 43.2, 14.1, 61.0, 63.1, 80.1, 156.2, 48.1...
## $ stat.Kper9      (dbl) 0.00, 10.92, 6.28, 10.48, 8.95, 5.27, 9.59, 6....
## $ stat.BBper9     (dbl) 9.00, 3.50, 2.51, 3.69, 2.13, 1.68, 2.36, 3.54...
## $ stat.HRper9     (dbl) 0.00, 0.41, 1.88, 0.30, 0.28, 0.45, 0.29, 0.37...
## $ stat.BBperIP    (dbl) 0.000, 0.262, 0.306, 0.268, 0.286, 0.271, 0.27...
## $ stat.leftonbase (dbl) 1.000, 0.819, 0.899, 0.755, 0.717, 0.785, 0.74...
## $ stat.batted     (dbl) 0.500, 0.260, 0.510, 0.550, 0.492, 0.478, 0.49...
## $ stat.HR.FB      (dbl) 0.000, 0.038, 0.231, 0.069, 0.041, 0.049, 0.04...
## $ stat.ERA        (dbl) 0.00, 1.44, 1.88, 2.21, 2.42, 2.46, 2.53, 3.17...
## $ stat.FIP        (dbl) 6.13, 2.61, 5.30, 2.66, 2.26, 3.32, 2.26, 3.44...
## $ stat.XFIP       (dbl) 7.37, 3.48, 3.70, 2.82, 2.81, 3.92, 2.73, 3.80...
## $ stat.WAR        (dbl) 0.0, 0.8, -0.2, 1.1, 1.6, 1.6, 5.1, 0.3, 0.9, ...
## $ demo.id         (int) 4756, 7677, 11157, 4070, 2391, 12049, 4153, 59...
## $ stat.outs       (dbl) 3, 131, 43, 183, 190, 241, 470, 145, 208, 33, ...
```
Notice that running `glimpse()` on this dataframe, we see that there are only 20 observations. Each of these observations has the same value, `"Cubs"` in the `demo.team` column. 

What if we wanted to select all BUT the Cubs pitchers?


```r
not.cubs <- filter(pitching, demo.team != "Cubs")
glimpse(not.cubs)
```

```
## Observations: 672
## Variables:
## $ demo.name       (chr) "J.P. Arencibia", "Pedro Beato", "Curtis Partc...
## $ demo.team       (chr) "Rangers", "Braves", "Reds", "Brewers", "Athle...
## $ stat.win        (int) 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0...
## $ stat.loss       (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.save       (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0...
## $ stat.games      (int) 1, 3, 6, 1, 3, 7, 1, 1, 2, 2, 2, 1, 1, 1, 9, 1...
## $ stat.starts     (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.innings    (dbl) 1.0, 4.1, 7.0, 0.1, 4.0, 6.2, 1.0, 1.0, 3.0, 1...
## $ stat.Kper9      (dbl) 0.00, 6.23, 7.71, 0.00, 0.00, 5.40, 0.00, 0.00...
## $ stat.BBper9     (dbl) 0.00, 6.23, 9.00, 0.00, 2.25, 2.70, 0.00, 9.00...
## $ stat.HRper9     (dbl) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.BBperIP    (dbl) 0.250, 0.231, 0.118, 0.000, 0.214, 0.238, 0.00...
## $ stat.leftonbase (dbl) 1.000, 1.000, 1.000, 1.000, 1.000, 1.000, 1.00...
## $ stat.batted     (dbl) 0.250, 0.231, 0.412, 0.000, 0.500, 0.333, 0.33...
## $ stat.HR.FB      (dbl) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.ERA        (dbl) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
## $ stat.FIP        (dbl) 3.13, 3.82, 4.42, 3.13, 3.88, 2.83, 3.13, 6.13...
## $ stat.XFIP       (dbl) 6.84, 6.11, 5.65, 6.84, 5.43, 4.50, 4.37, 8.60...
## $ stat.WAR        (dbl) 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.0, 0.1, 0...
## $ demo.id         (int) 697, 1330, 1333, 1617, 2835, 2868, 3086, 3704,...
## $ stat.outs       (dbl) 3, 13, 21, 1, 12, 20, 3, 3, 9, 3, 2, 3, 3, 3, ...
```
Notice that there are 672 observations in this table. This is excatly 20 (the number of Cubs pitchers) less than the total number of pitchers in the data set.


