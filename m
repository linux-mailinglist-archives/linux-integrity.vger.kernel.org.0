Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DA23B1B00
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Jun 2021 15:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhFWNZD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Jun 2021 09:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhFWNZD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Jun 2021 09:25:03 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53487C061574;
        Wed, 23 Jun 2021 06:22:46 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id s17-20020a17090a8811b029016e89654f93so3864917pjn.1;
        Wed, 23 Jun 2021 06:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZGWXHa050qFm5BneP5isu99H0Fbf7qPA1kM+KMynMI=;
        b=mZjLUu3PuQC4n9NmhxTUPiA3gTQq6JtU1AS4Ou4KhW5j9Xe/7MAkSPNZnTsPRGgVRa
         GuCMbcb1GNOeUMIgzJE/GkISgb7yXMCXMDgJT0KsMIfTTxye6lLAaAB29T8jEAG2v0a0
         vrNxnTeA9Mbnwqg0QLnvk6XJcXUPWUA0YRGxAvV3E1oOIsY92F7dmobq764V5+pibvil
         Phcb4mHzOFmn/t4QOcHvVftIeCNYMXutsjOJ4eDN3Dgak6nhA0If8lT+0Lz2SB+HeZmY
         r3EMJgFDDlVYKUDyVbLuLlUw0GGRj4tpna7XwXkPC96+RaQlHeV/baaJWSskkkIRRvVO
         L9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZGWXHa050qFm5BneP5isu99H0Fbf7qPA1kM+KMynMI=;
        b=ly9YQA2nh61RyKx0ZCeVuTLxP78MuhZPsYZ9R1ygWRuA4nzTi+vQFtPszHlLJr35t6
         6FP7qnOv1D5UdUd6kDBgnrd8C4qn48TnTg6Dr/R2QybJsma2EwsCKJDVyjXxsmfEmRIk
         QD5x+ac7BmsirWQU/Bn0II9JoCeoIustRNFjGDePYvtOE6gbqwTWs7lqrwuYa9wk6OFs
         G+d4/TZTroZ83bSx1ck6SP7+pBOzwbceEV9wjcNxADN/zmh2g1Ao5jd1ifl5lZUKqTFh
         /nGlgbgh1pvx3dFRDWLM8T1fUWQham6EVMGvfXGnNeBa6og5UroWvgdI1PPopMnksJ/L
         pRDg==
X-Gm-Message-State: AOAM531vRT77SsCbl97sxEqJy9O89/YFoRK3xDsTowl1YdvsuCo02unX
        UwRnfquqmS2L8oHgVuCjCN0=
X-Google-Smtp-Source: ABdhPJyqhLHk6WkZZW5iYsMvFKbuhohwsm2xKIN4EuNPxMB3XqpROF77Yxr2r/RFAUhrIwM35JTfBA==
X-Received: by 2002:a17:902:70c4:b029:122:250e:366c with SMTP id l4-20020a17090270c4b0290122250e366cmr23194388plt.7.1624454565809;
        Wed, 23 Jun 2021 06:22:45 -0700 (PDT)
Received: from vessel.. ([103.242.196.10])
        by smtp.gmail.com with ESMTPSA id la18sm2767040pjb.55.2021.06.23.06.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 06:22:45 -0700 (PDT)
From:   Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     Saubhik Mukherjee <saubhik.mukherjee@gmail.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, andrianov@ispras.ru
Subject: [PATCH] char: tpm: vtpm_proxy: Fix race in init
Date:   Wed, 23 Jun 2021 18:52:26 +0530
Message-Id: <20210623132226.140341-1-saubhik.mukherjee@gmail.com>
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

