Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E272201D08
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2020 23:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgFSVUX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Jun 2020 17:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgFSVUW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Jun 2020 17:20:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4283C0613EE
        for <linux-integrity@vger.kernel.org>; Fri, 19 Jun 2020 14:20:22 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id jz3so4590573pjb.0
        for <linux-integrity@vger.kernel.org>; Fri, 19 Jun 2020 14:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ao9q37LQ0LytZ2kfKG3wHimj3h6i1wrVhNw32iRbFs=;
        b=Tkb7Ld0wi9nF7ATlws2JBYfEWa59uVvt2ClnmP9ieabbYZjOte6+lbcgq2PEaZ1zrn
         Yds/3eiSECrIVK3ravRRPH5oKuD2S/uHQry5xNALw12JSTJMQlu57NIDkMM26URGAzdb
         /3CsO5DR4ErzUIzvmsJdfrcio7BN2OaYDez+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ao9q37LQ0LytZ2kfKG3wHimj3h6i1wrVhNw32iRbFs=;
        b=NeP41EvcwZxGaB+yMs7gFTpoJwLnwUvjWy7Vgw33YIfGoqYNDv7r9kirHqGRQVXcyB
         TB2QLUEYnOlfokE4LSvQ3hgSV1cZfGRDRHtAt4GC9Ozl3UEDXx9sIIDt9JMFdu4pt5DW
         lG0pbtBEZ/qXkxU9skUs6kYN24sUkFeDav55i1VsYWBE3WXLk4HsjLgS2JBbBWlHEi7K
         QUDqSVRND78/sbWclz4Vfnshe6rbsmTJhPax0Ewg9laJOfalUYgu/2O1jNHBrDBj5skF
         PfjNLO0IRTEkcov2OfQGT+/Ew2Xkv47zODoow1gkSEI6t/ehsqNQeNMOoqgb97OcRrI3
         ZzEw==
X-Gm-Message-State: AOAM533NiFNh2CUBhwIxszeOqJtC76isgsb743Lz+drvxs3Yk1GM3F7k
        +I/ii+xhJQQ+ICsTC2z/2k1DCw==
X-Google-Smtp-Source: ABdhPJykzkkGjRz28We2Mh/OfAmlnCSPOYZM7UkFgmBPDhfZhjfRzYZnmMZpQIbXGzCeVPLECON35g==
X-Received: by 2002:a17:902:e901:: with SMTP id k1mr9632688pld.92.1592601622268;
        Fri, 19 Jun 2020 14:20:22 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id g17sm5885290pju.11.2020.06.19.14.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 14:20:21 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Andrey Pronin <apronin@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm_tis_spi: Prefer async probe
Date:   Fri, 19 Jun 2020 14:20:01 -0700
Message-Id: <20200619141958.1.I58d549fded1fd2299543ede6a103fe2bb94c805d@changeid>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On a Chromebook I'm working on I noticed a big (~1 second) delay
during bootup where nothing was happening.  Right around this big
delay there were messages about the TPM:

[    2.311352] tpm_tis_spi spi0.0: TPM ready IRQ confirmed on attempt 2
[    3.332790] tpm_tis_spi spi0.0: Cr50 firmware version: ...

I put a few printouts in and saw that tpm_tis_spi_init() (specifically
tpm_chip_register() in that function) was taking the lion's share of
this time, though ~115 ms of the time was in cr50_print_fw_version().

Let's make a one-line change to prefer async probe for tpm_tis_spi.
There's no reason we need to block other drivers from probing while we
load.

NOTES:
* It's possible that other hardware runs through the init sequence
  faster than Cr50 and this isn't such a big problem for them.
  However, even if they are faster they are still doing _some_
  transfers over a SPI bus so this should benefit everyone even if to
  a lesser extent.
* It's possible that there are extra delays in the code that could be
  optimized out.  I didn't dig since once I enabled async probe they
  no longer impacted me.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/char/tpm/tpm_tis_spi_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index d96755935529..422766445373 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -288,6 +288,7 @@ static struct spi_driver tpm_tis_spi_driver = {
 		.pm = &tpm_tis_pm,
 		.of_match_table = of_match_ptr(of_tis_spi_match),
 		.acpi_match_table = ACPI_PTR(acpi_tis_spi_match),
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = tpm_tis_spi_driver_probe,
 	.remove = tpm_tis_spi_remove,
-- 
2.27.0.111.gc72c7da667-goog

