import Vue from 'vue'
import Router from 'vue-router'
// in development env not use Lazy Loading,because Lazy Loading too many pages will cause webpack hot update too slow.so only in production use Lazy Loading
/* layout */
import Layout from '../views/layout/Layout'

const _import = require('./_import_' + process.env.NODE_ENV)
Vue.use(Router)
export const constantRouterMap = [
  {path: '/login', component: _import('login/index'), hidden: true},
  {path: '/404', component: _import('404'), hidden: true},
  {
    path: '/',
    component: Layout,
    redirect: '/dashboard',
    name: '首页',
    hidden: true,
    children: [{
      path: 'dashboard', component: _import('dashboard/index')
    }]
  }
]
export default new Router({
  // mode: 'history', //后端支持可开
  scrollBehavior: () => ({y: 0}),
  routes: constantRouterMap
})
export const asyncRouterMap = [
  {
    path: '/system',
    component: Layout,
    redirect: '/system/article',
    name: '功能模块',
    meta: {title: '功能模块', icon: 'tree'},
    children: [
      {
        path: 'article',
        name: '文章',
        component: _import('article/article'),
        meta: {title: '文章', icon: 'example'},
        menu: 'article'
      },
    ]
  },
  {
    path: '/user',
    component: Layout,
    redirect: '/user/',
    name: '',
    meta: {title: '用户权限', icon: 'table'},
    children: [
      {
        path: '', 
        name: '用户列表', 
        component: _import('user/user'), 
        meta: {title: '用户列表', icon: 'user'}, 
        menu: 'user'
      },
      {
        path: 'role',
        name: '权限管理',
        component: _import('user/role'),
        meta: {title: '权限管理', icon: 'password'},
        menu: 'role'
      },
    ]
  },
  {
    path: '/system',
    component: Layout,
    redirect: '/system/specs',
    name: '规格管理',
    meta: {title: '规格管理', icon: 'tree'},
    children: [
      {
        path: 'specsname',
        name: '规格列表',
        component: _import('goods/specsname'),
        meta: {title: '规格列表', icon: 'example'},
        menu: 'specsname'
      },
      {
        path: 'specsvalue',
        name: '规格值列表',
        component: _import('goods/specsvalue'),
        meta: {title: '规格值列表', icon: 'example'},
        menu: 'specsvalue',
        hidden: true      
      },
    
    ],
  },

  {
    path: '/system',
    component: Layout,
    redirect: '/system/category',
    name: '分类管理',
    meta: {title: '分类管理', icon: 'tree'},
    children: [
      {
        path: 'category',
        name: '分类列表',
        component: _import('goods/category'),
        meta: {title: '分类列表', icon: 'example'},
        menu: 'category'
      },

      {
        path: 'soncategory',
        name: '子分类列表',
        component: _import('goods/soncategory'),
        meta: {title: '子分类列表', icon: 'example'},
        menu: 'category',
        hidden: true 
      },
    
    ],
  },

  {
    path: '/system',
    component: Layout,
    redirect: '/system/goods',
    name: '商品管理',
    meta: {title: '商品管理', icon: 'tree'},
    children: [
      {
        path: 'spu',
        name: 'spu列表',
        component: _import('goods/spu'),
        meta: {title: 'spu列表', icon: 'example'},
        menu: 'spu'
      },
    
    ],
  },

  {path: '*', redirect: '/404', hidden: true}
]
