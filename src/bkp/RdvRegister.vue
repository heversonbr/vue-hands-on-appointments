<template>
    <div class="rdv-register">
        <h2> {{ title }} </h2>
        <h4> {{appointments}} </h4>
        <form class="add-rdv" >
          <input type="text" v-model.trim="formValues.first_name" placeholder="first name" class="rdv-entry">
          <input type="text" v-model.trim="formValues.last_name"  placeholder="last name"  class="rdv-entry">
          
          <flat-pickr v-model="formValues.selected_date" :config="config" placeholder="select date"></flat-pickr>

          <div id="v-model-select-dynamic" class="time-select">
              <select v-model="formValues.selected_time">
                  <option v-for="option in formValues.time_options" v-bind:value="option" v-bind:key="option" > {{ option }} </option>
              </select>
          </div>
         
          
          <button v-on:click="addRendezvous"> Add Rdv </button>
        </form>
    </div>
</template>

<script>
 import flatPickr from 'vue-flatpickr-component'
 import 'flatpickr/dist/flatpickr.min.css'
 import Appointments from './Appointments.vue'

export default {

  name: 'RdvRegister',

  data(){

    return{

      formValues: {
        first_name: '',
        last_name: '',
        selected_date: null,
        time_options: [ '08:00' , '08:30' , '09:00' , '09:30' , '10:00' ],
        selected_time: ''
      },

      config: {
          dateFormat: 'd-m-Y',      
        }
      

    }
  },

  watch:{

    formValues(newValue){
      console.log('formValues changed ');
      console.log(newValue);

      deep: true;
    }
  },

  props: {
    title: String,
    appointments : Array
  },

  emits: ['add-rendezvous'],

  components: {
    flatPickr,
    Appointments
    
  
  },

  methods:{

    addRendezvous(event){

      event.preventDefault()
      
      console.log(this.formValues.first_name);
      console.log(this.formValues.last_name);
      console.log(this.formValues.selected_date);
      console.log(this.formValues.selected_time);

      let new_rdv = {
          id: this.appointments.length +1,
          first_name: this.formValues.first_name,
          last_name: this.formValues.last_name,
          date: this.formValues.selected_date,
          time: this.formValues.selected_time,
          complete: false
        }
      
      this.$emit('add-rendezvous', new_rdv);
      
      this.formValues.first_name = ''; 
      this.formValues.last_name = '';
      this.formValues.selected_date = '';
      this.formValues.selected_time = '';

    }
  }

}

</script>

<style scoped>


.rdv-register{
    background-color:darkgray;
    text-align: center;
    flex-grow: 1;

    display: flex;
    flex-direction: column;
}

.add-rdv{

  display: flex;
  flex-direction:column;
  
  align-items:center;
  /* justify-content: center; */
  
}

.rdv-entry{
  border: 0px;
  margin: 10px;
}

button{

  width: 90px;
  margin: 10px;
}

.time-select{
 
  margin: 10px;
}





</style>