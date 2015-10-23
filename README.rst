=====================
My rcfiles collection
=====================

Thanks to Pellaeon_, now I used github to manage my rcfiles.

..  _Pellaeon: https://github.com/pellaeon

I am trying to make it portable on every UNIX-like machine (Linux, FreeBSD, Cygwin, Mac OS X, etc.)

Installation
------------

1.  ``git clone https://github.com/pi314/rcfiles``
2.  (optional) ``mv rcfiles .rcfiles; cd .rcfiles``
3.  ``sh setup.sh``

Your old rcfiles will be backed up (but soft links are not.)

.tcshrc
-------

Basically this file is modified from the sample file which is provided by NCTUCS.
I spent a lot of time adjusting the color of ``ls`` command,
because there are two versions of ``ls`` command (or more), one is GNU version, another is BSD version.

GNU ``ls`` command uses ``--color`` option to encoloring the output,
referencing the environment variable ``LS_COLOR``.

BSD ``ls`` command uses ``-G`` option to encoloring the output,
referencing the environment variable ``LSCOLORS``.

Of course the format of ``LS_COLOR`` and ``LSCOLORS`` is different, so I added ``if ( `uname` == "FreeBSD" )`` to check operating system type.

.vim
----
Thanks to Iblis_, he introduced me the ``Vundle`` plugin.

..  _Iblis: https://github.com/iblis17

Currently I am using

* `Vundle.vim <https://github.com/gmarik/Vundle.vim>`_
* `nerdtree <https://github.com/scrooloose/nerdtree>`_
* `vim-nerdtree-tabs <https://github.com/jistr/vim-nerdtree-tabs>`_
* `tcomment_vim <https://github.com/tomtom/tcomment_vim>`_
* `vim-surround <https://github.com/tpope/vim-surround>`_
* `vim-table-mode <https://github.com/dhruvasagar/vim-table-mode>`_
* `pi314.boshiamy.vim <https://github.com/pi314/pi314.boshiamy.vim>`_
* `pi314.asciiart.vim <https://github.com/pi314/pi314.asciiart.vim>`_
* `pi314.rst.vim <https://github.com/pi314/pi314.rst.vim>`_
* `todo-or-not-todo.vim <https://github.com/pi314/todo-or-not-todo.vim>`_
* `zdict.vim <https://github.com/zdict/zdict.vim>`_

These are my hot-key settings

* Normal Mode

  - ``th`` switch to previous tab.
  - ``tl`` switch to next tab.
  - ``tt`` Add a new tab.
  - ``tp`` move current tab to previous position.
  - ``tn`` move current tab to next position.
  - ``<CR>`` insert a new line.
  - ``<C-n>`` toggle NERD-tree.
  - ``dq`` do movements in register ``"q``.
  - ``dz`` do movements in register ``"z``.

* Insert Mode

  - ``<leader>p`` toggle paste mode

.screenrc
---------

Ctrl+Left, Ctrl+Right to switch between windows

.tmux.conf
----------

Shift+Left, Shift+Right to switch between windows

.bashrc
-------

Similar to ``.tcshrc``, some color settings adjusted.

zsh
----

After failure on implementing ``tcsh`` two line prompt, I switched to ``zsh``.

I love my zsh prompt, I placed many infomations in it: (of course it may be slower, I don't care)

* Last command return code
* Python virtual env name
* Current git repository name and branch name and status (clean, dirty, or very dirty)
* Suspended jobs
* Today's date
* Directory stack depth (``pushd`` and ``popd``)
* Current path
* Zsh vim mode (insert or command mode)
* Time (not automatically update)
* Username
* Hostname
* Current user privilege

All information in three lines, YEAH!

There is a variable ``$today``,
which updates with every prompt, in ``"+%Y%m%d"`` format,
for me to complete some folder name.
