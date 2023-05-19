# flycheck-rjan

This package integrates
[rjan](https://github.com/sogaiu/review-janet) with Emacs via
[flycheck](https://www.flycheck.org).

## Setup

0. Ensure [`rjan`](https://github.com/sogaiu/review-janet) is
   installed and on your `PATH`.  Probably it makes sense if
   [janet-mode](https://github.com/ALSchwalm/janet-mode/) or
   [janet-ts-mode](https://github.com/sogaiu/janet-ts-mode) have been
   setup as well.

1. Clone this repository.  For the sake of concrete exposition,
   suppose the result ends up living under `~/src/flycheck-rjan`.

2. Add the following to your `init.el` (or .emacs-equivalent):

    ```emacs-lisp
    (add-to-list 'load-path
                 (expand-file-name "~/src/flycheck-rjan"))
    (require 'flycheck-rjan)
    ```

3. If you don't already have some flycheck stuff setup, you might also
   want to add:

    ```emacs-lisp
    (global-flycheck-mode)
    ```

4. To use the `rjan` flycheck checker (`janet-rjan`) "chained" along
   with `flycheck-janet`, also add:

    ```emacs-lisp
    (flycheck-add-next-checker 'janet-rjan 'janet-janet)
    ```

    This should arrange for the `janet-rjan` checker to run after
    `janet-janet` (the checker that's provided by `flycheck-janet`).

## Verify Operation

1. Open / create a `.janet` file with content like:

    ```janet
    (defn table
      [count]
      @{:a count})

    (def a
    ```

2. Assuming `janet-mode` or `janet-ts-mode` are active, `M-x
   flycheck-list-errors` should bring up a buffer (`*Flycheck
   errors*`) showing an error, but there should also be visual
   evidence in the buffer with Janet code indicating a problem.

3. Add something like ` 1)` to the end of `(def a` -- in other words,
   fix an error.  This should lead to some change both in the
   `*Flycheck errors*` buffer as well as the buffer containing Janet
   code.

## Troubleshooting

If there are no errors displayed, one option that might help is to
check out the [troubleshooting section of the flycheck
docs](https://www.flycheck.org/en/latest/user/troubleshooting.html).

If the common issues section doesn't help, possibly one or both of the
following two commands ([mentioned later in flycheck's
docs](https://www.flycheck.org/en/latest/user/troubleshooting.html#verify-your-setup))
might help in diagnosing the situation:

* `M-x flycheck-verify-setup`
* `M-x flycheck-compile`

