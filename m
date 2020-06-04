Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C7F1EE9F4
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jun 2020 19:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbgFDR7A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jun 2020 13:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730303AbgFDR7A (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jun 2020 13:59:00 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081C3C08C5C0
        for <linux-integrity@vger.kernel.org>; Thu,  4 Jun 2020 10:58:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 202so4168779lfe.5
        for <linux-integrity@vger.kernel.org>; Thu, 04 Jun 2020 10:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y1Q9f/owSvUftqSD1Hv4bVUGbDrPIGyfax6gzi32kpI=;
        b=z4UfZa+lMLv9ShPYyfh+GzumSq3gGE6u750clZOuQxq+iIssvL53B15ckxMDWbgilT
         Y97NO2inkyooaFl1RiKXYZPZfxYD8JeuP4lWbC6+prNZCPutbHdXuHMJpmlSDSS9L3Ld
         KFdTxuAMWY5A+D25hrJgRYNgpzikvi7ybP1j01lLvfUG/C56nYtin72DfPI1WHKJyoU+
         FkaU3ZYqOaDOJLwOIds3gYBJcDJ7b8tSCjT3fgJrOkTXXVmwiKovflV+ylKlM9fiqOgF
         rCV1SDmSSsSTYbJg05hNbA3Zc98hKNB1FqSpFR8uHqLOu08tFXaK6WISHRVTQxb34LBI
         A0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y1Q9f/owSvUftqSD1Hv4bVUGbDrPIGyfax6gzi32kpI=;
        b=idQLjiLwHqH4vCxGpaHx033v0vjKNB3OIPvyx+DVHIYAUjHBCzsR+q+1CSOmR99t6z
         PhptLjBE+yLGSILEH+X3ajiPnA1gwOJcnNH9/FibOwms+g9W05i6zJDUl4ot1UeeIu1Z
         LSrZwDwxHCcinOllq03hJ0OGkTyM6FVgEKGEiTpk3SbxVnGW7Ulc5mjQQ+7Vk8cqPro5
         TP/fyM85/M63snhaZipWeE3XnCMR7TJio2BARjD1T2qa9PIEGuz6Gz95PP343dglx6Z3
         D8SpaBnbI5lLCYsK+gMTlaWB5SzM5issGr65ngmyv3a19GNcSaaAChQCmAacUJP99ugC
         q4aQ==
X-Gm-Message-State: AOAM531a6BPDNrT1smKWl+19+EY4ZpB0GW1kJVxmT/ZXxZ+YxKtvD8ns
        i7qfJWhtqbdv84xEh8AXHmxFoA==
X-Google-Smtp-Source: ABdhPJzADlJyHJpTMoqBhWa2Fe/0GPccN4bZcPvL36+iqkbtKBaCtVHpO1PfCmnC0izcJYKWlfrGiA==
X-Received: by 2002:ac2:490f:: with SMTP id n15mr3155675lfi.39.1591293537372;
        Thu, 04 Jun 2020 10:58:57 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id y17sm72404lfa.77.2020.06.04.10.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 10:58:56 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv8 1/3] optee: use uuid for sysfs driver entry
Date:   Thu,  4 Jun 2020 20:58:49 +0300
Message-Id: <20200604175851.758-2-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200604175851.758-1-maxim.uvarov@linaro.org>
References: <20200604175851.758-1-maxim.uvarov@linaro.org>
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
index e3a148521ec1..23d264c8146e 100644
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
+	if (dev_set_name(&optee_device->dev, "optee-ta-%pUl", device_uuid)) {
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

