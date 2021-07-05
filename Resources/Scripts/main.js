import '@hotwired/turbo'

import './dom_helpers.js'

import { ExternalLinkRetargeter } from './external_link_retargeter.js'
import { SPIPackageListNavigation } from './package_list_navigation.js'
import { SPICopyPackageURLButton } from './copy_buttons.js'
import { SPICopyableInput } from './copy_buttons.js'
import { SPIBuildLogNavigation } from './build_log_navigation.js'
import { SPIAutofocus } from './autofocus.js'
import { SPIPlaygroundsAppLinkFallback } from './playgrounds_app_link.js'
import { SPIReadmeElement } from './readme_element.js'
import { SPIPackageTabs } from './package_tabs.js'

window.externalLinkRetargeter = new ExternalLinkRetargeter()
window.spiPackageListNavigation = new SPIPackageListNavigation()
window.buildLogNavigation = new SPIBuildLogNavigation()
new SPICopyPackageURLButton()
new SPICopyableInput()
new SPIAutofocus()
new SPIPlaygroundsAppLinkFallback()
new SPIPackageTabs()

customElements.define('spi-readme', SPIReadmeElement)

import 'normalize.css'
import '../Styles/main.scss'

//# sourceMappingURL=main.js.map
