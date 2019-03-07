.vim
====

My vim dot files. the `.vimrc` file is saved to
[vimrc](https://github.com/jessfraz/.vim/blob/master/vimrc).

**Table of Contents**

<!-- toc -->

- [About](#about)
  * [Installing](#installing)
    * [Pathogen](#pathogen)
      * [Plugins Used](#plugins-used)
      - [Contributing](#contributing)
        * [Using the `Makefile`](#using-the-makefile)

        <!-- tocstop -->

        ## About

        ### Installing

        Just run the following commands via terminal to get perfectly set up:

        ```console
        $ cd ~/
        $ git clone --recursive https://github.com/jessfraz/.vim.git .vim
        $ ln -sf $HOME/.vim/vimrc $HOME/.vimrc
        $ cd $HOME/.vim
        $ git submodule update --init
        ```

        ### Pathogen
        The vim dot files make use of the excellent
        [Pathogen](https://github.com/tpope/vim-pathogen) runtime path manager
        to install plugins and runtime files into their own private
        directiories.

        Currently using version 2.4 of Pathogen

        ### Plugins Used

        ## Contributing

        ### Using the `Makefile`

        You can use the [`Makefile`](Makefile) to run a series of commands.

        ```console
        $ make help
        install                        Sets up symlink for user and root .vimrc
        for vim and neovim.
        README.md                      Generates and updates plugin info in
        README.md.
        remove-submodule               Removes a git submodule (ex
        MODULE=bundle/nginx.vim).
        update-pathogen                Updates pathogen.
        update-plugins                 Updates all plugins.
        update                         Updates pathogen and all plugins.
        ```
* [github.com/davidhalter/jedi-vim](https://github.com/davidhalter/jedi-vim.git)
* [github.com/scrooloose/nerdtree](https://github.com/scrooloose/nerdtree.git)
* [github.com/Xuyuanp/nerdtree-plugin.git](https://github.com/Xuyuanp/nerdtree-git-plugin.git)
* [github.com/vim-airline/vim-airline](https://github.com/vim-airline/vim-airline.git)
* [github.com/vim-airline/vim-airline-themes](https://github.com/vim-airline/vim-airline-themes.git)
* [github.com/altercation/vim-colors-solarized](https://github.com/altercation/vim-colors-solarized.git)
* [github.com/elzr/vim-json](https://github.com/elzr/vim-json.git)
* [github.com/hynek/vim-python-pep8-indent](https://github.com/hynek/vim-python-pep8-indent.git)
