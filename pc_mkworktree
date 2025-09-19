#!/usr/bin/env python

import os
import argparse
import subprocess
import pathlib

parser = argparse.ArgumentParser(
	description = "Create a new worktree, checking out a particular local branch of the Pencil code",
	formatter_class = argparse.ArgumentDefaultsHelpFormatter,
	# epilog = "Example: %(prog)s  gputestv6",
	)
parser.add_argument('BRANCH', type=str, help="Name of the branch to clone in the new worktree")
parser.add_argument('--root', type=str, help="Location to use for the worktree", default=".")

args = parser.parse_args()
branch = args.BRANCH
worktrees_root = pathlib.Path(args.root).absolute()

pencil_home = os.getenv("PENCIL_HOME")
if pencil_home is None:
	raise RuntimeError("Environment variable PENCIL_HOME is not defined")

worktree_loc = worktrees_root/branch

bashrc_content = rf"""renice -n 19 $$ > /dev/null

export PENCIL_HOME={worktree_loc}
_sourceme_quiet=1; . $PENCIL_HOME/sourceme.sh; unset _sourceme_quiet

#Misc customizations
PS1="\e[01;34m[\u@\h \W]\$ \e[m"
alias ipy='ipython --profile=pencil'
alias pcrun='pc_run; notify-send -t 5000 "Simulation done"'
alias mkvid='pc_build -t read_all_videofiles && ./src/read_all_videofiles.x'
"""

subprocess.run([
		"git",
		"-C", pencil_home,
		"worktree",
		"add", worktree_loc, branch,
		],
	check=True,
	)

with open(worktree_loc/"bashrc", mode='x') as f:
	f.write(bashrc_content)

print(f"""Created worktree at
{worktree_loc}
To use it, change into that directory and run
bash --rcfile bashrc
When you no longer need this worktree, run
git worktree remove --force {worktree_loc}
""")
