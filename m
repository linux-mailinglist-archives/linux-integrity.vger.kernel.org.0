Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D35051C093
	for <lists+linux-integrity@lfdr.de>; Thu,  5 May 2022 15:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379312AbiEEN2n (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 May 2022 09:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377265AbiEEN2i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 May 2022 09:28:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCE95677D;
        Thu,  5 May 2022 06:24:56 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KvDtw5FdMzhYv6;
        Thu,  5 May 2022 21:24:24 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 21:24:55 +0800
Received: from ubuntu1804.huawei.com (10.67.174.152) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 21:24:54 +0800
From:   Wang Weiyang <wangweiyang2@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <wangweiyang2@huawei.com>
Subject: [PATCH 3/3] ima: Append line feed to ima/binary_runtime_measurements
Date:   Thu, 5 May 2022 21:23:01 +0800
Message-ID: <20220505132301.124832-4-wangweiyang2@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220505132301.124832-1-wangweiyang2@huawei.com>
References: <20220505132301.124832-1-wangweiyang2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.152]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There is no LF in binary_runtime_measurements output. It is little weird,
so append LF to it.

Example:

/ # cat /sys/kernel/security/ima/binary_runtime_measurements
...imaboot_aggregate/ #

Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>
---
 security/integrity/ima/ima_fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index cd1683dad3bf..0a2f9cb25b20 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -183,6 +183,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
 			show = IMA_SHOW_BINARY_OLD_STRING_FMT;
 		field->field_show(m, show, &e->template_data[i]);
 	}
+	seq_puts(m, "\n");
 	return 0;
 }
 
-- 
2.17.1

