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

If you want to see a sample of all of the variables, you can run the following code:

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
