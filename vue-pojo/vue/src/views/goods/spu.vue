<template>
  <div class="app-container">
    <div class="filter-container">
      <el-form>
        <el-form-item>
          <el-button type="primary" icon="plus" v-if="hasPerm('spu:add')" @click="showCreate">添加</el-button>
        </el-form-item>
      </el-form>
    </div>

    <el-form :inline="true" :model="listQuery" class="demo-form-inline">
      <el-form-item label="关键字">
        <el-input v-model="listQuery.keyword" placeholder="请输入搜索关键字"></el-input>
      </el-form-item>

      <el-form-item label="spu状态">
        <el-select v-model="listQuery.onlines" placeholder="请选择">
          <el-option
            v-for="item in options"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          ></el-option>
        </el-select>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" @click="getList">查询</el-button>
      </el-form-item>
    </el-form>

    <el-table
      :data="list"
      v-loading.body="listLoading"
      element-loading-text="拼命加载中"
      border
      fit
      highlight-current-row
    >
      <el-table-column align="center" label="序号" width="80">
        <template slot-scope="scope">
          <span v-text="getIndex(scope.$index)"></span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="分类名称" prop="categoryName" style="width: 60px;"></el-table-column>
      <el-table-column align="center" label="商品标题" prop="title" style="width: 60px;"></el-table-column>
      <el-table-column align="center" label="商品图片" style="width: 60px;">
        <template slot-scope="scope">
          <img :src="scope.row.img" alt />
        </template>
      </el-table-column>
      <el-table-column align="center" label="商品价格" prop="price" style="width: 60px;"></el-table-column>
      <el-table-column align="center" label="商品折扣价" prop="discount_price" style="width: 60px;"></el-table-column>
      <el-table-column align="center" label="商品状态" width="80">
        <template slot-scope="scope">
          <span>{{scope.row.online | isusableTypeFilter}}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="商品标签" prop="tags" style="width: 60px;"></el-table-column>
      <el-table-column align="center" label="商品规格" prop="specsname" style="width: 60px;"></el-table-column>
      <el-table-column align="center" label="创建时间" prop="add_time" width="170"></el-table-column>
      <el-table-column align="center" label="最近修改时间" prop="update_time" width="170"></el-table-column>
      <el-table-column align="center" label="管理" width="220">
        <template slot-scope="scope">
          <el-button type="primary" icon="edit" @click="showUpdate(scope.$index)">修改</el-button>
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
      layout="total, sizes, prev, pager, next, jumper"
    ></el-pagination>

    <el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible">
      <el-form
        class="small-space"
        ref="tempUser"
        :model="tempUser"
        label-position="left"
        label-width="90px"
        style="margin-left:50px;"
      >
        <el-form-item label="商品分类" required prop="discountprice">
          <el-cascader v-model="categoryValue" :options="categoryOptions" @change="handleChange"></el-cascader>
        </el-form-item>
        <el-form-item label="商品主题图">
          <update-one-img @imageurl="getForThemeImg" ref="myforthemeimgchild"></update-one-img>
        </el-form-item>
        <el-form-item label="商品轮播图">
          <update-multiple-img :fileCount="100" @imglist="getMsgFormSon" ref="mychild"></update-multiple-img>
        </el-form-item>

        <el-form-item label="商品规格">
          <el-select v-model="specsNameValue" multiple placeholder="请选择">
            <el-option
              v-for="item in specsNameOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            ></el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="商品详情">
          <!-- <div class="mavoneditor-div">         
          <mavon-editor v-model="tempUser.spudetails" ref=md @imgAdd="$imgAdd" @imgDel="$imgDel" />
          </div> -->
          <div class="goods-details">
          <upload-goods-details></upload-goods-details>
          </div>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button v-if="dialogStatus=='create'" type="success" @click="createSpu('tempUser')">创 建</el-button>
        <el-button type="primary" v-else @click="updateSpu('tempUser')">修 改</el-button>
      </div>
    </el-dialog>
  </div>
</template>
<script>
import { mapGetters } from "vuex";
import UpdateMultipleImg from "@/components/goods/UpdateMultipleImg";
import UpdateOneImg from "@/components/goods/UpdateOneImg";
import UploadGoodsDetails from "@/components/goods/UploadGoodsDetails";

const isusableOptions = [
  { type: 1, name: "上架" },
  { type: 0, name: "下架" },
];

