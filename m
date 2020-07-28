Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDAC22FFF8
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jul 2020 05:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgG1DPR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jul 2020 23:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgG1DPR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jul 2020 23:15:17 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46437C0619D2
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jul 2020 20:15:17 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id lw1so2077218pjb.1
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jul 2020 20:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PD2ZLQCvLaWVcoV1PzZsr55F59ipm51nH9LfNuI1BWE=;
        b=EjwAA3KCQnsgyym83+P1cOxkyODRcSK9IpoGYOEK8mo9VSqUL4M+G3WzSpNJSRYQA9
         y586nY0JjXTtfFnWhUCaxaE/0h4A5BMb85AH2INGsMulbg6VPaM/sY6p2gGS3DSzIqlX
         boAOW4/CtUL/7SK30IKifPmDizDBLglxmwmJh9IqHU/TYIA5Ru0CPlWcQ3nU0eQhDO5T
         Gtx4lpvl0TnG/jCP92EzfoGeSIQRbklRXSZmbE92OyLda3zwF7BtF6C/OB5EweH1I6e7
         qKnPgAMoeLt4IVhHIvneIRBJkhNGkLh9ClXVIslrK10smMjWzOTuc4hyJddRtz3Q2vDv
         XdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PD2ZLQCvLaWVcoV1PzZsr55F59ipm51nH9LfNuI1BWE=;
        b=E9MEknDzizuAB4koMUYVYw9U6RQNTLmTBr5nW2bDZ4UvwjZnrc5O0ShrDCfbX4Opov
         JC3rmMJ33L0jloP/chRNHJkXb/6p6LCb10eXbI8lx6gh1U8Aw/mKaqsBfgSi5PDWA7gX
         3MFrQr0hn3hs7P1onpUVs9ljRsxC418fJ4yVSTrCMy0X5wo/O1DeIqWEr5YTVVIWSVUK
         UkJfR6gGcE5Et7t9+IgXIVuPaOR3SyAi4fSr/stcYLl/keoZoKOfDNn+zIm+BVZkKEbI
         OQ2NoGVVSHoSMso2KSnpasuCJ4d/VllZlJAIDSwb8fU6n6F2GSJfslYWDxdELdyce+9v
         noFg==
X-Gm-Message-State: AOAM531b4F1VoHRsiBBWC4F7Jmif4/l8TcMtNlFdKqD3RuGaErrBzU75
        SJI27QT83Ls4P+3onoX++UWSyA==
X-Google-Smtp-Source: ABdhPJzhKrz0Xncjr22aQGFtwZngq8XVXIgQIPz03Ds2RskP8S8nIqrepHCZERgvSrGwYwgIXpZ4iA==
X-Received: by 2002:a17:90a:7805:: with SMTP id w5mr2362904pjk.192.1595906116854;
        Mon, 27 Jul 2020 20:15:16 -0700 (PDT)
Received: from debian.flets-east.jp ([2400:2411:502:a100:c84b:19e2:9b53:48bb])
        by smtp.gmail.com with ESMTPSA id s10sm3895285pjf.3.2020.07.27.20.15.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2020 20:15:15 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     masahisa.kojima@linaro.org, jarkko.sakkinen@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 2/2] dt-bindings: Add SynQucer TPM MMIO as a trivial device
Date:   Tue, 28 Jul 2020 12:14:32 +0900
Message-Id: <20200728031433.3370-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200728031433.3370-1-masahisa.kojima@linaro.org>
References: <20200728031433.3370-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add a compatible string for the SynQuacer TPM to the binding for a
TPM exposed via a memory mapped TIS frame. The MMIO window behaves
slightly differently on this hardware, so it requires its own
identifier.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 4165352a590a..814148939e5a 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -328,6 +328,8 @@ properties:
           - silabs,si7020
             # Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
           - skyworks,sky81452
+            # Socionext SynQuacer TPM MMIO module
+          - socionext,synquacer-tpm-mmio
             # i2c serial eeprom  (24cxx)
           - st,24c256
             # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
-- 
2.20.1

