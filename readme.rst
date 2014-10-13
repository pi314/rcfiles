My rcfiles collection
=======================
Thanks to Pellaeon, now I used github to manage my rcfiles.

.tcshrc
=======
Basically this file is modified from the sample file which is provided by NCTUCS.
I spent a lot of time adjusting the color of ``ls`` command recently,
because there are two versions of ``ls`` command (or more), one is GNU version, another is BSD version.

GNU ``ls`` command uses ``--color`` option to encoloring the output,
referencing the environment variable ``LS_COLOR``.

BSD ``ls`` command uses ``-G`` option to encoloring the output,
referencing the environment variable ``LSCOLORS``.

Of course the format of ``LS_COLOR`` and ``LSCOLORS`` is different.

So I added ``if ( `uname` == "FreeBSD" )`` to check operating system type.

.vimrc
======
Thanks to iblis17, he introduced me the ``Vundle`` plugin.

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

.screenrc
===========

.bashrc
=======
Similar to .tcshrc
