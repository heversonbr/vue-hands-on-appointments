<template>
    <div class="rdv-manager">
        <h2> {{ title }} </h2>
        <h4> Private intranet view for employees to manage appointements  </h4>
        <div class="appointments-container" >
            <Appointments v-on:complete-rdv="completeRdv" v-on:call-rdv="callRdv" v-on:delete-rdv="deleteRdv" v-bind:appointments="appointments" v-bind:counters="counters"  v-bind:currentDate="currentDate" />  
        </div>
    </div>
</template>
<script>

import Appointments from './Appointments.vue'

export default {
    
  name: 'RdvManager',

  props: {
    title: String,
    appointments : Array,
    counters: Array,
    currentDate: String
  },

  components: {
      Appointments
  },

  emits: ['delete-rdv', 'call-rdv', 'complete-rdv'],

  methods:{
        deleteRdv(rdvItem){
            console.log('RdvManager.vue => running deleteRdv()');
            this.$emit('delete-rdv', rdvItem );
        },

        completeRdv(rdvItem){
            console.log('RdvManager.vue => running completeRdv()');
            this.$emit('complete-rdv', rdvItem );
        },

        callRdv(payload){
            console.log('RdvManager.vue => callRdv');
            this.$emit('call-rdv', payload);
        }
  }
}
</script>

<style scoped>

.appointments-container{
    margin-top: 10px;
}

.rdv-manager{ 
    background-color:rgba(255, 182, 193, 0.555);
    text-align: center;
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    font-family: 'Nunito', sans-serif;
   
}

h4{
    color: tomato;
    margin-top: -10px;
}

</style>