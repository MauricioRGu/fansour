# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"

pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true


pin "@rails/activestorage", to: "activestorage.esm.js"
pin "emoji-picker-element", to: "https://ga.jspm.io/npm:emoji-picker-element@1.21.3/index.js"
pin "insert-text-at-cursor", to: "https://ga.jspm.io/npm:insert-text-at-cursor@0.3.0/dist/index.umd.js"
pin "vivus", to: "https://ga.jspm.io/npm:vivus@0.4.6/dist/vivus.js"
