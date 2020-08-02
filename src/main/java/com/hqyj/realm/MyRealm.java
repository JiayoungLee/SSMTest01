package com.hqyj.realm;

import com.hqyj.dao.PermissionMapper;
import com.hqyj.dao.PersonMapper;
import com.hqyj.pojo.Permission;
import com.hqyj.pojo.Person;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * author  Jayoung
 * createDate  2020/7/28 0028 11:28
 * version 1.0
 */
public class MyRealm extends AuthorizingRealm {
    @Autowired
    private PersonMapper personMapper;

    @Autowired
    private PermissionMapper permissionMapper;

    //用户授权
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
//        System.out.println("授权我进来了");
        //1、获得用户信息 即用户名
        String principal = (String) principalCollection.getPrimaryPrincipal();
        //2、给用户分配角色
        Set<String> roles = new HashSet<>();

        List<Permission> permissionList = permissionMapper.selectPermissionByPermissionName(principal);
        for (Permission p : permissionList) {
            roles.add(p.getPermissionName());
        }
        //3、返回SimpleAuthorizationInfo(roles)，把roles添加进去
        return new SimpleAuthorizationInfo(roles);
    }

    //用户认证
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        //将 authenticationToken 强转为 UsernamePasswordToken 类型（通过这个类型可以拿到身份）
        UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
        System.out.println("-------token.getUsername()--------" + token.getUsername());
        Person person = personMapper.selectByPersonName(token.getUsername());
        if (person != null) {
            //2.设置shiro比对器身份
            Object principal = person.getPersonName();
            //3.设置比对器里面的密码(把数据库里面的密码作为比对密码)
            Object credentials = person.getPersonPassword();
            //4.自动给令牌类里面的用户名设置加盐方式
            ByteSource salt = ByteSource.Util.bytes(person.getPersonName());
            //5.设置realm的名称
            String realmName = this.getName();

            /*  new SimpleAuthenticationInfo(principal,credentials,salt,realmName);
             *   讲上面的principle和token里面的用户名 对比
             *   将上面的credentials和token里面的密码 对比
             *   因为spring-shiro.xml里面配置了加密方式，所以会自动把token里面的密码以MD5加密，加密1024次
             *   因为上面除了个salt，表示再把token里面的密码再以salt加盐
             * */
            return new SimpleAuthenticationInfo(principal, credentials, salt, realmName);
        } else {
            throw new AuthenticationException();
        }
    }

    //测试加密
    public static void main(String[] args) {
        //设置加密方式
        String algorithmName = "MD5";
        //设置待加密的原密码
        Object source = "123";
        //设置加盐方式（一般来说都是以用户名来加盐的）
        Object salt = ByteSource.Util.bytes("admin");
        //加密次数
        int hashIterations = 1024;
        SimpleHash newPassword = new SimpleHash(algorithmName, source, salt, hashIterations);
        System.out.println(newPassword);
    }
}
