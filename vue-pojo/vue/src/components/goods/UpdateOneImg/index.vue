<template>
  <div>
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
    </div>
</template>

<script>
  export default {
    data() {
      return {
         tempUser: {       
          categoryimg: ''
        },   
         //图片
		imageUrl: '' 
      }
    },
    methods: {
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

     sendMsg(){
             //func: 是父组件指定的传数据绑定的函数，this.msg:子组件给父组件传递的数据
             this.$emit('imageurl',this.tempUser.categoryimg)
         }   
    }
  }


</script>