# CKA Exam Tips — Kubernetes 1.35

## Study Strategy

### General

- Study all topics as proposed in the curriculum until you feel comfortable with all.
- Do both test sessions with the CKA Simulator (Killer Shell).
- Be fast and breathe `kubectl`.
- The majority of CKA tasks involve creating Kubernetes resources, similar to the CKAD. Preparing a bit for the CKAD can't hurt.
- Learn and study the in-browser scenarios on [killercoda.com/killer-shell-cka](https://killercoda.com/killer-shell-cka) (and optionally [killercoda.com/killer-shell-ckad](https://killercoda.com/killer-shell-ckad)).

### Components

- Understand Kubernetes components and how to fix/investigate clusters: [debug-cluster](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-cluster)
- Know advanced scheduling: [kube-scheduler](https://kubernetes.io/docs/concepts/scheduling/kube-scheduler)
- When you need to fix a component (like `kubelet`) in one cluster, check how it's set up on another node in the same or a different cluster. You can copy config files over.
- Optionally look at [Kubernetes The Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way) once — it's NOT necessary, but helps understanding concepts.
- Install your own cluster using kubeadm (one controlplane, one worker) and investigate the components.
- Know how to use kubeadm to add nodes to a cluster.
- Know how to create Ingress resources.

---

## Official Resources

Read these before exam day:

| Resource | Link |
|---|---|
| **Curriculum** | [github.com/cncf/curriculum](https://github.com/cncf/curriculum) |
| **Candidate Handbook** | [LF Handbook (PSI Bridge)](https://docs.linuxfoundation.org/tc-docs/certification/lf-handbook2) |
| **Important Tips** | [CKA and CKAD Tips](https://docs.linuxfoundation.org/tc-docs/certification/tips-cka-and-ckad) |
| **FAQ** | [CKA/CKAD/CKS FAQ](https://docs.linuxfoundation.org/tc-docs/certification/faq-cka-ckad) |
| **Allowed Resources** | [Certification Resources](https://docs.linuxfoundation.org/tc-docs/certification/certification-resources-allowed) |

---

## Allowed Documentation During Exam

One active Firefox browser tab is permitted, strictly limited to:

- [kubernetes.io/docs](https://kubernetes.io/docs)
- [kubernetes.io/blog](https://kubernetes.io/blog)
- [helm.sh/docs](https://helm.sh/docs)
- [gateway-api.sigs.k8s.io](https://gateway-api.sigs.k8s.io/)

> ℹ️ Verify the latest list [here](https://docs.linuxfoundation.org/tc-docs/certification/certification-resources-allowed).

---

## The Exam Environment

### Remote Desktop

The exam provides a **Remote Desktop (Ubuntu with XFCE desktop environment)** via the PSI Bridge. XFCE is just the desktop environment — the underlying OS is Ubuntu/Debian.

- **Official info:** [ExamUI: Performance Based Exams](https://docs.linuxfoundation.org/tc-docs/certification/lf-handbook2/exam-user-interface/examui-performance-based-exams)
- **Lagging:** There can be some lag. Use a strong internet connection — your webcam and screen stream continuously.

### Pre-installed Tools

The following are pre-configured in the exam environment (verify [here](https://docs.linuxfoundation.org/tc-docs/certification/tips-cka-and-ckad)):

- `kubectl` with `k` alias and Bash autocompletion
- `yq` for YAML processing
- `curl` and `wget` for testing web services
- `man` and man pages for further documentation

> ℹ️ You're allowed to install additional tools, like `tmux` for terminal multiplexing or `jq` for JSON processing.

### PSI Bridge

- The exam uses the **PSI Secure Browser**, downloadable via Edge, Safari, Chrome, or Firefox.
- **Multiple monitors are NOT permitted.**
- **Personal bookmarks are NOT permitted.**
- A timer displays actual time remaining (in minutes) with alerts at 30, 15, and 5 minutes.
- Content panel is on the Left, remote desktop on the Right.
- Read more: [PSI Bridge Migration](https://training.linuxfoundation.org/bridge-migration-2021)

### Root Access

You can gain `root` access on exam nodes by running `sudo -i`. No password needed.

### Scoring

- There are **15-20 questions** in the exam.
- Results are automatically checked.
- **Partial credit** is awarded for incomplete tasks.
- If you disagree with results, contact Linux Foundation Support.

### Notepad & Flagging

You can **flag questions** to return to later (just a personal marker, doesn't affect scoring). A simple **notepad** is available in the browser for plain text notes. Alternatively, open Mousepad (XFCE app) or create a file with Vim.

### VSCodium

You can use VSCodium to edit files and run commands from its integrated terminal. You are **NOT** allowed to install any VSCodium extensions.

### Servers

Each question must be solved on a **specific instance** — you connect via SSH. The command is provided before each question.

---

## Copy & Paste

Coming from macOS/Windows, copy/paste shortcuts differ in the Linux environment:

| Context | Copy | Paste |
|---|---|---|
| **Terminal** | `Ctrl+Shift+C` | `Ctrl+Shift+V` |
| **Firefox / other apps** | `Ctrl+C` | `Ctrl+V` |
| **Right-click menu** | Always works | Always works |

---

## Terminal Handling

### Bash Aliases Don't Persist Across SSH

Each question requires SSHing into a different instance. Aliases set in your main terminal **will NOT** be available after SSH. Don't waste time configuring them.

> The `k` alias for `kubectl` and bash autocompletion are already configured on all instances.

### Be Fast

- Use the `history` command or **Ctrl+R** for reverse search to reuse commands.
- If a command takes time (e.g., `kubectl delete pod x`), put it in the background with **Ctrl+Z** and bring it back with `fg`.
- Delete pods fast:

```bash
k delete pod x --grace-period 0 --force
```

### Never Write YAML from Scratch

Always generate base YAML with `--dry-run=client -o yaml`:

```bash
k run nginx --image=nginx --dry-run=client -o yaml > pod.yaml
k create deployment web --image=nginx --dry-run=client -o yaml > deploy.yaml
```

---

## Vim Essentials

Be comfortable with Vim — it's the primary editor in the exam.

### Settings

If Vim is not configured properly (e.g., paste issues), configure via `~/.vimrc` or enter in Vim command mode:

```vim
set tabstop=2
set expandtab
set shiftwidth=2
```

`expandtab` ensures spaces are used instead of tabs.

> ⚠️ Changes in `~/.vimrc` will NOT transfer when connecting to other instances via SSH.

### Line Numbers

Press **Esc** and type:
- `:set number` — show line numbers
- `:set nonumber` — hide line numbers
- `:22` + **Enter** — jump to line 22

### Copy, Cut & Paste

| Action | Keys |
|---|---|
| Mark lines | `Esc` → `V` → arrow keys |
| Copy marked lines | `y` |
| Cut marked lines | `d` |
| Paste below / above | `p` / `P` |

### Indent Multiple Lines

1. Set indent width: `:set shiftwidth=2`
2. Mark lines: `Shift+V` + arrow keys
3. Indent: `>` (right) or `<` (left)
4. Repeat: `.`