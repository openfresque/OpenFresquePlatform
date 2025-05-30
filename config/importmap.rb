# config/importmap.rb

# ——— Hotwire ———
pin "@hotwired/turbo-rails",       to: "turbo.min.js",            preload: true
pin "@hotwired/stimulus",           to: "stimulus.min.js",         preload: true
pin "@hotwired/stimulus-loading",   to: "stimulus-loading.js",     preload: true

# ——— Host app entrypoint ———
pin "application",                  to: "application.js",          preload: true

# --- Bootstrap --- 
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.3.1/dist/js/bootstrap.esm.js"
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.8/dist/esm/popper.js"

# ——— Engine ———
pin "open_fresk",                   to: "open_fresk/application.js", preload: true

# ——— Controllers (host + engine) ———
pin_all_from "app/javascript/controllers",            under: "controllers"
pin_all_from "app/javascript/open_fresk/controllers", under: "open_fresk/controllers"