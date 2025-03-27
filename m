Return-Path: <linux-integrity+bounces-5474-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB647A7334D
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 14:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C800D18885F4
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 13:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F8C2147F1;
	Thu, 27 Mar 2025 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQRkdeck"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E169A1BC41;
	Thu, 27 Mar 2025 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743081825; cv=none; b=UaWR6L5ZPPLhxJw9sZ+ngAstL/layuHYJDdCuIjdt+y8lwroxezQqvVhcP/kQz8qWMVBOTYASlMLTMIU0HISYb7ZFodZsG02Xr4q2lbfel66JgiwHnSHme5Mqu20eg8MoAQo8JXxf+Z5rCKK/0SS2kfIxZbz7ZtI7TML2hNv+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743081825; c=relaxed/simple;
	bh=y4sLP3up9sPxue2DFidmSkL/uvEDHl5tUByPUffOcQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpV3q5WqNL+7AsZO8cxmDt9roz4RYbAPPM+npCnXhDqXzV5Xk9nrdgk+jPzEGH9C2I0CVbHb0sfk8stAgMh8YhaTtRVXniiS1zEdIfIAFRzI1HbkkBiwluuTO3FsrYtDdBmUJ6eStx1zCctQxXi71PuuEy+WSLnam2hMY9eQ+EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQRkdeck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD220C4CEDD;
	Thu, 27 Mar 2025 13:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743081823;
	bh=y4sLP3up9sPxue2DFidmSkL/uvEDHl5tUByPUffOcQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SQRkdecksjP6KSgis+IA69h4EdAde5LXfB08RrWwUa4ElMt5i5iarcVVAvB5B0RSl
	 gW4kWzf7Ctll/Vj7NA/udauY2A7yM+3y4ctZkZweiddLZlCVDOaZGRKcTyUReOzg5f
	 n8OW9jz+HRJMS+5MC+fU52+9RGFCy/Zhfz2zsRjUjjYOvCycgXfBITK18JGLoWX2Vr
	 i+GQECpQGoPAezTUs0SFSbk4CSn0XM3Brn5ljYhKeaYGd6HafdGjNsMt/HBNPEsTY3
	 uLYdMQf3cn+M9jda/gQIpe6sSTKIonqHFFH42A7UamPSSvoiY7jt+UMN6WB72chbe+
	 f+ztypGkVtqug==
Date: Thu, 27 Mar 2025 15:23:39 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Make chip->{status,cancel,req_canceled} opt
Message-ID: <Z-VRWy8jLkA0cpow@kernel.org>
References: <20250326161838.123606-1-jarkko@kernel.org>
 <exzxzomw7wcobjuoje37x6i2ta54xzx5ho74t3atd7g74xltlb@ymw2pn3yo27b>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <exzxzomw7wcobjuoje37x6i2ta54xzx5ho74t3atd7g74xltlb@ymw2pn3yo27b>

