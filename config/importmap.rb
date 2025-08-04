# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "sortablejs", to: "https://cdn.jsdelivr.net/npm/sortablejs@1.15.0/modular/sortable.core.esm.js"
pin "fullcalendar", to: "https://cdn.skypack.dev/fullcalendar@6.1.8"
pin "@rolemodel/turbo-confirm", to: "@rolemodel--turbo-confirm.js" # @2.1.1
