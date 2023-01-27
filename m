Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6CC67DEFB
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Jan 2023 09:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjA0IUo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Jan 2023 03:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjA0IUo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Jan 2023 03:20:44 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA7377511
        for <linux-integrity@vger.kernel.org>; Fri, 27 Jan 2023 00:20:35 -0800 (PST)
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P39QK5GGWz6J7cb
        for <linux-integrity@vger.kernel.org>; Fri, 27 Jan 2023 16:16:25 +0800 (CST)
Received: from localhost.localdomain (10.123.66.33) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 27 Jan 2023 08:20:33 +0000
From:   Ilya Hanov <ilya.hanov@huawei-partners.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <yusongping@huawei.com>, <hukeping@huawei.com>,
        <denis.semakin@huawei-partners.com>, <artem.kuzin@huawei.com>,
        <konstantin.meskhidze@huawei.com>, <ilya.hanov@huawei-partners.com>
Subject: [RFC PATCH v1 1/3] ima: Add a UUID value for each vPCR
Date:   Fri, 27 Jan 2023 16:19:51 +0800
Message-ID: <20230127081953.7534-2-ilya.hanov@huawei-partners.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230127081953.7534-1-ilya.hanov@huawei-partners.com>
References: <20221031025507.298323-1-denis.semakin@huawei.com>
 <20230127081953.7534-1-ilya.hanov@huawei-partners.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.123.66.33]
X-ClientProxiedBy: mscpeml500001.china.huawei.com (7.188.26.142) To
 lhrpeml500001.china.huawei.com (7.191.163.213)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Signed-off-by: Ilya Hanov <ilya.hanov@huawei-partners.com>
---
 security/integrity/ima/ima.h             | 2 ++
 security/integrity/ima/ima_fs.c          | 1 +
 security/integrity/ima/ima_init_ima_ns.c | 1 +
 3 files changed, 4 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 91da4dd11390..a717be9685ed 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -14,6 +14,7 @@
 #define __LINUX_IMA_H
 
 #include <linux/types.h>
+#include <linux/uuid.h>
 #include <linux/crypto.h>
 #include <linux/fs.h>
 #include <linux/security.h>
@@ -176,6 +177,7 @@ struct ima_namespace {
 	 */
 	int ima_extra_slots;
 	struct vpcr_entry vpcr;
+	uuid_t uuid;
 } __randomize_layout;
 extern struct ima_namespace init_ima_ns;
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index d2dc7749949b..cf9164d31599 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -635,6 +635,7 @@ static int vpcr_show(struct seq_file *m, void *v)
 						     vpcr);
 
 	ima_putc(m, "cPCR: ", strlen("cPCR: "));
+	ima_putc(m, curr_ns->uuid.b, UUID_SIZE);
 	ima_putc(m, vpcr->vpcr_tmp, SHA256_DIGEST_SIZE);
 
 	memcpy(buf, &temp_vpcr_hash.digest, SHA256_DIGEST_SIZE);
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index f22062b70977..33e6a18dc560 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -71,6 +71,7 @@ int ima_init_namespace(struct ima_namespace *ns)
 		mutex_unlock(&vpcr_list_mutex);
 	}
 
+	generate_random_uuid(ns->uuid.b);
 	get_random_bytes(&ns->vpcr.secret, sizeof(ns->vpcr.secret));
 
 	set_bit(IMA_NS_ACTIVE, &ns->ima_ns_flags);
-- 
2.17.1

