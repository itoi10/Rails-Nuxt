<template>
  <div id="logged-in-home">
    <v-parallax>
      <v-img
        :src="homeImg"
        alt="homeImg"
        :aspect-ratio="16/9"
        gradient="to top right, rgba(100,115,201,.33), rgba(25,32,72,.7)"
      >
        <v-container
          fill-height
        >
          <v-row
            justify="center"
            align="center"
          >
            <v-col
              cols="12"
              :sm="container.sm"
              :md="container.md"
            >
              <v-card-title class="white--text">
                最近のプロジェクト
              </v-card-title>

              <v-divider dark />

              <v-row
                align="center"
              >
                <v-col
                  cols="12"
                  :sm="card.sm"
                  :md="card.md"
                >
                  <v-btn
                    block
                    :height="card.height"
                    :elevation="card.elevation"
                  >
                    <div>
                      <v-icon
                        size="24"
                        color="myblue"
                        class="my-2"
                      >
                        mdi-plus
                      </v-icon>
                      <div class="caption myblue--text">
                        プロジェクトを追加
                      </div>
                    </div>
                  </v-btn>
                </v-col>
              </v-row>
            </v-col>
          </v-row>
        </v-container>
      </v-img>
    </v-parallax>
  </div>
</template>

<script>
import homeImg from '~/assets/images/loggedIn/home.png'

export default {
  layout ({ store }) {
    return store.state.loggedIn ? 'loggedIn' : 'welcome'
  },
  data () {
    return {
      homeImg,
      container: {
        sm: 10,
        md: 8
      },
      card: {
        sm: 6,
        md: 4,
        height: 120,
        elevation: 4
      }
    }
  },
  computed: {
    recentProjects () {
      const copyProjects = Array.from(this.$store.state.projects)
      return copyProjects.sort((a, b) => {
        if (a.updatedAt > b.updatedAt) { return -1 }
        if (a.updatedAt < b.updatedAt) { return 1 }
        return 0
      })
    }
  }
}
</script>

<style lang="scss">
#logged-in-home {
  .v-parallax__content {
    padding: 0;
  }
}
</style>
