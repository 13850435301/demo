<template>
    <div>
        <div class="image-wrapper">
            <div class="img-wrapper">
                <div class="item" v-for="(item, index) in imgList" :key="index">
                    <img :src="item" class="dis-image">
                    <span class="delete" @click="deleteImg(index)">X</span>
                </div>
                <div class="item upload-icon" @click="preSelect" v-if="imgList.length < fileCount">
                    <span class="heng"></span>
                    <span class="su"></span>
                </div>
            </div>
            <input type="file" class="inputer" ref="inputRef" @change="handleChange($event)" multiple="multiple" >
        </div>
    </div>
</template>

<script>

export default {
    name: 'imgUpload',
    props: {
        fileMaxSize: {
            //默认最大体积M
            type: Number,
            required: false,
            default: 10
        },
        fileCount: {
            //上传图片数量
            type: Number,
            required: false,
            default: 1
        },
        fileType: {
            type: String,
            required: false,
            default: 'image/png, image/jpeg, image/jpg'
        }
    },
    data () {
        return {
            imgList: []
            
        };
    },
 
    methods: {
        preSelect () {
            //点击上传图片之前
            this.$refs.inputRef.click();
        },

        handleChange (e) {
            /* eslint-disable */
            //点击上传图片事件
            console.log(e)
            let BreakException = {};
            var file = e.target.files;
            if ((file.length + this.imgList.length) > this.fileCount) {
                this.$message.error('最多上传' + this.fileCount + '张图片');
                return;
            }
            
          	for(var i=0;i<file.length;i++){
		      if (!file[i].type || this.fileType.indexOf(file[i].type) === -1) {
                        this.$message.error('图片类型错误');
                        return;
               } else if (file[i].size > this.fileMaxSize * 1024 * 1000) {
                        this.$message.error('图片太大请重新上传');
                        return;
            }

                let freader = new FormData();
                freader.append('file',file[i]);//传文件 
	            //上传到后台
			    this.api({
                url: "/fdfs/uploadFile",
                method: "post",
                data: freader
                }).then(data =>{
                this.imgList.push(data.fileUrl);
				this.$message({ message: "上传成功", type: "success" });
			    });	
	    }       
            this.$refs.inputRef.value="";
        },
        deleteImg (ind) {
            // 删除图片
            this.imgList.splice(ind,1);
        },
         sendMsg(){
             //func: 是父组件指定的传数据绑定的函数，this.msg:子组件给父组件传递的数据
             this.$emit('imglist',this.imgList)
         }    
    }
};
</script>

<style scoped>
.image-wrapper{
    padding:10px 10px;
}
.inputer{
    width:100px;
    height:100px;
    display:none;
}
.img-wrapper{
    display:flex;
    flex-direction: row;
    justify-content: left;
    flex-wrap: wrap;
    width: 100%;
}
.image-wrapper .upload-icon{
    margin-left:14px;
    margin-bottom:10px;
    /* overflow: hidden; */
    width:20%;
    height:70px;
    text-align: center;
    border:1px solid #dbdbdb;
}
.img-wrapper .item{
    position:relative;
    margin-left:14px;
    margin-bottom:10px;
    /* overflow: hidden; */
    width:20%;
    height:126px;
    text-align: center;
}
.img-wrapper .item .dis-image{
    width:100%;
    height:126px;
}
.image-wrapper .item .delete {
    display:inline-block;
    position:absolute;
    background-color: #dbdbdb;
    width: 20px;
    height: 20px;
    color: #fff;
    font-size: 0.8em;
    border-radius: 50%;
    top:-9px;
    right:-10px;
}

.img-wrapper .item .heng{
    position: absolute;
    display:inline-block;
    width:30px;
    height:3px;
    background:#dbdbdb;
    left: 50%;
    top: 50%;
    transform: translate(-50%,-50%);
} 
.img-wrapper .item .su{
    position: absolute;
    display:inline-block;
    width:3px;
    height:30px;
    background:#dbdbdb;
    left: 50%;
    top: 50%;
    transform: translate(-50%,-50%);
} 
</style>