Return-Path: <linux-integrity+bounces-6629-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB09AF974A
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 17:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518575A0B6C
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 15:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238B71D86FB;
	Fri,  4 Jul 2025 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="njgfOrPV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6A64501A;
	Fri,  4 Jul 2025 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751644293; cv=none; b=mmLtEqGxbMGSYxBCjEg3fDMto3owL01dxCl2bkmvJmLIELflkjIG6uMV4YToCkk5JVT2l61Yqp0TjAhgLmnqLXX69HAxk+F07A12PgUzoWd7ze1PINDE5SSz5LAmru3Ma/aLL68HhIuB/nf9NYBMWaud3tW24wKgA/K9EgTrlTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751644293; c=relaxed/simple;
	bh=FCnVZIOYhNx+EjP+n5BFpCdKpnT4NOhcK56CUNab/0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjaITAcWLyEku7ZgoDVUR1CUpFiQTgcGf5vuocBLFwf8tZ460wzp6z53rc83c3nfjyMeEQZ0n/BTD+xna5nE2qq3LJPQdSJwLDNqoJySM2IRrB/pyGS6vqMXGRizG+dT2+5DyJTZNGfObqd22ErQbhwYkfzj+iJ/B3QKP+r7t2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=njgfOrPV; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5yIk903c/6Tuugga8xcZneoZW3zuKnTSfGdd5qCKqlY=; b=njgfOrPVGUWR5K6ZS9mdd/1FCe
	jBbrB6eyznX3yHXAnGDj9lpbICMlfgjxTL8lMXZK/TH7L//BUG3dJWfJUCtqMaBiYJBIL3+CU4HHN
	Ru9++xcSgIBb6705Trhwa6Cnxe6ERiJ8STXt0KKiASyU5Ghd+HzlEwSYP3Ks6ei5eKXkhGDSVADCN
	Fbek/VYhdNFgkSTqXdlI5hJUW13dzKCcxWEH+ilmdx99gSDrzCB2CERNmWKnUInUDVL7wbAwCJp24
	kCfToSVR/dRl0LPkatMClamXiUPwCbFazN1KM8QoDsnXQrUb1nrw7MP+pWZAnx2oDMLY18Xq3pfM8
	9Q2goXyA==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1uXihD-00FRvW-0b;
	Fri, 04 Jul 2025 16:51:27 +0100
Date: Fri, 4 Jul 2025 16:51:27 +0100
From: Jonathan McDowell <noodles@earth.li>
To: "Orlov, Ivan" <ivan.orlov0322@gmail.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	"Orlov, Ivan" <iorlov@amazon.co.uk>,
	"peterhuewe@gmx.de" <peterhuewe@gmx.de>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [PATCH v2] tpm: Fix the timeout & use ktime
Message-ID: <aGf4f-PKyqlBNgNj@earth.li>
References: <20250620180828.98413-1-iorlov@amazon.com>
 <aFhtKrWTDzZbpTSh@earth.li>
 <aFwnG--lzZO0mQgc@kernel.org>
 <aGeYqQG15lb2_NaU@earth.li>
 <aGfwPbMZf-SHshXH@kernel.org>
 <048723bf-4a8d-451a-911b-f9f94a4270d7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <048723bf-4a8d-451a-911b-f9f94a4270d7@gmail.com>

