## CKA Tips Kubernetes 1.35

## Knowledge

**General**
- Study all topics as proposed in the curriculum until you feel comfortable with all
- Do both test sessions with this CKA Simulator.
- Be fast and breathe `kubectl`
- The majority of tasks in the CKA will also be around creating Kubernetes resources, like it's tested in the CKAD. So preparing a bit for the CKAD can't hurt.
- Learn and Study the in-browser scenarios on [https://killercoda.com/killer-shell-cka](https://killercoda.com/killer-shell-cka) (and maybe for CKAD [https://killercoda.com/killer-shell-ckad](https://killercoda.com/killer-shell-ckad))

**Components**
- Understanding Kubernetes components and being able to fix and investigate clusters: [https://kubernetes.io/docs/tasks/debug-application-cluster/debug-cluster](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-cluster)
- Know advanced scheduling: [https://kubernetes.io/docs/concepts/scheduling/kube-scheduler](https://kubernetes.io/docs/concepts/scheduling/kube-scheduler)
- When you have to fix a component (like `kubelet`) in one cluster, just check how it's setup on another node in the same or even another cluster. You can copy config files over etc.
- If you like you can look at [Kubernetes The Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way) once. But it's NOT necessary to do, the CKA is not that complex. But KTHW helps understanding the concepts.
- You should install your own cluster using kubeadm (one controlplane, one worker) in a VM or using a cloud provider and investigate the components.
- Know how to use Kubeadm to for example add nodes to a cluster.
- Know how to create an Ingress resources.

## CKA Exam Info

**Read the Curriculum**
```cardlink
url: https://github.com/cncf/curriculum
title: "GitHub - cncf/curriculum: 📚Open Source Curriculum for CNCF Certification Courses"
description: "📚Open Source Curriculum for CNCF Certification Courses - cncf/curriculum"
host: github.com
favicon: https://github.githubassets.com/favicons/favicon.svg
image: https://opengraph.githubassets.com/3c0a8ddb1a9711af37b30a7058fab3005a0cc9ef862b116d862cd271f9120058/cncf/curriculum
```

**Read the Handbook**
```cardlink
url: https://docs.linuxfoundation.org/tc-docs/certification/lf-handbook2
title: "Linux Foundation Certification Exam: Candidate Handbook (using PSI BRIDGE Proctoring platform) | T&C DOCS (Candidate Facing Resources)"
description: "This handbook applies to Linux Foundation Exams proctored using the PSI BRIDGE Proctoring Service."
host: docs.linuxfoundation.org
favicon: https://docs.linuxfoundation.org/tc-docs/~gitbook/icon?size=small&theme=light
image: https://docs.linuxfoundation.org/tc-docs/~gitbook/ogimage/-MN0KIGEc-hagOdn3TD8
```

**Read the important tips**
```cardlink
url: https://docs.linuxfoundation.org/tc-docs/certification/tips-cka-and-ckad
title: "Important Instructions: CKA and CKAD | T&C DOCS (Candidate Facing Resources)"
host: docs.linuxfoundation.org
favicon: https://docs.linuxfoundation.org/tc-docs/~gitbook/icon?size=small&theme=light
image: https://docs.linuxfoundation.org/tc-docs/~gitbook/ogimage/-MA9TvpgzLuxb33i_uoZ
```


**Read the FAQ**
```cardlink
url: https://docs.linuxfoundation.org/tc-docs/certification/faq-cka-ckad
title: "Frequently Asked Questions: CKA and CKAD & CKS | T&C DOCS (Candidate Facing Resources)"
host: docs.linuxfoundation.org
favicon: https://docs.linuxfoundation.org/tc-docs/~gitbook/icon?size=small&theme=light
image: https://docs.linuxfoundation.org/tc-docs/~gitbook/ogimage/-MA9QtVylqcs_rvWPDmJ
```
## Kubernetes documentation

Get familiar with the Kubernetes documentation and be able to use the search. Allowed resources are:
- [https://kubernetes.io/docs](https://kubernetes.io/docs)
- [https://kubernetes.io/blog](https://kubernetes.io/blog)
- [https://helm.sh/docs](https://helm.sh/docs)
- [https://gateway-api.sigs.k8s.io](https://gateway-api.sigs.k8s.io/)

> ℹ️ Verify the list [here](https://docs.linuxfoundation.org/tc-docs/certification/certification-resources-allowed)

## The Exam UI / Remote Desktop

The real exam, as well as the simulator, provides a Remote Desktop (XFCE) on Ubuntu/Debian. Coming from OSX/Windows there will be changes in copy&paste for example.

**Official Information**
[ExamUI: Performance Based Exams](https://docs.linuxfoundation.org/tc-docs/certification/lf-handbook2/exam-user-interface/examui-performance-based-exams)

**Lagging**
There could be some lagging, definitely make sure you are using a good internet connection because your webcam and screen are transferring all the time.

**Kubectl autocompletion and commands**
The following are installed or pre-configured, verify the list [here](https://docs.linuxfoundation.org/tc-docs/certification/tips-cka-and-ckad):
- `kubectl` with `k` alias and Bash autocompletion
- `yq` or YAML processing
- `curl` and `wget` for testing web services
- `man` and man pages for further documentation

> ℹ️ You're allowed to install tools, like `tmux` for terminal multiplexing or `jq` for JSON processing

**Copy & Paste**
Copy and pasting will work like normal in a Linux Environment:

What always works: copy+paste using right mouse context menu 
What works in Terminal: `Ctrl+Shift+c` and `Ctrl+Shift+v` 
What works in other apps: like *Firefox*: `Ctrl+c` and `Ctrl+v`

**Score**
There are **15-20 questions** in the exam. Your results will be automatically checked according to the handbook. If you don't agree with the results you can request a review by contacting the Linux Foundation Support.

**Notepad & Flagging Questions**
You can flag questions to return to later. This is just a marker for yourself and won't affect scoring. You also have access to a simple notepad in the browser which can be used to store any kind of plain text. It might make sense to use this and write down additional information about flagged questions. Instead of using the notepad you could also open Mousepad (XFCE application inside the Remote Desktop) or create a file with Vim.

**VSCodium**
You can use VSCodium to edit files and you can also use its terminal to run commands. You're ***not allowed*** to install any VSCodium extensions.

**Servers**
Each question needs to be solved on a specific instance other than your main terminal. You'll need to connect to the correct instance via ssh, the command is provided before each question.

## PSI Bridge

Starting with [PSI Bridge](https://training.linuxfoundation.org/bridge-migration-2021):
- The exam will be taken using the PSI Secure Browser, which can be downloaded using the newest versions of Microsoft Edge, Safari, Chrome, or Firefox.
- Multiple monitors will no longer be permitted.
- Use of personal bookmarks will no longer be permitted.

The new ExamUI includes improved features such as:
- A remote desktop configured with the tools and software needed to complete the tasks
- A timer that displays the actual time remaining (in minutes) and provides an alert with 30, 15, or 5 minute remaining.
- The content panel remains the same (presented on the Left Hand Side of the ExamUI)

Read more [here](https://training.linuxfoundation.org/bridge-migration-2021).
## Terminal Handling

### Bash Aliases
In the real exam, each question has to be solved on a different instance to which you connect via ssh. This means it's not advised to configure bash aliases because they wouldn't be available on the instances accessed by ssh.
### Be fast
Use the `history` command to reuse already entered commands or use even faster history search through **Ctrl +r** .
If a command takes some time to execute, like sometimes `kubectl delete pod x`. You can put a task in the background using **Ctrl +z** and pull it back into foreground running command `fg`.

You can delete *pods* fast with:
```
k delete pod x --grace-period 0 --force
```

### Vim
Be great with vim.

**Settings**
In case you face a situation where vim is not configured properly and you face for example issues with pasting copied content you should be able to configure via `~/.vimrc` or by entering manually in vim settings mode:

```
xxxxxxxxxx
set tabstop=2
set expandtabset shiftwidth=2
```

The `expandtab` option makes sure to use spaces for tabs.

> Note that changes in `~/.vimrc` will not be transferred when connecting to other instances via ssh.

**Toggle vim line numbers**
When in `vim` you can press **Esc** and type `:set number` or `:set nonumber` followed by **Enter** to toggle line numbers. This can be useful when finding syntax errors based on line - but can be bad when wanting to mark&copy by mouse. You can also just jump to a line number with **Esc** `:22` + **Enter**.

**Copy&Paste**
Get used to copy/paste/cut with vim:
```
xxxxxxxxxx
Mark lines: Esc+V (then arrow keys)
Copy marked lines: yCut marked lines: dPaste lines: p or P
```

**Indent multiple lines**
To indent multiple lines press **Esc** and type `:set shiftwidth=2`. First mark multiple lines using `Shift v` and the up/down keys. Then to indent the marked lines press `>` or `<`. You can then press `.` to repeat the action.