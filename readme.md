# Social Network

Bash Project

# Brian Manning

# 17324576

![](RackMultipart20201221-4-h91uqf_html_cf505ecfecf81d5d.jpg)

COMP30650: Operating Systems

UCD School of Computer Science

23/12/2020

# Introduction

In this project, I have implemented a basic social media system using Bash scripts.

# Requirements

The Social Network was required to facilitate communication between multiple clients and a server concurrently. The client would be able to perform the following actions:

1. Create a user: The client would be able to create a user (create a user folder and user files: wall &amp; friends).
2. Add a friend: The client would be able to add a user as friend on their user account.
3. Post to a friend&#39;s wall: The client would be able to post to the wall of a user who they are friends with.
4. Show a wall: The client would be able to see all posts on any user&#39;s wall.

The client and the server would communicate as follows:

1. The client would send their ID along with their request and any relevant arguments to the request to the server&#39;s pipe
2. The server would then read the request from the server pipe, and if it is valid it would run the request, else it returns an error the client
3. The output of the request will be then sent to the client&#39;s pipe, where the client is currently reading from

# Scripts

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

While reading through the friends list, if it find that the friend is a friend of the user, it runs the semaphore on the user&#39;s wall file. It then posts the message to the user&#39;s wall and returns a success message. Finally, it runs the V script and exits.

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

**Function**

This script firstly creates a pipe using the client ID provided. It then echoes all parameters passed to it to the server pipe. It then reads the input from the client ID pipe and removes the pipe, then exits once finished.

## server.sh

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

**Arguments**

This script takes one argument: the file which is to be locked.

**Error Checking**

- It first checks that only one argument is passed, exits if not
- It then checks if the file to be locked exists, if not exists

**Function**

## V.sh

**Arguments**

**Error Checking**

**Function**
