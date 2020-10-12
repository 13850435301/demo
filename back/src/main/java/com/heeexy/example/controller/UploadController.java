package com.heeexy.example.controller;

import com.alibaba.fastjson.JSONObject;
import com.heeexy.example.util.CommonUtil;
import com.heeexy.example.util.fastdfs.FastDFSClientUtil;
import org.apache.commons.io.IOUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/fdfs")
public class UploadController {

    @Autowired
    private FastDFSClientUtil dfsClient;


    @RequiresPermissions("file:upload")
    @RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
    public JSONObject fdfsUpload(@RequestParam("file") MultipartFile file) {
        Map map=new HashMap();
        try {
            String fileUrl = dfsClient.uploadFile(file);
            System.out.println("-----------------:"+fileUrl);
            map.put("fileUrl",fileUrl);
            map.put("state",1);
            map.put("message","上传成功");
        } catch (IOException e) {
            e.printStackTrace();
            map.put("fileUrl",null);
            map.put("state",0);
            map.put("message","上传失败");
        }
        return CommonUtil.successJson(map);
    }


    /*
     * http://localhost/download?filePath=group1/M00/00/00/wKgIZVzZEF2ATP08ABC9j8AnNSs744.jpg
     */
    @RequestMapping("/download")
    public void download(String filePath ,HttpServletRequest request ,HttpServletResponse response) throws IOException {

        //    group1/M00/00/00/wKgIZVzZEF2ATP08ABC9j8AnNSs744.jpg
        String[] paths = filePath.split("/");
        String groupName = null ;
        for (String item : paths) {
            if (item.indexOf("group") != -1) {
                groupName = item;
                break ;
            }
        }
        String path = filePath.substring(filePath.indexOf(groupName) + groupName.length() + 1, filePath.length());
        InputStream input = dfsClient.download(groupName, path);

        //根据文件名获取 MIME 类型
        String fileName = paths[paths.length-1] ;
        System.out.println("fileName :" + fileName); // wKgIZVzZEF2ATP08ABC9j8AnNSs744.jpg
        String contentType = request.getServletContext().getMimeType(fileName);
        String contentDisposition = "attachment;filename=" + fileName;

        // 设置头
        response.setHeader("Content-Type",contentType);
        response.setHeader("Content-Disposition",contentDisposition);

        // 获取绑定了客户端的流
        ServletOutputStream output = response.getOutputStream();

        // 把输入流中的数据写入到输出流中
        IOUtils.copy(input,output);
        input.close();

    }

    /**
     * http://localhost/deleteFile?filePath=group1/M00/00/00/wKgIZVzZaRiAZemtAARpYjHP9j4930.jpg
     * @param fileName  group1/M00/00/00/wKgIZVzZaRiAZemtAARpYjHP9j4930.jpg
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/deleteFile")
    public JSONObject delFile(String filePath , HttpServletRequest request ,HttpServletResponse response)  {
        Map map=new HashMap();

        try {
            dfsClient.delFile(filePath);
        } catch(Exception e) {
            // 文件不存在报异常 ： com.github.tobato.fastdfs.exception.FdfsServerException: 错误码：2，错误信息：找不到节点或文件
            // e.printStackTrace();
            map.put("state",0);
            map.put("message","找不到节点或文件");
            return CommonUtil.successJson(map);
        }
        map.put("state",1);
        map.put("message","成功删除");
        return CommonUtil.successJson(map);
    }


}
