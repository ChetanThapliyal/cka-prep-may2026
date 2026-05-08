# CKA Exam Day Tips

This document contains tips to save critical seconds during the exam.

## The Remote Desktop & Terminal

- **Copying and Pasting:** The terminal inside the PSI Bridge environment does not use standard copy/paste shortcuts. If you are copying and pasting text back and forth from the Firefox browser and the terminal, use the keyboard shortcut `CTRL + SHIFT + C` to copy and `CTRL + SHIFT + V` to paste.
- **Root Access:** You can gain `root` access on the exam nodes by running `sudo -i`. You do not need a password.
- **Multiple Terminals:** The exam environment is a single monitor. If you need multiple terminal windows, it is highly recommended to know basic `tmux` commands (which is pre-installed) to split your terminal horizontally or vertically.

## Time Savers

- **Use the aliases:** Always source your `setup-env.sh` (or type out the aliases) at the start of your exam. Using `k` instead of `kubectl` saves hundreds of keystrokes.
- **Never write YAML from scratch:** Always use `--dry-run=client -o yaml > file.yaml` to generate the base structure of a Pod, Deployment, or Job.
- **Grace Period:** When deleting pods, add `--force --grace-period=0` to delete them instantly instead of waiting 30 seconds.
