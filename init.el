(load-file "/home/michal/.emacs.d/my-elisp/my-latex-mode.el")
  (load-file "/home/michal/.emacs.d/my-elisp/my-random-dashboard-image.el")
  (load-file "/home/michal/.emacs.d/my-elisp/my-windows.el")
  (load-file "/home/michal/.emacs.d/my-elisp/my-utils.el")
  (load-file "/home/michal/.emacs.d/my-elisp/char-summary.el")

  (defun make-obsolete (obsolete-name current-name &optional when)
  "Make the byte-compiler warn that function OBSOLETE-NAME is obsolete.
OBSOLETE-NAME should be a function name or macro name (a symbol).

The warning will say that CURRENT-NAME should be used instead.
If CURRENT-NAME is a string, that is the `use instead' message
\(it should end with a period, and not start with a capital).
WHEN should be a string indicating when the function
was first made obsolete, for example a date or a release number."
  (declare (advertised-calling-convention
            ;; New code should always provide the `when' argument.
            (obsolete-name current-name when) "23.1"))
  (put obsolete-name 'byte-obsolete-info
       ;; The second entry used to hold the `byte-compile' handler, but
       ;; is not used any more nowadays.
       (purecopy (list current-name nil when)))
  obsolete-name)

(defmacro define-obsolete-function-alias (obsolete-name current-name
                                                        &optional when docstring)
  "Set OBSOLETE-NAME's function definition to CURRENT-NAME and mark it obsolete.

\(define-obsolete-function-alias \\='old-fun \\='new-fun \"22.1\" \"old-fun's doc.\")

is equivalent to the following two lines of code:

\(defalias \\='old-fun \\='new-fun \"old-fun's doc.\")
\(make-obsolete \\='old-fun \\='new-fun \"22.1\")

WHEN should be a string indicating when the function was first
made obsolete, for example a date or a release number.

See the docstrings of `defalias' and `make-obsolete' for more details."
  (declare (doc-string 4)
           (advertised-calling-convention
            ;; New code should always provide the `when' argument.
            (obsolete-name current-name when &optional docstring) "23.1"))
  `(progn
     (defalias ,obsolete-name ,current-name ,docstring)
     (make-obsolete ,obsolete-name ,current-name ,when)))

(defun make-obsolete-variable (obsolete-name current-name &optional when access-type)
  "Make the byte-compiler warn that OBSOLETE-NAME is obsolete.
The warning will say that CURRENT-NAME should be used instead.
If CURRENT-NAME is a string, that is the `use instead' message.
WHEN should be a string indicating when the variable
was first made obsolete, for example a date or a release number.
ACCESS-TYPE if non-nil should specify the kind of access that will trigger
  obsolescence warnings; it can be either `get' or `set'."
  (declare (advertised-calling-convention
            ;; New code should always provide the `when' argument.
            (obsolete-name current-name when &optional access-type) "23.1"))
  (put obsolete-name 'byte-obsolete-variable
       (purecopy (list current-name access-type when)))
  obsolete-name)

(defmacro define-obsolete-variable-alias (obsolete-name current-name
                                                        &optional when docstring)
  "Make OBSOLETE-NAME a variable alias for CURRENT-NAME and mark it obsolete.
This uses `defvaralias' and `make-obsolete-variable' (which see).
See the Info node `(elisp)Variable Aliases' for more details.

If CURRENT-NAME is a defcustom or a defvar (more generally, any variable
where OBSOLETE-NAME may be set, e.g. in an init file, before the
alias is defined), then the define-obsolete-variable-alias
statement should be evaluated before the defcustom, if user
customizations are to be respected.  The simplest way to achieve
this is to place the alias statement before the defcustom (this
is not necessary for aliases that are autoloaded, or in files
dumped with Emacs).  This is so that any user customizations are
applied before the defcustom tries to initialize the
variable (this is due to the way `defvaralias' works).

WHEN should be a string indicating when the variable was first
made obsolete, for example a date or a release number.

For the benefit of Customize, if OBSOLETE-NAME has
any of the following properties, they are copied to
CURRENT-NAME, if it does not already have them:
`saved-value', `saved-variable-comment'."
  (declare (doc-string 4)
           (advertised-calling-convention
            ;; New code should always provide the `when' argument.
            (obsolete-name current-name when &optional docstring) "23.1"))
  `(progn
     (defvaralias ,obsolete-name ,current-name ,docstring)
     ;; See Bug#4706.
     (dolist (prop '(saved-value saved-variable-comment))
       (and (get ,obsolete-name prop)
            (null (get ,current-name prop))
            (put ,current-name prop (get ,obsolete-name prop))))
     (make-obsolete-variable ,obsolete-name ,current-name ,when)))

(setq inhibit-startup-message t)
(scroll-bar-mode 0);
                                        ;visual scrollbar
(tool-bar-mode 0)
(tooltip-mode 0);
(set-fringe-mode 0);
(menu-bar-mode 0)
                                        ; set up visible bell
(setq visible-bell nil)
(global-visual-line-mode -1)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil
                    :font "Iosevka Aile"
                    :height 150)

(set-face-attribute 'default nil
                    :font "Source Code Pro"
                    :height 150)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil
                    :font "Source Code Pro"
                    :height 150)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(require 'package)
(setq package-archives '(
                         ;;("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
;; Initialize use-package on non Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(use-package diminish)

(use-package swiper
  :ensure t)

(use-package ivy
  :diminish
  :bind (
                                        ;("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-previous-i-search-kill))
  :config
  (ivy-mode 1))

(use-package counsel
  :ensure t
  :defer
  :config
  ;; Remove the '^' at the beginning of counsel commands
  (setq ivy-initial-inputs-alist nil))

(global-set-key (kbd "C-h") 'backward-char)
(global-unset-key (kbd "C-j"))
(global-set-key (kbd "C-j") 'next-line)
(global-set-key (kbd "C-k") 'previous-line)
(global-set-key (kbd "C-l") 'forward-char)
(global-set-key (kbd "C-M-h") 'left-word)
(global-unset-key (kbd "C-M-j"))
(global-set-key (kbd "C-M-j") nil)
(global-set-key (kbd "C-M-j") (lambda () (interactive) (next-line 4)))
(global-set-key (kbd "C-M-k") (lambda () (interactive) (previous-line 4)))
(global-set-key (kbd "C-M-l") 'right-word)
(global-set-key (kbd "C-m") 'back-to-indentation)
(global-set-key (kbd "RET") 'newline)

(global-set-key (kbd "C-c w") 'toggle-truncate-lines)

(global-set-key (kbd "C-n") 'electric-newline-and-maybe-indent)
(global-set-key (kbd "C-f") 'kill-line)
(global-set-key (kbd "C-p") 'help-command)
(global-set-key (kbd "C-b") 'recenter-top-bottom)
(global-set-key (kbd "C-M-o") 'counsel-switch-buffer)

(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "<f2> j") 'counsel-set-variable)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-c v") 'ivy-push-view)
(global-set-key (kbd "C-c V") 'ivy-pop-view)
(global-set-key (kbd "C-c c") 'counsel-compile)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c L") 'counsel-git-log)
(global-set-key (kbd "C-c k") 'counsel-rg)
(global-set-key (kbd "C-c m") 'counsel-linux-app)
(global-set-key (kbd "C-c f") 'counsel-fzf)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-c J") 'counsel-file-jump)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "C-c b") 'counsel-bookmark)
(global-set-key (kbd "C-c d") 'counsel-descbinds)
(global-set-key (kbd "C-c o") 'counsel-outline)
(global-set-key (kbd "C-c t") 'counsel-load-theme)
(global-set-key (kbd "C-c F") 'counsel-org-file)

(global-set-key (kbd "C-t") 'goto-line-preview)

(global-set-key (kbd "M-<up>") 'move-dup-move-lines-up)
(global-set-key (kbd "M-<down>") 'move-dup-move-lines-down)
(global-set-key (kbd "C-M-<up>") 'move-dup-duplicate-up)
(global-set-key (kbd "C-M-<down>") 'move-dup-duplicate-down)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-.") 'mc/mark-next-like-this)
(global-set-key (kbd "C-,") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-,") 'mc/mark-all-like-this)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;(global-unset-key (kbd "<right>"))
;(global-unset-key (kbd "<left>"))
;(global-unset-key (kbd "<up>"))
;(global-unset-key (kbd "<down>"))

(global-set-key (kbd "C-x K") 'mm/kill-everything)
(global-set-key (kbd "M-RET") 'mm/split-window-horizontally-and-focus-vterm)
(global-set-key (kbd "C-x 2") 'mm/split-window-vertically-and-focus)
(global-set-key (kbd "C-x 3") 'mm/split-window-horizontally-and-focus)
(global-set-key (kbd "C-r") 'mm/go-to-saved-point)
(global-set-key (kbd "C-s") (lambda () (interactive) (mm/save-point-and-fn 'swiper)))
(global-set-key (kbd "C-M-s") 'mm/save-point)
(global-set-key (kbd "C-`") 'mm/toggle-vterm-below)

(define-key emacs-lisp-mode-map (kbd "C-x M-e") 'eval-buffer)

(require 'multiple-cursors)

(use-package beacon
  :ensure t)
(beacon-mode 1)

(use-package which-key
  :ensure t)
(which-key-mode 1)
(use-package ivy-rich
  :ensure t
  :init
  (ivy-rich-mode 1))

(use-package general
  :config
  (general-evil-setup nil))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Programming")
    (setq projectile-project-search-path '("~/Programming")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package flycheck
  :ensure t)

(use-package yasnippet
  :ensure t
  :defer
  :config
  (yas-global-mode)
  (use-package yasnippet-snippets
    :ensure t)
  (yas-reload-all))
(yafolding-mode 1)

(use-package tree-sitter
  :ensure t)

(use-package tree-sitter-langs
  :defer
  :ensure t)
(global-tree-sitter-mode)

(use-package rainbow-delimiters
  :ensure t)

(use-package tex
  :ensure auctex
  :defer)

(use-package pdf-tools
  :defer
  :ensure t)

(use-package dired-single
  :ensure t)

(use-package move-dup
  :ensure t)

(use-package goto-line-preview
  :ensure t)

(use-package ess
  :ensure t)

(use-package vterm
  :ensure t
  :commands vterm
  :config
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")
  (setq vterm-max-scrollback 10000))

;; Fix broken prompt and completion prompts while running fish shell
(with-eval-after-load 'vterm(add-hook 'term-exec-hook
                                      (function
                                       (lambda ()
                                         (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix)))))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-varialbe)
  ([remap describe-key] . helpful-key))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 30)))
(setq doom-modeline-indent-info nil)
(setq doom-modeline-mu4e t)
(setq doom-modeline--battery-status t)
(setq doom-modeline-time-icon t)
    (display-battery-mode 1)

(use-package dired
  :ensure nil
  :custom ((dired-listing-switches "-agho --group-directories-first")))

(use-package all-the-icons-dired
  :ensure t
  :hook (dired-mode
         . all-the-icons-dired-mode))

(setf dired-kill-when-opening-new-dired-buffer t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("7a424478cb77a96af2c0f50cfb4e2a88647b3ccca225f8c650ed45b7f50d9525" "991ca4dbb23cab4f45c1463c187ac80de9e6a718edc8640003892a2523cb6259" "da75eceab6bea9298e04ce5b4b07349f8c02da305734f7c0c8c6af7b5eaa9738" "b99e334a4019a2caa71e1d6445fc346c6f074a05fcbb989800ecbe54474ae1b0" "636b135e4b7c86ac41375da39ade929e2bd6439de8901f53f88fde7dd5ac3561" "1a1ac598737d0fcdc4dfab3af3d6f46ab2d5048b8e72bc22f50271fd6d393a00" "251ed7ecd97af314cd77b07359a09da12dcd97be35e3ab761d4a92d8d8cf9a71" "4ff1c4d05adad3de88da16bd2e857f8374f26f9063b2d77d38d14686e3868d8d" default))
 '(package-selected-packages
   '(elfeed multiple-cursors fontaine clang-format mu4e utop merlin tuareg xkcd lsp-java dired-single yafolding org-bullets auctex math-preview pdf-tools latex-math-preview typescript-mode flycheck-rust rainbow-delimiters tree-sitter-langs tree-sitter gruvbox-theme all-the-icons-dired atom-one-dark-theme suscolors-theme subatomic-theme weyland-yutani-theme nano-theme yasnippet-snippets yasnippet vterm dirvish lsp-treemacs lsp-ui helpful company ivy-rich company-box lsp-mode flycheck rustic magit counsel-projectile projectile general dashboard which-key all-the-icons beacon good-scroll doom-themes use-package doom-modeline diminish counsel)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-solarized-dark t))

;; Enable flashing mode-line on errors
;;(doom-themes-visual-bell-config)
;; Enable custom neotree theme (all-the-icons must be installed!)
;;(doom-themes-neotree-config)
;; or for treemacs users
;;(setq doom-themes-treemacs-theme "doom-atom")) ; use "doom-colors" for less minimal icon theme
;;(doom-themes-treemacs-config)
;; Corrects (and improves) org-mode's native fontification.
;;(doom-themes-org-config))

;; Refresh a file edited outside of emacs
(global-auto-revert-mode 1)

(global-subword-mode 1)

;; Auto close (), "", {}
(electric-pair-mode 1)
(setq electric-pair-pairs
      '(
        (?\" . ?\")
        (?\{ . ?\})))

(column-number-mode)
(global-display-line-numbers-mode)

;; Disable line numbers in some scenarios
(dolist (mode '(org-mode-hook
                term-mode-hook
                eshell-mode-hook
                treemacs-mode-hook
                shell-mode-hook
                vterm-mode-hook
                rustic-cargo-run-mode-hook
                rustic-cargo-test-mode-hook
                mu4e-headers-mode-hook
                mu4e-view-mode-hook
                mu4e-main-mode-hook
                mu4e-org-mode-hook
                mu4e-compose-mode-hook
                eww-mode-hook
                ))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq-default truncate-lines t)
(delete-selection-mode 1)
(setq subword-mode 1)

(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; how many of the newest versions to keep
      kept-old-versions 5    ; and how many of the old
      )

(setq-default indent-tabs-mode nil)
(setq ivy-extra-directories nil)

(use-package dashboard
  :ensure t
  :init
  (progn
    (setq dashboard-center-content t)
    (setq dashboard-banner-logo-title "There is no system but GNU, and Linux is one of its kernels.")
    (setq dashboard-set-file-icons t)
    (setq dashboard-set-heading-icons t)
    (setq dashboard-set-footer nil)
    (setq dashboard-startup-banner (mm/random-dashboard-image-path)))
  :config
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  (setq dashboard-items '(
                          ;;(recents  . 4)
                          ;;(projects . 3)
                          (agenda . 3)
                          (bookmarks . 3)
                          )))
      ;;(setq dashboard-startup-banner (mm/random-dashboard-image-path)

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

;; Increase the amount of data which Emacs reads from the process.
;; Default value is causing a slowdown, it's too low to handle server responses.
(setq read-process-output-max (*(* 1024 1024) 3)) ;; 3mb

(setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
(setq lsp-headerline-breadcrumb-enable nil)

(add-hook 'lsp-mode-hook #'yas-minor-mode-on)
(add-hook 'lsp-mode-hook #'tree-sitter-hl-mode)
(with-eval-after-load 'lsp-mode
  (define-key lsp-mode-map (kbd "C-c l = =") 'mm/match-lsp-formatting))

;; Better completions
(use-package company
  :ensure t
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
              ("<tab>" . company-complete-selection))
  (:map lsp-mode-map
        ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))
(setq company-tooltip-maximum-width 60)
(setq company-tooltip-margin 3)

;; Better looking completions
(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode))
(setq company-box-doc-enable nil)

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)
(treemacs-project-follow-mode t)
(setq treemacs--project-follow-delay 0.1)

(with-eval-after-load 'lsp-mode
  (yas-global-mode))

(with-eval-after-load 'lsp-language-id-configuration
  (add-to-list 'lsp-language-id-configuration '(".*\\.R$" . "r"))
  (add-to-list 'lsp-language-id-configuration '(ess-mode . "r")))

(with-eval-after-load 'lsp-mode
  (lsp-register-client (make-lsp-client :new-connection
                                        (lsp-stdio-connection '("R" "--slave" "-e" "languageserver::run()"))
                                        :major-modes '(ess-r-mode inferior-ess-r-mode ess-mode)
                                        :server-id 'lsp-R)))

(use-package rustic
  :ensure t
  :hook (rustic-mode . lsp-deferred)
  :hook (rustic-mode . tree-sitter-hl-mode)
  :config
  (require 'lsp-rust)
  (setq lsp-rust-analyzer-completion-add-call-parenthesis t))

(use-package typescript-mode
  :mode "\\.ts\\'"
  :mode "\\.js\\'"
  :hook (typescript-mode . tree-sitter-hl-mode)
  :config
  (setq typescript-indent-level 2)
  (setq js-indent-level 2)
  (add-hook 'js-mode-hook 'lsp)
  (add-hook 'typescript-mode-hook 'lsp))

(add-hook 'c-mode-hook 'lsp)
(add-hook 'c-mode-hook 'tree-sitter-hl-mode)
(setq-default c-basic-offset 4)
(add-hook 'c++-mode-hook 'rebind)
(add-hook 'c++-mode-hook 'tree-sitter-hl-mode)
(add-hook 'c++-mode-hook 'lsp)
(setq-default c++-basic-offset 4)

(use-package clang-format
  :ensure t)
(setq-default clang-format-fallback-style "WebKit")

(use-package lsp-java
  :hook java-mode-hook)
(add-hook 'java-mode-hook 'tree-sitter-hl-mode)
(add-hook 'java-mode-hook 'lsp)

(add-hook 'LaTeX-mode-hook
          (local-set-key (kbd "C-c C-. M-c") 'mm/latex-compile)
          (local-set-key (kbd "C-c C-. M-v") 'mm/latex-compile-and-view)
          (lambda () (local-unset-key (kbd "C-j"))))
(setq TeX-auto-save t)
(setq TeX-parse-self t) 
(add-hook 'tex-mode-hook 'lsp)

;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
;;(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line

(add-hook 'emacs-lisp-mode-hook 'company-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

(use-package go-mode
  :ensure t)
(add-hook 'go-mode-hook 'lsp)
(add-hook 'go-mode-hook (lambda () (setq tab-width 4)))

(defun mm/org-mode-setup ()
  (setq org-startup-indented t)
  (org-indent-mode)
  (variable-pitch-mode 1) ;;enable a non-monospace font
  (auto-fill-mode 0)
  (visual-line-mode 1))

(use-package org
  :ensure t
  :hook (org-mode . mm/org-mode-setup)
  :config
  (setq org-ellipsis " ⏷"
        org-hide-emphasis-markers nil))

(use-package org-bullets
  :ensure t
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(require 'org-indent)

(set-face-attribute 'org-document-title nil :font "Iosevka Aile" :weight 'bold :height 1.3)
(with-eval-after-load 'org-faces
  (dolist (face '((org-level-1 . 1.25)
                  (org-level-2 . 1.15)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil
                        :font "Iosevka Aile"
                        :height (cdr face))
    ;; Ensure that anything that should be fixed-pitch in Org files appears that way
    (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
    (set-face-attribute 'org-table nil  :inherit 'fixed-pitch)
    (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
    (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
    (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)
    ))

(defun mm/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :ensure t
  :hook (org-mode . mm/org-mode-visual-fill))

(use-package org-download
  :ensure t
  :hook org-mode-hook)

(add-hook 'org-mode-hook
          (lambda () (local-set-key (kbd "C-j") nil)))

(with-eval-after-load 'org-mode-map (define-key org-mode-map (kbd "C-j") nil))

(setq agenda-dirs '("~/Semester-4" "~/Documents/org"))
(setq org-agenda-files (-flatten-n 1 (mapcar (lambda (dir) (directory-files-recursively dir "\\.org$" nil nil t)) agenda-dirs)))

(setq org-agenda-start-with-log-mode t)
(setq org-log-done 'time)
(setq org-log-into-drawer t)

(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")))

(setq org-tag-alist
      '((:startgroup)
        ;; Put mutually exclusive tags here
        (:endgroup)
        ("@home" . ?H)
        ("@work" . ?W)
        ("@put" . ?p)
        ("note" . ?n)
        ("idea" . ?i)))

;; Configure custom agenda views
(setq org-agenda-custom-commands
      '(("d" "Dashboard"
         ((agenda "" ((org-deadline-warning-days 14)))
          (todo "NEXT"
                ((org-agenda-overriding-header "Next Tasks")))
          (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

        ("n" "Next Tasks"
         ((todo "NEXT"
                ((org-agenda-overriding-header "Next Tasks")))))

        ("p" "PUT Tasks" tags-todo "+put")

        ;; Low-effort next actions
        ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
         ((org-agenda-overriding-header "Low Effort Tasks")
          (org-agenda-max-todos 20)
          (org-agenda-files org-agenda-files)))

        ("w" "Workflow Status"
         ((todo "WAIT"
                ((org-agenda-overriding-header "Waiting on External")
                 (org-agenda-files org-agenda-files)))
          (todo "REVIEW"
                ((org-agenda-overriding-header "In Review")
                 (org-agenda-files org-agenda-files)))
          (todo "PLAN"
                ((org-agenda-overriding-header "In Planning")
                 (org-agenda-todo-list-sublevels nil)
                 (org-agenda-files org-agenda-files)))
          (todo "BACKLOG"
                ((org-agenda-overriding-header "Project Backlog")
                 (org-agenda-todo-list-sublevels nil)
                 (org-agenda-files org-agenda-files)))
          (todo "READY"
                ((org-agenda-overriding-header "Ready for Work")
                 (org-agenda-files org-agenda-files)))
          (todo "ACTIVE"
                ((org-agenda-overriding-header "Active Projects")
                 (org-agenda-files org-agenda-files)))
          (todo "COMPLETED"
                ((org-agenda-overriding-header "Completed Projects")
                 (org-agenda-files org-agenda-files)))
          (todo "CANC"
                ((org-agenda-overriding-header "Cancelled Projects")
                 (org-agenda-files org-agenda-files)))))))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/Documents/RoamNotes")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert))
  :config
  (org-roam-setup))

(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")

(require 'mu4e)

(setq mail-user-agent 'mu4e-user-agent)

(setq mu4e-sent-folder   "/sent")
(setq mu4e-drafts-folder "/drafts")
(setq mu4e-trash-folder  "/trash")

(setq   mu4e-maildir-shortcuts
        '((:maildir "/archive" :key ?a)
          (:maildir "/inbox"   :key ?i)
          (:maildir "/work"    :key ?w)
          (:maildir "/sent"    :key ?s)))

(setq mu4e-get-mail-command "offlineimap")
(setq mu4e-compose-reply-to-address "michal.milek@student.put.poznan.pl"
      user-mail-address "michal.milek@student.put.poznan.pl"
      user-full-name  "Michał Miłek")
(setq mu4e-compose-signature
      "Michał Miłek\nhttp://www.put.poznan.pl\n")
(setq mu4e-compose-signature-auto-include nil)


;; smtp mail setting; these are the same that `gnus' uses.
(setq
 message-send-mail-function   'smtpmail-send-it
 smtpmail-default-smtp-server "poczta.student.put.poznan.pl"
 smtpmail-smtp-server         "poczta.student.put.poznan.pl"
 smtpmail-local-domain        "student.put.poznan.pl"
 smtpmail-smtp-service        587
 )

(setq mu4e-use-fancy-chars nil)
(setq mu4e-view-show-images t)
(setq mu4e-update-interval 600)

(use-package mu4e-alert
  :ensure t)

(use-package elfeed
  :ensure t
  :defer)
(setq elfeed-feeds
      '(
        "https://blog.rust-lang.org/feed.xml"
        ;;"http://www.reddit.com/r/emacs/.rss"
        "http://blogs.law.harvard.edu/tech/rss"
        "https://sachachua.com/blog/category/emacs-news/feed/"
        ))

(shell-command "/usr/bin/xmodmap /home/michal/.Xmodmap")

(use-package keyfreq
  :ensure t)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)
(setq keyfreq-excluded-commands
      '(self-insert-command
        lsp-ui-doc--handle-mouse-movement
        mwheel-scroll
        ;;forward-char
        ;;backward-char
        ;;previous-line
        ;;next-line
        ))
