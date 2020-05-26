Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B636A1E2DA3
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2020 21:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392172AbgEZTWt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 May 2020 15:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391720AbgEZTUi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 May 2020 15:20:38 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81726C03E96D
        for <linux-integrity@vger.kernel.org>; Tue, 26 May 2020 12:20:37 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q2so25911984ljm.10
        for <linux-integrity@vger.kernel.org>; Tue, 26 May 2020 12:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rtUuMXm/ONBedoZkJ6q0q4M3oKLg8gzt0JX6LQl6GCI=;
        b=WV+lRIPXhdAbr73BfOLpJHnqUyi9RLV2d6P/lSnjwQKsdG1PTeSIOYFAaisB+paIYp
         invHeMGCYHCqIV5cdTQTdIJvddRoxdNwO4T1f9khkjDHNViXuJafdBwBQsCjpzehqqtb
         A7YAVyoYLshTFTq8yJSMOPRdYs1AOvARxlUdyA6ddbaPT6LSYODBpviVqngC2v3ugJUr
         OMmhYqdqwjVg6jjicyPr0/52DWvIE8Viex8VFINN4J+JTqiH715WpzAzUe/qHMdg0q0W
         WeeqesnLx9n7ayo0WrOgHC0qw/7s+XJuB6x5wqx/FupXeZ6uT0bPcbvwC5Y8gYSgbeVR
         zVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rtUuMXm/ONBedoZkJ6q0q4M3oKLg8gzt0JX6LQl6GCI=;
        b=fsl85zUhLDuFiYAkBzvQD+80nbPovplVvEDhsgV5PZXEvbJ8ffdPbIulOKRRjMqD66
         IRKdWRsYXDCsWWUO8GE+K5DFTr99+Z7wdeybD1rVCtiWnSEx4KjTStwXudJXZoyiRcsh
         wY7wAIOM/+fr8+EjiW2XqQVkIgIoh9jwuXkIbxy7i3bN1xQP6SdKCYv66DZq4SnmTq3S
         G9i2ldKLY9MNzSEC9NY2jQDdF/dhHPmPLDK7SazioZv97UBQSZEyN4fHLnaSUDLeC547
         LAEfhDDjK54tBPbaIhQuN/S7+EoZQybJRDOXInerW30efnzLjARCvo6HyqIu0UY81sDm
         4F9Q==
X-Gm-Message-State: AOAM532v7CFLKt+6gbVHlBbaECCkKEWS6aQBPO0jHdMHSHb5VGeDWSR6
        2J/H2ZYNB5d/aVikp3H5cE0gpA==
X-Google-Smtp-Source: ABdhPJzdMwx9DomXW8KBpva2ZJfw1GOcGTyCYZ4yl/aqBpFaVYS/WVNE93qE/gu/n5fo/yWv+MTcUA==
X-Received: by 2002:a2e:958d:: with SMTP id w13mr1355785ljh.207.1590520835908;
        Tue, 26 May 2020 12:20:35 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id i8sm180483lfo.62.2020.05.26.12.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 12:20:35 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv4 1/3] optee: do drivers initialization before and after tee-supplicant run
Date:   Tue, 26 May 2020 22:20:27 +0300
Message-Id: <20200526192029.863-2-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526192029.863-1-maxim.uvarov@linaro.org>
References: <20200526192029.863-1-maxim.uvarov@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Some drivers (like ftpm) can operate only after tee-supplicant
runs becase of tee-supplicant provides things like storage
services.  This patch splits probe of non tee-supplicant dependable
drivers to early stage, and after tee-supplicant run probe other
drivers.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Suggested-by: Sumit Garg <sumit.garg@linaro.org>
Suggested-by: Arnd Bergmann <arnd@linaro.org>
---
 drivers/tee/optee/core.c          | 28 +++++++++++++++++++++++++---
 drivers/tee/optee/device.c        | 17 +++++++++++------
 drivers/tee/optee/optee_private.h | 10 +++++++++-
 3 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 99698b8a3a74..d059e3ac491c 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -17,6 +17,7 @@
 #include <linux/tee_drv.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+#include <linux/workqueue.h>
 #include "optee_private.h"
 #include "optee_smc.h"
 #include "shm_pool.h"
@@ -218,6 +219,15 @@ static void optee_get_version(struct tee_device *teedev,
 	*vers = v;
 }
 
+static void optee_bus_scan(struct work_struct *work)
+{
+	int rc;
+
+	rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP);
+	if (rc)
+		pr_err("optee_enumerate_devices failed %d\n", rc);
+}
+
 static int optee_open(struct tee_context *ctx)
 {
 	struct optee_context_data *ctxdata;
@@ -241,8 +251,18 @@ static int optee_open(struct tee_context *ctx)
 			kfree(ctxdata);
 			return -EBUSY;
 		}
-	}
 
