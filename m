Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C35B74DF34
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Jul 2023 22:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjGJU26 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jul 2023 16:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGJU25 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jul 2023 16:28:57 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473B2AD;
        Mon, 10 Jul 2023 13:28:56 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6fdaf6eefso76014151fa.0;
        Mon, 10 Jul 2023 13:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689020934; x=1691612934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwA4CqvxKmvSRXgeGj2yadyCOJ4Y6n3edsoObSgx8d4=;
        b=Cdbg3WzcN8W/VWeQQ49vaAlmTB8aKVQYef9AXCEh7EneO1Ufbzeoq0m4c4ePS0pijj
         CuDq6IMPiVqh8VC6KRN5IFBXOwRgb5sVm3TyTyX/EbntinrWdj3Y2PONkrBXRf0AQ2Y+
         wcm+hLMEX9Se5p7128uD5j02kn6VrBj3EKOkbb1apArMYNhu83xrRi+wRr2tCu0SDeWI
         6y/nSqv5qEZevC4tRP3tcO0ldog226UJRP5YqUkxkNr3bHFQSL71q4Ib+fx0hS2iLBqK
         ih8COm4OdSzBJpHciSa2fztN8tocQr3v64l1y9SrIlZeNSArU589egSSj9pIOOkMSYqO
         OZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689020934; x=1691612934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwA4CqvxKmvSRXgeGj2yadyCOJ4Y6n3edsoObSgx8d4=;
        b=EamBQgo3J94zrqm1R3wVjGr7FVpfMmhLkSV9JvZWDC1T9NEi5gwZkSqM2hMJ2/8j+W
         UfzLHra4jMS1q9zvgL7h39zysqQRTkVpLxxUbooLvrwQA6FDlz+gLcTgwbJoorcuwf11
         jgz2+/OZibTfvTIIgPJPvpsC9Ok5XVV4xkPEi+vNcPmeURSfeWn5hTRDX63sOs4mKwUD
         3w+Dd39QlezBxVe7N1nn8NrN+Df1NhBxl1J7Sc4jtMfC5CUz4YXIVrsj19ulOOIWm5en
         nYGCVvVRS9CLggg49xkRJrZdQzqVTN+lwTyO/+q/lJOxsRp+d2upZulGcOcQJooDXmWe
         IIYg==
X-Gm-Message-State: ABy/qLYC2R6WTutV+MIehSpZAI0timRwMMbSVUjqFuMrTZI9Yc77R1hb
        XpGC87BVO15cRQtaDZOhbXI=
X-Google-Smtp-Source: APBJJlGXpHLLHlw1nROTlf734S1oqGBDWm6C5C/qiewL6aJbndZxCQqkGJMoCyOv5gzKM7iXSRxYlA==
X-Received: by 2002:a2e:3507:0:b0:2b6:b611:64e9 with SMTP id z7-20020a2e3507000000b002b6b61164e9mr9219778ljz.52.1689020934229;
        Mon, 10 Jul 2023 13:28:54 -0700 (PDT)
Received: from valmont.froyen.eu ([2a01:799:ba5:6500::80f])
        by smtp.gmail.com with ESMTPSA id s15-20020a2e9c0f000000b002b700ca0f61sm123522lji.112.2023.07.10.13.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:28:53 -0700 (PDT)
From:   Valentin David <valentin.david@gmail.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Valentin David <valentin.david@gmail.com>
Subject: [PATCH v3] tpm: Do not remap from ACPI resouces again for Pluton TPM
Date:   Mon, 10 Jul 2023 22:27:49 +0200
Message-ID: <20230710202845.190917-1-valentin.david@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <CTYJ4KD2K9GO.25KSGPKKJSEN0@suppilovahvero>
References: <CTYJ4KD2K9GO.25KSGPKKJSEN0@suppilovahvero>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

Fixes: 4d2732882703 ("tpm_crb: Add support for CRB devices based on Pluton")

Signed-off-by: Valentin David <valentin.david@gmail.com>
---
v3: Add fixes tag
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

