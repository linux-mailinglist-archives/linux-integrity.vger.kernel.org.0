Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D15315AB1A
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2020 15:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgBLOlf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Feb 2020 09:41:35 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36105 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgBLOlf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Feb 2020 09:41:35 -0500
Received: by mail-lf1-f65.google.com with SMTP id f24so1795250lfh.3
        for <linux-integrity@vger.kernel.org>; Wed, 12 Feb 2020 06:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Xh49jfoB3Bge1tU8RlKZ+Inb7/ixfd/21e15JuBlmtk=;
        b=SnI15hSfsMwIFIY8C0YfyfYhaFqEpJNnMmdFgwsm/zWlJEsTFHNDH2UTIBXOBJihb/
         9mRNRDaqo7tRkzWovTjbQccF4Ehhjk9puIUgim2DdvzsKRrkmgwi409O50vKOaL4o96b
         LK2OYLffJaFlvI8xBvqt55rrW0sEemVD76MrmP91ubtOIYNPusNY/QQLqBsgTml3VJr0
         eCOAbWfiw+4YJnMNpjYey/WzvsEwPApgqBVb3QDiiAb0SfkFDp5jbxuXgLuqokGtihak
         dbtfYjqEebj9zVUt5SdMaKCUs07jfUktjvfuvenXiUEH3o+jiklqr+q46HXZ1DTCiqeh
         4Ivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Xh49jfoB3Bge1tU8RlKZ+Inb7/ixfd/21e15JuBlmtk=;
        b=hl2Ijl4XaOLRMRw+NNKZQglMknazU5dNZ/JouPQGUtetoOWarh/Gn7qkVhQ+7Bnz4w
         7GxEWLabthAp/fi1lixpysFUAtRVs5wSc9qqKdGelWPy1/oad404+2zhamzYVY17mGYU
         o6HWY3R2IBaEkV1tbCz4kWqwyuwYJzL4MqTqOp4HW0eJ0SssLln7v6n5B2+bP2HhBmke
         dnTEEc7uWMrKkTSpoje0eBLCJDGysKhZes9zNXoYTcNPLKhhHLBNket9HMa3sEepuUr1
         fjg6FLUjLX3HVeIY7KT6xdzX1a3bco5NTu9MPghThfRpyYl9Wq7yeuiyoSCcM4vAIffk
         7hZA==
X-Gm-Message-State: APjAAAV8pTNMiUMOWdcyQgzIArUVlnPIdR9Ei3PE9lqtcaQKbr5dAUO7
        tHCnGchPlRrt9eWAanEQ6Q0feiS2
X-Google-Smtp-Source: APXvYqxMCa8Ggbkpra/nkRHg1QlFKhH5jKdY5W87uiuSyoCPOnQRVM1XogwnvG/di/8+2XsUYyHXIQ==
X-Received: by 2002:a19:6449:: with SMTP id b9mr6874872lfj.5.1581518492844;
        Wed, 12 Feb 2020 06:41:32 -0800 (PST)
Received: from stp.localdomain ([109.204.238.30])
        by smtp.gmail.com with ESMTPSA id h10sm405285ljc.39.2020.02.12.06.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 06:41:32 -0800 (PST)
From:   Konsta Karsisto <konsta.karsisto@gmail.com>
To:     linux-integrity@vger.kernel.org
Cc:     Konsta Karsisto <konsta.karsisto@gmail.com>
Subject: [PATCH] ima: more careful error checking in restore_template_fmt()
Date:   Wed, 12 Feb 2020 16:41:05 +0200
Message-Id: <20200212144105.4572-1-konsta.karsisto@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fix a case where a failure in strdup() after a successful kzalloc()
could lead to a crash later on. Also, change the function signature
to allow returning an error code, which can be returned a the return
value of ima_restore_measurement_list().

Signed-off-by: Konsta Karsisto <konsta.karsisto@gmail.com>
---

Unfortunately, I'm not familiar with the ima kexec cofiguration,
and thus this has been compile tested only.

 security/integrity/ima/ima_template.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 6aa6408603e3..6b1964cbcbf5 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -270,7 +270,7 @@ int __init ima_init_template(void)
 	return result;
 }
 
-static struct ima_template_desc *restore_template_fmt(char *template_name)
+static int restore_template_fmt(char *template_name, struct ima_template_desc **returned_desc)
 {
 	struct ima_template_desc *template_desc = NULL;
 	int ret;
@@ -279,23 +279,27 @@ static struct ima_template_desc *restore_template_fmt(char *template_name)
 	if (ret < 0) {
 		pr_err("attempting to initialize the template \"%s\" failed\n",
 			template_name);
-		goto out;
+		return ret;
 	}
 
 	template_desc = kzalloc(sizeof(*template_desc), GFP_KERNEL);
 	if (!template_desc)
-		goto out;
+		return -ENOMEM;
 
 	template_desc->name = "";
 	template_desc->fmt = kstrdup(template_name, GFP_KERNEL);
-	if (!template_desc->fmt)
-		goto out;
+	if (!template_desc->fmt) {
+		kfree(template_desc);
+		return -ENOMEM;
+	}
 
 	spin_lock(&template_list);
 	list_add_tail_rcu(&template_desc->list, &defined_templates);
 	spin_unlock(&template_list);
-out:
-	return template_desc;
+
+	*returned_desc = template_desc;
+
+	return 0;
 }
 
 static int ima_restore_template_data(struct ima_template_desc *template_desc,
@@ -421,8 +425,8 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 
 		template_desc = lookup_template_desc(template_name);
 		if (!template_desc) {
-			template_desc = restore_template_fmt(template_name);
-			if (!template_desc)
+			ret = restore_template_fmt(template_name, &template_desc);
+			if (ret < 0)
 				break;
 		}
 
-- 
2.17.1

