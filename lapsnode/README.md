#__Debian__ __*``L``*__inux-__*``A``*__pache-__*``P``*__hp-__*``S``*__tack (__*``LAPS``*__) __Docker__
## (With) Node.js
[docker.io](http://docker.io \"Docker\") Dockerfile (_**Debian**:Wheezy 7.7_) with Apache, PHP5 & Node.js

``Dockerfile`` is standalone containing all _build_ & _run_ instructions:
```sh
cat Dockferfile
# build: docker build -t debian/lapsnode .
# run: docker run -p 80:80 -p 443:443 -it --detach --name=lapsnode debian/lapsnode
# cli: docker run -p 80:80 -p 443:443 -it --rm --name=lapsnode debian/lapsnode
```
Adjust leftmost ``-p`` numbers if local ``ports``: **80** (http) & **443** (https) are in use on testing machine - to use **_81_** & **_444_** bound to __*80*__ & __*443*__ in container:
```sh
docker run -p 81:80 -p 444:443 -it --rm --name=lapsnode debian/lapsnode
```
Default ``/var`` paths used for __apache2__ with default "It Works!" in ``/var/www/index.html`` 

To shell into image via ``/bin/bash`` simply append instruction to run command eg: 
```sh
docker run -p 81:80 -p 444:443 -it --rm --name=lapsnode debian/lapsnode /bin/bash
```
