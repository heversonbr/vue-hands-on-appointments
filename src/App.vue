<template>
  <!-- this is my app root component  in the index.html -->
  <div class="myHeader"> <Header /> </div>
  
  <div class="content-container">  
    <RdvRegister title="Register Rendezvous" v-bind:appointments="appointments" 
                                      v-on:add-rendezvous="addRdv" />
    <Panel title="Rendezvous Panel" v-bind:appointments="appointments" 
                              v-bind:counters="counters" 
                              v-on:time-changed="setTime" 
                              v-on:date-changed="setDate"/>
    <RdvManager title="Manage Rendezvous"  v-on:call-rdv="callRdv" 
                                    v-on:delete-rdv="deleteRdv" 
                                    v-on:complete-rdv="completeRdv"
                                    v-bind:appointments="appointments" 
                                    v-bind:counters="counters" 
                                    v-bind:currentDate="currentDate" />
  </div>
</template>

<script>
import Header from './components/Header.vue'
import Panel from './components/Panel.vue'
import RdvRegister from './components/RdvRegister.vue'
import RdvManager from './components/RdvManager.vue'
import DateTimeWatch from './components/DateTimeWatch.vue'
import axios from 'axios';

export default {

  name: 'App',

  components: {
    Header,
    RdvRegister,
    Panel,
    RdvManager
  },
    // appointment structure (object):
    //  {  
    //      id: null,
    //      first_name: this.formValues.first_name,
    //      last_name: this.formValues.last_name,
    //      date: this.formValues.selected_date,
    //      time: this.formValues.selected_time,
    //      status : open, called, cancelled, completed  
    //  }
  
  data(){
    return{

      currentTime: String,
      currentDate: String,
      appointments: [],
      userInfo: [],
      counters: [ 
        { number : '1' , rdv : null }, 
        { number : '2' , rdv : null },
        { number : '3' , rdv : null },
        { number : '4' , rdv : null },
      ]
    }
  },

  computed:{

    datePoll(){
      console.log('App.vue =>  computing datePoll()');  
      let numbOfDates = 3;
      let startdate = new Date();
      let currentDay = startdate.getDate();
      let currentMonth = startdate.getMonth()+1;
      let currentYear = startdate.getFullYear();
      let bissextile = currentYear % 4 == 0 ? true : false ;
      let maxDaysMonth = (month, bissexto) =>  {
        let days = 0;
        if (month < 8 ) {
            if (month == 2){
              days = (bissexto) ? 29 : 28 ;
            }else{
              days = (month % 2 == 1) ? 31 : 30 ;
            }           
        }
        if (month > 7) {
            days = (month % 2 == 0) ? 31 : 30 ;
        }
        return days;
      }
      let maxMonth = maxDaysMonth(currentMonth, bissextile);
      let selectedDates = [];
      if(currentDay+numbOfDates-1  <= maxMonth){
        for (let i=currentDay; i<(currentDay+numbOfDates) ; i++){
            selectedDates.push(`0${i}`.slice(-2) + '-' + `0${currentMonth}`.slice(-2) + '-' + currentYear);
        }
      }else{
        let overlap = (currentDay+numbOfDates-1-maxMonth);
        for (let i=currentDay; i<=maxMonth ; i++){
            selectedDates.push(`0${i}`.slice(-2) + '-' + `0${currentMonth}`.slice(-2) + '-' + currentYear);
        }
        for (let i=1; i<=overlap ; i++){
            selectedDates.push(`0${i}`.slice(-2) + '-' + `0${currentMonth+1}`.slice(-2) + '-' + currentYear);
        }
      }
      return selectedDates;
    },    
  },

  watch:{

    appointments(newValue){
      console.log('App.vue =>  watch: appointments changed ')
      console.log(this.appointments);

      if(this.appointments!=null){
        this.appointments.sort(function(a,b){
        // Turn your strings into dates, and then subtract them
        // to get a value that is either negative, positive, or zero.
        return new Date(a.date) - new Date(b.date);
        });
        console.log(this.appointments);
        
      }
    },

    userInfo(){
      console.log('App.vue =>  watch: userInfo changed ');
      console.log('App.vue =>  watch: will parse loaded Info');
      this.appointments = this.parseLoadedInfo();
    }

  },
  
  methods:{

    addRdv(new_rdv){
      console.log('App.vue => addRdv()');
      new_rdv.id = this.appointments.length+1;
      this.appointments.push(new_rdv); 
      this.appointments.sort(function(a,b){
        // Turn your strings into dates, and then subtract them
        // to get a value that is either negative, positive, or zero.
        return new Date(a.date) - new Date(b.date);
       });
    },

    completeRdv(rdvItem){
            console.log('RdvManager.vue => completeRdv()');
            this.setAppointmentStatus(rdvItem, 'completed');
            this.removeRdvFromCounter(rdvItem);
            
    },
    

    deleteRdv(rdvItem){
      console.log('App.vue => deleteRendezvous() method');
      console.log('App.vue => deleteRendezvous() received rdv id: ' + rdvItem.id);
      console.log(this.appointments);
      // remove rdvitem from appointments array, by searching its 'id'
      if (this.appointments.length > 0 && rdvItem.status != 'completed'){
        this.appointments.forEach( (element, index) => { 
          if (element.id == rdvItem.id){
            this.appointments.splice(index, 1)
            console.log('App.vue => deleteRendezvous() deleting index: ' + index + ' with id: ' + element.id);
          }
        });

        // remove rdvitem from counters array
        this.removeRdvFromCounter(rdvItem);

      }
      
      

            
    },

    callRdv(payload){

      console.log('App.vue => callRdv() method: ');
      console.log('App.vue => callRdv() received rdv id: ' + payload.rdv.id);

      let tableIndex = function(element) {
        return element.number == payload.counter;
      }

      if (this.counters[this.counters.findIndex(tableIndex)].rdv == null){
        this.counters[this.counters.findIndex(tableIndex)].rdv = payload.rdv;
        this.setAppointmentStatus(payload.rdv, 'called');
        
      }else{
        alert('Counter #' + payload.counter + ' is busy!');
      }

    },

    removeRdvFromCounter(rdvItem){

      console.log(this.counters);
      this.counters.forEach( (element) => {
            if(element.rdv != null && element.rdv.id == rdvItem.id){
              console.log('found rdv-item-id: ' + rdvItem.id + ' at counter: ' + element.number + ' removing...');
              element.rdv = null;
            }
        }
      );
      console.log(this.counters);

    },

    setAppointmentStatus(rdv, status){

      this.appointments.forEach( (element, index) => {
        
        if(element.id == rdv.id){
          console.log('index of rdv.id ' + rdv.id + ' is ' + index );
          console.log('current status: ' + element.status);
          element.status = status;
          console.log('new status: ' + element.status);

        }
      }

      );

    },

    parseLoadedInfo(){
      console.log('App.vue => parseLoadedInfo() method: ');
      let random_times = ['08:00','08:15','08:30','08:45','09:00','09:30','09:45','10:00','10:15','10:30','10:45','11:00','11:15','11:30','11:45','12:00','12:15','12:30','12:45','13:00','13:30','13:45','14:00','14:15','14:30','15:00','15:15','15:30','15:45','16:00','16:15','16:45','17:00','17:15','17:30'];
      let random_dates = this.datePoll;
      let parsedAppointments = [];
            
      this.userInfo.forEach( (element, index) => { 
           let newRdv = {};
           newRdv['id'] = index+1;  
           newRdv['first_name'] = element.name.first;
           newRdv['last_name'] = element.name.last;
          //  newRdv['full_name'] = element.name.first + ' ' + element.name.last;
           newRdv['date'] = random_dates[Math.floor(Math.random() * random_dates.length)];
           newRdv['time'] = random_times[Math.floor(Math.random() * random_times.length)];
           newRdv['status'] = 'open';
           parsedAppointments.push(newRdv);
      });
      return parsedAppointments;
    },

    loadAppointments(){
        // insert a dynamic dataset of users from internet and parses the entries with random times and dates. 
        console.log('App.vue => loadAppointments() method');
      
        axios.get('https://randomuser.me/api/?results=10&inc=name&nat=FR&noinfo').
          then((response) => {
            // handle success
            console.log('App.vue => loadAppointments() : axios.get userInfo: response arrived');
            console.log('App.vue => loadAppointments() : set reponse to userInfo');
            this.userInfo = response.data.results;
      
            })
            .catch(function (error) {
              console.log(error);
            });
    },

    loadStaticAppointments(){
          // load a static dataset of appointments for testing the app 
          console.log('App.vue => loadStaticAppointments() method');
          let result = [ 
            {
              id: 1,
              first_name: 'john',
              last_name: 'doe',
              date: '02-09-2021',
              time: '08:30',
              status: 'open'
            },
            {
              id: 2,
              first_name: 'jean',
              last_name: 'michel',
              date: '02-09-2021',
              time: '09:30',
              status: 'open'
            },
            {
              id: 3,
              first_name: 'joao',
              last_name: 'pedro',
              date: '05-09-2021',
              time: '10:30',
              status: 'open'
            },
            {
              id: 4,
              first_name: 'maria',
              last_name: 'jose',
              date: '03-09-2021',
              time: '10:30',
              status: 'open'
            },
            {
              id: 5,
              first_name: 'mary',
              last_name: 'jean',
              date: '04-09-2021',
              time: '10:30',
              status: 'open'
            }  
          ]  ;
          return result;
    },

    setTime(newValue){
        this.currentTime = newValue;
    },

    setDate(newValue){
        console.log(typeof(newValue));
        this.currentDate = newValue;
        console.log(typeof(this.currentDate));

    },
  },

  
  // lifecycle hooks: 
  beforeCreate(){
      console.log('App.vue => beforeCreate() : ');
  },
  created(){
      console.log('App.vue => created() : invoke loadAppointments');
      this.appointments = this.loadAppointments();
      console.log(this.appointments); 
  },
  beforeMount(){
      console.log('App.vue => beforeMount() : ');
  },
  mounted(){
      console.log('App.vue => mounted() : ');     
  },
  beforeUpdate(){
      console.log('App.vue => beforeUpdate() : ');
  },
  updated(){
      console.log('App.vue => updated() : ');
  },
  beforeDestroy(){
      console.log('App.vue => beforeDestroy() : ');
  },
  destroyed(){
      console.log('App.vue => destroyed() : ');
  },

}

</script>

<style scoped>
*{
  
  font-family: 'Nunito', sans-serif;
  background-color:lightcyan;
 
  box-sizing: border-box;
  margin: 0;
  padding: 0;
  display: block;
}

/* .date-time{
  color: green;
}

.date-time-wathc{
   padding: 2px;
    margin: 0px;
    border: 1px;
     border-color: black;
    border-style: dotted;
    color: red;
} */

.content-container{

  display: flex;
  flex-direction: row;
  justify-content: center;
  height: 100%;


}


</style>
