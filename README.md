# GNU Emacs Configuration

<div align="center">

![Emacs Logo](https://www.gnu.org/software/emacs/images/emacs.png)

**A highly customized, modular GNU Emacs configuration with neon aesthetics and developer-focused optimizations**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Emacs Version](https://img.shields.io/badge/Emacs-29.1+-blue.svg)](https://www.gnu.org/software/emacs/)
[![Maintained](https://img.shields.io/badge/Maintained-Yes-green.svg)](https://github.com/alperencolgecen/gnu-emacs)

</div>

## 🌟 Features

### 🎨 **Visual Design**
- **Neon Cyan Theme** - Custom #00FFFF cyan on dark backgrounds with box borders
- **Minimalist UI** - Clean interface with toggleable elements
- **Relative Line Numbers** - Better navigation in code
- **Rainbow Delimiters** - Color-coded parentheses matching
- **JetBrains Mono Font** - Professional programming typography

### ⚡ **Performance Optimizations**
- **Garbage Collection Tuning** - 100MB during init, 16MB after startup
- **Native Compilation** - Optimized byte-code compilation
- **File Watching** - Case-insensitive filesystem support
- **Font Cache Management** - Prevents compacting for better performance

### 🔧 **Developer Tools**
- **Modern Completion** - Vertico + Marginalia + Orderless
- **Git Integration** - Magit for version control
- **File Tree** - Treemacs for project navigation
- **Auto-completion** - Company with intelligent suggestions
- **Key Discovery** - Which-key shows available bindings

### 🎮 **Unique Features**
- **Ghost Lock Mode** (`F12`) - Hide cursor and lock input
- **UI Toggle** (`F7`/`F9`) - Show/hide menu/tool/scroll bars
- **Enhanced Search** - Wrap-around with match counting
- **Smart Navigation** - Ace-window and Avy for fast movement

## 📁 Architecture

This configuration uses a **modular architecture** with 8 specialized modules:

```
.emacs.d/
├── init.el              # Bootstrap and module loader (12 lines)
├── modules/
│   ├── packages.el      # Package management and archives
│   ├── performance.el  # Startup and runtime optimizations
│   ├── ui.el          # Interface and visual settings
│   ├── font.el        # Typography and line numbers
│   ├── editor.el      # Core editing behaviors
│   ├── theme.el       # Doom theme and custom faces
│   ├── plugins.el     # Third-party package configurations
│   └── keybindings.el # Custom key bindings and functions
├── custom.el          # User customizations (auto-generated)
├── .gitignore         # Version control exclusions
└── LICENSE            # MIT License
```

### 🚀 **Module Loading Order**

1. **packages** - Sets up package.el and archives
2. **performance** - Applies startup optimizations
3. **ui** - Configures interface elements
4. **font** - Sets up typography
5. **editor** - Core editing behaviors
6. **theme** - Loads doom-vibrant theme
7. **plugins** - Configures third-party packages
8. **keybindings** - Sets up custom key bindings

## 🎯 Key Bindings

### 📁 **File Operations**
- `C-a` - Select all
- `C-s` - Save buffer
- `C-S-s` - Save as
- `C-k C-o` - Open file
- `C-r` - Recent files

### 🔍 **Search & Navigation**
- `C-f` - Search forward
- `C-S-f` - Search backward
- `C-h` - Query replace
- `M-g` - Go to line
- `M-o` - Ace window selection
- `M-s` - Avy jump to char

### 🎨 **Interface**
- `F7` / `F9` - Toggle UI elements
- `F12` - Ghost lock mode
- `C-wheel-up/down` - Text scaling

### 🛠️ **Development**
- `C-x g` - Magit status
- `F8` - Toggle Treemacs

## 🎨 Theme Configuration

### **Neon Color Palette**
```elisp
;; Primary Colors
#00FFFF  ; Neon Cyan (foreground)
#0d0d1a  ; Dark Background (mode-line)
#1a1a2e  ; Medium Background (menu/tool-bar)
#005f5f  ; Inactive Cyan

;; Applied Elements
- Mode line: Cyan on dark with box border
- Menu/Tool bar: Cyan on medium background
- Header line: Matching mode-line style
- Inactive elements: Muted cyan
```

## 📦 Package List

### **Core Packages**
- `doom-themes` - Theme framework
- `rainbow-delimiters` - Colorized parentheses
- `vertico` - Vertical completion UI
- `marginalia` - Completion annotations
- `orderless` - Flexible completion style

### **Development Tools**
- `magit` - Git interface
- `company` - Auto-completion
- `treemacs` - File tree viewer
- `which-key` - Key binding helper

### **Navigation**
- `ace-window` - Window selection
- `avy` - Fast navigation

## 🚀 Installation

### **For Emacs Users**
1. **Clone the repository**
   ```bash
   git clone https://github.com/alperencolgecen/gnu-emacs.git ~/.emacs.d
   ```

2. **Restart Emacs**
   - The configuration will automatically download and install packages
   - All modules will be loaded in the correct order

3. **Customize (Optional)**
   - Edit `custom.el` for personal settings
   - Add new modules to the `modules/` directory

### **For VS Code Users**
If you're coming from VS Code, this configuration includes familiar workflows:

**VS Code → Emacs Equivalents:**
- `Ctrl+P` → `C-x C-f` (Open file) or `C-r` (Recent files)
- `Ctrl+Shift+P` → `M-x` (Command palette)
- `Ctrl+` → `C-x` (Prefix for file operations)
- `Ctrl+Tab` → `M-o` (Ace window switcher)
- `Ctrl+Goto` → `M-g` (Go to line)
- `Ctrl+F` → `C-f` (Search)
- `Ctrl+H` → `C-h` (Replace)

**Learning Resources:**
- [Emacs Tutorial](https://www.gnu.org/software/emacs/tour/) - Built-in tutorial (`C-h t`)
- [Emacs Wiki](https://www.emacswiki.org/) - Comprehensive documentation
- [System Crafters](https://systemcrafters.net/) - Modern Emacs content

**Transition Tips:**
- Use `M-x describe-key` to learn what keys do
- Enable `which-key-mode` (included) for key suggestions
- Start with basic editing, gradually learn advanced features

## ⚙️ Customization

### **Adding New Modules**
1. Create `modules/my-module.el`
2. Add to `init.el` module list
3. Follow the established patterns:
   ```elisp
   ;;; my-module.el --- Module Description
   
   ;; Configuration here
   ```

### **Modifying Theme**
Edit `modules/theme.el` to adjust colors:
```elisp
(custom-set-faces
 '(mode-line ((t (:foreground "#YOUR_COLOR" :background "#YOUR_BG"))))
 ;; Add more face definitions
)
```

## 🐛 Troubleshooting

### **Common Issues**

**Packages not installing:**
```elisp
M-x package-refresh-contents
M-x package-install-p
```

**Performance issues:**
- Check `performance.el` GC settings
- Verify native compilation is working

**Theme not loading:**
- Ensure `doom-themes` is installed
- Check `theme.el` for errors

### **Getting Help**
- Open an issue on GitHub
- Check `*Messages*` buffer in Emacs
- Use `M-x describe-variable` for settings

## 📈 Performance

### **Startup Time**
- Target: < 2 seconds
- Achieved through: GC tuning, lazy loading, byte compilation

### **Memory Usage**
- Base: ~50MB
- With packages: ~100MB
- Optimized through: Efficient GC thresholds

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

### **Guidelines**
- Follow the modular architecture
- Add comments explaining WHY (not what)
- Use English for all custom functions
- Maintain consistent naming (`my/` prefix)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Doom Emacs** - Inspiration for theme and structure
- **System Crafters** - Modular configuration patterns
- **GNU Project** - The amazing Emacs editor itself

## 📊 Statistics

- **Total Lines:** ~1,200 (across all modules)
- **Modules:** 8 specialized files
- **Key Bindings:** 20+ custom bindings
- **Packages:** 15+ configured packages
- **Startup Time:** ~1.5 seconds

---

<div align="center">

Prepared by Alperen Çölgeçen

</div> 
