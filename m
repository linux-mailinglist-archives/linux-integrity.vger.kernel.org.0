Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F221360C5BA
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Oct 2022 09:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiJYHpk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Oct 2022 03:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiJYHp2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Oct 2022 03:45:28 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D41BB7F7;
        Tue, 25 Oct 2022 00:45:28 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MxP6m5gW0zJnBK;
        Tue, 25 Oct 2022 15:42:40 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 15:45:25 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
        <akpm@linux-foundation.org>, <cuigaosheng1@huawei.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH] ima: fix a possible null pointer dereference
Date:   Tue, 25 Oct 2022 15:45:25 +0800
Message-ID: <20221025074525.2226586-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In restore_template_fmt(), template_desc->fmt will be NULL if kstrdup
fails, but the return value of restore_template_fmt() will not be null,
then in ima_restore_measurement_list(), template_desc->fmt will continue
to be used in below logic:
  |-- restore_template_fmt(...);	<-- template_desc->fmt = NULL
  |-- ret = template_desc_init_fields(template_desc->fmt,
				      &(template_desc->fields),
				      &(template_desc->num_fields));
    |-- template_num_fields = template_fmt_size(template_fmt);
      |--int template_fmt_len = strlen(template_fmt); <-- null-pre-def

So we need return NULL and free template_desc's memory if kstrdup fails
to fix it.

Fixes: c7d09367702e ("ima: support restoring multiple template formats")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 security/integrity/ima/ima_template.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index c25079faa208..dc6e8a5194da 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -331,23 +331,26 @@ static struct ima_template_desc *restore_template_fmt(char *template_name)
 	if (ret < 0) {
 		pr_err("attempting to initialize the template \"%s\" failed\n",
 			template_name);
-		goto out;
+		goto err;
 	}
 
 	template_desc = kzalloc(sizeof(*template_desc), GFP_KERNEL);
 	if (!template_desc)
-		goto out;
+		goto err;
 
 	template_desc->name = "";
 	template_desc->fmt = kstrdup(template_name, GFP_KERNEL);
 	if (!template_desc->fmt)
-		goto out;
+		goto err;
 
 	spin_lock(&template_list);
 	list_add_tail_rcu(&template_desc->list, &defined_templates);
 	spin_unlock(&template_list);
-out:
 	return template_desc;
+err:
+	if (template_desc != NULL)
+		kfree(template_desc);
+	return NULL;
 }
 
 static int ima_restore_template_data(struct ima_template_desc *template_desc,
-- 
2.25.1