On Fri, Jul 04, 2025 at 04:39:20PM +0100, Orlov, Ivan wrote:
>On 04/07/2025 16:16, Jarkko Sakkinen wrote:
>>On Fri, Jul 04, 2025 at 10:02:33AM +0100, Jonathan McDowell wrote:
>>>On Wed, Jun 25, 2025 at 07:43:07PM +0300, Jarkko Sakkinen wrote:
>>>>On Sun, Jun 22, 2025 at 09:52:58PM +0100, Jonathan McDowell wrote:
>>>>>On Fri, Jun 20, 2025 at 06:08:31PM +0000, Orlov, Ivan wrote:
>>>>>>The current implementation of timeout detection works in the following
>>>>>>way:
>>>>>>
>>>>>>1. Read completion status. If completed, return the data
>>>>>>2. Sleep for some time (usleep_range)
>>>>>>3. Check for timeout using current jiffies value. Return an error if
>>>>>>   timed out
>>>>>>4. Goto 1
>>>>>>
>>>>>>usleep_range doesn't guarantee it's always going to wake up strictly in
>>>>>>(min, max) range, so such a situation is possible:
>>>>>>
>>>>>>1. Driver reads completion status. No completion yet
>>>>>>2. Process sleeps indefinitely. In the meantime, TPM responds
>>>>>>3. We check for timeout without checking for the completion again.
>>>>>>   Result is lost.
>>>>>>
>>>>>>Such a situation also happens for the guest VMs: if vCPU goes to sleep
>>>>>>and doesn't get scheduled for some time, the guest TPM driver will
>>>>>>timeout instantly after waking up without checking for the completion
>>>>>>(which may already be in place).
>>>>>>
>>>>>>Perform the completion check once again after exiting the busy loop in
>>>>>>order to give the device the last chance to send us some data.
>>>>>>
>>>>>>Since now we check for completion in two places, extract this check into
>>>>>>a separate function.
>>>>>>
>>>>>>Signed-off-by: Ivan Orlov <iorlov@amazon.com>
>>>>>>---
>>>>>>V1 -> V2:
>>>>>>- Exclude the jiffies -> ktime change from the patch
>>>>>>- Instead of recording the time before checking for completion, check
>>>>>>  for completion once again after leaving the loop
>>>>>>
>>>>>>drivers/char/tpm/tpm-interface.c | 17 +++++++++++++++--
>>>>>>1 file changed, 15 insertions(+), 2 deletions(-)
>>>>>>
>>>>>>diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>>>>>>index 8d7e4da6ed53..6960ee2798e1 100644
>>>>>>--- a/drivers/char/tpm/tpm-interface.c
>>>>>>+++ b/drivers/char/tpm/tpm-interface.c
>>>>>>@@ -82,6 +82,13 @@ static bool tpm_chip_req_canceled(struct tpm_chip *chip, u8 status)
>>>>>>	return chip->ops->req_canceled(chip, status);
>>>>>>}
>>>>>>
>>>>>>+static bool tpm_transmit_completed(struct tpm_chip *chip)
>>>>>>+{
>>>>>>+	u8 status_masked = tpm_chip_status(chip) & chip->ops->req_complete_mask;
>>>>>>+
>>>>>>+	return status_masked == chip->ops->req_complete_val;
>>>>>>+}
>>>>>>+
>>>>>>static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>>>>>>{
>>>>>>	struct tpm_header *header = buf;
>>>>>>@@ -129,8 +136,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>>>>>>	stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
>>>>>>	do {
>>>>>>		u8 status = tpm_chip_status(chip);
>>>>>>-		if ((status & chip->ops->req_complete_mask) ==
>>>>>>-		    chip->ops->req_complete_val)
>>>>>>+		if (tpm_transmit_completed(chip))
>>>>>>			goto out_recv;
>>>>>
>>>>>The only thing I'd point out here is we end up doing a double status read
>>>>>one after the other (once here, once in tpm_transmit_completed), and I'm
>>>>>pretty sure I've seen instances where that caused a problem.
>>>>
>>>>It would be easy to to prevent at least double reads after completion
>>>>e.g., in tpm_chip_status():
>>>
>>>Or just take the simple approach and make the check after the while loop:
>>>
>>>	if ((tpm_chip_status(chip) & chip->ops->req_complete_mask) ==
>>>	    chip->ops->req_complete_val)
>>>		goto out_recv;
>>>
>>>There might be potential for a longer term cleanup using chip->status to
>>>cache things, but I'm little concerned that's going to open paths where we
>>>might not correctly update it, so I think it should be a separate piece.
>>>
>>>(I'm motivated by the fact we've started to see the "Operation Canceled"
>>>error and I'd like us to close on the best way to fix it. :) )
>>
>>This would work for me too!
>>
>
>Hi, and sorry for the late reply :(
>
>I believe this option would work for us as well. Please let me know 
>whether you'd like me to send V3 or you feel free to send it yourself 
>if you want.

As far as I'm concerned it's something you found, and your patch. You 
send a new version, I'll test + review it. :)

J.

-- 
  What have you got in your pocket? |  .''`.  Debian GNU/Linux Developer
                                    | : :' :  Happy to accept PGP signed
                                    | `. `'   or encrypted mail - RSA
                                    |   `-    key on the keyservers.

