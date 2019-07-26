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
        if(keyword in contents):

            match_lines = []
            in_function = False
            match = False

            for line in contents.splitlines():
                
                match_lines.append(line)

                if keyword in line:
                    match = True
                    # Trivial Case : Alias Match
                    if(re.match(r'^alias\ ', line)):
                        # match_lines.append(line)
                        matches.append(match_lines)
                        match_lines = []
                        match = False
                
                if(re.match(r"^[a-z\_\-]+\(\)\{",line,re.IGNORECASE)):
                    in_function = True
                elif(in_function and re.match(r'^}$',line)):
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
    for line in match_lines:
        if(re.match(r'^#',line)):
            print(Fore.GREEN + line.replace(keyword,Fore.RED + keyword + Fore.GREEN))
        else:    
            print(Fore.LIGHTBLUE_EX + line.replace(keyword,Fore.RED + keyword + Fore.LIGHTBLACK_EX))
    print(Style.RESET_ALL)
        
def printHeader(filename, match_count):
    print(Back.WHITE)
    print(Fore.BLACK)
    print(file + Fore.CYAN  + " [" + str(match_count) + "]")



home = os.path.expanduser("~")
search_string = sys.argv[1]

for root, dirs, files in os.walk(home + "/env"):
        for file in files:
            if file.endswith(".al"):
                matches = searchFile(file,search_string)
                if len(matches) > 0:
                    printHeader(file,len(matches))
                    for match in matches:
                        printMatch(match,search_string)
