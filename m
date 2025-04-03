Return-Path: <linux-integrity+bounces-5575-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F60DA7A17F
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 13:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A62A173A32
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 11:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBB01F5825;
	Thu,  3 Apr 2025 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="n1dG/KLz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB901F4E34;
	Thu,  3 Apr 2025 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743678042; cv=none; b=XscaLgrsVdToD+2chetif91lwjPRKHNCGscR+BPR/TYVzMrQQkDb3jMNJtWMnVtnJbh/nAYGDz7nT9BWIjBYOXXGPgPVcehMn/2fXhTLz68YNix5f/M4ICu6J4dbBhEfzTDqMYxCUUFV9/dRDGlAGHh1REC/MD0eETGq2rSMabA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743678042; c=relaxed/simple;
	bh=2JuxxbroOgOfK+lvh1I4ocGKmehAyvFihR3ei21x4Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpIPEKxJvNSrEO92I9qPaR/0KtPTpenAzk0fjBkyoVLW7eTUxBDpHKHDiIwbsZlRxctxi4VxPg42mgEQ/NUUr7dULcQMFIVqXwm+bYj2caxWJRmGiaN29nwvyDEoE5B4vo9lfReIpJ0cLuHHWk5Kmzw/dfFaQ5Omp6RxNdwjlZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=n1dG/KLz; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qHM5XgndzJyPxlIcLRlSN1VKPmI6qvMCkprJ3qF1Z1I=; b=n1dG/KLzyZ3jlf6HVFDzRkCjKf
	E36olS1H/NLMC0e0i1y08DrcYdmzZXIAfoG5m+rkYBaUdUq7lUzvNtEMWqh4XbLZD7cHwZ8r0tNga
	wF2MVMz6QnVXiN01jYniiUMwTpxPA4s+MXJnN3sHK0/XXCqbNFxbqBcyifm4YsYdipEUfMJQN74i+
	/3wh+hvSrL49Rs2UG3/9ayM1nDKPj/c5qMUcVRGWr0gCduqlAbpsZtGaA570c3TcWFOJ6kIa+f3vj
	vhNjQ33jNMP3nlVGrAO+guJrm/s2E+cmFIJoKoM6Qecy5tkQJQTsT30U+qoBJ1JvJibMFhGaSEact
	u1AAOdXg==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1u0IJI-00D0QP-0m;
	Thu, 03 Apr 2025 12:00:36 +0100
Date: Thu, 3 Apr 2025 12:00:36 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: tis: Increase the default for timeouts B and C
Message-ID: <Z-5qVBjeRfEdRAP5@earth.li>
References: <20250402172134.7751-1-msuchanek@suse.de>
 <Z-13xOebA3LvQQ-8@earth.li>
 <Z-2ZC2Ew2EtNAW6-@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-2ZC2Ew2EtNAW6-@kitsune.suse.cz>

On Wed, Apr 02, 2025 at 10:07:39PM +0200, Michal Suchánek wrote:
>On Wed, Apr 02, 2025 at 06:45:40PM +0100, Jonathan McDowell wrote:
>> On Wed, Apr 02, 2025 at 07:21:30PM +0200, Michal Suchanek wrote:
>> > With some Infineon chips the timeouts in tpm_tis_send_data (both B and
>> > C) can reach up to about 2250 ms.
>> >
>> > Extend the timeout duration to accommodate this.
>>
>> The problem here is the bump of timeout_c is going to interact poorly with
>> the Infineon errata workaround, as now we'll wait 4s instead of 200ms to
>> detect the stuck status change.
>
>Yes, that's problematic. Is it possible to detect the errata by anything
>other than waiting for the timeout to expire?

Not that I'm aware of, nor have seen in my experimentation. It's a 
"stuck" status, so the timeout is how it's detected.

OOI, have you tried back porting the fixes that are in mainline for 6.15 
to your frankenkernel? I _think_ the errata fix might end up resolving 
at least the timeout for valid for you, as a side effect? We're 
currently rolling them out across our fleet, but I don't have enough 
runtime yet to be sure they've sorted all the timeout instances we see.

J.

-- 
/-\                             | He's weird? It's ok, I'm fluent in
|@/  Debian GNU/Linux Developer |               weird.
\-                              |

