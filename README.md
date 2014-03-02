# Tiny Rails Gallery

[![Code Climate](https://codeclimate.com/github/voran/tiny-file-repository.png)](https://codeclimate.com/github/voran/tiny-file-repository)
[![Build Status](https://travis-ci.org/voran/tiny-file-repository.png?branch=master)](https://travis-ci.org/voran/tiny-file-repository)
[![Dependency Status](https://gemnasium.com/voran/tiny-file-repository.png)](https://gemnasium.com/voran/tiny-file-repository)

- [Description](#description)
- [Installation](#installation)
- [Configuration](#configuration)
    - [Change Password](#change-password)
    - [Title and Meta Tags](#title-and-meta-tags)
    - [Content](#content)
- [License](#license)
- [Credits](#credits)



## Description
Tiny File repository provides an easy way to browse a directory on a remote server and search for files.

## Installation
Clone this repository. Then:
```sh
bundle install
```

## Configuration
Configuration for this application is stored in config/application.rb

### Change Password
This password will be required for regenerating the search index.
```rb
  config.index_password = 'changeme'
```

### Title and Meta Tags
You can set title and meta tags using the following entries:
```rb
    config.title = "Tiny File Repository"
    config.meta_description = "Powered by Tiny File Repository"
    config.meta_keywords = "File Repository"
```

### Content
Files need to be in a folder under public/. You can also set up a symlink that points outside of your application. Change
```rb
    config.files_url = "/files/"
```
 to point to a folder (or symlink) relative to pubic/ where your content is stored.



Also, You can whitelist file types and blacklist directories using the following entry:
```rb
    config.blacklist_dirs = [".", ".."]
```


## License
Released under the [GPL 3 License](http://www.gnu.org/licenses/gpl.txt).

## Credits
Layout based on  [twitter/bootstrap](https://github.com/twitter/bootstrap).
    
