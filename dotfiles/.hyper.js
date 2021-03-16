// /Users/USERNAME/.hyper.js

module.exports = {
  config: {
    fontSize: 17,
    fontFamily: 'Cascadia Code, Source Code Pro for Powerline, Hack Nerd Font',
    //backgroundColor: '#000',
    //transparentBg: {
    //   WebkitFilter: 'blur(5px)',
    //  opacity: '0.5'
    //},
    shell: '/bin/zsh',
    scrollback: 10000,
    hyperTransparent: {
      backgroundColor: '#000',
      opacity: 0.5,
      vibrancy: ' ' // ['', 'dark', 'medium-light', 'ultra-dark']
    }
  },
  plugins: [
    //"hyperterm-material",
  //"hyper-transparent-bg",
  //"hyperterm-paste",
  //"hyper-dark-vibrancy"
  //"hyper-broadcast", 
  //"hyper-search", 
  //"hyper-statusline", 
  //"hyper-tab-icons-plus", 
  //"hyper-blink", 
  //"hyper-kage"
  //"hyper-solarized-dark-transparent", 
  "hyper-transparent", "hyper-pane"],
  //env: {
  //  "HYPER_PASTE_SEPARATOR": " & "
  //},
};
