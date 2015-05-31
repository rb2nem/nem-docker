
# Info

A docker file to help you setup a nem NIS node, remote or local, with our without running the Nem Comunity Client.

# How to run

Of course you need docker installed.

Clone this repository, get in the repo's directory.


First build your image:

    sudo docker build -t mynis  .
    
Then run it:

    sudo docker run -v ${PWD}/nem:/root/nem -t -i -p 7890:7890 mynis

This will run NIS and make it available on port 7890 of your host.
You'll be dropped in a shell of the docker container. When you're done, type exit and the container is stopped.
The blockchain is save in the nem directory, so this data is persisted across restarts of the container.
    
# For development

You can pass arguments specifying what you want to run, the default being only NIS. But if you want to run NIS and NCC, just do:

    docker run -t -i -v ${PWD}/nem:/root/nem -p 8989:8989 -p 7890:7890 mynis ncc nis

This will run NIS and NCC, making them available respectively on port 7890 and 8989 of your host.
Do not do this if you don't master docker. Consider that when you stop the container, your storage and possibly newly created wallet is lost! You could loose your wallet, you've been warned!

# Todo

  * Make it run as a daemon. Now you get a shell prompt from the container.
