Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718391AB3EC
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2020 00:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387511AbgDOWpq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Apr 2020 18:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732976AbgDOWpd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Apr 2020 18:45:33 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90A4C061A0C
        for <linux-integrity@vger.kernel.org>; Wed, 15 Apr 2020 15:45:33 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g6so648273pgs.9
        for <linux-integrity@vger.kernel.org>; Wed, 15 Apr 2020 15:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hk3FQvRPPps1Uxi4cD6hTJblVzZpBfLo8gEJSgewU+k=;
        b=iJU1m8SKgYHTmnv3/nRUH7LiYPN1jT883fXNggZGozl+mR/plO1qAh72026IYeUnQe
         WEiouZLk37XHIff87PbPArkP5mnuLNhtMyeyk9oKvkz9gcJYq/XaQz8RnDp80HZ6/F/u
         EnaLMbh1EBlTCgymu60TB67+4mmk53SV5fbjO4V8bHUmkgUfYI5Mh9jCUpO0GVvj9Obn
         MBh4+NA6uUg7Wrg2jLVHXf4jsGJWYktrOQgyhzq2Fc4h6cbn5jMh1/mZl5qRaCm3fHad
         WuOS2g2Lm8Iimocfoh/W4cgX+z+OqEIIGy3YNUu0J1zMSYilcwppwrcxLcKg6pmYVqEk
         cVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hk3FQvRPPps1Uxi4cD6hTJblVzZpBfLo8gEJSgewU+k=;
        b=jjjsWi8ftviegW+Z5T4c3eqnIjYUoaPbKBS361jr/ay71kSGF/C+P6t03Z3giOL9Ga
         gAMi33dZVDfMJdpAnVHWOGqlt28bBPUu/WCcGopS50NUWvGgHAc3cVJjI3fr8KIxMBb6
         1MbDt+kXVSxig28qGPbBF376xyZMrqJpj8hfzSBedM+qVnAR2TY7jMq4xCIZUiefH5jx
         c1RaoqZ03TgPBludI4cI0wzYUwO/rfMN68+LjtBt1lhmtw0uRy6d84PaCz0riNbZMBx2
         32oIu+KdGc03PIOgKHzNMOf/1+uEAbHenbxUKtWzWCFYGQ8eAzKZLUcE5keAnCOUw1Bg
         MsfA==
X-Gm-Message-State: AGi0PuYDaXbtfwZg6cW7c0NlUG4tjxqwAGRsZyqYKSMdlYjyY9uG+fp0
        9ro/8Zq/2EIdEsbvTrcrWiW5M4yczKE=
X-Google-Smtp-Source: APiQypL0zoz0gXpIT2NtDNWV6U82yFfa3jetowhmtl+UG/LSPnz1jR69RrDC86Rv0uLPRFQEKm1s6A==
X-Received: by 2002:aa7:8a9a:: with SMTP id a26mr17134973pfc.77.1586990732972;
        Wed, 15 Apr 2020 15:45:32 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:b0c6])
        by smtp.gmail.com with ESMTPSA id j16sm12593323pgi.40.2020.04.15.15.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 15:45:32 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: [PATCH] tpm_tis: work around status register bug in STMicroelectronics TPM
Date:   Wed, 15 Apr 2020 15:45:22 -0700
Message-Id: <6c55d7c1fb84e5bf2ace9f05ec816ef67bd873e1.1586990595.git.osandov@fb.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

We've encountered a particular model of STMicroelectronics TPM that
transiently returns a bad value in the status register. This causes the
kernel to believe that the TPM is ready to receive a command when it
actually isn't, which in turn causes the send to time out in
get_burstcount(). In testing, reading the status register one extra time
convinces the TPM to return a valid value.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/char/tpm/tpm_tis_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 27c6ca031e23..277a21027fc7 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -238,6 +238,18 @@ static u8 tpm_tis_status(struct tpm_chip *chip)
 	rc = tpm_tis_read8(priv, TPM_STS(priv->locality), &status);
 	if (rc < 0)
 		return 0;
+	/*
+	 * Some STMicroelectronics TPMs have a bug where the status register is
+	 * sometimes bogus (all 1s) if read immediately after the access
+	 * register is written to. Bits 0, 1, and 5 are always supposed to read
+	 * as 0, so this is clearly invalid. Reading the register a second time
+	 * returns a valid value.
+	 */
+	if (unlikely(status == 0xff)) {
+		rc = tpm_tis_read8(priv, TPM_STS(priv->locality), &status);
+		if (rc < 0)
+			return 0;
+	}
 
 	return status;
 }
-- 
2.26.1

