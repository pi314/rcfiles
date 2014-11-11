My rcfiles collection
=====================

Thanks to Pellaeon_, now I used github to manage my rcfiles.

..  Pellaeon_: https://github.com/pellaeon

I am trying to make it portable on every UNIX-like machine (Linux, FreeBSD, Cygwin, Mac OS X, etc.)

Installation
============

1.  ``git clone https://github.com/pi314/rcfiles``
2.  (optional) ``mv rcfiles .rcfiles; cd .rcfiles``
3.  ``sh setup.sh``

Old rcfiles will be backed up, after these configuration file being installed, ``setup.sh`` will ask you if you want to install vim plugins.

Remember to change the user data in ``.gitconfig`` (or delete it)

.tcshrc
=======

Basically this file is modified from the sample file which is provided by NCTUCS.
I spent a lot of time adjusting the color of ``ls`` command,
because there are two versions of ``ls`` command (or more), one is GNU version, another is BSD version.

GNU ``ls`` command uses ``--color`` option to encoloring the output,
referencing the environment variable ``LS_COLOR``.

BSD ``ls`` command uses ``-G`` option to encoloring the output,
referencing the environment variable ``LSCOLORS``.

Of course the format of ``LS_COLOR`` and ``LSCOLORS`` is different.

So I added ``if ( `uname` == "FreeBSD" )`` to check operating system type.

.vim
====
Thanks to Iblis_, he introduced me the ``Vundle`` plugin.

..  Iblis_: https://github.com/iblis17

Currently I am using

- Vundle
- NERD-tree
- riv.vim
- tcomment_vim

These are my hot-key settings

- ``tj`` switch to previous tab.
- ``tk`` switch to next tab.
- ``tt`` Add a new tab.
- ``tp`` move current tab to previous position.
- ``tn`` move current tab to next position.
- ``<C-n>`` toggle NERD-tree.

My ``.vim`` folder also contains a boshiamy input method in ``.vim/plugin``.

.screenrc
===========

I use Ctrl+Left, Ctrl+Right to switch between windows

.bashrc
=======

Similar to ``.tcshrc``, some color settings adjusted.

zsh
===

After failure on adjusting tcsh two line prompt, I switched to ``zsh``.

I love my zsh prompt, I placed many infomations in it: (of course it may be slower, I don't care)

- last command return code
- directory stack depth (``pushd`` and ``popd``)
- current path
- current git branch name
- current git branch status (clean, dirty, or very dirty)
- suspend jobs
- zsh vim mode (insert or command mode)
- time (not automatically update)
- username
- hostname
- current user privilege

All information in two lines, I love it ~
