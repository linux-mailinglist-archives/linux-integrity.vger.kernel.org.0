Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3FD655F42
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Dec 2022 03:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiLZCnu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 25 Dec 2022 21:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiLZCnt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 25 Dec 2022 21:43:49 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F0726CD
        for <linux-integrity@vger.kernel.org>; Sun, 25 Dec 2022 18:43:47 -0800 (PST)
Received: from lhrpeml500003.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NgMSK0DWzz6HHqk;
        Mon, 26 Dec 2022 10:39:29 +0800 (CST)
Received: from mscphispre00062.huawei.com (10.123.70.102) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 26 Dec 2022 02:43:44 +0000
From:   Denis Semakin <denis.semakin@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <stefanb@linux.ibm.com>, <denis.semakin@huawei-partners.com>
Subject: [RFC PATCH v2] ima: fix possible memory leak in cache allocating for namespace
Date:   Mon, 26 Dec 2022 10:43:35 +0800
Message-ID: <20221226024335.767587-1-denis.semakin@huawei.com>
X-Mailer: git-send-email 2.38.GIT
In-Reply-To: <20221224070545.349944-1-denis.semakin@huawei.com>
References: <20221224070545.349944-1-denis.semakin@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.70.102]
X-ClientProxiedBy: mscpeml100002.china.huawei.com (7.188.26.75) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There is a KMEM_CACHE(); macro which calls kmem_cache_create() function.
The default workflow is to call:
kmem_cache_create();
kmem_cache_alloc();
kmem_cache_free();
kmem_cache_destroy();

But here if register_blocking_lsm_notifier() return an error then
kmem_cache_destroy() will never calls which can lead a memory leak I suppose.

Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
Signed-off-by: Ilya Hanov <ilya.hanov@huawei-partners.com>
---
 security/integrity/ima/ima_init_ima_ns.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 1eaa6ceee2ee..5c850b740ae6 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -43,12 +43,16 @@ int ima_init_namespace(struct ima_namespace *ns)
 		ret = register_blocking_lsm_notifier
 						(&ns->ima_lsm_policy_notifier);
 		if (ret)
-			return ret;
+			goto destroy_cache;
 	}
 
 	set_bit(IMA_NS_ACTIVE, &ns->ima_ns_flags);
 
 	return 0;
+
+destroy_cache:
+	kmem_cache_destroy(ns->ns_status_cache);
+	return ret;
 }
 
 int __init ima_ns_init(void)
-- 
2.38.GIT

