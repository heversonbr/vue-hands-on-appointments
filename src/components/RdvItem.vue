<template>
    <div class="rdv-item">
        <div class="item-info">
            <p>  {{rdvitem.id}} </p>
            <p>  {{rdvitem.first_name}} {{rdvitem.last_name }} </p> 
            <!-- <p>  {{rdvitem.last_name }} </p>  -->
            <p>  {{rdvitem.date}} </p> 
            <p>  {{rdvitem.time}} </p> 
            <p>  {{rdvitem.status}} </p>
        </div>

        <div class="item-control" >
            <p data-toggle="tooltip" data-placement="bottom" title="Select the counter/desk to call someone">
                <select v-model="selectedCounter" >
                <option  v-for="counter in counters" :value="counter.number" v-bind:key="counter.number">{{ counter.number }} </option> 
                </select>
            </p>
            <p data-toggle="tooltip" data-placement="bottom" title="Click to call someone">
                <!-- <i v-if="rdvitem.date == currentDate" class="fas fa-bell" v-on:click="callRdv({rdv: rdvitem, counter: selectedCounter})"  ></i>
                <i v-else class="fa fa-bell bell-disable"></i> -->
                <i v-if="rdvitem.date == currentDate && rdvitem.status == 'open'" v-bind:class="callRdvClassObject" v-on:click="callRdv({rdv: rdvitem, counter: selectedCounter})"  ></i>
                <i v-else class="fa fa-bell bell-disable"></i>

            </p>
            <p data-toggle="tooltip" data-placement="bottom" title="Click to finish/complete an appointment">
                <i v-if="rdvitem.date == currentDate && rdvitem.status == 'called'" v-bind:class="completeRdvClassObject" v-on:click="completeRdv(rdvitem)"  ></i>
                <i v-else class="fas fa-check-circle check-disable"></i>
            </p>
            <!-- <p><i v-on:click="deleteRdv(rdvitem)" class="fas fa-times-circle" aria-hidden="true"></i></p> -->
            <p data-toggle="tooltip" data-placement="bottom" title="Click to delete and appointment">
                <i v-if="rdvitem.status == 'completed'" class="fas fa-times-circle times-circle-disable" aria-hidden="true"></i>
                <i v-else v-on:click="deleteRdv(rdvitem)" class="fas fa-times-circle" aria-hidden="true"></i>
            </p>
        


        </div>
        
         
        

    </div>
    
    
</template>

<script>


export default {
    name: 'RdvItem',

    data(){
        return{
            selectedCounter: null,
        }
    },



    computed:{
        callRdvClassObject: function () {
            return {
              
              'fa': true,
              'fa-bell' : true,
              'bell-disable': this.rdvitem.status == 'called'
            }
        },

        completeRdvClassObject: function () {
            return {
              
              'fas': true,
              'fa-check-circle' : true,
              'check-disable': this.rdvitem.status == 'completed'

               
            }
        },
    },

    props: {
        rdvitem : Object,
        counters: Array,
        currentDate: String
    },

    emits: ['delete-rdv', 'call-rdv', 'complete-rdv'],

    methods:{

        deleteRdv(rdvitem){
            console.log('RdvItem.vue => deleteRdv');
            console.log('id : ' + rdvitem.id );
            this.$emit('delete-rdv', rdvitem);
        },

        callRdv(payload){
            console.log('RdvItem.vue => callRdv');
            if (payload.counter){
                console.log(payload.rdv);
                console.log(payload.counter);
                console.log('this.$emit call-rdv');
                this.$emit('call-rdv', payload);
            }else{
                alert('counter not selected');
            } 
        },
        
        completeRdv(rdvitem){
            console.log('RdvItem.vue => completeRdv');
            console.log('rdvItem : ' + rdvitem );
            console.log('id : ' + rdvitem.id );
            this.$emit('complete-rdv', rdvitem);

        }

        


    }


}

</script>

<style scoped>


.rdv-item{
    display: flex;
    flex-direction: column;
    align-content: flex-end;


    
}

.item-info{

    display: flex;
    flex-direction: row;
    justify-content:space-around;
    font-family: 'Nunito', sans-serif;
    /* margin-top: -10px; */


}

.item-control{
    display: flex;
    flex-direction: row;
    justify-content:space-around;
    margin-top: -15px;

}

.fa-times-circle{
    color: tomato;
}

.fa-check-circle{
    color: greenyellow; 
}

.fa-bell{
    color:royalblue ;
}

.bell-disable{
    color: grey;
}

.check-disable{
    color: grey;
}

.times-circle-disable{
    color: grey;
}

</style>