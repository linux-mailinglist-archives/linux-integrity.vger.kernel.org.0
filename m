Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4C71D79F5
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2020 15:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgERNfM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 May 2020 09:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbgERNfM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 May 2020 09:35:12 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01BCC061A0C
        for <linux-integrity@vger.kernel.org>; Mon, 18 May 2020 06:35:10 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d21so9851816ljg.9
        for <linux-integrity@vger.kernel.org>; Mon, 18 May 2020 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nReH/eQEYpY5qBGwyesmqqBLLLmSZ5Vmj3Rju5zI4Hg=;
        b=D6zE7LhyBDbFvUvXHBjPgBWWhiZH+CpalI1XPPXwKexEQ/02z/PPA1SZXZuW1tba2j
         nTAJ9svDa5HUuUJsdPXuRFt0W7qqw9jAoosxuvTLwOPSVy3GOgn9kNsWBIqn/DOWyK1m
         +nZ0CwnmYrbvvNnw8OPVeDjsPk+ye4pU8G084qemJFbvkFQcw6zHlNmSdh/EHYO/JzbA
         XJIzEsvv0RGR23ycXv8NNX5NtANsgnBN4yHKXW8xDPHrgg8tz5cyK6KSLsBuJdPkO/WH
         Ok56mgvHqGRMl1jGlvbxNCs5vAZK4yf7IZXCOWWyMgwUP5RhATPlx1HWpOzg/mlekecX
         0AQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nReH/eQEYpY5qBGwyesmqqBLLLmSZ5Vmj3Rju5zI4Hg=;
        b=kV37HXcm+xZs0nx7AGCBV2Y8dNiyWduqBEokcRTL0mxVj8O9HRWYWNTtFaa9963a3z
         6zQyDN6792qLrAXsUJeJ/P7iV/4OFOj5ltX0vjQn28TnB8aFAQBsw6YPTM4n6WwN4gge
         GdezRDtly3IouXdT0dpm+b3TWx+nZyR8T+AIyiTsuQzCMjYN+6g4IXgZQ6vhLjBdPPjk
         IWSgL1I0nwIDzfU5otOwxAk9FiJ/oah49Dh6SKheL1qEJZTe2BskC8kPhW73q+vrTvlk
         KNyI0Z4ahKFHZdkhjPZHAaZznvVEXk9rnuD0K6sC9SHZg6lSQZmxiYJuCW75zfBPoln8
         qBkw==
X-Gm-Message-State: AOAM532l/TnNUzy4dcsUqgm13PyaQlI5FCt0ODJqur8XH269vp9dhp/E
        Fxto2imYUmHNLQwXAXFWpEf0dg==
X-Google-Smtp-Source: ABdhPJzLr8kFLKl76UF8Zmt6RJKxe5bU4dooeIUbedNmLQl2xA0++XwUYvWel1Q0n+BFYh3LAbMfFQ==
X-Received: by 2002:a05:651c:3c1:: with SMTP id f1mr1653068ljp.77.1589808907944;
        Mon, 18 May 2020 06:35:07 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id w20sm1370439lfk.56.2020.05.18.06.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 06:35:07 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCH 1/2] optee: do drivers initialization before and after tee-supplicant run
Date:   Mon, 18 May 2020 16:34:58 +0300
Message-Id: <20200518133459.28019-2-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518133459.28019-1-maxim.uvarov@linaro.org>
References: <20200518133459.28019-1-maxim.uvarov@linaro.org>
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
 drivers/tee/optee/core.c          | 25 ++++++++++++++++++++++---
 drivers/tee/optee/device.c        | 17 +++++++++++------
 drivers/tee/optee/optee_private.h |  8 +++++++-
 3 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 99698b8a3a74..dd2265c44907 100644
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
@@ -241,8 +251,15 @@ static int optee_open(struct tee_context *ctx)
 			kfree(ctxdata);
 			return -EBUSY;
 		}
-	}
 
+		INIT_WORK(&optee->scan_bus_work, optee_bus_scan);
+		optee->scan_bus_wq = create_workqueue("optee_bus_scan");
+		if (!optee->scan_bus_wq) {
+			pr_err("optee: couldn't create workqueue\n");
+			return -ECHILD;
+		}
+		queue_work(optee->scan_bus_wq, &optee->scan_bus_work);
+	}
 	mutex_init(&ctxdata->mutex);
 	INIT_LIST_HEAD(&ctxdata->sess_list);
 
@@ -296,8 +313,10 @@ static void optee_release(struct tee_context *ctx)
 
 	ctx->data = NULL;
 
-	if (teedev == optee->supp_teedev)
+	if (teedev == optee->supp_teedev) {
+		destroy_workqueue(optee->scan_bus_wq);
 		optee_supp_release(&optee->supp);
+	}
 }
 
 static const struct tee_driver_ops optee_ops = {
@@ -675,7 +694,7 @@ static int optee_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, optee);
 
-	rc = optee_enumerate_devices();
+	rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES);
 	if (rc) {
 		optee_remove(pdev);
 		return rc;
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index e3a148521ec1..8263b308efd5 100644
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
+int __optee_enumerate_devices(u32 func)
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
index d9c5037b4e03..6cdac4bb7253 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -78,6 +78,8 @@ struct optee_supp {
  * @memremaped_shm	virtual address of memory in shared memory pool
  * @sec_caps:		secure world capabilities defined by
  *			OPTEE_SMC_SEC_CAP_* in optee_smc.h
+ * @scan_bus_wq		workqueue to scan optee bus and register optee drivers
+ * @scan_bus_work	workq to scan optee bus and register optee drivers
  */
 struct optee {
 	struct tee_device *supp_teedev;
@@ -89,6 +91,8 @@ struct optee {
 	struct tee_shm_pool *pool;
 	void *memremaped_shm;
 	u32 sec_caps;
+	struct workqueue_struct *scan_bus_wq;
+	struct work_struct scan_bus_work;
 };
 
 struct optee_session {
@@ -173,7 +177,9 @@ void optee_free_pages_list(void *array, size_t num_entries);
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

