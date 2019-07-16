Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 780006B205
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 00:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389010AbfGPWpj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jul 2019 18:45:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42139 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388943AbfGPWpX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jul 2019 18:45:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so9800426pff.9
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jul 2019 15:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=72sm/MNTwsNcY36VTGuC/LZLkp7KY9tFB/Nl1CF7FuQ=;
        b=J94PBbim+Yv1GJt8vVgj6+wcSDxVIhoI24sx6Ohj38GaoLPK5smv0nkb3SYd2el77t
         vhonBa6mPzCYZBG5IGCaD7sBcIrd7SlCQO0LYmBNL8zSlXInCc6ICRsQN0Y4g8SQtwpS
         mYIMo0LaCbF6Ir8WNqnrThYgyhYz5bABz7R+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=72sm/MNTwsNcY36VTGuC/LZLkp7KY9tFB/Nl1CF7FuQ=;
        b=ZeMKT4X5rMh/Y+l2gK2FsN2uCe8RO5E18v99Pc6KS5gKLm0uRmuCBjwUisfGR0t0HU
         EG/2QseRSFWIkZ1k18DckkHxXE8PXyWWY5+HQD8aW0RoTpppwzMA3mfBh2rjP5TOwDa1
         FYRgwR+A6z6UlJJyAGTgQXNVm9BVzFZdrstcptql/YvA8Qk3V34hCPyRUZ3lOiowFb2I
         A0sGXS9r5qYazkOWdjCG7C3KZWBGQ7qMC0IqyVJxNTE23TGrncSnFIdZ00wrUgWu8om6
         GFA6iQ8MtDZjmI5V8ekpzdFxMrdyX2hGoPtRd2oc/qJOSCQU6KNC5RXMzCEevLEgZlej
         /ONQ==
X-Gm-Message-State: APjAAAXrRRsCi3AIWTV0ptrimRlE47+d9grABvg8xmjsT7YtB/30lQbP
        zjbS3vycrfVibeI+qxyejQYxVw==
X-Google-Smtp-Source: APXvYqxPLoiQ/fQgpBzDfuDCkw0cAWxIoJ+jwZaN3mgwgHT7TpOVZgKqLx0rU89mFfmaN1nGc7j+/A==
X-Received: by 2002:a63:2006:: with SMTP id g6mr36282313pgg.287.1563317122894;
        Tue, 16 Jul 2019 15:45:22 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 64sm22182562pfe.128.2019.07.16.15.45.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 15:45:22 -0700 (PDT)
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
Subject: [PATCH v2 3/6] tpm_tis_spi: add max xfer size
Date:   Tue, 16 Jul 2019 15:45:15 -0700
Message-Id: <20190716224518.62556-4-swboyd@chromium.org>
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

Reject burstcounts larger than 64 bytes reported by tpm.
SPI Hardware Protocol defined in section 6.4 of TCG PTP
Spec supports up to 64 bytes of data in a transaction.

Signed-off-by: Andrey Pronin <apronin@chromium.org>
Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/char/tpm/tpm_tis_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index 19513e622053..27393275a3f0 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -190,6 +190,7 @@ static const struct tpm_tis_phy_ops tpm_spi_phy_ops = {
 	.read16 = tpm_tis_spi_read16,
 	.read32 = tpm_tis_spi_read32,
 	.write32 = tpm_tis_spi_write32,
+	.max_xfer_size = MAX_SPI_FRAMESIZE,
 };
 
 static int tpm_tis_spi_probe(struct spi_device *dev)
-- 
Sent by a computer through tubes

