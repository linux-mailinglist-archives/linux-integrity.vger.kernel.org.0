Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C567B7A836
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jul 2019 14:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbfG3MYm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Jul 2019 08:24:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45488 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbfG3MYm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jul 2019 08:24:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so29755707pfq.12
        for <linux-integrity@vger.kernel.org>; Tue, 30 Jul 2019 05:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F6RVSFR3EtlCJ6lvWs5T4vKHtTJAwPryiatLZ1M1aSY=;
        b=tfILgsUTF754qwTkDQPJD0rCNoaw5Uefc9p9gu+bUyOB285QrfyyfBMXVCuakpWXxU
         HICwYDIoYTjs/+ornlvVNUoij4mg9ij8bxODX+c7q02mHaK7IrzMH1R7ecmTkMo4+2xO
         Us9rLCt7owepUui89bfkEE/+tfrGjWsmuEK7kWBlWuXdpLhbvxXU6dLLp7egHq3QfEOx
         EAnFbfA73EDc7EvI/7xV2L+LruWbM8T/aZwxfA/Fok9dNyUsOb1nZjkFl2ZhnvrgF20f
         tcRKcSqCuXR5PmdwOUIpurnXSTsuhM16BUhSnW79IuqvzINcCDhZiAimeJCJ/3aEVT/+
         Skzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F6RVSFR3EtlCJ6lvWs5T4vKHtTJAwPryiatLZ1M1aSY=;
        b=jzg5+Z9hCBvk1B9XJkPH9TvxkebfgPJjx4gRmSl1H+wnKPMQVElATEtQI1k97b5h8n
         hmIS34ScqHDQEeuA0YxVcQlZIDYrZOT5If4H31Nnc3uEQkp/kKSnERZ8KtcjojUGGyZc
         NRD/0LQgby0PvbXzKFH5W2mYpMt9F4FV20NkUeVKIDAB66Boq4RQEIpDot768aRp1pAT
         naYO4eVn5/NhhNoYMuSd2lDfR34zZ79vr1XJMwGHzKLWYN1gv0Uw/rgUYwWwRvUWUC8H
         Kl3JY/3tvVgG16FaUEvqkEOuvaayfh/Ik1jghRVvEIB3VZIk+TMmYrqEAPtMu6NvSzkH
         A82A==
X-Gm-Message-State: APjAAAXsEgvKGZXYbKKeftGcF/BTWlbHWxF3QdPHS+KnWR6RhIxIzKEW
        3Suphgq/JRuJv9lwCaZ751RLOA==
X-Google-Smtp-Source: APXvYqxOXWjfS6W6Wq7C2Wm2EcZsROERy2icoey7lDKRVXENBtDjIep6/+XJLEKlNdfJ39CZmoJ1DQ==
X-Received: by 2002:a63:d04e:: with SMTP id s14mr103689463pgi.189.1564489481707;
        Tue, 30 Jul 2019 05:24:41 -0700 (PDT)
Received: from localhost.localdomain ([45.114.72.197])
        by smtp.gmail.com with ESMTPSA id v8sm54895462pgs.82.2019.07.30.05.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jul 2019 05:24:40 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     jens.wiklander@linaro.org, corbet@lwn.net, dhowells@redhat.com,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        casey@schaufler-ca.com, ard.biesheuvel@linaro.org,
        daniel.thompson@linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC v2 2/6] tee: enable support to register kernel memory
Date:   Tue, 30 Jul 2019 17:53:36 +0530
Message-Id: <1564489420-677-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Enable support to register kernel memory reference with TEE. This change
will allow TEE bus drivers to register memory references.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_shm.c   | 16 ++++++++++++++--
 include/linux/tee_drv.h |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 2da026f..5c69b89 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -9,6 +9,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
+#include <linux/uio.h>
 #include "tee_private.h"
 
 static void tee_shm_release(struct tee_shm *shm)
@@ -224,13 +225,14 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 {
 	struct tee_device *teedev = ctx->teedev;
 	const u32 req_flags = TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED;
+	const u32 req_ker_flags = TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED;
 	struct tee_shm *shm;
 	void *ret;
 	int rc;
 	int num_pages;
 	unsigned long start;
 
-	if (flags != req_flags)
+	if (flags != req_flags && flags != req_ker_flags)
 		return ERR_PTR(-ENOTSUPP);
 
 	if (!tee_device_get(teedev))
@@ -264,7 +266,17 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 		goto err;
 	}
 
-	rc = get_user_pages_fast(start, num_pages, FOLL_WRITE, shm->pages);
+	if (flags & TEE_SHM_USER_MAPPED) {
+		rc = get_user_pages_fast(start, num_pages, FOLL_WRITE,
+					 shm->pages);
+	} else {
+		const struct kvec kiov = {
+			.iov_base = (void *)start,
+			.iov_len = PAGE_SIZE
+		};
+
+		rc = get_kernel_pages(&kiov, num_pages, 0, shm->pages);
+	}
 	if (rc > 0)
 		shm->num_pages = rc;
 	if (rc != num_pages) {
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 7a03f68..dedf8fa 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -26,6 +26,7 @@
 #define TEE_SHM_REGISTER	BIT(3)  /* Memory registered in secure world */
 #define TEE_SHM_USER_MAPPED	BIT(4)  /* Memory mapped in user space */
 #define TEE_SHM_POOL		BIT(5)  /* Memory allocated from pool */
+#define TEE_SHM_KERNEL_MAPPED	BIT(6)  /* Memory mapped in kernel space */
 
 struct device;
 struct tee_device;
-- 
2.7.4

