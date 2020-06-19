## Moon2P8
## by Juno Nguyen @JunoNgx
## https://github.com/JunoNgx/moon2p8-py/
## Compiles MoonScript to Pico-8 codes easily and flexibly

import os
import sys
import re
import argparse

def writeListToFile(fileObj, content):
    with open(fileObj, 'w') as file:
        for line in content:
            file.write(line)

def printLines(lines):
    for line in lines:
        print(line.rstrip('\n'))

def insertToAt(ls, lx, index):
    lx[index:index] = ls

def getPathFromInclude(_line):
    return _line[10:].replace('\")', '')

parser = argparse.ArgumentParser()
parser.add_argument("inputFile", help="your *.moon source file")
parser.add_argument("outputFile", help="the output *.p8 Pico-8 cartridge to insert codes to (must be pre-created and has valid __lua__ and __gfx__ markers)")
parser.add_argument("-v", "--verbose", help="show detailed and verbose output", action="store_true")
parser.add_argument("-kt", "--keeptempfiles", help="keep temporary files after the operation", action="store_true")

args = parser.parse_args()

# Process the initial input file
# =====================================
if not os.path.isfile(args.inputFile):
    sys.exit(f'Error: input file {args.inputFile} does not exist. Operation terminated.')
    # print('Error: input file {} does not exist. Operation terminated.'.format(str(sys.argv[1])))

if not os.path.isfile(args.outputFile):
    sys.exit(f'Error: Output file {args.outputFile} does not exist. Operation terminated.')
    # print('Error: input file {} does not exist. Operation terminated.'.format(str(sys.argv[1])))

with open(args.inputFile, 'r') as inputFile:
    inputContent = inputFile.readlines()

# Search for #include and paste snippets
# =====================================
lineCount = 0
for line in inputContent:
    strippedLine = line.replace(' ', '').replace('\n', '')
    if re.search("^#include", strippedLine, re.IGNORECASE):
        if args.verbose: print(f'#include found at line {lineCount}')
        filePath = getPathFromInclude(strippedLine)
        if not os.path.isfile(filePath):
            sys.exit(f'Included file {filePath} not found. Operation terminated.')
        with open(filePath, 'r') as f:
            fc = f.readlines()
        del inputContent[lineCount]
        insertToAt(fc, inputContent, lineCount)
        if args.verbose: print(f'File included: {filePath}')
    lineCount += 1

# Use temp files to acquire the main body of the code
# =====================================
with open('_codeBody.moon', 'w') as mf:
    mf.writelines(inputContent)

os.system('moonc _codeBody.moon')
with open('_codeBody.lua', 'r') as lf:
    codeBody = lf.readlines()

if args.verbose: print("Compilation from MoonScript to Lua successful.")

# Strip codes in P8 file
# =====================================
with open(args.outputFile, 'r') as p8f:
    content = p8f.readlines()

lineCount = 0
for line in content:
    if line.replace('\n', '') == "__lua__":
        lua_marker = lineCount
    if line.replace('\n', '') == "__gfx__":
        gfx_marker = lineCount

    lineCount += 1

try:
    lua_marker
except:
    sys.exit("Error: cannot find __lua__ marker in Pico-8 cartridge. Please use a valid output cartridge.")
if args.verbose: print("Lua marker found in cartridge at line:", lua_marker)

try:
    gfx_marker
except:
    sys.exit("Error: cannot find __gfx__ marker in Pico-8 cartridge. Please use a valid output cartridge.")
if args.verbose: print("Gfx marker found in cartridge at line:", gfx_marker)

for i in range(gfx_marker - lua_marker - 1):
    del content[lua_marker + 1]
if args.verbose: print("Existing codes in cartridge cleared.")

# Final processing
# =====================================

insertToAt(codeBody, content, lua_marker + 1)
writeListToFile(args.outputFile, content)
if args.verbose: print(f'New Lua codes injected to {args.outputFile} from {args.inputFile} without any issue detected.')

# Cleaning up temp files
# =====================================
if not args.keeptempfiles:
    os.remove("_codeBody.moon")
    os.remove("_codeBody.lua")
    if args.verbose: print(f'Temporary files deleted.')
else:
    print('Temporary files kept as per argument.')

# Successful output
# =====================================
print('Operation completed.')
