Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6C53B9C3C
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jul 2021 08:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhGBGl1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Jul 2021 02:41:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhGBGl1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Jul 2021 02:41:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E08A613FB;
        Fri,  2 Jul 2021 06:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625207936;
        bh=JyTuKCLD1I+mEBP/UUmCbI9VqTb4ZjTS2241I8Zw7m8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cEZKplZtL8srXuLJGv/iX8oV+tZDjo1cheBCKnXUX++bzqX7mZnYYaWm8Jm8hvWx5
         L54VLWSk/tMt/F29Pv77LKoK+9GGTpBqW583/Gks9PiZXUhuQN9j6zAZFwz8cAllFC
         zGzuIqJqVKUcAMstY6P8eT3alh2rj8DEdquTIjRcbg+UYA3QeYpG6D68J4FhBIS2E6
         5oRneLbF1t9VIC5b+FSnEFqCnEcHVED638x+FJmWdDN9cOgJJGeAtiyxJpNWBpZTzy
         uEzM+IYnsMcREGx8DZ47EzTMJEMt1NFY0Z5c2qSS//pkUguHD2SVUZTnES+Uf0vXjo
         JD2PpjKD5QdEQ==
Date:   Fri, 2 Jul 2021 09:38:53 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        andrianov@ispras.ru
Subject: Re: [PATCH] char: tpm: vtpm_proxy: Fix race in init
Message-ID: <20210702063853.x27z6yzsdxp7u4y6@kernel.org>
References: <20210623132226.140341-1-saubhik.mukherjee@gmail.com>
 <20210629172700.yxqnedbayumo5f24@kernel.org>
 <20210629210524.hze6yb23pps3flnv@kernel.org>
 <2b7d8d44-791e-284a-a700-5465fbc2c100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b7d8d44-791e-284a-a700-5465fbc2c100@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 30, 2021 at 12:54:30PM +0530, Saubhik Mukherjee wrote:
> On 6/30/21 2:35 AM, Jarkko Sakkinen wrote:
> > On Tue, Jun 29, 2021 at 08:27:00PM +0300, Jarkko Sakkinen wrote:
> > > On Wed, Jun 23, 2021 at 06:52:26PM +0530, Saubhik Mukherjee wrote:
> > > > vtpm_module_init calls vtpmx_init which calls misc_register. The file
> > > > operations callbacks are registered. So, vtpmx_fops_ioctl can execute in
> > > > parallel with rest of vtpm_module_init. vtpmx_fops_ioctl calls
> > > > vtpmx_ioc_new_dev, which calls vtpm_proxy_create_device, which calls
> > > > vtpm_proxy_work_start, which could read uninitialized workqueue.
> > > > 
> > > > To avoid this, create workqueue before vtpmx init.
> > > > 
> > > > Found by Linux Driver Verification project (linuxtesting.org).
> > > > 
> > > > Signed-off-by: Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
> > > > ---
> > > >   drivers/char/tpm/tpm_vtpm_proxy.c | 19 +++++++++----------
> > > >   1 file changed, 9 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
> > > > index 91c772e38bb5..225dfa026a8f 100644
> > > > --- a/drivers/char/tpm/tpm_vtpm_proxy.c
> > > > +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
> > > > @@ -697,23 +697,22 @@ static int __init vtpm_module_init(void)
> > > >   {
> > > >   	int rc;
> > > > -	rc = vtpmx_init();
> > > > -	if (rc) {
> > > > -		pr_err("couldn't create vtpmx device\n");
> > > > -		return rc;
> > > > -	}
> > > > -
> > > >   	workqueue = create_workqueue("tpm-vtpm");
> > > >   	if (!workqueue) {
> > > >   		pr_err("couldn't create workqueue\n");
> > > > -		rc = -ENOMEM;
> > > > -		goto err_vtpmx_cleanup;
> > > > +		return -ENOMEM;
> > > > +	}
> > > > +
> > > > +	rc = vtpmx_init();
> > > > +	if (rc) {
> > > > +		pr_err("couldn't create vtpmx device\n");
> > > > +		goto err_destroy_workqueue;
> > > >   	}
> > > >   	return 0;
> > > > -err_vtpmx_cleanup:
> > > > -	vtpmx_cleanup();
> > > > +err_destroy_workqueue:
> > > > +	destroy_workqueue(workqueue);
> > > >   	return rc;
> > > >   }
> > > > -- 
> > > > 2.30.2
> > > > 
> > > > 
> > > 
> > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > Taking reviewed-by back.
> > 
> > You're lacking fixes tag. Please re-send with one.
> > 
> > /Jarkko
> > 
> 
> Thank you for noticing. I sent the patch containing the Fixes tag in reply
> to your last message. (https://lkml.org/lkml/2021/6/30/104)

Please do not do that. Instead, version your patches (git format-patch -vX)
and send them as separate threads.

It's all documented: https://www.kernel.org/doc/html/v5.13/process/submitting-patches.html

/Jarkko
