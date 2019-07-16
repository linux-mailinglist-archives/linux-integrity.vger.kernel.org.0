Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECF26B1FF
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 00:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfGPWpZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jul 2019 18:45:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36173 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388965AbfGPWpY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jul 2019 18:45:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so9815493pfl.3
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jul 2019 15:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n5NY9hcxy/qmq+InJeq+MZhB52hgL5/XHKuoEKWCJRY=;
        b=QQhDmz+Am7zIZWfhfkXcmZA4KTBLGRUoGtoM6MU/qb/jbJajF+li7TvgwLh/nbUZNT
         32HiuWT7lxFOy4PNA9GA48nPUnKmJFwf7Bo11YiNOfjWgG3s6g0vkINmqLZ2NxSzQgwW
         LpwQxIbjBSMF8oNuHBZJ04Clp3Ojer4C09NC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n5NY9hcxy/qmq+InJeq+MZhB52hgL5/XHKuoEKWCJRY=;
        b=he37yGm9uKKzuqtKxUQ24Le44XE4GHR6gcY7sQyI74Zl9ETiaoC+FWtAX2q0m/q6QM
         yHFtLB8bs59ALMX7lk0cqR2NzyJNWT/E4NlEXvSY4WdZBnTY7PFgwl0xltjZp6fgO09k
         DcBJxsbVzn2tragB6YMeU04Y4VBk8TAI0CYmt1t4sKPyjzLc8V+z0vHB8MbjgxdL16Br
         ayBGmADecaU6GheDa1Lr5eZQ24Tk1OWOk22tmzM37kY0aYRWNtc8MPvdo15NmbOPU961
         UEORyfikNql80tiwYqaA2rfedmaEhCKu7HcmLu23Th/E+kTT4fiXtnYtcQoePcxSDxf3
         HFNg==
X-Gm-Message-State: APjAAAV6MRLpY3dZGyMl6VlgeG3X2bdBvcEPomd+SzMdYxNcz+UhCyy4
        629xzN8E9rwEOrjF5M7LtuP6lw==
X-Google-Smtp-Source: APXvYqy9H7LyEYLNDeFy27ZQi/NQGBvJDuaRVOmlwxY2kPGjQcHSYWDcwox3EfLdlVSqYkgPX7Bgnw==
X-Received: by 2002:a17:90a:d58c:: with SMTP id v12mr38933628pju.7.1563317123728;
        Tue, 16 Jul 2019 15:45:23 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 64sm22182562pfe.128.2019.07.16.15.45.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 15:45:23 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 4/6] dt-bindings: tpm: document properties for cr50
Date:   Tue, 16 Jul 2019 15:45:16 -0700
Message-Id: <20190716224518.62556-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190716224518.62556-1-swboyd@chromium.org>
References: <20190716224518.62556-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Andrey Pronin <apronin@chromium.org>

Add TPM2.0 PTP FIFO compatible SPI interface for chips with Cr50
firmware.

Signed-off-by: Andrey Pronin <apronin@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../bindings/security/tpm/google,cr50.txt     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt

diff --git a/Documentation/devicetree/bindings/security/tpm/google,cr50.txt b/Documentation/devicetree/bindings/security/tpm/google,cr50.txt
new file mode 100644
index 000000000000..401f4ba281b7
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
+        cr50@0 {
+                compatible = "google,cr50";
+                reg = <0>;
+                spi-max-frequency = <800000>;
+        };
+};
-- 
Sent by a computer through tubes

