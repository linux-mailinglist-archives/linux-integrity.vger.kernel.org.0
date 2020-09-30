Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071D127DE63
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 04:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgI3CQt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 22:16:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:51661 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgI3CQt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 22:16:49 -0400
IronPort-SDR: z4hMBw/4a4KkJ+462l9h2iC0mW2nFZVTMKMnI2gaHnoPbyVVX8OiZ6dAxKaQmRNrKExhmKOI/q
 vFjJjrfYA0rg==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="150115776"
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="150115776"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 19:16:46 -0700
IronPort-SDR: pbBCHHkindS+uQ7x1xqq62iOfD+Dgk29ZkEjybqJcOnoZextidcz1Zilsjo5v/WGqnxUdBbZH/
 +s/nQyMu5l5g==
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="457487340"
Received: from xinpan-mobl.ger.corp.intel.com (HELO localhost) ([10.249.35.239])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 19:16:40 -0700
Date:   Wed, 30 Sep 2020 05:16:37 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Hao Wu <hao.wu@rubrik.com>, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        Hamza Attak <hamza@hpe.com>, nayna@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, zohar@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
Message-ID: <20200930021637.GF808399@linux.intel.com>
References: <20200926223150.109645-1-hao.wu@rubrik.com>
 <73405d14d7665e8a4e3e9defde7fb12aeae7784c.camel@HansenPartnership.com>
 <DFD7629C-05BF-46C1-B3D7-92FBBC176D9E@rubrik.com>
 <cf5c8035b7183522fb8a5df4baa95bd24288e61f.camel@HansenPartnership.com>
 <E6E3C07D-57F4-48F5-B4A9-50868B82E779@rubrik.com>
 <0c896ca8eb0e30d6e75843cfbf2aa627ddc63feb.camel@HansenPartnership.com>
 <246A111F-C72C-4CA2-B439-A6BBE0E85087@rubrik.com>
 <ceb230ea03858f5f6c7d77cfd7adea6e9f864699.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceb230ea03858f5f6c7d77cfd7adea6e9f864699.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 28, 2020 at 03:11:39PM -0700, James Bottomley wrote:
> On Sun, 2020-09-27 at 22:59 -0700, Hao Wu wrote:
> [...]
> > > However, there is another possibility: it's something to do with
> > > the byte read; I notice you don't require the same slowdown for the
> > > burst count read, which actually reads the status register and
> > > burst count as a read32.  If that really is the case, for the atmel
> > > would substituting a read32 and just throwing the upper bytes away
> > > in tpm_tis_status() allow us to keep the current timings?  I can
> > > actually try doing this and see if it fixes my nuvoton.
> > 
> > If would be helpful if you can find the solution without reducing
> > performance. I think it is a separate problem to address though.
> > Maybe not worth to mix them in the same fix.
> 
> Well, if it works, no other fix is needed.
> 
> This is what I'm currently trying out on my nuvoton with the timings
> reverted to being those in the vanilla kernel.  So far it hasn't
> crashed, but I haven't run it for long enough to be sure yet.
> 
> James

OK, so the bus does not like one byte reads but prefers full (32-bit)
word reads? I.e. what's the context?

> ---
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 6b884badabe7..c4dbac8edc9b 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -233,9 +233,9 @@ static u8 tpm_tis_status(struct tpm_chip *chip)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  	int rc;
> -	u8 status;
> +	u32 status;
>  
> -	rc = tpm_tis_read8(priv, TPM_STS(priv->locality), &status);
> +	rc = tpm_tis_read32(priv, TPM_STS(priv->locality), &status);
>  	if (rc < 0)
>  		return 0;
>  
> 

/Jarkko
