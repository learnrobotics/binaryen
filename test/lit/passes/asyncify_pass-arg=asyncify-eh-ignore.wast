;; NOTE: Assertions have been generated by update_lit_checks.py --all-items and should not be edited.
;; NOTE: This test was ported using port_passes_tests_to_lit.py and could be cleaned up.

;; RUN: foreach %s %t wasm-opt --enable-exception-handling --asyncify --pass-arg=asyncify-ignore-unwind-from-catch --pass-arg=asyncify-onlylist@foo -S -o - | filecheck %s

(module
  (memory 1 2)
  ;; CHECK:      (type $0 (func))

  ;; CHECK:      (type $1 (func (param i32)))

  ;; CHECK:      (type $2 (func (result i32)))

  ;; CHECK:      (import "extmod" "exttag" (tag $default (param i32)))
  (import "extmod" "exttag" (tag $default (param i32)))
  ;; CHECK:      (global $__asyncify_state (mut i32) (i32.const 0))

  ;; CHECK:      (global $__asyncify_catch_counter (mut i32) (i32.const 0))

  ;; CHECK:      (global $__asyncify_data (mut i32) (i32.const 0))

  ;; CHECK:      (memory $0 1 2)

  ;; CHECK:      (export "asyncify_start_unwind" (func $asyncify_start_unwind))

  ;; CHECK:      (export "asyncify_stop_unwind" (func $asyncify_stop_unwind))

  ;; CHECK:      (export "asyncify_start_rewind" (func $asyncify_start_rewind))

  ;; CHECK:      (export "asyncify_stop_rewind" (func $asyncify_stop_rewind))

  ;; CHECK:      (export "asyncify_get_state" (func $asyncify_get_state))

  ;; CHECK:      (export "asyncify_get_catch_counter" (func $asyncify_get_catch_counter))

  ;; CHECK:      (func $foo
  ;; CHECK-NEXT:  (local $0 i32)
  ;; CHECK-NEXT:  (local $1 i32)
  ;; CHECK-NEXT:  (local $2 i32)
  ;; CHECK-NEXT:  (local $3 i32)
  ;; CHECK-NEXT:  (local $4 i32)
  ;; CHECK-NEXT:  (if
  ;; CHECK-NEXT:   (i32.eq
  ;; CHECK-NEXT:    (global.get $__asyncify_state)
  ;; CHECK-NEXT:    (i32.const 2)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:   (nop)
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (local.tee $3
  ;; CHECK-NEXT:   (block $__asyncify_unwind
  ;; CHECK-NEXT:    (block
  ;; CHECK-NEXT:     (block
  ;; CHECK-NEXT:      (if
  ;; CHECK-NEXT:       (i32.eq
  ;; CHECK-NEXT:        (global.get $__asyncify_state)
  ;; CHECK-NEXT:        (i32.const 2)
  ;; CHECK-NEXT:       )
  ;; CHECK-NEXT:       (block
  ;; CHECK-NEXT:        (i32.store
  ;; CHECK-NEXT:         (global.get $__asyncify_data)
  ;; CHECK-NEXT:         (i32.add
  ;; CHECK-NEXT:          (i32.load
  ;; CHECK-NEXT:           (global.get $__asyncify_data)
  ;; CHECK-NEXT:          )
  ;; CHECK-NEXT:          (i32.const -4)
  ;; CHECK-NEXT:         )
  ;; CHECK-NEXT:        )
  ;; CHECK-NEXT:        (local.set $4
  ;; CHECK-NEXT:         (i32.load
  ;; CHECK-NEXT:          (i32.load
  ;; CHECK-NEXT:           (global.get $__asyncify_data)
  ;; CHECK-NEXT:          )
  ;; CHECK-NEXT:         )
  ;; CHECK-NEXT:        )
  ;; CHECK-NEXT:       )
  ;; CHECK-NEXT:      )
  ;; CHECK-NEXT:      (if
  ;; CHECK-NEXT:       (i32.eq
  ;; CHECK-NEXT:        (global.get $__asyncify_state)
  ;; CHECK-NEXT:        (i32.const 0)
  ;; CHECK-NEXT:       )
  ;; CHECK-NEXT:       (try $try
  ;; CHECK-NEXT:        (do
  ;; CHECK-NEXT:         (call $fn1)
  ;; CHECK-NEXT:        )
  ;; CHECK-NEXT:        (catch $default
  ;; CHECK-NEXT:         (local.set $2
  ;; CHECK-NEXT:          (pop i32)
  ;; CHECK-NEXT:         )
  ;; CHECK-NEXT:         (try $foo-finally-1
  ;; CHECK-NEXT:          (do
  ;; CHECK-NEXT:           (block $foo-pop-1
  ;; CHECK-NEXT:            (local.set $1
  ;; CHECK-NEXT:             (local.get $2)
  ;; CHECK-NEXT:            )
  ;; CHECK-NEXT:            (global.set $__asyncify_catch_counter
  ;; CHECK-NEXT:             (i32.add
  ;; CHECK-NEXT:              (global.get $__asyncify_catch_counter)
  ;; CHECK-NEXT:              (i32.const 1)
  ;; CHECK-NEXT:             )
  ;; CHECK-NEXT:            )
  ;; CHECK-NEXT:           )
  ;; CHECK-NEXT:           (local.set $0
  ;; CHECK-NEXT:            (local.get $1)
  ;; CHECK-NEXT:           )
  ;; CHECK-NEXT:           (call $fn2)
  ;; CHECK-NEXT:           (global.set $__asyncify_catch_counter
  ;; CHECK-NEXT:            (i32.sub
  ;; CHECK-NEXT:             (global.get $__asyncify_catch_counter)
  ;; CHECK-NEXT:             (i32.const 1)
  ;; CHECK-NEXT:            )
  ;; CHECK-NEXT:           )
  ;; CHECK-NEXT:          )
  ;; CHECK-NEXT:          (catch_all
  ;; CHECK-NEXT:           (global.set $__asyncify_catch_counter
  ;; CHECK-NEXT:            (i32.sub
  ;; CHECK-NEXT:             (global.get $__asyncify_catch_counter)
  ;; CHECK-NEXT:             (i32.const 1)
  ;; CHECK-NEXT:            )
  ;; CHECK-NEXT:           )
  ;; CHECK-NEXT:           (rethrow $foo-finally-1)
  ;; CHECK-NEXT:          )
  ;; CHECK-NEXT:         )
  ;; CHECK-NEXT:        )
  ;; CHECK-NEXT:        (catch_all
  ;; CHECK-NEXT:         (try $foo-finally-2
  ;; CHECK-NEXT:          (do
  ;; CHECK-NEXT:           (global.set $__asyncify_catch_counter
  ;; CHECK-NEXT:            (i32.add
  ;; CHECK-NEXT:             (global.get $__asyncify_catch_counter)
  ;; CHECK-NEXT:             (i32.const 1)
  ;; CHECK-NEXT:            )
  ;; CHECK-NEXT:           )
  ;; CHECK-NEXT:           (call $fn3)
  ;; CHECK-NEXT:           (global.set $__asyncify_catch_counter
  ;; CHECK-NEXT:            (i32.sub
  ;; CHECK-NEXT:             (global.get $__asyncify_catch_counter)
  ;; CHECK-NEXT:             (i32.const 1)
  ;; CHECK-NEXT:            )
  ;; CHECK-NEXT:           )
  ;; CHECK-NEXT:          )
  ;; CHECK-NEXT:          (catch_all
  ;; CHECK-NEXT:           (global.set $__asyncify_catch_counter
  ;; CHECK-NEXT:            (i32.sub
  ;; CHECK-NEXT:             (global.get $__asyncify_catch_counter)
  ;; CHECK-NEXT:             (i32.const 1)
  ;; CHECK-NEXT:            )
  ;; CHECK-NEXT:           )
  ;; CHECK-NEXT:           (rethrow $foo-finally-2)
  ;; CHECK-NEXT:          )
  ;; CHECK-NEXT:         )
  ;; CHECK-NEXT:        )
  ;; CHECK-NEXT:       )
  ;; CHECK-NEXT:      )
  ;; CHECK-NEXT:     )
  ;; CHECK-NEXT:     (return)
  ;; CHECK-NEXT:    )
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (block
  ;; CHECK-NEXT:   (i32.store
  ;; CHECK-NEXT:    (i32.load
  ;; CHECK-NEXT:     (global.get $__asyncify_data)
  ;; CHECK-NEXT:    )
  ;; CHECK-NEXT:    (local.get $3)
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:   (i32.store
  ;; CHECK-NEXT:    (global.get $__asyncify_data)
  ;; CHECK-NEXT:    (i32.add
  ;; CHECK-NEXT:     (i32.load
  ;; CHECK-NEXT:      (global.get $__asyncify_data)
  ;; CHECK-NEXT:     )
  ;; CHECK-NEXT:     (i32.const 4)
  ;; CHECK-NEXT:    )
  ;; CHECK-NEXT:   )
  ;; CHECK-NEXT:  )
  ;; CHECK-NEXT:  (nop)
  ;; CHECK-NEXT: )
  (func $foo
    (local $0 i32)
    (try
      (do
        (call $fn1)
      )
      (catch $default
        (local.set $0
          (pop i32)
        )
        (call $fn2)
      )
      (catch_all
        (call $fn3)
      )
    )
  )

  ;; CHECK:      (func $fn1
  ;; CHECK-NEXT:  (nop)
  ;; CHECK-NEXT: )
  (func $fn1
  )

  ;; CHECK:      (func $fn2
  ;; CHECK-NEXT:  (nop)
  ;; CHECK-NEXT: )
  (func $fn2
  )

  ;; CHECK:      (func $fn3
  ;; CHECK-NEXT:  (nop)
  ;; CHECK-NEXT: )
  (func $fn3
  )
)
;; CHECK:      (func $asyncify_start_unwind (param $0 i32)
;; CHECK-NEXT:  (if
;; CHECK-NEXT:   (i32.ne
;; CHECK-NEXT:    (global.get $__asyncify_catch_counter)
;; CHECK-NEXT:    (i32.const 0)
;; CHECK-NEXT:   )
;; CHECK-NEXT:   (return)
;; CHECK-NEXT:  )
;; CHECK-NEXT:  (global.set $__asyncify_state
;; CHECK-NEXT:   (i32.const 1)
;; CHECK-NEXT:  )
;; CHECK-NEXT:  (global.set $__asyncify_data
;; CHECK-NEXT:   (local.get $0)
;; CHECK-NEXT:  )
;; CHECK-NEXT:  (if
;; CHECK-NEXT:   (i32.gt_u
;; CHECK-NEXT:    (i32.load
;; CHECK-NEXT:     (global.get $__asyncify_data)
;; CHECK-NEXT:    )
;; CHECK-NEXT:    (i32.load offset=4
;; CHECK-NEXT:     (global.get $__asyncify_data)
;; CHECK-NEXT:    )
;; CHECK-NEXT:   )
;; CHECK-NEXT:   (unreachable)
;; CHECK-NEXT:  )
;; CHECK-NEXT: )

;; CHECK:      (func $asyncify_stop_unwind
;; CHECK-NEXT:  (global.set $__asyncify_state
;; CHECK-NEXT:   (i32.const 0)
;; CHECK-NEXT:  )
;; CHECK-NEXT:  (if
;; CHECK-NEXT:   (i32.gt_u
;; CHECK-NEXT:    (i32.load
;; CHECK-NEXT:     (global.get $__asyncify_data)
;; CHECK-NEXT:    )
;; CHECK-NEXT:    (i32.load offset=4
;; CHECK-NEXT:     (global.get $__asyncify_data)
;; CHECK-NEXT:    )
;; CHECK-NEXT:   )
;; CHECK-NEXT:   (unreachable)
;; CHECK-NEXT:  )
;; CHECK-NEXT: )

;; CHECK:      (func $asyncify_start_rewind (param $0 i32)
;; CHECK-NEXT:  (global.set $__asyncify_state
;; CHECK-NEXT:   (i32.const 2)
;; CHECK-NEXT:  )
;; CHECK-NEXT:  (global.set $__asyncify_data
;; CHECK-NEXT:   (local.get $0)
;; CHECK-NEXT:  )
;; CHECK-NEXT:  (if
;; CHECK-NEXT:   (i32.gt_u
;; CHECK-NEXT:    (i32.load
;; CHECK-NEXT:     (global.get $__asyncify_data)
;; CHECK-NEXT:    )
;; CHECK-NEXT:    (i32.load offset=4
;; CHECK-NEXT:     (global.get $__asyncify_data)
;; CHECK-NEXT:    )
;; CHECK-NEXT:   )
;; CHECK-NEXT:   (unreachable)
;; CHECK-NEXT:  )
;; CHECK-NEXT: )

;; CHECK:      (func $asyncify_stop_rewind
;; CHECK-NEXT:  (global.set $__asyncify_state
;; CHECK-NEXT:   (i32.const 0)
;; CHECK-NEXT:  )
;; CHECK-NEXT:  (if
;; CHECK-NEXT:   (i32.gt_u
;; CHECK-NEXT:    (i32.load
;; CHECK-NEXT:     (global.get $__asyncify_data)
;; CHECK-NEXT:    )
;; CHECK-NEXT:    (i32.load offset=4
;; CHECK-NEXT:     (global.get $__asyncify_data)
;; CHECK-NEXT:    )
;; CHECK-NEXT:   )
;; CHECK-NEXT:   (unreachable)
;; CHECK-NEXT:  )
;; CHECK-NEXT: )

;; CHECK:      (func $asyncify_get_state (result i32)
;; CHECK-NEXT:  (global.get $__asyncify_state)
;; CHECK-NEXT: )

;; CHECK:      (func $asyncify_get_catch_counter (result i32)
;; CHECK-NEXT:  (global.get $__asyncify_catch_counter)
;; CHECK-NEXT: )
