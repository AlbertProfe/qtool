# qtool: Quarto Tool

## Overview

**Qtool** is a tool specifically designed for **users of the Quarto documentation platform**. It offers a number of features that can help users manage large numbers of Quarto files more efficiently.

The `help` feature provides users with information on how to use the tool and its various functions. The `debug` feature allows users to identify discrepancies between their `.yaml` and `.qmd` files, which can be useful for finding errors or inconsistencies in the documentation.

The `dirtable` and yamltable features allow users to create tables from `.csv` files, which can be useful for organizing and visualizing large amounts of data.

Finally, the `writenavigation` feature allows users to write `callouts` in their ``.qmd`` files to facilitate navigation within the documentation.

Overall, qtool can be a valuable asset for Quarto users looking to **streamline their documentation processes and better manage large amounts of files**.

## For big teams and big projects

qtool can help Quarto users manage a large number of files by providing a number of useful functions. The `help` function can provide users with information on how to use the tool and its various functions.

The `debug` function can be used to identify discrepancies between the .yaml file and the `.qmd` files, which can be useful for ensuring that the project is properly structured and organized. 

The `dirtable` and `yamltable` functions can be used to create tables from .csv files, which can be useful for visualizing and organizing data in a more structured way.

Finally, the `writenavigation` function can be used to write callouts in `.qmd` files to facilitate navigation, which can be especially useful for large projects with many collaborators. Overall, qtool can be a very useful tool for managing and organizing large Quarto projects.

## Operations implemented

**Qtool is a command-line tool** that helps users manage and manipulate their Quarto (`.qmd`) files. It has the following five operations:

- `debug`: scans the directories and files in a specified directory, and checks for any discrepancies between the .yaml and ``.qmd`` files. It reports any errors or inconsistencies it finds.
- `dirtable`: generates a CSV file containing information about the directories in the specified directory. It includes the directory name, the number of files in the directory, and the total number of lines in all of the files in the directory.
- `yamltable`: generates a CSV file containing information about the .yaml files in the specified directory. It includes the file name, the number of lines in the file, and the number of sections in the file.
- `writenavigation`: adds callouts to the ``.qmd`` files in the specified directory, to make it easier for users to navigate through the content. It adds a callout at the beginning of each section, with a link to the next and previous sections.

## Future features: To-do

- `help`: displays a list of all available commands and their usage.
- `template`: allows users to create a new template for their .qmd files or use an existing template.

### Template discussion

This can be useful for organizing and standardizing the structure of their .qmd files, particularly in large projects with multiple collaborators. To create a new template, users can specify the desired structure and formatting for their .qmd files and save it as a template file. To use an existing template, they can specify the path to the template file and the qtool script will use it to create new .qmd files. The qtool script is a free, open-source tool licensed under the MIT license, so users can freely use and modify it to meet their needs.

## Install

To install qtool, users can clone the repository from GitHub using the following command:

```bash
git clone https://github.com/user/qtool.git
```

Alternatively, users can download the zip file and extract it to a desired location.

Once the qtool directory is available, users can enter the directory and use the following command to make the script executable:

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

## Pricing and license

### Pricing

**Qtool is a free and open source tool licensed under the MIT license**. 

This means that users are free to use, modify, and distribute the tool as they see fit, as long as they include the appropriate attribution and do not hold the developers liable for any damages that may result from using the tool. Users can easily install and use qtool from the Linux terminal by downloading the source code from a repository such as GitHub and following the installation instructions provided.

### tty-table

Use nodejs and tty-table app with csv delimiter ";"

**need to install two packages:**

```bash
$ sudo apt-get install nodejs 
$ npm install tty-table -g
```

[tty-table 端子台](https://github.com/tecfu/tty-table)
