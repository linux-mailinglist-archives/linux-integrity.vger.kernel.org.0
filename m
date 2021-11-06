Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94614446F03
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Nov 2021 17:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhKFQou (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 6 Nov 2021 12:44:50 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:53296 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbhKFQou (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 6 Nov 2021 12:44:50 -0400
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id jOlYmPHM52lVYjOlZmW5Cp; Sat, 06 Nov 2021 17:42:06 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 06 Nov 2021 17:42:06 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        hao.wu@rubrik.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] tpm_tis: Fix an error handling path in 'tpm_tis_core_init()'
Date:   Sat,  6 Nov 2021 17:42:04 +0100
Message-Id: <7391611c2f2c5ca9fcea5b960fe6f7cac12121f4.1636216848.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Commit 79ca6f74dae0 ("tpm: fix Atmel TPM crash caused by too frequent
queries") has moved some code around without updating the error handling
path.

This is now pointless to 'goto out_err' when neither 'clk_enable()' nor
'ioremap()' have been called yet.

Make a direct return instead to avoid undoing things that have not been
done.

Fixes: 79ca6f74dae0 ("tpm: fix Atmel TPM crash caused by too frequent queries")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/char/tpm/tpm_tis_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index b2659a4c4016..e672d2dc8937 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -952,7 +952,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 
 	rc = tpm_tis_read32(priv, TPM_DID_VID(0), &vendor);
 	if (rc < 0)
-		goto out_err;
+		return rc;
 
 	priv->manufacturer_id = vendor;
 
-- 
2.30.2

