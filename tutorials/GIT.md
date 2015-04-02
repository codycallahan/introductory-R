Getting Started with Git Using This Project
===

Git is a powerful tool for facilitating collaboration in an easy and meaningful way. Unfortunately, there is a bit of a learning curve in getting up and running.

Fortunately, we can use this project to get familiar with the concepts and start to build a workflow. While we will not necessarily be working creating a single project, the same principles apply

Here are the steps we are going to take. Each one is explained in more detail below.

1. Project lead creates master repository on github
2. Collaborators login and fork the repository
3. Everyone clones their repository locally (create an R Project)
4. Add a remote link back to the master repository
5. Each collaborator creates a branch that he/she will work on
6. Edits are made to the branch and pushed to the master
7. Once edits are made, a pull request is made and Project lead validates the work
8. Collaborators do some branch maintenance
9. Collaborators sync thier fork

Because of the nature of the project, we won't be using all of these steps. If you want more detail on this exact workflow, check out this [explanation](http://blog.scottlowe.org/2015/01/27/using-fork-branch-git-workflow/).

###Step 1
To get started collaborating with Git, we first need to create a parent project. I have done this with this git repository. I have created this repository which can be found [here](https://github.com/bradleyfay/introductory-R)

* Login to your Github account
* Navigate to the link above
* click **Fork**

You should now have forked the main repository to your account. The next thing we need to do is clone the project locally.

###Step 2
To clone the project locally, we can either use git from the command line or open up R Studio and start a new project. For this, we're going to do the latter.

* Open R Studio
* Create a New Project
* Choose the third option, Version Control
* select Git
* Copy the clone url from your github fork. It should look something like: `https://github.com/bradleyfay/introductory-R.git` where `bradleyfay` is replaced with your username
* Choose the directory on your computer where you want to store your project
* Click OK

You should now have an R Studio Project open on your desktop. It should have the files that are in the repository you forked. Check out the **files** tab in R Studio to make sure there are some contents.

###Step 3
Now that we have the master repository forked and cloned, we need to hook the project back to the original project. 

* Click on the **Git** tab in R Studio
* Choose the **More** option
* Select **Shell** or **Terminal**

From there, a terminal/shell window should open. type the following
```git remote add upstream https://github.com/bradleyfay/introductory-R.git```

* `git clone`
* `git status`
* `git add`
* `git commit -m ""`
* `git push`
* `git branch`
* `git checkout`
* `git merge`