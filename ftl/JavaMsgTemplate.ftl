package ${packageName};

import java.util.List;

/**
 *  @author ${author}
 */
public class ${className} extends AbstractMsgPacket {
  	
  <#list fields as field> 
    private ${field.ft} ${field.fn};
  </#list>
    
    public static ${className} Create() {
       return new ${className}();
    }
	
    @Override
    public int getMsgId() {
        return ${reqId?c};
    }
    
    @Override
    public void encode(MsgByteArray msgPacket) { 
        <#list fields as field> 
        msgPacket.write${field.ft}(this.${field.fn});
        </#list>
    }
    
    @Override
    public void decode(MsgByteArray msgPacket) { 
	    <#list fields as field> 
         this.${field.fn} = msgPacket.read${field.ft}();
        </#list>
    }
	
<#list fields as field> 
    public void set${field.fn?cap_first}(${field.ft} ${field.fn}){
        this.${field.fn} = ${field.fn};
    }
    
    public ${field.ft} get${field.fn?cap_first}(){
        return this.${field.fn};
    }
</#list>
	
}