<template>
    <h1> {{welcome_msg}} </h1>
</template>

<script>
export default {
  name: 'Header',
  

  data() {
    return { welcome_msg: 'Welcome! ' }
  }

}
</script>


<style scoped>

h1{ 
    background-color:green;
    text-align: center;
}

</style>
