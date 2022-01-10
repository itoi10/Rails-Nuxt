<template>
  <v-app>
    <welcome-app-bar />

    <v-img
      dark
      src="../assets/images/back.png"
      gradient="to top right, rgba(19,84,122,.6), rgba(128,208,199,.9)"
      :height="imgHeight"
    >
      <v-row
        align="center"
        justify="center"
        :style="{ height: `${imgHeight}px` }"
      >
        <v-col
          cols="12"
          class="text-center"
        >
          <h1 class="display-1 mb-4">
            Nuxt App Demo
          </h1>
          <h4
            class="subheading"
            :style="{ letterSpacing: '5px' }"
          >

          </h4>
        </v-col>
      </v-row>
    </v-img>

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
    <before-login-footer />
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
      imgHeight: 500,
      menus: [
        { title: 'about', subtitle: 'About' },
        { title: 'products', subtitle: 'Products' },
        { title: 'price', subtitle: 'Price' },
        { title: 'contact', subtitle: 'Contact' },
        { title: 'company', subtitle: 'Company' }
      ]
    }
  }
}
</script>