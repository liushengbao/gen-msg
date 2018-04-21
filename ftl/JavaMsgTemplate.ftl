package ${packageName};
<#assign import_util = 0>
<#list fields as field> 
<#if field.ft == "array">
<#if import_util == 0>
<#assign import_util = 1>
import java.util.*;
</#if>
</#if>
<#if field.ft == "map">
<#if import_util == 0>
<#assign import_util = 1>
import java.util.*;
</#if>
</#if>
</#list>
/**
 *  @author ${author}
 */
public class ${className} extends AbstractMsgPacket {
<#function toJavaType fv>
	<#if fv == "int8">
		<#return "Byte">
	<#elseif fv == "int16">
		<#return "Short">
	<#elseif fv == "int32">
		<#return "Integer">
	<#elseif fv == "int64">
		<#return "Long">
	<#elseif fv == "string">
		<#return "String">
	<#else>
		<#return fv>
	</#if>
</#function>
<#function toJavaBasic fv>
	<#if fv == "int8">
		<#return "byte">
	<#elseif fv == "int16">
		<#return "short">
	<#elseif fv == "int32">
		<#return "int">
	<#elseif fv == "int64">
		<#return "long">
	<#elseif fv == "string">
		<#return "String">
	<#else>
		<#return fv>
	</#if>
</#function>
<#function isNewObj fv>
	<#if fv == "int8">
		<#return "false">
	<#elseif fv == "int16">
		<#return "false">
	<#elseif fv == "int32">
		<#return "false">
	<#elseif fv == "int64">
		<#return "false">
	<#elseif fv == "string">
		<#return "false">
	<#else>
		<#return "true">
	</#if>
</#function>

<#list fields as field> 
  	<#if field.ft == "base">
  	<#if isNewObj(field.fv) == "true">
    private ${field.fv} ${field.fn} = new ${field.fv}();
  	<#else>
    private ${toJavaBasic(field.fv)} ${field.fn};
  	</#if>
  	</#if>
    <#if field.ft == "array">
    private List<${toJavaType(field.fv)}> ${field.fn} = new ArrayList<>();
    </#if>
    <#if field.ft == "map">
    private Map<${toJavaType(field.fk)},${toJavaType(field.fv)}> ${field.fn} = new HashMap<>();
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
        <#if field.ft == "base">
        <#if field.fv == "int8">
        msgPacket.writeInt8(this.${field.fn});
        <#elseif field.fv == "int16">
        msgPacket.writeInt16(this.${field.fn});
        <#elseif field.fv == "int32">
        msgPacket.writeInt32(this.${field.fn});
        <#elseif field.fv == "int64">
        msgPacket.writeInt64(this.${field.fn});
        <#elseif field.fv == "string">
        msgPacket.writeString(this.${field.fn});
        <#else>
        ${field.fn}.encode(msgPacket);
        </#if>
        </#if>
        <#if field.ft == "array">
        msgPacket.writeInt16((short) this.${field.fn}.size());
        ${field.fn}.forEach(v -> {
        <#if field.fv == "int8">
          msgPacket.writeInt8(v);
        <#elseif field.fv == "int16">
          msgPacket.writeInt16(v);
        <#elseif field.fv == "int32">
          msgPacket.writeInt32(v);
        <#elseif field.fv == "int64">
          msgPacket.writeInt64(v);
        <#elseif field.fv == "string">
          msgPacket.writeString(v);
        <#else>
          v.encode(msgPacket);
        </#if>
        });
        </#if>
        <#if field.ft == "map">
        msgPacket.writeInt16((short) this.${field.fn}.size());
        ${field.fn}.forEach((k,v) -> {
        <#if field.fk == "int8">
          msgPacket.writeInt8(k);
        <#elseif field.fk == "int16">
          msgPacket.writeInt16(k);
        <#elseif field.fk == "int32">
          msgPacket.writeInt32(k);
        <#elseif field.fk == "int64">
          msgPacket.writeInt64(k);
        <#elseif field.fk == "string">
          msgPacket.writeString(k);
        <#else>
          k.encode(msgPacket);
        </#if>
        <#if field.fv == "int8">
          msgPacket.writeInt8(v);
        <#elseif field.fv == "int16">
          msgPacket.writeInt16(v);
        <#elseif field.fv == "int32">
          msgPacket.writeInt32(v);
        <#elseif field.fv == "int64">
          msgPacket.writeInt64(v);
        <#elseif field.fv == "string">
          msgPacket.writeString(v);
        <#else>
          v.encode(msgPacket);
        </#if>          
        });
        </#if>
        </#list>
    }
    
    @Override
    public void decode(MsgByteArray msgPacket) { 
	    <#list fields as field> 
        <#if field.ft == "base">
        <#if field.fv == "int8">
        this.${field.fn}.readInt8(msgPacket);
        <#elseif field.fv == "int16">
        this.${field.fn}.readInt16(msgPacket);
        <#elseif field.fv == "int32">
        this.${field.fn}.readInt32(msgPacket);
        <#elseif field.fv == "int64">
        this.${field.fn}.readInt64(msgPacket);
        <#elseif field.fv == "string">
        this.${field.fn}.readString(msgPacket);
        <#else>
        ${field.fn}.decode(msgPacket);
        </#if>
        </#if>
        <#if field.ft == "array">
       	short ${field.fn}_size = msgPacket.readInt16();
        ${field.fn}.forEach(v -> {
        <#if field.fv == "int8">
          msgPacket.writeInt8(v);
        <#elseif field.fv == "int16">
          msgPacket.writeInt16(v);
        <#elseif field.fv == "int32">
          msgPacket.writeInt32(v);
        <#elseif field.fv == "int64">
          msgPacket.writeInt64(v);
        <#elseif field.fv == "string">
          msgPacket.writeString(v);
        <#else>
          v.encode(msgPacket);
        </#if>
        });
        </#if>
        <#if field.ft == "map">
        msgPacket.writeInt16((short) this.${field.fn}.size());
        ${field.fn}.forEach((k,v) -> {
        <#if field.fk == "int8">
          msgPacket.writeInt8(k);
        <#elseif field.fk == "int16">
          msgPacket.writeInt16(k);
        <#elseif field.fk == "int32">
          msgPacket.writeInt32(k);
        <#elseif field.fk == "int64">
          msgPacket.writeInt64(k);
        <#elseif field.fk == "string">
          msgPacket.writeString(k);
        <#else>
          k.encode(msgPacket);
        </#if>
        <#if field.fv == "int8">
          msgPacket.writeInt8(v);
        <#elseif field.fv == "int16">
          msgPacket.writeInt16(v);
        <#elseif field.fv == "int32">
          msgPacket.writeInt32(v);
        <#elseif field.fv == "int64">
          msgPacket.writeInt64(v);
        <#elseif field.fv == "string">
          msgPacket.writeString(v);
        <#else>
          v.encode(msgPacket);
        </#if>          
        });
        </#if>
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