import os
import sys
import re

inputFile = sys.argv[1]
p8File = sys.argv[2]

if not os.path.isfile(inputFile):
    print('Error: input file {} does not exist. Operation terminated.'.format(str(sys.argv[1])))

    # re.search('r^',)

# Using temp files to acquire the main body of the code
# =====================================
with open(inputFile, 'r') as inputFile, open('_codebody.moon', 'w') as mf:
    for line in inputFile:
        mf.write(line)

os.system('moonc _codebody.moon ')
with open('_codebody.lua', 'r') as lf:
    codebody = lf.readlines()

# Strip codes in P8 file
# =====================================
with open(p8File, 'r') as p8f:
    content = p8f.readlines()

code_start_line = 0
code_end_line = 0
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

# # debug
# for line in content:
#     print(line.rstrip("\n"))

# Slicing to prepare for insertion
# =====================================
heading = content[:code_start_line + 1]
media = content[code_start_line + 1:]

# # debug
# for line in heading:
#     print(line.rstrip("\n"))
# print("-----------------")
# for line in media:
#     print(line.rstrip("\n"))

# Extending to one single content variable
fullContent = []
fullContent.extend(heading)
fullContent.extend(codebody)
fullContent.extend(media)

# # debug
# for line in fullContent:
#     print(line.rstrip("\n"))

with open(p8File, 'w') as p8f:
    for line in fullContent:
        p8f.write(line)

print('Lua codes injected to', p8File)
print('Operation completed without any detected issue')
