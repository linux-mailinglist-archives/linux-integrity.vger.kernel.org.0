Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33870A29E8
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 00:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfH2Wl4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Aug 2019 18:41:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42907 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbfH2WlO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Aug 2019 18:41:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id p3so2358133pgb.9
        for <linux-integrity@vger.kernel.org>; Thu, 29 Aug 2019 15:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oyE0lW4jziioV/J2I+7J0Vx8oaL6QC9YS1SJmLa32Os=;
        b=IBRubZtS1atZrqip9I8WO1UTgzAETIXc7HfyZTs6nQr0vABcMw+sHvmDJXCiwp1gni
         nw6735YGQNZkNblmIdQ48ZBesNcP+sSkrySx4lR9ltiJbGTueUZr6NwPAG2b/YWNVmob
         qPEE1yyqQB6vhC1EoijhgmKUxZlfWmCaLp13w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oyE0lW4jziioV/J2I+7J0Vx8oaL6QC9YS1SJmLa32Os=;
        b=MWzd/AGgEN26qeWltvCz71f+jkdWPz7aGAkIZQLwos03XK5PK+Ktgc3Nlv/u1YH/Rd
         CyxOmSjRCMHwRqGjoCgbXfgJgcCYCjr1YrAX/Z6CeO+LrFwEcUiwnsCIFEPhlb3HnsgS
         gMSIy93TzqzpW7ILLbeGTthES6PIipovjePGkfnZ3vV7e9LzAaWfY7o1uWosTNNqEIAr
         54/DDyKnAWuZWrGVkmE1i5XxJJwDwYb4rFxugNBg9ikFv1ro+xTYy60/KekK2R/TdybD
         Y3w8qEpOOmCVAKVfkuySQG3gs3fxwwUkcJ3N35nengWTtqmJS6FMT1P91SAdxmLIUGG5
         fzfQ==
X-Gm-Message-State: APjAAAVfZ/2rLD9Q8u5rUtO/kyA6o4H1CgYSAO+v0eI3gNcAhoxCEmIL
        Bz+AJ28ZYQKSMmc3J5jiiBia0w==
X-Google-Smtp-Source: APXvYqwGYvucblokw7IOjHB0DGRoWgdDwob5vMGNPjBvaJbTUPcopwQDr6kFLB4lDrG7VWR42z6a5Q==
X-Received: by 2002:aa7:9533:: with SMTP id c19mr14347289pfp.153.1567118473386;
        Thu, 29 Aug 2019 15:41:13 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q8sm3882531pjd.28.2019.08.29.15.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 15:41:12 -0700 (PDT)
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
Subject: [PATCH v6 1/4] dt-bindings: tpm: document properties for cr50
Date:   Thu, 29 Aug 2019 15:41:07 -0700
Message-Id: <20190829224110.91103-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190829224110.91103-1-swboyd@chromium.org>
References: <20190829224110.91103-1-swboyd@chromium.org>
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

