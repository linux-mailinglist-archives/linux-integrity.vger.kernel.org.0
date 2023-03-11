Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217026B5F5F
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Mar 2023 18:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCKRuM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Mar 2023 12:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjCKRuK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Mar 2023 12:50:10 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27CB5BC87
        for <linux-integrity@vger.kernel.org>; Sat, 11 Mar 2023 09:50:05 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id da10so33204245edb.3
        for <linux-integrity@vger.kernel.org>; Sat, 11 Mar 2023 09:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678557004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6QRvqIPqhwfkaL7qJCNUGtwyaLEhOy0ZykrT/r18uU=;
        b=avy2XnQ5ee8d83UnInhhNy0BVYj7vPJIzRtKhW6y2UcEyybTuFPa1xQ56X0w4VH9zX
         rHBxtksuweWQY2ULdQsSBIUJj4fjrcyZN3vDXktUbz73hePujflqghTq7TgNrP+pzkAd
         /QtST5bdC/lI0VW/bUe+CHADE1A74/LskJ/VOVlaJH9HCMZD3su9LxMh5ZYYjh/nr2jq
         YDM0G+hnjIwFYPa9VbftDqL5iAsAul+JdiwI3NEJu0SQSlKt1xz2vEmdlVO0nnpvtIoU
         EWKd3UlZhv0H5cQBia0R8zqEIk+0VPXKpa9dtT60veKtjrN4924L3MkAtyYB62pa/8Se
         3yaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678557004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6QRvqIPqhwfkaL7qJCNUGtwyaLEhOy0ZykrT/r18uU=;
        b=ZJ2kSZMgZDWzny9VPhrz9GuUGCncauk5y72KccVng3ytb+jfqEMgf6BTrS+C868bfN
         hPjmPY798MlXHpmeQGDHRlDMLVpRxzAA6fIzNGW+cXJ9t5PVxsgSmGHFH6/VS+tzKnm7
         OCHQeKSwvomo+ZErSWhAj0naKnNaLPJbGTIofojrGHsUSiHqFIzhahtZI2ROydlpJwQg
         8IFsZ4v1JEsitZ3KAWq5iC4jYpgISt1AezueD1r5W1ePf4aMmCVo7JHvqdtTGwEEb6IU
         jWd84q0npOgbzgfIke6b4kV7XGHxTAZsdPSN+QGeOSUwBXEhDPRIqHNW6oPVX1yyWelk
         9CBg==
X-Gm-Message-State: AO0yUKVn9iTBZLvy5Gz0T1kVphb41BxNKoQGb90o+2/nwfr+FVYaAEHE
        Yip1IFzak0+4pWgRXk23vi9N6yxGHmjobkS7m5w=
X-Google-Smtp-Source: AK7set8G/4BR94DteJ8al719zG2ZLW4GhFbY4KlxWdeiielUMmGVUrP1PmeO8ZDcbEXIIrdlTQcCAA==
X-Received: by 2002:a17:907:c22:b0:919:7f81:22a8 with SMTP id ga34-20020a1709070c2200b009197f8122a8mr6980742ejc.24.1678556144183;
        Sat, 11 Mar 2023 09:35:44 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906b00c00b008c76facbbf7sm1311364ejy.171.2023.03.11.09.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:35:43 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] tpm: tpm_tis_spi: Mark ACPI and OF related data as maybe unused
Date:   Sat, 11 Mar 2023 18:35:41 +0100
Message-Id: <20230311173541.262949-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311173541.262949-1-krzysztof.kozlowski@linaro.org>
References: <20230311173541.262949-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The driver can be compile tested with !CONFIG_OF or !CONFIG_ACPI making
unused:

  drivers/char/tpm/tpm_tis_spi_main.c:234:34: error: ‘of_tis_spi_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/char/tpm/tpm_tis_spi_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index a0963a3e92bd..1f5207974a17 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -231,7 +231,7 @@ static const struct spi_device_id tpm_tis_spi_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, tpm_tis_spi_id);
 
-static const struct of_device_id of_tis_spi_match[] = {
+static const struct of_device_id of_tis_spi_match[] __maybe_unused = {
 	{ .compatible = "st,st33htpm-spi", .data = tpm_tis_spi_probe },
 	{ .compatible = "infineon,slb9670", .data = tpm_tis_spi_probe },
 	{ .compatible = "tcg,tpm_tis-spi", .data = tpm_tis_spi_probe },
@@ -240,7 +240,7 @@ static const struct of_device_id of_tis_spi_match[] = {
 };
 MODULE_DEVICE_TABLE(of, of_tis_spi_match);
 
-static const struct acpi_device_id acpi_tis_spi_match[] = {
+static const struct acpi_device_id acpi_tis_spi_match[] __maybe_unused = {
 	{"SMO0768", 0},
 	{}
 };
-- 
2.34.1

