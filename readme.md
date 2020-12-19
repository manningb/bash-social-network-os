
##

# Social Network

Bash Project

# Brian Manning

## 17324576

![](RackMultipart20201221-4-xmlu1b_html_cf505ecfecf81d5d.jpg)

COMP30650: Operating Systems

UCD School of Computer Science

23/12/2020

# Introduction

In this project, I have implemented a basic social media system using a collection of Bash scripts.

# Requirements

The Social Network was required to facilitate communication between multiple clients and a server concurrently. The client would be able to perform the following actions:

1. Create a user: The client would be able to create a user (create a user folder and user files: wall &amp; friends).
2. Add a friend: The client would be able to add a user as friend on their user account.
3. Post to a friend&#39;s wall: The client would be able to post to the wall of a user who they are friends with.
4. Show a wall: The client would be able to see all posts on any user&#39;s wall.
5. Shutdown: This would shutdown the server for all users.

The client and the server would communicate as follows:

1. The client would send their ID along with their request and any relevant arguments to the request to the server&#39;s pipe
2. The server would then read the request from the server pipe, and if it is valid it would run the request, else it returns an error the client
3. The output of the request will be then sent to the client&#39;s pipe, where the client is currently reading from

The client must be able to read multiple lines of output from the server and must also wait for the server to return the output of their request before outputting to the client&#39;s command line. Multiple clients must be able to communicate with the server concurrently and semaphores must be used to lock critical files as they are being read/written to.

# Scripts

Below I have outlined how the 8 scripts which I use to create the social network system work. The collection of scripts is designed to work together, asynchronously. The server is at the centre of the scripts: it takes requests from clients, runs the required scripts, and returns the output. Clients send requests to the server to be ran. Add, show, post and create all work to provide individual functionality for the users. P and V create semaphores to prevent certain files from being accessed simultaneously.

## add.sh

This script is used to add a user as a friend of another user.

**Arguments**

This script takes two arguments as input: user &amp; friend.

**Error Checking**

- It checks if two arguments are provided, returns an error, and exits if not.
- It then checks if the user exists, if not exits.
- It finally checks if friend exists, if not exits.
- It now reads the friends of the user. If the friend who wants to be added is already a friend of the user, it exits.

**Function**

Finally, it uses a semaphore to lock the friends file of that user. It then adds the friend as a friend of the user, by adding their name to end of the friends file. It then runs the V script to exit.

## show.sh

This script is used to show all posts on a user&#39;s wall.

**Arguments**

This script takes one argument: user.

**Error Checking**

- It checks if only one argument is provided, returns an error, and exits if not.
- It then checks if the user exists, exits if not.

**Function**

Finally, it uses a semaphore to lock the wall file of that user. It then echoes each line of the wall file (each post). It then runs the V script to exit.

###

## post.sh

This script is used to post a message to the wall of a user who is friends with the sender.

**Arguments**

This script takes 3 arguments: receiver, sender, and message.

**Error Checking**

- It checks if at least three arguments are provided, returns an error, and exits if not.
- It then checks if the user exists, if not exits.
- It finally checks if friend exists, if not exits.
- It then checks if the friend is a friend of the user, if not exits with error.

**Function**

While reading through the friends list, if it finds that the friend is a friend of the user, it runs the semaphore on the user&#39;s wall file. It then posts the message to the user&#39;s wall and returns a success message. Finally, it runs the V script and exits.

## create.sh

This script is used to create a new user and their wall and friends files.

**Arguments**

This script takes one argument: the user who is being created.

**Error Checking**

- It first checks that only one argument is provided
- It then checks if the user has already been created

**Function**

It uses a semaphore to lock the create.sh script. This prevents two users from being created simultaneously. This is done to prevent two users with the same name being created at the same time. It then creates the user&#39;s folder along with the wall and friends files. It then returns a success message and uses the V script and exits.

## client.sh

**Arguments**

This script requires at least three arguments – client ID, request &amp; arguments for the request.

**Error Checking**

- It first checks that at least three arguments are provided to the script
- It then checks if the client ID is already in use, exits if so
- It uses cases to check if the request is a valid one, then checking if the required number of arguments are passed to the script

**Function**

This script firstly creates a pipe using the client ID provided. It then echoes all parameters passed to it to the server pipe. It then reads the input from the client ID pipe and removes the pipe, then exits once finished.

## server.sh

This locks a file so that only one process can access it at a time.

**Arguments**

This script works differently to the rest of the scripts and does not take any arguments.

**Error Checking**

- This checks if the server.pipe is already created and if so exits to prevent two servers being created at once.

**Function**

1. Creates a server.pipe to read requests from clients
2. Traps the server.pipe to always delete on exit
3. Reads requests from clients
  1. If the request is create, add, post or show it runs the relevant script and passes the relevant argument
  2. If the request is shutdown – it exits the server, shutting it down
  3. If the request is not known, an error is return to the client

