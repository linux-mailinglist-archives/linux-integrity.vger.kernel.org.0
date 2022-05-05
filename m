Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F7251C094
	for <lists+linux-integrity@lfdr.de>; Thu,  5 May 2022 15:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379306AbiEEN2m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 May 2022 09:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356785AbiEEN2i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 May 2022 09:28:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0635677B;
        Thu,  5 May 2022 06:24:56 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KvDtw45L9zhYv3;
        Thu,  5 May 2022 21:24:24 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 21:24:54 +0800
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
Subject: [PATCH 2/3] evm: Append line feed to /sys/kernel/security/evm
Date:   Thu, 5 May 2022 21:23:00 +0800
Message-ID: <20220505132301.124832-3-wangweiyang2@huawei.com>
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

There is no LF in /sys/kerne/security/evm output. It is little weird,
so append LF to it.

Example:

/ # cat /sys/kernel/security/evm
0/ #

Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>
---
 security/integrity/evm/evm_secfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index 8a9db7dfca7e..6a46b62aabd4 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -45,7 +45,7 @@ static ssize_t evm_read_key(struct file *filp, char __user *buf,
 	if (*ppos != 0)
 		return 0;
 
-	sprintf(temp, "%d", (evm_initialized & ~EVM_SETUP_COMPLETE));
+	sprintf(temp, "%d\n", (evm_initialized & ~EVM_SETUP_COMPLETE));
 	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
 
 	return rc;
-- 
2.17.1

