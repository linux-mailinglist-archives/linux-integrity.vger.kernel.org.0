Return-Path: <linux-integrity+bounces-6698-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9F2B0E217
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jul 2025 18:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1581C81591
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jul 2025 16:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E071727CCC7;
	Tue, 22 Jul 2025 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="bac53ywu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D15B25A33F;
	Tue, 22 Jul 2025 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753202690; cv=none; b=NFmusuGJswvozhTHuA9w3Ox3udIJ8UymWgPbSTj29yTtrIMW98kzXPPnZZ8Xrro3NUFnN9gQtjg64xhZKKeHZGp7CPsCTnqgXNibVfpmVD2FBfcg1FIxNwUps1CwXSR7vTp1J/KO7ihAx2F7Nu07LVPvF1Dvr/mEmgdBceMDhL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753202690; c=relaxed/simple;
	bh=/J187Y7xzslmxfUFWBXu1BQPsE8yhA9RZTq8b1VBKqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4Dt/v2swuJAq5KM9tlTt9CYATF3uyQZXjGAawCgXLOu+mIWBN+bW89gLGEVPjvZ874APAMGVlIh1llmky4+mp6zZH4y/UuNlsLgAsiT5BcO4t2pNWSkSxBfb0PtOWiGsjWO++Y68IUjcZG23edOpRBSawgLa1gG0fg4wPnypXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=bac53ywu; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Q7ot06XHSdA+9CooHLue7LWbJ8w8edhGUBCYEoQ+gec=; b=bac53ywuj0Sj2uWrhpXEl//Ukg
	u1qO4uIz2zpfTawhqbR3JgbM+IhoDGu38SV9WUV5++56smwYIURpQ4bpjnqs2DNj25J8LF9v8T0HU
	DgUhELAVaIYXRmhuvvGjD1q812M4eSSFc+4lQ82SSLv9tdH4A6f8yw3RSXNohomd0q0/uVKtmsplz
	psS3tTOg3MpcKobgXDE8s6pndqYKCUtZA9D7nk7/lCMmSKfegj3JLn8mz/lSQTGbTnfjQHaNNcjrB
	NPpZT7aSI1qjmffxT6P2t/nJXRobq1WbCw55v9h+x366MdsrILR4p9JXgVUC9G1bqKo4HWAFzOkfu
	o/8pq0dw==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1ueFRb-001WK5-1U;
	Tue, 22 Jul 2025 17:02:19 +0100
Date: Tue, 22 Jul 2025 17:02:19 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, iorlov@amazon.co.uk, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	dwmw@amazon.co.uk
Subject: Re: [PATCH v3] tpm: Check for completion after timeout
Message-ID: <aH-2C_coDUL-KKWW@earth.li>
References: <20250719201340.24447-1-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250719201340.24447-1-ivan.orlov0322@gmail.com>

On Sat, Jul 19, 2025 at 08:13:39PM +0000, Ivan Orlov wrote:
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
>Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>

I'm running this (though with an open coded repeated check, instead of 
the check function) in our fleet now. It hasn't rolled out to enough 
machines for me to confirm it definitely fixes the problem we see, but:

Reviewed-By: Jonathan McDowell <noodles@meta.com>

>---
>V1 -> V2:
>- Exclude the jiffies -> ktime change from the patch
>- Instead of recording the time before checking for completion, check
>  for completion once again after leaving the loop
>V2 -> V3:
>- Avoid reading the chip status twice in the inner loop by passing
>  status into tpm_transmit_completed
>
> drivers/char/tpm/tpm-interface.c | 17 +++++++++++++++--
> 1 file changed, 15 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>index 8d7e4da6ed53..8d18b33aa62d 100644
>--- a/drivers/char/tpm/tpm-interface.c
>+++ b/drivers/char/tpm/tpm-interface.c
>@@ -82,6 +82,13 @@ static bool tpm_chip_req_canceled(struct tpm_chip *chip, u8 status)
> 	return chip->ops->req_canceled(chip, status);
> }
>
>+static bool tpm_transmit_completed(u8 status, struct tpm_chip *chip)
>+{
>+	u8 status_masked = status & chip->ops->req_complete_mask;
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
>+		if (tpm_transmit_completed(status, chip))
> 			goto out_recv;
>
> 		if (tpm_chip_req_canceled(chip, status)) {
>@@ -142,6 +148,13 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> 		rmb();
> 	} while (time_before(jiffies, stop));
>
>+	/*
>+	 * Check for completion one more time, just in case the device reported
>+	 * it while the driver was sleeping in the busy loop above.
>+	 */
>+	if (tpm_transmit_completed(tpm_chip_status(chip), chip))
>+		goto out_recv;
>+
> 	tpm_chip_cancel(chip);
> 	dev_err(&chip->dev, "Operation Timed out\n");
> 	return -ETIME;
>-- 
>2.43.0
>

J.

-- 
/-\                             |   <fledermaus> you should see the
|@/  Debian GNU/Linux Developer |  damage a bear on fire can do to a
\-                              |          rack of switches.

