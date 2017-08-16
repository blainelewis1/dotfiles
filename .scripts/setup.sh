set -x

./install-packages.sh

open -a "Google Chrome" https://www.keepassx.org/downloads

wget -N -P ~/Library/Fonts https://github.com/tonsky/FiraCode/raw/master/distr/otf/FiraCode-Bold.otf
wget -N -P ~/Library/Fonts https://github.com/tonsky/FiraCode/raw/master/distr/otf/FiraCode-Light.otf
wget -N -P ~/Library/Fonts https://github.com/tonsky/FiraCode/raw/master/distr/otf/FiraCode-Medium.otf
wget -N -P ~/Library/Fonts https://github.com/tonsky/FiraCode/raw/master/distr/otf/FiraCode-Regular.otf
wget -N -P ~/Library/Fonts https://github.com/tonsky/FiraCode/raw/master/distr/otf/FiraCode-Retina.otf