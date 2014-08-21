;; .emacs

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;; always end a file with a newline
;(setq require-final-newline 'query)

;; New dabbrev stuff
;(require 'new-dabbrev)

;; -----------------User defined starts here--------------

(setq load-path (cons "~/emacs" load-path))
(require 'linum)
(require 'doxygen)
(load-file "~/emacs/user-macros.el")

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default c-basic-offset 4)

(add-hook 'c-mode-common-hook '(lambda()
    (local-set-key(kbd "RET") 'newline-and-indent)))

;; change the auto-indent behavior
;; (c-set-offset 'arglist-intro '+)
;; (c-set-offset 'arglist-cont-nonempty '+)
;; (c-set-offset 'arglist-close '+)
 
;;charset encoding
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; This from a japanese individual.  I hope it works.
(setq default-buffer-file-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8)

                                        ;Create a COPY line function
(defun copy-total-line ()
  "Copy the whole line that the cursor is on"
  (interactive)
  ;We want to return to where we started
  (save-excursion      
    ;Jump to the start of the line          
    (beginning-of-line)           
    ;Store the start of the line         
    (let* ((startpos (point)))    
      ;Move to the end of the line
      (end-of-line)
      ;Add it all to the kill ring as M-w would                       
      (kill-ring-save startpos (point) )  
    )
  )
)

;; scroll 1 line at a time.
(setq scroll-step 1)
;; enable column number
(column-number-mode 1)
;; enable mouse scrollng
;;(mouse-wheel-mode t)
;; ----- Key Bindings starts here
;; bind <F5> as linum-mode
(global-set-key (kbd "<f5>") 'linum-mode)
;; bind <F2> to insert function comment
(global-set-key (kbd "<f2>") 'doxygen-insert-function-comment)
;; bind <F6> to fire compiling
(global-set-key (kbd "<f6>") 'compile)
;; bind <F7> to align-regexp
(global-set-key (kbd "<f7>") 'align-regexp)
;; bind copy-total-line to C-h
(global-set-key (kbd "\C-h") 'copy-total-line)

;; enalbe line mode by default, seems not work
(linum-mode 1)
;; no menu bar
(menu-bar-mode 0)
;; highlight matching pairs
(show-paren-mode)