Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7C2D4391
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Oct 2019 16:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfJKO51 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Oct 2019 10:57:27 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34850 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfJKO50 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Oct 2019 10:57:26 -0400
Received: by mail-qk1-f194.google.com with SMTP id w2so9159018qkf.2
        for <linux-integrity@vger.kernel.org>; Fri, 11 Oct 2019 07:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YbBp9VvPkD8eNpJBRQ5STbltfPRFXxYXYzjmjuU0B34=;
        b=MHcwt0R9n6g9OcUmpGOacsNQ3PLbzo+CSC08LXsvnHZ0MI4NxEONsfXpXUZCFj+nee
         xTaFgzuj8zSkufJo3VL2rKeg1RmKDKz5S63aP2m6rutf3WAmRO6zxIEEG0dhbtpwfmic
         DVIvuJSOEDEru4SJkHlRLrAmHN+LD8zrHUzDToLJ8DnkdOp679Zyr/1FS+ydZGoyAwma
         T85YTUKUtdaaDMm9Pc7jt29TBzKwUJC0jdK8/S4oVVirU6ut50SDG0HpI0hEpUwI+o6i
         QGfWuI0EqKffPiAkS51NsS2NjbnOdSBIhBxtmSw8jldSfsNGvN8qVD0nkAVX1L+aq4+h
         DkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YbBp9VvPkD8eNpJBRQ5STbltfPRFXxYXYzjmjuU0B34=;
        b=eOEvI7D9uk8+NTCpE0FU8Uz3FtJUbX3fpmQnbZklsg+aiRblNhX1xTFrCg2bNmQa1u
         KkDjKJsIrI8825mi1nAyO4xFoS6hGmcuGgj1jvwIsae4GyiQjxvAZZ2zKBYeV1UMG950
         Zt7NXBWj6EZHpk0K0LDYt5KGMHleDpTwrNRI4SRcCMmJ8n1Z76mT23fSuDa79qd47NNp
         TR/jD1xX9ZFhFEAWAgKm7qHVhkzudnHnOydN0ZZbDvy3WcJyvQucQxePBCg0vbVXdU+E
         rOfgPM2vlEPUGp0lj+z6OLKKN49HN99NsbrdNsAh3oZ+MiMpnkLobzevrtu6NHRpCRbF
         ovNw==
X-Gm-Message-State: APjAAAWcfBUY1VBFSc7S1exyk+EuFB9tlfJNpwluGnA0ljEILLzgW8R7
        Hxdzd/2iuCbSVyWVKspm620w/A==
X-Google-Smtp-Source: APXvYqwW3ebcRvrTy8tgu7bWsHJGSY9ufsTTMd5PUS1NSfcaT9aY86IEEBpS0O4460EIDp7UF7T8IQ==
X-Received: by 2002:a05:620a:2152:: with SMTP id m18mr16157791qkm.354.1570805843289;
        Fri, 11 Oct 2019 07:57:23 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q64sm4759497qkb.32.2019.10.11.07.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 07:57:22 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org, ilias.apalodimas@linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Subject: [PATCH] ftpm: add shutdown call back
Date:   Fri, 11 Oct 2019 10:57:21 -0400
Message-Id: <20191011145721.59257-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: thiruan <thiruan@microsoft.com>

add shutdown call back to close existing session with fTPM TA
to support kexec scenario.

Signed-off-by: Thirupathaiah Annapureddy <thiruan@microsoft.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 drivers/char/tpm/tpm_ftpm_tee.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 6640a14dbe48..c245be6f4015 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -328,6 +328,27 @@ static int ftpm_tee_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/**
+ * ftpm_tee_shutdown - shutdown the TPM device
+ * @pdev: the platform_device description.
+ *
+ * Return:
+ * 	none.
+ */
+static void ftpm_tee_shutdown(struct platform_device *pdev)
+{
+	struct ftpm_tee_private *pvt_data = dev_get_drvdata(&pdev->dev);
+
+	/* Free the shared memory pool */
+	tee_shm_free(pvt_data->shm);
+
+	/* close the existing session with fTPM TA*/
+	tee_client_close_session(pvt_data->ctx, pvt_data->session);
+
+	/* close the context with TEE driver */
+	tee_client_close_context(pvt_data->ctx);
+}
+
 static const struct of_device_id of_ftpm_tee_ids[] = {
 	{ .compatible = "microsoft,ftpm" },
 	{ }
@@ -341,6 +362,7 @@ static struct platform_driver ftpm_tee_driver = {
 	},
 	.probe = ftpm_tee_probe,
 	.remove = ftpm_tee_remove,
+	.shutdown = ftpm_tee_shutdown,
 };
 
 module_platform_driver(ftpm_tee_driver);
-- 
2.23.0

