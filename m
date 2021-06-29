Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F833B79A9
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jun 2021 23:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhF2VHy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Jun 2021 17:07:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233961AbhF2VHy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jun 2021 17:07:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4601861D8E;
        Tue, 29 Jun 2021 21:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625000726;
        bh=H89tqMOve1E8JhT7/xnfHIoHCDtTVSnl7jHFG7dv45c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fyPWXZ+EcjvShdj4zuFPpdQnuW4dIl7Rwo+jO97sgD0It7LCW30P66DuXU0o2l115
         HPY/XquXYdCpYhxg6D1y7R79Kje+WRHo9i0xvXFDn893fozwj3DHNzQLv3lDzM7CxI
         FLqbkG3Uwoy8Ol2Cp27GilkMEmVtLi2v27WnQF1c+Yc111yMv1npTjH3iTseIu/juV
         NQyW0WwOrROiwkVlEsHwo97MYQfPFLYDF5KuZ8UnUQU87ii3beUtXXKfKah7wNXYmT
         rhhK4f0eaDAbiCT1OV7i+pvhVozLDzffXxVTI3lJpPitU+JVpeNC/6eEmFGgwTSuJP
         nO/0ne319khUg==
Date:   Wed, 30 Jun 2021 00:05:24 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        andrianov@ispras.ru
Subject: Re: [PATCH] char: tpm: vtpm_proxy: Fix race in init
Message-ID: <20210629210524.hze6yb23pps3flnv@kernel.org>
References: <20210623132226.140341-1-saubhik.mukherjee@gmail.com>
 <20210629172700.yxqnedbayumo5f24@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629172700.yxqnedbayumo5f24@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 29, 2021 at 08:27:00PM +0300, Jarkko Sakkinen wrote:
> On Wed, Jun 23, 2021 at 06:52:26PM +0530, Saubhik Mukherjee wrote:
> > vtpm_module_init calls vtpmx_init which calls misc_register. The file
> > operations callbacks are registered. So, vtpmx_fops_ioctl can execute in
> > parallel with rest of vtpm_module_init. vtpmx_fops_ioctl calls
> > vtpmx_ioc_new_dev, which calls vtpm_proxy_create_device, which calls
> > vtpm_proxy_work_start, which could read uninitialized workqueue.
> > 
> > To avoid this, create workqueue before vtpmx init.
> > 
> > Found by Linux Driver Verification project (linuxtesting.org).
> > 
> > Signed-off-by: Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
> > ---
> >  drivers/char/tpm/tpm_vtpm_proxy.c | 19 +++++++++----------
> >  1 file changed, 9 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
> > index 91c772e38bb5..225dfa026a8f 100644
> > --- a/drivers/char/tpm/tpm_vtpm_proxy.c
> > +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
> > @@ -697,23 +697,22 @@ static int __init vtpm_module_init(void)
> >  {
> >  	int rc;
> >  
> > -	rc = vtpmx_init();
> > -	if (rc) {
> > -		pr_err("couldn't create vtpmx device\n");
> > -		return rc;
> > -	}
> > -
> >  	workqueue = create_workqueue("tpm-vtpm");
> >  	if (!workqueue) {
> >  		pr_err("couldn't create workqueue\n");
> > -		rc = -ENOMEM;
> > -		goto err_vtpmx_cleanup;
> > +		return -ENOMEM;
> > +	}
> > +
> > +	rc = vtpmx_init();
> > +	if (rc) {
> > +		pr_err("couldn't create vtpmx device\n");
> > +		goto err_destroy_workqueue;
> >  	}
> >  
> >  	return 0;
> >  
> > -err_vtpmx_cleanup:
> > -	vtpmx_cleanup();
> > +err_destroy_workqueue:
> > +	destroy_workqueue(workqueue);
> >  
> >  	return rc;
> >  }
> > -- 
> > 2.30.2
> > 
> > 
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Taking reviewed-by back.

You're lacking fixes tag. Please re-send with one.

/Jarkko
