
# Info

A docker file to help you setup a nem NIS node.

# How to run

Of course you need docker installed.

Clone this repository, get in the repo's directory.

Then simply run:

    ./run.sh

To stop the container, issue:

    sudo docker stop mynis

# Tweaking the config

If you want to tweak the config, here some info.
The run script checks if a file config-user.properties exists, and if it doesn't, it prompts the user for information.
It then generates the file config-user.properties with a bootName and a bootKey. If you want to tweak the config of your 
node, this is the file to edit.

After that, the script builds and runs the image with these commands, naming the container mynis:

    sudo docker build -t mynis  .
    sudo docker run --name -v ${PWD}/nem:/root/nem -t -d  -p 7890:7890 mynis

This will run NIS and make it available on port 7890 of your host.
The blockchain is save in the nem directory, so this data is persisted across restarts of the container.

    
# For development

You can pass arguments specifying what you want to run, the default being only NIS. But if you want to run NIS and NCC, just do:

    sudo docker run -t -i -v ${PWD}/nem:/root/nem -p 8989:8989 -p 7890:7890 mynis ncc nis

This will run NIS and NCC, making them available respectively on port 7890 and 8989 of your host.
Do not do this if you don't master docker. Consider that when you stop the container, your storage and possibly newly created wallet is lost! You could loose your wallet, you've been warned!
With this command you'll be dropped in a shell running inside the container. To stop the container, exit the shell.
