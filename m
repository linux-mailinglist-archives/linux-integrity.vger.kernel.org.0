Return-Path: <linux-integrity+bounces-5465-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16269A72D30
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 11:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843B6188EC37
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 09:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAFD20E6FF;
	Thu, 27 Mar 2025 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjKQ+ySO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D31E20E334
	for <linux-integrity@vger.kernel.org>; Thu, 27 Mar 2025 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743069493; cv=none; b=rqIkdD7lqRIuetgxL2BugJAMUycIiT54hSNnor7/h9JVSJ3EMjKVF1DH5FVRbH3+HY4jM3g2yzs5QP+T1CwRvAj5BvLNoxo/z0jUFSPYdZxdEokChBE6X10NZ62mfL/wW1c3qne4QDrJkY0mFTwFbrlKqDvYMqjmxgDZVVYeSUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743069493; c=relaxed/simple;
	bh=vWFcy9MqBkU3MS0rkYQfag+265Y0WSAQStIYd8p8iC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhtnmWhPHXLM2QbTkbzr47kUx7AgrEgKL/OqUvgfx8O1NIiKnQvGE52Ubs3rIhcDOxTobYuX4iQbm0cChMSVkoZA/6dNS4ekBOK2XvSzwfOS/uJl/SoXadfUbzT1HxyCc7ChRMikALV15cYtT099M/qPU8sSbX1sZqjXI0LZuFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZjKQ+ySO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743069490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o5WRdT56UXd0npVrp/2U96P0CSz3ps8f9h79oyQ+jKU=;
	b=ZjKQ+ySOkae061yvvzEAnt+QD+s0sBzrklI8e4/oKosgobYfGE7cI1eE9jB8kWESmV0itQ
	6Bq+x8upQMUYJTGl6Q6KxZ/7LZWH5UH6fO9X81ludtsXPP6dTg2oL1lTfJIki2qxlF+LSr
	5qFGM3qrqFCAIVdvhdAePyBQCHpv1tA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-0EAbkG0wPc2Kp1jsLZ2CBw-1; Thu, 27 Mar 2025 05:58:07 -0400
X-MC-Unique: 0EAbkG0wPc2Kp1jsLZ2CBw-1
X-Mimecast-MFC-AGG-ID: 0EAbkG0wPc2Kp1jsLZ2CBw_1743069486
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac27f00a8a5so58387066b.3
        for <linux-integrity@vger.kernel.org>; Thu, 27 Mar 2025 02:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743069485; x=1743674285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5WRdT56UXd0npVrp/2U96P0CSz3ps8f9h79oyQ+jKU=;
        b=blYVvcUewIbRfTGJn9+/o4as4ChT7/NkPI8AHgtbXgSGG+VscX0V7zjbyfjdFtA8uh
         qDWjIebc1bJszKZf1+TAfI24emAg1xy+7TKOba7Q8c7S9G5LO+uNhFLqWY3nXW2xp8li
         VythafCkwWdGwW6NjGfMKopT3/tAl2qvCHQlAEz0SgLlXiuFCSqm5ccJP+cvnwnukmTA
         4PyLIqppkzFqrajcHagSO/uNhGadlHRul2TxngWt1h8MZxM7whX+wrJFO9sY4jsIZIcb
         x25rKpjtNG8r7dR703TZQP0xUmlvDgZocmqkZb1IUGkuORfHPpYmd1GUvBfxbCX/TSUQ
         cucg==
X-Gm-Message-State: AOJu0Ywmne8vD/9n72h+QES0UBiyGlKoJ/RImXHTvVYVloB02Apd0vdf
	lpHe2B3GgR2RAdhb0QtGJ8a4Yqq1mylJBY19e1M80Sfol3nmV5MqkACfoWwvXXDxvVIQvc2xsL6
	lu6VHfuVUrSViH4dYk5xL+iKAaICMTqrVhxfRKIs7pNTqxIMxPMTGtdEVPqNo5oJ+jKJKrxNEx6
	0f
X-Gm-Gg: ASbGncva/7seIZdVVJivQpjQHgZjB63Imid9c/WDi8gcjVI8YR2I+S8RQLWFxjR4KPY
	UwzG3GG8jV87OrcYRPJLLR/9byGmPNskuWvnvQldQp1j55JjsJbIaggq7bBh6w+pguHX5zjlgpS
	IOTdvMapWkQSKOcJJLqn4gFBYbqm2k9n5mkHDoSKouhQ0nMEi2egr3aDWgrjeD/uy90bUqkHiYX
	fCwCJ0WGN5qGMF2z1zUbmnhMH9/WutZjyT8cSHOAB4BZPP1QMLxULdK6jrMOwv7VadXiUduxipm
	FR8ZIqoemsNvfVRZjgk9lx761SMnhD7ALVbHwVsB+cYUZuJkamJ4vnD+FOKar0xl
X-Received: by 2002:a17:907:1c27:b0:ac2:cf0b:b809 with SMTP id a640c23a62f3a-ac6faefb3c6mr235705366b.31.1743069485423;
        Thu, 27 Mar 2025 02:58:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGFF/kF/t3t8RCCYix4B11GQ276Qy+zARToPx5UPq3eGAAcl4NqTpfSAcxFafRrGcMJ2i/Eg==
