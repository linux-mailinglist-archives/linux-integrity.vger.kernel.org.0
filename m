Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C295F1E2DA1
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2020 21:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391697AbgEZTWs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 May 2020 15:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392083AbgEZTUj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 May 2020 15:20:39 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C25C03E96F
        for <linux-integrity@vger.kernel.org>; Tue, 26 May 2020 12:20:39 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id z6so25913249ljm.13
        for <linux-integrity@vger.kernel.org>; Tue, 26 May 2020 12:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lvb7GwLG3BntWf/QcLDoc033RmPPdE5QMxPQxom4Z0Q=;
        b=v/IieG+v8K1/6mBF8GZcSAnmAYLch72PLwozLymUhBDLeK34PAwfgESn58GfbEMC7Z
         gcaFKAorQtsiHvcqwEbI4+Yg8Anlnx6dQ1kJxM4Sk59kmflXQ6vygfLcGRB9ox/N3nKD
         hEgF5Za1Z2HtCtx9hgDKdcDJQBLDJ9AcnMjZd69+ad8s7d2ZvVQY3yLJ6dSdw9ZgAQ7g
         3Mj3267zVSd38wNr/AvnwKBWVSw1lbrXRgRFy8wxDOOSd+X9OCMlUecPls3hSEwjo43B
         KmExpVFq9nI631CZLuF5iQ2r7xSFywtLzkECd3+q9Daoq3iGyL4DLp820jTNST54tTc1
         0MLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lvb7GwLG3BntWf/QcLDoc033RmPPdE5QMxPQxom4Z0Q=;
        b=Nox5M3Du5O7E1FngLOtW2lUWaEMHpkHJ9H7N/bXVG6XwH/DYGwI70C3QBMgRU5Ljp1
         dfc4LtBXZ+lJ09qJ+cCLwkUW/eSl19EOlIjk447pfBXRJzT8dz5bwPSM10kgtmGCNMDt
         GqllpHy4m4F3u4uaR4qA9r8MRqbdiTc19WAPzY9bVJmBZbA49JTKs8Rphhlb6goskrih
         zYZToOf5pGReJCoABVXGyoOX0rg6xEN10drfWTYErIiViJjm+OyDKBUllXXiWDVBpqKN
         9YGzAwQz7NEs8SsUk7so8lxpJQuR67ZfMwSjVElfAiVEmb9+mGU/78/a7qzFKZ6OVXtu
         yuFg==
X-Gm-Message-State: AOAM531r5xJ79VInQTIvdkxtYU2RAE/f6jUvnZcCWPldoAnffC9WGx5v
        GUG7DwxPFuOVDLAa3cocG+MBJw==
X-Google-Smtp-Source: ABdhPJwIqvK5YGc6xvZbo31+HCxJFzPjnxRYj+tLshYiDKcJL96yG/ZhHlaYkZlk2k3Kkmmzj+k14A==
X-Received: by 2002:a2e:89d7:: with SMTP id c23mr1230467ljk.169.1590520837478;
        Tue, 26 May 2020 12:20:37 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id i8sm180483lfo.62.2020.05.26.12.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 12:20:37 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv4 2/3] optee: use uuid for sysfs driver entry
Date:   Tue, 26 May 2020 22:20:28 +0300
Message-Id: <20200526192029.863-3-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526192029.863-1-maxim.uvarov@linaro.org>
References: <20200526192029.863-1-maxim.uvarov@linaro.org>
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

