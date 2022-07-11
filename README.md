
# Environment Repo

This repo is a collection of aliases and functions used to normailize my workflow across linux machines. 

## Organization

The 'loadEnv' file is sourced by the user's .rc file. This file detects and sources all '.al' files within the 'env' folder. `.al` files are a way to group application specific aliases and functions together so that they can be included/excluded together, separate from other applications.

## installation

Use install script:

```sh
curl https://raw.githubusercontent.com/chris-jaques/env/master/install.sh | sh
```

which will checkout this repo into the user's home folder and load the env into the users .bashrc

NOTE: if the aliases aren't available on shell re-launch, check to see if your .bashrc is being sourced by your .profile.

## Useful Aliases & getting started

1. Alias Search
-  search the env for any keyword. For example, search for any kubernetes aliases with:
```sh
as kube
```

2. Local Directory Aliases
- You may wish to work on a project on your local machine, and add an alias to quickly cd into the project directory.
-  This project exist in a different directory ( or not at all ) on another machine that is using the env, so there is no need to save it to the env project
- Local aliases are kept in the `local.al` file. You can easily add a cd alias into this file like `alias myalias="/path/to/folder"`:
```sh
    cda /path/to/folder myalias
```
You can also add a comment above this line, which will show up in an Alias Search
```sh
    cd /path/to/folder
    cda . myalias This is a custom alias for myProject
```
output:
```sh
# This is a custom alias for myProject
alias myalias="/path/to/folder"
```

If you don't want this alias any more, you can also remove it with `cdr`

```sh
    cdr myalias
```

3. Editing this project
- If you don't have vscode, then you can install it with 
```
i_vscode
```
Then you can use the `eenv` command to edit the env.
```sh
# Open the env project in vscode ( will open local.al by default )
eenv;

# OR

# Open the env project to a particular file for editing (opens git.al)
eenv git
```

# Conventions

## 1.
Any arguments that are accpected by a function/alias are defined in the comment above its definition

example:
```sh
# Say Hello { name }
hi(){
    echo "Hello $1"
}
```
This tells you that the first argument, "name", is required. 

### Types of parameter definitions: 
- Required 
    - ex:  `{ required }`
    - required parameter
    - not providing this parameter will usually halt the function and output an error

- Optional Paramter
    - ex: `{ notRequired? }`

- Parameter with Default
    - ex: `{ someParameter=theDeafultValue }`
    - If the parameter is **not** provided, the default value will be used

- Parameter Array
    - ex: `{ ...things }`
    - 1 to any number of parameters 
    - practicatl example:
    ```sh
        # Echo { ...outputText }
        e(){
            echo "${@:1}"
        }
    ```
    - usage:
     ```sh
        e here is some text

        #output
        here is some text
     ``` 