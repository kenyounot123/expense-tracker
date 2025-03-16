import { Application } from "@hotwired/stimulus"
import { Multiselect } from '@wizardhealth/stimulus-multiselect'

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
application.register('multiselect', Multiselect)
window.Stimulus   = application

export { application }
