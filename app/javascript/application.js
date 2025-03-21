// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "chartkick"
import "Chart.bundle"
import "@wizardhealth/stimulus-multiselect"

document.addEventListener("turbo:load", () => {
  // Force Chartkick to refresh charts
  if (typeof Chartkick !== 'undefined') {
    Chartkick.eachChart((chart) => {
      chart.redraw()
    })
  }
})
