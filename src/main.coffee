import Vue from 'vue'
import Vuex from "vuex"
import App from './App.vue'
import vuetify from './plugins/vuetify'
import VueSocketIO from "vue-socket.io"

Vue.use(Vuex)
store = new (Vuex.Store)(
  state:
    count: 1
    isQuestion: false
    question: {}
    button: true
    listOfAttempts: []
  mutations:
    increment: (state) ->
      state.count++
      return
    tried: (state, p) ->
      state.question.triedID = p
    SOCKET_newQuestion: (s, p) ->
      console.log p
      s.isQuestion = true
      s.question = Object.assign({}, p)
      return
    SOCKET_checkedQuestion: (s, p) ->
      # console.log(p)
      # s.listOfAttempts.push(p)
      p.correct ? s.isRight = true : s.isWrong = true
      x.isRight = true for x in s.question.answers when x.id is p.aID
      x.isWrong = true for x in s.question.answers when x.id is p.gID 
        
      console.log s
      console.log p
      return
    SOCKET_news: (s, p) ->
      console.log p
      return
    disableButton: (s) ->
      s.button = false
      return
)
Vue.config.productionTip = false
Vue.use new VueSocketIO(
  debug: true
  connection: 'https://gimkit-backend.glitch.me/'
  vuex:
    store: store
    actionPrefix: 'SOCKET_'
    mutationPrefix: 'SOCKET_')

new Vue({
  vuetify,
  store,
  render: (h) ->
    h App
}).$mount("#app")

