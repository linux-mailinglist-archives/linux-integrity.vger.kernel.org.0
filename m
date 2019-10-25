Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3C0EE4EA0
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2019 16:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407545AbfJYOMJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Oct 2019 10:12:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405765AbfJYOMI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Oct 2019 10:12:08 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8EAB93B72D
        for <linux-integrity@vger.kernel.org>; Fri, 25 Oct 2019 14:12:08 +0000 (UTC)
Received: by mail-pg1-f200.google.com with SMTP id q1so1868983pgj.3
        for <linux-integrity@vger.kernel.org>; Fri, 25 Oct 2019 07:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mngp9ByjJpQg9SxtEqbRAAoshsDSaBU3xx6GDmhW2Rk=;
        b=JTviBTG6PteTUFKGlBl8BUg4Ifs7m8K0h4h2OaQ/M/05MO8ojeKx8HJJV/i59sDUjj
         cl1BPA14fx7olLEQ+VgveU650e3jt6GnlsAdJlp2Tu9dgMHyY9/ptZUpHfP46rdlJY5B
         /JtdCEa8TuVlqgLpGlXNyqGm40zrrJR5eF7hLCoUoT36KDa2tq9TVq+Pcy2LxLUNYJqx
         XM3NoS4FA5qXa5HKjwgcoO300v51m/PBj010o2PxwCcv+5dc4qfLQ4PNPn7z41MRKPdC
         PcFVlyRP5iO6szzZKDnPP1hYGJmdS50P5mnHVHcxHp0hAek3hHnZ5RybK49jEVr0kAl8
         DwkQ==
X-Gm-Message-State: APjAAAXXOJ7kwjShtzm1D5CQpAg1rE/tgc1ogXdsPVCYv4m4lcBccpek
        TU/lpTvxA2V/iWHIMv096+aicSvJtAgfQWP6FwUGradUKuZyL6G6urKVE4L0jhQtEGuX8gKIUu0
        bEq7MFdP+2nXxYqudMs64132jbuDm
X-Received: by 2002:a17:902:7684:: with SMTP id m4mr3940752pll.13.1572012727828;
        Fri, 25 Oct 2019 07:12:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz7AEcm435KjYgZqphptYvJ49zOefG9Ex/lTNGT+5fch3KhjaaMUw8kACuhB2ab3+0PFqWY0Q==
X-Received: by 2002:a17:902:7684:: with SMTP id m4mr3940724pll.13.1572012727562;
        Fri, 25 Oct 2019 07:12:07 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id 82sm4101072pfa.115.2019.10.25.07.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 07:12:06 -0700 (PDT)
Date:   Fri, 25 Oct 2019 07:12:05 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Switch to platform_get_irq_optional()
Message-ID: <20191025141205.vejqamwsppvdmp7a@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20191025091448.4424-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191025091448.4424-1-hdegoede@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Oct 25 19, Hans de Goede wrote:
>platform_get_irq() calls dev_err() on an error. As the IRQ usage in the
>tpm_tis driver is optional, this is undesirable.
>
>Specifically this leads to this new false-positive error being logged:
>[    5.135413] tpm_tis MSFT0101:00: IRQ index 0 not found
>
>This commit switches to platform_get_irq_optional(), which does not log
>an error, fixing this.
>
>Fixes: 7723f4c5ecdb ("driver core: platform: Add an error message to platform_get_irq*()"
>Cc: <stable@vger.kernel.org> # 5.4.x
>Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

>---
>Changes in v2:
>- Slightly reword commit msg, add Fixes tag
>---
> drivers/char/tpm/tpm_tis.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
>index e4fdde93ed4c..e7df342a317d 100644
>--- a/drivers/char/tpm/tpm_tis.c
>+++ b/drivers/char/tpm/tpm_tis.c
>@@ -286,7 +286,7 @@ static int tpm_tis_plat_probe(struct platform_device *pdev)
> 	}
> 	tpm_info.res = *res;
>
>-	tpm_info.irq = platform_get_irq(pdev, 0);
>+	tpm_info.irq = platform_get_irq_optional(pdev, 0);
> 	if (tpm_info.irq <= 0) {
> 		if (pdev != force_pdev)
> 			tpm_info.irq = -1;
>-- 
>2.23.0
>

