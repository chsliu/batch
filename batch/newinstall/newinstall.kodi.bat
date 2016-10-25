set path=%path%;C:\Program Files (x86)\Git\cmd

cinst -y git kodi

mkdir %appdata%\Kodi
pushd %appdata%\Kodi
git clone https://github.com/chsliu/userdata.git
popd

