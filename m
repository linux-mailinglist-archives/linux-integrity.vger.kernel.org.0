Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF0879C191
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Sep 2023 03:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbjILBUO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Sep 2023 21:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbjILBUC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Sep 2023 21:20:02 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7737E56781
        for <linux-integrity@vger.kernel.org>; Mon, 11 Sep 2023 17:53:15 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-76dbe786527so269796285a.2
        for <linux-integrity@vger.kernel.org>; Mon, 11 Sep 2023 17:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1694479924; x=1695084724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vyG3UChShGVJO9DWooQ063oFbpwzovAkingO0YTtxfI=;
        b=Zm5t3uoNcXR30eP4ZNN/fij0E0zJ4KAea+mdZVeDim8jx9l4T1hqcZ/RK2eoMHchbf
         bx569F1DL4BKBW1zbROel6bY532UxS1jA1ewg/Yb+kvDkxw6GQaVQu4CfnsNV64mNiZD
         AXaF6rk+qZf8SUpob+9p2cm4XyYnCaPy7zi0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694479924; x=1695084724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyG3UChShGVJO9DWooQ063oFbpwzovAkingO0YTtxfI=;
        b=ZD4qVpCnFmYhw0mtoSe5RQt3lHHu1hZRtyhkImNbyDFWq2Jj1zHRyGvjNi8oZDAnyU
         2dEG+5ZYznkfwTOo+yJp3gTXB5Erswcf4kqgDEPlSqF1P2ZaDVeFIPzPiPeRexzIl4Oa
         yK6QWWTq6M1ylTa/ZPCvFVEGBylqYXib3txH2ssvnmuAErvXCMqrf8xFi3Fv+9541Wsc
         c2UpvslqGd9QPs5mqEeYVDl+8+NL42UAj2sIGP6WMyPi7stWmp4TAp7mTC/4N5+Ec47O
         iUL3Semmp3fPGoOC0BSeUS4+CXjFZPhCCZXtF4rJ2Yc/PSiQfUVJPkKKoHOvLwfhXbAq
         jTWA==
X-Gm-Message-State: AOJu0Yw7I9kKVRhFixERJoBbvjGPLKo+u9FymwuFRYhBv9+dJh0fBCcb
        2mWBxF6NyELnIRHEhZOcXcF2WUhWFgC4yFOHMsTQ5uvHnPJf6A==
X-Google-Smtp-Source: AGHT+IGNNzNZoTkPqBRBvBWifr5nO33Ye5UrwbovWJsNmOlq8W6uLmJ6fD/Xbsecw0HjypP7x1zI6g==
X-Received: by 2002:aca:1a0d:0:b0:3a8:68a9:29d3 with SMTP id a13-20020aca1a0d000000b003a868a929d3mr10800812oia.19.1694471565811;
        Mon, 11 Sep 2023 15:32:45 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id l10-20020aca190a000000b003a8715d7f9esm3658017oii.19.2023.09.11.15.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 15:32:45 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
From:   "Justin M. Forbes" <jforbes@fedoraproject.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Justin M. Forbes" <jforbes@fedoraproject.org>
Subject: [PATCH] tpm: Fix typo in tpmrm class definition
Date:   Mon, 11 Sep 2023 17:32:37 -0500
Message-ID: <20230911223238.3495955-1-jforbes@fedoraproject.org>
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

