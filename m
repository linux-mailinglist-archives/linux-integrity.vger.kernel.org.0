Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2ACC3B7DE7
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Jun 2021 09:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhF3HS6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Jun 2021 03:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbhF3HS5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jun 2021 03:18:57 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988C6C061766;
        Wed, 30 Jun 2021 00:16:28 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id e33so1371970pgm.3;
        Wed, 30 Jun 2021 00:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xonZNlE+l6sBtKA7UNKEQ0/jPH3nyQ4s6DxRX9fs0lI=;
        b=uW8c87PFM4174j/Wd1DNcpOQPC9Ka6CjksrqU4eo4XnXTmwYgc4rXGyYe0hMW2FSne
         Jv7bi9UkL/K6gkSxdmpUo6PY0l/YE4OBEsT6BvGofrY2fa8ghfE7B7HBfW8pg6D5q+kP
         s+KGRruGtH072QXvggVltyGxcIMpM7zGfFE4u1eUy09NoSkxdoEsELKwXC6dr2EiyJHv
         yYJYA9CcLF6e6GnVFPIE6vbbCFsvkc/mX7BH7f67pkKhH2pui8DGUGEJIwJmjg3GoIFe
         lrZF/WWWcMxowXNFdAbW8eVqipaeh2dVWa+9fauENG5Bu8L1OfmHqiHtDu65kgkHzspn
         T8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xonZNlE+l6sBtKA7UNKEQ0/jPH3nyQ4s6DxRX9fs0lI=;
        b=ksXuBPu8qwYTVsbFas2fXLctcBJ0rNxlhaKfv067A9QMUmLUZOUH3OZhyEqfgQ3Eti
         DsmXhznaIR9lHrREyOw9bXkY/gEZY6AcKWqLKeUyCKZhZXLIsXpCSpxzBn/XIho7RZY3
         AUbq0nXMZykEjwTpf1yb4Kvqy23FSuC1Q2HbG+VbEorX4ykWm3se0OcihQMO4mfeprOs
         U62srnoXQ6m4EwbqYsu5am/PfHA9XbVhl8ZGqIWzOI5ypoEfZdqgwCr8kVKv0enQ/s85
         Fn1IrdKCLLerQR61aszOEJ6Z52rfpBrZnnB55t1xLmwpQhPf+h6jeVT2v4+i9ZqZz9Eb
         +9Ug==
X-Gm-Message-State: AOAM5329NoV4GM2Qc4Rb2UB8vztM1520YKCvYjXc0C2PiU3ExQU38FlF
        JvrdkRZsLitKWXpF93BOrYc=
X-Google-Smtp-Source: ABdhPJyXt5mu22Dh0CprhoQwKxErQ9vG90XQm8t6hV/p9URQU/LnBmaG3a0CXaR4CG6+w9ShnVZwxA==
X-Received: by 2002:a63:d213:: with SMTP id a19mr32858796pgg.28.1625037388076;
        Wed, 30 Jun 2021 00:16:28 -0700 (PDT)
Received: from vessel.. ([103.242.196.99])
        by smtp.gmail.com with ESMTPSA id ay3sm12288517pjb.38.2021.06.30.00.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 00:16:26 -0700 (PDT)
From:   Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     Saubhik Mukherjee <saubhik.mukherjee@gmail.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, andrianov@ispras.ru
Subject: [PATCH] char: tpm: vtpm_proxy: Fix race in init
Date:   Wed, 30 Jun 2021 12:44:51 +0530
Message-Id: <20210630071451.15507-1-saubhik.mukherjee@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210629210524.hze6yb23pps3flnv@kernel.org>
References: <20210629210524.hze6yb23pps3flnv@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

vtpm_module_init calls vtpmx_init which calls misc_register. The file
operations callbacks are registered. So, vtpmx_fops_ioctl can execute in
parallel with rest of vtpm_module_init. vtpmx_fops_ioctl calls
vtpmx_ioc_new_dev, which calls vtpm_proxy_create_device, which calls
vtpm_proxy_work_start, which could read uninitialized workqueue.

To avoid this, create workqueue before vtpmx init.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 6f99612e2500 ("tpm: Proxy driver for supporting multiple emulated TPMs")
Signed-off-by: Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
---
 drivers/char/tpm/tpm_vtpm_proxy.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 91c772e38bb5..225dfa026a8f 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -697,23 +697,22 @@ static int __init vtpm_module_init(void)
 {
 	int rc;
 
-	rc = vtpmx_init();
-	if (rc) {
-		pr_err("couldn't create vtpmx device\n");
-		return rc;
-	}
-
 	workqueue = create_workqueue("tpm-vtpm");
 	if (!workqueue) {
 		pr_err("couldn't create workqueue\n");
-		rc = -ENOMEM;
-		goto err_vtpmx_cleanup;
+		return -ENOMEM;
+	}
+
+	rc = vtpmx_init();
+	if (rc) {
+		pr_err("couldn't create vtpmx device\n");
+		goto err_destroy_workqueue;
 	}
 
 	return 0;
 
-err_vtpmx_cleanup:
-	vtpmx_cleanup();
+err_destroy_workqueue:
+	destroy_workqueue(workqueue);
 
 	return rc;
 }
-- 
2.30.2

