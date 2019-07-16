Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBF16B209
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 00:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388725AbfGPWpu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jul 2019 18:45:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42868 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388877AbfGPWpV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jul 2019 18:45:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so10855689plb.9
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jul 2019 15:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7aVjiR+JK3ggYYZ7yXO08DXVJw3fb9HDv02tv0JnQs=;
        b=WsSLV5wxog6kvWIkL7tsl/dpBk3h6KCtQVzK3wRMQZycgoNetF0L2hlVtTIwv+mdb7
         7cdOcd7E5s69ObFuTWG9V3q2o8BXcDlXi1AKT8WQLwj1muCboCZQwl1QXuY+k0KdETX/
         dlhJO7ZtlW1HnyxfHdjlR711IWf195ERVsWbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7aVjiR+JK3ggYYZ7yXO08DXVJw3fb9HDv02tv0JnQs=;
        b=BxDDEUtyyonOR5qMaex/rW146itIhTaUy3EUbGRkhYkNcr5jyL+U93GjXaqOAf4XR+
         2Eaco5QS28bHP3f2K0Fic7567C1L0gpL2tp7JGFyxaMS4gCBl3Y0n5dmm/cj1csLvz+3
         V/DiZo7D1N1gsCf9lUIWpnmuGDndfy6AJByJQ3VqDTzJkeT22zlmjoiKzs+agPtzQOL6
         8HjBGY1zklNFrLYDiNyEU+r7dUH3CTzOH+AccCnRsLMJy/v2oiGIHx+ryYiUHp5WwJdi
         i19MyQEkvrnmgFutVbpGPOPzYXyaW8WjadftEbzp1tRhilL5F528XeiAr1nWC43H2fb7
         sVWQ==
X-Gm-Message-State: APjAAAUw7L781DwJbaumJK/Y/3Qq/zsfXZT/ZWXkerM300ZEwpf1Rulk
        WfH2haDC1RAKM/hkO+R4o6CyLg==
X-Google-Smtp-Source: APXvYqxPH9EK3keRCVn+uuCQzmztl+iHZMi6aDlVgkc8dTyHKxOKu67J/eMo+6OI5dwAp8p0Iblpbw==
X-Received: by 2002:a17:902:6b86:: with SMTP id p6mr39696288plk.14.1563317121296;
        Tue, 16 Jul 2019 15:45:21 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 64sm22182562pfe.128.2019.07.16.15.45.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 15:45:20 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH v2 1/6] hwrng: core: Freeze khwrng thread during suspend
Date:   Tue, 16 Jul 2019 15:45:13 -0700
Message-Id: <20190716224518.62556-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190716224518.62556-1-swboyd@chromium.org>
References: <20190716224518.62556-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The hwrng_fill() function can run while devices are suspending and
resuming. If the hwrng is behind a bus such as i2c or SPI and that bus
is suspended, the hwrng may hang the bus while attempting to add some
randomness. It's been observed on ChromeOS devices with suspend-to-idle
(s2idle) and an i2c based hwrng that this kthread may run and ask the
hwrng device for randomness before the i2c bus has been resumed.

Let's make this kthread freezable so that we don't try to touch the
hwrng during suspend/resume. This ensures that we can't cause the hwrng
backing driver to get into a bad state because the device is guaranteed
to be resumed before the hwrng kthread is thawed.

Cc: Andrey Pronin <apronin@chromium.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Duncan Laurie <dlaurie@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/char/hw_random/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 95be7228f327..3b88af3149a7 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/freezer.h>
 #include <linux/fs.h>
 #include <linux/hw_random.h>
 #include <linux/kernel.h>
@@ -421,7 +422,9 @@ static int hwrng_fillfn(void *unused)
 {
 	long rc;
 
-	while (!kthread_should_stop()) {
+	set_freezable();
+
+	while (!kthread_freezable_should_stop(NULL)) {
 		struct hwrng *rng;
 
 		rng = get_current_rng();
-- 
Sent by a computer through tubes

