;;; dynamic-fonts-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "dynamic-fonts" "dynamic-fonts.el" (22769 18416
;;;;;;  0 0))
;;; Generated autoloads from dynamic-fonts.el

(let ((loads (get 'dynamic-fonts 'custom-loads))) (if (member '"dynamic-fonts" loads) nil (put 'dynamic-fonts 'custom-loads (cons '"dynamic-fonts" loads))))

(let ((loads (get 'dynamic-fonts-preferred-fonts 'custom-loads))) (if (member '"dynamic-fonts" loads) nil (put 'dynamic-fonts-preferred-fonts 'custom-loads (cons '"dynamic-fonts" loads))))

(autoload 'dynamic-fonts-setup "dynamic-fonts" "\
Set up `fixed-pitch', `variable-pitch', and `default' faces.

The font face and size is determined dynamically, by comparing
the following values

    `dynamic-fonts-preferred-monospace-fonts'
    `dynamic-fonts-preferred-monospace-point-size'
    `dynamic-fonts-preferred-proportional-fonts'
    `dynamic-fonts-preferred-proportional-point-size'

with the fonts available on your system.

When `dynamic-fonts-set-alternatives' is set, also amends
the standard value of `face-font-family-alternatives', providing
the values above as alternatives.

\(fn)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; dynamic-fonts-autoloads.el ends here
