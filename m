Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEB848AAAB
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Aug 2019 00:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfHLWmz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Aug 2019 18:42:55 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37344 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbfHLWmz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Aug 2019 18:42:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id f22so2417798edt.4;
        Mon, 12 Aug 2019 15:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QUBJRxxlBoKDOtPGvaYl0LzRCrQs93fgZbNJb9pzsVM=;
        b=HutFIDTYL6kWqcxuk2ZOU+gDDGZ7sptzDfhcTBXelsnOypyUhBliP1BKGfVK7K/eXX
         u7gD3mE7UrrKY7GXmP3Prr8gL2QbxVVfTn3BCFRHqVwcrMk6icYvKuK6APeWtNBAEzR+
         UlkVljHdlauattZbAVzeKEUrxcxN9QcqLTcxBDukDv6wivnIF8kzo+zNkxm/zfcqI0ww
         ocsROxYgoun1TnHNxNeC7BkLBFQCE12jt7i3SchntHdfDUDRcxj0KA0P1nSiDyd6vVEb
         hqkry+jMlDulUzlMkdKCseTmoWHKWzFvyMCLTp0BCGOR/5tPkeGsuZfcLWewMJhdjCuB
         D35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QUBJRxxlBoKDOtPGvaYl0LzRCrQs93fgZbNJb9pzsVM=;
        b=UAaM+tDZQDvtyoBnbHIN42z3Ok7kx4iPlmDoHMyZyJk2ZXJXxjfXY5eNkWQCANFoCl
         e0QiSbA1nhATdV0WDiiBWWdnIoYv8wQDleOFt1iuNAiNRmuyXWoaNSqg6jRipi5WZbZ9
         PNQa1n+t8PLABEu+ufIDpAUVjc1pNbT+2xmWJOtvrKR6hWj0TsFLIP2Ey1XDQ3GPXsE6
         JVOKbUQm9BHGARigN5FnpNUBc6X1CSTuIUCaqsvVCCwkAmUxfO/LunloRF4+7RB5DcrS
         2vh5w/J/JRmiWCDOe9uvls8kQhsFRnUkWSiSHINFf24YSafDZpWWg4uQApicmPoS/JEr
         +2Jw==
X-Gm-Message-State: APjAAAVWzUVonBgHdSvDCXrPjQbf1gNtszaNfcsVsElr5AaiV81LhupX
        WesGEwpo2tzHofoBSh7oXCMscYhTtKoH+g==
X-Google-Smtp-Source: APXvYqyiLsbdP8VKcYz03FlnTneDzOyiHyRZD/jSMbxNrgMsudDeBN5ao3nvCdNwNsL7PQl5cblO0Q==
X-Received: by 2002:a05:6402:1244:: with SMTP id l4mr115209edw.117.1565649773120;
        Mon, 12 Aug 2019 15:42:53 -0700 (PDT)
Received: from tazik.netherland ([188.187.106.181])
        by smtp.gmail.com with ESMTPSA id z9sm3202067edd.18.2019.08.12.15.42.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 15:42:53 -0700 (PDT)
Date:   Tue, 13 Aug 2019 01:42:42 +0300
From:   Vanya Lazeev <ivan.lazeev@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Fix fTPM on AMD Zen+ CPUs
Message-ID: <20190812224242.GA3865@tazik.netherland>
References: <20190811185218.16893-1-ivan.lazeev@gmail.com>
 <20190812131003.GF24457@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812131003.GF24457@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 12, 2019 at 10:10:03AM -0300, Jason Gunthorpe wrote:
