Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 960458B974
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Aug 2019 15:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfHMNGH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Aug 2019 09:06:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727425AbfHMNGH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Aug 2019 09:06:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B68DA206C2;
        Tue, 13 Aug 2019 13:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565701565;
        bh=/XgDq0Sg1Ifb1GFIIHjqV+Hu7HputWWafjIl43pcTZ4=;
        h=From:To:Cc:Subject:Date:From;
        b=PhStlNDon4n1IlaA0NJHILAJUbaSV58XyxhA9I53Buw1zRzQn5gzGT5BOpXdDJ9n+
         bwokpELD0QnRaAT6IaGFNNM16Dwxu+xylQ/sDg5VAkhxHkETOBLBkHBfkdNzGlUy6y
         ea3V0D3QRPy8AfqfuH2rRlNCDt1TU5ocXhrzH7nQ=
From:   Sasha Levin <sashal@kernel.org>
To:     jarkko.sakkinen@linux.intel.com, peterhuewe@gmx.de
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH] tpm/tpm_ftpm_tee: trivial checkpatch fixes
Date:   Tue, 13 Aug 2019 09:05:59 -0400
Message-Id: <20190813130559.16936-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fixes a few checkpatch warnings (and ignores some), mostly around
spaces/tabs and documentation.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml |  2 ++
 drivers/char/tpm/Kconfig                               |  2 +-
 drivers/char/tpm/tpm_ftpm_tee.c                        | 10 +++++-----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6992bbbbffab6..d61a203138cbe 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -575,6 +575,8 @@ patternProperties:
     description: Micro Crystal AG
   "^micron,.*":
     description: Micron Technology Inc.
+  "^microsoft,.*":
+    description: Microsoft Corporation
   "^mikroe,.*":
     description: MikroElektronika d.o.o.
   "^miniand,.*":
diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 17bfbf9f572fc..9c37047f4b562 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -167,7 +167,7 @@ config TCG_VTPM_PROXY
 config TCG_FTPM_TEE
 	tristate "TEE based fTPM Interface"
 	depends on TEE && OPTEE
-	---help---
+	help
 	  This driver proxies for firmware TPM running in TEE.
 
 source "drivers/char/tpm/st33zp24/Kconfig"
diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 5679a5af9a96a..6640a14dbe48c 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -38,7 +38,7 @@ static const uuid_t ftpm_ta_uuid =
  * @count:	the number of bytes to read.
  *
  * Return:
- * 	In case of success the number of bytes received.
+ *	In case of success the number of bytes received.
  *	On failure, -errno.
  */
 static int ftpm_tee_tpm_op_recv(struct tpm_chip *chip, u8 *buf, size_t count)
@@ -67,7 +67,7 @@ static int ftpm_tee_tpm_op_recv(struct tpm_chip *chip, u8 *buf, size_t count)
  * @len:	the number of bytes to send.
  *
  * Return:
- * 	In case of success, returns 0.
+ *	In case of success, returns 0.
  *	On failure, -errno
  */
 static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
@@ -212,7 +212,7 @@ static int ftpm_tee_match(struct tee_ioctl_version_data *ver, const void *data)
  * @pdev: the platform_device description.
  *
  * Return:
- * 	On success, 0. On failure, -errno.
+ *	On success, 0. On failure, -errno.
  */
 static int ftpm_tee_probe(struct platform_device *pdev)
 {
@@ -302,7 +302,7 @@ static int ftpm_tee_probe(struct platform_device *pdev)
  * @pdev: the platform_device description.
  *
  * Return:
- * 	0 always.
+ *	0 always.
  */
 static int ftpm_tee_remove(struct platform_device *pdev)
 {
@@ -323,7 +323,7 @@ static int ftpm_tee_remove(struct platform_device *pdev)
 	/* close the context with TEE driver */
 	tee_client_close_context(pvt_data->ctx);
 
-        /* memory allocated with devm_kzalloc() is freed automatically */
+	/* memory allocated with devm_kzalloc() is freed automatically */
 
 	return 0;
 }
-- 
2.20.1

