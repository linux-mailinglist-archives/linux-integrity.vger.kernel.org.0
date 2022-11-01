Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47999614303
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 03:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiKACEb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Oct 2022 22:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiKACEa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Oct 2022 22:04:30 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F222DE9
        for <linux-integrity@vger.kernel.org>; Mon, 31 Oct 2022 19:04:29 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d25so21428042lfb.7
        for <linux-integrity@vger.kernel.org>; Mon, 31 Oct 2022 19:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEOfG8FISec8dD0CD8AC77q2u56LHquBLj1RJNx5Usc=;
        b=QU29yDlELEUuuRWj1upBQXU7weViRCr1RNj7th0kF4mtd+S6H8Ya+btyUKRBnNTKYm
         I7ZpQkDUrO7pe2kX0tX8FVat5xexlVGPoI/XPDudIwAqflSSPNzOas6BjnDsLVqSeeEw
         T+JVjZNiDnyMRes6ghgSTbvtQltFlB5WzOW0uQnUSgB4JOUauC+oVDQM1C6EdgyXc24t
         NOGhXCRsyXEl+h0u6uNbE9NFZ70JL8mDlLJ41xuTdMXre5/2XW7fVe3qX/a8PS3jntRr
         1JAIP8CisWDOV4p0aHqxaD8CS/Fyl7Iz659W1T5HiJ/6WuuluqGwGwE1eS82OMIVl84I
         ub2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEOfG8FISec8dD0CD8AC77q2u56LHquBLj1RJNx5Usc=;
        b=xF45kVk8OKWj3X+0+8TxozUQF+y6/lW0BKDZTeBk3geh+Jjs9oVf3QaQW0bdT/vZFP
         BkNwdrc1gIGJzB3F702b8dYWrmvC/JM4wEnoZHSj63S+GaIMxtkLtvwY3LsDdqtEa5yF
         CX5EkEjybF1GF3G7170UXcshACKmhmCj4H3ZTek5JP+RjetbcvdnEBmmogc7y3SKycWy
         kLBVZ/As9xfgCIJPFcUU3uFZk7bjtaeV3alYfN9+870uAgWZcr5VMCXcd0wwgsDnymLn
         0xUq+7NTqkV4pMh/d6qeHIY5eZ6YiBI8/AmAVoVIESlO39YntoyaD1vdKstDcAMNb0OM
         JnYw==
X-Gm-Message-State: ACrzQf0rHyyhNw9c35GsDqB50MwiSI1ahdaMVw6GzyY86wLQGISiVOA6
        sa0ie5KZs9MI9Geo2to/h6GtZRK1/b717zcmDG8=
X-Google-Smtp-Source: AMsMyM7o1nsgVCD+ml2o5UYPFBx/F16nVtNQd/tilk04HXeS6xjthgIOd1iyxgIYtANfHmQMgh4iiw==
X-Received: by 2002:a05:6512:3a86:b0:4ad:23ac:94de with SMTP id q6-20020a0565123a8600b004ad23ac94demr6932543lfu.70.1667268267198;
        Mon, 31 Oct 2022 19:04:27 -0700 (PDT)
Received: from dabros-l.roam.corp.google.com ([185.157.14.92])
        by smtp.gmail.com with ESMTPSA id k11-20020ac257cb000000b00494942bec60sm1508799lfo.17.2022.10.31.19.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 19:04:26 -0700 (PDT)
From:   Jan Dabros <jsd@semihalf.com>
To:     linux-integrity@vger.kernel.org, jarkko@kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        arnd@arndb.de
Cc:     rrangel@chromium.org, timvp@google.com, apronin@google.com,
        mw@semihalf.com, upstream@semihalf.com, jsd@semihalf.com
Subject: [PATCH 1/3] char: tpm: Protect tpm_pm_suspend with locks
Date:   Tue,  1 Nov 2022 03:03:50 +0100
Message-Id: <20221101020352.939691-2-jsd@semihalf.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221101020352.939691-1-jsd@semihalf.com>
References: <20221101020352.939691-1-jsd@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently tpm transactions are executed unconditionally in
tpm_pm_suspend() function, what may lead to races with other tpm
accessors in the system.

Add proper locking mechanisms by calling tpm_try_get_ops() which is a
wrapper on tpm_chip_start().

Signed-off-by: Jan Dabros <jsd@semihalf.com>
---
 drivers/char/tpm/tpm-interface.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1621ce8187052..d69905233aff2 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -401,13 +401,14 @@ int tpm_pm_suspend(struct device *dev)
 	    !pm_suspend_via_firmware())
 		goto suspended;
 
-	if (!tpm_chip_start(chip)) {
+	rc = tpm_try_get_ops(chip);
+	if (!rc) {
 		if (chip->flags & TPM_CHIP_FLAG_TPM2)
 			tpm2_shutdown(chip, TPM2_SU_STATE);
 		else
 			rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
 
-		tpm_chip_stop(chip);
+		tpm_put_ops(chip);
 	}
 
 suspended:
-- 
2.38.1.273.g43a17bfeac-goog

