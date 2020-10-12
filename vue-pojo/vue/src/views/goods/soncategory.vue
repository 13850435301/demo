<template>
  <div class="app-container">
    <div class="filter-container">
      <el-form>
        <el-form-item>
          <el-button type="primary" icon="plus" v-if="hasPerm('category:add')" @click="showCreate">添加
          </el-button>
        </el-form-item>
      </el-form>
    </div>

  <el-form :inline="true" :model="listQuery" class="demo-form-inline">
  <el-form-item label="关键字" >
    <el-input v-model="listQuery.keyword" placeholder="请输入名称"></el-input>
  </el-form-item>

  <el-form-item label="分类状态" >
      <el-select v-model="listQuery.isusables" placeholder="请选择">
        <el-option
      v-for="item in options"
      :key="item.value"
      :label="item.label"
      :value="item.value">
      </el-option>
    </el-select>
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
      <el-table-column align="center" label="子分类名称" prop="category_name" style="width: 60px;"></el-table-column>
      <el-table-column align="center" label="子分类图标" style="width: 60px;">
      <template slot-scope="scope">
         <img :src="scope.row.category_img" alt="" />
      </template>

      </el-table-column>
      <el-table-column align="center" label="分类描述" prop="category_describe" style="width: 60px;"></el-table-column>
      <el-table-column align="center" label="状态" width="80">
        <template slot-scope="scope">
          <span>{{scope.row.isusable | isusableTypeFilter}}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="创建时间" prop="add_time" width="170"></el-table-column>
      <el-table-column align="center" label="最近修改时间" prop="update_time" width="170"></el-table-column>
      <el-table-column align="center" label="管理" width="220" >
      <template slot-scope="scope">
			  <el-button type="primary" icon="edit" @click="showUpdate(scope.$index)">修改</el-button>
        <el-button type="danger" icon="delete"   @click="removeCategory(scope.$index)">删除 </el-button>                        
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
    <el-form class="small-space" :rules="rules" ref="tempUser" :model="tempUser" label-position="left" label-width="80px"
               style='width: 300px; margin-left:50px;'>
        <el-form-item label="分类名称" required  prop="categoryname">
          <el-input type="text" v-model="tempUser.categoryname">
          </el-input>
        </el-form-item>

  <el-form-item label="图标" prop="categoryimg" label-width="80px"> 
  <el-upload
    class="avatar-uploader"
	  action="#" 
	  v-model="tempUser.categoryimg"
	  :show-file-list="false"
	  :on-success="handleAvatarSuccess"
	  :on-change="onchange"
	  :before-upload="handleBeforeUpload"> 
	    <i class="el-icon-plus"></i>
   </el-upload>
     <img v-if="imageUrl" :src="imageUrl" class="avatar">
     <i v-else class="el-icon-plus avatar-uploader-icon"></i>  
  </el-form-item>

    <el-form-item label="是否启用禁用" v-if="dialogStatus=='update'">
    <el-switch :active-value="1" :inactive-value="0" v-model="tempUser.isusables"></el-switch>
  </el-form-item>

  <el-form-item label="分类描述" >
    <el-input type="textarea" v-model="tempUser.categorydescribe"></el-input>
  </el-form-item> 
  </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button v-if="dialogStatus=='create'" type="success"  @click="createCategory('tempUser')">创 建</el-button>
        <el-button type="primary" v-else @click="updateCategory('tempUser')">修 改</el-button>
      </div>
    </el-dialog>

   
  </div>
</template>
<script>
  import {mapGetters} from 'vuex'

  const isusableOptions=[
    {type:1,name:'启用'},
    {type:0,name:'禁用'},
  ]

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
          parentid:this.$route.query.id-0         
        },
        dialogStatus: 'create',
        dialogFormVisible: false,
        textMap: {
          update: '编辑',
          create: '新建分类'
        },
            

        tempUser: {
          categoryid:null,
          categoryname: '',
          categoryimg: '',
          categorydescribe: '',
          isusables: 1,
          isparents: 0,
          parentid:this.$route.query.id-0
        },
        options: [{
          value: 1,
          label: '启用'
        }, {
          value: 0,
          label: '禁用'
        }, {
          value: null,
          label: '全部'
        }],
             rules: {
          categoryname: [
            { required: true, message: '请输入分类名称', trigger: 'blur' }
          ],
          categoryimg: [
            { required: true, message: '请上传分类图标', trigger: 'blur' }
          ],
          
        } ,
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
          url: "/goods/listCategory",
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
        this.tempUser.categoryname = "";
        this.tempUser.categoryimg = "";
        this.tempUser.categorydescribe = "";
        this.imageUrl = "";
        this.dialogStatus = "create"
        this.dialogFormVisible = true
      },
      showUpdate($index) {
        let specs = this.list[$index];
        this.tempUser.categoryid = specs.category_id;
        this.tempUser.categoryname = specs.category_name;
        this.imageUrl = specs.category_img;
        this.tempUser.categoryimg = specs.category_img;
        this.tempUser.categorydescribe = specs.category_describe;
        this.tempUser.isusables = specs.isusable;
        this.tempUser.deleteStatus = '1';
        this.dialogStatus = "update"
        this.dialogFormVisible = true
      },
        getIndex($index) {
        //表格序号
        return (this.listQuery.pageNum - 1) * this.listQuery.pageRow + $index + 1
      },
      createCategory(tempUser) {
          this.$refs[tempUser].validate((valid) => {
          if (valid) {
             //添加分类
        this.api({
          url: "/goods/addCategory",
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
          } else {
            console.log('error submit!!');
            return false;
          }
        });
      
      },
      updateCategory(tempUser) {
           this.$refs[tempUser].validate((valid) => {
          if (valid) {
        //修改分类信息
        let _vue = this;
        this.api({
          url: "/goods/updateCategory",
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
           } else {
            console.log('error submit!!');
            return false;
          }
        });
      },
      removeCategory($index) {
        let _vue = this;
        this.$confirm('确定删除此分类吗?', '提示', {
          confirmButtonText: '确定',
          showCancelButton: false,
          type: 'warning'
        }).then(() => {
          let category = _vue.list[$index];
          _vue.tempUser.categoryid = category.category_id;
          _vue.api({
            url: "/goods/deleteCategory",
            method: "post",
            data: _vue.tempUser
          }).then(() => {
            _vue.getList()
          }).catch(() => {
            _vue.$message.error("删除失败")
          })
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
				this.tempUser.categoryimg = data.fileUrl; 
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

    },
    filters:{
    isusableTypeFilter(type){
      const obj=isusableOptions.find(obj=>obj.type==type)
      return obj? obj.name:null
    }  
    },
  }
</script>
