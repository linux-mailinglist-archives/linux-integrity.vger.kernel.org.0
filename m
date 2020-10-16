Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BD028FE0E
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Oct 2020 08:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388876AbgJPGK0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Oct 2020 02:10:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22648 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730492AbgJPGK0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Oct 2020 02:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602828624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SDFh+4dhaaVVnZpAHchgy8jwKvRXaQU7zwokuKHCQLM=;
        b=E0NaOFMm4JzepU4BuvUt74gR974xc8OO6uKbJ+LJi0tvXF5Fjg5tInoQMs+6MINIqxJiHj
        MakZNzqMtTZsQBiEHsbbNV+lL2XeDtk3H06paboUzmcUN5z5VbUs+gGovekmhQaVpKKf0K
        vI+gTejDipuzLBJq+9D3daXuab2iLx0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-RIMk7MdMO-aET_ev3UG9iQ-1; Fri, 16 Oct 2020 02:10:22 -0400
X-MC-Unique: RIMk7MdMO-aET_ev3UG9iQ-1
Received: by mail-ed1-f71.google.com with SMTP id s2so540834edw.21
        for <linux-integrity@vger.kernel.org>; Thu, 15 Oct 2020 23:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SDFh+4dhaaVVnZpAHchgy8jwKvRXaQU7zwokuKHCQLM=;
        b=kVIa+TCILNlHwp1tCAz0HosymBmHEkhjL0e/rOh27ta4CiyxRg1ZJgY20oqgVsz313
         HQMv4xe0zPhYNIjaZCsWXHfzj90z2FkqWW6B/LTpwCPFH1liE0DfN7csas6flWs4c4ve
         lKdHNNMsB2D+bRRfI0d7HPwaYQb2xmRtL1YGLc9SOygildb/E3/yAbNjSIIsrcs5xSU3
         2dj9t/bF5u3NDEJVWWU2Mg//QOTqYvwLis+B0ttQ7KJ80CgD5tH6GenB+l+Ojfsoh05g
         EGYYZvkyaqVyqz+TADZMuADxJp8KaAhkorrdxNQGql/gGIP2dlkyz8iwVcIbNr+TpLG/
         /9Rw==
X-Gm-Message-State: AOAM530en/e+ZZ6pyDaLMnSB0SWj8ElE3yXA6lTm6RYt5xH5BR6EU23Y
        nPpiFy8SfVoxIAdMjwESqcmMn9zpDqavh6yummyjlXOKjRrtvAZ+AN3cpHenMZxwAeOGBgl2xaX
        clVrgvdTHUSVnO/DheYbMTv44e9Ws
X-Received: by 2002:a17:906:a002:: with SMTP id p2mr1959644ejy.399.1602828621267;
        Thu, 15 Oct 2020 23:10:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaToAH6DE6ijarStuPvXIQn3tWvFXSGa5ck7V41ia0Yt6o1J9meHKp3eQ45OLyLzpdJKN78w==
X-Received: by 2002:a17:906:a002:: with SMTP id p2mr1959624ejy.399.1602828621050;
        Thu, 15 Oct 2020 23:10:21 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id g4sm824833ejf.78.2020.10.15.23.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 23:10:20 -0700 (PDT)
Subject: Re: [PATCH] tpm_tis: Disable interrupts on ThinkPad T490s
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jarkko@kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
References: <20201015214430.17937-1-jsnitsel@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cb153887-1044-0b48-c65a-b6257c5b91f2@redhat.com>
Date:   Fri, 16 Oct 2020 08:10:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201015214430.17937-1-jsnitsel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 10/15/20 11:44 PM, Jerry Snitselaar wrote:
> There is a misconfiguration in the bios of the gpio pin used for the
> interrupt in the T490s. When interrupts are enabled in the tpm_tis
> driver code this results in an interrupt storm. This was initially
> reported when we attempted to enable the interrupt code in the tpm_tis
> driver, which previously wasn't setting a flag to enable it. Due to
> the reports of the interrupt storm that code was reverted and we went back
> to polling instead of using interrupts. Now that we know the T490s problem
> is a firmware issue, add code to check if the system is a T490s and
> disable interrupts if that is the case. This will allow us to enable
> interrupts for everyone else. If the user has a fixed bios they can
> force the enabling of interrupts with tpm_tis.interrupts=1 on the
> kernel command line.
> 
> Cc: jarkko@kernel.org
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/char/tpm/tpm_tis.c | 29 +++++++++++++++++++++++++++--
>   1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 0b214963539d..4ed6e660273a 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -27,6 +27,7 @@
>   #include <linux/of.h>
>   #include <linux/of_device.h>
>   #include <linux/kernel.h>
> +#include <linux/dmi.h>
>   #include "tpm.h"
>   #include "tpm_tis_core.h"
>   
> @@ -49,8 +50,8 @@ static inline struct tpm_tis_tcg_phy *to_tpm_tis_tcg_phy(struct tpm_tis_data *da
>   	return container_of(data, struct tpm_tis_tcg_phy, priv);
>   }
>   
> -static bool interrupts = true;
> -module_param(interrupts, bool, 0444);
> +static int interrupts = -1;
> +module_param(interrupts, int, 0444);
>   MODULE_PARM_DESC(interrupts, "Enable interrupts");
>   
>   static bool itpm;
> @@ -63,6 +64,28 @@ module_param(force, bool, 0444);
>   MODULE_PARM_DESC(force, "Force device probe rather than using ACPI entry");
>   #endif
>   
> +static int tpm_tis_disable_irq(const struct dmi_system_id *d)
> +{
> +	if (interrupts == -1) {
> +		pr_notice("tpm_tis: %s detected: disabling interrupts.\n", d->ident);
> +		interrupts = 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dmi_system_id tpm_tis_dmi_table[] = {
> +	{
> +		.callback = tpm_tis_disable_irq,
> +		.ident = "ThinkPad T490s",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T490s"),
> +		},
> +	},
> +	{}
> +};
> +
>   #if defined(CONFIG_PNP) && defined(CONFIG_ACPI)
>   static int has_hid(struct acpi_device *dev, const char *hid)
>   {
> @@ -192,6 +215,8 @@ static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
>   	int irq = -1;
>   	int rc;
>   
> +	dmi_check_system(tpm_tis_dmi_table);
> +
>   	rc = check_acpi_tpm2(dev);
>   	if (rc)
>   		return rc;
> 

