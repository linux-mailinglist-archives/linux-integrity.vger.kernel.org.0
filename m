Return-Path: <linux-integrity+bounces-5606-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A44A7B9FE
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Apr 2025 11:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57FD4189A6EC
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Apr 2025 09:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF1C19E806;
	Fri,  4 Apr 2025 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="K9UkCEt1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C14611E;
	Fri,  4 Apr 2025 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743759084; cv=none; b=nm/mrX5iAgxYajIZUureD3EkHUHJbpt+8s+cSTwrq9PFMs+KAEdoMihSFQupY6ZSesMboRr7ccVc4uQXJXtts2glDpvNh8wVJZAqjSRbfcT8C3T6GzKBKX1EmobGl2UXdiAIbQOYFGlhJeU4RwlWibdbpXN6okjQZIrlQ+C2vVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743759084; c=relaxed/simple;
	bh=rVF6aHtapSaiEymHvYn2RlfRG4DeMQlIrJEj2npHJxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAIR1nqjkd4KB46Ce8pSJB8kThKL5Qij5c0Qc2qtfbPBs6/jKorF0NtOgU2DKxExkA7EWbeqVS3q9wXo9rU/nQ9ZONTqYY4Gx26hVTqmR0DLqQ3253qM9P/2ohhfpGMjah2MeOCjPILx2vLjqxstwwY6J4FQHwByxfgymqkO+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=K9UkCEt1; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=x2gLbZPVBbBR3kCGdGzcIPbbiqmvneZACUbfbPNVGN4=; b=K9UkCEt1f7WimuPsqO2lnmf8Ui
	dKCUhnKcQJWqaeKXSK3s1+ORDofXTHBKa6JQ1P0oItbHJIJ0zkoZolkXNPEtW3xCGfc/KgQ8s/mWT
	qpmsINpUR2SDbqWm1z+d1refj19Mdctqgx8hU4tAiddidp6xqyS/iKK+aIFPqY6k9w8HT6yylh99q
	LUiiIjzQkIkuTWE+MABHhJw3NADuWdtO0htx01kOiR2fMOKrzJWhf9S5DxC+hQSeoU7TiWE9CWqJG
	PYMd2baa6g3XhjOsshKE+w60P6o3F+arNDwnNN8THt+COJeJ7XTmm32oOrWnm9CEEJrADRsenFYe0
	mfEsERog==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1u0dOQ-00ELhl-2U;
	Fri, 04 Apr 2025 10:31:18 +0100
Date: Fri, 4 Apr 2025 10:31:18 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] tpm: tis: Increase the default for timeouts B and C
Message-ID: <Z--m5rTDLLbyWEE5@earth.li>
References: <20250402172134.7751-1-msuchanek@suse.de>
 <Z-13xOebA3LvQQ-8@earth.li>
 <Z-7XQYP7_tXYR2Ik@kernel.org>
 <Z-7y5x3u6wVGFjj-@earth.li>
 <Z--PgeuYjRx6zXmG@kitsune.suse.cz>
 <Z--T5LEsXddkTX-H@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z--T5LEsXddkTX-H@kernel.org>

On Fri, Apr 04, 2025 at 11:10:12AM +0300, Jarkko Sakkinen wrote:
>On Fri, Apr 04, 2025 at 09:51:29AM +0200, Michal Suchánek wrote:
>> On Thu, Apr 03, 2025 at 09:43:19PM +0100, Jonathan McDowell wrote:
>> > On Thu, Apr 03, 2025 at 09:45:21PM +0300, Jarkko Sakkinen wrote:
>> > > On Wed, Apr 02, 2025 at 06:45:40PM +0100, Jonathan McDowell wrote:
>> > > > On Wed, Apr 02, 2025 at 07:21:30PM +0200, Michal Suchanek wrote:
>> > > > > With some Infineon chips the timeouts in tpm_tis_send_data (both B and
>> > > > > C) can reach up to about 2250 ms.
>> > > > >
>> > > > > Extend the timeout duration to accommodate this.
>> > > >
>> > > > The problem here is the bump of timeout_c is going to interact poorly with
>> > > > the Infineon errata workaround, as now we'll wait 4s instead of 200ms to
>> > > > detect the stuck status change.
>> > > >
>> > > > (Also shouldn't timeout_c already end up as 750ms, as it's
>> > > > max(TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_C), and TIS_SHORT_TIMEOUT is 750 vs 200
>> > > > for TPM2_TIMEOUT_C? That doesn't seem to be borne out by your logs, nor my
>> > > > results.)
>> > >
>> > > Just noticed that the commit did not end up having fixes etc. tags:
>> > >
>> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=de9e33df7762abbfc2a1568291f2c3a3154c6a9d
>> > >
>> > > Should we forward to stable?
>> >
>> > It's a TPM bug rather than a kernel issue, so I don't think there's a valid
>> > Fixes: for it, but it's certainly stable material in my mind.
>>
>> In the more general sense of Fixes: indicating where the fix is
>> applicable it would be any kernel that supports TPM2.
>
>I tried applying the patch on 6.1-stable:
>
>~/work/kernel.org/stable/linux tags/v6.1.132
>$ git am -3 ~/Downloads/infineon.patch
>Applying: tpm, tpm_tis: Workaround failed command reception on Infineon devices
>Using index info to reconstruct a base tree...
>M	drivers/char/tpm/tpm_tis_core.c
>M	drivers/char/tpm/tpm_tis_core.h
>M	include/linux/tpm.h
>Falling back to patching base and 3-way merge...
>Auto-merging include/linux/tpm.h
>Auto-merging drivers/char/tpm/tpm_tis_core.h
>Auto-merging drivers/char/tpm/tpm_tis_core.c
>
>If no counter-opinions, I'd add:
>
>stable@vger.kernel.org # v6.1+
>
>I based this on Bookworm kernel.

It looks like Sasha has already autoselected it for 6.1, 6.6, 6.12, 6.13 
+ 6.14.

J.

-- 
How does it work?  I don't know but it does!
This .sig brought to you by the letter R and the number 21
Product of the Republic of HuggieTag

