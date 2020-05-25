Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F631E0DD7
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2020 13:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390365AbgEYLw7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 May 2020 07:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390323AbgEYLwp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 May 2020 07:52:45 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E29CC061A0E
        for <linux-integrity@vger.kernel.org>; Mon, 25 May 2020 04:52:45 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a25so8801708ljp.3
        for <linux-integrity@vger.kernel.org>; Mon, 25 May 2020 04:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GGtb/VoRoWTmlojJAyBVCcYgsbrBsVJ+27ovJzUUe4Q=;
        b=fytoxuUYZUmziOocYOXa6Ua4TXMwv5acadaI6E+7PiGdl/arLQGPQaPfMmRUWo4Jnr
         ytKMK4XS3klP+uUdG9mtW+8fVxTUC7kzjkfy2oRh+WYetY6htW/KH2hvMU+/t4lQqsVo
         6RE0bXTJYhjsbPQluDB8ZVCaHsCX6KsSxqUdIwkANIpUxlLSPYQ+ZEBWIoUDA/VD+vF/
         s8nw46T/keKlv30EHWhasZop8jqmjcGVskS896QPH4RVbbK2OL8lMUW0grAOSllICALj
         08n7VTqdhShz1HDV4HuWYl5fH6YqvG7X1Kh/b5FflPhD+LaTXqjdjC2Xdh5guUNSLBWD
         DNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GGtb/VoRoWTmlojJAyBVCcYgsbrBsVJ+27ovJzUUe4Q=;
        b=qloQOpVVB/ymg+BvDtNEJs6hGnM4lnJ3TGtOc9IE2G9I1esigakt4zvWRj6zTMyswc
         bjCJRjq/NXQe5wQ4KnacRKNcClPnuODU3YiY3rK4Spco1gs64UB9Qeh2G5REtanoiROW
         cfL5ZQqEbkccZlZ/8mNKYRlWrLtS94ddwBJhfg/0WC6UCewe2gfCFQA+SspxZZIdC5Xx
         MEkyy2ZwA34myj3+HIkMKyqgj9FIlbPinYCvglbYpWL7rfLGkzgPlfIH5P78QyGxfc4V
         PYeI4hLD9cMNucO4MUn+AIdir1kXGyJA9oeGKGiRC9jWrb7X/3Z8rkN8R3mvVqLT/YK+
         vpUQ==
X-Gm-Message-State: AOAM530MViWeFQUbU32kHuFoGuBV8O6Eyu8OGia+Vpo4nenpVTxm+y1A
        x7jwYqXgYPEpCZkN24OMvhl+wQ==
X-Google-Smtp-Source: ABdhPJzupvF9pjz+LSBC5BY8hC4Q+7Z8VeXmpJDxLeKXi4HEwS66Xwy96UpVjqQIb9TnNX/rcc/3cQ==
X-Received: by 2002:a2e:150f:: with SMTP id s15mr13209778ljd.102.1590407563923;
        Mon, 25 May 2020 04:52:43 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id y130sm4847756lfc.22.2020.05.25.04.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 04:52:43 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv3 2/3] optee: use uuid for sysfs driver entry
Date:   Mon, 25 May 2020 14:52:34 +0300
Message-Id: <20200525115235.5405-3-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525115235.5405-1-maxim.uvarov@linaro.org>
References: <20200525115235.5405-1-maxim.uvarov@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Optee device names for sysfs needed to be unique
and it's better if they will mean something. UUID for name
looks like good solution:
/sys/bus/tee/devices/optee-clnt-<uuid>

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 drivers/tee/optee/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index d4931dad07aa..aab917605e74 100644
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
+	dev_set_name(&optee_device->dev, "optee-clnt-%pUl", device_uuid);
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

