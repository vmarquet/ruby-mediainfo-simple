mediainfo-simple
================

Description
-----------
This gem is a wrapper for the [MediaInfo](https://mediaarea.net) command-line interface.


How it works
------------
It calls the MediaInfo command-line interface, and parses the XML output (obtained with `mediainfo file.mp4 --Output=XML`). Excepted for the MediaInfo CLI, it's 100% Ruby.


Installation
------------

### Dependencies

MediaInfo CLI. Installation:

* Mac OS X: `brew install mediainfo`
* Debian / Ubuntu: `sudo apt-get install mediainfo`

### The gem

`gem install mediainfo-simple`


Usage
-----
```
require 'mediainfo-simple'

info = MediaInfo.new "/path/to/file"
```

That will issue the system call to `mediainfo` and parse the output.

```
# check if there is a stream of some type
info.video?        # true
info.audio?        # true
info.image?        # false

# check the number of streams of some type
info.audio.count   # 2

# get metadata about a stream
info.audio[0].language  # "English"
info.audio[1].language  # "French"
```

See all the metadata attributes supported for each stream type in the corresponding classes in [lib/mediainfo-simple/streams](lib/mediainfo-simple/streams).


TODO
----
* add tests
* add methods to get duration in a particular format


License
-------
[WTFPL](http://www.wtfpl.net/txt/copying/)

Credits
-------
Inspired by:

* ["mediainfo" gem](https://github.com/greatseth/mediainfo)

