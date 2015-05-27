;; This is where I keep bigger temporary macros with arguments.

(global-set-key (kbd "C-c i") 'py-boolean-field)

(defun py-abstract-property (string)
  (interactive "sproperty name: ")
  (insert (format "def get_%s(self, *args, **kwargs):" string))
  (py-newline-and-indent)
  (insert "raise NotImplementedError()")
  (py-newline-and-indent)
  (insert (format "def set_%s(self, *args, **kwargs):" string))
  (py-newline-and-indent)
  (insert "raise NotImplementedError()")
  (py-newline-and-indent)
  (insert (format "%s = property(fget=get_%s, fset=set_%s)" string string string)))

(defun py-boolean-field (string)
  (interactive "sproperty name: ")
  (insert (format "is_%s = BooleanField(default=False)" string))
  (py-newline-and-indent))

