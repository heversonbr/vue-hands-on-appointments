<template>
  <!-- this is my app root component  in the index.html -->
  <div class="myHeader"> <Header /> </div>
  <h4> {{info}} </h4>
  <br>
  <h4> {{this.appointments}} </h4>
  <div class="content-container">  
    <RdvRegister title="Register Rdv" v-bind:appointments="appointments" v-on:add-rendezvous="addSingleRendezvous" />
    <Panel title="Rendezvous List" v-bind:appointments="appointments" />
    <RdvManager title="Manage Rdv" v-bind:appointments="appointments" v-on:delete-rdv="deleteRendezvous"  />
  </div>
</template>

<script>
import Header from './components/Header.vue'
import Panel from './components/Panel.vue'
import RdvRegister from './components/RdvRegister.vue'
import RdvManager from './components/RdvManager.vue'
import axios from 'axios';

export default {

  name: 'App',

  components: {
    Header,
    RdvRegister,
    Panel,
    RdvManager
  },

  emits: ['add-rendezvous'],
  
  data(){
    return{
      info: [],  
    }   
  },

  computed:{
    appointments(){
       console.log('App.vue => running computed appointments()')
       return this.loadAppointments();
  }

  },
  
  watch:{
   appointments(){
      console.log('App.vue => appointments changed');
      
     },

    info(){
      console.log('App.vue => info changed');
     
    }
   },
  
  methods:{

    addSingleRendezvous(new_rdv){
      console.log('App.vue => addSingleRendezvous()');
      console.log(new_rdv);
      console.log(this.appointments);
      this.appointments.push(new_rdv); 
      console.log(this.appointments);
      

    },

    deleteRendezvous(id){
      console.log('App.vue => deleteRendezvous() method');
      console.log('id: ' + id);
      console.log(this.appointments);
      if (this.appointments.length > 0){
        this.appointments.forEach( (element, index) => { 
          if (element.id == id){
            this.appointments.splice(index, 1)
            console.log('deleting index: ' + index + ' with id: ' + element.id);
          }
        })
      }
      console.log(this.appointments);
    },

    loadAppointments(){
      console.log('App.vue => Loading appointments() ');
      let new_info = [];
      let random_times = ['08:00','08:15','08:30','08:45','09:00','09:30','09:45','10:00','10:15','10:30','10:45','11:00','11:15','11:30','11:45','12:00','12:15','12:30','12:45','13:00','13:30','13:45','14:00','14:15','14:30','15:00','15:15','15:30','15:45','16:00','16:15','16:45','17:00','17:15','17:30'];
      let random_dates = [ '01-09-2021','02-09-2021','03-09-2021','04-09-2021' ];

      let allAppointments = [];

      this.info.forEach( (element, index) => { 
      // return this.info.map(function callbackFn(element, index) { 
          let newRdv = {};
          newRdv['id'] = index+1;  
          newRdv['first_name'] = element.name.first;
          newRdv['last_name'] = element.name.last;
          newRdv['date'] = random_dates[Math.floor(Math.random() * random_dates.length)];
          newRdv['time'] = random_times[Math.floor(Math.random() * random_times.length)];
          newRdv['complete'] = false;
          allAppointments.push(newRdv);
      }) 
      console.log('loadAppointments() returning appointments: ');
      console.log(allAppointments);   
      return allAppointments;
    }
  },

  // lifecycle hooks: 
  created(){
    console.log('App.vue => created() : ');
  },
   
  mounted() {
    // 'https://randomuser.me/api/?results=5&inc=name&noinfo' 
    // 'https://jsonplaceholder.typicode.com/users'
    console.log('App.vue => mounted() : http get users');
    axios.get('https://randomuser.me/api/?results=10&inc=name&nat=FR&noinfo').
    then((response) => {
       // handle success
      console.log('setting response to this.info');
      this.info = response.data.results;
      //console.log(this.info);
      
      })
      .catch(function (error) {
        // handle error
        console.log(error);
      })
      .then(function () {
        // always executed
    });


  }
}

</script>

<style scoped>
*{
  font-family: Avenir, Helvetica, Arial, sans-serif;
  background-color:lightcyan;
 
  box-sizing: border-box;
  margin: 0;
  padding: 0;
  display: block;
}

.content-container{

  display: flex;
  flex-direction: row;
  justify-content: center;
  height: 100%;


}


</style>
