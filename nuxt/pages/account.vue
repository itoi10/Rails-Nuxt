<template>
  <v-container>
    <nuxt-child />
  </v-container>
</template>

<script>
export default {
  layout: 'loggedIn',
  // 自動で/accountというパスを生成されるが使わないのでアクセス不可(404)とする
  validate ({ route }) {
    return route.name !== 'account'
  }
}
</script>
