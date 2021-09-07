<template>
    <div class="rdv-register">
        <h2> {{ title }} </h2>
        <h4> Website for the public to set an appointement  </h4>
        <form class="add-rdv" >
          <input type="text" v-model.trim="formValues.first_name" placeholder="first name" class="rdv-entry">
          <input type="text" v-model.trim="formValues.last_name"  placeholder="last name"  class="rdv-entry">
          <div data-toggle="tooltip" data-placement="bottom" title="Choose the time for your appointment">
            <flat-pickr v-model="formValues.selected_date" :config="config" placeholder="select date"></flat-pickr>
          </div>
           <div id="v-model-select-dynamic" class="time-select">
              <select v-model="formValues.selected_time" data-toggle="tooltip" data-placement="bottom" title="Choose the time for your appointment">
                  <option v-for="option in formValues.time_options" v-bind:value="option" v-bind:key="option" > {{ option }} </option>
              </select>
          </div>
          <button class="btn-add" data-toggle="tooltip" data-placement="bottom" title="Click to add a new Appointment" v-on:click="addRendezvous"> Add Rendezvous </button>
        </form>
    </div>
</template>

<script>
  import flatPickr from 'vue-flatpickr-component'
  import 'flatpickr/dist/flatpickr.min.css'


  export default {

  name: 'RdvRegister',

  data(){

    return{

      formValues: {
        first_name: '',
        last_name: '',
        selected_date: null,
        time_options: ['08:00','08:15','08:30','08:45','09:00','09:30','09:45','10:00','10:15','10:30','10:45','11:00','11:15','11:30','11:45','12:00','12:15','12:30','12:45','13:00','13:30','13:45','14:00','14:15','14:30','15:00','15:15','15:30','15:45','16:00','16:15','16:45','17:00','17:15','17:30'],
        selected_time: ''
      },

      config: {
          dateFormat: 'd-m-Y',      
      }
      

    }
  },


  props: {
    title: String,
  },

  emits: ['add-rendezvous'],

  components: {
    flatPickr,    
  },

  methods:{

    addRendezvous(event){

      event.preventDefault();
      console.log('add');
      let result = this.validateFormInputs();
      console.log('result: ' + result);
      if(result){
        console.log('validate');
        let new_rdv = {
          id: null,
          first_name: this.formValues.first_name,
          last_name: this.formValues.last_name,
          date: this.formValues.selected_date,
          time: this.formValues.selected_time,
          status: 'open'
          // status : open, called, waiting, recalled, canceled, completed 
        }
        this.$emit('add-rendezvous', new_rdv);
        this.cleanFormInput();


      }else{
        console.log('no valid');
        alert('Missing information');
      }

    },
    cleanFormInput(){
    this.formValues.first_name = ''; 
    this.formValues.last_name = '';
    this.formValues.selected_date = '';
    this.formValues.selected_time = '';
    },

    validateFormInputs(){
      console.log('validating');
      if(this.formValues.first_name == '' ||  this.formValues.last_name == '' || this.formValues.selected_date == '' || this.formValues.selected_time == ''){
        console.log('vazio?  false');
        return false;
      }
      console.log('nao vazio? true');
      return true;

    }
  },

  


}
</script>

<style scoped>

/* *{
    font-family: 'Nunito', sans-serif;
} */

h4{
    color: tomato;
    margin-top: -10px;
}

.rdv-register{
    background-color:rgba(255, 182, 193, 0.555);
    text-align: center;
    flex-grow: 1;

    display: flex;
    flex-direction: column;
    font-family: 'Nunito', sans-serif;
  

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

.btn-add{
  width: 140px;

}





</style>