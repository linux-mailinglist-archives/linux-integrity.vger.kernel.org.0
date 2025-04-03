Return-Path: <linux-integrity+bounces-5578-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34443A7A33E
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 15:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A766A1895513
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 13:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C12288DA;
	Thu,  3 Apr 2025 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="RKezEb3r"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E809A42077;
	Thu,  3 Apr 2025 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743685234; cv=none; b=m6MsVnjYGklz0UsSPmvxQvdKgTqKNmcGrJDX5jG8++EGC4sp8Heu1uIol32YNJPzd84Hrc8AH3CviTUuYq19ESNCVsm0gD/MWQ5ShglFdMFb/+HHHf8RLKqmVF4nY0UQ7X8pROvdrW6aIo3APzCwp0yqbWLw2xYmoKCM0Mg5Q6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743685234; c=relaxed/simple;
	bh=PGGzqZcN3jsU0S4wR+DRC+6bha7CRHvmRwu43ZxAiww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrU/Mro3i1pJWoeNO7knwg9gzhIROYQT4mFsFsQfx2J4I3nuakOJx0kWa9coEVniRAtK3KRk4elRba/OtlgeqrvLXfna5FX1Sp1/nx+P349Dx5ZjCsFBXfoDv+Nw9C3Qc99k3SfG+75qI7m3Rk8Xz/inzOTErO8Z8krOc7jvhpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=RKezEb3r; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Y9Nrx94zlOw1+SqwFMXO9WjGC7xtpMLuSEbRhU1kM4c=; b=RKezEb3r1cDi7GOb9OiOYNW7EC
	W//JFQ/0JrkRQKImOWdd5y3O4JeNWO8UgAsCVl8JiW4c9qMTntuUm11upQRYvTRcnfzar2/otTxpN
	THgzKqIQWvX66/38yoc+MkYDAS4eP7zret91GFNXDHMFUlFOmWPi+mNBN51A4PVwbp66PeiASJy1s
	ZDIZ30w8U/cxZlTxyRW/iwI79f+cAvr6bAfcA3Wo6pezUkPqAjVEJ2IGlYcWK0qweAEO/xeFPzTZP
	gVnJcOQ3Roxt1EgjS/bL0JMxK08L1ptYqmqQCMDR1lj/epLO4G4qmILBelBv6klfD0KfEI4UXlTws
	lBqao2VA==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1u0KBG-00D6lI-0Z;
	Thu, 03 Apr 2025 14:00:26 +0100
Date: Thu, 3 Apr 2025 14:00:26 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: tis: Increase the default for timeouts B and C
Message-ID: <Z-6Gau3aCB7B3pB9@earth.li>
References: <20250402172134.7751-1-msuchanek@suse.de>
 <Z-13xOebA3LvQQ-8@earth.li>
 <Z-2ZC2Ew2EtNAW6-@kitsune.suse.cz>
 <Z-5qVBjeRfEdRAP5@earth.li>
 <Z-53dR25MT8OUDhW@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-53dR25MT8OUDhW@kitsune.suse.cz>

On Thu, Apr 03, 2025 at 01:56:37PM +0200, Michal Suchánek wrote:
>On Thu, Apr 03, 2025 at 12:00:36PM +0100, Jonathan McDowell wrote:
>> On Wed, Apr 02, 2025 at 10:07:39PM +0200, Michal Suchánek wrote:
>> > On Wed, Apr 02, 2025 at 06:45:40PM +0100, Jonathan McDowell wrote:
>> > > On Wed, Apr 02, 2025 at 07:21:30PM +0200, Michal Suchanek wrote:
>> > > > With some Infineon chips the timeouts in tpm_tis_send_data (both B and
>> > > > C) can reach up to about 2250 ms.
>> > > >
>> > > > Extend the timeout duration to accommodate this.
>> > >
>> > > The problem here is the bump of timeout_c is going to interact poorly with
>> > > the Infineon errata workaround, as now we'll wait 4s instead of 200ms to
>> > > detect the stuck status change.
>> >
>> > Yes, that's problematic. Is it possible to detect the errata by anything
>> > other than waiting for the timeout to expire?
>>
>> Not that I'm aware of, nor have seen in my experimentation. It's a "stuck"
>> status, so the timeout is how it's detected.
>>
>> OOI, have you tried back porting the fixes that are in mainline for 6.15 to
>> your frankenkernel? I _think_ the errata fix might end up resolving at least
>> the timeout for valid for you, as a side effect? We're currently rolling
>> them out across our fleet, but I don't have enough runtime yet to be sure
>> they've sorted all the timeout instances we see.
>
>When was that merged?

It hit Linus' tree last Friday I believe.

>The change I see is that sometimes EAGAIN is returned instead of ETIME
>but based on the previous discussion this is unlikely to help.

That sounds like you might have picked up the version with the typo that 
I posted to the list; it got fixed up before making it to mainline. The 
two patches I've backported locally are in mainline as:

7146dffa875cd00e7a7f918e1fce79c7593ac1fa tpm, tpm_tis: Fix timeout handling when waiting for TPM status
de9e33df7762abbfc2a1568291f2c3a3154c6a9d tpm, tpm_tis: Workaround failed command reception on Infineon devices

J.

-- 
Can I trade this job for what's behind door 2?

