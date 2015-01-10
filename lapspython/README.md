#__Debian__ ``L``inux ``A``pache2 ``P``HP5 ``S``tack (__*``LAPS``*__) Docker
## (With) Python 2.x+
[docker.io](http://docker.io \"Docker\") Dockerfile (_**Debian**:Wheezy 7.7_) with Apache, PHP5 & Python 

``Dockerfile`` is standalone containing all _build_ & _run_ instructions:
```sh
cat Dockferfile
# build: docker build -t debian/lapspython .
# run: docker run -p 80:80 -p 443:443 -it --detach --name=lapspython debian/lapspython
# cli: docker run -p 80:80 -p 443:443 -it --rm --name=lapspython debian/lapspython
```
Adjust leftmost ``-p`` numbers if local ``ports``: **80** (http) & **443** (https) are in use on testing machine - to use **_81_** & **_444_** bound to __*80*__ & __*443*__ in container:
```sh
docker run -p 81:80 -p 444:443 -it --rm --name=lapspython debian/lapspython
```
Default ``/var`` paths used for __apache2__ with default "It Works!" in ``/var/www/index.html`` 

To shell into image via ``/bin/bash`` simply append instruction to run command eg: 
```sh
docker run -p 81:80 -p 444:443 -it --rm --name=lapspython debian/lapspython /bin/bash
```
