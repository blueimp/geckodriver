# Geckodriver Dockerfile

This is a [Dockerfile](https://docs.docker.com/engine/reference/builder/) to
create a [Webdriver](https://www.w3.org/TR/webdriver/) Docker image with
[geckodriver](https://github.com/mozilla/geckodriver) and
[Mozilla Firefox](https://www.mozilla.org/en-US/firefox/).

- [Usage](#usage)
- [Tags](#tags)
- [Software](#software)
- [Configuration](#configuration)
- [License](#license)
- [Author](#author)

## Usage

The `blueimp/geckodriver` image starts a `geckodriver` server on port `4444`,
which runs Webdriver tests with Mozilla Firefox in a virtual X Window System.

Sample [docker-compose](https://docs.docker.com/compose/compose-file/)
configuration:

```yml
version: "3.7"
services:
  geckodriver:
    image: blueimp/geckodriver
    # Mount the /tmp partition as tmpfs:
    tmpfs: /tmp
    # Set the size of the /dev/shm partition:
    shm_size: 2g
    environment:
      # Enable the VNC server:
      - ENABLE_VNC=true
      # Expose the X Window Server via TCP:
      - EXPOSE_X11=true
    volumes:
      # Mount the host ./assets directory into the container:
      - ./assets:/home/webdriver/assets:ro
    ports:
      # Expose the VNC server on port 5901 on localhost:
      - 127.0.0.1:5901:5900
```

Please have a look at the [blueimp/wdio](https://github.com/blueimp/wdio)
project for a complete configuration example.

## Tags

For any critical infrastructure (e.g. your company's Continuous Integration
tests) it is **strongly** recommended to use your own tagged Docker images
instead of `blueimp/geckodriver` directly, as changes in the included Software
(see e.g.
[geckodriver issue #1935](https://github.com/mozilla/geckodriver/issues/1935))
might break your tests inadvertently. For example:

```yml
version: "3.7"
services:
  geckodriver:
    image: YOUR_ORG/geckodriver:2021-09-27
    # ...
```

For full control, you should also set up a build for your own version of
[blueimp/basedriver](https://github.com/blueimp/basedriver) and edit the parent
image reference at the start of the `Dockerfile` in this repository accordingly,
e.g.:

```Dockerfile
FROM YOUR_ORG/basedriver:2021-09-27
```

## Software

The following software is included in the `blueimp/geckodriver` image:

- [blueimp/basedriver](https://github.com/blueimp/basedriver) (base image)
- [geckodriver](https://github.com/mozilla/geckodriver) (latest)
- [Mozilla Firefox](https://www.mozilla.org/en-US/firefox/) (latest)

The [blueimp/geckodriver](https://hub.docker.com/r/blueimp/geckodriver) image
provided on Docker hub will be occasionally updated to incorporate changes in
the [blueimp/basedriver](https://github.com/blueimp/basedriver) image as well as
to upgrade to the latest versions of geckodriver and Mozilla Firefox.

## Configuration

See
[blueimp/basedriver configuration](https://github.com/blueimp/basedriver/blob/master/README.md#configuration).

## License

Released under the [MIT license](https://opensource.org/licenses/MIT).

## Author

[Sebastian Tschan](https://blueimp.net/)
