Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381FA292013
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Oct 2020 23:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgJRVLq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 18 Oct 2020 17:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgJRVLq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 18 Oct 2020 17:11:46 -0400
X-Greylist: delayed 125 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Oct 2020 14:11:45 PDT
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A45C061755;
        Sun, 18 Oct 2020 14:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rwlD0i+Gji/DQfCWgJihttK1p3QsdOsw/Q0vx5uztvU=; b=Lb3hFbiK2JW6hqjPMwPt7dpAFo
        X99d5Yc0bNqX+pmMiQAQz3Sqpr0n8dPLtP/shdnBS/X3BfFEW1jwSYu8yqcFsPJJbnwDkgNYrgC5h
        IUswxA+x9UPo0sqVlosKX3ggVmUjdTDmH9XXzXHXS+nlKe078OIn82LL/JPV7Uy+vlx7C+WbLNk34
        Z2/ONHI199dCH9S8o84OWEA0vGv+xZOBR587K4RawVJ0FTvnFGDOzrLiv2jvd9XskG2H2AK2tROIm
        PGRnCtQ3VN9Ik2Hc7JnpuBkQyCcjkzUqoWSZ8zTNlVgWG0oQ4zPpWiYpy4SpYP3EtZsw2F6kDw0PR
        3fdW8Dbg==;
Received: from 83-245-197-237.elisa-laajakaista.fi ([83.245.197.237] helo=localhost)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jarkko.sakkinen@iki.fi>)
        id 1kUFxw-0002fn-5e; Mon, 19 Oct 2020 00:11:44 +0300
Date:   Mon, 19 Oct 2020 00:11:43 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jarkko@kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Hans de Goede <hdegoede@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] tpm_tis: Disable interrupts on ThinkPad T490s
Message-ID: <20201018211143.GC575510@kapsi.fi>
References: <20201015214430.17937-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015214430.17937-1-jsnitsel@redhat.com>
X-SA-Exim-Connect-IP: 83.245.197.237
X-SA-Exim-Mail-From: jarkko.sakkinen@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 15, 2020 at 02:44:30PM -0700, Jerry Snitselaar wrote:
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

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

I'll apply this and make it available in linux-next.

/Jarkko

> ---
>  drivers/char/tpm/tpm_tis.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 0b214963539d..4ed6e660273a 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -27,6 +27,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/kernel.h>
> +#include <linux/dmi.h>
>  #include "tpm.h"
>  #include "tpm_tis_core.h"
>  
> @@ -49,8 +50,8 @@ static inline struct tpm_tis_tcg_phy *to_tpm_tis_tcg_phy(struct tpm_tis_data *da
>  	return container_of(data, struct tpm_tis_tcg_phy, priv);
>  }
>  
> -static bool interrupts = true;
> -module_param(interrupts, bool, 0444);
> +static int interrupts = -1;
> +module_param(interrupts, int, 0444);
>  MODULE_PARM_DESC(interrupts, "Enable interrupts");
>  
>  static bool itpm;
> @@ -63,6 +64,28 @@ module_param(force, bool, 0444);
>  MODULE_PARM_DESC(force, "Force device probe rather than using ACPI entry");
>  #endif
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
>  #if defined(CONFIG_PNP) && defined(CONFIG_ACPI)
>  static int has_hid(struct acpi_device *dev, const char *hid)
>  {
> @@ -192,6 +215,8 @@ static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
>  	int irq = -1;
>  	int rc;
>  
> +	dmi_check_system(tpm_tis_dmi_table);
> +
>  	rc = check_acpi_tpm2(dev);
>  	if (rc)
>  		return rc;
> -- 
> 2.28.0
> 
> 
