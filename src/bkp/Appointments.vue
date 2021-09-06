<template>
    <div class="appointments-container">
        <ul>
            <div v-for="rdv in appointments" v-bind:key="rdv.id" >
                <li> <RdvItem @delete-rdv="deleteRdv" v-bind:rdvitem="rdv" /> </li>
            </div>
        </ul>
    </div>
    
</template>

 
<script>
import RdvItem from './RdvItem.vue'

export default {
    name: 'Appointments',

    props: {
      appointments: Array
    },

    components: {
        RdvItem
    },

    methods: {

        deleteRdv(id){
            this.$emit('delete-rdv', id );
        }
    }

}

</script>

<style scoped>

*{
    box-sizing: border-box;
    margin: 0;
    padding: 0;

}

li{
    list-style-type: none;
    border-style:solid;
    border-width: 1px;
    border-color: lightgray;
    margin: 5px;
}

</style>