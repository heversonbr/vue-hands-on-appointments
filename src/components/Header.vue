<template>
    <h1> {{welcome_msg}} </h1>
</template>

<script>
export default {
  name: 'Header',
  

  data() {
    return { welcome_msg: 'Vue.js Hands-on : a Simple Example of an Appointments-App' }
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
    /* font-family: 'Nunito', sans-serif; */
}

</style>
