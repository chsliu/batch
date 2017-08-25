REM using a 1TB file
REM 8 threads of execution, each generating 8 outstanding random 8KB unbuffered read IOs

diskspd.exe -c1000G -d10 -r -w0 -t8 -o8 -b8K -h -L X:\testfile.dat

