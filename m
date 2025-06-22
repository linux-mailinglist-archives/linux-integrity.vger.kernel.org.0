Return-Path: <linux-integrity+bounces-6496-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62753AE3217
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Jun 2025 22:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232EA188DF93
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Jun 2025 20:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC141F0991;
	Sun, 22 Jun 2025 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="DfX1QEZH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F356C30E841;
	Sun, 22 Jun 2025 20:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750625591; cv=none; b=hwQ/IfCi+E+oChrAiBxXXhtYhUOOv1jDyP6dQprxhcp7eZ0NnLk/3Fm77N0eAPCXidXoTcck4h8pwGOgi2rreuE2XLsAZYJjgVpQtsdC8Cp3RTIvRYJS6dXK4VIsqJRQc+N6BAt/4zVNXcOXBV8W8B8mLGYBz4x7sLe31Mv3cQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750625591; c=relaxed/simple;
	bh=JJyj3mo8oKEq4wZ4Dv10w5hdo1/sXliZGlZgrk5/K3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fr49PyM4HDV8TiijttvDVzvmOtVyz5Jz3YWwj6+2C71yQQ5fL2lWJGDPyBwjNfwU5q9DZIiwoYHe5ziMro2Gvy59y/oaK8zdF1Enx8zcWP5UHUadeY46X7v8tEYPSEOWiGWRqhKxJdv3TeqKSdHDLNQx6ORdhy3+JZ8WG+dcHc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=DfX1QEZH; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=D3O7Y2Dq8XWvhCk7TsV976q3evuoHtvC9Y/E+MQrHn0=; b=DfX1QEZH7Ptiv4qhoqSdtKXqHM
	4F2V7bhJK9praia6z+rjV6ZwRHSca9SoGMQltZQyPL1Jtkx4qhNGRGoDYCsKki3FmIt36pOsbca5H
	3zjlSuLg4ywuLP11REUXei4kDqJIkuA6WQmGzRxdwoXxRo6v0BII2atdPP45KVg7uibZtusFz44RE
	RpkR+0s4Kw3RmeV2yLEAnpMB/DmBJZLebSdTtJVlFfvrtAXDuvyXkTEmRVyK+nH9v1Znus2YB4asX
	WR4+urJs73PoSq2X9Tn68D8LW5HEZCBcVdZI6woRQZB6AhZoA4787IWl/cteC6l18ANXQsMmhRwd/
	BnbD8Sew==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1uTRgQ-00GUWB-1U;
	Sun, 22 Jun 2025 21:52:58 +0100
Date: Sun, 22 Jun 2025 21:52:58 +0100
From: Jonathan McDowell <noodles@earth.li>
To: "Orlov, Ivan" <iorlov@amazon.co.uk>
Cc: "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
	"jarkko@kernel.org" <jarkko@kernel.org>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [PATCH v2] tpm: Fix the timeout & use ktime
Message-ID: <aFhtKrWTDzZbpTSh@earth.li>
References: <20250620180828.98413-1-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250620180828.98413-1-iorlov@amazon.com>

On Fri, Jun 20, 2025 at 06:08:31PM +0000, Orlov, Ivan wrote:
>The current implementation of timeout detection works in the following
>way:
>
>1. Read completion status. If completed, return the data
>2. Sleep for some time (usleep_range)
>3. Check for timeout using current jiffies value. Return an error if
>   timed out
>4. Goto 1
>
>usleep_range doesn't guarantee it's always going to wake up strictly in
>(min, max) range, so such a situation is possible:
>
>1. Driver reads completion status. No completion yet
>2. Process sleeps indefinitely. In the meantime, TPM responds
>3. We check for timeout without checking for the completion again.
>   Result is lost.
>
>Such a situation also happens for the guest VMs: if vCPU goes to sleep
>and doesn't get scheduled for some time, the guest TPM driver will
>timeout instantly after waking up without checking for the completion
>(which may already be in place).
>
>Perform the completion check once again after exiting the busy loop in
>order to give the device the last chance to send us some data.
>
>Since now we check for completion in two places, extract this check into
>a separate function.
>
>Signed-off-by: Ivan Orlov <iorlov@amazon.com>
>---
>V1 -> V2:
>- Exclude the jiffies -> ktime change from the patch
>- Instead of recording the time before checking for completion, check
>  for completion once again after leaving the loop
>
> drivers/char/tpm/tpm-interface.c | 17 +++++++++++++++--
> 1 file changed, 15 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>index 8d7e4da6ed53..6960ee2798e1 100644
>--- a/drivers/char/tpm/tpm-interface.c
>+++ b/drivers/char/tpm/tpm-interface.c
>@@ -82,6 +82,13 @@ static bool tpm_chip_req_canceled(struct tpm_chip *chip, u8 status)
> 	return chip->ops->req_canceled(chip, status);
> }
>
>+static bool tpm_transmit_completed(struct tpm_chip *chip)
>+{
>+	u8 status_masked = tpm_chip_status(chip) & chip->ops->req_complete_mask;
>+
>+	return status_masked == chip->ops->req_complete_val;
>+}
>+
> static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> {
> 	struct tpm_header *header = buf;
>@@ -129,8 +136,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> 	stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
> 	do {
> 		u8 status = tpm_chip_status(chip);
>-		if ((status & chip->ops->req_complete_mask) ==
>-		    chip->ops->req_complete_val)
>+		if (tpm_transmit_completed(chip))
> 			goto out_recv;

The only thing I'd point out here is we end up doing a double status 
read one after the other (once here, once in tpm_transmit_completed), 
and I'm pretty sure I've seen instances where that caused a problem.

> 		if (tpm_chip_req_canceled(chip, status)) {
>@@ -142,6 +148,13 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> 		rmb();
> 	} while (time_before(jiffies, stop));
>
>+	/*
>+	 * Check for completion one more time, just in case the device reported
>+	 * it while the driver was sleeping in the busy loop above.
>+	 */
>+	if (tpm_transmit_completed(chip))
>+		goto out_recv;
>+
> 	tpm_chip_cancel(chip);
> 	dev_err(&chip->dev, "Operation Timed out\n");
> 	return -ETIME;

J.

-- 
She's the one for me. She's all I really need, oh yeah.
This .sig brought to you by the letter K and the number  3
Product of the Republic of HuggieTag

