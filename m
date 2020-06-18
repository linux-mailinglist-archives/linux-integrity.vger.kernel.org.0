Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023881FF3F4
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 15:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbgFRNxa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 09:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbgFRNw5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 09:52:57 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77418C0613EE
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jun 2020 06:52:57 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q19so7357065lji.2
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jun 2020 06:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9P1JCHrt7FUW+xiuM5vRud2sFx/m9qpZviiIZWSxrs0=;
        b=fODOZVVAnIrwoUAGSdktk0kNRi39TD3Lykb/NupWJ2fkCd44VpIcQ3OX6t7gFZc8bv
         9mkwvZ5UOQt9GsXUcQhK6Anuggx62lhuOCS4LMARk8o5hYREwyQChzBoKG5ohuca9Gfu
         0sHcIPcV4k7pQCIDqLEHPkYlOEwxMVR1KnC383+RumsOcY/yRwcIItVdUkaCX5aCKSKS
         in5FTKhUADwrQfDy3FcD2qcW0tqfRCF+uOMSo3RTkuBuXIEcvA/dK+1IoJetlpLm6366
         MB9g77DSsG5kxYlIlToWw7tpxgjTC4LI7hOqg9DEd8mg2oTmInUJOdeVoFF0U+PXVKcR
         FbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9P1JCHrt7FUW+xiuM5vRud2sFx/m9qpZviiIZWSxrs0=;
        b=Ms6vTx9cR9AcdXKCNqIHmfGAm7tsyHIxrFTq76EW/QcXt+52o01D/xMRocj2ESu5F1
         EStibYcvbFoXODpZEnL5y2vgEpahYJaW2fkrRA431l9YkHyME8G1JRfd1ChlWlKN7kyK
         jgj3cskBDR/3ywG96/uK0ldyz29wvPTIlmfTbDlXnodwYpoK5qY+Q8/Z4snboGUn0i9a
         gBjQCfVPuqZ2dZX3mASbqnQ3+N60doCF4y7hJwP7VdWYtmG4B5+13xmIcI9WybkR2IcH
         1u+1vMH/v+FtK94aFPV1JHfFVFkpS3xFcKgy4Je4b+TaBVVscoKQWkwE3kmduohteeT6
         CaPQ==
X-Gm-Message-State: AOAM533QsL2U70DoxkLl8eRslSXg+gAO/5rfOeRFH7Pr1ngCF4Yh2v6+
        Dm3gdntYGIC9RkzNYCV0blWk7Q==
X-Google-Smtp-Source: ABdhPJyCXiCIvGCC262AeAojPgSkk69Vv7ksw/of2eKCXEYedcwranKM17EXQYCe8ycY+gsWuOgfHQ==
X-Received: by 2002:a05:651c:108:: with SMTP id a8mr2424578ljb.326.1592488375701;
        Thu, 18 Jun 2020 06:52:55 -0700 (PDT)
Received: from maximlap.d-systems.local ([185.75.190.112])
        by smtp.gmail.com with ESMTPSA id f2sm768324lfc.11.2020.06.18.06.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 06:52:55 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv9 1/3] optee: use uuid for sysfs driver entry
Date:   Thu, 18 Jun 2020 16:52:49 +0300
Message-Id: <20200618135251.5761-2-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618135251.5761-1-maxim.uvarov@linaro.org>
References: <20200618135251.5761-1-maxim.uvarov@linaro.org>
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
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Sumit Garg <sumit.garg@linaro.org>
---
 Documentation/ABI/testing/sysfs-bus-optee-devices | 8 ++++++++
 MAINTAINERS                                       | 1 +
 drivers/tee/optee/device.c                        | 9 ++++++---
 3 files changed, 15 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices

diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
new file mode 100644
index 000000000000..0f58701367b6
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
@@ -0,0 +1,8 @@
+What:		/sys/bus/tee/devices/optee-ta-<uuid>/
+Date:           May 2020
+KernelVersion   5.8
+Contact:        op-tee@lists.trustedfirmware.org
+Description:
+		OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
+		matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
+		are free to create needed API under optee-ta-<uuid> directory.
diff --git a/MAINTAINERS b/MAINTAINERS
index 301330e02bca..b9536cb5b8b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12697,6 +12697,7 @@ OP-TEE DRIVER
 M:	Jens Wiklander <jens.wiklander@linaro.org>
 L:	tee-dev@lists.linaro.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-optee-devices
 F:	drivers/tee/optee/
 
 OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index e3a148521ec1..e91b7db5f49e 100644
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
+	if (dev_set_name(&optee_device->dev, "optee-ta-%pUb", device_uuid)) {
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

