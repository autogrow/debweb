This document represents the view the application takes of the debian repository structure:


The Debian Repository syntax:

    deb http://nz.archive.ubuntu.com/ubuntu/ vivid main restricted
    deb <url> <project> <branch1> <branch2>
    deb http://exampe.com myproject stable testing

## Models

### Library

The Library models a folder on disk that contains all the debian packages in a flat structure.  The user can
then add a package from the library into Aptly.  Then Aptly does it's thing and places the package in the
correct spot in the Debian Repository.  After that the Package model can facilitate copying a hardlink from
the library over it's path.  This means that you only use disk space for one copy of the package, even if
that package is in multiple repositories.

Also when you add a *.deb to the Library path, it is instantly visible in the app ready to be added to a
repository.

The Library path is set in the `config/settings.yml` file.

**Methods:**

* size
* packages

### Project

The main project that the repository is serving packages for.

* Has many Branches

**Attributes:**

* name (myproject)

### Branch

The branch of the project this repository represents:

* Has many Packages
* Belongs to Project

**Attributes:**

* name (stable, testing, experimental)
* project ID

### Package

The package that is served by the repository.

When the package is added, and the package exists in the Library, the package is replaced with hardlink to the file in the Library.

* Belongs to Branch

**Attributes:**

* name (linux-image, myapp-common, myapp-utils, myapp-ui)
* branch ID
* version
* path
