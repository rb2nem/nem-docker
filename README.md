
# Info

A docker image on Docker hub to help run NIS, NEM's Infrastructure Server.

# How to run

Of course you need docker installed, then:

docker pull rb2nem/nis
docker run -p 7890:7890 rb2nem/nis:latest


NIS is then ready and listening on port 7890.



# Passing a config file to NIS

You can "mount" a local config file to make it available in the container.
Do it like this:

docker run -v /path/to/config-user.properties:/package/nis/config-user.properties -p 7890:7890 rb2nem/nis:latest

