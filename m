Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B41878AA81
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Aug 2019 00:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfHLWgp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Aug 2019 18:36:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46630 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfHLWg1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Aug 2019 18:36:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id q139so2135522pfc.13
        for <linux-integrity@vger.kernel.org>; Mon, 12 Aug 2019 15:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ARqGVqps+UvD6gPycAavcJDE2CdT6bD5OYORFnIVyA4=;
        b=P9G6y5o0oRHI87G+Axh3H0Q0lFVxG69Ev11gPscknQxS++hpSgrVr+Dz6m6gko17ad
         ndY5JECMTxJve5nKky69rtBFiunmAm0EkOnERFYVcbyhmyFZL20WXAzpaT5zaevxqmZh
         ICi/9Scec6pPJIaFjZ4EY496D2VMLbQFWuVF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ARqGVqps+UvD6gPycAavcJDE2CdT6bD5OYORFnIVyA4=;
        b=EfY7rLsU4LdGA4zMt3uhStHqLSuA0DlYr1f0ZOk2Cs1O8kbKYHjHOwB/Bv3z7pyz8F
         1RZTAjtxMe5Uhtv/ICpVzPY7aGGaSGMWygmU6K7/+nYpdCqnqEr3mpCEbzPF1I9g5yc7
         OEyzzZWgMUJeJj7kTa+Qa66Udlv5noDukqhieEc+3sQJIjhkNdq4VAUKsxpx3CsK1OFG
         CQhMtXLi4ibck5URhShEJMoNNGxrCTFsvJeKDgMVnD1emjvXS2WE4tkuNJzvVD7VuFG7
         NnMAgi/WHw7L3h8xxknOQDQ63TEWBgja6GJ4qvdWC7PuB1+tcvlk50+JZ5afqbkiwbY4
         e1HA==
X-Gm-Message-State: APjAAAXFke58SyoQWAn3k8RP1yZAG9j48HVOJiiAhY+WKCIByzKqTGxW
        mI0IkAcdowPi24zFsvRJmOq1mQ==
X-Google-Smtp-Source: APXvYqzUWfHrQolgxy4D/V0dl/A2RBuv86RieLCSdSWbN9BhIfnP3A1Tjww9sDQhKmaZIUj7PkFxRQ==
X-Received: by 2002:a62:db43:: with SMTP id f64mr21707438pfg.38.1565649387079;
        Mon, 12 Aug 2019 15:36:27 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b6sm93911594pgq.26.2019.08.12.15.36.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 15:36:26 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [PATCH v4 3/6] tpm: tpm_tis_spi: Add a pre-transfer callback
Date:   Mon, 12 Aug 2019 15:36:19 -0700
Message-Id: <20190812223622.73297-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190812223622.73297-1-swboyd@chromium.org>
References: <20190812223622.73297-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Cr50 firmware has a requirement to wait for the TPM to wakeup before
sending commands over the SPI bus. Otherwise, the firmware could be in
deep sleep and not respond. Add a hook to tpm_tis_spi_transfer() before
we start a SPI transfer so we can keep track of the last time the TPM
driver accessed the SPI bus.

Cc: Andrey Pronin <apronin@chromium.org>
Cc: Duncan Laurie <dlaurie@chromium.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/char/tpm/tpm_tis_spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index 819602e85b34..93f49b1941f0 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -44,6 +44,7 @@ struct tpm_tis_spi_phy {
 	struct spi_device *spi_device;
 	int (*flow_control)(struct tpm_tis_spi_phy *phy,
 			    struct spi_transfer *xfer);
+	void (*pre_transfer)(struct tpm_tis_spi_phy *phy);
 	u8 *iobuf;
 };
 
@@ -129,6 +130,8 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 
 		spi_message_init(&m);
 		spi_message_add_tail(&spi_xfer, &m);
+		if (phy->pre_transfer)
+			phy->pre_transfer(phy);
 		ret = spi_sync_locked(phy->spi_device, &m);
 		if (ret < 0)
 			goto exit;
-- 
Sent by a computer through tubes

