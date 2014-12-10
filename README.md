Encrypted Filesystem
====================

### Usage:
  1. `$ make pa5-encfs`
  2. `$ ./pa5-encfs <MIRROR> <MOUNT> -e <PASSWORD>`

#### When finished:
	1. $ fusermount -u <MIRROR>
	2. $ make clean

### Shortcuts:
	1. $ make mount
		* performs any necessary compilation and mounts the files from /mnt onto /mir
	2. $ make unmount
	3. $ make clean

Assignment worked on by: Michael Asnes, Ian Ker-Seymer and Austin Wood.
