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
```
git remote add upstream https://github.com/bradleyfay/introductory-R.git
```

Once you've done this, you've connected your copy of the project back to the original. The next step is to create a branch that you work on which won't conflict with your teammates.

###step 4
To create a branch, we are going to stay in the terminal window. If you closed the terminal, follow the instructions in Step 3 to get the terminal window back.

With the terminal open, type the following:

```
git checkout -b [branch-name]
```

where you replace `[branch-name]` with the unique name of your branch. For this project, use your last name.

At this point, you can code away. Feel free to create your own files and folders. Basically whatever you need to do to complete your work.

When you are done with your work and want to share it with others, proceed to step 5.

###Step 5
Now that you have done some work, you need it to be double checked. To do this, follow these instructions in R Studio:

* Select the **Git** tab in R Studio
* Check the boxes for the files you want to send to the main project
* click the **Committ** button, a window will pop up.
* Type a short message in the *Commit Message* box on the right. This should explicitly say what you are adding.
* When you are done with your message, click **commit**
* You can add unique messages for each file and I encourage you to do so.
* When you have made all your commitments, you need to **Push** your work to the main repository. Click the **PUSH** button
* You will be prompted for your Github username and password. Enter those
* If successful, you will get a message indicating the repository you pushed the changes to. Make sure that it is the master repository `https://github.com/bradleyfay/introductory-R.git`.

If it pushes to your forked repository, you will have to push changes through the terminal. This is pretty straight forward, to do after you have made all your commits through R Studio.

Follow the instructions in Step 3 to open your terminal window. Run the following command: 
```
git push origin [branch-name]
```

This should push all of your changes to the master repository and the project lead can review the changes.

###Step 6
In this project, I will be updating the master repository with new data sets and scripts. You will need to keep your forked repository up to date. 

To do this through R Studio, click the **PULL** button on the **GIT** tab. Check that the files you pulled are from the parent project: `https://github.com/bradleyfay/introductory-R.git`

If they are not, you will have to go through the terminal. To do this, follow the instructions in step three to open the terminal window. From there, type the following: 
```
git pull upstream master
git push origin master
```

After running these two commands, you should be up-to-date with the information I have put to the master repository.