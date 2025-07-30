# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "sortablejs", to: "https://cdn.jsdelivr.net/npm/sortablejs@1.15.0/modular/sortable.core.esm.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "progressbar.js" # @1.1.1
pin "fullcalendar", to: "https://cdn.skypack.dev/fullcalendar@6.1.8"
