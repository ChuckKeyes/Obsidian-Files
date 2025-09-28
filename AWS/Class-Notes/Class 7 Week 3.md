

09-27-252025


# Notes for Class 7, Week 3: CLI, Source Code Management, and IDE

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#notes-for-class-7-week-3-cli-source-code-management-and-ide)

## Table of Contents

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#table-of-contents)

1. [Introduction](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#introduction)
2. [Core Concepts](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#core-concepts)
3. [Visual Studio Code](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#visual-studio-code)
4. [File Paths](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#file-paths)
5. [CLI File Management Basics](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#cli-file-management-basics)
6. [Git Setup](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#git-setup)
7. [GitHub Setup](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#github-setup)

## Introduction

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#introduction)

This week we cover some essential skills IT professionals need. Goals are to explore command-line interfaces, version control systems, file management, and how these tools work together in modern development workflows.

---

## Core Concepts

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#core-concepts)

### What is Version Control, Source Code Management, and GitOps

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#what-is-version-control-source-code-management-and-gitops)

**Version Control System:** A system that tracks changes to files over time, allowing you to:

- See what changed, when, and who made the changes
- Revert to previous versions of files
- Create branches for different features or experiments
- Merge changes from multiple contributors
- Maintain a complete history of your project

**Source Code Management (SCM):** The practice and tools used to track and control changes in software code. SCM encompasses:

- Version control systems (like Git)
- Repository hosting (like GitHub, GitLab, or custom solutions)
- Branching strategies and workflows
- Code review processes

**GitOps:** A modern operational framework that uses Git as the single source of truth for:

- Infrastructure configuration
- Application deployment
- Automated deployments triggered by Git changes

### What is a CLI, Shell, and Terminal

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#what-is-a-cli-shell-and-terminal)

**CLI (Command Line Interface):** A text-based interface where users type commands to interact with the computer, rather than using a graphical interface with windows and buttons.

**Shell:** The program that interprets and executes the commands you type in a CLI. It acts as an intermediary between you and the operating system.

**Terminal:** The application that provides the window/interface where you can access the shell. It's like a container that runs the shell program.

> **Important Note:** For us, essentially all of these terms are synonomous or at least interchangeable.

#### Popular Shells Explained

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#popular-shells-explained)

**Bash (Bourne Again Shell):**

- Default shell for most Linux distributions
- Used on older macOS versions (before macOS Catalina)
- Widely supported and documented
- Excellent for scripting and automation

**Zsh (Z Shell):**

- Default shell on newer macOS versions (Catalina and later)
- Enhanced version of Bash
- Better auto-completion and customization options
- Compatible with most Bash scripts

**PowerShell:**

- Default shell for newer Windows versions
- Powerful scripting capabilities
- Cross-platform (available on Linux and macOS)

**Command Prompt (cmd):**

- Traditional Windows command-line interface
- Limited compared to modern shells
- Still useful for basic Windows system tasks

**Git Bash:**

- Bash shell emulator specifically designed for Windows
- Comes bundled with Git for Windows
- Provides Unix-like command experience on Windows
- Provides a very similar experience to bash on Linux

---

## Visual Studio Code

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#visual-studio-code)

Visual Studio Code (VS Code) is an Integrated Development Environment (IDE) that brings together multiple development tools with convenient shortcuts and integrations.

### Key Features:

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#key-features)

- **Code editing** with syntax highlighting and IntelliSense
- **Integrated terminal** that works exactly the same as standalone terminals
- **Version control integration** with built-in Git support
- **Extension marketplace** for additional functionality
- **Debugging tools** for multiple programming languages
- **File management** with built-in explorer

> **Important Note:** Running a terminal inside VS Code functions identically to running a terminal outside of VS Code. The commands, file paths, and shell behavior remain the same.

---

## File Paths

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#file-paths)

File paths tell the computer exactly where files and folders are located in the storage system. Think of them as addresses for your files.

### Setting Up GUI File Views

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#setting-up-gui-file-views)

#### macOS File Path and Extension Setup

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#macos-file-path-and-extension-setup)

**Show File Paths:**

_Basic path bar (recommended):_

1. Open Finder
2. Go to **View** menu → **Show Path Bar**
3. Path bar appears at bottom of Finder window

_Show full path in title bar:_

1. Open Terminal
2. Run:

```shell
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
killall Finder
```

**Show File Extensions:**

1. Open Finder
2. Go to **Finder** menu → **Preferences** (or press **Cmd + ,**)
3. Click the **Advanced** tab
4. Check **"Show all filename extensions"**

**Alternative keyboard shortcut:**

- **Cmd + Shift + .** toggles hidden files and extensions

#### Windows File Explorer Setup

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#windows-file-explorer-setup)

**Show File Extensions:**

1. Open File Explorer
2. Click **View** tab in ribbon
3. Check **File name extensions**

**Show Full Paths:**

1. Open File Explorer
2. Click **View** tab
3. Click **Options** → **Change folder and search options**
4. Click **View** tab
5. Check **Display the full path in the title bar**

### Absolute vs Relative Paths

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#absolute-vs-relative-paths)

#### **Absolute File Paths:**

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#absolute-file-paths)

These reference files from the root of the storage drive, including every folder in the path. Like giving complete directions from a landmark (root drive) everyone knows.

**macOS/Linux/Unix Examples:**

```shell
/Users/john/Documents/resume.pdf
/Applications/Visual Studio Code.app
/System/Library/Fonts/Helvetica.ttc
/etc/hosts
/var/log/system.log
```

**Windows (Git Bash) Examples:**

```shell
/c/Users/John/Documents/resume.pdf
/c/Program Files/Git/bin/git.exe
/d/Projects/website/index.html
```

#### **Relative File Paths:**

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#relative-file-paths)

These reference files from your current location (present working directory). Like giving directions from where someone currently is.

```shell
./Documents/resume.pdf          # File in Documents folder from current location
../Desktop/photo.jpg            # File in Desktop folder, one level up
scripts/backup.sh               # File in scripts subfolder
../../shared/config.txt         # File two levels up, then in shared folder
```

### Path Shortcuts

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#path-shortcuts)

**Home Directory:** - Use the tilde (`~`) - **macOS:** Expands to `/Users/<YOUR-USERNAME>/` - **Windows (Git Bash):** Expands to `/c/Users/<YOUR-USERNAME>/`

**Current Directory:** - Use `.` or `./` - Is expanded to whatever the path is that `pwd` returns.

**Parent Directory:** - Use `..` or `../` - Is expanded to be the directory "above" the directory you are in.

---

## CLI File Management Basics

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#cli-file-management-basics)

### Essential Navigation Commands

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#essential-navigation-commands)

**`pwd` (Print Working Directory):** Shows your current location in the file system.

**`ls` (List Storage/Contents):** Shows files and folders in the current directory.

**`cd` (Change Directory):** Navigate between folders.

Also:

```shell
cd ..                       # Go up one directory level
cd ~                        # Go to home directory
```

### File and Directory Operations

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#file-and-directory-operations)

**`mkdir` (Make Directory):** Create new folders.

**`touch` (Create Empty Files):** Create new empty files (Unix/macOS/Git Bash).

**`rm` (Remove/Delete):** Delete files and directories.

**`cat` (Concatenate/Read Files):** Display file contents.

### Terminal Management

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#terminal-management)

1. **`clear` (clear history in terminal window)**
    
2. **Use up and down arrows** to retrieve previous commands
    
3. **Use ctrl-c** to kill a command currently executing
    
4. **Stop using spaces, stop using caps**
    
    - File names or paths with spaces will need special attention.
        - Use character breaks (normally is `\`) for spaces
        - Alternatively, you can "delimit" the entire file name or path by wrapping it in a pair of quotes.

5. Usings "windows style" file paths in Git Bash will cause issues as the path is parsed as having character breaks.
    - Option A: Rewrite it with forward slashes.
    - Option B: Wrap the file path in double quotes.

### Practice File Folder Script

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#practice-file-folder-script)

```shell
curl https://raw.githubusercontent.com/aaron-dm-mcdonald/Class7-notes/refs/heads/main/092725/practice.sh | $SHELL
```

---

## Git Setup

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#git-setup)

Git is a distributed version control system that tracks changes in your code. Before using Git, you need to configure your identity.

### Initial Git Configuration

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#initial-git-configuration)

1. **Set Your Name:**
    
    ```shell
    git config --global user.name "Your Full Name"
    ```
    
2. **Set Your Email:**
    

> **Note**: You should use your no reply email on Github for simplicity.

```shell
git config --global user.email "your.email@example.com"
```

3. **Verify Configuration:**
    
    ```shell
    git config --global --list
    ```
    

---

## GitHub Setup

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#github-setup)

GitHub is a web-based platform for hosting Git repositories, collaborating on code, project management, and more.

### Terminology

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#terminology)

**Repository (Repo):** A project folder that contains all your files, folders, and the complete history of changes. Think of it as your project's home on GitHub.

**Remote:** A version of your repository that's stored on a server (like GitHub) rather than your local computer. The connection between your local repo and the GitHub repo.

**Origin:** The default name for the main remote repository. When you clone a repo, GitHub automatically becomes the "origin" remote.

**Pull Request (PR):** A request to merge changes from one branch into another. It allows code review and discussion before changes are integrated.

**Fork:** Your personal copy of someone else's repository. You can make changes to your fork without affecting the original project.

**Clone:** Creating a local copy of a remote repository on your computer.

**Commit:** A snapshot of your changes with a descriptive message. Each commit creates a point in your project's history.

**Push:** Uploading your local commits to the remote repository (GitHub).

**Pull:** Downloading the latest changes from the remote repository to your local copy.

**Merge:** Combining changes from different branches into one branch.

### Authentication

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#authentication)

Authentication proves your identity to GitHub so you can access your repositories and make changes. There are two main methods:

**HTTPS Authentication:**

- Uses your GitHub username and password (or personal access token)
- Easier to set up but requires entering credentials frequently
- GitHub now requires Personal Access Tokens instead of passwords for security

**SSH Authentication:**

- Uses cryptographic key pairs (public and private keys)
- More secure and convenient once set up
- No need to enter credentials repeatedly

### Create Your First Repository

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#create-your-first-repository)

**On GitHub:**

1. Click "+" icon → "New repository"
2. Name your repository
3. Add description (optional)
4. Choose public
5. Click "Create repository"

### Basic Git Workflow

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#basic-git-workflow)

```shell
# Create the local repo on your computer
git init

# Begin to add files to the git index (staging)
git add <files to stage>

# Save a "snapshot" of the files in staging
git commit -m "<message name>"

# Rename default branch from "master" to "main" (preferred name)
git branch -M main

# Add your Github (remote) repo into your git index and name "origin"
git remote add origin <your remote>

# Upload commited changes from local repo
# Targets the "main" branch on the remote repo named "origin"
# -u sets the "upstream defaults" meaning after this you don't need them if you want to use the "main" branch on the remote repo "origin"
git push -u origin main
```

### GitHub Best Practices

[](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/092725#github-best-practices)

**Repository Organization:**

- Use clear, descriptive repository names
- Include comprehensive README files
- Add appropriate .gitignore files
- Use meaningful commit messages

**Security:**

- Never commit sensitive information (passwords, API keys)
- Review code before committing