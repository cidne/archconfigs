;; -*-lisp-*-
;;
;; Here is a sample .stumpwmrc file

(in-package :stumpwm)

;; change the prefix key to something else
(set-prefix-key (kbd "C-z"))

;; prompt the user for an interactive command. The first arg is an
;; optional initial contents.
(defcommand colon1 (&optional (initial "")) (:rest)
  (let ((cmd (read-one-line (current-screen) ": " :initial-input initial)))
    (when cmd
      (eval-command cmd t))))

;; change window focus by clicking
(setf *mouse-focus-policy* :click)
;; Modeline setup
(setf *window-format* "%m%n%s%c")
(setf *screen-mode-line-format* (list "[^B%n^b]%W^>%d"))
(setf *time-modeline-string* "%a %b %e %k:%M")
(setf *modeline-timeout* 2)
(enable-mode-line (current-screen) (current-head) t)
(set-font "-xos4-terminus-medium-r-normal-*-20-*-*-*-*-*-*-*")



;; Set cursor
(run-shell-command "xsetroot -cursor_name left_ptr")
;; Read some doc
(define-key *root-map* (kbd "d") "exec libreoffice")
;; Browse somewhere
(define-key *root-map* (kbd "b") "colon1 exec flatpak run engineer.atlas.Nyxt http://www.")
;; Ssh somewhere
(define-key *root-map* (kbd "C-s") "colon1 exec alacritty -e ssh ")
;; Lock screen
(define-key *root-map* (kbd "C-l") "exec slock")
;; Terminal
(define-key *root-map* (kbd "t") "exec alacritty")
;; Blender
(define-key *root-map* (kbd "y") "exec ~/.local/bl*/blender")

;; Web jump (works for DuckDuckGo and Imdb)
(defmacro make-web-jump (name prefix)
  `(defcommand ,(intern name) (search) ((:rest ,(concatenate 'string name " search: ")))
    (nsubstitute #\+ #\Space search)
    (run-shell-command (concatenate 'string ,prefix search))))

(make-web-jump "duckduckgo" "flatpak run engineer.atlas.Nyxt https://duckduckgo.com/?q=")
(make-web-jump "imdb" "flatpak run engineer.atlas.Nyxt http://www.imdb.com/find?q=")

;; C-t M-s is a terrble binding, but you get the idea.
(define-key *root-map* (kbd "M-s") "duckduckgo")
(define-key *root-map* (kbd "i") "imdb")

;; Message window font
(set-font "-xos4-terminus-medium-r-normal--14-140-72-72-c-80-iso8859-15")

;;; Define window placement policy...

;; Clear rules
(clear-window-placement-rules)

;; Last rule to match takes precedence!
;; TIP: if the argument to :title or :role begins with an ellipsis, a substring
;; match is performed.
;; TIP: if the :create flag is set then a missing group will be created and
;; restored from *data-dir*/create file.
;; TIP: if the :restore flag is set then group dump is restored even for an
;; existing group using *data-dir*/restore file.
(define-frame-preference "Default"
  ;; frame raise lock (lock AND raise == jumpto)
  (0 t nil :class "Konqueror" :role "...konqueror-mainwindow")
  (1 t nil :class "XTerm"))

(define-frame-preference "Ardour"
  (0 t   t   :instance "ardour_editor" :type :normal)
  (0 t   t   :title "Ardour - Session Control")
  (0 nil nil :class "XTerm")
  (1 t   nil :type :normal)
  (1 t   t   :instance "ardour_mixer")
  (2 t   t   :instance "jvmetro")
  (1 t   t   :instance "qjackctl")
  (3 t   t   :instance "qjackctl" :role "qjackctlMainForm"))

(define-frame-preference "Shareland"
  (0 t   nil :class "XTerm")
  (1 nil t   :class "aMule"))

(define-frame-preference "Emacs"
  (1 t t :restore "emacs-editing-dump" :title "...xdvi")
  (0 t t :create "emacs-dump" :class "Emacs"))
