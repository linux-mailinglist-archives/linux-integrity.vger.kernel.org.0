Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8411EE73D
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jun 2020 17:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgFDPD6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jun 2020 11:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbgFDPD5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jun 2020 11:03:57 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7383C08C5C0
        for <linux-integrity@vger.kernel.org>; Thu,  4 Jun 2020 08:03:55 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id n24so7682653lji.10
        for <linux-integrity@vger.kernel.org>; Thu, 04 Jun 2020 08:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2G7ECRZ0sqdPG0Sn9PupugE+kCxZ4b7ImU27a+GdeD4=;
        b=yejS0GIsl+P7vAV536bZM+BfVVBb8WI7tgOzOO2ZEbeYEvxxjzzSxz+TWYdDp7xNdn
         megTdRN0ZB6GMnXPp8pbIsiHJwCdlRRGCAxYrK0uRDiyurxcn6/wZFlNJWo0IlBKBQjB
         NLhDCl5lolyRtuzQF5YhwHt6lEvE1Wflf5VAmDb/s+5RoRjZS23yTi4BwXT+nvjnMHsK
         INC2ECVClnxsuKg42XbK6yJt9n1w+QZ/BCBPmcxsyOMN7eNrI7guUf4oNVVP9NIYN2N7
         UjPoG+KPrAKDwy00HPkv9SJ9kCSA2lYLSltKZUB4b9mgiasdhqp1YhxDfc0Hb4FN2ldo
         L2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2G7ECRZ0sqdPG0Sn9PupugE+kCxZ4b7ImU27a+GdeD4=;
        b=ZmhfGmYxq0B73ejFYvzt+84T0BJolZGcUr+J5O3w9HaxSpyHjoBc3Py3B6ymowqVPA
         3YHbd+yIbC/bjYFVE+VonADIcVRrGGbZVIG1LGJIUbeuxgZC+/fvm2zX2oOHsf5PUMRV
         X2n1xaiGJoK1HcbWvYFKhUQSgVa49zCg6ZgaRkUsfAK4BwnH3DC4Kbuy3DC2tx/eT839
         qEHyAM1i6t+eS3Zg7PgWqpSbvrU6TjHlqymLUS9t0MtnXQVbAfsM5Gf66yLwnhOX3Snx
         TkkcQY5/3rUzwU92OZ6S2F/1crWUnesjjgGOBf7dFPN9J4EPHRHMJ0MhXvwveFDNW8de
         /B6Q==
X-Gm-Message-State: AOAM531zAml1lJHTpJfvNzl7ANc/9XzQRTMQ+bC4NhyZud3A1zo9SbVY
        j0Wh988qZEHITXCza+GakcuZxA==
X-Google-Smtp-Source: ABdhPJxEY8iXqHYTZNqUiMEhG7EoA7OENV7C3UWY8wNG/nozA9E54iTq+rC2H83E8kmFzWCMYC/yng==
X-Received: by 2002:a2e:8e25:: with SMTP id r5mr2274751ljk.455.1591283033631;
        Thu, 04 Jun 2020 08:03:53 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id m15sm1514619lfk.65.2020.06.04.08.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 08:03:53 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv7 1/3] optee: use uuid for sysfs driver entry
Date:   Thu,  4 Jun 2020 18:03:46 +0300
Message-Id: <20200604150348.27996-2-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200604150348.27996-1-maxim.uvarov@linaro.org>
References: <20200604150348.27996-1-maxim.uvarov@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

With the evolving use-cases for TEE bus, now it's required to support
multi-stage enumeration process. But using a simple index doesn't
suffice this requirement and instead leads to duplicate sysfs entries.
So instead switch to use more informative device UUID for sysfs entry
like:
/sys/bus/tee/devices/optee-ta-<uuid>

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
---
 Documentation/ABI/testing/sysfs-bus-optee-devices | 8 ++++++++
 MAINTAINERS                                       | 1 +
 drivers/tee/optee/device.c                        | 9 ++++++---
 3 files changed, 15 insertions(+), 3 deletions(-)
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
index ecc0749810b0..6717afef2de3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12516,6 +12516,7 @@ OP-TEE DRIVER
 M:	Jens Wiklander <jens.wiklander@linaro.org>
 L:	tee-dev@lists.linaro.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-optee-devices
 F:	drivers/tee/optee/
 
 OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index e3a148521ec1..14d335cf8d34 100644
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
@@ -75,7 +75,10 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
 		return -ENOMEM;
 
 	optee_device->dev.bus = &tee_bus_type;
-	dev_set_name(&optee_device->dev, "optee-clnt%u", device_id);
+	if (!dev_set_name(&optee_device->dev, "optee-ta-%pUl", device_uuid)) {
+		kfree(optee_device);
+		return -ENOMEM;
+	}
 	uuid_copy(&optee_device->id.uuid, device_uuid);
 
 	rc = device_register(&optee_device->dev);
@@ -144,7 +147,7 @@ int optee_enumerate_devices(void)
 	num_devices = shm_size / sizeof(uuid_t);
 
 	for (idx = 0; idx < num_devices; idx++) {
-		rc = optee_register_device(&device_uuid[idx], idx);
+		rc = optee_register_device(&device_uuid[idx]);
 		if (rc)
 			goto out_shm;
 	}
-- 
2.17.1

