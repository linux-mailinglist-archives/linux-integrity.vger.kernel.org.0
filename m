Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16E7289F39
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Aug 2019 15:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfHLNKG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Aug 2019 09:10:06 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44927 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbfHLNKG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Aug 2019 09:10:06 -0400
Received: by mail-qk1-f196.google.com with SMTP id d79so76752303qke.11
        for <linux-integrity@vger.kernel.org>; Mon, 12 Aug 2019 06:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=likbUpy+hqGKJ+aVkUc0jeuI5OoHP9NpOwWastRmABc=;
        b=kMK9LpmiWRr60D1T45SSevOv2vlXHiDiuiZf4ulsSujUTJizy0pUz3kKtJ7qNNGElj
         mFCM6EpcfkE6SAynb+2ABW1IUSVqv2ssditwGlUOMmvdLgN1O01qru86vwQGjt+PtEcw
         yCn6ptRF+oQZfo9bCTN+M7VWA/LinJSYRnBoCCzIhLilDCp9A+WNZUvoYIQch03LkiyW
         UCAF0avgTHRqAP6fpSSdLw5TOSHhg0FRWpCrCjIBz6vBgjj5BFqOsozA1HSfhsf37z88
         GlNWxbskvtCvJaIoLD5/kiOmhDqKuvUYuNv8F3UdSBXmES59wTP1s/FuIEgyxkN33U0M
         QDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=likbUpy+hqGKJ+aVkUc0jeuI5OoHP9NpOwWastRmABc=;
        b=qIZ4/yEnyn08ABGLW7mgXmX3eMjIpZ+VHiYklc7px0w/UyI8jU4E3DXBDyVU26En0T
         E5JSsmPXfRFLxOvRaXmxku2hcV/p7aqvWQCtTXMk6C2dZJqfveGvYlHFGzkCA3rzWwd7
         +yHpD5XdC5lxnUPNf3mIaNNLglGbTbRnbKnW7qWJUB2UBBHV5mqSTcF0qg0hrLTVzkd+
         oOC5ibk3R3Xp+Sr8I2V26vadUqg/FUDO1Iis9wGS6XkwaGXX5BH5+hns3qZa/fEOmawl
         O6bTCYwfF5s0Iy9ATxp3lUzZoLbciPwDL/aUR1w30DwxNYKrvotQvcy71olXA1b5g5ZG
         aKxQ==
X-Gm-Message-State: APjAAAUlsuKHOzBTfiDB9wJwV3JzT7oXTssTvOjWS5R2GRjIqh/8N8hY
        YrRfgcywt9XK2AO9zBmHelR0rg==
X-Google-Smtp-Source: APXvYqzGPtJIkSMQQNtzwkSQiuzOThChzk/aOVnFzsP0ZJUn84TcNwpdr4gmvQMUHX5Di1/LtzK0ZA==
X-Received: by 2002:a37:b381:: with SMTP id c123mr30501028qkf.349.1565615404632;
        Mon, 12 Aug 2019 06:10:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id h26sm60899009qta.58.2019.08.12.06.10.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 06:10:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hxA5L-0007Yr-Q4; Mon, 12 Aug 2019 10:10:03 -0300
