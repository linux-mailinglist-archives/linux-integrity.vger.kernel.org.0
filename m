Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B4F6C0249
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Mar 2023 15:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCSOOB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 19 Mar 2023 10:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCSOOA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 19 Mar 2023 10:14:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB71014E9A
        for <linux-integrity@vger.kernel.org>; Sun, 19 Mar 2023 07:13:58 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eg48so37317708edb.13
        for <linux-integrity@vger.kernel.org>; Sun, 19 Mar 2023 07:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679235237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5h5ofl9KKUhrjR7negFQ4f5ler/o7Dhg36fLIrhRAc=;
        b=Ai7++6+aY05cVSDp59+T7LeeF+Cun1dhLEcqFosyhAc7I034fOOznPXcVIQlrfl1D4
         lqnGnSZewjrygIFJxoPDi4H16xWzFCfbg30AeW0+AJo8B9uIl2uzFpcIAFX6+lD8mCgr
         Z+C9Yhe032vSB9NsHf4MN7kipOjbk/BYbrYb+lKlAWW7ZX6HlVRUilNo1n2JZ+CB+mI0
         /p7S0TugbN6YdU3J0DwzDmDHioac3LQMqturckMbbK9K/kaS5PKuE77wi5bZEscaHoYz
         l891EVtKKQC47NR/0FBw5g1zsziJ6hkSXRjWJ6++bR3vygzJlmhuXimU9aTFf7DF62lW
         zNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679235237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5h5ofl9KKUhrjR7negFQ4f5ler/o7Dhg36fLIrhRAc=;
        b=F7Cqr+dEnO1VmbvCQOGlvk7JImJSDFMxVaWykn4vmoZhn6KzrciuxHQEPxGM+wmUTc
         3KJz3CngEoyhPu+cb2vzRNV95wU7CutAKvDPxnjoEZdmfBHs69wJGORyA1audAYVGnQt
         9RuonSgMI8/fXerxo0X538Fz8Tz8qxat1qnGpt4kpvonvTZD+9xGQKXsdsJ9Vg4uVeWH
         zfvr/PDgrOl6ioFK0pHE3/lDYYlks09cR7SCcwMwPvr66zPI1kMU+BMbW7mglsrMKW9w
         Rh0IQAAhyabcTVhRworZ/vf4yfpTdroy2HRbW+ByzGKPAmLK4o3KEPRxcBHGsfkP0nYo
         s7uw==
X-Gm-Message-State: AO0yUKV3x/xrLcw4aV6Hf17Fbs/FbpE7e6KhcEGpHXQo6E/FbcaqPWNn
        HCu/k/lM1tZWrmULW7I8CQ21CMI/qwncA1mTY+w=
X-Google-Smtp-Source: AK7set9VLgLOFLpI9k8tMUp+EUnJsYP+QKe0Ps442caQ2pD4i0SM2QXtqQduQ+MgDAWL/o+RJWkYfQ==
X-Received: by 2002:aa7:cc09:0:b0:4fc:e605:556a with SMTP id q9-20020aa7cc09000000b004fce605556amr9678786edt.5.1679235237279;
        Sun, 19 Mar 2023 07:13:57 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id t21-20020a50d715000000b004af7191fe35sm3540689edi.22.2023.03.19.07.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 07:13:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] tpm: st33zp24: Mark ACPI and OF related data as maybe unused
Date:   Sun, 19 Mar 2023 15:13:53 +0100
Message-Id: <20230319141354.22907-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The driver can be compile tested with !CONFIG_OF or !CONFIG_ACPI making
unused.  This fixes compile tests with W=1 by annotating device ID table
as possibly unused:

  drivers/char/tpm/st33zp24/i2c.c:141:34: error: ‘of_st33zp24_i2c_match’ defined but not used [-Werror=unused-const-variable=]
  drivers/char/tpm/st33zp24/spi.c:258:34: error: ‘of_st33zp24_spi_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Enhance commit msg.
---
 drivers/char/tpm/st33zp24/i2c.c | 4 ++--
 drivers/char/tpm/st33zp24/spi.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2c.c
index c4d0b744e3cc..2d28f55ef490 100644
--- a/drivers/char/tpm/st33zp24/i2c.c
+++ b/drivers/char/tpm/st33zp24/i2c.c
@@ -138,13 +138,13 @@ static const struct i2c_device_id st33zp24_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, st33zp24_i2c_id);
 
-static const struct of_device_id of_st33zp24_i2c_match[] = {
+static const struct of_device_id of_st33zp24_i2c_match[] __maybe_unused = {
 	{ .compatible = "st,st33zp24-i2c", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, of_st33zp24_i2c_match);
 
-static const struct acpi_device_id st33zp24_i2c_acpi_match[] = {
+static const struct acpi_device_id st33zp24_i2c_acpi_match[] __maybe_unused = {
 	{"SMO3324"},
 	{}
 };
diff --git a/drivers/char/tpm/st33zp24/spi.c b/drivers/char/tpm/st33zp24/spi.c
index 2154059f0235..f5811b301d3b 100644
--- a/drivers/char/tpm/st33zp24/spi.c
+++ b/drivers/char/tpm/st33zp24/spi.c
@@ -255,13 +255,13 @@ static const struct spi_device_id st33zp24_spi_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, st33zp24_spi_id);
 
-static const struct of_device_id of_st33zp24_spi_match[] = {
+static const struct of_device_id of_st33zp24_spi_match[] __maybe_unused = {
 	{ .compatible = "st,st33zp24-spi", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, of_st33zp24_spi_match);
 
-static const struct acpi_device_id st33zp24_spi_acpi_match[] = {
+static const struct acpi_device_id st33zp24_spi_acpi_match[] __maybe_unused = {
 	{"SMO3324"},
 	{}
 };
-- 
2.34.1

