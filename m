Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16845112EB8
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Dec 2019 16:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfLDPkn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Dec 2019 10:40:43 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34602 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbfLDPkn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Dec 2019 10:40:43 -0500
Received: by mail-qk1-f194.google.com with SMTP id d202so323038qkb.1
        for <linux-integrity@vger.kernel.org>; Wed, 04 Dec 2019 07:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TKYIamcANZtYnmd1DLMg7mRBVJgMxnDC2sAqJEPIU6o=;
        b=MnN7qOb/Aw5hzyId41e+MvM96sCf/2c9FL9dits2novfdCy38l1/jJBsE1+wc4CuQQ
         wJ6Niv+OzgPFjhdWNvF5jLiIqcA7oN//EoCsfCB2ZNOzcq2M0zI0Orgz+dmeNVH+GvJA
         gOc3ooWHdDMsuUfWywZwnY2gzvT3IzCIpuqxFfrlccfJKdFW91lXLM9Y1u/dy9s7T3KN
         I6AgMBz1p0Pf1QQ+UK8fEJlZv5SO1z74BKGRINlVNqAT55wfRmGFV5SECzpLWjlYfb2b
         FCgn29hXTwL/HXrrQzMlDGu/tGJqh/6IB/UcRDvmaC1OeHDCYh5IHIA7Z096X8tbng5F
         Wmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TKYIamcANZtYnmd1DLMg7mRBVJgMxnDC2sAqJEPIU6o=;
        b=P3V1fWbPxFLqrm85zKdJRBDDDd66e/TBaccTwblWCVpwYdhOGT5M/YDy+prRoL6sFS
         mZIm8YRj7CO6KIDXPHfoH80GJHLpJY8ZVY5iT0BsOQaG/+Wgu+G9r0YxREt8ht0nxudP
         74FD+6F0tyRZM5qbOrveaW42QHJfwvxPaBscNHicl2qDYHnJnQU+FoVSQPhV7BQGO5BX
         nQhQ+u2zwNpE69iRAvoQuJJk9dV2hEfxKgn11zuJUovfPhtIx9b5p6mvSw2dFZFHxd44
         JHkQRmqXvrMkJ89/C/sl+yq8TmaEaMN0XOVNYG1Yla5tolmAn4PmcJzRWSDh1Ss+VUBS
         QVVw==
X-Gm-Message-State: APjAAAVGkVSUHKVhJ7U3A9RcmBMgE33G5x+BTRHLKAqnPXiOWOwl0KUB
        c5ti7Nu9GVnjF2MY4nS6vbZvdQ==
X-Google-Smtp-Source: APXvYqzaHMZ7ljtRRla518W1B2GOaSGHFhofv7ElsnTVyzHk/MSaxlYFr3gvMJQ2QFU6avcGGFW/IA==
X-Received: by 2002:a37:7186:: with SMTP id m128mr3526332qkc.384.1575474042150;
        Wed, 04 Dec 2019 07:40:42 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id y28sm3937692qtk.65.2019.12.04.07.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:40:41 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org, ilias.apalodimas@linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Subject: [PATCH v4 1/1] tpm/tpm_ftpm_tee: add shutdown call back
Date:   Wed,  4 Dec 2019 10:40:38 -0500
Message-Id: <20191204154038.2276810-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204154038.2276810-1-pasha.tatashin@soleen.com>
References: <20191204154038.2276810-1-pasha.tatashin@soleen.com>
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
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Sasha Levin <sashal@kernel.org>
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
2.24.0