Date:   Mon, 12 Aug 2019 10:10:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     ivan.lazeev@gmail.com
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Fix fTPM on AMD Zen+ CPUs
Message-ID: <20190812131003.GF24457@ziepe.ca>
References: <20190811185218.16893-1-ivan.lazeev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811185218.16893-1-ivan.lazeev@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Aug 11, 2019 at 09:52:18PM +0300, ivan.lazeev@gmail.com wrote:
> From: Vanya Lazeev <ivan.lazeev@gmail.com>
> 
> The patch is an attempt to make fTPM on AMD Zen CPUs work.
> Bug link: https://bugzilla.kernel.org/show_bug.cgi?id=195657
> 
> The problem seems to be that tpm_crb driver doesn't expect tpm command
> and response memory regions to belong to different ACPI resources.
> 
> Tested on Asrock ITX motherboard with Ryzen 2600X CPU.
> However, I don't have any other hardware to test the changes on and no
> expertise to be sure that other TPMs won't break as a result.
> Hopefully, the patch will be useful.
> 
> Changes from v1:
> - use list_for_each_safe
> 
> Signed-off-by: Vanya Lazeev <ivan.lazeev@gmail.com>
>  drivers/char/tpm/tpm_crb.c | 146 ++++++++++++++++++++++++++++---------
>  1 file changed, 110 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index e59f1f91d..b0e797464 100644
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -91,7 +91,6 @@ enum crb_status {
>  struct crb_priv {
>  	u32 sm;
>  	const char *hid;
> -	void __iomem *iobase;
>  	struct crb_regs_head __iomem *regs_h;
>  	struct crb_regs_tail __iomem *regs_t;
>  	u8 __iomem *cmd;
> @@ -108,6 +107,13 @@ struct tpm2_crb_smc {
>  	u32 smc_func_id;
>  };
>  
> +struct crb_resource {
> +	struct resource io_res;
> +	void __iomem *iobase;
> +
> +	struct list_head link;
> +};
> +
>  static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
>  				unsigned long timeout)
>  {
> @@ -432,23 +438,69 @@ static const struct tpm_class_ops tpm_crb = {
>  	.req_complete_val = CRB_DRV_STS_COMPLETE,
>  };
>  
> +static void crb_free_resource_list(struct list_head *resources)
> +{
> +	struct list_head *position, *tmp;
> +
> +	list_for_each_safe(position, tmp, resources)
> +		kfree(list_entry(position, struct crb_resource, link));
> +}
> +
> +/**
> + * Checks if resource @io_res contains range with the specified @start and @size
> + * completely or, when @strict is false, at least it's beginning.
> + * Non-strict match is needed to work around broken BIOSes that return
> + * inconsistent values from ACPI regions vs registers.
> + */
> +static inline bool crb_resource_contains(const struct resource *io_res,
> +					 u64 start, u32 size, bool strict)
> +{
> +	return start >= io_res->start &&
> +		(start + size - 1 <= io_res->end ||
> +		 (!strict && start <= io_res->end));
> +}
> +
> +static struct crb_resource *crb_containing_resource(
> +		const struct list_head *resources,
> +		u64 start, u32 size, bool strict)
> +{
> +	struct list_head *pos;
> +
> +	list_for_each(pos, resources) {
> +		struct crb_resource *cres;
> +
> +		cres = list_entry(pos, struct crb_resource, link);
> +		if (crb_resource_contains(&cres->io_res, start, size, strict))
> +			return cres;
> +	}
> +
> +	return NULL;
> +}

This flow seems very strange, why isn't this part of crb_map_res?

>  static int crb_check_resource(struct acpi_resource *ares, void *data)
>  {
> -	struct resource *io_res = data;
> +	struct list_head *list = data;
> +	struct crb_resource *cres;
>  	struct resource_win win;
>  	struct resource *res = &(win.res);
>  
>  	if (acpi_dev_resource_memory(ares, res) ||
>  	    acpi_dev_resource_address_space(ares, &win)) {
> -		*io_res = *res;
> -		io_res->name = NULL;
> +		cres = kzalloc(sizeof(*cres), GFP_KERNEL);
> +		if (!cres)
> +			return -ENOMEM;
> +
> +		cres->io_res = *res;
> +		cres->io_res.name = NULL;
> +
> +		list_add_tail(&cres->link, list);

And why is this allocating memory inside the acpi table walker? It
seems to me like the memory should be allocated once the mapping is
made.

Maybe all the mappings should be created from the ACPI ranges right
away?

> @@ -460,10 +512,16 @@ static void __iomem *crb_map_res(struct device *dev, struct crb_priv *priv,
>  	if (start != new_res.start)
>  		return (void __iomem *) ERR_PTR(-EINVAL);
>  
> -	if (!resource_contains(io_res, &new_res))
> +	if (!cres)
>  		return devm_ioremap_resource(dev, &new_res);
>  
> -	return priv->iobase + (new_res.start - io_res->start);
> +	if (!cres->iobase) {
> +		cres->iobase = devm_ioremap_resource(dev, &cres->io_res);
> +		if (IS_ERR(cres->iobase))
> +			return cres->iobase;
> +	}

It sounds likethe real bug is that the crb_map_res only considers a
single active mapping, while these AMD chips need more than one?

Jason
