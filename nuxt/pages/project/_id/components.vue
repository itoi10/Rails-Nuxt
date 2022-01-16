<template>
  <logged-in-container>
    <template #my-content>
      {{ $route.fullPath }}
    </template>
  </logged-in-container>
</template>

<script>
export default {
}
</script>
