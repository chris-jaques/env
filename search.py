"""
    Search the /env for a certain keyword
"""
import os
import sys
import re
from colorama import Fore, Back, Style

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
    print(Back.BLACK)
    match = ""
    for line in match_lines:
        m = re.search(r"" + re.escape(keyword),line,re.IGNORECASE)
        if m:
            match = m.group(0)
            if debug: print(" MATCH = ",match)

        if(re.match(r'^#',line)):
            if debug:print("COMMENT LINE: ",line, 'reaplace ',keyword, ' with ',match)
            print(Fore.GREEN + re.sub(re.escape(keyword),Fore.RED + match + Fore.GREEN,line,flags=re.I))
        else:
            print(Fore.LIGHTBLUE_EX + line.replace(keyword,Fore.RED + keyword + Fore.LIGHTBLUE_EX))
    print(Style.RESET_ALL)

def printFileHeader(filename, match_count):
    print(Back.WHITE)
    print(Fore.BLACK)
    print(filename + Fore.CYAN  + " [" + str(match_count) + "]")
    print(Style.RESET_ALL)


env_dir = os.path.expanduser("~") + "/env"
if len(sys.argv) > 1:
    search_string = sys.argv[1]
else:
    search_string = " "

debug = (False,True)[len(sys.argv) > 2 and sys.argv[2] == "-d"]

print(Style.RESET_ALL)
for root, dirs, files in os.walk(env_dir):
        for file in files:
            if file.endswith(".al"):
                matches = searchFile(env_dir + "/" + file, search_string)
                if len(matches) > 0:
                    printFileHeader(file,len(matches))
                    for match in matches:
                        printMatch(match,search_string)
