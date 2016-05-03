# Oracle Java Development Kit (JDK) 8 for Habitat Plan

It works but required hacking because:

* Oracle requires a cookie to be set accepting the licenses to download, so a custom download_file() is written.
* The unpacked directory name doesn't match the tarball name, so a custom do_unpack() is written


