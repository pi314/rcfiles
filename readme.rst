My rcfiles collection
=======================
Thanks to Pellaeon, now I used github to manage my rcfiles.
This repository includes .tcshrc, .vimrc, and .screenrc

.tcshrc
=======================
Basically this file is modified from the sample file which is provided by NCTUCS.
I spent a lot of time adjusting the color of ``ls`` command recently,
because there are two ``ls`` command (or more), one is GNU's ``ls``, another is BSD's ``ls``.

GNU's ``ls`` command uses ``--color`` option to encoloring the output,
and the setting of colors is in environment variable ``LS_COLOR``.

BSD's ``ls`` command uses ``-G`` option to encoloring the output,
and the setting of colors is in environment variable ``LSCOLORS``

Of course the format of ``LS_COLOR`` and ``LSCOLORS`` is different...

So I add ``if ( `uname` == "FreeBSD" )`` to recognize operating system.

.vimrc
========
I didn't spent much time on tuning my vim, actually I don't like to use plugins (except for the tab plugin).
There are a few hot-keys I used to manage tabs.

-   <C-j> switch to previous tab.
-   <C-k> switch to next tab.
-   <C-t> Add a new tab.
-   <C-p> move current tab to previous position.
-   <C-n> move current tab to next position.
-   <S-tab> in insert mode to unindent a line.
    Notice that I use Cygwin, so I have to use <ESC>[Z to present <S-tab>.

.screenrc
===========
I spent a lot of time on adjusting the color of screen's caption.
Thereis a strange thing that, same color setting, results different between Cygwin's screen and BSD's screen.
