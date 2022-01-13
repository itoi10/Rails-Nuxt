<template>
  <v-text-field
    v-model="setEmail"
    :rules="rules"
    label="メールアドレスを入力"
    :placeholder="form.placeholder"
    outlined
  />
</template>

<script>
export default {
  props: {
    email: {
      type: String,
      default: ''
    },
    noValidation: {
      type: Boolean,
      default: false
    }
  },
  data () {
    return {
      // 入力必須, 書式チェック
      // (入力中にはエラーメッセージが表示しないでおく)
      rules: [
        v => !!v || '',
        v => /.+@.+\..+/.test(v) || ''
      ]
    }
  },
  computed: {
    setEmail: {
      get () { return this.email },
      set (newVal) { return this.$emit('update:email', newVal) }
    },
    form () {
      // propsにnoValidationありならplaceholder設定なし
      const placeholder = this.noValidation ? undefined : 'your@email.com'
      return { placeholder }
    }
  }
}
</script>
