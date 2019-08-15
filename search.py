"""
    Search the /env for a certain keyword
"""
import os
import sys
import re

def fg(color):
    """
    Forground Colors
    """
    switch = {
        # Green
        "g": "\x1b[32m",
        
        # Red
        'r': "\x1b[31m",

        # Black
        'b': "\x1b[30m",
        
        # White
        'w': "\x1b[37m",

        # Blue
        'bl': "\x1b[94m",

        # Cyan
        'c': "\x1b[36m"
    }
    return switch.get(color)

def bg(color):
    """
    Background Colors
    """
    switch = {
        # White
        "w": "\x1b[47m",

        # Black
        "b": "\x1b[40m"
    }
    return switch.get(color)

def reset():
    print("\x1b[0m")

def searchFile(filename, keyword):
    """
    Search the file for the keyword
    if found, return the full alias/function definition(s)
    """
    matches = []
    with open(filename, 'r') as file:
        contents = file.read()
        if keyword.lower() in contents.lower():

            match_lines = []
            in_function = False
            match = False
            header = True

            for line in contents.splitlines():
                # Ignore the file headers
                if header and re.match(r'^#',line):
                    continue
                elif header:
                    header = False

                if debug and match: print("MATCHING... ",line)
                match_lines.append(line)

                if match or keyword.lower() in line.lower():
                    match = True
                    if debug: print("KEYWORD MATCH: ",line)
                    # Trivial Case : Alias Match
                    if(re.match(r'^alias\ ', line)):
                        if debug: print("Alias")
                        matches.append(match_lines)
                        match_lines = []
                        match = False

                # Match function definition
                if(re.match(r"^[a-z\_\-]+\(\)\ ?\{",line,re.IGNORECASE)):
                    in_function = True
                    if debug: print("In a Function: ")
                elif(in_function and re.match(r'^}$',line)):
                    if debug: print("End of Function ")
                    in_function = False
                    if match:
                        matches.append(match_lines)
                    match_lines = []
                    match = False

                if not in_function and re.match('^$',line):
                    if match:
                        matches.append(match_lines)
                    match_lines = []
    return matches

def printMatch(match_lines, keyword):
    print(bg('b'))
    match = ""
    for line in match_lines:
        
        m = re.search(r"" + re.escape(keyword),line,re.IGNORECASE)
        if m:
            match = m.group(0)
            if debug: print(" MATCH = ",match)

        # Output a comment line
        if(re.match(r'^#',line)):
            print(fg('g') + re.sub(re.escape(keyword),fg('r') + match + fg('g'),line,flags=re.I))
        else:
            print(fg('bl') + re.sub(re.escape(keyword),fg('r') + match + fg('bl'),line,flags=re.I))
    reset()

def printFileHeader(filename, match_count):
    print(bg('w'))
    print(fg('b'))
    print(filename + fg('c')  + " [" + str(match_count) + "]")
    reset()


env_dir = os.path.expanduser("~") + "/env"
if len(sys.argv) > 1:
    search_string = sys.argv[1]
else:
    search_string = " "

debug = (False,True)[len(sys.argv) > 2 and sys.argv[2] == "-d"]

reset()
for root, dirs, files in os.walk(env_dir):
        for file in files:
            if file.endswith(".al"):
                matches = searchFile(env_dir + "/" + file, search_string)
                if len(matches) > 0:
                    printFileHeader(file,len(matches))
                    for match in matches:
                        printMatch(match,search_string)
