// /Users/USERNAME/.hyper.js

module.exports = {
  config: {
    fontSize: 15,
    fontFamily: 'Cascadia Code, Source Code Pro for Powerline, Hack Nerd Font',
    backgroundColor: '#000',
    transparentBg: {
      WebkitFilter: 'blur(5px)',
      opacity: '0.2'
    },
    shell: '/bin/zsh',
    scrollback: 10000
  },
  plugins: [
    //"hyperterm-material",
    "hyper-transparent-bg",
    "hyper-broadcast",
    "hyper-search",
    "hyper-statusline",
    "hyper-tab-icons-plus",
    "hyper-blink",
    //"hyperterm-paste",
    //"hyper-dark-vibrancy"
  ],
  //env: {
  //  "HYPER_PASTE_SEPARATOR": " & "
  //},
};