> On Sun, Aug 11, 2019 at 09:52:18PM +0300, ivan.lazeev@gmail.com wrote:
> > From: Vanya Lazeev <ivan.lazeev@gmail.com>
> > 
> > The patch is an attempt to make fTPM on AMD Zen CPUs work.
> > Bug link: https://bugzilla.kernel.org/show_bug.cgi?id=195657
> > 
> > The problem seems to be that tpm_crb driver doesn't expect tpm command
> > and response memory regions to belong to different ACPI resources.
> > 
> > Tested on Asrock ITX motherboard with Ryzen 2600X CPU.
> > However, I don't have any other hardware to test the changes on and no
> > expertise to be sure that other TPMs won't break as a result.
> > Hopefully, the patch will be useful.
> > 
> > Changes from v1:
> > - use list_for_each_safe
> > 
> > Signed-off-by: Vanya Lazeev <ivan.lazeev@gmail.com>
> >  drivers/char/tpm/tpm_crb.c | 146 ++++++++++++++++++++++++++++---------
> >  1 file changed, 110 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> > index e59f1f91d..b0e797464 100644
> > +++ b/drivers/char/tpm/tpm_crb.c
> > @@ -91,7 +91,6 @@ enum crb_status {
> >  struct crb_priv {
> >  	u32 sm;
> >  	const char *hid;
> > -	void __iomem *iobase;
> >  	struct crb_regs_head __iomem *regs_h;
> >  	struct crb_regs_tail __iomem *regs_t;
> >  	u8 __iomem *cmd;
> > @@ -108,6 +107,13 @@ struct tpm2_crb_smc {
> >  	u32 smc_func_id;
> >  };
> >  
> > +struct crb_resource {
> > +	struct resource io_res;
> > +	void __iomem *iobase;
> > +
> > +	struct list_head link;
> > +};
> > +
> >  static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
> >  				unsigned long timeout)
> >  {
> > @@ -432,23 +438,69 @@ static const struct tpm_class_ops tpm_crb = {
> >  	.req_complete_val = CRB_DRV_STS_COMPLETE,
> >  };
> >  
> > +static void crb_free_resource_list(struct list_head *resources)
> > +{
> > +	struct list_head *position, *tmp;
> > +
> > +	list_for_each_safe(position, tmp, resources)
> > +		kfree(list_entry(position, struct crb_resource, link));
> > +}
> > +
> > +/**
> > + * Checks if resource @io_res contains range with the specified @start and @size
> > + * completely or, when @strict is false, at least it's beginning.
> > + * Non-strict match is needed to work around broken BIOSes that return
> > + * inconsistent values from ACPI regions vs registers.
> > + */
> > +static inline bool crb_resource_contains(const struct resource *io_res,
> > +					 u64 start, u32 size, bool strict)
> > +{
> > +	return start >= io_res->start &&
> > +		(start + size - 1 <= io_res->end ||
> > +		 (!strict && start <= io_res->end));
> > +}
> > +
> > +static struct crb_resource *crb_containing_resource(
> > +		const struct list_head *resources,
> > +		u64 start, u32 size, bool strict)
> > +{
> > +	struct list_head *pos;
> > +
> > +	list_for_each(pos, resources) {
> > +		struct crb_resource *cres;
> > +
> > +		cres = list_entry(pos, struct crb_resource, link);
> > +		if (crb_resource_contains(&cres->io_res, start, size, strict))
> > +			return cres;
> > +	}
> > +
> > +	return NULL;
> > +}
> 
> This flow seems very strange, why isn't this part of crb_map_res?
> 

fTPM on Zen+ not only needs multiple mappings, it can also return
inconsistent with ACPI values for range sizes (as for me and
mikajhe from the bug thread), so results of crb_containing_resource 
are also used to fix the inconsistencies with crb_fixup_cmd_size.

> >  static int crb_check_resource(struct acpi_resource *ares, void *data)
> >  {
> > -	struct resource *io_res = data;
> > +	struct list_head *list = data;
> > +	struct crb_resource *cres;
> >  	struct resource_win win;
> >  	struct resource *res = &(win.res);
> >  
> >  	if (acpi_dev_resource_memory(ares, res) ||
> >  	    acpi_dev_resource_address_space(ares, &win)) {
> > -		*io_res = *res;
> > -		io_res->name = NULL;
> > +		cres = kzalloc(sizeof(*cres), GFP_KERNEL);
> > +		if (!cres)
> > +			return -ENOMEM;
> > +
> > +		cres->io_res = *res;
> > +		cres->io_res.name = NULL;
> > +
> > +		list_add_tail(&cres->link, list);
> 
> And why is this allocating memory inside the acpi table walker? It
> seems to me like the memory should be allocated once the mapping is
> made.
> 

Yes, this looks bad. Letting the walker build the list and then using
it is, probably, a better idea.

> Maybe all the mappings should be created from the ACPI ranges right
> away?
> 

I don't know if it's a good idea to just map them all instead of doing 
so only for relevant ones. Maybe it is safe, here I need an advice
from a more knowledgeable person.

> > @@ -460,10 +512,16 @@ static void __iomem *crb_map_res(struct device *dev, struct crb_priv *priv,
> >  	if (start != new_res.start)
> >  		return (void __iomem *) ERR_PTR(-EINVAL);
> >  
> > -	if (!resource_contains(io_res, &new_res))
> > +	if (!cres)
> >  		return devm_ioremap_resource(dev, &new_res);
> >  
> > -	return priv->iobase + (new_res.start - io_res->start);
> > +	if (!cres->iobase) {
> > +		cres->iobase = devm_ioremap_resource(dev, &cres->io_res);
> > +		if (IS_ERR(cres->iobase))
> > +			return cres->iobase;
> > +	}
> 
> It sounds likethe real bug is that the crb_map_res only considers a
> single active mapping, while these AMD chips need more than one?
> 

Yes, this seems to be the issue.
