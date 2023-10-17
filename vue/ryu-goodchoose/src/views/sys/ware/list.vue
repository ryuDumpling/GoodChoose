<template>
  <div>

    <el-card class="operate-container" shadow="never">
      <div style="margin-top: 15px">
        <el-form :inline="true" size="small" label-width="140px">
          <el-form-item label="输入搜索：">
            <el-input style="width: 203px" v-model="tempSearchObj.name" placeholder="仓库名称"></el-input>
          </el-form-item>
          <el-button type="primary" icon="el-icon-search" @click="search()">查询</el-button>
          <el-button type="default" @click="resetSearch()">清空</el-button>
        </el-form>
      </div>
    </el-card>

    <!-- 工具条 -->
    <el-card class="operate-container" shadow="never">
      <i class="el-icon-tickets" style="margin-top: 5px"></i>
      <span style="margin-top: 5px">仓库列表</span>

      <el-button class="btn-add" size="mini" @click="showAddWares()">添加仓库</el-button>
      <el-button class="btn-add" size="mini" @click="removeWares()" :disabled="selectedWares.length === 0" style="margin: 0 10px;">批量删除</el-button>
    </el-card>

    <el-table
      border
      stripe
      v-loading="listLoading"
      :data="wares"
      @selection-change="handleSelectionChange">

      <el-table-column
        type="selection"
        width="75" />

      <el-table-column
        type="index"
        label="序号"
        width="100"
        align="center">
      </el-table-column>

      <el-table-column prop="name" label="名称"/>
      <el-table-column prop="province" label="省编码" />
      <el-table-column prop="city" label="市编码" />
      <el-table-column prop="district" label="区域编码" />
      <el-table-column prop="detailAddress" label="详细地址" />

      <el-table-column label="操作" align="center">
        <template slot-scope="scope">
          <HintButton size="mini" type="primary" icon="el-icon-edit" title="修改仓库"
            @click="showUpdateWares(scope.row)" />
          <HintButton size="mini" type="danger" icon="el-icon-delete" title="删除仓库"
            @click="removeWare(scope.row.id)"/>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页组件 -->
    <el-pagination
      :current-page="page"
      :total="total"
      :page-size="limit"
      :page-sizes="[5, 10, 20]"
      style="padding: 10px;"
      layout="prev, pager, next, jumper, ->, sizes, total"
      @current-change="getWares"
      @size-change="handleSizeChange"
    />

<!-- 修改仓库弹窗 -->
    <el-dialog :title="ware.id ? '修改仓库' : '添加仓库'" :visible.sync="dialogWareVisible">
      <el-form ref="wareForm" :model="ware" label-width="120px">
        <el-form-item label="仓库名称" prop="name">
          <el-input v-model="ware.name"/>
        </el-form-item>
        <el-form-item label="详细地址">
          <el-input v-model="ware.detailAddress"/>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="cancel()">取 消</el-button>
        <el-button :loading="loading" type="primary" @click="addOrUpdate()">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import wareApi from '@/api/sys/ware'
import cloneDeep from 'lodash/cloneDeep'
export default {

  name: 'WareList',

  data() {
    return {
      dialogWareVisible:false,//修改页面显示值
      listLoading: true, // 数据是否正在加载
      wares:[],//仓库表
      ware:{},//当前要操作的仓库
      total: 0, // 总记录数
      page: 1, // 当前页码
      limit: 5, // 每页记录数
      loading: false, // 是否正在提交请求中
      tempSearchObj: { // 收集搜索条件数据
        name: '',
      },
      searchObj: {// 查询表单对象
        name:'',//仓库名称
      }, 
      selectedWares:[]//所有选中的仓库
    }
  },

  mounted() {
    //this.getRoles()
    this.getWares()
  },

  methods: {
    /*
    取消仓库的保存或更新
    */
    cancel () {
      this.dialogWareVisible = false
      this.ware = {}
    },

    /*
    显示添加仓库的界面
    */
    showAddWares () {
      this.ware = {}
      this.dialogWareVisible = true
      this.$nextTick(() => this.$refs.wareForm.clearValidate())
    },
    /*
    保存或者更新仓库
    */
    addOrUpdate () {
      this.$refs.wareForm.validate(valid => {
        if (valid) {
          const {ware} = this
          this.loading = true
          wareApi[ware.id ? 'updateById' : 'save'](ware).then((result) => {
            this.loading = false
            this.$message.success('保存成功!')
            this.getWares(ware.id ? this.page : 1)
            this.ware = {}
            this.dialogWareVisible = false
          })
        }
      })
    },
    /*
    显示更新仓库的界面
    */
    showUpdateWares (ware) {
      this.ware = cloneDeep(ware)
      this.dialogWareVisible = true
    },
    /*
    每页数量发生改变的监听
    */
    handleSizeChange(pageSize) {
      this.limit = pageSize
      this.getWares()
    },

     /*
    异步获取仓库分页列表
    */
    getWares(page = 1) {
      this.page = page
      this.listLoading = true
      const {limit, searchObj} = this
      wareApi.getPageList(page, limit, searchObj).then(
        result => {
          const {records, total} = result.data
          this.wares = records.map(item => {
            item.edit = false // 用于标识是否显示编辑输入框的属性
            item.originName = item.name // 缓存角仓库名称, 用于取消
            return item
          })
          this.total = total
        }
      ).finally(() => {
        this.listLoading = false
      })
      this.selectedWares = []
    },

    /*
    根据搜索条件进行搜索
    */
    search () {
      this.searchObj = {...this.tempSearchObj}
      this.getWares()
    },

    /*
    重置查询表单搜索列表
    */
    resetSearch() {
      this.tempSearchObj = {
        name: ''
      }
      this.searchObj = {
        name: ''
      }
      this.getWares()
    },

    /*
    删除某个仓库
    */
    removeWare (id) {
      wareApi.removeById(id)
      this.$message.success('删除成功')
      this.getWares()
    },

    /*
    删除所有选中的仓库
    */
    removeWares () {
      this.$confirm('确定删除吗?').then(async () => {
        await wareApi.removeRows(this.selectedWares)
        this.$message.success('删除成功')
        this.getWares()
      }).catch(() => {
        this.$message.info('取消删除')
      })
    },

    /*
    当表格复选框选项发生变化的时候触发
    */
    handleSelectionChange(selection) {
      this.selectedWares = selection
    },

  }
}
</script>

<style scoped>
.edit-input {
  padding-right: 100px;
}
.cancel-btn {
  position: absolute;
  right: 15px;
  top: 10px;
}
</style>
