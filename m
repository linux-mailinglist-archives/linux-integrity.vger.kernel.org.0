Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72CA2188B4
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jul 2020 15:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgGHNPe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jul 2020 09:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729450AbgGHNPd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jul 2020 09:15:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA49C08E763
        for <linux-integrity@vger.kernel.org>; Wed,  8 Jul 2020 06:15:33 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k4so4000948pld.12
        for <linux-integrity@vger.kernel.org>; Wed, 08 Jul 2020 06:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TkaB98nQDQAZj54VpdleIAAukarhv3l749JNi1B5PxQ=;
        b=MWS3+plUn1olq+Vl0HSnSx9XuX4+qccQPmHePb7EJ1x/+hpS5X72De+w9gp5zePmi2
         uEBEj8+vpc2d0ZmfNZEu1tR3fmnZhOyjMH+CGfPikEuRleWqZSsb83T8bG1JmRTOj3PC
         OUlziPQqB9o29Ey6JIKiRDbMkEZU02veExKlAElj9QyWRc2DhuVCqfHXzwH4JqS1Uzv7
         XVI+mgUKRw4/U7uBudtvva9dc2A9QC6hak0Shp8idznMrB8p4oHtrXgztaxFurPnbKek
         tx1HungF0YCw9Q6kraf4iK64nLxrK7mltzcVpd95MsBgh093XGC8AlO3r8IautX/orHp
         +aSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TkaB98nQDQAZj54VpdleIAAukarhv3l749JNi1B5PxQ=;
        b=iOkRjzrMohw6x8akWA68TYZi3u4dFkWZAgETKoXPfX74Y+KmdQO45AvWGo198ereuP
         zjuyZ0TQm86t6GmTenEDxH9FMstZ3rs6jgyO0gd9LBuKOdsCETakoVKdZYKoQ04IBCEJ
         BIIDUli9NCU6kY6A4pAsMEg16TMR+0PdhavBQia4oim8dbb1p4m+G9EcJGmnoOvEid19
         68FJXJJfycNr60Jq8sZrr5rnikUYaO02J6Bv6j4lHmFJiZ2ag4Y+wgvKE01LzrwiZrtc
         5XCYNcOvrJxMbScJ3aanbydfmdpFNWpzNFaXafAbq0C8m2SlWVTc5Tbw3dFuP3m8SpL/
         9oNQ==
X-Gm-Message-State: AOAM531oABfvk3yfVu/NMf2c3y+d8AZgwb2ZDXRC481xj5108jYiVGko
        9nGULRkhwxguOYQNNR9rU3ZKlw==
X-Google-Smtp-Source: ABdhPJySUm0xfOTXmzrFgBr8CFij0vt7Ulz8YKPVEAGa5Pv1sa2H7kaBEkbqYnBp9p21gKkAyuCYLw==
X-Received: by 2002:a17:902:bd97:: with SMTP id q23mr46309205pls.251.1594214133211;
        Wed, 08 Jul 2020 06:15:33 -0700 (PDT)
Received: from debian.flets-east.jp ([2400:2411:502:a100:c84b:19e2:9b53:48bb])
        by smtp.gmail.com with ESMTPSA id y63sm4096366pgb.49.2020.07.08.06.15.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 06:15:32 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     masahisa.kojima@linaro.org, jarkko.sakkinen@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 2/2] dt-bindings: Add SynQucer TPM MMIO as a trivial device
Date:   Wed,  8 Jul 2020 22:14:24 +0900
Message-Id: <20200708131424.18729-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200708131424.18729-1-masahisa.kojima@linaro.org>
References: <20200708131424.18729-1-masahisa.kojima@linaro.org>
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