export default {
  components: { UpdateMultipleImg, UpdateOneImg,UploadGoodsDetails},
  data() {
    return {
      totalCount: 0, //分页组件--数据总条数
      list: [], //表格的数据
      listLoading: false, //数据加载等待动画
      listQuery: {
        pageNum: 1, //页码
        pageRow: 50, //每页条数
        isLimit: 1,
        keyword: "",
        onlines: null,
      },
      dialogStatus: "create",
      dialogFormVisible: false,
      textMap: {
        update: "编辑",
        create: "新建spu",
      },
      tempUser: {
        spuid: null,
        categoryid: null,
        discountprice: null,
        forthemeimg: "",
        spuimg: "",
        spuonline: null,
        spuprice: null,
        rootcategoryid: null,
        sketchspecid: null,
        sketchspecname: "",
        spusubtitle: "",
        sputags: "",
        sputitle: "",
        bannerimgs: "",
        spudetails: "",
        specsjson: "",
      },
      options: [
        {
          value: 1,
          label: "上架",
        },
        {
          value: 0,
          label: "下架",
        },
        {
          value: null,
          label: "全部",
        },
      ],

      //图片
      imageUrl: "",
      categoryOptions: [],
      categoryValue: [],
      specsNameOptions: [],
      specsNameValue: [],
      img_file:[],
    };
  },
  created() {
    this.getList();
    if (this.hasPerm("spu:add") || this.hasPerm("spu:update")) {
      this.getAllCategory();
      this.getAllSpecsName();
    }
  },
  computed: {
    ...mapGetters(["userId"]),
  },
  methods: {
    getList() {
      //查询列表
      this.listLoading = true;
      this.api({
        url: "/goods/listSpu",
        method: "post",
        data: this.listQuery,
      }).then((data) => {
        this.listLoading = false;
        this.list = data.list;
        if (this.list.length > 0) {
          this.totalCount = data.list[0].count;
        }
      });
    },
    handleSizeChange(val) {
      //改变每页数量
      this.listQuery.pageRow = val;
      this.handleFilter();
    },
    handleCurrentChange(val) {
      //改变页码
      this.listQuery.pageNum = val;
      this.getList();
    },
    handleFilter() {
      //查询事件
      this.listQuery.pageNum = 1;
      this.getList();
    },

    showCreate() {
      //显示新增对话框
      this.dialogStatus = "create";
      this.dialogFormVisible = true;
    },
    showUpdate($index) {
      let specs = this.list[$index];
      this.dialogStatus = "update";
      this.dialogFormVisible = true;
    },
    getIndex($index) {
      //表格序号
      return (this.listQuery.pageNum - 1) * this.listQuery.pageRow + $index + 1;
    },
    createSpu(tempUser) {
      this.$refs.mychild.sendMsg();
      this.$refs.myforthemeimgchild.sendMsg();
      this.tempUser.specsjson = this.specsNameValue.join(",");
    },
    updateSpu(tempUser) {
      this.$refs.mychild.sendMsg();
    },
    removeSpu($index) {},

    getAllCategory() {
      this.api({
        url: "/goods/selectListCategory",
        method: "get",
      }).then((data) => {
        this.categoryOptions = data.list;
      });
    },

    handleChange(value) {
      if (value) {
        if (value.length == 2) {
          this.tempUser.categoryid = value[0];
          this.tempUser.rootcategoryid = value[1];
        }

        if (value.length == 1) {
          this.tempUser.categoryid = value[0];
        }
      }
      console.log(value);
    },
    getMsgFormSon(data) {
      this.tempUser.bannerimgs = data.join(",");
    },

    getForThemeImg(data) {
      this.tempUser.forthemeimg = data;
    },
    getAllSpecsName() {
      this.api({
        url: "/goods/selectListSpecsName",
        method: "get",
      }).then((data) => {
        this.specsNameOptions = data.list;
      });
    },

    // 绑定@imgAdd event
$imgAdd(pos, $file) {
    // 第一步.将图片上传到服务器.
    var formdata = new FormData();
    formdata.append('file', $file);
    this.img_file[pos] = $file;
			//上传到后台
			    this.api({
          url: "/fdfs/uploadFile",
          method: "post",
          data: formdata
        }).then(data =>{
          this.$refs.md.$img2Url(pos, data.fileUrl);
			});

},
$imgDel(pos) {
    delete this.img_file[pos];
}
  },
  filters: {
    isusableTypeFilter(type) {
      const obj = isusableOptions.find((obj) => obj.type == type);
      return obj ? obj.name : null;
    },
  },
};
</script>

<style scoped>
.mavoneditor-div{
  width: 770px;
  height: auto;
}

.goods-details{
  width: auto;
  height: auto;
}
</style>
