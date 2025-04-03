Return-Path: <linux-integrity+bounces-5597-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205EBA7B07C
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 23:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2E916C20E
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 21:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DE22010EE;
	Thu,  3 Apr 2025 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="OCTXJd4s"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D522010E8;
	Thu,  3 Apr 2025 20:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743713010; cv=none; b=Nw3++sy0rxICtSM65pF5Zcm0ijkSKMo5u4ri4yM2Ts0J2UP3QEf+LcMgwDNjyahCIK/uL1/nix2jo0CLbdlcqjvZf3n4SfPB18DBKmt7yN/ADn/iFk+CPly/6RV1TdCFxDwyq7UjSC576DJFljRyEwSRH1pB22ZomqBvfp7nYP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743713010; c=relaxed/simple;
	bh=Z6AjCiX55b2ls3ukJbErpaiU+cdMDwLkhdMXgsJVwDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCI9Ha/zHKh6nlRfxeNwK8Gynet+ffBSiHIpacH7MLBhhShakSvQMWdekNKWq7oVgq4EO5YtOEFUmE5cI3fsv2e5trTogDxRvVehMaempOYfWEEVwiQsTBhjzaA9bOnCeJh+Yeq5DeQviEXthvGIYCUwtxWYWFsjGkKsbS4QtM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=OCTXJd4s; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fZj5xEBVPcFI3ae7bqQp+lq69uF7xTX+XTtVKf/jG+A=; b=OCTXJd4swL2/t46/ZwVEzf2BDl
	HCeuiVJsGDYbPxYeHr3X5iT4vVThPE5O3SiBDtvLIbuq19ycBbDIKp3GI8s0z1g+wqMp4MBnHHh16
	K2gtUoZ37E91iz0rOflZvhTKIarFFTxicg7s07cPt53MMjrHpJF4aHrlunXh//JdbjGHPbTuzDaxt
	wScyyhD2w6gWgzfgHP30xlj0AgKB89SzWkYZDoEIpvErsuDtPX2JZ/22KgoFydUpI2n+8kbh/rPTt
	lQLZhidzdTzWV7x2K90Chxfd3MhR/N3NyveVd+yLorSC0Ljm9L5ZgYiDMmQe72qY4kUHZSF8LKME4
	O4isR4YQ==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1u0RPD-00DdeO-0u;
	Thu, 03 Apr 2025 21:43:19 +0100
Date: Thu, 3 Apr 2025 21:43:19 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Michal Suchanek <msuchanek@suse.de>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: tis: Increase the default for timeouts B and C
Message-ID: <Z-7y5x3u6wVGFjj-@earth.li>
References: <20250402172134.7751-1-msuchanek@suse.de>
 <Z-13xOebA3LvQQ-8@earth.li>
 <Z-7XQYP7_tXYR2Ik@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z-7XQYP7_tXYR2Ik@kernel.org>

On Thu, Apr 03, 2025 at 09:45:21PM +0300, Jarkko Sakkinen wrote:
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
>>
>> (Also shouldn't timeout_c already end up as 750ms, as it's
>> max(TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_C), and TIS_SHORT_TIMEOUT is 750 vs 200
>> for TPM2_TIMEOUT_C? That doesn't seem to be borne out by your logs, nor my
>> results.)
>
>Just noticed that the commit did not end up having fixes etc. tags:
>
>https://web.git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=de9e33df7762abbfc2a1568291f2c3a3154c6a9d
>
>Should we forward to stable?

It's a TPM bug rather than a kernel issue, so I don't think there's a 
valid Fixes: for it, but it's certainly stable material in my mind.

J.

-- 
... "It only counts as a lie-in if you don't get dressed before tea time."
     -- Steve Willison

