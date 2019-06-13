Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38F4544A54
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 20:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbfFMSJg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 14:09:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43993 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbfFMSJg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 14:09:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so12309196pfg.10
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jun 2019 11:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s4UOPmCaMTA/ZsZDFJPVYGvmCISuBSexVdeFUduycxw=;
        b=AskOkpFh+++DQTTwkArdgdbEfkDEWm7fPaUOs7Ny9QWsIUaPiNRiGi5WaJeUUHcjym
         gm+jUgHvjsTqYfPalPPiLiATfaYoIQekqX/3rNGp/yQFbm0/XdoLXLLQaDF50fZuML1V
         MdHGKBpojl7UUP03AIFcdmLEsEYcSIGP8ZgI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s4UOPmCaMTA/ZsZDFJPVYGvmCISuBSexVdeFUduycxw=;
        b=NiHUGEDHxbiEEmGIs93iHYTdLH2AQwlYCpWuwbdSEUVV6yDQdRCyVP4Jy15QSYuEZQ
         aTnhE5kDzGjR/q06z5dNiL7i0KsO3h9hQC53eV2q22LYWIkFmwUb/oH1r8tBB37UgTy7
         RTNB6YnAEI5DsBf9VbP+WLnD+afaKwo7RnX3EYDXAFQ/WYEnn926WrLi7DCQ/S9OhPd2
         nk92jUYwSC3sbgZur/mP66nhNvQz5AZTF7P6kErwnmlnxPDHln0HxEcRpuJCwov10lGl
         OLscePATuxRLVy8e4oU/6woP3GwUX3nmIzzeyAjG4eu4XOIYnbhmS8sBArvjVvdP7tg/
         WCpw==
X-Gm-Message-State: APjAAAWiGjzvpm5zJdp7YaG30h1WHvDlrpGQGjDT1DdD5jAt+pPOSMcV
        NQZHnN4G4ugRwliTW446HeDN8w==
X-Google-Smtp-Source: APXvYqyK//TFyvvsB14tdex9tb6JEfZao67LE8nQZkwFwZLlBu9O+FoPljXy615K3VxpUOjo9MniMw==
X-Received: by 2002:a62:14c4:: with SMTP id 187mr20886406pfu.241.1560449375606;
        Thu, 13 Jun 2019 11:09:35 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b15sm454449pff.31.2019.06.13.11.09.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 11:09:35 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>
Subject: [PATCH 3/8] tpm_tis_spi: add max xfer size
Date:   Thu, 13 Jun 2019 11:09:26 -0700
Message-Id: <20190613180931.65445-4-swboyd@chromium.org>
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

Reject burstcounts larger than 64 bytes reported by tpm.
SPI Hardware Protocol defined in section 6.4 of TCG PTP
Spec supports up to 64 bytes of data in a transaction.

Signed-off-by: Andrey Pronin <apronin@chromium.org>
Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

This is a resend of https://lkml.kernel.org/r/1469677797-74304-3-git-send-email-apronin@chromium.org

 drivers/char/tpm/tpm_tis_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index 9914f6973463..0fdd3966a3b3 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -194,6 +194,7 @@ static const struct tpm_tis_phy_ops tpm_spi_phy_ops = {
 	.read16 = tpm_tis_spi_read16,
 	.read32 = tpm_tis_spi_read32,
 	.write32 = tpm_tis_spi_write32,
+	.max_xfer_size = MAX_SPI_FRAMESIZE,
 };
 
 static int tpm_tis_spi_probe(struct spi_device *dev)
-- 
Sent by a computer through tubes

