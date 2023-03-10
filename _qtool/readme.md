# qtool: Quarto Tool

## Overview

**Qtool** is a tool specifically designed for **users of the Quarto documentation platform**. It offers a number of features that can help users manage large numbers of Quarto files more efficiently.

**Qtool is a command-line tool** that helps users manage and manipulate their Quarto (`.qmd`) files. It has the following five operations:

- `debug`: scans the directories and files in a specified directory, and checks for any discrepancies between the .yaml and ``.qmd`` files. It reports any errors or inconsistencies it finds.
- `dirtable`: generates a CSV file containing information about the directories in the specified directory. It includes the directory name, the number of files in the directory, and the total number of lines in all of the files in the directory.
- `yamltable`: generates a CSV file containing information about the .yaml files in the specified directory. It includes the file name, the number of lines in the file, and the number of sections in the file.
- `writenavigation`: adds callouts to the ``.qmd`` files in the specified directory, to make it easier for users to navigate through the content. It adds a callout at the beginning of each section, with a link to the next and previous sections.

## Using qtool

1. git clone from repository
2. move to Quarto project **_qtool**
3. remember to add **_qtool** directory to *.gitignore*
4. from **_qtool** directory:
   1. give permission to bash scripts: **chmod +x debug.sh** or directory **chmod +x _qtool**
   2. execute them: **./qtool debug.sh**

## Install

To install qtool, users can clone the repository from GitHub using the following command:

```bash
git clone https://github.com/user/qtool.git
```

Alternatively, users can download the zip file and extract it to a desired location. Once the qtool directory is available, users can enter the directory and use the following command to make the script executable:

```bash
chmod +x qtool
```

To use qtool, users can open a terminal and navigate to the qtool directory. Then, they can use the following command to see a list of available options:

```bash
./qtool help
```

To use a specific function, users can use the following command, replacing "function" with the name of the desired function:

```bash
./qtool function
```

For example, to use the debug function, users can use the following command:

```bash
./qtool debug
```

Users can also use the qtool script from any location by adding the qtool directory to their PATH environment variable. This allows them to use the qtool command without specifying the full path to the script.

```bash
export PATH=$PATH:/path/to/qtool
```

Once the qtool script is installed and available in the PATH, users can use it from any location by simply using the "qtool" command followed by the desired function.

```bash
qtool function
```

### tty-table

Use nodejs and tty-table app with csv delimiter ";"

**need to install two packages:**

```bash
$ sudo apt-get install nodejs 
$ npm install tty-table -g
```

[tty-table ?????????](https://github.com/tecfu/tty-table)

**Notice**

> The package (tty-table) that depends on another package (yargs) which in turn depends on yargs-parser. The yargs-parser package requires a minimum version of **Node.js (12)** in order to work properly.

```bash
sudo apt update
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
source ~/.bashrc
nvm --version
nvm ls
nvm ls-remote
# chek last version
# nvm install [version.number]
nvm install v19.3.0
```
