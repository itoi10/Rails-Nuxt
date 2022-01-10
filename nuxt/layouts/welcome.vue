<template>
  <v-app>
    <wel-app-bar />
    <v-sheet>
      <v-container
        fluid
        :style="{ maxWidth: '1280px' }"
      >
        <v-row
          v-for="(menu, i) in menus"
          :key="`menu-${i}`"
        >
          <v-col cols="12">
            <div :is="`welcome-${menu.title}`" />
          </v-col>
        </v-row>
      </v-container>
    </v-sheet>
  </v-app>
</template>

<script>
import welcomeAbout from '~/components/welcome/welcomeAbout'
import welcomeProducts from '~/components/welcome/welcomeProducts'
import welcomePrice from '~/components/welcome/welcomePrice'
import welcomeContact from '~/components/welcome/welcomeContact'
import welcomeCompany from '~/components/welcome/welcomeCompany'

export default {
  components: {
    welcomeAbout,
    welcomeProducts,
    welcomePrice,
    welcomeContact,
    welcomeCompany
  },
  data () {
    return {
      menus: [
        { title: 'about', subtitle: 'About' },
        { title: 'products', subtitle: '他にはない優れた機能の数々' },
        { title: 'price', subtitle: '会社の成長に合わせた3つのプラン' },
        { title: 'contact', subtitle: 'お気軽にご連絡を' },
        { title: 'company', subtitle: '私たちの会社' }
      ]
    }
  }
}
</script>