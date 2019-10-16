Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B843FD9766
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Oct 2019 18:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406313AbfJPQbW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Oct 2019 12:31:22 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:32905 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406299AbfJPQbS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Oct 2019 12:31:18 -0400
Received: by mail-qk1-f194.google.com with SMTP id x134so23368845qkb.0
        for <linux-integrity@vger.kernel.org>; Wed, 16 Oct 2019 09:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTgFblTilWPLhT8MMkcXspcKpW5vjx4zEloAKyzJGi0=;
        b=coFJjl0HJ+uHFdg/bI6YXY7wiaUzK1aPDE5YOVuYUMg1nQZgO/cfYCiQmzo/YtiC4w
         SlhtLAroVPdlEVGO5aeCmlYdzdYJFQxi03+NiMjE4NnF7k0Yqi94dPrvrn8T3mMx3IOx
         hd7Hh7peaPx05gIOGe5GHwPEP2X0Bhl3OHY8cAmfY0VEFiDDVmYyWVc5u4RsJ2UYApXN
         wC7ypZP2CtXmmQ0LQy47RpwchV6Yb5CnUPNXcsH2jmKOTESumQg7/NK+2vzpL57jtm5Y
         DlVjxc7a+Vgojx5DHU5c2Rot9/Plh/6GL5qf9YKsLGvMXt3n+3r14apyCEpdy++H9WEm
         TBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTgFblTilWPLhT8MMkcXspcKpW5vjx4zEloAKyzJGi0=;
        b=KkUiCH7J0yc5FSuAD+KnqBxFJrYnjHIXw9aF+2vbXXQa2QrOBqx4JnRw2tgopnGHmU
         JzoKMzkRlLAT6cbFuAAcCp75fybw3MjdOPfhair+To7Cjre1nBiBN1iJdVrXZ+dFmvKA
         zgVHIgkeog1klkGuENjgHhFDqkdpCifAqMoHNE48CT4eN4Hs8EQejhYdQOup7CzysW5B
         huKTQUvan+vWjgbrQ35mWTHtv29rBD9YKP35Dzt2a6izkKTyg2xgj8w2ua+t0FHuU4qn
         QzCr61we07ZWQEPtKZxirJ8aIWnz+ystDvJx2SU2HQ6wIos68XKU9lMN1EExFGouZ0I6
         pRrw==
X-Gm-Message-State: APjAAAXYT2VNzwlul1XrA4BYDXVzwEZsK4LF+qrkni1BW0SpTnORQczo
        onGd9fmBmJVjkCpcDOj3QNh6Sw==
X-Google-Smtp-Source: APXvYqyHCJf1i88vRUK7SbxeLerxK/xfkkBAD/iRk3OjZtPqNBNflP4CyHeu77wsKOU1yNNd980c0A==
X-Received: by 2002:a05:620a:1012:: with SMTP id z18mr42381240qkj.275.1571243476948;
        Wed, 16 Oct 2019 09:31:16 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u39sm13506560qtj.34.2019.10.16.09.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 09:31:16 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org, ilias.apalodimas@linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Subject: [PATCH v3] tpm/tpm_ftpm_tee: add shutdown call back
Date:   Wed, 16 Oct 2019 12:31:14 -0400
Message-Id: <20191016163114.985542-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add shutdown call back to close existing session with fTPM TA
to support kexec scenario.

Add parentheses to function names in comments as specified in kdoc.

Signed-off-by: Thirupathaiah Annapureddy <thiruan@microsoft.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 drivers/char/tpm/tpm_ftpm_tee.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 6640a14dbe48..22bf553ccf9d 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -32,7 +32,7 @@ static const uuid_t ftpm_ta_uuid =
 		  0x82, 0xCB, 0x34, 0x3F, 0xB7, 0xF3, 0x78, 0x96);
 
 /**
- * ftpm_tee_tpm_op_recv - retrieve fTPM response.
+ * ftpm_tee_tpm_op_recv() - retrieve fTPM response.
  * @chip:	the tpm_chip description as specified in driver/char/tpm/tpm.h.
  * @buf:	the buffer to store data.
  * @count:	the number of bytes to read.
@@ -61,7 +61,7 @@ static int ftpm_tee_tpm_op_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 }
 
 /**
- * ftpm_tee_tpm_op_send - send TPM commands through the TEE shared memory.
+ * ftpm_tee_tpm_op_send() - send TPM commands through the TEE shared memory.
  * @chip:	the tpm_chip description as specified in driver/char/tpm/tpm.h
  * @buf:	the buffer to send.
  * @len:	the number of bytes to send.
@@ -208,7 +208,7 @@ static int ftpm_tee_match(struct tee_ioctl_version_data *ver, const void *data)
 }
 
 /**
- * ftpm_tee_probe - initialize the fTPM
+ * ftpm_tee_probe() - initialize the fTPM
  * @pdev: the platform_device description.
  *
  * Return:
@@ -298,7 +298,7 @@ static int ftpm_tee_probe(struct platform_device *pdev)
 }
 
 /**
- * ftpm_tee_remove - remove the TPM device
+ * ftpm_tee_remove() - remove the TPM device
  * @pdev: the platform_device description.
  *
  * Return:
@@ -328,6 +328,19 @@ static int ftpm_tee_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/**
+ * ftpm_tee_shutdown() - shutdown the TPM device
+ * @pdev: the platform_device description.
+ */
+static void ftpm_tee_shutdown(struct platform_device *pdev)
+{
+	struct ftpm_tee_private *pvt_data = dev_get_drvdata(&pdev->dev);
+
+	tee_shm_free(pvt_data->shm);
+	tee_client_close_session(pvt_data->ctx, pvt_data->session);
+	tee_client_close_context(pvt_data->ctx);
+}
+
 static const struct of_device_id of_ftpm_tee_ids[] = {
 	{ .compatible = "microsoft,ftpm" },
 	{ }
@@ -341,6 +354,7 @@ static struct platform_driver ftpm_tee_driver = {
 	},
 	.probe = ftpm_tee_probe,
 	.remove = ftpm_tee_remove,
+	.shutdown = ftpm_tee_shutdown,
 };
 
 module_platform_driver(ftpm_tee_driver);
-- 
2.23.0

