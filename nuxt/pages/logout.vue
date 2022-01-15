<template>
  <div />
</template>
<script>
export default {
  layout: 'logout',
  // トップページからのログアウト時にレイアウト変更されるように、
  // ログアウトのレイアウトを表示させた後にリダイレクト実行
  async middleware ({ store, redirect, from }) {
    await store.dispatch('logout')
    if (from.name !== 'index') { return redirect('/') }
  },
  beforeCreate () {
    this.$router.replace('/')
  }
}
</script>