X-Received: by 2002:a17:907:1c27:b0:ac2:cf0b:b809 with SMTP id a640c23a62f3a-ac6faefb3c6mr235701966b.31.1743069484718;
        Thu, 27 Mar 2025 02:58:04 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e56dsm1184197466b.37.2025.03.27.02.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 02:58:03 -0700 (PDT)
Date: Thu, 27 Mar 2025 10:58:00 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@kernel.org>, 
	Jens Wiklander <jens.wiklander@linaro.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Make chip->{status,cancel,req_canceled} opt
Message-ID: <exzxzomw7wcobjuoje37x6i2ta54xzx5ho74t3atd7g74xltlb@ymw2pn3yo27b>
References: <20250326161838.123606-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250326161838.123606-1-jarkko@kernel.org>

On Wed, Mar 26, 2025 at 06:18:38PM +0200, Jarkko Sakkinen wrote:
>From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>
>tpm_ftpm_tee does not require chip->status, chip->cancel and
>chip->req_canceled. Make them optional.
>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>---
> drivers/char/tpm/tpm-interface.c | 31 ++++++++++++++++++++++++++++---
> drivers/char/tpm/tpm_ftpm_tee.c  | 20 --------------------
> 2 files changed, 28 insertions(+), 23 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>index f62f7871edbd..10ba47a882d8 100644
>--- a/drivers/char/tpm/tpm-interface.c
>+++ b/drivers/char/tpm/tpm-interface.c
>@@ -58,6 +58,30 @@ unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
> }
> EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
>
>+static void tpm_chip_cancel(struct tpm_chip *chip)
>+{
>+	if (!chip->ops->cancel)
>+		return;
>+
>+	chip->ops->cancel(chip);
>+}
>+
>+static u8 tpm_chip_status(struct tpm_chip *chip)
>+{
>+	if (!chip->ops->status)
>+		return 0;
>+
>+	return chip->ops->status(chip);
>+}
>+
>+static bool tpm_chip_req_canceled(struct tpm_chip *chip, u8 status)
>+{
>+	if (!chip->ops->req_canceled)
>+		return false;
>+
>+	return chip->ops->req_canceled(chip, status);
>+}
>+
> static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> {
> 	struct tpm_header *header = buf;
>@@ -65,6 +89,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> 	ssize_t len = 0;
> 	u32 count, ordinal;
> 	unsigned long stop;
>+	u8 status;

Why move `status` out of the do/while block?

>
> 	if (bufsiz < TPM_HEADER_SIZE)
> 		return -EINVAL;
>@@ -104,12 +129,12 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>

What about doing an early return avoiding also calling
tpm_calc_ordinal_duration()?

I mean something like this:

                 rc = 0;
         }

-       if (chip->flags & TPM_CHIP_FLAG_IRQ)
+       if (!chip->ops->status || chip->flags & TPM_CHIP_FLAG_IRQ)
                 goto out_recv;


Anyway, those are small things, the patch LGTM and it's a great cleanup
for ftpm and the svsm driver I'm developing!


Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


> 	stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
> 	do {
>-		u8 status = chip->ops->status(chip);
>+		status = tpm_chip_status(chip);
> 		if ((status & chip->ops->req_complete_mask) ==
> 		    chip->ops->req_complete_val)
> 			goto out_recv;
>
>-		if (chip->ops->req_canceled(chip, status)) {
>+		if (tpm_chip_req_canceled(chip, status)) {
> 			dev_err(&chip->dev, "Operation Canceled\n");
> 			return -ECANCELED;
> 		}
>@@ -118,7 +143,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> 		rmb();
> 	} while (time_before(jiffies, stop));
>
>-	chip->ops->cancel(chip);
>+	tpm_chip_cancel(chip);
> 	dev_err(&chip->dev, "Operation Timed out\n");
> 	return -ETIME;
>
>diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
>index 8d9209dfc384..53ba28ccd5d3 100644
>--- a/drivers/char/tpm/tpm_ftpm_tee.c
>+++ b/drivers/char/tpm/tpm_ftpm_tee.c
>@@ -164,30 +164,10 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
> 	return 0;
> }
>
>-static void ftpm_tee_tpm_op_cancel(struct tpm_chip *chip)
>-{
>-	/* not supported */
>-}
>-
>-static u8 ftpm_tee_tpm_op_status(struct tpm_chip *chip)
>-{
>-	return 0;
>-}
>-
>-static bool ftpm_tee_tpm_req_canceled(struct tpm_chip *chip, u8 status)
>-{
>-	return false;
>-}
>-
> static const struct tpm_class_ops ftpm_tee_tpm_ops = {
> 	.flags = TPM_OPS_AUTO_STARTUP,
> 	.recv = ftpm_tee_tpm_op_recv,
> 	.send = ftpm_tee_tpm_op_send,
>-	.cancel = ftpm_tee_tpm_op_cancel,
>-	.status = ftpm_tee_tpm_op_status,
>-	.req_complete_mask = 0,
>-	.req_complete_val = 0,
>-	.req_canceled = ftpm_tee_tpm_req_canceled,
> };
>
> /*
>-- 
>2.39.5
>


