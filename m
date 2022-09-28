Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E975ED3FA
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Sep 2022 06:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiI1ElV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Sep 2022 00:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiI1ElT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Sep 2022 00:41:19 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CC19B879;
        Tue, 27 Sep 2022 21:41:15 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id w2so11543919pfb.0;
        Tue, 27 Sep 2022 21:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=fmTTNMO6nsNe3wwRALCsW2vgWT26jAViSTGEkQkN2xQ=;
        b=jxBQhnmvzqGCDopGTTWap7p3CfH89/qdhBvA2jCdFcstc30gbSfpozgkE6NAT1Gj+H
         5BSTzGE4t/RVKqSbRykONVgD7iltxOf3qRrk3riU+UA9DIhHHbNmOCyZ8gMUajW+HZVI
         NLP2WTJUS9/Ub71qoV7HKTiD4InpViwiixbdUHymIVZFo07b7pNhSs6ruIc+oSTJ5zZo
         ndGfqN+oVLod8oJMo9TIKFG3HIgXZOunjqLB1lcc6lvhrfZxn8jUPT71+VxHuSR8Mtsm
         VIE4HuJIp517+WIPEO1xSSvHX5Gn9wt+PfKDH8FI3Trhl4DyUf0VwnBNNRPAIgfoIMUi
         iZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=fmTTNMO6nsNe3wwRALCsW2vgWT26jAViSTGEkQkN2xQ=;
        b=e7bY1Cq407ODp3bjbEIXfGoupXMizWX8vqksvnDKZ6SbS1scJb8q3Gs1/idBrvWKW6
         mPyuZwPJHiNXs5+kJT6Kpa8jFTXkwCBmsyJbA4eUzTGjbEjT+AoCT85nggje4wWQ0b0Q
         dsS1ai/ZEt7eqR1F38+958dToFLotnDClUPp4puOik+MZg1KSlQOkeLkwW7aDAePesqZ
         KP5/d3Y2ceJUjI1uXtGpkLjQcuVahf866PZd6dfSLwC02uB/VJIGuitMe32xf7MFUQ3y
         7FqqpzwohZvM/ENg00g4rIhQsy27J2smBZvrnle28yhrsmStoMCKaxmaoggFvXTViwr1
         5waQ==
X-Gm-Message-State: ACrzQf2uf2J9Gf9MemB7bppizOKrDtyg/zRmHpRwCI9Bwo+XVAv5w2JI
        1TsQ3hm8y3SXunrxf6/YKzkwu5jklLrbkQ==
X-Google-Smtp-Source: AMsMyM6OjeMBDncKovrfBrauwsMbC7jPBrOrDGMVCCdiVbGsbmIIYeu+lFoSHceRGW54M4IlSuUhew==
X-Received: by 2002:a63:d118:0:b0:43c:1440:6486 with SMTP id k24-20020a63d118000000b0043c14406486mr27160681pgg.92.1664340074533;
        Tue, 27 Sep 2022 21:41:14 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.18])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e80800b00178ac4e70dcsm2504439plg.185.2022.09.27.21.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 21:41:13 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Rob Herring <robh+dt@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Holland <johannes.holland@infineon.com>,
        eajames@linux.ibm.com
Subject: [PATCH v2 3/3] tpm: tis-i2c: Add more compatible strings
Date:   Wed, 28 Sep 2022 14:09:57 +0930
Message-Id: <20220928043957.2636877-4-joel@jms.id.au>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220928043957.2636877-1-joel@jms.id.au>
References: <20220928043957.2636877-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The NPCT75x TPM is TIS compatible. It has an I2C and SPI interface.

https://www.nuvoton.com/products/cloud-computing/security/trusted-platform-module-tpm/

Add a compatible string for it, and the generic compatible.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/char/tpm/tpm_tis_i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index 0692510dfcab..4af27b7ec5b1 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -368,6 +368,8 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
 #ifdef CONFIG_OF
 static const struct of_device_id of_tis_i2c_match[] = {
 	{ .compatible = "infineon,slb9673", },
+	{ .compatible = "nuvoton,npct75x", },
+	{ .compatible = "tcg,tpm-tis-i2c", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
-- 
2.35.1

