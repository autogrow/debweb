# debweb

Simple Web Interface for Aptly written in Rails.

## How does it work

This web interface abstracts the Debian repository model into Projects and Branches.  A project would constitute the main project like **wheezy** or **mycoolapp**.  Then that Project can be split into branches such as **stable**, **testing**, **restricted**, **contrib** etc.  Then you can add packages to the branch.

The Debian packages are kept in a central 'library' folder.  From the web interface you can select packages to add to individual branches.  Then when you push build on a project, it will build out the structure in Aptly, idempotently, so you can run build over and over without causing errors.  You can even delete the whole Aptly folder and rebuild it without losing any data.

## Requirements

Aptly is required, this can be installed from the Debian repositories.

It will probably only work on a Debian based distro but as long as the OS meets the aptly requirements and provides access to the `dpkg-deb` executable it should run.

## Installation

Clone it:

    $ git clone https://github.com/AutogrowSystems/debweb.git

Build the database:

    $ rake db:migrate

Create an `~/.aptly.conf` file.

Run it:

    $ rails s

Serve the repository with apache, nginx or similar (default location is `/home/you/.aptly/public`).

## Todo

* user authentication
* event logging (tom added x package to wheezy stable)
* drag and drop package upload
* HTTP package upload using API key (perfect for use with CI)
* repository serving (currently this must be done with another web server)
