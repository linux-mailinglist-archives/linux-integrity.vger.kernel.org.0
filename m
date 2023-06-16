Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E985733726
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jun 2023 19:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbjFPRHf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jun 2023 13:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjFPRHe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jun 2023 13:07:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5549B5;
        Fri, 16 Jun 2023 10:07:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f8fcaa31c7so3764445e9.3;
        Fri, 16 Jun 2023 10:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686935252; x=1689527252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KOyi1uZXbfS1mI0xtKCRw9/llyElWj9SgCwJLwNUQQw=;
        b=l0qC/sZ3zGBtTdAmUHs33/HYMu2KRwoOg+5n+OYYoY/S3fO179g/teTeai5O6DC0sm
         t9mTTMY90WgR4Gf1aXMhXZgEgnVEzXSN6d1YuI1xdOzxw0VeHOAevtlKXDo8tdiQhIhI
         f04+EKQd4DWBcG3v6D1w1dEOmPkS9SvL5t2/Yi3HPJUEV5ze7HgaoDQZQNDCvNZ/x4Ma
         KKjCgYiNTMUYVb1CZAM1ih9mgJCAdWIPteEf+h6BXLQtahr7m0qhT2ocMYiN+NBHlOnS
         akJXFT8j6u9v7wovHIuMRfUQgmNpRU9Cie1NEdb44WHfW4eYde8kJ3a2EZ6RV6xj6BJ6
         diIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686935252; x=1689527252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOyi1uZXbfS1mI0xtKCRw9/llyElWj9SgCwJLwNUQQw=;
        b=Avw4JFpTkN5MroqYorBHzv0J2M40JmkI5vlVPJxvUA33x1EmuxElXSFm3bRZeNQYMw
         Nq19f309Zf/3X36hZyAvRYZPZCgEC74CqO3gQ2UppBMagdGTGnBwgTPgYXbCNYA52JXS
         1bc4TkclQSrSPUekPiD3CsNpJwKmE3Zyi66hwzFXVRb0mZkB2glW3EU+PbdCkZc4QvV2
         HVLv16uk8Wnu73qlbvgskgw72kBXEItai3BzDU8xY/6i6aq350B27kOcl+HWsvrGuvdl
         t4lrVdGCw4Q6roMxeEFem6uN/TWsff0P6KAMjhj3BHLHdVK8cWJJFDbfj8tIuB2Ayv8G
         qrag==
X-Gm-Message-State: AC+VfDx9vnILLPU8Bhq8g8OCEpIZMMk99KtrqQjS2N9pt6NF1zQQIUev
        bUcbkJ9AoZdT2dHSxeR1m+w=
X-Google-Smtp-Source: ACHHUZ4An+9O4ztbGuPRvwFpgFafnFx9+qA+nzyQdD6ycg1Wum1uQEIvMbJ/Js+C2xbg9090RCZJJQ==
X-Received: by 2002:a7b:c7ce:0:b0:3f7:e80b:bfc with SMTP id z14-20020a7bc7ce000000b003f7e80b0bfcmr2415918wmk.30.1686935251990;
        Fri, 16 Jun 2023 10:07:31 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c029500b003f8d80ecc4bsm2705383wmk.34.2023.06.16.10.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 10:07:31 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] tpm: remove redundant variable len
Date:   Fri, 16 Jun 2023 18:07:30 +0100
Message-Id: <20230616170730.2343540-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Variable len is being accumulated but the value is never read. It is
redundant and can be removed. Cleans up clang scan build warning:

drivers/char/tpm/eventlog/tpm1.c:276:2: warning: Value stored to 'len' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/char/tpm/eventlog/tpm1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
index 8aa9057601d6..12ee42a31c71 100644
--- a/drivers/char/tpm/eventlog/tpm1.c
+++ b/drivers/char/tpm/eventlog/tpm1.c
@@ -251,7 +251,6 @@ static int tpm1_binary_bios_measurements_show(struct seq_file *m, void *v)
 
 static int tpm1_ascii_bios_measurements_show(struct seq_file *m, void *v)
 {
-	int len = 0;
 	char *eventname;
 	struct tcpa_event *event = v;
 	unsigned char *event_entry =
@@ -273,7 +272,7 @@ static int tpm1_ascii_bios_measurements_show(struct seq_file *m, void *v)
 	/* 3rd: event type identifier */
 	seq_printf(m, " %02x", do_endian_conversion(event->event_type));
 
-	len += get_event_name(eventname, event, event_entry);
+	get_event_name(eventname, event, event_entry);
 
 	/* 4th: eventname <= max + \'0' delimiter */
 	seq_printf(m, " %s\n", eventname);
-- 
2.39.2

