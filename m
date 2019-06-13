Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7FF44A6E
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 20:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfFMSKM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 14:10:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44110 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbfFMSJh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 14:09:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id t7so5859835plr.11
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jun 2019 11:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bvG2ZWdGwzdw20Vaj21QLD8aycjtnHcWUCoyGpGKEWY=;
        b=lzPIFdjzUR/wFnx/fMUjNPupfoWmxca3DM5UVu8+hd4R5sq7M+qvUbC8nuCpVO8lPv
         9Uj0Vm6UxWmyVZHBpiN+aUFDlfeXO3TKAyqodZOOWA11O0rRLIXCs4L3VmB04JwMf4v0
         YSq8BckegDspgDNZeogG2mhkHUr+sZrTM9M/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bvG2ZWdGwzdw20Vaj21QLD8aycjtnHcWUCoyGpGKEWY=;
        b=OuDYgqekkjZZuB4UG5x2ljeq+I5MS5ytK0l4adGvKh/CoOpGlwXWG9FUo7gP118Y2u
         r9ig1ZM329kYPM2rmPqq0C0pKbePOFFK3aDpoBDkAYrEnj4Gf13ieQh/mc8LmjcW6hiV
         MbZY/prqIAVC018FS7ZZrwJGdZJroaCz6fNS5lSKWnBIUZLpext8HTBqQDQuciHQiBjO
         BVyRjrxdjPsIc4L3qL/mzhFqc7GXwZAZPiMaMLmbF9pIXb6Eby14mmwdjXOrINUG8Vvl
         S5c+txVB8dzyDgnF2+5/cY6MMIHegfUusPopkzLm+FFMxTC0HE9PR8oX/gmbDKjJ7FVS
         HSSQ==
X-Gm-Message-State: APjAAAU/LpbwoXz1YOpig6FddwHWYRAHI+QwXj/yHRiDZScdtQAqaJ/d
        6DxQBU3IcF+Rbs9C9kdZD1FJmzBOTGc=
X-Google-Smtp-Source: APXvYqyWsi8I0Z/Xyw4W9vvyu3c+zI7NliEjaHBXNJQGMPyffoOtEx4GKM8WmXQU7xvAUKnPRu1EmQ==
X-Received: by 2002:a17:902:2926:: with SMTP id g35mr43540886plb.269.1560449376868;
        Thu, 13 Jun 2019 11:09:36 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b15sm454449pff.31.2019.06.13.11.09.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 11:09:36 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 4/8] dt-bindings: tpm: document properties for cr50
Date:   Thu, 13 Jun 2019 11:09:27 -0700
Message-Id: <20190613180931.65445-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190613180931.65445-1-swboyd@chromium.org>
References: <20190613180931.65445-1-swboyd@chromium.org>
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
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

This is a resend of https://lkml.kernel.org/r/1469757314-116169-2-git-send-email-apronin@chromium.org
with status removed.

 .../bindings/security/tpm/cr50_spi.txt        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/cr50_spi.txt

diff --git a/Documentation/devicetree/bindings/security/tpm/cr50_spi.txt b/Documentation/devicetree/bindings/security/tpm/cr50_spi.txt
new file mode 100644
index 000000000000..401f4ba281b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/cr50_spi.txt
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

