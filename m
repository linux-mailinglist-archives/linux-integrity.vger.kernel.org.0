Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A226A798844
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Sep 2023 16:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243691AbjIHOG6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Sep 2023 10:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238414AbjIHOG6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Sep 2023 10:06:58 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6891BF1
        for <linux-integrity@vger.kernel.org>; Fri,  8 Sep 2023 07:06:52 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6c09f1f4610so1488817a34.0
        for <linux-integrity@vger.kernel.org>; Fri, 08 Sep 2023 07:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1694182012; x=1694786812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vyG3UChShGVJO9DWooQ063oFbpwzovAkingO0YTtxfI=;
        b=UPquD9Mpugp7mq/Z/taIlRo25AzGdeGL1C7LJlmygu4HPzinhfv/27mgKD9yvrIaJd
         pFR5QiEHtcDkY4M1is5oWDjErIhrJhgg2+qt7FMsOYGBcEBaEoKLNfHNWpTEuNZRXoxp
         JilXAz/SonvpnaqR+nxiPKi6I9SM1GRACnxkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694182012; x=1694786812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyG3UChShGVJO9DWooQ063oFbpwzovAkingO0YTtxfI=;
        b=Qf+SG8GlYuilg6cf76d7bw3WMXd+9TVIS0iwK/wBhYn0gX+RPJDN7quTJnA0kxHpSG
         DnV13XmXj5hMFfcJWXR+QAbXXM6CmYEpOCQSgfzSCs4H6zFhKstZ8dj+R387xRUCMN85
         yBVv/P7F1/04E1RO3kJbGUdKwBsCzCPS97H3AxBuYYoyYn+2wAz8ON/2+eDxeIW/POKD
         6nTiPjAjP9QRJ31Ddi10VTaomziOB0OtL1d/SUok1TSevlYVux1iPthJoVmX/9XKemA9
         HWUoP0xzBR7ginXCC2nc2mp+nVwfLhEkLQhwY3tR50Pr+YURACwFgP2w0j5tG8pAY65W
         tThA==
X-Gm-Message-State: AOJu0YxzLWJSUwNCNf8qMth4pSx3lMyiaZ8YdigPEEi9jN2XMIR3GVMx
        U6gP/Yy1cmJHH20BB4RfYAUN7A==
X-Google-Smtp-Source: AGHT+IGlGpMT8eP8hzLgjD/uwE/TSjN7En/WrHjfpuEMHJFNGdbQGIXNb7JhD/YORyT0OudSoOQaQg==
X-Received: by 2002:a05:6830:20ce:b0:6be:e447:dbd with SMTP id z14-20020a05683020ce00b006bee4470dbdmr2639358otq.22.1694182012202;
        Fri, 08 Sep 2023 07:06:52 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id s23-20020a0568301e1700b006b8c6eb962esm705759otr.52.2023.09.08.07.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 07:06:51 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
From:   "Justin M. Forbes" <jforbes@fedoraproject.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jmforbes@linuxtx.org,
        "Justin M. Forbes" <jforbes@fedoraproject.org>
Subject: [PATCH] Fix typo in tpmrm class definition
Date:   Fri,  8 Sep 2023 09:06:29 -0500
Message-ID: <20230908140629.2930150-1-jforbes@fedoraproject.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Commit d2e8071bed0be ("tpm: make all 'class' structures const")
unfortunately had a typo for the name on tpmrm.

Fixes: d2e8071bed0b ("tpm: make all 'class' structures const")
Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
---
 drivers/char/tpm/tpm-chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 23f6f2eda84c..42b1062e33cd 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -33,7 +33,7 @@ const struct class tpm_class = {
 	.shutdown_pre = tpm_class_shutdown,
 };
 const struct class tpmrm_class = {
-	.name = "tmprm",
+	.name = "tpmrm",
 };
 dev_t tpm_devt;

-- 
2.41.0

