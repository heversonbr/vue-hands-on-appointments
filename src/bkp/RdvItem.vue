<template>
    <div class="rdv-item">
       
        <p><i class="fa fa-bell" aria-hidden="true"></i></p>
       
        <p>  {{rdvitem.first_name}} </p> 
        <p>  {{rdvitem.last_name }} </p> 
        <p>  {{rdvitem.date}} </p> 
        <p>  {{rdvitem.time}} </p> 
        <p><i v-on:click="deleteRdv(rdvitem.id)" class="fa fa-times" aria-hidden="true"></i></p>

    </div>
    
    
</template>

<script>
export default {
    name: 'RdvItem',

    props: {
        rdvitem : Object
    },

    methods:{

        deleteRdv(id){
            this.$emit('delete-rdv', id);
        }
    }


}

</script>

<style scoped>

.rdv-item{

    display: flex;
    flex-direction: row;
    justify-content:space-around;
}

.fa-times{
    color: red;
}

.fa-bell{
    color: blue;
}

/* .fa{
    color: black;
} */




</style>