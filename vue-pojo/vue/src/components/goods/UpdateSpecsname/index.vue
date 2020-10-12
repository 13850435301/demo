<template>
<div class="div-a">
      <el-form class="small-space" :model="tempUser" label-position="left" label-width="80px"
               style='width: 300px; margin-left:50px;'>
        <el-form-item label="规格名称" required >
          <el-input type="text" v-model="tempUser.specsname">
          </el-input>
        </el-form-item>
  
        <el-form-item label="规格描述" >
          <el-input type="text" v-model="tempUser.specsdescription">
          </el-input>
        </el-form-item>

      <el-form-item label="是否标准" >       
             <el-radio-group v-model="tempUser.specsstandard">
            <el-radio :label="1">是</el-radio>
            <el-radio :label="0">否</el-radio>
      </el-radio-group>
        </el-form-item>

         <el-form-item label="单位" >
          <el-input type="text" v-model="tempUser.specsunit">
          </el-input>
        </el-form-item>

      </el-form>
      <div slot="footer" class="dialog-footer footer-button">
        <el-button @click="cancelUpdate">取 消</el-button>
        <el-button type="primary"  @click="updateSpecsName">修 改</el-button>
      </div>
   
  </div> 



 
</template>


<script>
 export default {
    data() {
      return { 
        tempUser: {
          specsNameId: 0,
          specsname: '',
          specsdescription: '',
          specsstandard: 0,
          specsunit: ''
        },
           listQuery: {   
          isLimit:0,
          specsnameid:this.$route.query.id-0
         
         
        },
      }
    },
  created() {
      this.showUpdate();
    },

   methods: {
    showUpdate() {
    this.api({
          url: "/goods/listSpecsName",
          method: "post",
          data: this.listQuery
        }).then(data => {
          this.listLoading = false;
          this.list = data.list;
          let specs = data.list[0];
        this.tempUser.specsname = specs.specs_name;
        this.tempUser.specsdescription = specs.specs_description;
        this.tempUser.specsstandard = specs.specs_standard;
        this.tempUser.specsunit = specs.specs_unit;
        this.tempUser.specsNameId = specs.specs_name_id;
        }) 
      },
       updateSpecsName() {
        //修改用户信息
        let _vue = this;
        this.api({
          url: "/goods/updateSpecsname",
          method: "post",
          data: this.tempUser
        }).then(data =>{
             if(data.state==0){
            this.$message.error(data.message)
            return
          }
          let msg = "修改成功";
          this.dialogFormVisible = false
       
          this.$message({
            message: msg,
            type: 'success',
            duration: 1 * 1000,
            onClose: () => {
            return _vue.$router.push({
            path:'/system/specsname'        
        })
            }
          })
        })
      },
       cancelUpdate() {
        return this.$router.push({
        path:'/system/specsname'        
        })  

       }
   }

 }
 
  
</script>

<style scoped> 
.div-a{ 
  float:left;
  width:35%;
  margin-top: 20px;
 
  } 

.footer-button{
margin-left: 151px;
}
</style>
