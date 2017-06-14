<template lang="slm">
  .app
    p
      | {{ message }}
</template>

<script>
export default {
  data: function () {
    return {
      message: "Hello me"
    }
  }
}
</script>

<style lang="sass" scoped>
p
  font-size: 2em
  text-align: center
  color: red
</style>
