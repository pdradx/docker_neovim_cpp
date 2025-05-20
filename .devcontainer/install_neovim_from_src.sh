cd /tmp
git clone --depth=1 --branch stable https://github.com/neovim/neovim
cd neovim

make CMAKE_BUILD_TYPE=Release
make install

cd /tmp
rm -rf ./neovim

