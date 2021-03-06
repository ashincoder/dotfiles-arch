;;; init.el --- Description -*- lexical-binding: t; -*-

;; Setting garbage collection threshold
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)

;; Profile emacs startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;; Silence compiler warnings as they can be pretty disruptive (setq comp-async-report-warnings-errors nil)

;; Silence compiler warnings as they can be pretty disruptive
(if (boundp 'comp-deferred-compilation)
    (setq comp-deferred-compilation nil))
;; In noninteractive sessions, prioritize non-byte-compiled source files to
;; prevent the use of stale byte-code. Otherwise, it saves us a little IO time
;; to skip the mtime checks on every *.elc file.
(setq load-prefer-newer noninteractive)

;; Disable warnings from legacy advice system. They aren't useful, and what can
;; we do about them, besides changing packages upstream?
(setq ad-redefinition-action 'accept)

;; Get rid of "For information about GNU Emacs..." message at startup, unless
;; we're in a daemon session where it'll say "Starting Emacs daemon." instead,
;; which isn't so bad.
(unless (daemonp)
  (advice-add #'display-startup-echo-area-message :override #'ignore))

;; Reduce Message noise at startup. An empty scratch buffer (or the dashboard)
;; is more than enough.
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message user-login-name
      inhibit-default-init t
      ;; Shave seconds off startup time by starting the scratch buffer in
      ;; fundamental-mode', rather than, say, org-mode' or `text-mode', which
      ;; pull in a ton of packages. provides a better scratch buffer anyway.

      initial-major-mode 'fundamental-mode
      initial-scratch-message nil)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Always use straight to install on systems other than Linux
(setq straight-use-package-by-default (not (eq system-type 'gnu/linux)))

;; Use straight.el for use-package expressions
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; Load the helper package for commands like `straight-x-clean-unused-repos'
(require 'straight-x)

;; Using garbage magic hack.
(use-package gcmh
  :config
  (gcmh-mode 1))
(setq gcmh-idle-delay 5 ; default is 15s
      gcmh-high-cons-threshold (* 16 1024 1024)) ; 16mb

;; Making emacs clean
(setq user-emacs-directory "~/.cache/emacs")
(use-package no-littering)

;; Disabling backup
(setq make-backup-files nil) ;; We dont need these
;; Shit cl
(setq byte-compile-warnings '(cl-functions))

(setq inhibit-startup-message t)

(menu-bar-mode -1) ; Disable the menu bar
(scroll-bar-mode -1) ; Disable visible scrollbar
(tool-bar-mode -1) ; Disable the toolbar
(tooltip-mode -1) ; Disable tooltips
(set-fringe-mode 10) ; Give some breathing room

;;By default in Emacs, we don???t have ability to select text, and then start typing and our new text replaces the selection.Let???s fix that!
(delete-selection-mode t)

;; Relative line numbers
(setq-default display-line-numbers 'visual
              ;; this is the default
              display-line-numbers-current-absolute t)

(defun noct:relative ()
  (setq-local display-line-numbers 'visual))

(defun noct:absolute ()
  (setq-local display-line-numbers t))

(add-hook 'evil-insert-state-entry-hook #'noct:absolute)

(use-package evil
  :demand t
  :init ;; tweak evil's configuration before loading it
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (evil-mode))
;; Evil Collection
(use-package evil-collection
  :after evil
  :config
  (setq evil-collection-mode-list '(dashboard dired ibuffer))
  (evil-collection-init))

(use-package evil-tutor
  :commands (evil-tutor-start))

(use-package evil-nerd-commenter
  :bind ("C-/" . evilnc-comment-or-uncomment-lines))

(use-package dashboard
  :demand t
  :init ;; tweak dashboard config before loading it
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
  ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (bookmarks . 5)
                          (projects . 3)
                          (agenda . 3 )
                          (registers . 3)))
  :config
  (dashboard-setup-startup-hook)
  (dashboard-modify-heading-icons '((recents . "file-text")
                                    (bookmarks . "book"))))

(setq initial-buffer-choice (lambda () (get-buffer "dashboard")))

(use-package doom-themes
  :demand t
  :config
  (setq doom-themes-enable-bold t ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  :init (load-theme 'doom-one t))

(use-package doom-modeline
  :demand t
  :hook (after-init . doom-modeline-init))

(use-package all-the-icons)

(defun enable-doom-modeline-icons (_frame)
  (setq doom-modeline-icon t))

(add-hook 'after-make-frame-functions
          #'enable-doom-modeline-icons)

(defun ash/set-font-faces ()
  (set-face-attribute 'default nil :font "JetBrains Mono Nerd Font" :height 110 :weight 'medium)

  ;; Set the fixed pitch face
  (set-face-attribute 'fixed-pitch nil :font "JetBrains Mono Nerd Font" :height 110 :weight 'medium)

  ;; Set the variable pitch face
  (set-face-attribute 'variable-pitch nil :font "JetBrains Mono Nerd Font" :height 110 :weight 'regular))

;; Makes commented text and keywords italics.
;; This is working in emacsclient but not emacs.
;; Your font must have an italic face available.
(set-face-attribute 'font-lock-comment-face nil
                    :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
                    :slant 'italic)
;; Uncomment the following line if line spacing needs adjusting.
(setq-default line-spacing 0.12)
;; changes certain keywords to symbols, such as lamda!
(setq global-prettify-symbols-mode t)

(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame
                  (ash/set-font-faces))))
  (ash/set-font-faces))

;; zoom in/out like we do everywhere else.
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-0") '(lambda () (interactive) (text-scale-adjust 0)))

(use-package rainbow-mode
  :defer t
  :hook (org-mode
         emacs-lisp-mode
         prog-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package general
  :after evil
  :init
  (general-create-definer vim-leader-def :prefix "SPC"))
:config
(general-evil-setup t)

(nvmap :keymaps 'override :prefix "SPC"
       "c c" '(compile :which-key "Compile")
       "c C" '(recompile :which-key "Recompile")
       "h r r" '((lambda () (interactive) (load-file "~/.emacs.d/init.el")) :which-key "Reload emacs config")
       "t t" '(toggle-truncate-lines :which-key "Toggle truncate lines"))

(nvmap :keymaps 'override :prefix "SPC"
       "m *" '(org-ctrl-c-star :which-key "Org-ctrl-c-star")
       "m +" '(org-ctrl-c-minus :which-key "Org-ctrl-c-minus")
       "m ." '(counsel-org-goto :which-key "Counsel org goto")
       "m e" '(org-export-dispatch :which-key "Org export dispatch")
       "m f" '(org-footnote-new :which-key "Org footnote new")
       "m h" '(org-toggle-heading :which-key "Org toggle heading")
       "m i" '(org-toggle-item :which-key "Org toggle item")
       "m n" '(org-store-link :which-key "Org store link")
       "m o" '(org-set-property :which-key "Org set property")
       "m t" '(org-todo :which-key "Org todo")
       "m x" '(org-toggle-checkbox :which-key "Org toggle checkbox")
       "m B" '(org-babel-tangle :which-key "Org babel tangle")
       "m I" '(org-toggle-inline-images :which-key "Org toggle inline imager")
       "m T" '(org-todo-list :which-key "Org todo list")
       "m a" '(org-agenda :which-key "Org agenda"))

(setq-default tab-width 4)
(setq-default evil-shift-width tab-width)
(setq-default indent-tabs-mode nil)
(setq tabify-regexp "^\t* [ \t]+")

(winner-mode 1)
(nvmap :prefix "SPC"
       ;; Window splits
       "w c" '(evil-window-delete :which-key "Close window")
       "w n" '(evil-window-new :which-key "New window")
       "w s" '(evil-window-split :which-key "Horizontal split window")
       "w v" '(evil-window-vsplit :which-key "Vertical split window")
       ;; Window motions
       "w h" '(evil-window-left :which-key "Window left")
       "w j" '(evil-window-down :which-key "Window down")
       "w k" '(evil-window-up :which-key "Window up")
       "w l" '(evil-window-right :which-key "Window right")
       "w w" '(evil-window-next :which-key "Goto next window")
       ;; winner mode
       "w " '(winner-undo :which-key "Winner undo")
       "w " '(winner-redo :which-key "Winner redo"))

(nvmap :prefix "SPC"
       "b b" '(ibuffer :which-key "Ibuffer")
       "b c" '(clone-indirect-buffer-other-window :which-key "Clone indirect buffer other window")
       "b k" '(kill-current-buffer :which-key "Kill current buffer")
       "b n" '(next-buffer :which-key "Next buffer")
       "b p" '(previous-buffer :which-key "Previous buffer")
       "b B" '(ibuffer-list-buffers :which-key "Ibuffer list buffers")
       "b K" '(kill-buffer :which-key "Kill buffer"))

(nvmap :prefix "SPC"
       "o m" '(bookmark-set :which-key "Set Bookmark")
       "o M" '(bookmark-set-no-overwrite :which-key "Set Bookmark No Overwrite")
       "o l" '(bookmark-bmenu-list :which-key "List Bookmarks")
       "o j" '(bookmark-jump :which-key "Jump to Bookmarks")
       "o r" '(bookmark-rename :which-key "Rename Bookmarks")
       "o d" '(bookmark-delete :which-key "Delete a Bookmark"))

(nvmap :states '(normal visual) :keymaps 'override :prefix "SPC"
       "e b" '(eval-buffer :which-key "Eval elisp in buffer")
       "e d" '(eval-defun :which-key "Eval defun")
       "e e" '(eval-expression :which-key "Eval elisp expression")
       "e l" '(eval-last-sexp :which-key "Eval last sexression")
       "e r" '(eval-region :which-key "Eval region"))

(defun ash/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

(use-package org
  :hook (org-mode . ash/org-mode-setup)
  :commands (org-agenda)
  :config
  (setq org-directory "/Org/"
        org-agenda-files '("/Org/agenda.org") org-default-notes-file (expand-file-name "notes.org" org-directory) org-ellipsis " ??? "
        org-log-done 'time
        org-journal-dir "~/Org/journal/"
        org-journal-date-format "%B %d, %Y (%A) "
        org-journal-file-format "%Y-%m-%d.org"
        org-hide-emphasis-markers t
        org-src-preserve-indentation nil
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 0))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))
;; Replace list hyphen with dot
(font-lock-add-keywords 'org-mode
                        '(("^ *\([-]\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "???"))))))

(setq org-todo-keywords
      '((sequence
         "TODO(t)" ; A task that needs doing & is ready to do
         "PROJ(p)" ; A project, which usually contains other tasks
         "LOOP(r)" ; A recurring task
         "STRT(s)" ; A task that is in progress
         "WAIT(w)" ; Something external is holding up this task
         "HOLD(h)" ; This task is paused/on hold because of me
         "IDEA(i)" ; An unconfirmed and unapproved task or notion
         "|"
         "DONE(d)" ; Task successfully completed
         "KILL(k)") ; Task was cancelled, aborted or is no longer applicable
        (sequence
         " " ; A task that needs doing
         "-" ; Task is in progress
         "?" ; Task is being held up or paused
         "|"
         "X"))) ; Task was completed

(setq org-blank-before-new-entry (quote ((heading . nil)
                                         (plain-list-item . nil))))
;; Supports shift selection
(setq org-support-shift-select t)
(defun +org-init-appearance-h ()
  "Configures the UI for `org-mode'."
  (setq org-indirect-buffer-display 'current-window
        org-eldoc-breadcrumb-separator " ??? "
        org-entities-user
        '(("flat" "\flat" nil "" "" "266D" "???")
          ("sharp" "\sharp" nil "" "" "266F" "???"))
        org-fontify-done-headline t
        org-fontify-quote-and-verse-blocks t
        org-hide-leading-stars t
        org-image-actual-width nil
        org-imenu-depth 8
        ;; Sub-lists should have different bullets
        org-list-demote-modify-bullet '(("+" . "-") ("-" . "+") ("*" . "+") ("1." . "a."))
        org-priority-faces
        '((?A . error)
          (?B . warning)
          (?C . success))
        org-startup-indented t
        org-tags-column 0
        org-use-sub-superscripts '{}))

(defun ash/org-present-prepare-slide ()
  (org-overview)
  (org-show-entry)
  (org-show-children))

(defun ash/org-present-hook ()
  (setq-local face-remapping-alist '((default (:height 1.5) variable-pitch)
                                     (header-line (:height 4.5) variable-pitch)
                                     (org-code (:height 1.55) org-code)
                                     (org-verbatim (:height 1.55) org-verbatim)
                                     (org-block (:height 1.25) org-block)
                                     (org-block-begin-line (:height 0.7) org-block)))
  (setq header-line-format " ")
  (org-display-inline-images)
  (ash/org-present-prepare-slide))

(defun ash/org-present-quit-hook ()
  (setq-local face-remapping-alist '((default variable-pitch default)))
  (setq header-line-format nil)
  (org-present-small)
  (org-remove-inline-images))

(defun ash/org-present-prev ()
  (interactive)
  (org-present-prev)
  (ash/org-present-prepare-slide))

(defun ash/org-present-next ()
  (interactive)
  (org-present-next)
  (ash/org-present-prepare-slide))

(use-package org-present
  :bind (:map org-present-mode-keymap
         ("C-c C-j" . ash/org-present-next)
         ("C-c C-k" . ash/org-present-prev))
  :hook ((org-present-mode . ash/org-present-hook)
         (org-present-mode-quit . ash/org-present-quit-hook)))

(defun ash/org-start-presentation ()
  (interactive)
  (org-tree-slide-mode 1)
  (setq text-scale-mode-amount 3)
  (text-scale-mode 1))

(defun ash/org-end-presentation ()
  (interactive)
  (text-scale-mode 0)
  (org-tree-slide-mode 0))

(use-package org-tree-slide
  :defer t
  :after org
  :commands org-tree-slide-mode
  :config
  (evil-define-key 'normal org-tree-slide-mode-map
    (kbd "q") 'ash/org-end-presentation
    (kbd "C-j") 'org-tree-slide-move-next-tree
    (kbd "C-k") 'org-tree-slide-move-previous-tree)
  (setq org-tree-slide-slide-in-effect nil
        org-tree-slide-activate-message "Presentation started."
        org-tree-slide-deactivate-message "Presentation ended."
        org-tree-slide-header t))

(with-eval-after-load 'org
  ;; This is needed as of Org 9.2
  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("hs" . "src haskell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python")))

(setq org-src-fontify-natively t
      org-src-tab-acts-natively t
      org-confirm-babel-evaluate nil
      org-edit-src-content-indentation 0)

(use-package toc-org
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))

;; Get file icons in dired
(use-package all-the-icons-dired)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(nvmap :states '(normal visual) :keymaps 'override :prefix "SPC"
       "d d" '(dired :which-key "Open dired")
       "d j" '(dired-jump :which-key "Dired jump to current")
       "d p" '(peep-dired :which-key "Peep-dired"))

(with-eval-after-load 'dired
  ;;(define-key dired-mode-map (kbd "M-p") 'peep-dired)
  (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
  (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-open-file)) ; use dired-find-file instead if not using dired-open package

;; With dired-open plugin, you can launch external programs for certain extensions
;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
(use-package dired-open
  :after dired
  :config
  (setq dired-open-extensions '(("gif" . "sxiv")
                                ("jpg" . "sxiv")
                                ("png" . "sxiv")
                                ("mkv" . "mpv")
                                ("mp4" . "mpv"))))

(use-package projectile
  :defer 0
  :diminish projectile-mode
  :custom ((projectile-completion-system 'ivy))
  :bind ("C-c p" . projectile-command-map)
  :config (projectile-mode))

(nvmap :states '(normal visual) :keymaps 'override :prefix "SPC"
       "." '(find-file :which-key "Find file")
       "f f" '(find-file :which-key "Find file")
       "f r" '(counsel-recentf :which-key "Recent files")
       "f s" '(save-buffer :which-key "Save file")
       "f u" '(sudo-edit-find-file :which-key "Sudo find file")
       "f y" '(ash/show-and-copy-buffer-path :which-key "Yank file path")
       "f C" '(copy-file :which-key "Copy file")
       "f D" '(delete-file :which-key "Delete file")
       "f R" '(rename-file :which-key "Rename file")
       "f S" '(write-file :which-key "Save file as...")
       "f U" '(sudo-edit :which-key "Sudo edit file"))

(use-package recentf
  :config
  (recentf-mode))
(use-package sudo-edit
  :commands (sudo-edit sudo-edit-find-file)) ;; Utilities for opening files with sudo

(defun ash/show-and-copy-buffer-path ()
  "Show and copy the full path to the current file in the minibuffer."
  (interactive)
  ;; list-buffers-directory is the variable set in dired buffers
  (let ((file-name (or (buffer-file-name) list-buffers-directory)))
    (if file-name
        (message (kill-new file-name))
      (error "Buffer not visiting a file"))))
(defun ash/show-buffer-path-name ()
  "Show the full path to the current file in the minibuffer."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if file-name
        (progn
          (message file-name)
          (kill-new file-name))
      (error "Buffer not visiting a file"))))

(use-package ivy
  :defer 0.1
  :diminish
  :bind
  (("C-c C-r" . ivy-resume)
   ("C-x B" . ivy-switch-buffer-other-window))
  :custom
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode))
(use-package ivy-rich
  :after ivy
  :custom
  (ivy-virtual-abbreviate 'full
                          ivy-rich-switch-buffer-align-virtual-buffer t
                          ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
                               'ivy-rich-switch-buffer-transformer)
  (ivy-rich-mode 1)) ;; this gets us descriptions in M-x.

(use-package counsel
  :after ivy
  :config (counsel-mode))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))

(setq ivy-initial-inputs-alist nil)

(use-package ivy-posframe
  :after ivy
  :init
  (setq ivy-posframe-display-functions-alist
        '((swiper . ivy-posframe-display-at-point)
          (complete-symbol . ivy-posframe-display-at-point)
          (counsel-M-x . ivy-display-function-fallback)
          (counsel-esh-history . ivy-posframe-display-at-window-center)
          (counsel-describe-function . ivy-display-function-fallback)
          (counsel-describe-variable . ivy-display-function-fallback)
          (counsel-find-file . ivy-display-function-fallback)
          (counsel-recentf . ivy-display-function-fallback)
          (counsel-register . ivy-posframe-display-at-frame-bottom-window-center)
          (dmenu . ivy-posframe-display-at-frame-top-center)
          (nil . ivy-posframe-display))
        ivy-posframe-height-alist
        '((swiper . 20)
          (dmenu . 20)
          (t . 10)))
  :config
  (ivy-posframe-mode 1)) ; 1 enables posframe-mode, 0 disables it.

(use-package haskell-mode
  :mode "\.hs\'")
(use-package lua-mode
  :mode "\.lua\'")
(use-package python-mode
  :mode "\.py\'")
(setq python-shell-interpreter "/usr/bin/python3")

;;; SH mode:
(add-hook 'sh-mode-hook (lambda ()
                          (setq sh-basic-offset 2)
                          (setq sh-indentation 2)))

(defvar +sh-builtin-keywords
  '("cat" "cd" "chmod" "chown" "cp" "curl" "date" "echo" "find" "git" "grep"
    "kill" "less" "ln" "ls" "make" "mkdir" "mv" "pgrep" "pkill" "pwd" "rm"
    "sleep" "sudo" "touch")
  "A list of common shell commands to be fontified especially in `sh-mode'.")

;;; Packages

(use-package sh-mode ; built-in
  :straight nil
  :mode ("\.\(?:zunit\|env\)\'" . sh-mode)
  :mode ("/.sh\'" . sh-mode)
  :config
  (set-docsets 'sh-mode "Bash")
  (set-electric 'sh-mode :words '("else" "elif" "fi" "done" "then" "do" "esac" ";;"))
  (set-formatter 'shfmt
                 '("shfmt" "-ci"
                   ("-i" "%d" (unless indent-tabs-mode tab-width))
                   ("-ln" "%s" (pcase sh-shell (bash "bash") (mksh "mksh") (_ "posix")))))
  (set-repl-handler 'sh-mode #'+sh/open-repl)
  (set-lookup-handlers 'sh-mode :documentation #'+sh-lookup-documentation-handler)
  (set-ligatures 'sh-mode
                 ;; Functional
                 :def "function"
                 ;; Types
                 :true "true" :false "false"
                 ;; Flow
                 :not "!"
                 :and "&&" :or "||"
                 :in "in"
                 :for "for"
                 :return "return"
                 ;; Other
                 :dot "." :dot "source"))

;;; Emacs Lisp mode:
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (eldoc-mode)
            (define-key emacs-lisp-mode-map (kbd "") 'eval-last-sexp)))

(setq-default enable-local-variables :safe)

(use-package flycheck
  :commands flycheck-mode)
;; hook
(add-hook 'flycheck-mode-hook
          (lambda ()
            (evil-define-key 'normal flycheck-mode-map (kbd "]e") 'flycheck-next-error)
            (evil-define-key 'normal flycheck-mode-map (kbd "[e") 'flycheck-previous-error)))

(use-package company
  :hook
  (org-mode . company-mode)
  (prog-mode . company-mode)
  :bind (:map company-active-map ("" . company-complete-common-or-cycle))
  :custom
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))

(with-eval-after-load 'company
  ;; (define-key company-active-map [tab] 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "SPC") #'company-abort))

(setq skeleton-pair t)
(global-set-key "[" 'skeleton-pair-insert-maybe)
(global-set-key "{" 'skeleton-pair-insert-maybe)
(global-set-key "(" 'skeleton-pair-insert-maybe)
(global-set-key "'" 'skeleton-pair-insert-maybe)

(setq show-paren-delay 0.1
      show-paren-highlight-openparen t
      show-paren-when-point-inside-paren t
      show-paren-when-point-in-periphery t)
(setq show-paren-delay 0)
(show-paren-mode 1)

(use-package magit
  :general
  (vim-leader-def 'normal 'global
                  "gj" 'magit-blame
                  "gc" 'magit-commit
                  "gp" 'magit-push
                  "gu" 'magit-pull
                  "gs" 'magit-status
                  "gd" 'magit-diff
                  "gl" 'magit-log
                  "gc" 'magit-checkout
                  "gb" 'magit-branch)
  :commands magit-status)

;; Forge
(use-package forge
  :after magit)

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.2
        which-key-add-column-padding 1))

(nvmap :prefix "SPC"
       "r c" '(copy-to-register :which-key "Copy to register")
       "r f" '(frameset-to-register :which-key "Frameset to register")
       "r i" '(insert-register :which-key "Insert register")
       "r j" '(jump-to-register :which-key "Jump to register")
       "r l" '(list-registers :which-key "List registers")
       "r n" '(number-to-register :which-key "Number to register")
       "r r" '(counsel-register :which-key "Choose a register")
       "r v" '(view-register :which-key "View a register")
       "r w" '(window-configuration-to-register :which-key "Window configuration to register")
       "r +" '(increment-register :which-key "Increment register")
       "r SPC" '(point-to-register :which-key "Point to register"))

(setq scroll-conservatively 101) ;; value greater than 100 gets rid of half page jumping
(setq mouse-wheel-scroll-amount '(3 ((shift) . 3))) ;; how many lines at a time
(setq mouse-wheel-progressive-speed t) ;; accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(use-package vterm
  :commands vterm
  :config
  (setq shell-file-name "/bin/zsh"
        vterm-max-scrollback 5000))

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))
