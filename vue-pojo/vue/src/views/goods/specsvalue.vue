<template>
<div class="div-father">
<update-specsname></update-specsname>
<specs-value></specs-value>
</div>
 
</template>


<script>
import {mapGetters} from 'vuex'
import UpdateSpecsname from '@/components/goods/UpdateSpecsname'
import SpecsValue from '@/components/goods/SpecsValue'
 export default {
 components: {UpdateSpecsname,SpecsValue}
 }
</script>

<style scoped> 

.div-father{ 
width:100%;
} 

</style>
