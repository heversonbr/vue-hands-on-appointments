<template>
    <div class="rdv-manager">
        <h2> {{ title }} </h2>
        <h4> {{appointments}} </h4>
        <div >
            <Appointments v-on:delete-rdv="deleteRdv" v-bind:appointments="appointments" />  
        </div>
    </div>
</template>

<script>

import Appointments from './Appointments.vue'

export default {
    
  name: 'RdvManager',

  props: {
    title: String,
    appointments : Array
  },

  components: {
      Appointments
  },

  methods:{

      deleteRdv(id){
          console.log('RdvManager.vue => running deleteRdv()')
          this.$emit('delete-rdv', id )
      }
  }

}
</script>


<style scoped>

.rdv-manager{ 
    background-color:bisque;
    text-align: center;
    flex-grow: 1;

    display: flex;
    flex-direction: column;


}

</style>