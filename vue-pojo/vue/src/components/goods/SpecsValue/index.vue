<template>
<div class="div-b">
 

  <el-form :inline="true" :model="listQuery" class="demo-form-inline">
  <el-form-item label="关键字" >
    <el-input v-model="listQuery.keyword" placeholder="请输入名称"></el-input>
  </el-form-item>

  <el-form-item>
    <el-button type="primary" @click="getList">查询</el-button>
    <el-button type="primary" icon="plus" v-if="hasPerm('specsvalue:add')" @click="showCreate">添加</el-button>
  </el-form-item>
</el-form>

    <el-table :data="list" v-loading.body="listLoading" element-loading-text="拼命加载中" border fit
              highlight-current-row>
    
        <el-table-column align="center" label="序号" width="80">
        <template slot-scope="scope">
          <span v-text="getIndex(scope.$index)"> </span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="规格值" prop="specs_value" style="width: 60px;"></el-table-column>
      <el-table-column align="center" label="创建时间" prop="add_time" width="170"></el-table-column>
      <el-table-column align="center" label="最近修改时间" prop="update_time" width="170"></el-table-column>
      <el-table-column align="center" label="管理" width="280" >
     <template slot-scope="scope">
        <el-button type="primary" icon="edit" v-if="hasPerm('specsvalue:update')" @click="showUpdate(scope.$index)">修改</el-button>          
        <el-button type="danger" icon="delete"  v-if="hasPerm('specsvalue:delete')"  @click="removeUser(scope.$index)">删除 </el-button>               
      </template>
      </el-table-column>
    </el-table>
    <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="listQuery.pageNum"
      :page-size="listQuery.pageRow"
      :total="totalCount"
      :page-sizes="[10, 20, 50, 100]"
      layout="total, sizes, prev, pager, next, jumper">
    </el-pagination>

   <el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible">
      <el-form class="small-space" :model="tempUser" label-position="left" label-width="80px"
               style='width: 300px; margin-left:50px;'>
        <el-form-item label="规格值" required >
          <el-input type="text" v-model="tempUser.specsvalue">
          </el-input>
        </el-form-item>
  
        <el-form-item label="扩展" >
          <el-input type="text" v-model="tempUser.specsextend">
          </el-input>
        </el-form-item>

      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button v-if="dialogStatus=='create'" type="success" @click="createSpecsvalue">创 建</el-button>
        <el-button type="primary" v-else @click="updateSpecsvalue">修 改</el-button>

      </div>
    </el-dialog>

   
  </div>
 
 
</template>


<script>
  import {mapGetters} from 'vuex'

  export default {
    data() {
      return {
        totalCount: 0, //分页组件--数据总条数
        list: [],//表格的数据
        listLoading: false,//数据加载等待动画
        listQuery: {
          pageNum: 1,//页码
          pageRow: 50,//每页条数
          isLimit:1,
          keyword:'',
          specsnameid:this.$route.query.id-0
        },
        dialogStatus: 'create',
        dialogFormVisible: false,
        textMap: {
          update: '编辑',
          create: '新建规格值'
        },
            

        tempUser: {
          specsvalueid:0,
          specsnameid:this.$route.query.id-0,
          specsvalue: '',
          specsextend: ''   
        }
      }
    },
    created() {
      this.getList();
    },
    computed: {
      ...mapGetters([
        'userId'
      ])
    },
    methods: {
      getList() {
        //查询列表
        this.listLoading = true;
        this.api({
          url: "/goods/listSpecsValue",
          method: "post",
          data: this.listQuery
        }).then(data => {
          this.listLoading = false;
          this.list = data.list;
          this.totalCount = data.list[0].count;
        })
      },
      handleSizeChange(val) {
        //改变每页数量
        this.listQuery.pageRow = val
        this.handleFilter();
      },
      handleCurrentChange(val) {
        //改变页码
        this.listQuery.pageNum = val
        this.getList();
      },
      handleFilter() {
        //查询事件
        this.listQuery.pageNum = 1
        this.getList()
      },
    


      showCreate() {
        //显示新增对话框
        this.tempUser.specsvalue = "";
        this.tempUser.specsextend = "";
        this.dialogStatus = "create"
        this.dialogFormVisible = true
      },


      showUpdate($index) {
        let specs = this.list[$index];
        this.tempUser.specsvalueid = specs.specs_value_id;
        this.tempUser.specsnameid = specs.specs_name_id;
        this.tempUser.specsvalue = specs.specs_value;
        this.tempUser.specsextend = specs.specs_extend;       
        this.tempUser.deleteStatus = '1';
        this.dialogStatus = "update"
        this.dialogFormVisible = true
      },
        getIndex($index) {
        //表格序号
        return (this.listQuery.pageNum - 1) * this.listQuery.pageRow + $index + 1
      },
      createSpecsvalue() {
        //添加规格值
        this.api({
          url: "/goods/addSpecsvalue",
          method: "post",
          data: this.tempUser
        }).then(data => {
          if(data.state==0){
            this.$message.error(data.message)
            return
          }
          this.getList();
          this.dialogFormVisible = false
        })
      },
       updateSpecsvalue() {
        //修改规格值
        let _vue = this;
        this.api({
          url: "/goods/updateSpecsvalue",
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
              _vue.getList();
            }
          })
        })
      },
      removeUser($index) {
        let _vue = this;
        this.$confirm('确定删除此规格值?', '提示', {
          confirmButtonText: '确定',
          showCancelButton: false,
          type: 'warning'
        }).then(() => {
          let specs = _vue.list[$index];
          specs.deleteStatus = '2';
        this.tempUser.specsvalueid = specs.specs_value_id;
          _vue.api({
            url: "/goods/deleteSpecsvalue",
            method: "post",
            data: this.tempUser
          }).then(() => {
            _vue.getList()
          }).catch(() => {
            _vue.$message.error("删除失败")
          })
        })
      },
  

    }
  }
</script>


<style scoped> 

.div-b{ 
float:left;
width:65%;
margin-top: 20px;
} 


</style>
