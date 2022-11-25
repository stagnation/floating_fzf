Overview
========

This project uses fzf in a floating terminal to replace dmenu in several
use-cases. The benefit is to use the same fuzzy-matching algorithm in all
applications. From the shell, in vim and when navigating windows with
quickswitch: https://github.com/OliverUv/quickswitch-for-i3/


FZF_selector
============

Use fzf as a selector similar to dmenu

In addition to the settings from FZF_launcher this accepts input from standard
input and populates fzf with entries from any command. The output from fzf is
saved to a file and later output from the selector after the terminal with fzf
exits.

Any script can be used to populate the floating fzf selector and the
selection can be put to use with any script. See the included fzf_launcher for
an example.

The structure of an invocation is
`$source | fzf_selector [fzf settings] | $sink`

$source needs to generate newline-separated entries on std-out and $sink needs to
consume the output via a pipe. xargs can be used if the desired sink program
takes input on the command line.

Refer to fzf's manual for available settings and flags. And note that due to
shell escaping and quoting inside the scripts, multi-word values need to be
escaped as ` fzf_selector --prompt \'one two :\'

i3 binding
----------

bindsym $mod+Tab exec ~/bin/gits/quickswitch-for-i3/quickswitch.py --dmenu fzf_selector

usage combined with quickswitch
-------------------------------
quickswitch: https://github.com/OliverUv/quickswitch-for-i3/

`
$ quickswitch.py --dmenu fzf_selector <extra arguments>
`

screenshot
----------

![Screenshot](./selector.png)

FZF launcher
============

Use fzf as a launcher similar to dmenu_run.
As per https://medium.com/njiuko/using-fzf-instead-of-dmenu-2780d184753f .

Three scripts are composed as well as some i3 rules to display the launcher in a
floating terminal.

* fzf_launcher.sh
    the launcher, creates a new terminal window with a specific window class.
    This populates fzf with all the binaries in $PATH and launches the selection

    This is a wrapper script around fzf_selector

* listbins.sh
    prints all binaries in $PATH

* start_independent_process.py
    start a process in the background and disowns it so it survives when the
    launcher process exits.


i3 rules
--------
`
for_window [class = "URxvt" instance = "FloatingTerminal$"] floating enable
`

Some terminals might require different rules, use xprop to find the required window
information about the terminal.

i3 binding
----------

bindsym $mod+space exec fzf_launcher

screenshot
----------

![ScreenShot](launcher.png)


Troubleshooting
===============

During development of these scripts I had trouble getting them to run properly
when launched from i3. That is because i3 and my shells have different $PATH
values. The spawned URxvt terminal would then only flicker and no select
properly from the input. To solve this make sure that the shells spawned by i3
can find all the necessary scripts. This includes fzf, if fzf is installed in a
non-standard location.

I have the following symlinks:
```
lrwxrwxrwx  ~/bin/fzf -> ~/.fzf/bin/fzf
lrwxrwxrwx  ~/bin/fzf_launcher.sh -> ~/repos/floating_fzf/bin/fzf_launcher.sh
lrwxrwxrwx  ~/bin/fzf_selector.sh -> ~/repos/floating_fzf/bin/fzf_selector.sh
lrwxrwxrwx  ~/bin/listbins.sh -> ~/repos/floating_fzf/bin/listbins.sh
lrwxrwxrwx  ~/bin/start_independent_process.py -> ~/repos/floating_fzf/bin/start_independent_process.py
```

with i3 config:
```
bindsym $mod+space exec fzf_launcher.sh
set $quickswitch ~/bin/gits/quickswitch-for-i3/quickswitch.py --dmenu fzf_selector.sh
bindsym $mod+Tab exec $quickswitch
```

Contribution
============

Pull requests are welcome, as well as information and issues found when used in
different setups.