## P.sh

This locks the file passed as the argument.

**Arguments**

This script takes one argument: the file which is to be locked.

**Error Checking**

- It first checks that only one argument is passed, exits if not
- It then checks if the file to be locked exists, if not exists

**Function**

This script takes a file which needs to be locked, and locks it using the link operation (an atomic operation). If it cannot create a link file, this is because a link file has already been created and it therefore must wait (sleep for 1 second and then try again). This is how it locks a file from being used while another process is using it.

## V.sh

**Arguments**

This script takes one argument: the file which is to be &#39;unlocked&#39;.

**Error Checking**

- It first checks if exactly one parameter it passed to it, if not exits
- It then checks if the target file exists, if not exits

**Function**

This script takes a file as input and removes the lock on that file.

# Challenges

## Changing arguments read directly to variable names

Towards the end of my project, I chose to change the any arguments referenced directly in my scripts (eg $1, $2 etc) to more descriptive variable names, making the scripts much easier to read and understand. I coupled this process with using shellcheck to ensure that all my scripts didn&#39;t have any errors that I&#39;d missed. One error that came up was the below in the client.sh script:

![](RackMultipart20201221-4-xmlu1b_html_963884189c5070cf.png)

This error appeared to state that assigning the array to a string was incorrect. From doing further research online I found that the above assignment was not an error and was correct usage and therefore did not change it. This is the only error that comes up when using shellcheck on the scripts. I was getting a similar error in the server.sh script, because of how I was reading in the input from the client pipe. I originally was reading it in as a string and then converting to an array. Rather than doing this, I changed my script to read in the input as an array and this eliminated the need to convert to an array in the following line. See below:

![](RackMultipart20201221-4-xmlu1b_html_6e5ab8574da4bbce.png)

## Reading all output from the server to the client

I had trouble reading the input from the server to the client pipe. Due to the output of some commands being multiple lines eg show.sh, or an error message which returns both the error and the usage of the command, the client.sh needed to be able to read output of multiple lines. Rather than having a single read on the pipe, I opted to use a while loop which read each line of the pipe and echoed it to the client. This enabled the client to be able to read all the output from the server.

![](RackMultipart20201221-4-xmlu1b_html_50e093df32b80230.png)

## Removing server pipe on exit

I had initially proposed removing the server pipe whenever either the shutdown or \*) case were ran, but this did not cover when I used ctrl-c on the server to exit, as the server pipe would not be removed. I found the trap command which could be used to ensure that the pipe was always deleted when the script exits, which was the optimal solution.

![](RackMultipart20201221-4-xmlu1b_html_96c089f46ccfc893.png)

## Trapping client pipe on exit

I had originally set up the client.sh script to have trap &quot;rm ClientID.pipe&quot; EXIT, to ensure that the client ID pipe was always removed when the client script had finished running. This ran into concurrency issues when two scripts were run at the same time, as the trap command would only work on the last ClientID that was run. I had to remove this from the client.sh script and replaced it with rm ClientID.pipe after the client script had finished running instead. Originally, I thought using a trap EXIT here would be an elegant solution to the problem but it turned out to create issues down the line, that I had not seen when using the same script for the server script.

![](RackMultipart20201221-4-xmlu1b_html_7c8d5847b871478e.png)

## Passing script stdout along with stderr to the client

I had initially setup my server.sh script to only pass stdout to the client as below:

![](RackMultipart20201221-4-xmlu1b_html_65f4f742ad1d422b.png)

This did not work properly with my scripts, as all error output was being sent to stderr within each of the individual scripts. This meant that if a client entered the incorrect arguments to the script or if a certain condition was not met the script would not run and the client would not receive any notification of this. I had thought about changing each of the individual scripts to send error output to stdout but this would be an optimal solution and I wanted to keep error output going to stderr within each script. After doing some research online about this but not finding a solution, I was shown the below pipe method (&amp;\&gt;) by the demonstrators, which enabled me to pass all output to the client pipe without changing the individual script&#39;s output methods.

![](RackMultipart20201221-4-xmlu1b_html_631122b0700fc9b0.png)

## Checking if requests are valid in the client script

To check if a request was valid by a client, I needed to check two things: whether the name of the request was valid and secondly whether the correct amount of arguments were given with the request. I implemented a case check for requests in the client.sh script here because it made it simplified the process of filtering the type of requests. This would ensure that a request would not be sent to the server if it was not valid. The cases then check if the correct number of arguments are passed with that request, if not the server exits – if the server passes the case check it can then go on to run the final script and send the request to the server.

# Conclusion

In the above I have outlined the requirements of the Social Network System project in Bash, along with how it was implemented with each of the scripts and finally showed some of the challenges I faced while creating the system. Overall, creating this complex system of scripts helped me to understand the power of the tools that I learned in the lectures and the labs. I got the opportunity to use each of the labs together to create a functional system.
