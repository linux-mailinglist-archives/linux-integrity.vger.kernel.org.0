Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D19460082
	for <lists+linux-integrity@lfdr.de>; Sat, 27 Nov 2021 18:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbhK0RbW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 27 Nov 2021 12:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244168AbhK0R3V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 27 Nov 2021 12:29:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C848C061746;
        Sat, 27 Nov 2021 09:26:06 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id j3so26119876wrp.1;
        Sat, 27 Nov 2021 09:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r/ozYoR08H/XXW9Gao2CC3lzOc6yYZ/UMoGZeifS3Ss=;
        b=n1tLH6HOp5+n2CGCEA8o4LvlRsI+8OnwJlYyCxPPXsqtX+OFCEAj+38QewTDKd7+uw
         RIMhKluImQqvOnQDjb/viZjNrQQpV+P0DGbBwPP7dWwP7w0YnvoBFp5xlKgfZEPIm2SK
         6q+HmqVV35iNmEDkkqK8GbO4UIjSAr/BoiaDvoRjiWqngVoxd4GzD8Wbrzi0JSZEMq8O
         uOy8JIA0QgFJlTKtBGJbpaN7KngHXb3Qf/UjcIWUbieSuNPeZ3yrho+BV7N3Gt+xG6eY
         IZu/LwPqmoFViXgo1S2m0c5OTqFcruUGtjeJfRkyJ+UUjXgD+JTsqB0M+qUod34Xavh4
         N2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r/ozYoR08H/XXW9Gao2CC3lzOc6yYZ/UMoGZeifS3Ss=;
        b=Z3GoVKG6D7j3YR+Vwwst+C7zLgMR6tV20y57MxD0f/jGJNdaaXp6DELpVBCh72uJlu
         P339Adb/oufv+PdMVIcX00urcb1xirEPO1jh4s5q2i1IdyaH6nrh/TS6jQMzR0QoH6vX
         9VgCgmgmB5h71JNMmo9Z4/d0W+ugU/U7Id9Tp1v70Nvf/h2aVCQcT+7j4TgJABFTSJqO
         i/ek+f0e+Fd8P6tM6Z1g6zvY73DsDjoecDqJPtSr5axXRNXb6tDFHyQl5sjxQfHVuWpE
         n8Wlp2EYfdEzJ/C+rvqhgFTc3yrI+eppqpYHFysH+8faZJtZacWXJ4MALjp+blwgNf3n
         MuKA==
X-Gm-Message-State: AOAM530J413w01JZ04x2wO3aL0x5XDVOI9bF4vST7HpZUu2+R6tdb8tL
        eu2O85AFAGWdPA==
X-Google-Smtp-Source: ABdhPJxzt++dlNdWq40q40ITInoJudc5jVmSXPUYFSSjX9Vw6WDE0SvpssXN0Qddhzy0k/aTpSB4lg==
X-Received: by 2002:a05:6000:188c:: with SMTP id a12mr20961328wri.92.1638033965237;
        Sat, 27 Nov 2021 09:26:05 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w22sm2219198wmi.27.2021.11.27.09.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 09:26:04 -0800 (PST)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: make const pointer desc a static const array
Date:   Sat, 27 Nov 2021 17:26:04 +0000
Message-Id: <20211127172604.126322-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Make const pointer desc a static const array, removes a dereference
and shrinks object code a few bytes.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index b2659a4c4016..649b4229e76e 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -716,7 +716,7 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
 
 static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
 {
-	const char *desc = "attempting to generate an interrupt";
+	static const char desc[] = "attempting to generate an interrupt";
 	u32 cap2;
 	cap_t cap;
 	int ret;
-- 
2.33.1

