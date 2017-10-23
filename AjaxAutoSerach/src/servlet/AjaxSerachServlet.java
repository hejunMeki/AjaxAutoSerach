package servlet;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2017/10/21 0021.
 * Description:...
 */
@WebServlet("/ajaxSerach")
public class AjaxSerachServlet extends HttpServlet {
    //模拟数据
    static List<String> datas=new ArrayList<String>();
    static{
        datas.add("ajax");
        datas.add("ajaxpost");
        datas.add("helloworld");
        datas.add("ajaxsend");
        datas.add("ajaxopen");
        datas.add("abcd");

    }
    //获取数据
    public List<String> getData(String keyword)
    {
        List<String> list=new ArrayList<String>();
        for(String data:datas)
        {
            if(data.contains(keyword)){
                list.add(data);
            }
        }
        return list;

    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //设置编码
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        //获得客户端发送来的数据
        String keyword=req.getParameter("keyword");
        System.out.println("参数是："+keyword);
        //获取关联的数据
        List<String> list=getData(keyword);
        System.out.println(list);
        //这句话没有输出内容
     //   System.out.println(JSONObject.fromObject(list).toString());
        //不成功？？？？为什么?
        //返回json格式 转换为字符串  写入响应流
        resp.getWriter().write(JSONArray.fromObject(list).toString());
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       doGet(req,resp);
    }
}
