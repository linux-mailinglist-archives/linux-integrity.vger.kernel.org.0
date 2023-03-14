Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70476BA01A
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Mar 2023 20:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjCNTyd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Mar 2023 15:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjCNTyc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Mar 2023 15:54:32 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425BB211CB
        for <linux-integrity@vger.kernel.org>; Tue, 14 Mar 2023 12:54:11 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id l9so6124083iln.1
        for <linux-integrity@vger.kernel.org>; Tue, 14 Mar 2023 12:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678823650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ILXYxmnfOLR0ewM60G3euG3ql1j35ZPmWRlhkZCiP0=;
        b=b7+Z0objvds1+g+MvHWg73uKyRsDn7xQDsrO8N7y5nen+snWZz62/2DCKr+C0ayHlh
         P3qPei6OCXlzaWbzFO+MrlrP/pQ9gFRP0CCvwwwQyKWxfIavYHkST9viDLG/6R/bne43
         fBeyImX0Oa/I3zIUX1G3VttadI8Kjje6aXMZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678823650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ILXYxmnfOLR0ewM60G3euG3ql1j35ZPmWRlhkZCiP0=;
        b=6JwMvQWsSbUcliiNgDpIYGPZzjlX8j0dCsellnCZT9KIQq0caC4OqyzIkCv6NFkquV
         6ZileoNoib+ASH+klyY329VXymsHUXPuBNlNFOPSM9gwOcI5bW/5b23MNklAP3h/W3yi
         7pGojwkqVxNXrU1kb0rfsc0yDW/Ju8O5evNibUA3TJoLo9LOT1IchbHk5S+9ke53SRwS
         aReC7mkEoo3oqPihC1TwzClV15v4+mekLJtqw0Ui7gZ8i4GVpX0SXeXFn97KTvNwiSCm
         67qwuxVieVU3/GB33Re55lvgBTGQdWap2v38NAPkLa1bPWW1GDPeSw8xT247Mq2PJwvm
         vAJA==
X-Gm-Message-State: AO0yUKWDtTR3f2OyPpoifXSS97BLeUDaZ0I/97UP/mBQVFjgl1GnChGM
        HnXxVQP26q7TYzvWTGBXQx2Yjt25qvmhb/KwP3U=
X-Google-Smtp-Source: AK7set9u8J4nHcX/9iBm0CPgxbmxzUuW1WdTeigP4mZCYcQyLJQAQ77l+aELPl1OxKuxN3uk6qfJYQ==
X-Received: by 2002:a05:6e02:1c01:b0:323:ad6:5357 with SMTP id l1-20020a056e021c0100b003230ad65357mr3511492ilh.28.1678823650533;
        Tue, 14 Mar 2023 12:54:10 -0700 (PDT)
Received: from markhas1.corp.google.com ([2620:15c:183:204:da4a:3c9d:f298:5d61])
        by smtp.gmail.com with ESMTPSA id w2-20020a029682000000b00403b917f3a8sm1012718jai.56.2023.03.14.12.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 12:54:10 -0700 (PDT)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Mark Hasemeyer <markhas@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: cr50: i2c: use jiffies to wait for tpm ready irq
Date:   Tue, 14 Mar 2023 13:54:04 -0600
Message-Id: <20230314135400.1.I5561dfbc4438418281626e43e345e8acc879cd7c@changeid>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When waiting for a tpm ready completion, the cr50 i2c driver incorrectly
assumes that the value of timeout_a is represented in milliseconds
instead of jiffies.

Remove the msecs_to_jiffies conversion.

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

 drivers/char/tpm/tpm_tis_i2c_cr50.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index 77cea5b31c6e4..376ae18a04ebb 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -100,8 +100,7 @@ static int tpm_cr50_i2c_wait_tpm_ready(struct tpm_chip *chip)
 	}
 
 	/* Wait for interrupt to indicate TPM is ready to respond */
-	if (!wait_for_completion_timeout(&priv->tpm_ready,
-					 msecs_to_jiffies(chip->timeout_a))) {
+	if (!wait_for_completion_timeout(&priv->tpm_ready, chip->timeout_a)) {
 		dev_warn(&chip->dev, "Timeout waiting for TPM ready\n");
 		return -ETIMEDOUT;
 	}
-- 
2.40.0.rc2.332.ga46443480c-goog

