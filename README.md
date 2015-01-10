#__Debian__ ``L``inux ``A``pache ``P``H5 ``S``tack (__*``LAPS``*__) Docker's
**Multiple** **[docker.io](http://docker.io \"Docker\")** Dockerfile's (_**Debian**:Wheezy 7.7_) incorporating, similar to XAMP / LAMP, a stack that includes:
- **APACHE** (can be _nginix_)
- **PHP5** (with many core php-plugins)

By default **_apache_** ``php5`` & ``rewrite`` _mods_ are enabled which are commonly needed in most PHP orianteaited frameworks & applications. 

Other common & versatile development variants of LAPS provided with:
- __*``lapsnode``*__ [Node.js (1.4.x+)](http://nodejs.org/ \"node.js-website\")
- __*``lapspython``*__ [python 2.7+ Programming Language](https://www.python.org/ \"python-website\")
- __*``lapsdev``*__ Common Tools &  Utils (as above with: _build-essential_,_go_, _git_, _nano_, etc. ) 

A template application *__``laps200app``__* has also been provided that simply returns an unconditional [HTTP 200 OK](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html \"rfc2616\") response for any request using ```FallbackResource``` in .htaccess & index.php; both files are in-lined descripted within each ```Dockerfile```. 

*__``lapsdev``__* is a more comprehensively equiped statck with more tools and ultitlies akine to a developers own personal computer system. This is based on the _``laps200app``_ which when run via **C**ommand-**L**ine-**I**nterface verbose, tail, output of access.log are echoed to the screen. 

Each ``Dockerfile``'s standalone containing all _build_ & _run_ instructions - eg:
```sh
cat Dockferfile
...
# build: docker build -t debian/laps .
# run: docker run -p 80:80 -p 443:443 -it --detach --name=laps debian/laps
# cli: docker run -p 80:80 -p 443:443 -it --rm --name=laps debian/laps
```
Adjust leftmost ``-p`` numbers if local ``ports``: **80** (http) & **443** (https) are in use on testing machine - for example:
```sh
docker run -p 81:80 -p 444:443 -it --rm --name=laps debian/laps
```
To shell into image via ``/bin/bash`` simply append instruction to run command eg: 
```sh
docker run -p 81:80 -p 444:443 -it --rm --name=laps debian/laps /bin/bash
```
Default ``/var`` paths used for __apache2__ with default "It Works!" ``/var/www/index.html`` or ``/var/www/index.php``.

``docker images`` of all builds should resemble:
```
REPOSITORY          TAG        IMAGE ID        CREATED    VIRTUAL SIZE
debian/laps         latest     843b05802f6d      ...        183.1 MB
debian/laps200app   latest     45c59e66f5b0      ...        183.1 MB
debian/lapsdev      latest     747a117ab953      ...        894.7 MB
debian/lapspython   latest     34bcb2e4a879      ...        205.3 MB
debian/lapsnode     latest     dcfef0dde129      ...        212.2 MB
```
To pull directly using ``docker`` from  [registry.hub.docker.com](https://registry.hub.docker.com/u/aphorise/debian-laps/ "registry.hub.docker.com") ``docker pull aphorise/laps`` for example. 
