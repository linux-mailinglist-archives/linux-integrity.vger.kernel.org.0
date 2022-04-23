Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D8A50CBE6
	for <lists+linux-integrity@lfdr.de>; Sat, 23 Apr 2022 17:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiDWPpw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 23 Apr 2022 11:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiDWPpv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 23 Apr 2022 11:45:51 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CE42AE01;
        Sat, 23 Apr 2022 08:42:53 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x18so15037897wrc.0;
        Sat, 23 Apr 2022 08:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yMZzg60G1r0O+zhJPETceGTDi3cD9NRSXbJnU2icLjg=;
        b=qI/HvanJmIe5IQfPWxxSghqXfQ19PzOOPY5ROUHdV4TgmPwyzKLjHSIymZCv3nMUt4
         WY/+VQUdJUSmDN+jnmnsDplUuk3Pd7+vYpC23V7xEejA+3OYhHWjv6AwPBut4WisOzkl
         JIaFLhyhT8Ufpi7GtZMaaz5xBtXAT/+v4DDnFkvC2nZ68G9qhGM+bj81iemNjj5tTQRv
         jbnEvLxkm8uROWTSFiVpIaT2eAN5Cjdw0X2EkYU3s7EsZyGWG4QhwtG6YC3ZY0Y7m0tH
         PhWJhp6cAaDqPSP7gfnsbc59li4rf9UI7SQcHr8Dd997+4UJwHgFLzNcpRzGy/UQYasX
         XyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yMZzg60G1r0O+zhJPETceGTDi3cD9NRSXbJnU2icLjg=;
        b=sBjuM0fhWJ1dyP9Mnp/K9Is8odzg/qPkUUY9xNXSrOCOgaExc9nnaN0GVFSWIqT6f0
         2PZc32HfewzrestJ4XnwyDIoN01Dl0BNk8dXng1X4n/kflrSH2z7eiuu5gr+IUyKfNup
         zdwqA0HdpPsjYG3hJQQYsORDmbiE3jCCCpiuq1SAXUh/YfRdQbHw+1ojLMHQUYNLj1jo
         ZvA+an1MA87g2RxRW/2RLLTrYWftnb8ZQFmqqvUmSIAytBs1FP48NlWOaXaJBXeG9LhJ
         ZVQaotq4nNonAN2m2UrsRVvu589FEKsjF8nQWtYZB9G4NXX8T6FQ0EtBM54jcHBIw6JZ
         kXsg==
X-Gm-Message-State: AOAM530WHK7YrgOM7XEZI6ep0l44MDJTOR/mk2E/1oxeM8Y9QuIQ4Tqm
        1jjsCMnNc5hXgnrwiJB2dci0E0upL/H2Kw==
X-Google-Smtp-Source: ABdhPJzigspIO+nCb4TJCNeuyV0FmGg5etBtsR3yKIinZAZn7mlaGENk+ItIS6su47dD4tXyRCfeSg==
X-Received: by 2002:a05:6000:1c0b:b0:20a:855e:1272 with SMTP id ba11-20020a0560001c0b00b0020a855e1272mr8049143wrb.261.1650728572528;
        Sat, 23 Apr 2022 08:42:52 -0700 (PDT)
Received: from localhost.localdomain (93-41-17-143.ip79.fastwebnet.it. [93.41.17.143])
        by smtp.gmail.com with ESMTPSA id t2-20020a1c4602000000b003917d43d339sm7288766wma.4.2022.04.23.08.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 08:42:52 -0700 (PDT)
From:   Alberto Solavagione <albertosolavagione30@gmail.com>
To:     zohar@linux.ibm.com
Cc:     scovottodavide@gmail.com, dmitry.kasatkin@gmail.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alberto Solavagione <albertosolavagione30@gmail.com>
Subject: [PATCH 1/2] clk-bcm2835: use subsys_initcall for the clock driver when IMA is enabled
Date:   Sat, 23 Apr 2022 11:42:29 -0400
Message-Id: <20220423154229.3620-1-albertosolavagione30@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

We are working on a RaspberryPi 4 with the rpi-5.15.y kernel and a Infineon SLB9670 TPM.
We wrote this two patches in order to fix a problem with IMA and TPM, specifically the TPM device results available when IMA is already in bypass mode.
We already opened a pull request (https://github.com/raspberrypi/linux/pull/5003) on the rpi-5.15.y branch where you can find additional, more specific, information about the problem and the solution.

Thanks for you attention,
Davide Scovotto, Master's degree Student at PoliTO,
Alberto Solavagione, Master's degree Student at PoliTO.

Co-authored-by: Davide Scovotto <scovottodavide@gmail.com>
Co-developed-by: Davide Scovotto <scovottodavide@gmail.com>
Signed-off-by: Davide Scovotto <scovottodavide@gmail.com>
Signed-off-by: Alberto Solavagione <albertosolavagione30@gmail.com>
---
 drivers/clk/bcm/clk-bcm2835.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 7112a9c4f7e3..9ed157b0a37a 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -2408,7 +2408,11 @@ static int __init __bcm2835_clk_driver_init(void)
 {
 	return platform_driver_register(&bcm2835_clk_driver);
 }
+#ifdef CONFIG_IMA
+subsys_initcall(__bcm2835_clk_driver_init);
+#else
 postcore_initcall(__bcm2835_clk_driver_init);
+#endif
 
 MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
 MODULE_DESCRIPTION("BCM2835 clock driver");
-- 
2.33.0


From aaba5263553b28540c8d5a923cadcb424d9b3d12 Mon Sep 17 00:00:00 2001
From: Scovotto Davide <scovottodavide@gmail.com>
Date: Wed, 20 Apr 2022 17:22:17 +0200
Subject: [PATCH 2/2] tpm_tis_spi_main: Force probe routine to run synchronously with driver and device registration when IMA is enabled

Co-authored-by: Alberto Solavagione <albertosolavagione30@gmail.com>
Co-developed-by: Alberto Solavagione <albertosolavagione30@gmail.com>
Signed-off-by: Alberto Solavagione <albertosolavagione30@gmail.com>
Signed-off-by: Davide Scovotto <scovottodavide@gmail.com>
---
 drivers/char/tpm/tpm_tis_spi_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index aaa59a00eeae..b6cf04812078 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -294,7 +294,11 @@ static struct spi_driver tpm_tis_spi_driver = {
 		.pm = &tpm_tis_pm,
 		.of_match_table = of_match_ptr(of_tis_spi_match),
 		.acpi_match_table = ACPI_PTR(acpi_tis_spi_match),
+#ifdef CONFIG_IMA
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
+#else
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+#endif
 	},
 	.probe = tpm_tis_spi_driver_probe,
 	.remove = tpm_tis_spi_remove,
-- 
2.33.0

