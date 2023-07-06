Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF3E74A449
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Jul 2023 21:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjGFTO2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Jul 2023 15:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjGFTO1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jul 2023 15:14:27 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C721B1BDB;
        Thu,  6 Jul 2023 12:14:25 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so1671619e87.0;
        Thu, 06 Jul 2023 12:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688670864; x=1691262864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knhfEEL6pgJDiH6jDH9axq86hl1v5IF4lIkzXelYSDY=;
        b=PGeS5SArw9ya3mfRNoD2y1rbKTvOeqhVsjLKCjfq/N+azCAd37y+tjBo9HAxAug0yn
         V44xRpHSJreS94PEH6FAi81LTh+K5ZyhbqSKi1fGzactN5Ef3+PacdMmJN8pjf2l6zwe
         yPV7DVsTflgcnqEI6zzE3srEKI8MQ4uc3t8QsB1sDmKFG95hh2MQRM96Z0D5aMfDSXBI
         rpHI49Mu/0ANmBlzscnHbd/bk5HAIsbSCBMzMR4g5wErjuFIx47x6WNG7d4BELSKqm8G
         7Uxi8cHFpeitPDtwtwWVUNRGx6WTqndLmV6hHES9v1BWcgrPA37WxHHSkT6+eLMlXpkw
         L6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688670864; x=1691262864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knhfEEL6pgJDiH6jDH9axq86hl1v5IF4lIkzXelYSDY=;
        b=QWb3GhQYsDw5EDh6hBQQfX3XE3JUe62kejLxfhsGU/+SvlHRCqYjGFIR453zsFIMXp
         G68H0usf9eZJS842uOie8dTOWrve8TGupM/OJ/WYpBDXWxGI31lMjGWs31Kc8S+awLQv
         blmAwu/VNdnTm8UUGivPvSZm96izslOBh2rOLZfQx8FA2Kj1i1F1o6pjlPzdXFmKBiN0
         C2zUkUQEd6im73s2dbIMSd4/cKKpuwwsYqD9IHP+6NJ7X+2hC1PX43HRQZNQa3wxkh9W
         /qXBzW95ZCTOV4FqAzZeydTt+Tga5ZaeAgL/hNK7gpaGfV13AZ3DuoWZnCaoaHgtlxoO
         3EQQ==
X-Gm-Message-State: ABy/qLbPCbbcZuLba+s50UMw20K8qtwfFj6uBG//WFW1qzSbrvptsacK
        T1S+0lFi2UkAr3AQmr8yz38=
X-Google-Smtp-Source: APBJJlH201cL2j5Ew4p8ZimnPzMs1jn2Qz+PNJ9BgeJOqFBKztGVDFdRhCTBzPKQtNs3DNzPS2D9wg==
X-Received: by 2002:a05:6512:39cb:b0:4f3:93d6:f969 with SMTP id k11-20020a05651239cb00b004f393d6f969mr2377728lfu.59.1688670863666;
        Thu, 06 Jul 2023 12:14:23 -0700 (PDT)
Received: from valmont.froyen.eu ([2a01:799:ba5:6500::80f])
        by smtp.gmail.com with ESMTPSA id o23-20020a056512051700b004fbb011c9bcsm370409lfb.161.2023.07.06.12.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 12:14:23 -0700 (PDT)
From:   Valentin David <valentin.david@gmail.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Valentin David <valentin.david@gmail.com>
Subject: [PATCH v2] tpm: Do not remap from ACPI resouces again for Pluton TPM
Date:   Thu,  6 Jul 2023 21:13:40 +0200
Message-ID: <20230706191409.737080-1-valentin.david@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230701153329.6476-1-valentin.david@gmail.com>
References: <20230701153329.6476-1-valentin.david@gmail.com>
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

Signed-off-by: Valentin David <valentin.david@gmail.com>
---
v2: add missing sign-off in commit message
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

