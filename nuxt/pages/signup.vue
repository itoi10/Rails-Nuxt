<template>
  <before-login-form-card>
    <template
      #form-card-content
    >
      <v-form>
        <user-form-name />
        <user-form-email />
        <user-form-password />
      </v-form>
    </template>
  </before-login-form-card>
</template>

<script>
export default {
  layout: 'beforeLogin'
}
</script>