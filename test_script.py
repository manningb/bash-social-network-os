from subprocess import PIPE, Popen , list2cmdline
import os

def run_cmd(command, should_print=False):
    print("Running ", list2cmdline(command))
    with Popen(command, stdin=PIPE, stdout=PIPE, stderr=PIPE, shell=False) as process:
        (stdout, stderr) = process.communicate()
        if should_print:
            print("stderr:\n%s\nstdout:\n%s\n" % (stderr, stdout))
        return process.wait()

def check_if_string_in_file(file_name, string_to_search):
    """ Check if any line in the file contains given string """
    # Open the file in read only mode
    with open(file_name, 'r') as read_obj:
        # Read all lines in the file one by one
        for line in read_obj:
            # For each line, check if line contains the string
            if string_to_search in line:
                return True
    return False

print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("#Test create.sh")

print("#Should fail, no parameters")
if run_cmd(["./create.sh"]) == 0:
    print("#create.sh should have failed because no parameter")
    exit(1)

print("#Should succeed, no spaces")
run_cmd(["./create.sh", "myUser"])

if os.path.isfile("./myUser"):
    print("#Created the folder ./myUser correctly")
else:
    print("#Did not create the user folder")
    exit(1)
if os.path.isfile("./myUser/wall"):
    print("#Created the wall file correctly")
else:
    print("#Did not create the wall file")
    exit(1)
if os.path.isfile("./myUser/friends"):
    print("#Created the friends file correctly")
else:
    print("#Did not create the friends file")
    exit(1)

print("#Should succeed, spaces")
run_cmd(["./create.sh", "my User"])

if os.path.isfile("./my User"):
    print("#Created the folder './my User' correctly")
else:
    print("#Did not create the user folder")
    exit(1)
if os.path.isfile("./my User/wall"):
    print("#Created the wall file correctly")
else:
    print("#Did not create the wall file")
    exit(1)
if os.path.isfile("./my User/friends"):
    print("#Created the friends file correctly")
else:
    print("#Did not create the friends file")
    exit(1)

print("#Should fail because user already exists")
if run_cmd(["./create.sh", "my User"]) == 0:
    print("#create.sh should have failed as the user already exists")
    exit(1)


print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("#Test add.sh")

print("#Should fail because not enough parameters")

if run_cmd(["./add.sh", "newUser"]) == 0:
    print("add.sh should have failed because not enough parameters")
    exit(1)

print("#Should fail because too many parameters")
if run_cmd(["./add.sh", "myUser", "my User", "shouldNotBeHere"]) == 0:
    print("#add.sh should have failed because too many parameters")
    exit(1)

print("#Should fail because user does not exist")
if run_cmd(["./add.sh", "userNotExists", "myUser"]) == 0:
    print("#add.sh should have failed because user does not exist")
    exit(1)

print("#Should fail because friend does not exist")
if run_cmd(["./add.sh", "myUser", "userNotExists"]) == 0:
    print("#add.sh should have failed because friend does not exist")
    exit(1)

print("#Should succeed")
run_cmd(["./add.sh", "myUser", "my User"])
if not check_if_string_in_file("my User", "./myUser/friends"):
    print("#Did not add the friend to the friend list")
    exit(1)

print("#Should fail because users are already friends")
if run_cmd(["./add.sh", "myUser", "my User"]) == 0:
    print("#add.sh should have failed because users are already friends")
    exit(1)


print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("#Test post.sh")

print("#Should succeed")
run_cmd("./post.sh", "myUser", "my User", "A test message")
if not check_if_string_in_file("my User: A test message", "./myUser/wall"):
    print("#Did not add the message to the wall")
    exit(1)

print("#Should fail because sender is not friend of receiver")
if run_cmd("./post.sh", "my User", "myUser", "A test message") == 0:
    print("#post.sh should have failed because sender is not a friend of receiver")
    exit(1)


print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("#Test show.sh")
if run_cmd("./show.sh", "myUser", True) != 0:
    print("show.sh failed")
    exit(1)
