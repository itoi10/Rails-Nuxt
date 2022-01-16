<template>
  <div>
    <logged-in-nav-drawer
      :drawer.sync="drawer"
    />
    <logged-in-app-bar>
      <template #nav-icon>
        <v-app-bar-nav-icon
          @click="drawer = !drawer"
        />
      </template>
    </logged-in-app-bar>
  </div>
</template>

<script>
export default {
  data () {
    return {
      drawer: null
    }
  }
}
</script>
