<template>
  <div class="app-container">
    <div class="filter-container">
      <el-form>
        <el-form-item>
          <el-button type="primary" icon="plus" v-if="hasPerm('specsname:add')" @click="showCreate">添加
          </el-button>
        </el-form-item>
      </el-form>
    </div>

  <el-form :inline="true" :model="listQuery" class="demo-form-inline">
  <el-form-item label="关键字" >
    <el-input v-model="listQuery.keyword" placeholder="请输入名称"></el-input>
  </el-form-item>

  <el-form-item>
    <el-button type="primary" @click="getList">查询</el-button>
  </el-form-item>
</el-form>

    <el-table :data="list" v-loading.body="listLoading" element-loading-text="拼命加载中" border fit
              highlight-current-row>
    
        <el-table-column align="center" label="序号" width="80">
        <template slot-scope="scope">
          <span v-text="getIndex(scope.$index)"> </span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="规格名称" prop="specs_name" style="width: 60px;"></el-table-column>
      <el-table-column align="center" label="规格描述" prop="specs_description" style="width: 60px;"></el-table-column>
      <el-table-column align="center" label="单位" prop="specs_unit" style="width: 60px;"></el-table-column>
      <el-table-column align="center" label="创建时间" prop="add_time" width="170"></el-table-column>
      <el-table-column align="center" label="最近修改时间" prop="update_time" width="170"></el-table-column>
      <el-table-column align="center" label="管理" width="220" >
     <template slot-scope="scope">
      <!-- <el-button type="primary" icon="edit" @click="showUpdate(scope.$index)">修改</el-button>  -->
    <el-button type="primary" v-if="hasPerm('specsname:update')" icon="edit" @click.native="updateSpecsvalue(scope.row.specs_name_id)">修改</el-button> 
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

     <el-form-item label="图标" prop="imgSrc" :label-width="formLabelWidth"> 
   <el-upload
    class="avatar-uploader"
	action="#" 
	v-model="tempUser.imgSrc"
	:show-file-list="false"
	:on-success="handleAvatarSuccess"
	:on-change="onchange"
	:before-upload="handleBeforeUpload"> 
	<i class="el-icon-plus"></i>
   </el-upload>
   <img v-if="imageUrl" :src="imageUrl" class="avatar">
   <i v-else class="el-icon-plus avatar-uploader-icon"></i>  
</el-form-item>

      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button v-if="dialogStatus=='create'" type="success" @click="createUser">创 建</el-button>
        <el-button type="primary" v-else @click="updateUser">修 改</el-button>
      </div>
    </el-dialog>

   
  </div>
</template>
<script>
  import {mapGetters} from 'vuex'

  export default {
    data() {
      return {
        dataFormRules: {
				 
				imgSrc: [{ 
					required: true, message: '请上传图片', trigger: 'blur' 
				}]
			},
        totalCount: 0, //分页组件--数据总条数
        list: [],//表格的数据
        listLoading: false,//数据加载等待动画
        listQuery: {
          pageNum: 1,//页码
          pageRow: 50,//每页条数
          isLimit:1,
          keyword:''
         
         
        },
        roles: [],//角色列表
        dialogStatus: 'create',
        dialogFormVisible: false,
        textMap: {
          update: '编辑',
          create: '新建规格名'
        },
            

        tempUser: {
          specsNameId: 0,
          specsname: '',
          specsdescription: '',
          specsstandard: 0,
          specsunit: '',
          imgSrc:''
        },
        //图片
			imageUrl: '' 
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
          url: "/goods/listSpecsName",
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
        this.tempUser.specsname = "";
        this.tempUser.specsdescription = "";
        this.tempUser.specsstandard = 0;
        this.tempUser.specsunit = "";
        this.tempUser.imgSrc = "";
        this.imageUrl="";
        this.dialogStatus = "create"
        this.dialogFormVisible = true
      },
      showUpdate($index) {
        let specs = this.list[$index];
        this.tempUser.specsname = specs.specs_name;
        this.tempUser.specsdescription = specs.specs_description;
        this.tempUser.specsstandard = specs.specs_standard;
        this.tempUser.specsunit = specs.specs_unit;
        this.tempUser.specsNameId = specs.specs_name_id;
        this.tempUser.deleteStatus = '1';
        this.dialogStatus = "update"
        this.dialogFormVisible = true
      },
        getIndex($index) {
        //表格序号
        return (this.listQuery.pageNum - 1) * this.listQuery.pageRow + $index + 1
      },
      createUser() {
        //添加新用户
        this.api({
          url: "/goods/addSpecsname",
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
      updateUser() {
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
              _vue.getList();
            }
          })
        })
      },
      removeUser($index) {
        let _vue = this;
        this.$confirm('确定删除此用户?', '提示', {
          confirmButtonText: '确定',
          showCancelButton: false,
          type: 'warning'
        }).then(() => {
          let user = _vue.list[$index];
          user.deleteStatus = '2';
          _vue.api({
            url: "/user/updateUser",
            method: "post",
            data: user
          }).then(() => {
            _vue.getList()
          }).catch(() => {
            _vue.$message.error("删除失败")
          })
        })
      },
      updateSpecsvalue(id){
        return this.$router.push({
          path:'/system/specsvalue',
          query:{
            id:id
          }
        })
      },
        handleAvatarSuccess(res, file) {
			this.imageUrl = URL.createObjectURL(file.raw); 
    },
    	// 上传文件之前的方法
		handleBeforeUpload(file){		
			if(!(file.type === 'image/png' || file.type === 'image/gif' || file.type === 'image/jpg' || file.type === 'image/jpeg')) {
				this.$message.error('上传图片格式为image/png, image/gif, image/jpg, image/jpeg的图片!');
				return isJPG
			}
			const isLt2M = file.size / 1024 / 1024 < 2;
			if (!isLt2M) {
				this.$message.error('上传图片大小不能超过 2MB!');
				return isLt2M
			} 
			let fd = new FormData();
			fd.append('file',file);//传文件 
			//上传到后台
			    this.api({
          url: "/fdfs/uploadFile",
          method: "post",
          data: fd
        }).then(data =>{
				this.tempUser.imgSrc = data.fileUrl; 
				this.$message({ message: "上传成功", type: "success" });
			});					
		},
		//当上传图片后，调用onchange方法，获取图片本地路径
		onchange(file,fileList){
			var _this = this;
			var event = event || window.event;
			if(event.target.files!=undefined){
				var file = event.target.files[0];
				var reader = new FileReader(); 
				//转base64
				reader.onload = function(e) {
				_this.imageUrl = e.target.result //将图片路径赋值给src
				}
				reader.readAsDataURL(file);
			}
		}, 

    }
  }
</script>
