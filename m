Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CC542640E
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Oct 2021 07:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhJHF3f (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Oct 2021 01:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhJHF3f (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Oct 2021 01:29:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591B8C061570;
        Thu,  7 Oct 2021 22:27:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k7so25741724wrd.13;
        Thu, 07 Oct 2021 22:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WzM1iYqWC83TqgteofpYEJWEho+MBqR0p/pEBHUFvzo=;
        b=JqIte8NakKnc09OiKx+/S3I1bPYMMmfVSZFLHwc3+Rr3FpSu3gUbng1tdAe6R92zxK
         NMMeNig252Lnj87nCmfuvUW9KVq6wYJTP9MmPxZG1KEe4q59eXY+Yk/Bj3Osc30MmtbC
         twyt2TrTe9/xm42SqkZwfxAKpzMVc7CuXe3KOwxy+YMoMak53hjDHeWhPmMRxKvTy0hF
         4jZelGeaO0Tn+guheF/9x3QRaHTeg6WnXdVo556ereaaekLTiZzfymTUAJO7OpIvuMW7
         Onp3Tso4QLF7lIckq1cWNyOzDmKmso5iuT6KOD/Un8gXTqfSmuJsZ3s770NJCpH2EhbE
         Hugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WzM1iYqWC83TqgteofpYEJWEho+MBqR0p/pEBHUFvzo=;
        b=gKlKG1I2gPtxRVduFY5sq5/qxEutoJi/dsngbxsqUyCzKtk1ML7gcq9zfTBD0jPw6D
         TcIpupIJbkR6csiyAAf6cS2tyMthHiESv5cfKZLHHuCbEVTVDofvzqtLxTYaHYcw78zN
         NSkhL8KJsgRfUhv8FpXSWdBDnwyPH4g9ZK1C1017kFVuKHQUW/E4dM76RlkTm17yAe/y
         om/cNG7RqWXu4KFqXgUN5vyuJl1lsUlGcsTJwIrNU+G1Ae9CJI0SzWI/SL/fNh1+AoWM
         /9ryHwhBFRjkQYP0ZD8CAzcpVkzcDjvzOVX7z6ksRFr0o/iluM12Mzcl0xd8VHcDXii/
         wGSA==
X-Gm-Message-State: AOAM531sJkcAqwIx4ApGOEc1cYCjeoPdK9VDtaDOw/sUsAAF+pg4UPM5
        bwGY28EbTLvl+ckrdkm/J2g=
X-Google-Smtp-Source: ABdhPJyAD+ueReOjPg+2+7LH24FyZ+oQR+wR2rnUh+z2ATY/waUhl5QXGHZokTEmlty3XMMuesMWXQ==
X-Received: by 2002:a5d:6ad2:: with SMTP id u18mr1445570wrw.47.1633670858969;
        Thu, 07 Oct 2021 22:27:38 -0700 (PDT)
Received: from localhost.localdomain ([197.49.35.129])
        by smtp.gmail.com with ESMTPSA id c204sm11030436wme.11.2021.10.07.22.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 22:27:38 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     sohaib.amhmd@gmail.com
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm/st33zp24: Fix typo in st33zp24.c
Date:   Fri,  8 Oct 2021 07:27:35 +0200
Message-Id: <20211008052736.629562-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Remove repeated world "device"
"datas" -> "data"

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 drivers/char/tpm/st33zp24/st33zp24.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index 4ec10ab5e576..f888624c1ae7 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -62,7 +62,7 @@ enum tis_defaults {

 /*
  * clear_interruption clear the pending interrupt.
- * @param: tpm_dev, the tpm device device.
+ * @param: tpm_dev, the tpm device.
  * @return: the interrupt status value.
  */
 static u8 clear_interruption(struct st33zp24_dev *tpm_dev)
@@ -434,7 +434,7 @@ static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
 /*
  * st33zp24_recv received TPM response through TPM phy.
  * @param: chip, the tpm_chip description as specified in driver/char/tpm/tpm.h.
- * @param: buf,	the buffer to store datas.
+ * @param: buf,	the buffer to store data.
  * @param: count, the number of bytes to send.
  * @return: In case of success the number of bytes received.
  *	    In other case, a < 0 value describing the issue.
--
2.25.1

