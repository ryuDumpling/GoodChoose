package com.ryu.goodchoose.acl.util;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.ryu.goodchoose.acl.mapper.PermissionMapper;
import com.ryu.goodchoose.model.acl.Permission;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;

/**
 * @author ryuDumpling
 * @version 2023/10/3 17:29
 */
public class PermissionHelper {

    @Autowired
    private static PermissionMapper permissionMapper;
    public static List<Permission> buildPermission(List<Permission> allList){
        List<Permission> trees = new ArrayList<>();
        //遍历所有菜单，获得顶层菜单：pid=0
        for(Permission permission:allList){
            if(permission.getPid()==0){
                permission.setLevel(1);
                //调用方法(递归)，从第一层向下找，直到最底层
                trees.add(findChildren(permission,allList));
            }
        }
        return trees;
    }

    private static Permission findChildren(Permission permission, List<Permission> allList) {
        //初始化子菜单list
        permission.setChildren(new ArrayList<>());
        //由于所有菜单数据都在allList中，所以遍历allList判断id与pid的关系，添加层级
        for (Permission it:allList) {
            if(permission.getId() == it.getPid()){
                int level = permission.getLevel() + 1;
                it.setLevel(level);
                //封装下一层数据，如果为空则退出递归
                if(permission.getChildren()==null){
                    permission.setChildren(new ArrayList<>());
                }
                permission.getChildren().add(findChildren(it,allList));
            }
        }
        return permission;
    }
}
