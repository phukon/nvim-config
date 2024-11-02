<div align="center">
<h1>My Neovim setup</h1>

![Static Badge](https://img.shields.io/badge/Neovim-phukon-blueviolet.svg?style=flat-square&logo=Neovim&color=90E59A&logoColor=white)

</div>

> I must give credit where it's due, my setup is built on top of Neovim's [NvChad](https://nvchad.com/) flavour, created by the awesome [@sciduck](https://github.com/siduck)

---

## Added:

- Language servers
  - CLang/C++
  - Golang
  - Typescript
  - Javascript
- Auto imports
- Check for unused variables in Golang
- Debugger (Golang, CLang/C++ and Typescript)
- Tailwind auto-completion snippets
- Golang auto-completion snippets
- Golang Auto-formatter
- CLang/C++ auto-completion snippets
- CLang/C++ Auto-formatter

## ⚠ Caveats

You should have the following packages <u>installed in your system</u> (Globally/GOPATH for using Golang features)

- gofumpt
- goimports_reviser
- golines
- prettier

## My plugin config.:

1. **neovim/nvim-lspconfig**
2. **williamboman/mason.nvim**
   - Installed Language Servers:
     - gopls
     - eslint-lsp
     - tailwindcss-language-server
     - typescript-language-server
3. **mfussenegger/nvim-dap**
4. **leoluz/nvim-dap-go**
   - For Go language
   - Depends on mfussenegger/nvim-dap
5. **jose-elias-alvarez/null-ls.nvim**
   - For various languages: go, javascript, typescript, html, json, yaml
6. **olexsmir/gopher.nvim**
   - For Go language
   - Depends on mfussenegger/nvim-dap
   - Additional setup using Gopher and related mappings

> What is it?
>
> - NvChad is a neovim config written in lua aiming to provide a base configuration with very beautiful UI and blazing fast startuptime (around 0.02 secs ~ 0.07 secs). UI plugins such as telescope, nvim-tree, bufferline etc are tweaked well to provide an aesthetic UI experience.

`C:\Users\<user_name>\AppData\Local\nvim`
