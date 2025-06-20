Return-Path: <linux-integrity+bounces-6486-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF265AE1CFE
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jun 2025 16:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1F41884D98
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jun 2025 14:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607F928B7C6;
	Fri, 20 Jun 2025 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="Xev9waoG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598A28B4FD;
	Fri, 20 Jun 2025 14:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750428216; cv=none; b=qqljjeWhoUKvZuwRcieKrpO+IUUfdVN4XD8bVYpRxQwdyMtvJMT8iqSBP5zAozRQRx36noT1yZiBw60q4z4hIK9Kf6vgWU6yX8gt3YPu1M2CvCPPyypapGWfOpUcR8VUu6KDhQ320v6xj4UYzWi5kGlUozghIrqzqH1/FMc5gMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750428216; c=relaxed/simple;
	bh=XDSYm0LAP+6mIAyG1KOcL1BQwmwnediG65sYR4tURfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qq2lwmfEStidVtc0lttl5cnuRSZxZKUfxhDqPEmGsmqsS0O1lRDAJJp4Gh3XIFx23yHZXciCCRx0/s60CoNWH6gwcmq9zBF4yYV33H6nFE7EErnez7DeSbgxbULXU/03pEPP6mQsVQPRCRYEZ7JXNv1UYTQHyCU2eUfOeOcsQWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=Xev9waoG; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DDBlc6X06W7RqhIMTP6H4wGHxtmOyxhuVoFdQGnU/JY=; b=Xev9waoGKB/yOZL6DtC7FSYtoD
	mHdKnQepePRvZsJPJS3oD/FFwxtGfk3CE9H7zItG/4MMQVk3O32pKSxBeNP2BRahz75ZYudDPs8DX
	rOj82yKRit66GJqEbH+VPIMCvUF68oX6xN9fptWj38nVc+lDLfb95FUEiUn58H1Vdy5usU8P4k28Q
	7R9jmo28pTsNy6mP/Rs5LLe8+cNJIAMUzv2o+SskQCnrItxwlTx0XfHFrJy80FeTcKST6IPviMFpO
	7+935TRYzFGl/ujRWYWevVkyC/oxBeJXH9ZNiHmK6kuAJC/d5P+dc07m55WOB1m0zI5j8nsk6Cxe3
	Zr0JeV8w==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1uSbjI-00E85J-0d;
	Fri, 20 Jun 2025 14:24:28 +0100
Date: Fri, 20 Jun 2025 14:24:28 +0100
From: Jonathan McDowell <noodles@earth.li>
To: "Orlov, Ivan" <iorlov@amazon.co.uk>
Cc: "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
	"jarkko@kernel.org" <jarkko@kernel.org>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [PATCH] tpm: Fix the timeout & use ktime
Message-ID: <aFVhDDewVHneFXnO@earth.li>
References: <20250611162508.85149-1-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250611162508.85149-1-iorlov@amazon.com>

On Wed, Jun 11, 2025 at 04:25:24PM +0000, Orlov, Ivan wrote:
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

This looks similar to the issue I fixed in 7146dffa875c ('Fix timeout
handling when waiting for TPM status'), I assume you're actually seeing
it in your systems? I think we're starting to see it (rarely) now the
other issues are fixed in our builds. As a similar approach does the
following work?

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 8d7e4da6ed53..18ae0767fa60 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -127,7 +127,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
  		goto out_recv;
  
  	stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
-	do {
+	while (true) {
  		u8 status = tpm_chip_status(chip);
  		if ((status & chip->ops->req_complete_mask) ==
  		    chip->ops->req_complete_val)
@@ -138,9 +138,12 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
  			return -ECANCELED;
  		}
  
+		if (time_after(jiffies, stop))
+			break;
+
  		tpm_msleep(TPM_TIMEOUT_POLL);
  		rmb();
-	} while (time_before(jiffies, stop));
+	}
  
  	tpm_chip_cancel(chip);
  	dev_err(&chip->dev, "Operation Timed out\n");

