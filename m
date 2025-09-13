Return-Path: <linux-integrity+bounces-7067-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE34B56195
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Sep 2025 16:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE02189286B
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Sep 2025 14:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3512EC546;
	Sat, 13 Sep 2025 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="v/z5Pf4f"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E2C1C8FBA;
	Sat, 13 Sep 2025 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757774000; cv=none; b=qi4Sq3OWhEj1eLCRrGN6sD/9KxN4lkrd88tEXwpPtq8eFW5HV36MS1nOGKIzKZM2aAczJ+3XmEXl3vDbXTR+IS5ydFtzFPS6sAurvCMpIbI4QggZqMF+t57yKzXrCfOd0RLmNY2qBIrdF7CIz9iGt/g67xOMpPdDw0JEPbmCfsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757774000; c=relaxed/simple;
	bh=j2QM2aw7mGhSmWHCXRRe7ymcvibhXUOQnnNuy1bwWt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncOLKGhOxtfj84WkQpTQl4CjEpoTZy1IYVeaBzv5CGt0n4YPItKI96hV2FxW0ACNRIkOry3/cjIesUroFWPt4iw9aB4yyoWl3dSsGm3ZvwjySdRYO135o0nThDafuknaVUXghmmopuXcCcR91EH57Dz39RkEZqDT2rgMf6VOdjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=v/z5Pf4f; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1n+QzLWlRDA0aVwcLcZsmd3RKgAIHsT4SqseR68tHQw=; b=v/z5Pf4fO/v9/6pnVSlfLxYlNu
	VvXEyApHvJ9tTy3ns2198rDsufr4MuK8Uf4+5aO8n+5LwG+vVq8bYPqJQfR9PkdCUhMbz6xOaaNBS
	f3hZi2QA5VBGlEjEORy4HlS+y/GY2g0OT157KsbrJeTh+Hgiz5P+N4YxQRWAOQlHFlx9kpx781CAj
	by7+K43WCkAEtrpDDDcvOyh6+PQqmharGMQWihy6CZgN0kTx/vx6AffDowKhmETWB3wweWn2y+2yM
	cuaSCEnbyn2EQDE/x1d5GuQj3IxFFAg3aYFSgjxK4fmdem78qADUgKpD+wlg+vdQnKgVYWVveiIyk
	B/i9Zotw==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1uxQvv-00CwjW-2K;
	Sat, 13 Sep 2025 15:08:55 +0100
Date: Sat, 13 Sep 2025 15:08:55 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Olivia Mackall <olivia@selenic.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] hwrng: core - Allow runtime disabling of the HW RNG
Message-ID: <aMV690M9WOS6rtWX@earth.li>
References: <aLWltVMmuYQn8Pwa@earth.li>
 <aMTra7C-CayEcaCY@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aMTra7C-CayEcaCY@gondor.apana.org.au>

On Sat, Sep 13, 2025 at 11:56:27AM +0800, Herbert Xu wrote:
>On Mon, Sep 01, 2025 at 02:55:01PM +0100, Jonathan McDowell wrote:
>> From: Jonathan McDowell <noodles@meta.com>
>>
>> The HW RNG core allows for manual selection of which RNG device to use,
>> but does not allow for no device to be enabled. It may be desirable to
>> do this on systems with only a single suitable hardware RNG, where we
>> need exclusive access to other functionality on this device. In
>> particular when performing TPM firmware upgrades this lets us ensure the
>> kernel does not try to access the device.
>>
>> Before:
>>
>> root@debian-qemu-efi:~# grep "" /sys/devices/virtual/misc/hw_random/rng_*
>> /sys/devices/virtual/misc/hw_random/rng_available:tpm-rng-0
>> /sys/devices/virtual/misc/hw_random/rng_current:tpm-rng-0
>> /sys/devices/virtual/misc/hw_random/rng_quality:1024
>> /sys/devices/virtual/misc/hw_random/rng_selected:0
>>
>> After:
>>
>> root@debian-qemu-efi:~# grep "" /sys/devices/virtual/misc/hw_random/rng_*
>> /sys/devices/virtual/misc/hw_random/rng_available:tpm-rng-0 none
>> /sys/devices/virtual/misc/hw_random/rng_current:tpm-rng-0
>> /sys/devices/virtual/misc/hw_random/rng_quality:1024
>> /sys/devices/virtual/misc/hw_random/rng_selected:0
>>
>> root@debian-qemu-efi:~# echo none > /sys/devices/virtual/misc/hw_random/rng_current
>> root@debian-qemu-efi:~# grep "" /sys/devices/virtual/misc/hw_random/rng_*
>> /sys/devices/virtual/misc/hw_random/rng_available:tpm-rng-0 none
>> /sys/devices/virtual/misc/hw_random/rng_current:none
>> grep: /sys/devices/virtual/misc/hw_random/rng_quality: No such device
>> /sys/devices/virtual/misc/hw_random/rng_selected:1
>>
>> (Observe using bpftrace no calls to TPM being made)
>>
>> root@debian-qemu-efi:~# echo "" > /sys/devices/virtual/misc/hw_random/rng_current
>> root@debian-qemu-efi:~# grep "" /sys/devices/virtual/misc/hw_random/rng_*
>> /sys/devices/virtual/misc/hw_random/rng_available:tpm-rng-0 none
>> /sys/devices/virtual/misc/hw_random/rng_current:tpm-rng-0
>> /sys/devices/virtual/misc/hw_random/rng_quality:1024
>> /sys/devices/virtual/misc/hw_random/rng_selected:0
>>
>> (Observe using bpftrace that calls to the TPM resume)
>>
>> Signed-off-by: Jonathan McDowell <noodles@meta.com>
>> ---
>>  drivers/char/hw_random/core.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
>> index 018316f54621..11c8077b792b 100644
>> --- a/drivers/char/hw_random/core.c
>> +++ b/drivers/char/hw_random/core.c
>> @@ -341,6 +341,10 @@ static ssize_t rng_current_store(struct device *dev,
>>
>>  	if (sysfs_streq(buf, "")) {
>>  		err = enable_best_rng();
>> +	} else if (sysfs_streq(buf, "none")) {
>> +		if (current_rng)
>> +			cur_rng_set_by_user = 1;
>> +		drop_current_rng();
>
>Is this setting supposed to be sticky?
>
>Because as it stands, if another HWRNG is registered after setting
>it to none, it would still become the default RNG which seems to be
>surprising.

Good point, I'd missed that (it's not likely to be an issue in my 
situation), but I'll spin a v2 that fixes up hwrng_register() too.

J.

-- 
I'm an atheist myself - there is no Greg Hill.

