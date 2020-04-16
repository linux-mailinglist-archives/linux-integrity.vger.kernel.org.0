Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB44B1AB4BC
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2020 02:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgDPAXc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Apr 2020 20:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729384AbgDPAX3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Apr 2020 20:23:29 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B3CC061A0C
        for <linux-integrity@vger.kernel.org>; Wed, 15 Apr 2020 17:23:29 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id z9so595488pjd.2
        for <linux-integrity@vger.kernel.org>; Wed, 15 Apr 2020 17:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q8rOvlIsPJzudF8l2xvM7KYul05YvAqoo1GTo7iiNyo=;
        b=WszjZdF7hvXKHki6EfFhdSsg6eWfzBQ8prUE4LZgaD62ZA97oEnz/xKs/c2gFSlINh
         2rn7Rm7iMdoD1s79QYgHzphENMYzkngNrgc+XoRCbQsHFBxJTDBlEPM7UD6Jc9DQr8W3
         UphjV37qvSFYKfoFSvopcMjTST3Tfgy5efo1rXRLaSjB1j5Loo7zYaMoGoFY7beyg4WC
         0w+waUZUezxrDVF/XzzQeChl3EQ8ic/q6CoPDFjMpgoYypzaJh96L34RZjmvyZWgOhf2
         th2kPcDWr27dGTu4ZYvVzTQpCIzz+Kv5OHKlJO+HmDfvuibOYeTR59Nza6FjQXS/flQ7
         89kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q8rOvlIsPJzudF8l2xvM7KYul05YvAqoo1GTo7iiNyo=;
        b=qxvO0wWVeILlBOyzLKFM6WQ9TZMCPyeghGQUJJRCXXKrJHzyvdYxl/OW/6ely+a72g
         uKFgWHJYiA4+ydvOb0Ar5AZeXLVHn2IPkx9o6Jeszpa4b0KbeeuQ/BaGj77g4psCdMbg
         zKbBNW//gR0tKtf+oZofN+9lCOF2RC3HToXCdeOM2EMNtgOwTFaEubYVgGLhWKIiXjTx
         M+cwSObR9O0UIqOpZzz2YiCssIUXEZYrY/noyS557LOeotaBMiPOuPK0ZPkscq9cavXr
         lh2ymUKD04KwPe914M2tsH2EIPACHvEpiyBoRng8wSE4lr0dMQSKkog24mEOl3ANNFGN
         Z35Q==
X-Gm-Message-State: AGi0PuYjp29xhcjMKjZrtqhEzq0HtYyW+SheRMhmpetVosLn432cFgLX
        wpTtFo7wERDBYMY47s09PJ9W2Q==
X-Google-Smtp-Source: APiQypJgK3wXES7yMoFvLBrDaa2jFWyALO6oplSC7IoLAG6mvjd6W8Kqh9JURtqGFM9yETAPpJEy8w==
X-Received: by 2002:a17:902:464:: with SMTP id 91mr7667128ple.261.1586996608912;
        Wed, 15 Apr 2020 17:23:28 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:b0c6])
        by smtp.gmail.com with ESMTPSA id k1sm13721758pgh.72.2020.04.15.17.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 17:23:28 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2] tpm_tis: work around status register bug in STMicroelectronics TPM
Date:   Wed, 15 Apr 2020 17:23:22 -0700
Message-Id: <c0ba1e2931ca7c46a21a43f2b9a6add2e188d6c8.1586996553.git.osandov@fb.com>
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
 drivers/char/tpm/tpm_tis_core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 27c6ca031e23..5a2f6acaf768 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -238,6 +238,25 @@ static u8 tpm_tis_status(struct tpm_chip *chip)
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
+		/*
+		 * The status is somehow still bad. This hasn't been observed in
+		 * practice, but clear it just in case so that it doesn't appear
+		 * to be ready.
+		 */
+		if (unlikely(status == 0xff))
+			status = 0;
+	}
 
 	return status;
 }
-- 
2.26.1

