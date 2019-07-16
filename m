Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6202C6B207
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 00:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389048AbfGPWpo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jul 2019 18:45:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41470 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388920AbfGPWpW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jul 2019 18:45:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so9812432pff.8
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jul 2019 15:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XhoCZVaLlau9+Xc+5qSO9umR0QsUdpX7Z2QE44vnJZU=;
        b=bluu7D9B/mMWMLSKmrkYFqWlQqd81PwDK6IUpGDHR9A82/CADp8Ac7NeQrUBhy32gp
         un4BOzUZXGz/UosByptd3LvbToVwTST2LMbVWMk7+mDvzRsTkqdAMysmWFPl0zLwop74
         VThHreHsZRuHz+/sHCR45nilICSBE7D5SjV2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhoCZVaLlau9+Xc+5qSO9umR0QsUdpX7Z2QE44vnJZU=;
        b=Mn34zWyJwMsXJtbT4d2nS+gNdRowkEebtqlYAsxf8sh+ZFhbXSOwlzPdNFXLFTCILx
         ZROGPAkM6PNT7Bq7dZ7KgMrxycFYvBysNiP0m/5K6Q8bgUJ7LAJapnyqeVwwAJ2zWYkQ
         OLEVugk2sMsQd7bh4avgaNMnCthfiBXs3Ab2T7/ON8bafJkt1reDLGmw7ZTxL6F2N5dS
         G9MapkVfNR79NtENUZzcMU6BbExBFWJe28KnLh0lyq9OsREFgtPLrZuF8F/BJB2zAFWk
         wX6aR5MNsi49sb1hRzKCBhh+GVP4aMWGcaxpzWLyrJ1ZrGzyoYK/PQIVDKQaWlJZ2f33
         fggQ==
X-Gm-Message-State: APjAAAXv224tpPZLIj/Y2YUPwB7tYx5+CEREte9SrEblFy9nfBq52xqx
        RTPQWfDir5kNT49v0MDNoZFQWg==
X-Google-Smtp-Source: APXvYqzJCyO68XJZcaLnDyrXCNdFh5UGj9LKILi3eXmr8hQVkr/gtkE5Z7MtsrtHorzGNfG0SBaK3Q==
X-Received: by 2002:a17:90a:32ed:: with SMTP id l100mr39314318pjb.11.1563317122065;
        Tue, 16 Jul 2019 15:45:22 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 64sm22182562pfe.128.2019.07.16.15.45.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 15:45:21 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>
Subject: [PATCH v2 2/6] tpm_tis_core: add optional max xfer size check
Date:   Tue, 16 Jul 2019 15:45:14 -0700
Message-Id: <20190716224518.62556-3-swboyd@chromium.org>
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

If tpm reports a bigger burstcnt than allowed by the physical protocol,
set burstcnt to the max allowed value.

In practice, seen in case of xfer issues (e.g. in spi interface case,
lost header causing flow control issues and wrong values returned on read
from TPM_STS). Without catching, causes the physical layer to reject xfer.

Signed-off-by: Andrey Pronin <apronin@chromium.org>
Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
[swboyd@chromium.org: Drop extra parenthesis in if statement]
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/char/tpm/tpm_tis_core.c | 9 ++++++++-
 drivers/char/tpm/tpm_tis_core.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index c3181ea9f271..5134b05487e5 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -268,8 +268,15 @@ static int get_burstcount(struct tpm_chip *chip)
 			return rc;
 
 		burstcnt = (value >> 8) & 0xFFFF;
-		if (burstcnt)
+		if (burstcnt) {
+			if (priv->phy_ops->max_xfer_size &&
+			    burstcnt > priv->phy_ops->max_xfer_size) {
+				dev_warn(&chip->dev,
+					 "Bad burstcnt read: %d\n", burstcnt);
+				burstcnt = priv->phy_ops->max_xfer_size;
+			}
 			return burstcnt;
+		}
 		usleep_range(TPM_TIMEOUT_USECS_MIN, TPM_TIMEOUT_USECS_MAX);
 	} while (time_before(jiffies, stop));
 	return -EBUSY;
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 7337819f5d7b..248e8ac8fd02 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -106,6 +106,7 @@ struct tpm_tis_phy_ops {
 	int (*read16)(struct tpm_tis_data *data, u32 addr, u16 *result);
 	int (*read32)(struct tpm_tis_data *data, u32 addr, u32 *result);
 	int (*write32)(struct tpm_tis_data *data, u32 addr, u32 src);
+	u16 max_xfer_size;
 };
 
 static inline int tpm_tis_read_bytes(struct tpm_tis_data *data, u32 addr,
-- 
Sent by a computer through tubes

