// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: {_csrf_token: csrfToken}
})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
// Keep the scroll position across page reloads (e.g. dev live reload on save).
// The browser's own restoration loses it because LiveView re-renders after load.
const scrollKey = `scroll:${location.pathname}${location.search}`
window.addEventListener("beforeunload", () => {
  sessionStorage.setItem(scrollKey, String(window.scrollY))
})
const navType = performance.getEntriesByType("navigation")[0]?.type
const savedScroll = sessionStorage.getItem(scrollKey)
if (navType === "reload" && savedScroll !== null) {
  history.scrollRestoration = "manual"
  const restore = () => window.scrollTo(0, Number(savedScroll))
  restore()
  window.addEventListener("phx:page-loading-stop", restore, {once: true})
}

liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket


// Lightbox: click any image inside an article to view it full screen.
// Delegated on document so it survives LiveView navigation.
const lightbox = document.createElement("dialog")
lightbox.className = "lightbox"
lightbox.innerHTML = `<img alt="">`
document.body.appendChild(lightbox)
const lightboxImg = lightbox.querySelector("img")

document.addEventListener("click", e => {
  const img = e.target.closest("article img")
  if (!img || img.closest("a")) return
  lightboxImg.src = img.currentSrc || img.src
  lightboxImg.alt = img.alt
  lightbox.showModal()
})

// Close on any click inside the dialog (image or backdrop); Esc closes natively.
lightbox.addEventListener("click", () => lightbox.close())
