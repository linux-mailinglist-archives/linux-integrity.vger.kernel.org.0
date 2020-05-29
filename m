Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011001E784D
	for <lists+linux-integrity@lfdr.de>; Fri, 29 May 2020 10:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgE2I1Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 May 2020 04:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgE2I1Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 May 2020 04:27:24 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A762C08C5C8
        for <linux-integrity@vger.kernel.org>; Fri, 29 May 2020 01:27:24 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id l15so1533413lje.9
        for <linux-integrity@vger.kernel.org>; Fri, 29 May 2020 01:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lvb7GwLG3BntWf/QcLDoc033RmPPdE5QMxPQxom4Z0Q=;
        b=F9dEKHOkH0cAXKSPdNV41k36w556EeHSBMNjTmb/IXl5HdpuI3EBvsYZoGqtAPXZJ1
         2Rk1tkciCo8IVnEzf1kZBwQCqvwYgH4W/Q58Iv61kNjuCgkTWdLrBwsr8pySgEY/5DjO
         ue39PqwUslIEqvDTDii4WUJPRXjJYVGmbseNueybZVansy6gt2W5EKfwYaz5JgtAA6RD
         xCH1bAwKUHNTB+pX5uPQIMaeorPzEtr4Sc5XrkHhU9kdR3r7UtUpgrf3BX9ShwTiBTKC
         FLnJBSjmRV9AJOL0iFcMteBgDBlHb+okTPj4jyzGpoRGS0KO5XHqIdBfe9/wm3UEgh11
         3MaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lvb7GwLG3BntWf/QcLDoc033RmPPdE5QMxPQxom4Z0Q=;
        b=iTlt2GDpWOmn03d5EYLJktjjNQv/1yOdeR1UUnYBT7YzyiDTnY8KoB2AWaucoE3kEE
         LXN4Wvx/78gO1px1bGpCt09xkjsBOjlV03AvD/sP+PSh/kuOGHeawTZXeBR+jeVUV++a
         Y/UmN5m5JqQSAuhfrdDyGS0mdkKrRhbm1xC6jqdgZBZj2zYzJjsz3qCXhV535Vbc/mNT
         blq6/bRHe7vndypl6MpzeOC/65Suf63P0u3D9RrH70nw9Ak2VUcoIE73mPiFTFr3E2ek
         RCkBfgjQGK8LbWtmabw2WIk+BeMExSjdk2xBmJBEKVMKKXrJprKVfHfsx5AziLPmSkkJ
         jKDw==
X-Gm-Message-State: AOAM533KjGH00wvh5+NTx69wU8ZVv9DEFJhC9DaHeqKkv7/SjAgwyNNL
        kNVwzTifaEbBcWQs5HeEOfX+XQ==
X-Google-Smtp-Source: ABdhPJwY7RMBHiVJn5QJhFI4Dq2Q68Mc3VSypIgKxCn3Jk9i0QL7HpowENkqjNQFNM9Fbr0Jn8Czbw==
X-Received: by 2002:a2e:8992:: with SMTP id c18mr3347262lji.396.1590740842563;
        Fri, 29 May 2020 01:27:22 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id y20sm1878450lji.31.2020.05.29.01.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 01:27:22 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv5 2/3] optee: use uuid for sysfs driver entry
Date:   Fri, 29 May 2020 11:27:00 +0300
Message-Id: <20200529082701.13457-3-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529082701.13457-1-maxim.uvarov@linaro.org>
References: <20200529082701.13457-1-maxim.uvarov@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

OP-TEE device names for sysfs need to be unique
and it's better if they will mean something. UUID for name
looks like good solution:
/sys/bus/tee/devices/optee-ta-<uuid>

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 Documentation/ABI/testing/sysfs-bus-optee-devices | 8 ++++++++
 MAINTAINERS                                       | 2 ++
 drivers/tee/optee/device.c                        | 6 +++---
 3 files changed, 13 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices

diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
new file mode 100644
index 000000000000..0ae04ae5374a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
@@ -0,0 +1,8 @@
+What:		/sys/bus/tee/devices/optee-ta-<uuid>/
+Date:           May 2020
+KernelVersion   5.7
+Contact:        tee-dev@lists.linaro.org
+Description:
+		OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
+		matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
+		are free to create needed API under optee-ta-<uuid> directory.
diff --git a/MAINTAINERS b/MAINTAINERS
index ecc0749810b0..52717ede29fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12516,8 +12516,10 @@ OP-TEE DRIVER
 M:	Jens Wiklander <jens.wiklander@linaro.org>
 L:	tee-dev@lists.linaro.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-optee-devices
 F:	drivers/tee/optee/
 
+
 OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
 M:	Sumit Garg <sumit.garg@linaro.org>
 L:	tee-dev@lists.linaro.org
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index d4931dad07aa..2eb1c0283aec 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -65,7 +65,7 @@ static int get_devices(struct tee_context *ctx, u32 session,
 	return 0;
 }
 
-static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
+static int optee_register_device(const uuid_t *device_uuid)
 {
 	struct tee_client_device *optee_device = NULL;
 	int rc;
@@ -75,7 +75,7 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
 		return -ENOMEM;
 
 	optee_device->dev.bus = &tee_bus_type;
-	dev_set_name(&optee_device->dev, "optee-clnt%u", device_id);
+	dev_set_name(&optee_device->dev, "optee-ta-%pUl", device_uuid);
 	uuid_copy(&optee_device->id.uuid, device_uuid);
 
 	rc = device_register(&optee_device->dev);
@@ -144,7 +144,7 @@ static int __optee_enumerate_devices(u32 func)
 	num_devices = shm_size / sizeof(uuid_t);
 
 	for (idx = 0; idx < num_devices; idx++) {
-		rc = optee_register_device(&device_uuid[idx], idx);
+		rc = optee_register_device(&device_uuid[idx]);
 		if (rc)
 			goto out_shm;
 	}
-- 
2.17.1

