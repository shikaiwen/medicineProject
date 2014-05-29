package com.drp.util;

import java.io.InputStream;
import java.text.MessageFormat;
import java.util.Iterator;
import java.util.List;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;
import org.jdom2.xpath.XPath;

public class XmlReader {

	
	
	public static void main(String[] args) {
		String s = "123";
		StringBuilder sb = new StringBuilder();
		sb.insert(0, "<script>");
		sb.append("</script>");
		System.out.println(sb.toString());
//		String function = getSubTextById("OrderAction_importOrder");;
//		MessageFormat form = new MessageFormat(function);
//		Object[] testObj = {"{'1':'1','2':'2'}"};
//		//String str = "{'1':'1','2':'2'}";
//		System.out.println(form.format(testObj));
	}
	
	
	public static String getSubTextById(String id){
		SAXBuilder  builder = new SAXBuilder ();
		Document doc = null;
		InputStream is = Thread.currentThread().getContextClassLoader().getResourceAsStream("callback_functions.xml");
	    try{
	    	 doc=builder.build(is);
	    	 
	    	 Element rootElt = doc.getRootElement();
	    	 List functionList = XPath.selectNodes(rootElt, "//root//functions//function");
	    	 for(Iterator iter = functionList.iterator();iter.hasNext();){
	    		 Element elt = (Element)iter.next();
	    		 String attrId = elt.getAttribute("id").getValue();
	    		 if(id.equals(attrId)){
	    			 return elt.getText();
	    		 }
	    	 }
	    }catch(Exception e){
	    	e.printStackTrace();
	    }
		
	   return null;
	    		
	}
}
