set -x

xargs brew install < ~/.packages/brew.txt
xargs brew cask install < ~/.packages/brew-cask.txt
xargs pip install < ~/.packages/pip.txt
xagrs pip2.7 install < ~/.packages/pip27.txt
xargs npm update --global < ~/.packages/npm.txt
