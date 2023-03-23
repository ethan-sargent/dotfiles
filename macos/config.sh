# delay before starting to repeat
defaults write -g InitialKeyRepeat -int 12
# repeat speed
defaults write -g KeyRepeat -int 1

defaults write com.apple.dock expose-animation-duration -int 0
# Remove window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
# Reduce/remove resize time
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
