import request from '@/utils/request'

const api_name = '/admin/sys/ware'

export default {

  getPageList(page, limit, searchObj) {
    return request({
      url: `${api_name}/${page}/${limit}`,
      method: 'get',
      params: searchObj
    })
  },

  getById(id) {
    return request({
      url: `${api_name}/get/${id}`,
      method: 'get'
    })
  },

  save(ware) {
    return request({
      url: `${api_name}/save`,
      method: 'post',
      data: ware
    })
  },

  updateById(ware) {
    return request({
      url: `${api_name}/update`,
      method: 'put',
      data: ware
    })
  },
  removeById(id) {
    return request({
      url: `${api_name}/remove/${id}`,
      method: 'delete'
    })
  },
  removeRows(idList) {
    return request({
      url: `${api_name}/batchRemove`,
      method: 'delete',
      data: idList
    })
  },

  findAllList() {
    return request({
      url: `${api_name}/findAllList`,
      method: 'get'
    })
  }
}
