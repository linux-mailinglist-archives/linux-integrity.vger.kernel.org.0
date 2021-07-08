Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A684F3BF7D1
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Jul 2021 11:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhGHJzu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Jul 2021 05:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbhGHJzu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Jul 2021 05:55:50 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A88C061574;
        Thu,  8 Jul 2021 02:53:07 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h1-20020a17090a3d01b0290172d33bb8bcso5537939pjc.0;
        Thu, 08 Jul 2021 02:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pP73IrCzP3i0QRD5vKKxBVf9fATf89KjmWVbRdJAXWg=;
        b=MVNw4G3ivXOPqXOy5yXFS1hqraU2wybFgf8NsCWlF1jvN5k3MKExXmiNVBrGibuE+l
         JJtRqjN1WppxCBZzgosB5xg8EK8HK29oFHBaMF5eCyajnr2I52w+53uSWra1t0+SQDfX
         Ch27a2NASYVBnV3j3EMfECZjYJvb7yXVlDccHAF0MBFhwqqGIpVeQTs1lPX6y5gizKmC
         pWyfDlIr0+OuCnGT8XJMHlaG4NPybN+Sy86p8VhzFkuS7aVQxzDhTcsrSqd6d4QeAk7I
         wE4vjQzdpEL8oOFk98tjwUE7RN2nBFVpJXRdhCnOJCdiWcq6fHZiDW8bM+phuSJ4MPFf
         3kTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pP73IrCzP3i0QRD5vKKxBVf9fATf89KjmWVbRdJAXWg=;
        b=AGDOSaNwAS4jcXq66ofpqZs53yFw82YpXvXNpNxF+eUOYaib+B8ujA+reB4U7xQZRb
         cMDYRWOgzmVLIyLEOlS6WhgV66Os2oTjxR1LCNeXobUteSZ8TVpKEqE8fxg2jtcUmgRj
         DQ+C2Mzqy8kcgQ6UXTuWsiCAPlVRJ+5lIpZ1JsOEiIo4ufYVqjffYByvInmbuYLQujgB
         gN8jOtd5fcIO+ji7c/Bh+KIobrQw1EaOH0sic1sFUnI0LMucnjfKrw4wZL5x+oKmNsbn
         4lckuSuPSwQeaeXj6Mld1UddjNhdLmE0v2j9PLdnFIftv1kJnbQVM70oXda3kgaJkN2l
         J3zQ==
X-Gm-Message-State: AOAM5328Lljq2QI857CZepCdrk+krF5Sa02+7agt9jvQcAEqQgkxGeM4
        NgtsRBpnINFSOwZl5j0QCeE=
X-Google-Smtp-Source: ABdhPJzCen8H13roJe+VcrT1fuciaZNNAHgz/HNODAXEjwP/LITAK+0KCs+JBq5A+7/Xi/ewjMF31w==
X-Received: by 2002:a17:903:186:b029:129:5733:85c8 with SMTP id z6-20020a1709030186b0290129573385c8mr25566147plg.39.1625737987436;
        Thu, 08 Jul 2021 02:53:07 -0700 (PDT)
Received: from vessel.. ([103.242.196.137])
        by smtp.gmail.com with ESMTPSA id b4sm1900896pji.52.2021.07.08.02.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 02:53:06 -0700 (PDT)
From:   Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     Saubhik Mukherjee <saubhik.mukherjee@gmail.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, andrianov@ispras.ru
Subject: [PATCH v2] char: tpm: vtpm_proxy: Fix race in init
Date:   Thu,  8 Jul 2021 15:22:59 +0530
Message-Id: <20210708095259.27915-1-saubhik.mukherjee@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Changes since v1 ([0]):
- Add Fixes tag to commit message, as requested by Jarkko in [1].

[0]: https://lkml.org/lkml/2021/6/23/572
[1]: https://lkml.org/lkml/2021/6/29/695

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

