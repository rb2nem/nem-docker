# NEM NanoWallet docker configuration

[This git repository](https://github.com/rb2nem/nem-docker/) helps you to build the NEM NanoWallet in a docker container.
You can then decide to copy the result of the build to your host, or access the 
NanoWallet in the docker container over http.

You can build the image yourself, or use the image published on DockerHub.
the difference is that when you build the image yourself, you will always build the
latest version of the NanoWallet available on Github. When you use the image 
from DockerHub, you will get the wallet that was latest at the time DockerHub
built the image.


# Building the image yourself

## Accessing the wallet on the host filesystem

Build the image and copy the nanowallet to the host:

    docker build -t nanowallet .
    docker run nanowallet tar -c -C /NanoWallet build | tar x
    echo "open file://$PWD/build/start.html in your browser"

The NanoWallet is copied to the `build` directory, which you can access in your browser.

This is also automated with the script `build.sh`:

    ./build.sh

giving the same results.


## Accessing the wallet server from the docker container

    docker build -t nanowallet .
    docker run --rm -p 80:80 nanowallet

and access [http://localhost/](http://localhost/)

# Using the image from DockerHub

    
## Accessing the wallet on the host filesystem


    docker run rb2nem/lightwallet tar -c -C /NanoWallet build | tar x
    echo "open file://$PWD/build/start.html in your browser"

## Accessing the wallet server from the docker container

    docker run --rm -p 80:80 rb2nem/lightwallet

and access [http://localhost/](http://localhost/)