On Thu, Mar 27, 2025 at 10:58:00AM +0100, Stefano Garzarella wrote:
> On Wed, Mar 26, 2025 at 06:18:38PM +0200, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > 
> > tpm_ftpm_tee does not require chip->status, chip->cancel and
> > chip->req_canceled. Make them optional.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > ---
> > drivers/char/tpm/tpm-interface.c | 31 ++++++++++++++++++++++++++++---
> > drivers/char/tpm/tpm_ftpm_tee.c  | 20 --------------------
> > 2 files changed, 28 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > index f62f7871edbd..10ba47a882d8 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -58,6 +58,30 @@ unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
> > }
> > EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
> > 
> > +static void tpm_chip_cancel(struct tpm_chip *chip)
> > +{
> > +	if (!chip->ops->cancel)
> > +		return;
> > +
> > +	chip->ops->cancel(chip);
> > +}
> > +
> > +static u8 tpm_chip_status(struct tpm_chip *chip)
> > +{
> > +	if (!chip->ops->status)
> > +		return 0;
> > +
> > +	return chip->ops->status(chip);
> > +}
> > +
> > +static bool tpm_chip_req_canceled(struct tpm_chip *chip, u8 status)
> > +{
> > +	if (!chip->ops->req_canceled)
> > +		return false;
> > +
> > +	return chip->ops->req_canceled(chip, status);
> > +}
> > +
> > static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> > {
> > 	struct tpm_header *header = buf;
> > @@ -65,6 +89,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> > 	ssize_t len = 0;
> > 	u32 count, ordinal;
> > 	unsigned long stop;
> > +	u8 status;
> 
> Why move `status` out of the do/while block?

I'm not a huge fan of stack allocations inside blocks, unless there is
a particular reason to do so.


> 
> > 
> > 	if (bufsiz < TPM_HEADER_SIZE)
> > 		return -EINVAL;
> > @@ -104,12 +129,12 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> > 
> 
> What about doing an early return avoiding also calling
> tpm_calc_ordinal_duration()?
> 
> I mean something like this:
> 
>                 rc = 0;
>         }
> 
> -       if (chip->flags & TPM_CHIP_FLAG_IRQ)
> +       if (!chip->ops->status || chip->flags & TPM_CHIP_FLAG_IRQ)
>                 goto out_recv;
> 
> 
> Anyway, those are small things, the patch LGTM and it's a great cleanup
> for ftpm and the svsm driver I'm developing!

If you refined send() and had that the sync flag, this would become:

	if (chip->flags & (TPM_CHIP_FLAG_IRQ | TPM_CHIP_FLAG_SYNC))
		goto out_recv;

> 
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thank you.


> 
> 
> > 	stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
> > 	do {
> > -		u8 status = chip->ops->status(chip);
> > +		status = tpm_chip_status(chip);
> > 		if ((status & chip->ops->req_complete_mask) ==
> > 		    chip->ops->req_complete_val)
> > 			goto out_recv;
> > 
> > -		if (chip->ops->req_canceled(chip, status)) {
> > +		if (tpm_chip_req_canceled(chip, status)) {
> > 			dev_err(&chip->dev, "Operation Canceled\n");
> > 			return -ECANCELED;
> > 		}
> > @@ -118,7 +143,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> > 		rmb();
> > 	} while (time_before(jiffies, stop));
> > 
> > -	chip->ops->cancel(chip);
> > +	tpm_chip_cancel(chip);
> > 	dev_err(&chip->dev, "Operation Timed out\n");
> > 	return -ETIME;
> > 
> > diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> > index 8d9209dfc384..53ba28ccd5d3 100644
> > --- a/drivers/char/tpm/tpm_ftpm_tee.c
> > +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> > @@ -164,30 +164,10 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
> > 	return 0;
> > }
> > 
> > -static void ftpm_tee_tpm_op_cancel(struct tpm_chip *chip)
> > -{
> > -	/* not supported */
> > -}
> > -
> > -static u8 ftpm_tee_tpm_op_status(struct tpm_chip *chip)
> > -{
> > -	return 0;
> > -}
> > -
> > -static bool ftpm_tee_tpm_req_canceled(struct tpm_chip *chip, u8 status)
> > -{
> > -	return false;
> > -}
> > -
> > static const struct tpm_class_ops ftpm_tee_tpm_ops = {
> > 	.flags = TPM_OPS_AUTO_STARTUP,
> > 	.recv = ftpm_tee_tpm_op_recv,
> > 	.send = ftpm_tee_tpm_op_send,
> > -	.cancel = ftpm_tee_tpm_op_cancel,
> > -	.status = ftpm_tee_tpm_op_status,
> > -	.req_complete_mask = 0,
> > -	.req_complete_val = 0,
> > -	.req_canceled = ftpm_tee_tpm_req_canceled,
> > };
> > 
> > /*
> > -- 
> > 2.39.5
> > 
> 

BR, Jarkko

