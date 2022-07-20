(setq inhibit-startup-message t)

(scroll-bar-mode -1) ;; visual scrollbar
(tool-bar-mode -1) ;; disable toolbar
(tooltip-mode -1) ;; disable tooltips
(set-fringe-mode 0) ;; space

(menu-bar-mode -1) ;; disable menu bar

;; set up visible bell
(setq visible-bell nil)
(global-visual-line-mode -1)

(set-face-attribute 'default nil :font "Source Code Pro" :height 140)

;;(load-theme 'wombat)
;;(load-theme 'flatland t)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
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

(use-package diminish)

(use-package swiper
  :ensure t)

(setq use-package-always-ensure t)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
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

(global-set-key (kbd "C-s") 'swiper-isearch)
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
(global-set-key (kbd "C-c n") 'counsel-fzf)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-c J") 'counsel-file-jump)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(global-set-key (kbd "C-c w") 'counsel-wmctrl)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "C-c b") 'counsel-bookmark)
(global-set-key (kbd "C-c d") 'counsel-descbinds)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c o") 'counsel-outline)
(global-set-key (kbd "C-c t") 'counsel-load-theme)
(global-set-key (kbd "C-c F") 'counsel-org-file)

(use-package counsel
  :ensure t
  :config
  ;; Remove the '^' at the beginning of counsel commands
  (setq ivy-initial-inputs-alist nil))

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
(setq doom-modeline-indent-info t)
(use-package all-the-icons
  :ensure t)
(use-package all-the-icons-dired
  :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("7a424478cb77a96af2c0f50cfb4e2a88647b3ccca225f8c650ed45b7f50d9525" "991ca4dbb23cab4f45c1463c187ac80de9e6a718edc8640003892a2523cb6259" "da75eceab6bea9298e04ce5b4b07349f8c02da305734f7c0c8c6af7b5eaa9738" "b99e334a4019a2caa71e1d6445fc346c6f074a05fcbb989800ecbe54474ae1b0" "636b135e4b7c86ac41375da39ade929e2bd6439de8901f53f88fde7dd5ac3561" "1a1ac598737d0fcdc4dfab3af3d6f46ab2d5048b8e72bc22f50271fd6d393a00" "251ed7ecd97af314cd77b07359a09da12dcd97be35e3ab761d4a92d8d8cf9a71" "4ff1c4d05adad3de88da16bd2e857f8374f26f9063b2d77d38d14686e3868d8d" default))
 '(package-selected-packages
   '(rainbow-delimiters tree-sitter-langs tree-sitter gruvbox-theme all-the-icons-dired atom-one-dark-theme suscolors-theme subatomic-theme weyland-yutani-theme nano-theme yasnippet-snippets yasnippet vterm dirvish lsp-treemacs lsp-ui helpful company ivy-rich company-box lsp-mode flycheck rustic magit counsel-projectile projectile general dashboard which-key all-the-icons beacon good-scroll doom-themes use-package doom-modeline diminish counsel)))
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
  (load-theme 'doom-gruvbox t))

  ;; Enable flashing mode-line on errors
  ;;(doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  ;;(doom-themes-neotree-config)
  ;; or for treemacs users
  ;;(setq doom-themes-treemacs-theme "doom-atom")) ; use "doom-colors" for less minimal icon theme
  ;;(doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  ;;(doom-themes-org-config))

;; Revert buffers whent the underlying file has changed. Refresh a file edited outside of emacs
(global-auto-revert-mode 1)

;; Auto close (), "", {}
(electric-pair-mode 1)
(setq electric-pair-pairs
      '(
        (?\" . ?\")
        (?\{ . ?\})))

;; Enable smooth scrolling since Emacs 29 is not released yet
;;(use-package good-scroll)
;;(good-scroll-mode 1)


;; Enable line and column numbers
(column-number-mode)
(global-display-line-numbers-mode)
;;(global-display-line-numbers-type 'absolute)

;; Disable line numbers in some scenarios
(dolist (mode '(org-mode-hook
	      term-mode-hook
	      eshell-mode-hook
	      treemacs-mode-hook
	      shell-mode-hook
	      vterm-mode-hook
	      rustic-cargo-run-mode-hook
	      rustic-cargo-test-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Light up the cursor whenever the window scrolls
(use-package beacon)
:
(beacon-mode 1)

(use-package which-key
  :ensure t)
(which-key-mode 1)

;; Dashboard settings
(use-package dashboard
  :ensure t
  :init
  (progn
    (setq dashboard-center-content t)
    (setq dashboard-banner-logo-title "Happy Hacking")
    (setq dashboard-set-file-icons t)
    (setq dashboard-set-heading-icons t)
    (setq dashboard-startup-banner 'official)
    )
  :config
  (dashboard-setup-startup-hook))
(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
(setq dashboard-items '((recents  . 3)
                        (projects . 3)
                        ;;(agenda . 5)
                        ;;(bookmarks . 5)
                        ))

(use-package ivy-rich
  :ensure t
  :init
  (ivy-rich-mode 1))

;;(global-set-key (kbd "C-M-j") 'counsel-switch-buffer)
(define-key emacs-lisp-mode-map (kbd "C-x M-e") 'eval-buffer)

(use-package general
  :config
  (general-evil-setup nil))

(general-define-key
 "C-M-j" 'counsel-switch-buffer)

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

(defun my-kill-everything ()
  (interactive)
  (dolist (cur (buffer-list))
    (kill-buffer cur)))

(global-set-key (kbd "C-x K") 'my-kill-everything)

(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (lsp-mode lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))
;; Increase the amount of data which Emacs reads from the process.
;; Default value is causing a slowdown, it's too low to handle server responses.
(setq read-process-output-max (*(* 1024 1024) 3)) ;; 3mb

(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))
(setq lsp-headerline-breadcrumb-enable nil)

(add-hook 'lsp-mode-hook #'yas-minor-mode-on)

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
;;  :config
;;  (company-keymap--unbind-quick-access company-active-map)
;;  (company-tng-configure-default)

;; Better looking completions
;;(use-package company-box
;;  :ensure t
;;  :hook (company-mode . company-box-mode))

(use-package flycheck
  :ensure t)

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-position 'bottom))

(use-package rustic
  :ensure t
  :hook (rustic-mode . lsp-deferred)
  :hook (rustic-mode . tree-sitter-hl-mode)
  :config
  (require 'lsp-rust)
  (setq lsp-rust-analyzer-completion-add-call-parenthesis t))

;; Treemacs
(use-package lsp-treemacs
  :after lsp)
(treemacs-project-follow-mode t)

(use-package vterm
  :ensure t
  :commands vterm
  :config
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")
  (setq vterm-max-scrollback 10000))

(use-package yasnippet
  :ensure t
  :config
  (use-package yasnippet-snippets
    :ensure t)
  (yas-reload-all))

(shell-command "/usr/bin/xmodmap /home/michal/.Xmodmap")

;; Fix broken prompt and completion prompts while running fish shell
(add-hook 'term-exec-hook
          (function
           (lambda ()
             (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))))

(use-package tree-sitter
  :ensure t)
(use-package tree-sitter-langs
    :ensure t)
(global-tree-sitter-mode)

(use-package rainbow-delimiters
  :ensure t)

