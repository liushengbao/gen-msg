package ${packageName};

import org.common.socket.core.*;
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
 *  消息说明:${desc}
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
<#function toGetSetType ft fk fv>
 <#if ft == "base">
<#return toJavaType(fv)>
 </#if>
 <#if ft == "array">
 <#return "List<"+toJavaType(fv)+">">
 </#if>
 <#if ft == "map">
 <#return "Map<"+toJavaType(fk)+","+toJavaType(fk)+">">
 </#if>
<#return fv>
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
        this.${field.fn} = msgPacket.readInt8();
        <#elseif field.fv == "int16">
        this.${field.fn} = msgPacket.readInt16();
        <#elseif field.fv == "int32">
        this.${field.fn} = msgPacket.readInt32();
        <#elseif field.fv == "int64">
        this.${field.fn} = msgPacket.readInt64();
        <#elseif field.fv == "string">
        this.${field.fn} = msgPacket.readString();
        <#else>
        ${field.fn}.decode(msgPacket);
        </#if>
        </#if>
        <#if field.ft == "array">
       	short ${field.fn}_size = msgPacket.readInt16();
       	for (int i = 0; i < ${field.fn}_size; i++) {
		<#if field.fv == "int8">
        	${field.fn}.add(msgPacket.readInt8());
        <#elseif field.fv == "int16">
            ${field.fn}.add(msgPacket.readInt16());
        <#elseif field.fv == "int32">
            ${field.fn}.add(msgPacket.readInt32());
        <#elseif field.fv == "int64">
            ${field.fn}.add(msgPacket.readInt64());
        <#elseif field.fv == "string">
            ${field.fn}.add(msgPacket.readString());
        <#else>
            ${field.fv} item = new ${field.fv}();
            item.decode(msgPacket);
            ${field.fn}.add(item);
        </#if>
        }
		</#if>        
        <#if field.ft == "map">
        short ${field.fn}_size = msgPacket.readInt16();
        for (int i = 0; i < ${field.fn}_size; i++) {
        <#if field.fk == "int8">
            byte key = msgPacket.readInt8();
		<#elseif field.fk == "int16">
            short key = msgPacket.readInt16();
		<#elseif field.fk == "int32">
            int key = msgPacket.readInt32();
		<#elseif field.fk == "int64">
            long key = msgPacket.readInt64();
		<#elseif field.fk == "string">
            String key = msgPacket.readString();
		<#else>
            ${field.fk} key = new ${field.fk}();
            key.decode(msgPacket);
		</#if>
		<#if field.fv == "int8">
            byte value = msgPacket.readInt8();
		<#elseif field.fv == "int16">
            short value = msgPacket.readInt16();
		<#elseif field.fv == "int32">
            int value = msgPacket.readInt32();
		<#elseif field.fv == "int64">
            long value = msgPacket.readInt64();
		<#elseif field.fv == "string">
            String value = msgPacket.readString();
		<#else>
            ${field.fv} value = new ${field.fv}();
            value.decode(msgPacket);
		</#if>
            ${field.fn}.put(key,value);      
         }
        </#if>          
        </#list>
    }
	
<#list fields as field> 
    public void set${field.fn?cap_first}(${toGetSetType(field.ft, field.fk, field.fv)} ${field.fn}){
      this.${field.fn} = ${field.fn};
    }
        
    public ${toGetSetType(field.ft, field.fk, field.fv)} get${field.fn?cap_first}(){
      return this.${field.fn};
    }
    
</#list>
	
}
