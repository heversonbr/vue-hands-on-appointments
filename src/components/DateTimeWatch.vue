<template>
    <div class="date-time-watch">
        <div class="date-watch"> {{ currentDate }}  </div>
        <div class="time-watch"> {{ currentTime }} </div>
    </div>
</template>
<script>

export default {

    name: 'DateTimeWatch',

    data(){
        return{
            currentDate: String,
            currentTime: String
        }
    },

    emits: ['time-changed', 'date-changed'],

    watch:{

        currentTime(newValue){
            // console.log(' DataTimeWatch.vue : currentTime changed');
            this.$emit('time-changed', newValue);
            // console.log(' DataTimeWatch.vue : this.$emit() ');
        },

        currentDate(newValue){
            // console.log(' DataTimeWatch.vue : currentDate changed');
            this.$emit('date-changed', newValue);
          
        }

    },

    components: {
    
    },

    methods:{
        getDate() {
            let today = new Date();
            this.currentDate = `0${today.getDate()}`.slice(-2) + '-' + `0${today.getMonth()+1}`.slice(-2) + '-' + today.getFullYear()
        },
        getTime() {
            let now = new Date();
            //this.currentTime = `0${now.getHours()}`.slice(-2) + ':' + 0${now.getMinutes()}`.slice(-2) + ':' + `0${now.getUTCSeconds()}`.slice(-2);
            this.currentTime = now.getHours() + ':' + `0${now.getMinutes()}`.slice(-2) + ':' + now.getUTCSeconds(); 
        }
    },

    // lifecycle hooks:
    created(){

      this.getDate();
      this.getTime();
      setInterval(this.getDate.bind(this), 10000);
      setInterval(this.getTime.bind(this), 1000);
  }

}
</script>

<style scoped>

*{
    font-family: 'Nunito', sans-serif;
}

.date-time-watch{

    display: flex;
    flex-direction: row;
    justify-content: space-around;
    padding: 2px;
    margin: 10px;
    color: black; 

}

.date-watch{
    display: inherit;
}

.date-time{
    display: inherit;
}

</style>