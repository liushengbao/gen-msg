package ${packageName};

import java.util.List;

/**
 *  @author ${author}
 */
public class ${className} extends AbstractMsgPacket {
<#list fields as field> 
  	<#if field.ft == "base">
  		<#if field.fv == "int8">
    private byte ${field.fn};
		<#elseif field.fv == "int16">
    private short ${field.fn};		
		<#elseif field.fv == "int32">
	private int ${field.fn};
		<#elseif field.fv == "long">
	private short ${field.fn};
		<#elseif field.fv == "string">
	private String ${field.fn};
		<#else>
	private ${field.fv} ${field.fn} = new ${field.fv}();
  		</#if>
    </#if>
    <#if field.ft == "array">
    private List<${field.fv}> ${field.fn} = new ArrayList<>();
    </#if>
    <#if field.ft == "map">
    private Map<${field.fk},${field.fv}> ${field.fn} = new HashMap<>();
    </#if>
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