Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5ADD1E2F31
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2020 21:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389155AbgEZTir (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 May 2020 15:38:47 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39852 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388900AbgEZTir (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 May 2020 15:38:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6E6578EE181;
        Tue, 26 May 2020 12:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1590521926;
        bh=BI1XnFy6GiuDGMxE6lgdz47UyvtRyqP9U2h3jmKsqVo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PdeECWvKdZ1EFs0jEhQBBF+XSOYThIOu1hN4ZtRv9/Oep67nilQ9mrufZG54k60qE
         KPKS+3b9CkDJ+ZNiqr5xhCRcanxFJcEG2nwT8xov6YwhnFFZrOdNBfnK5Tv+luMWWt
         kbJfUdy+uF5mRU4+nQx6rqq5RpYDyVgn3eKUs6dg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8vkt1A1W0LmP; Tue, 26 May 2020 12:38:46 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 91C988EE0D4;
        Tue, 26 May 2020 12:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1590521926;
        bh=BI1XnFy6GiuDGMxE6lgdz47UyvtRyqP9U2h3jmKsqVo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PdeECWvKdZ1EFs0jEhQBBF+XSOYThIOu1hN4ZtRv9/Oep67nilQ9mrufZG54k60qE
         KPKS+3b9CkDJ+ZNiqr5xhCRcanxFJcEG2nwT8xov6YwhnFFZrOdNBfnK5Tv+luMWWt
         kbJfUdy+uF5mRU4+nQx6rqq5RpYDyVgn3eKUs6dg=
Message-ID: <1590521924.15108.1.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mario.Limonciello@dell.com, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeffrin@rajagiritech.edu.in, alex@guzman.io
Date:   Tue, 26 May 2020 12:38:44 -0700
In-Reply-To: <ccf055cbf1a14f28bc95a6b02e29a2f6@AUSX13MPC105.AMER.DELL.COM>
References: <20200526183213.20720-1-mario.limonciello@dell.com>
         <1590520454.11810.40.camel@HansenPartnership.com>
         <ccf055cbf1a14f28bc95a6b02e29a2f6@AUSX13MPC105.AMER.DELL.COM>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-05-26 at 19:23 +0000, Mario.Limonciello@dell.com wrote:
> > On Tue, 2020-05-26 at 13:32 -0500, Mario Limonciello wrote:
> > > This reverts commit d23d12484307b40eea549b8a858f5fffad913897.
> > > 
> > > This commit has caused regressions for the XPS 9560 containing
> > > a Nuvoton TPM.
> > 
> > Presumably this is using the tis driver?
> 
> Correct.
> 
> > 
> > > As mentioned by the reporter all TPM2 commands are failing with:
> > >   ERROR:tcti:src/tss2-tcti/tcti-
> > > device.c:290:tcti_device_receive()
> > >   Failed to read response from fd 3, got errno 1: Operation not
> > > permitted
> > > 
> > > The reporter bisected this issue back to this commit which was
> > > backported to stable as commit 4d6ebc4.
> > 
> > I think the problem is request_locality ... for some inexplicable
> > reason a failure there returns -1, which is EPERM to user space.
> > 
> > That seems to be a bug in the async code since everything else
> > gives a ESPIPE error if tpm_try_get_ops fails ... at least no-one
> > assumes it gives back a sensible return code.
> > 
> > What I think is happening is that with the patch the TPM goes
> > through a quick sequence of request, relinquish, request,
> > relinquish and it's the third request which is failing (likely
> > timing out).  Without the patch, the patch there's only one
> > request,relinquish cycle because the ops are held while the async
> > work is executed.  I have a vague recollection that there is a
> > problem with too many locality request in quick succession, but
> > I'll defer to Jason, who I think understands the intricacies of
> > localities better than I do.
> 
> Thanks, I don't pretend to understand the nuances of this particular
> code, but I was hoping that the request to revert got some attention
> since Alex's kernel Bugzilla and message a few months ago to linux
> integrity weren't.
> 
> > 
> > If that's the problem, the solution looks simple enough: just move
> > the ops get down because the priv state is already protected by the
> > buffer mutex
> 
> Yeah, if that works for Alex's situation it certainly sounds like a
> better solution than reverting this patch as this patch actually does
> fix a problem reported by Jeffrin originally.
> 
> Could you propose a specific patch that Alex and Jeffrin can perhaps
> both try?

Um, what's wrong with the one I originally attached and which you quote
below?  It's only compile tested, but I think it will work, if the
theory is correct.

James

> > 
> > James
> > 
> > ---
> > 
> > diff --git a/drivers/char/tpm/tpm-dev-common.c
> > b/drivers/char/tpm/tpm-dev-
> > common.c
> > index 87f449340202..1784530b8387 100644
> > --- a/drivers/char/tpm/tpm-dev-common.c
> > +++ b/drivers/char/tpm/tpm-dev-common.c
> > @@ -189,15 +189,6 @@ ssize_t tpm_common_write(struct file *file,
> > const char
> > __user *buf,
> >  		goto out;
> >  	}
> > 
> > -	/* atomic tpm command send and result receive. We only
> > hold the ops
> > -	 * lock during this period so that the tpm can be
> > unregistered even if
> > -	 * the char dev is held open.
> > -	 */
> > -	if (tpm_try_get_ops(priv->chip)) {
> > -		ret = -EPIPE;
> > -		goto out;
> > -	}
> > -
> >  	priv->response_length = 0;
> >  	priv->response_read = false;
> >  	*off = 0;
> > @@ -211,11 +202,19 @@ ssize_t tpm_common_write(struct file *file,
> > const char
> > __user *buf,
> >  	if (file->f_flags & O_NONBLOCK) {
> >  		priv->command_enqueued = true;
> >  		queue_work(tpm_dev_wq, &priv->async_work);
> > -		tpm_put_ops(priv->chip);
> >  		mutex_unlock(&priv->buffer_mutex);
> >  		return size;
> >  	}
> > 
> > +	/* atomic tpm command send and result receive. We only
> > hold the ops
> > +	 * lock during this period so that the tpm can be
> > unregistered even if
> > +	 * the char dev is held open.
> > +	 */
> > +	if (tpm_try_get_ops(priv->chip)) {
> > +		ret = -EPIPE;
> > +		goto out;
> > +	}
> > +
> >  	ret = tpm_dev_transmit(priv->chip, priv->space, priv-
> > > data_buffer,
> > 
> >  			       sizeof(priv->data_buffer));
> >  	tpm_put_ops(priv->chip);

