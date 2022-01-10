<template>
  <div>
    index.vue
  </div>
</template>

<script>
export default {
  layout ({ store }) {
    return store.state.isLoggedIn ? 'default' : 'welcome'
  }
}
</script>