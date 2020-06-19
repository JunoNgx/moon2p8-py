import os
import sys
import re

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

inputFile = sys.argv[1]
p8File = sys.argv[2]

# Process the initial input file
# =====================================
if not os.path.isfile(inputFile):
    print('Error: input file {} does not exist. Operation terminated.'.format(str(sys.argv[1])))

with open(inputFile, 'r') as inputFile:
    inputContent = inputFile.readlines()

# Search for #include and paste snippets
# =====================================
lineCount = 0
for line in inputContent:
    strippedLine = line.replace(' ', '').replace('\n', '')
    if re.search("^#include", strippedLine, re.IGNORECASE):
        filePath = getPathFromInclude(strippedLine)
        with open(filePath, 'r') as f:
            fc = f.readlines()
        del inputContent[lineCount]
        insertToAt(fc, inputContent, lineCount)
    lineCount += 1

# Use temp files to acquire the main body of the code
# =====================================
with open('_codeBody.moon', 'w') as mf:
    mf.writelines(inputContent)

os.system('moonc _codeBody.moon')
with open('_codeBody.lua', 'r') as lf:
    codeBody = lf.readlines()

# Strip codes in P8 file
# =====================================
with open(p8File, 'r') as p8f:
    content = p8f.readlines()

lineCount = 0
for line in content:
    if line.replace('\n', '') == "__lua__":
        code_start_line = lineCount
    if line.replace('\n', '') == "__gfx__":
        code_end_line = lineCount

    lineCount += 1

if not code_start_line:
    sys.exit("Error: cannot find lua code marker in pico-8 cartridge. Please use a valid output cartridge.")

if not code_end_line:
    sys.exit("Error: cannot find gfx marker in pico-8 cartridge. Please use a valid output cartridge.")

# # debug
# print(code_start_line)
# print(code_end_line)

for i in range(code_end_line - code_start_line - 1):
    del content[code_start_line + 1]

# Final processing
# =====================================
insertToAt(codeBody, content, code_start_line + 1)
writeListToFile(p8File, content)

# Cleaning up temp files
# =====================================
os.remove("_codeBody.moon")
os.remove("_codeBody.lua")

print(f'Lua codes injected to {p8File} from {inputFile.name} without any issue detected')
