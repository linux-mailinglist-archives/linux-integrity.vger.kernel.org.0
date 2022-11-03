Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC993618041
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 15:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiKCO4C (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 10:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiKCOzr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 10:55:47 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149A11A201
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 07:55:27 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p8so3222288lfu.11
        for <linux-integrity@vger.kernel.org>; Thu, 03 Nov 2022 07:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEOfG8FISec8dD0CD8AC77q2u56LHquBLj1RJNx5Usc=;
        b=p6+vbSXy9L4H3XzkDCfcuzje1tN6xEUcMCkzn0XRDrsn73geORp/F3ccOZ9PvPyPiQ
         Sv1BwBP8RxGDGA4+iFppn9mUb6C3EV4Kl5S7LQ5vxYRiIeQFUsQjFyK0sQbYrzbV3oKk
         RS07WEhJAISN+0b12N+1KRc04N4DinEzOjF4VkqeGStRIWxpCs2LhF3jqLF7BfnzOc46
         pD9yurIKvrm9AMJPx3NEl862Sjb9LdeBsA2wVaFMZEMZmabk8aC08UOQyW9g/bRZ+oQr
         CnRHD27fn/p+6Bm4S/uEhFIPXNAbCvHMrSoxitX9dK5JBvAKliAcAs7XjxJRJNtt9Qnc
         C54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEOfG8FISec8dD0CD8AC77q2u56LHquBLj1RJNx5Usc=;
        b=fjf0w5tTd/KePFMZ+LGEj1kVv7Ar32BhslM+04pB7sKA6VvabfPVqEcPUSvYXegKql
         H8WHNFe5iV5IsbSpCs1phWJid3S/W/pfvlESXuYH5WaTChGmEdUQafEhCJ1iG2p3G58K
         4AElJAMQRI1zGih++Mhn5pNiY6N+hII5caCakp3pDcrwpvMNM1HZ61PSNrAZMozxGWCp
         ybf3anhfcCJessqaLSPLeM4NaWIgAL1+KQL3krXGtJDXY3YVXZ2YI35FmKTPKAM3oczs
         8F7C4bbfuV1t+msC+j8rmk5OE0ZMnbjsI28xeuoqPB0foJ3FfRlO09lgD6CtIdo/h2NL
         N6Eg==
X-Gm-Message-State: ACrzQf3ERTcjnLiUEgRdV93tMxZQ+TE/hEUx8Lr/uBg1gQf5TByFQW7e
        vuFBL9Tdv4J4tSFLKlwF+aWLBww0fGyr0KgI
X-Google-Smtp-Source: AMsMyM7MScLKgj/jkNTw/zOcvOUCyvdRl2SVgGTsac92sKcCBCyoEyJ6Gho5fdOXAFm04o46R0l0Sw==
X-Received: by 2002:ac2:5204:0:b0:4b0:678:20d7 with SMTP id a4-20020ac25204000000b004b0067820d7mr12166417lfl.675.1667487325167;
        Thu, 03 Nov 2022 07:55:25 -0700 (PDT)
Received: from dabros-l.wifi.semihalf.net ([83.142.187.86])
        by smtp.gmail.com with ESMTPSA id x4-20020a056512078400b0049c29389b98sm154878lfr.151.2022.11.03.07.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 07:55:24 -0700 (PDT)
From:   Jan Dabros <jsd@semihalf.com>
To:     linux-integrity@vger.kernel.org, jarkko@kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        arnd@arndb.de
Cc:     rrangel@chromium.org, timvp@google.com, apronin@google.com,
        mw@semihalf.com, upstream@semihalf.com, jsd@semihalf.com
Subject: [PATCH v2 1/3] char: tpm: Protect tpm_pm_suspend with locks
Date:   Thu,  3 Nov 2022 15:54:48 +0100
Message-Id: <20221103145450.1409273-2-jsd@semihalf.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221103145450.1409273-1-jsd@semihalf.com>
References: <20221103145450.1409273-1-jsd@semihalf.com>
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