+		if (!optee->scan_bus_done) {
+			INIT_WORK(&optee->scan_bus_work, optee_bus_scan);
+			optee->scan_bus_wq = create_workqueue("optee_bus_scan");
+			if (!optee->scan_bus_wq) {
+				pr_err("optee: couldn't create workqueue\n");
+				return -ECHILD;
+			}
+			queue_work(optee->scan_bus_wq, &optee->scan_bus_work);
+			optee->scan_bus_done = true;
+		}
+	}
 	mutex_init(&ctxdata->mutex);
 	INIT_LIST_HEAD(&ctxdata->sess_list);
 
@@ -296,8 +316,10 @@ static void optee_release(struct tee_context *ctx)
 
 	ctx->data = NULL;
 
-	if (teedev == optee->supp_teedev)
+	if (teedev == optee->supp_teedev) {
+		destroy_workqueue(optee->scan_bus_wq);
 		optee_supp_release(&optee->supp);
+	}
 }
 
 static const struct tee_driver_ops optee_ops = {
@@ -675,7 +697,7 @@ static int optee_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, optee);
 
-	rc = optee_enumerate_devices();
+	rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES);
 	if (rc) {
 		optee_remove(pdev);
 		return rc;
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index e3a148521ec1..d4931dad07aa 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -21,7 +21,6 @@
  * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
  * TEE_ERROR_SHORT_BUFFER - Output buffer size less than required
  */
-#define PTA_CMD_GET_DEVICES		0x0
 
 static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
 {
@@ -32,7 +31,8 @@ static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
 }
 
 static int get_devices(struct tee_context *ctx, u32 session,
-		       struct tee_shm *device_shm, u32 *shm_size)
+		       struct tee_shm *device_shm, u32 *shm_size,
+		       u32 func)
 {
 	int ret = 0;
 	struct tee_ioctl_invoke_arg inv_arg;
@@ -42,7 +42,7 @@ static int get_devices(struct tee_context *ctx, u32 session,
 	memset(&param, 0, sizeof(param));
 
 	/* Invoke PTA_CMD_GET_DEVICES function */
-	inv_arg.func = PTA_CMD_GET_DEVICES;
+	inv_arg.func = func;
 	inv_arg.session = session;
 	inv_arg.num_params = 4;
 
@@ -87,7 +87,7 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
 	return rc;
 }
 
-int optee_enumerate_devices(void)
+static int __optee_enumerate_devices(u32 func)
 {
 	const uuid_t pta_uuid =
 		UUID_INIT(0x7011a688, 0xddde, 0x4053,
@@ -118,7 +118,7 @@ int optee_enumerate_devices(void)
 		goto out_ctx;
 	}
 
-	rc = get_devices(ctx, sess_arg.session, NULL, &shm_size);
+	rc = get_devices(ctx, sess_arg.session, NULL, &shm_size, func);
 	if (rc < 0 || !shm_size)
 		goto out_sess;
 
@@ -130,7 +130,7 @@ int optee_enumerate_devices(void)
 		goto out_sess;
 	}
 
-	rc = get_devices(ctx, sess_arg.session, device_shm, &shm_size);
+	rc = get_devices(ctx, sess_arg.session, device_shm, &shm_size, func);
 	if (rc < 0)
 		goto out_shm;
 
@@ -158,3 +158,8 @@ int optee_enumerate_devices(void)
 
 	return rc;
 }
+
+int optee_enumerate_devices(u32 func)
+{
+	return  __optee_enumerate_devices(func);
+}
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index d9c5037b4e03..8b71839a357e 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -78,6 +78,9 @@ struct optee_supp {
  * @memremaped_shm	virtual address of memory in shared memory pool
  * @sec_caps:		secure world capabilities defined by
  *			OPTEE_SMC_SEC_CAP_* in optee_smc.h
+ * @scan_bus_done	flag if device registation was already done.
+ * @scan_bus_wq		workqueue to scan optee bus and register optee drivers
+ * @scan_bus_work	workq to scan optee bus and register optee drivers
  */
 struct optee {
 	struct tee_device *supp_teedev;
@@ -89,6 +92,9 @@ struct optee {
 	struct tee_shm_pool *pool;
 	void *memremaped_shm;
 	u32 sec_caps;
+	bool   scan_bus_done;
+	struct workqueue_struct *scan_bus_wq;
+	struct work_struct scan_bus_work;
 };
 
 struct optee_session {
@@ -173,7 +179,9 @@ void optee_free_pages_list(void *array, size_t num_entries);
 void optee_fill_pages_list(u64 *dst, struct page **pages, int num_pages,
 			   size_t page_offset);
 
-int optee_enumerate_devices(void);
+#define PTA_CMD_GET_DEVICES		0x0
+#define PTA_CMD_GET_DEVICES_SUPP	0x1
+int optee_enumerate_devices(u32 func);
 
 /*
  * Small helpers
-- 
2.17.1

