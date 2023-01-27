Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67CB67DEFD
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Jan 2023 09:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjA0IUp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Jan 2023 03:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjA0IUo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Jan 2023 03:20:44 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9C6757BE
        for <linux-integrity@vger.kernel.org>; Fri, 27 Jan 2023 00:20:37 -0800 (PST)
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P39QM15kQz6J7dJ
        for <linux-integrity@vger.kernel.org>; Fri, 27 Jan 2023 16:16:27 +0800 (CST)
Received: from localhost.localdomain (10.123.66.33) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 27 Jan 2023 08:20:34 +0000
From:   Ilya Hanov <ilya.hanov@huawei-partners.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <yusongping@huawei.com>, <hukeping@huawei.com>,
        <denis.semakin@huawei-partners.com>, <artem.kuzin@huawei.com>,
        <konstantin.meskhidze@huawei.com>, <ilya.hanov@huawei-partners.com>
Subject: [RFC PATCH v1 3/3] ima: Use TPM RNG for vPCR.secret if it's presented.
Date:   Fri, 27 Jan 2023 16:19:53 +0800
Message-ID: <20230127081953.7534-4-ilya.hanov@huawei-partners.com>
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
 security/integrity/ima/ima_init_ima_ns.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 33e6a18dc560..5ce3e42b6caa 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -6,7 +6,11 @@
  *   Stefan Berger <stefanb@linux.vnet.ibm.com>
  */
 
+#ifdef CONFIG_HW_RANDOM_TPM
+#include <linux/tpm.h>
+#else /* !CONFIG_HW_RANDOM_TPM */
 #include <linux/random.h>
+#endif /* CONFIG_HW_RANDOM_TPM */
 #include "ima.h"
 
 LIST_HEAD(vpcr_list);
@@ -72,7 +76,14 @@ int ima_init_namespace(struct ima_namespace *ns)
 	}
 
 	generate_random_uuid(ns->uuid.b);
+#ifdef CONFIG_HW_RANDOM_TPM
+	ret = tpm_get_random(ns->ima_tpm_chip, ns->vpcr.secret,
+			     sizeof(ns->vpcr.secret));
+	if (ret < 0)
+		goto err_destroy_cache;
+#else /* !CONFIG_HW_RANDOM_TPM */
 	get_random_bytes(&ns->vpcr.secret, sizeof(ns->vpcr.secret));
+#endif /* CONFIG_HW_RANDOM_TPM */
 
 	set_bit(IMA_NS_ACTIVE, &ns->ima_ns_flags);
 
-- 
2.17.1

