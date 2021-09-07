<template>
    <div class="my-panel">

        <h2> {{ title }} </h2>
        <h4> Public Panel to drive users showing up for their appointements </h4>
        <div class="date-time-panel" >     
           <DateTimeWatch v-on:time-changed="setTime" v-on:date-changed="setDate"/>
        </div>
        
        <div class="current-rdvs" v-if="ongoingRdvs"> 
            <h3>Ongoing Appointments</h3>          
            <ul>
                <div v-for="counter in counters" v-bind:key="counter.number" >
                    <li v-if="counter.rdv" class="current-rdv-items">
                        <p> Table: {{counter.number}} </p> 
                        <p>  {{counter.rdv.first_name}} {{counter.rdv.last_name}} </p> 
                       
                    </li>
                </div>
            </ul>
        </div>

        <div class="todays-rdv" v-if="todaysAppointments.length" >
            <h3>Scheduled for today</h3>
            <ul>
                <div v-for="rdv in todaysAppointments" v-bind:key="rdv.id" >
                    <li class="todays-rdv-items">
                        <p v-bind:class="rdv.status=='completed' ? 'todays-rdv-items-done' : ''">  {{rdv.f_name}} {{rdv.l_name }}</p> 
                        <p v-bind:class="rdv.status=='completed' ? 'todays-rdv-items-done' : ''">  {{rdv.time}} </p>
                        <p v-bind:class="rdv.status=='completed' ? 'todays-rdv-items-done' : ''">  {{rdv.date}} </p> 
                        <p>  {{rdv.status}} </p>
                    </li>
                    <!-- <li  class="todays-rdv-items todays-rdv-items-done">
                        <p>  {{rdv.f_name}} {{rdv.l_name }}</p> 
                        <p>  {{rdv.time}} </p>
                        <p>  {{rdv.date}} </p> 
                    </li> -->
                </div>
            </ul>
        </div>
    </div>

</template>

<script>

import DateTimeWatch from './DateTimeWatch.vue';

export default {

    name: 'Panel',  
    props: {
        title: String,
        appointments : Array,
        counters : Array
    }, 

    data(){   
      return{
        currentDate : String,
        currentTime : String,
        tables: Array,
        standByRdv: Array,


      }
    },

    components: {
        DateTimeWatch
    }, 
    
    emits: ['time-changed','date-changed'],

    watch:{
        appointments(){
            console.log('Panel.vue => appointments() watch: changed ');    
        },
        currentTime(newValue){
            this.$emit('time-changed', newValue);
        },

        currentDate(newValue){
            this.$emit('date-changed', newValue);
        }
    },
    
    computed:{

        todaysRdvItemClassObject: function () {
            return {
              'todays-rdv-items': true,
              'todays-rdv-items-done': true
            }
        },

        todaysAppointments(){
            console.log('Panel.vue => computed todaysAppointments()');
            let selected = this.selectAppointments();
            console.log(selected);
            if(selected!=null){
                selected.sort(function(a,b){
                return a.time.localeCompare(b.time) ;
            });
            console.log(selected);
            }
            return selected; 
        },
        ongoingRdvs(){
            // checks the counters array and set the variable ongoing to true if there is any rdv on going.
            // this variable is checked by the Panel.vue component, in order to display the current rdvs.
            let ongoing = false;
            this.counters.forEach( (element) => {
                if(element.rdv != null){
                    ongoing = true;
                }
            });
            return ongoing;
        }
    },


    methods:{

    setTime(newValue){
        this.currentTime = newValue;
    },

    setDate(newValue){
        this.currentDate = newValue;
    },

    selectAppointments(){
        console.log('Panel.vue => selectAppointments()');
        let selected = [];
        if(this.appointments){
            this.appointments.forEach((element) => {
                if(element.date == this.currentDate){
                    let rdv = {};
                    rdv['id'] = element.id;
                    rdv['f_name'] = element.first_name;
                    rdv['l_name'] = element.last_name;
                    rdv['date'] = element.date;
                    rdv['time'] = element.time;
                    rdv['status'] = element.status;
                    selected.push(rdv);
                }
            });
        }
        return selected;
    }

  },

  // lifecycle hooks:
  mounted(){
    
  }

}
</script>



<style scoped>

*{
    box-sizing: border-box;
    margin: 0;
    padding: 0;
    font-family: 'Nunito', sans-serif;

}

.my-panel{ 
    background-color:floralwhite;
    flex-grow: 3;
    text-align: center;
   
    display: flex;
    flex-direction: column;
    padding: 10px;
}

.date-time-panel{
    margin-top: 10px;
}


.todays-rdv{
    display: block;
    margin-top: 20px;
}

.todays-rdv-items{
    display: flex;
    flex-direction: row; 
    justify-content:space-between;
    align-items: center;
    
    list-style-type: none;
    border-style: solid;
    border-width: 1px;
    border-color: lightpink;
    margin: 5px;
    padding: 10px;
}

.todays-rdv-items-done{
    text-decoration-line: line-through;
    text-decoration-style:solid;
    text-decoration-thickness: 2px;
    text-decoration-color: red;
}

.current-rdvs{
    display: block;
    margin-top: 20px;
    
    
}

.current-rdv-items{

    display: flex;
    flex-direction: row; 
    justify-content:space-between;
    
    list-style-type: none;
    border-style:solid;
    border-width: 2px;
    border-color:tomato;
    margin: 5px;
    padding: 10px;
    
}




.fa{
    display: none;
}

h4{
    color: tomato;
    margin-top: 10px;
}


</style>