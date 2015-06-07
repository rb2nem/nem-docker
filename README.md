
# Info

A docker file to help you setup a nem NIS node and the NEM Community Client.

# How to run

Of course you need docker installed.

Clone this repository, get in the repo's directory.

Then simply run:

    ./start.sh

The first time you run it you will be prompted for a node name (required) and a boot key (optional, 
one can be generated).

To stop the container, issue:

    ./stop.sh

# Tweaking the config

If you want to tweak the config, here is some info.
The start.sh script checks if a file config-user.properties exists, and if it doesn't, it prompts the user for information.
It then generates the file config-user.properties with a bootName and a bootKey. If you want to tweak the config of your 
node, this is the file to edit.

After the config file generation, the script builds and runs the image with these commands, naming the container mynem_container:

    sudo docker build -t mynem_image  .
    sudo docker run --name mynem_container -v ${PWD}/nem:/root/nem -t -d  -p 7890:7890 -p 8989:8989 mynem_image "$@"

This will run NIS and make it available on port 7890 of your host.
The blockchain is saved in the nem directory, so this data is persisted across restarts of the container.

    
# Running NCC

Before you do this, be sure you have a backup of your wallet in a safe place! Things can go wrong, and you should not use this 
if you do not have a backup of your wallets in a safe place! You've been warned!

You can pass arguments specifying what you want to run: nis for running NIS, ncc for running NCC. You can pass one or both values
to the start.sh script. For example, to run both NIS and NCC:

    ./start.sh nis ncc

This will run NIS and NCC, making them available respectively on port 7890 and 8989 of your host.

# Importing a previously exported wallet

When the container is started and running NCC, a new subdirectory is made where you can put your wallets to make them usable 
with NCC. To import an exported wallet, just unzip the exported zip file in ./nem/ncc. Reloading the NCC page in your browser is 
sufficient to have the wallet listed.

