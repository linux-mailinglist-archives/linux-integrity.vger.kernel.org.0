Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A66C1E0DCF
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2020 13:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390315AbgEYLwp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 May 2020 07:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390160AbgEYLwo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 May 2020 07:52:44 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E99C061A0E
        for <linux-integrity@vger.kernel.org>; Mon, 25 May 2020 04:52:44 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m18so20443272ljo.5
        for <linux-integrity@vger.kernel.org>; Mon, 25 May 2020 04:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rtUuMXm/ONBedoZkJ6q0q4M3oKLg8gzt0JX6LQl6GCI=;
        b=ijKPMN2wiA64RoZK/PINLt+f/4rT8Rahpf6206SpCLNDIOaW5SZB8Ip3LXZ3bIZEYi
         Efmzlp5DJL9pug2eitp1odZalFzIgPO8l7/HMvKOeLlKq8Hoy6FnzJyIwdC/s94YseXc
         Lgcc+NUDl/ZFokOEv9IWnfVZstonJgq9dN5Zanq1Vft9MBGOs2VO8XbhyY2gEdoK/3WQ
         uVS+zt/9zLFoK3z1X8iDLBIwpHRk9w29O20zzbkqaM4DdSzB4Xv9NG5Mx6k2UIgqEJ5l
         rhKiWsH48GNbqbrHIpf3FVQYMhV9SVo6Lba/gpsE0xm0GTDVEmVpzB5Ltp7tPxvDnRnO
         qEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rtUuMXm/ONBedoZkJ6q0q4M3oKLg8gzt0JX6LQl6GCI=;
        b=bX6Wd12cTAKQowRzt3o2xqXiIIdnXIIEonHpixoH+YSp7NPqlQBhMpeAyg93F5Widg
         9NYF4vXai5t9npH9134MEDQqZag1D4p7kUiRexQceU/YG57gd2a0PRxcQd1jJM3hIq9u
         J+7vMmQ26hslzytWZ/TG7Q4QGcMuGUAsYgzHS0i4mYVDBK5VJPkT/NaKENo7pfGAoEVX
         Fb9OGZR6LAeQSgOxLeP+hxBG/st/Zb70ZZ16IhqTFAChJOegke0jXU2WfrFMZVaUta+w
         wlUL7O9piS1A/g690tu949esn3MPXJp/5EaM9UUY0xJNbY1SvPTOk9PfTpoRigym1V3p
         3BsQ==
X-Gm-Message-State: AOAM532jIRubOV+B/Mb+EHzWYqi8144EcM/3Hu+ChltS++u/7aNrG386
        nxquaI63j6AKkRbzJzVFpDTIlA==
X-Google-Smtp-Source: ABdhPJxPZXCvsuT4UnRbx+3FQxO74WQB/yQ6KOG1U7quUxuRwPM4KdQqkJEiCW5Sj1m2+FelslVL+w==
X-Received: by 2002:a2e:8082:: with SMTP id i2mr14079063ljg.134.1590407562451;
        Mon, 25 May 2020 04:52:42 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id y130sm4847756lfc.22.2020.05.25.04.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 04:52:41 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv3 1/3] optee: do drivers initialization before and after tee-supplicant run
Date:   Mon, 25 May 2020 14:52:33 +0300
Message-Id: <20200525115235.5405-2-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525115235.5405-1-maxim.uvarov@linaro.org>
References: <20200525115235.5405-1-maxim.uvarov@linaro.org>
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

