<template>
  <before-login-form-card>
    <template
      #form-card-content
    >
      <v-form
        ref="form"
        v-model="isValid"
      >
        <user-form-name
          :name.sync="params.user.name"
        />
        <user-form-email
          :email.sync="params.user.email"
        />
        <user-form-password
          :password.sync="params.user.password"
        />
        <v-btn
          :disabled="!isValid || loading"
          :loading="loading"
          block
          color="myblue"
          class="white--text"
          @click="signup"
        >
          登録する
        </v-btn>
      </v-form>
      <v-card-text>
        {{ params }}
      </v-card-text>
    </template>
  </before-login-form-card>
</template>

<script>
export default {
  layout: 'beforeLogin',
  data () {
    return {
      loading: false,
      // フォームバリデーションOK?
      isValid: false,
      // RailsAPI送信用オブジェクト
      params: {
        user: {
          name: '',
          email: '',
          password: ''
        }
      }
    }
  },
  methods: {
    signup () {
      // 仮アクション, RailsAPI呼び出し未実装
      this.loading = true
      setTimeout(() => {
        this.formReset()
        this.loading = false
      }, 1500)
    },
    formReset () {
      // v-form[ref="form"]の入力を削除
      this.$refs.form.reset()
      // dataリセット
      this.params = { user: { name: '', email: '', password: '' } }
    }
  }
}
</script>
