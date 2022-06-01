<template>
    <h1> {{welcome_msg}} </h1>
</template>

<script>
export default {
  name: 'Header',
  

  data() {
    return { welcome_msg: 'Vue.js Hands-on : a simple web-app front-end for Appointments' }
  }

}
</script>


<style scoped>

h1{ 
    background-color:tomato;
    text-align: center;
    height: 10vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

</style>
