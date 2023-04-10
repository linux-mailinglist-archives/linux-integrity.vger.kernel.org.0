Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F666DC6C4
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Apr 2023 14:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjDJM3k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Apr 2023 08:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDJM3j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Apr 2023 08:29:39 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5635C423B;
        Mon, 10 Apr 2023 05:29:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-246773b4da9so205894a91.3;
        Mon, 10 Apr 2023 05:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681129777; x=1683721777;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IBF+xgglDWe7wxOB6LdlEQYYex7G8oFJMHo1ddlc7+I=;
        b=cekAVriuwN7cYuTCgtuU3Mov7AbNtFVvBkvMpn1H2eed4CMRjXhsh81YvVzQ33GigO
         lZR7SYwaTbMSYuNi/dswAWPrFpK4wpYTtbQXq6eZY8ZqBUbvawPwhDqrhle2BmXR6BGi
         lqptP6kKa/fc3PpAkmCHX6SQ5WkCTTyfygbHrrmYujzNyyH3G1gaf8XitsWZAhGk4HG2
         J/kJJd1xLnuthlbqKDEfum8wxPl6kGJSgK6oaa46ozzfH1zqW5vBH65Ni0FXkVR6Ifhe
         FJn19gTBcer4EyxbgR3PplUbppeiXrLcoThSMoV5Qlo0MqkFWibf4GaXOkFXaBmCImJ7
         LqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681129777; x=1683721777;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IBF+xgglDWe7wxOB6LdlEQYYex7G8oFJMHo1ddlc7+I=;
        b=oVqPSTBbt6pQcQEWWMhI3CqXCEta6gRqEAwcVfi+b1M0fQct6Wagg/elWCsI64OXzC
         Z/Gga4NnLT+4otjlDJkjlrmu/0ke0RTw0OAovTKbyits/00U9X4Ipdu8Fg0c70EHVBbv
         622aYgfwcefD/T4jWSl1Vgn3f1qRo5ZrrXCL2kPBML95lqi0iAg13IJDL6E5jE35NQ+/
         RHFcJb4LlzsIK961arCo5LtMV9/cUnLdvmjOoKfM2eOiZIjNSegJFUrQfnp/cra86uh2
         x2ctKRkr3Vbh7+51WxKcnePT57LL2Fyqm9GY6OAR1TBg6iuRfs5bf45AAtC4jN9ylMHh
         IkTQ==
X-Gm-Message-State: AAQBX9emg8EnkBkXG0cKVaN0UG5ppeDFIha+HNEz3ABn0aT1YW5fw56k
        DRuPbqY/4XZkqgAVhzDcKJ4Jkg8uKMfPuRsW3Pg=
X-Google-Smtp-Source: AKy350ZFo801tvDiT5TFRr+x1QeyeiOoQOyN7L5y6scS0Exwjm0pAJVhLRHuTmC6Tm7HfKgB6x5UCcJd1i7nJNXO9XM=
X-Received: by 2002:a05:6a00:1799:b0:625:cff9:8b8d with SMTP id
 s25-20020a056a00179900b00625cff98b8dmr3307971pfg.2.1681129776745; Mon, 10 Apr
 2023 05:29:36 -0700 (PDT)
MIME-Version: 1.0
From:   Peijie Shao <shaopeijie@gmail.com>
Date:   Mon, 10 Apr 2023 20:29:26 +0800
Message-ID: <CALB=bK-7m68fCQ-_6JrzkFwanTN9E7wKzZBXtVTRziVXyXHOAA@mail.gmail.com>
Subject: [PATCH] tpm_tis_spi: fix:release chip select when flow control fails
To:     "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        shaopeijie@cestc.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Peijie Shao <shaopeijie@gmail.com>

The TPM's chip select will leave active after spi_bus_unlock when
flow control timeout, and may interfere other chips sharing the same
spi bus, or may damage them dule to level conflict on MISO pin.

So the patch deactives the chip select by sending an empty message
with cs_change=0 if flow control fails.

The reason why flow control timeout for me is unfortunately I got a
damaged TPM chip. It always pull MISO low during cs active(this can
be easily emulated by wire MISO to the ground), not responding anything,
and dmesg shows below:
...
[   311.150725] tpm_tis_spi: probe of spi0.0 failed with error -110
...

Signed-off-by: Peijie Shao <shaopeijie@cestc.cn>
---
drivers/char/tpm/tpm_tis_spi_main.c | 13 ++++++++++++-
1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c
b/drivers/char/tpm/tpm_tis_spi_main.c
index a0963a3e92bd..5c8ff343761f 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -105,8 +105,19 @@ int tpm_tis_spi_transfer(struct tpm_tis_data
*data, u32 addr, u16 len,
/* Flow control transfers are receive only */
spi_xfer.tx_buf = NULL;
ret = phy->flow_control(phy, &spi_xfer);
- if (ret < 0)
+ if (ret < 0) {
+ /*
+ * Release cs pin if the device is not responding, regardless of the reason.
+ * Notice cs may alreadly been released if the failure was caused inside
+ * spi_sync_locked called by flow_control, in this situation, a pluse may be
+ * generated on cs.
+ */
+ memset(&spi_xfer, 0, sizeof(spi_xfer));
+ spi_message_init(&m);
+ spi_message_add_tail(&spi_xfer, &m);
+ spi_sync_locked(phy->spi_device, &m);
goto exit;
+ }
spi_xfer.cs_change = 0;
spi_xfer.len = transfer_len;
--
2.39.1
