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

inputFile = sys.argv[1]
p8File = sys.argv[2]

if not os.path.isfile(inputFile):
    print('Error: input file {} does not exist. Operation terminated.'.format(str(sys.argv[1])))

    # re.search('r^',)

# Use temp files to acquire the main body of the code
# =====================================
with open(inputFile, 'r') as inputFile, open('_codeBody.moon', 'w') as mf:
    mf.write(inputFile.read())

os.system('moonc _codeBody.moon')
with open('_codeBody.lua', 'r') as lf:
    codeBody = lf.readlines()

# Strip codes in P8 file
# =====================================
with open(p8File, 'r') as p8f:
    content = p8f.readlines()

position = 0
for line in content:
    if line.rstrip('\n') == "__lua__":
        code_start_line = position
    if line.rstrip('\n') == "__gfx__":
        code_end_line = position

    position += 1

# # debug
# print(code_start_line)
# print(code_end_line)

for i in range(code_end_line-code_start_line - 1):
    del content[code_start_line + 1]

# Final processing
# =====================================
insertToAt(codeBody, content, code_start_line+1)
writeListToFile(p8File, content)

# Cleaning up temp files
# =====================================
os.remove("_codeBody.moon")
os.remove("_codeBody.lua")

print('Lua codes injected to', p8File)
print('Operation completed without any detected issue')
