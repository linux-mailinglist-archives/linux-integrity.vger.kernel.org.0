Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3933B9738
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Sep 2019 20:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406582AbfITScp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Sep 2019 14:32:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45011 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406279AbfITSco (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Sep 2019 14:32:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id q21so5039774pfn.11
        for <linux-integrity@vger.kernel.org>; Fri, 20 Sep 2019 11:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oyE0lW4jziioV/J2I+7J0Vx8oaL6QC9YS1SJmLa32Os=;
        b=E2eibxj8my5Dp1jxc+KoYQACiZUC0OFoR9GaGM/J3hIS0zRM4vSRbkysgba9lXdTZL
         xTdQ7FDQwPL9Ih3+86mwVQMtG0mMaoDjt3NVu9Cwmb7n+GUycQ2UgmVgOZz83WZHf/52
         /GznKVv8v3jAxGvGSRakY9iH/C3Uciv4mMza8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oyE0lW4jziioV/J2I+7J0Vx8oaL6QC9YS1SJmLa32Os=;
        b=S14N4/yoYP+KNOtyIrg6l8JhtzBsy7HWGJ9RHajJMgt98Yo//LRk5UEV4NCjxcvaFN
         EEcn0NNV5mYq+aOVHmVOWzkLIx0eSbFzxSJ9eMehjw8zsIj9k2rl8w9cOPbAFIY5P1Nc
         3oW8DArMFLEnU1FhKHDCPaBMjG4qelG6hJ9MaN0AxqZYUuU7HPpn1RmfiBY0/wDRrw5n
         odOxI37CCZ+rfCLDHJY5Y54KIgr/Op2fdYdqKwVx8XOvBj4IGI2Q06c0tr3yIQ5t6MHb
         Q+t5AtBHfWPqira5CWNdbaFhsJLO+30G/tSWOJ3JE3DJUsw8uO0whrbQJ3I+mWA85pmU
         9QPg==
X-Gm-Message-State: APjAAAWMc+dpvn2PnrFJOZzBonCHALovp/jj5jVbAz2gwpafDlETzWlz
        HbCybh2rL4V0v+kFY1j0ljiOmg==
X-Google-Smtp-Source: APXvYqyEpnhnEiGd4gIQfC2yEjPQ+Cs/cq/kw9SdUkcIz7yiWyUxh4iISf5kbtfmrVH3anNGaf7eXg==
X-Received: by 2002:a62:7d8c:: with SMTP id y134mr19187475pfc.257.1569004363189;
        Fri, 20 Sep 2019 11:32:43 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b69sm4436072pfb.132.2019.09.20.11.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 11:32:42 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>
Subject: [PATCH v7 1/6] dt-bindings: tpm: document properties for cr50
Date:   Fri, 20 Sep 2019 11:32:35 -0700
Message-Id: <20190920183240.181420-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
In-Reply-To: <20190920183240.181420-1-swboyd@chromium.org>
References: <20190920183240.181420-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Andrey Pronin <apronin@chromium.org>

Add TPM2.0 PTP FIFO compatible SPI interface for chips with Cr50
firmware.

Cc: Andrey Pronin <apronin@chromium.org>
Cc: Duncan Laurie <dlaurie@chromium.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Andrey Pronin <apronin@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../bindings/security/tpm/google,cr50.txt     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt

diff --git a/Documentation/devicetree/bindings/security/tpm/google,cr50.txt b/Documentation/devicetree/bindings/security/tpm/google,cr50.txt
new file mode 100644
index 000000000000..cd69c2efdd37
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/google,cr50.txt
@@ -0,0 +1,19 @@
+* H1 Secure Microcontroller with Cr50 Firmware on SPI Bus.
+
+H1 Secure Microcontroller running Cr50 firmware provides several
+functions, including TPM-like functionality. It communicates over
+SPI using the FIFO protocol described in the PTP Spec, section 6.
+
+Required properties:
+- compatible: Should be "google,cr50".
+- spi-max-frequency: Maximum SPI frequency.
+
+Example:
+
+&spi0 {
+	tpm@0 {
+		compatible = "google,cr50";
+		reg = <0>;
+		spi-max-frequency = <800000>;
+	};
+};
-- 
Sent by a computer through tubes

