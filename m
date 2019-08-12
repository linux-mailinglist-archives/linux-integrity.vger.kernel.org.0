Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAAA58AA7A
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Aug 2019 00:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfHLWga (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Aug 2019 18:36:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41108 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfHLWg3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Aug 2019 18:36:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so39852174pgg.8
        for <linux-integrity@vger.kernel.org>; Mon, 12 Aug 2019 15:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pbLJacb6MCh29sDmogMC5h9hCymvEateyvCVNbUfmp0=;
        b=AEbhrZIj9L570kQMqoryJFGF2aST4nMckbDoihfMAMRyTUCHFi6Ut0bR+e+RXtYm/U
         MXuKioSk/vI5utYPt24IRcbOVwc0DCsUn2PZKC7Ms5olCCzRtnYK5HcSKaVz06P1uSWr
         bZusf6mtHlyCAET4JMEufjD6pmZJ6MqwUKup8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pbLJacb6MCh29sDmogMC5h9hCymvEateyvCVNbUfmp0=;
        b=CZwhhKEV2AnFvlREzF72ZkVj7VIPD2Z/WfdVwZuhygCa6a+vgkuSAvQ2JJfHMqRPKS
         BtxTECDXehBp9yslj6PljbZGNN7rR+adqSd5wmUTKg6sCwp904yLvQkiVwPy7W9up3wd
         NLEnWPmnpw6RuMbPQelppZ5VXImtT0hvL2gj8ve2p4y/9VnNzHZWpzaZen5zQPjYHamE
         KN0QI9gTEVKz0WaVBuLrV1C3NVJjiBW9ui16I5iGlqUtyNpnIS/NkG6iypH8PIDyzDHO
         EHCsVhwpmgUkmoPpJ3ZdvFHwVzuP12sVe2kcescDkGJM06qT+ApDGCnxMzoafGG5Vf6v
         r1Kg==
X-Gm-Message-State: APjAAAUIvMJ8HWb4/7fhuEX3mrLTFyJBq825FWyBgJtoVLZ2+TKbhUuF
        ea/BogCf0cqs5ZxMPGHolVzvYg==
X-Google-Smtp-Source: APXvYqzmmF4BEegcpnS/e+KMA+yvCSfeLCUG6UJMXyZthuybe6012WcUe4Lc93X5m141O03baC5izQ==
X-Received: by 2002:a17:90a:c596:: with SMTP id l22mr1444056pjt.46.1565649388818;
        Mon, 12 Aug 2019 15:36:28 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b6sm93911594pgq.26.2019.08.12.15.36.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 15:36:28 -0700 (PDT)
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
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 5/6] dt-bindings: tpm: document properties for cr50
Date:   Mon, 12 Aug 2019 15:36:21 -0700
Message-Id: <20190812223622.73297-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190812223622.73297-1-swboyd@chromium.org>
References: <20190812223622.73297-1-swboyd@chromium.org>
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
Signed-off-by: Andrey Pronin <apronin@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../bindings/security/tpm/google,cr50.txt     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt

diff --git a/Documentation/devicetree/bindings/security/tpm/google,cr50.txt b/Documentation/devicetree/bindings/security/tpm/google,cr50.txt
new file mode 100644
index 000000000000..7aa65224c8b9
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
+        tpm@0 {
+                compatible = "google,cr50";
+                reg = <0>;
+                spi-max-frequency = <800000>;
+        };
+};
-- 
Sent by a computer through tubes

