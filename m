Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F71FD6AB9
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Oct 2019 22:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732608AbfJNUVi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Oct 2019 16:21:38 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39253 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730516AbfJNUVi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Oct 2019 16:21:38 -0400
Received: by mail-qt1-f194.google.com with SMTP id n7so27203489qtb.6
        for <linux-integrity@vger.kernel.org>; Mon, 14 Oct 2019 13:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=adO3s5rQ80FSe9QoQi3APfXKvpPGONNAIqngjG3oV3o=;
        b=OM2ocL11y852dXCVsBTTpuenXy1lATvJseKhiuvI5VqKrW3eLE0ylQgP0sVpJYLMqj
         V+5p0nSCH5rtm5LMxJzk63qUpR9mCtXx/XbgvaoScxUOnwO1xOeUhezLjlq9KtPDfKhp
         vZt862J+CI1qdnKRiqLlUUFrbhGYwtFxs9oqYKQNKoI2lXWl7HSZKymNsU/OF/Bfc7+x
         BsWoW55x/FwsLR7uau3VLSwUPAbwkHiJS4+jHjDuNNCHRSOwePUqK9KYfadOZ6LEp7xE
         tuL3rbh5/VA/0sWCOxYlL7n3oaUiY26/ltdD2omqJQqg0Y3NHy1m5E1Fnd29cPO8IvcU
         tuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=adO3s5rQ80FSe9QoQi3APfXKvpPGONNAIqngjG3oV3o=;
        b=HC56wMazRNIU5jSwJt/BMOBgJVG91nfxxcj7YtXwYqoUtWacpBsLJJ2GVOI5X1aGHI
         KMsbfq1Aad4+cUg3Zz8olRm/0w0c1ofAUvEIyFJXN6UJSCYTvD0EUFq9JqOEAn10//YF
         NXFH/oB11JbMxlfxXPRHzijyJm5ipMAbsMJPPwZZqFOg23qzXD2y+mbV+2UXHKnfA+OG
         GN5o3Rbo79/F7uqdJSG9L4hDiIaXM7mfLciJU8qglijbfQ75jZrag7CuZvQ1RPVrG2qo
         wwk9DHBQ7M+ZGIpjmSeGGbDxHeZelLnefOxcUH5wCuvlOzWxUIY7FWUxS28Ok0XsJkDL
         KE/Q==
X-Gm-Message-State: APjAAAXNv0RvZXuSFgDeYA8uJXmvAmYUikmEAWZWYPEn7c+xOOFPLskE
        S/i5jr8vraPfBAKBqvY5hbUrXg==
X-Google-Smtp-Source: APXvYqyIGxVirj24b/z7N8sIuYFghEnsbiFVPx5jPEWYM5oEfLgLlBoX9K22BMNQM88asTUBLjrE6A==
X-Received: by 2002:aed:3e45:: with SMTP id m5mr3983673qtf.268.1571084497370;
        Mon, 14 Oct 2019 13:21:37 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id y58sm11111472qta.1.2019.10.14.13.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 13:21:36 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org, ilias.apalodimas@linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Subject: [PATCH v2] tpm/tpm_ftpm_tee: add shutdown call back
Date:   Mon, 14 Oct 2019 16:21:35 -0400
Message-Id: <20191014202135.429009-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

add shutdown call back to close existing session with fTPM TA
to support kexec scenario.

Signed-off-by: Thirupathaiah Annapureddy <thiruan@microsoft.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 drivers/char/tpm/tpm_ftpm_tee.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 6640a14dbe48..ad16ea555e97 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -328,6 +328,19 @@ static int ftpm_tee_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/**
+ * ftpm_tee_shutdown - shutdown the TPM device
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

