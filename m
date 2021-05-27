Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7CE393261
	for <lists+linux-integrity@lfdr.de>; Thu, 27 May 2021 17:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbhE0PZl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 May 2021 11:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53523 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235889AbhE0PZj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 May 2021 11:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622129043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1kCrvAGNk5x+9ZoqSebLak4g0PU0sL2l99GoIBSvwDw=;
        b=MCT8H1y7KyRtD4PA7PRtFkbQCXUgJhC7FyjfYQmIY2ssEnCRtuyUOf5yZKhiyVwOdNSXqz
        JHDstiLkKvmEfUQxZXddUYEX1PVBbWFLlovaonm15WMNsjtT/GsNANXWbElcPRKr7XX2Mu
        Mb3TJMX5JV7nLpnybEEpyO7Qod7xn1Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-wxEooqFwNcKdw6tK-nso3w-1; Thu, 27 May 2021 11:24:02 -0400
X-MC-Unique: wxEooqFwNcKdw6tK-nso3w-1
Received: by mail-wm1-f70.google.com with SMTP id y205-20020a1ce1d60000b029019278214067so342506wmg.3
        for <linux-integrity@vger.kernel.org>; Thu, 27 May 2021 08:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1kCrvAGNk5x+9ZoqSebLak4g0PU0sL2l99GoIBSvwDw=;
        b=fbFM7VjNp3vDH7Wn5gwuj3FQ9GqM4LJHRhLHyBi6EhOlHMO2Gh/3D4hVgnHrwtoS2H
         XlVl9tcg4h1hXdGPKLF7rlBvDg7XWMTtvXdrYbo3IVNqzIPbmZhlaC5ktkm9FAT/wZTA
         zSbeCpdjiuK4v00dOlgY+YqqTdnvjJ1j+7SqynUzmQxHjGcQQpdOVxZXIOREbSUksK9e
         gUCJQdS/eQOJr2m4754zHTxDtjRuC6N4mVEqIJwQ57eGSoJN6j7zBffOub++XHekVxul
         ttj9fp9/YjRKd6TXjG1ZD/ywqu048CvoTYmiYYoPZh13FEixcQCpMe7GOZWlj7JMTZQP
         wc9A==
X-Gm-Message-State: AOAM532GI9AzKNFiwoo8dtbsOt2tvLgM6stifCNHQjtBAt0TcYqGw+gU
        PC9yVBd6s7BWiAUtf4zGY87u2tcKaRVGyXFyD1e18iyAE5D4Lu+y0jNdkwaisaQeTf0FMPIDeXW
        yoklzhai92y/TFZw7+izvCDG2NVm1
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr4246477wmj.84.1622129040403;
        Thu, 27 May 2021 08:24:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztaJymgHwJOsX1iIFw99a7GlGot9wAyRTZgOLuVZfzZW5nP4EfgoQ88bQesUBm7rDx0IdFNw==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr4246461wmj.84.1622129040240;
        Thu, 27 May 2021 08:24:00 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id s5sm3551714wrw.95.2021.05.27.08.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:23:59 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Alexander Wellbrock <a.wellbrock@mailbox.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] tpm_tis_spi: add missing SPI device ID entries
Date:   Thu, 27 May 2021 17:23:52 +0200
Message-Id: <20210527152352.3835076-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The SPI core always reports a "MODALIAS=spi:<foo>", even if the device was
registered via OF. This means that this module won't auto-load if a DT has
for example has a node with a compatible "infineon,slb9670" string.

In that case kmod will expect a "MODALIAS=of:N*T*Cinfineon,slb9670" uevent
but instead will get a "MODALIAS=spi:slb9670", which is not present in the
kernel module aliases:

$ modinfo drivers/char/tpm/tpm_tis_spi.ko | grep alias
alias:          of:N*T*Cgoogle,cr50C*
alias:          of:N*T*Cgoogle,cr50
alias:          of:N*T*Ctcg,tpm_tis-spiC*
alias:          of:N*T*Ctcg,tpm_tis-spi
alias:          of:N*T*Cinfineon,slb9670C*
alias:          of:N*T*Cinfineon,slb9670
alias:          of:N*T*Cst,st33htpm-spiC*
alias:          of:N*T*Cst,st33htpm-spi
alias:          spi:cr50
alias:          spi:tpm_tis_spi
alias:          acpi*:SMO0768:*

To workaround this issue, add in the SPI device ID table all the entries
that are present in the OF device ID table.

Reported-by: Alexander Wellbrock <a.wellbrock@mailbox.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/char/tpm/tpm_tis_spi_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index 3856f6ebcb3..de4209003a4 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -260,6 +260,8 @@ static int tpm_tis_spi_remove(struct spi_device *dev)
 }
 
 static const struct spi_device_id tpm_tis_spi_id[] = {
+	{ "st33htpm-spi", (unsigned long)tpm_tis_spi_probe },
+	{ "slb9670", (unsigned long)tpm_tis_spi_probe },
 	{ "tpm_tis_spi", (unsigned long)tpm_tis_spi_probe },
 	{ "cr50", (unsigned long)cr50_spi_probe },
 	{}
-- 
2.31.1

