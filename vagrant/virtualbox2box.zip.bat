set path=%path%;d:\Users\sita\Documents\tasks\bin

pushd %1 || exit /b


7za a -tzip -r -y "..\%1.box" *


popd
