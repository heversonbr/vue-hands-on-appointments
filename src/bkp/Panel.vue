<template>
    <div class="my-panel">
        <h2> {{ title }} </h2>
        <div class="date-time-panel">     
           <span>{{ currentDay }} </span>
           <span>{{ currentHour }} </span>
        </div>
        <h4> {{appointments}} </h4>
        <hr>
        <h4> {{todaysAppointments}} </h4>
        <div class="rdv-item" v-if="todaysAppointments.length>0" >
                <ul>
                    <div v-for="rdv in todaysAppointments" v-bind:key="rdv.id" >
                        <li>
                            <p>  {{rdv.f_name}} </p> 
                            <p>  {{rdv.l_name }} </p> 
                            <p>  {{rdv.date}} </p> 
                            <p>  {{rdv.time}} </p> 
                        </li>
                    </div>
                </ul>
        </div>
    </div>

</template>

<script>

import Appointments from './Appointments.vue'

export default {

    name: 'Panel',  
    props: {
        title: String,
        appointments : Array
    }, 

    components: {
        Appointments
    },  
    
    data(){   
      return{
          currentDay : String,
          currentHour : String,
      }
    },

    watch:{
        todaysAppointments(){
          console.log('Panel.vue => todaysAppointments changed');
          //this.allAppointments = this.appointments;
          deep: true
         },
         appointments(){
          console.log('Panel.vue => appointments changed');
          //this.allAppointments = this.appointments;
          deep: true
         },
   },
    
    computed:{
        todaysAppointments(){
            console.log('Panel.vue => computed todaysAppointments()');
            return this.selectAppointments();
        }
    },


    methods:{
    currentDate() {
        let today = new Date();
        this.currentDay = `0${today.getDate()}`.slice(-2) + '-' + `0${today.getMonth()+1}`.slice(-2) + '-' + today.getFullYear()
    },
    currentTime() {
        let now = new Date();
        this.currentHour = now.getHours() + ':' + now.getMinutes() + ':' + now.getUTCSeconds();
    },
    selectAppointments(){
        console.log('Panel.vue => selectAppointments()')
        let selected = [];
        this.appointments.forEach((element) => {
            console.log('element date: ' + element.date);
            console.log('current day: ' + this.currentDay);
            if(element.date == this.currentDay){
                console.log('same day: ');
                let rdv = {};
                rdv['id'] = element.id;
                rdv['f_name'] = element.first_name;
                rdv['l_name'] = element.last_name;
                rdv['date'] = element.date;
                rdv['time'] = element.time;
                selected.push(rdv);
             }
        });
        console.log('Panel.vue => selected :')
        console.log(selected);
        return selected;
    }

  },

  // lifecycle hooks:
  created(){

      this.currentDate();
      this.currentTime();
    
      setInterval(this.currentTime.bind(this), 1000);
      setInterval(this.currentDate.bind(this), 5000);

  }

}
</script>

<style scoped>

*{
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

.my-panel{ 
    background-color:cornflowerblue;
    flex-grow: 2;
    text-align: center;

    display: flex;
    flex-direction: column;
}


.date-time-panel{
    display: flex;
    flex-direction: column;
    /* align-content:center; */
    justify-content: space-between;
    /* width: 100%; */
}

.rdv-item{

    display: flex;
    flex-direction: column;
    justify-content:space-around;
}

li{

    display: flex;
    flex-direction: row; 
    justify-content:space-evenly;
    
    list-style-type: none;
    border-style:solid;
    border-width: 1px;
    border-color: lightgray;
    margin: 20px;
    padding: 10px;
}




.fa{
    display: none;
}


</style>