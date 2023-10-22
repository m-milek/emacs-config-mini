(setq inhibit-startup-message t)
(scroll-bar-mode 0);
(tool-bar-mode 0)
(tooltip-mode 0);
(set-fringe-mode 0);
(menu-bar-mode 0)
(setq visible-bell nil)
(global-visual-line-mode -1)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

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
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(global-auto-revert-mode 1)
(global-subword-mode 1)
(electric-pair-mode 1)
(setq electric-pair-pairs
      '(
        (?\" . ?\")
        (?\{ . ?\})))
(column-number-mode)
(global-display-line-numbers-mode)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq-default truncate-lines t)
(delete-selection-mode 1)
(setq subword-mode 1)
(setq backup-directory-alist '(("." . "~/.emacs.d/backup")))
(setq-default indent-tabs-mode nil)

(shell-command "setxkbmap ctrl:swapcaps")
