Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88CE4B973E
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Sep 2019 20:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406592AbfITSct (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Sep 2019 14:32:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40605 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406624AbfITScs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Sep 2019 14:32:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so4292141pgj.7
        for <linux-integrity@vger.kernel.org>; Fri, 20 Sep 2019 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p7IfU61KE2txhnLC8mG/Pzm9PBv785Nvfxd4FYtvCwc=;
        b=b+RPPisf/2hxQhW05ru7RW/KG9Jpf2rSHMmfrV2LDB4v3ZsUDOhf+sdejyVBzrvSFQ
         f7PXa7Z0tMhC7VqrXtpsCmIcaOL6hs00kaYfKCIgi/MFzGo3tYmK8XJZ23HZWuaZjrfv
         Z6mFQHxasieOupjhCYo951/yeGWwoYwlMJlu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p7IfU61KE2txhnLC8mG/Pzm9PBv785Nvfxd4FYtvCwc=;
        b=nfa0FzecvUoYhasfkgRI2BFQt+utb7L5PRbeUQX0BvQi3cSD6t2aMYGzdYFpC2ZO2f
         cGjkTK+DliskNpjINjVl57OSvHb/ixXzc73KUSxJBrphUG8q+Fl/x1ysQFSr1k906Mjt
         ibL8QmFuM7CeW3p0sv3Buh1C4tHmcT2ssWixBbNi5qMU9DKpePr8295HFcfSoMQEeZTF
         fYPHjnCYR8oPc00ry/cheYPSkqKa9qsGGDe9IirTr/fCfojpgGNujrnVKCeyc2gv4DBS
         KVQgSLwKAHV7Fx2OHGuRyS2IwQETLuwcR1GI6yH9aMnJcqbRn2+rry4Ge29phUloFBzV
         BDpQ==
X-Gm-Message-State: APjAAAVZ7pNkTdDRKJ7rfUIa76nIyhEsFk4MVSXBdSzMRO4tG02y+sJM
        5Wcz1ahzYujEodLz/cUTRMz9uA==
X-Google-Smtp-Source: APXvYqy8nLBGPA5Ce5MY1hxDTwMj6VGdu3MYCiEfKtWTCTtQj3T/I+08bq/MEAKVkaCJRyy09HhEEQ==
X-Received: by 2002:a63:5d0e:: with SMTP id r14mr16656526pgb.15.1569004368198;
        Fri, 20 Sep 2019 11:32:48 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b69sm4436072pfb.132.2019.09.20.11.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 11:32:47 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v7 6/6] tpm: tpm_tis_spi: Drop THIS_MODULE usage from driver struct
Date:   Fri, 20 Sep 2019 11:32:40 -0700
Message-Id: <20190920183240.181420-7-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
In-Reply-To: <20190920183240.181420-1-swboyd@chromium.org>
References: <20190920183240.181420-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The module_spi_driver() macro already inserts THIS_MODULE into the
driver .owner field. Remove it to save a line.

Cc: Andrey Pronin <apronin@chromium.org>
Cc: Duncan Laurie <dlaurie@chromium.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/char/tpm/tpm_tis_spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index ec703aee7e7d..d1754fd6c573 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -283,7 +283,6 @@ MODULE_DEVICE_TABLE(acpi, acpi_tis_spi_match);
 
 static struct spi_driver tpm_tis_spi_driver = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "tpm_tis_spi",
 		.pm = &tpm_tis_pm,
 		.of_match_table = of_match_ptr(of_tis_spi_match),
-- 
Sent by a computer through tubes

