Return-Path: <linux-integrity+bounces-6624-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1499CAF8EBA
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 11:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F73B17772B
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 09:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7951B27E077;
	Fri,  4 Jul 2025 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="uKxsXHdj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1A129A308;
	Fri,  4 Jul 2025 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751621616; cv=none; b=OFtaXp7K8h50B8dHQasuSacSBAB1qTL7WUlAxWdeNUv/gEVZH//xUQxhLRAalR4iekZCsnfXouEbJqQfNzilmHTbXcWS3QyGTwNosrx+qJUqibmQoPLTxXCxuTN9IVUwYbGZqBz3UGFeQmMt7j8F5agk9DSUctBjr5Np2ZS+NUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751621616; c=relaxed/simple;
	bh=fHcJeLxd3czLO7BU7brQAuvBtgPi8QsgFNuxt0mkEqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J74H/hneYxGuaHDGzNv1SBRy7BfhWJKjcjxuQE775VAd4H/wwnBQ+/5uObSr9awtEpjQeLZuJbt10azvY7lNU6+P0rJg1k4BKRiCr2xqwHwWjH/ksTgQgxYo/UYauUCvR0LBJIr0NpR3bZvfGUkp054T8DS56BzHV5ReciUCsJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=uKxsXHdj; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+ugYoCt4pJwQ2pOWir6Edta+6ErzUvYTIgWTgVQ/3MQ=; b=uKxsXHdj6Ne/ZaRoOuewi5ciYi
	8fwgDW1KbupmKAcb4xGGFmTeQi1OzdjLFFhRKbQWak0cxynu3yV6kBA3QjNIfX9xZ8o2QYnvNfLZK
	Ih1F/sNvLjZzuq4/q1FpTrL/6Yn4t/vk7Kmy2k5k4U9u+PWKdCPr5DsxRWp0mm8wQ2Jp/LpKW4Zbl
	PEfWzem+TeDVHfbNdf8ak+Hdxua2egOzivAl28wvaWi2mWDdMwMvgQYMwj4byMzq5ZcxdMNqGzt3p
	6+8/OvF5dV8Za+/THlftghSXRMuR6U7kHkUd/yRS0xUdqvvnCCwS5QhjZblkSbMTQpWHfpCDXIPq2
	NG8bCTrg==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1uXcJV-00F2KC-2R;
	Fri, 04 Jul 2025 10:02:33 +0100
Date: Fri, 4 Jul 2025 10:02:33 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: "Orlov, Ivan" <iorlov@amazon.co.uk>,
	"peterhuewe@gmx.de" <peterhuewe@gmx.de>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [PATCH v2] tpm: Fix the timeout & use ktime
Message-ID: <aGeYqQG15lb2_NaU@earth.li>
References: <20250620180828.98413-1-iorlov@amazon.com>
 <aFhtKrWTDzZbpTSh@earth.li>
 <aFwnG--lzZO0mQgc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aFwnG--lzZO0mQgc@kernel.org>

On Wed, Jun 25, 2025 at 07:43:07PM +0300, Jarkko Sakkinen wrote:
>On Sun, Jun 22, 2025 at 09:52:58PM +0100, Jonathan McDowell wrote:
>> On Fri, Jun 20, 2025 at 06:08:31PM +0000, Orlov, Ivan wrote:
>> > The current implementation of timeout detection works in the following
>> > way:
>> >
>> > 1. Read completion status. If completed, return the data
>> > 2. Sleep for some time (usleep_range)
>> > 3. Check for timeout using current jiffies value. Return an error if
>> >   timed out
>> > 4. Goto 1
>> >
>> > usleep_range doesn't guarantee it's always going to wake up strictly in
>> > (min, max) range, so such a situation is possible:
>> >
>> > 1. Driver reads completion status. No completion yet
>> > 2. Process sleeps indefinitely. In the meantime, TPM responds
>> > 3. We check for timeout without checking for the completion again.
>> >   Result is lost.
>> >
>> > Such a situation also happens for the guest VMs: if vCPU goes to sleep
>> > and doesn't get scheduled for some time, the guest TPM driver will
>> > timeout instantly after waking up without checking for the completion
>> > (which may already be in place).
>> >
>> > Perform the completion check once again after exiting the busy loop in
>> > order to give the device the last chance to send us some data.
>> >
>> > Since now we check for completion in two places, extract this check into
>> > a separate function.
>> >
>> > Signed-off-by: Ivan Orlov <iorlov@amazon.com>
>> > ---
>> > V1 -> V2:
>> > - Exclude the jiffies -> ktime change from the patch
>> > - Instead of recording the time before checking for completion, check
>> >  for completion once again after leaving the loop
>> >
>> > drivers/char/tpm/tpm-interface.c | 17 +++++++++++++++--
>> > 1 file changed, 15 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>> > index 8d7e4da6ed53..6960ee2798e1 100644
>> > --- a/drivers/char/tpm/tpm-interface.c
>> > +++ b/drivers/char/tpm/tpm-interface.c
>> > @@ -82,6 +82,13 @@ static bool tpm_chip_req_canceled(struct tpm_chip *chip, u8 status)
>> > 	return chip->ops->req_canceled(chip, status);
>> > }
>> >
>> > +static bool tpm_transmit_completed(struct tpm_chip *chip)
>> > +{
>> > +	u8 status_masked = tpm_chip_status(chip) & chip->ops->req_complete_mask;
>> > +
>> > +	return status_masked == chip->ops->req_complete_val;
>> > +}
>> > +
>> > static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>> > {
>> > 	struct tpm_header *header = buf;
>> > @@ -129,8 +136,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>> > 	stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
>> > 	do {
>> > 		u8 status = tpm_chip_status(chip);
>> > -		if ((status & chip->ops->req_complete_mask) ==
>> > -		    chip->ops->req_complete_val)
>> > +		if (tpm_transmit_completed(chip))
>> > 			goto out_recv;
>>
>> The only thing I'd point out here is we end up doing a double status read
>> one after the other (once here, once in tpm_transmit_completed), and I'm
>> pretty sure I've seen instances where that caused a problem.
>
>It would be easy to to prevent at least double reads after completion
>e.g., in tpm_chip_status():

Or just take the simple approach and make the check after the while 
loop:

	if ((tpm_chip_status(chip) & chip->ops->req_complete_mask) ==
	    chip->ops->req_complete_val)
		goto out_recv;

There might be potential for a longer term cleanup using chip->status to 
cache things, but I'm little concerned that's going to open paths where 
we might not correctly update it, so I think it should be a separate 
piece.

(I'm motivated by the fact we've started to see the "Operation Canceled" 
error and I'd like us to close on the best way to fix it. :) )

J.

-- 
I am afraid of the dark.

