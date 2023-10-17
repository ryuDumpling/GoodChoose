package com.ryu.goodchoose.home.service;

import java.util.Map;

public interface ItemService {
    Map<String, Object> item(Long id, Long userId);
}
