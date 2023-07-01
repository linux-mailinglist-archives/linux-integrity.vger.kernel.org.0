Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DB7744A45
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Jul 2023 17:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjGAPeE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 1 Jul 2023 11:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGAPeD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 Jul 2023 11:34:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAC08F;
        Sat,  1 Jul 2023 08:34:00 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb41682472so4623789e87.2;
        Sat, 01 Jul 2023 08:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688225638; x=1690817638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=880KZF/bF7Pq2RTuRW+0pg3Ip+SR1DYzPUOsvKeNVsM=;
        b=lyQhPqOak0+3VFs5bbpx0rCwSq46srMpfg6U2AudEA5Qkit7pkzLiXdtf3zvcoVplv
         CkltgxMlhblTxMFeayy4vLvkeI3NYwXHO5f4xAgnmMPNs0SjMIqPT+mt/hL2oJgAq6H9
         Kp5q7y6S2xjtOm4Om/bru2wGPxOok1I8tkx4oHGHQHdI2sNyYR8m6e4G/8+ABU0L1vSH
         /BZpBC0p3J4mkMU4W/XP8s5rMeSts9+1C0+4lxK14OpkCmXAgO545PAMQpdN60GHJO7v
         fObAYYTziHFO7Xwpp0VfL6T6LVj4l5XCREp5wfCTnlpQG5CXB/VY2vkU9AnleAVA0oSz
         qWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688225638; x=1690817638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=880KZF/bF7Pq2RTuRW+0pg3Ip+SR1DYzPUOsvKeNVsM=;
        b=kofu06I5bm3OuQf4BkjKQ3zpDd19OnImbzuhJlqaUWGVxwiMdf1Vt6kYXaW77/VXkj
         FdV5ID0ZkOmlZUxiXmPnNc9nFbPg8M9ecmzvRCcxwqTKZiLxoWbzRV9Iv2z8IE/LLkoh
         ZLSEbgZXeL5O83cXVoMPbiguvm3tVFv2ypyMdm0MsM0Z4giiYrj/dI/+5WSRY/Z4e6Rv
         yCCfAirbf6xAwJmgUJingC7OBShyD0ZKOhqkYHb8e1XcSv0es4qLv3TXZHBWj+PznjzK
         1IaevejYCkznAgPg6reMuL4rMAr9tvmxFvykiAMdo5QgxSO4Fajs/+JbFGtTyatCFI4v
         oJrQ==
X-Gm-Message-State: ABy/qLaGAw/KXo4GSfb9APpFNxO2etsDyEjDPUFkzdmXh+pmKaxMk6TF
        92DSXXsRPllcnt7ombiguG8=
X-Google-Smtp-Source: APBJJlE3Jfw/gE1TQQQKMseHw0V7j4sMBh55RijAtpWxnofbU+lbA1ULH1dDGJzGzV/ydyR/Y1nUBA==
X-Received: by 2002:a05:6512:31d6:b0:4fb:96ed:93b3 with SMTP id j22-20020a05651231d600b004fb96ed93b3mr5546131lfe.65.1688225637491;
        Sat, 01 Jul 2023 08:33:57 -0700 (PDT)
Received: from valmont.froyen.eu ([2a01:799:ba5:6500::80f])
        by smtp.gmail.com with ESMTPSA id y16-20020a197510000000b004fba5eb0a64sm899778lfe.42.2023.07.01.08.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 08:33:57 -0700 (PDT)
From:   Valentin David <valentin.david@gmail.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        valentin.david@gmail.com
Subject: [PATCH] tpm: Do not remap from ACPI resouces again for Pluton TPM
Date:   Sat,  1 Jul 2023 17:33:29 +0200
Message-ID: <20230701153329.6476-1-valentin.david@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
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

For Pluton TPM devices, it was assumed that there was no ACPI memory
regions. This is not true for ASUS ROG Ally. ACPI advertises
0xfd500000-0xfd5fffff.

Since remapping is already done in `crb_map_pluton`, remapping again
in `crb_map_io` causes EBUSY error:
```
[    3.510453] tpm_crb MSFT0101:00: can't request region for resource [mem 0xfd500000-0xfd5fffff]
[    3.510463] tpm_crb: probe of MSFT0101:00 failed with error -16
```
---
 drivers/char/tpm/tpm_crb.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index d43a0d7b97a8..1a5d09b18513 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -563,15 +563,18 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	u32 rsp_size;
 	int ret;
 
-	INIT_LIST_HEAD(&acpi_resource_list);
-	ret = acpi_dev_get_resources(device, &acpi_resource_list,
-				     crb_check_resource, iores_array);
-	if (ret < 0)
-		return ret;
-	acpi_dev_free_resource_list(&acpi_resource_list);
-
-	/* Pluton doesn't appear to define ACPI memory regions */
+	/*
+	 * Pluton sometimes does not define ACPI memory regions.
+	 * Mapping is then done in crb_map_pluton
+	 */
 	if (priv->sm != ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON) {
+		INIT_LIST_HEAD(&acpi_resource_list);
+		ret = acpi_dev_get_resources(device, &acpi_resource_list,
+					     crb_check_resource, iores_array);
+		if (ret < 0)
+			return ret;
+		acpi_dev_free_resource_list(&acpi_resource_list);
+
 		if (resource_type(iores_array) != IORESOURCE_MEM) {
 			dev_err(dev, FW_BUG "TPM2 ACPI table does not define a memory resource\n");
 			return -EINVAL;
-- 
2.41.0

