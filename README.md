# README 

## Introduction
Creating new source files, writing all the same things everytime and placing the files in the right place makes you tired.
This script will help you to generate new sources automatically.
This script will generate following files.
1. c++ header file
1. c++ source file
1. c++ gtest source file
1. c++ gtest main source file for each module

## Install
1. Clone this repository into your directory. For example,  
```
git clone https://github.com/rise-lab-skku/src_generate_script.git "${HOME}/.custom_tools/psrcgen"
```

1. Make alias in your shell initializing script. For example, 
```
echo "alias psrcgen=\"source ${HOME}/.custom_tools/psrcgen/psrcgen.sh\"" >> ${HOME}/.zshrc
```

## Usage
1. Make sure you are using this command in local git repository. Else it will not work.
1. Simply type the command.
```
psrcgen your_package_name your_module_name your_file_name
```

Have Fun!