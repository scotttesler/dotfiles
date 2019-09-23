// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

module.exports = {
  config: {
    backgroundColor: "#000",
    bell: "SOUND",
    borderColor: "#333",
    colors: {
      black: "#000000",
      blue: "#0A2FC4",
      cyan: "#20C5C6",
      green: "#1DC121",
      lightBlack: "#686868",
      lightBlue: "#6A76FB",
      lightCyan: "#68FDFE",
      lightGreen: "#67F86F",
      lightMagenta: "#FD7CFC",
      lightRed: "#FD6F6B",
      lightWhite: "#FFFFFF",
      lightYellow: "#FFFA72",
      magenta: "#C839C5",
      red: "#C51E14",
      white: "#C7C7C7",
      yellow: "#C7C329"
    },
    copyOnSelect: false,
    css: "",
    cursorAccentColor: "#000",
    cursorBlink: false,
    cursorColor: "rgba(248,28,229,0.8)",
    cursorShape: "BLOCK",
    defaultSSHApp: true,
    env: {},
    fontFamily:
      'Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',
    fontSize: 12,
    fontWeight: "normal",
    fontWeightBold: "bold",
    foregroundColor: "#fff",
    letterSpacing: 0,
    lineHeight: 1,
    macOptionSelectionMode: "force",
    padding: "12px 14px",
    quickEdit: false,
    selectionColor: "rgba(248,28,229,0.3)",
    shell: "/bin/zsh",
    shellArgs: ["--login"],
    showHamburgerMenu: "",
    showWindowControls: "",
    termCSS: "",
    updateChannel: "canary",
    webGLRenderer: true
  },
  keymaps: {},
  localPlugins: [],
  plugins: ["hyper-dracula"]
};
