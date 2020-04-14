<template>
  <div id="app">
    <v-app>
      <!-- <v-navigation-drawer app>
      </v-navigation-drawer>
      -->
      <v-app-bar app>
        <v-row justify="center">
          <v-btn class="e" @click="getQ">Start</v-btn>
        </v-row>
      </v-app-bar>
      <!-- Sizes your content based upon application components -->
      <v-content>
        <!-- Provides the application the proper gutter -->
        <v-container fluid>
          <!-- :disabled="!this.$store.state.button"  -->
          <!--           
    <p v-if="qTime">{{ this.$store.state.question.q }}</p>
    <div v-if="qTime">
      <div :key="question.id" v-for="question in this.$store.state.question.answers">
        <v-btn color="accent" class="f" @click="van(question)">{{question.word}}</v-btn>
      </div>
          </div>-->
          <v-card class="mx-auto" max-width="344" v-if="qTime" outlined>
            <v-list-item three-line>
              <v-list-item-content>
                <div class="overline mb-4">Question</div>
                <v-list-item-title class="headline mb-1">{{ this.$store.state.question.q }}</v-list-item-title>
              </v-list-item-content>
            </v-list-item>

            <v-card-actions>
              <v-row>
                <v-col
                  class="pa-6"
                  :key="question.id"
                  v-for="question in this.$store.state.question.answers"
                >
                  <v-btn
                    :color="question.isRight ? 'success' : question.isWrong ? 'error' : ''"
                    text
                    class="f"
                    @click="van(question)"
                  >{{ question.word }}</v-btn>
                </v-col>
              </v-row>
            </v-card-actions>
          </v-card>
        </v-container>
      </v-content>

      <v-footer app>
        <!-- -->
      </v-footer>
    </v-app>
  </div>
</template>

<script lang="coffee">

export default {
  name: 'App'
  methods:
    questionColor: (e) ->
      if @$store.state.question.rightID is e.id then w = 'success' else if @$store.state.question.triedID is e.id then w = 'error' else w = ''
      console.log 'w', w
      console.log 'e.id', e.id
      console.log 'e', e
      return w
    kids: ->
      console.log @$store
      @$store.commit 'increment'
      return
    getQ: ->
      @$store.commit 'disableButton'
      @$socket.emit 'requestQuestion'
      return
    van: (e) ->
      console.log
        qID: @$store.state.question.id
        aID: e.id
      @$store.commit 'tried', e.id
      @$socket.emit 'attemptQuestion',
        qID: @$store.state.question.id
        aID: e.id
      return
  computed:
    bruh: ->
      console.log @$store
      @$store.state.count
    qTime: ->
      @$store.state.isQuestion
}
</script>

<style lang="scss">
@import url(https://cdn.jsdelivr.net/gh/tonsky/FiraCode@1.207/distr/fira_code.css);
body {
  overflow: hidden;
}

textarea {
  font-family: "Fira Code", monospace;
}

.f {
  margin-bottom: 10px;
}
</style>
