<template>
    <div class="appointments-container">
        <div class="rdv-table-header"> 
            <span class="rdv-header-item">id</span>
            <span class="rdv-header-item">name</span>
            <span class="rdv-header-item">date</span>
            <span class="rdv-header-item">time</span>
            <span class="rdv-header-item">status</span>
        </div>
        <ul>
            <div v-for="rdv in appointments" v-bind:key="rdv.id" >
                <li> <RdvItem v-on:complete-rdv="completeRdv" v-on:delete-rdv="deleteRdv" v-on:call-rdv="callRdv" v-bind:rdvitem="rdv" v-bind:counters="counters" v-bind:currentDate="currentDate" /> </li>
            </div>
        </ul>
    </div>
    
</template>

 
<script>
import RdvItem from './RdvItem.vue'

export default {
    name: 'Appointments',

    data(){
        return{
            selected: null
        }
    },

    props: {
      appointments: Array,
      counters: Array,
      currentDate: String
    },

    components: {
        RdvItem
    },

    emits: ['delete-rdv', 'call-rdv', 'complete-rdv'],

    methods: {
        deleteRdv(rdvItem){
            this.$emit('delete-rdv', rdvItem );
        },

        completeRdv(rdvItem){
            this.$emit('complete-rdv', rdvItem );
        },

        callRdv(payload){
            console.log('Appointments.vue => callRdv');
            console.log(payload.rdv);
            console.log(payload.counter);
            console.log('this.$emit call-rdv');
            this.$emit('call-rdv', payload);
        }
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
.rdv-table-header{
    display: flex;
    flex-direction: row;
    justify-content:space-around;
}

.rdv-header-item{
    text-transform: capitalize;
    font-weight: bold;
}

li{
    list-style-type: none;
    border-style:solid;
    border-width: 1px;
    border-color: lightgray;
    margin: 5px;
}

</style>