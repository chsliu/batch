import os
for file in os.listdir('.'):
    if file.endswith('.iso'):
        os.system('wbfs_file.exe "%s"' % file)
        os.system('del "%s"' % file)

os.system('del *.url')
os.system('del *.txt')
