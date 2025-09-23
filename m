Return-Path: <linux-integrity+bounces-7234-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D068B9510A
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 10:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC5D1902C61
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 08:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B29B31DD8C;
	Tue, 23 Sep 2025 08:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="aCvVArsM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DCE31D72D;
	Tue, 23 Sep 2025 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617321; cv=none; b=HsBKrGE+/38s5HEER3Z8mFA7oK9H83qoho+CPi5XzU7CcO0zVFynj2qUzIFLvvCmxKEoGmZePoLyh92RXj8q7s9jTynjDmYq9LakhVOvLIUJ7aqVvOOc3gkYF3JvycN0e2yM0ELB3g0TnFxTwsdKd5ep0+Mm/51zAtBAPQkA+l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617321; c=relaxed/simple;
	bh=N+VH81cdb4m2Kj7Vc9/EG8TiDJQ+pXsW8MlooCmCsO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jU/RrSoHT/rvceBoTtCuT2PwcxB0KYplpqelGuu+8M+LXRBG/oUxETKkx0cWEy7cd9CUgyiM4Zg9oQDwjy4Ip1RKfnCgC09psJ8W05tEtZxMbbMTtZhp97qbYbx0cXJH9qRUPgnmXaeVAkfinRaHXAXhoi3FzTFB58dSdQrFOfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=aCvVArsM; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=h9lP8yZeKdSTjfsxTL2HNB4e5QFWKyOPZFUAWGwb5yM=; b=aCvVArsMv3G1+2VSgHIUFEiQZi
	O4FUjAyCCt8G4YdTYjkS+UpJ8SWOEVrO+yMq3ejVuWCFMxXN8TY0bHS9B/SJqlFtcmsH33nMk3UXo
	dm5oSJseG8vhj26JIBlU7IJ6aNkKQWR7cEyGH36KyDPGr7qhwQaephrePWzpJ+AnHKtuF9AyV8YA0
	wth3oiaZAxHVEFxrdiu9kgSTJscKJuYSt//VPGXxNzmyZ86LIpxZZhfXKgZxJyBF88IAsw/ihlU5m
	ortYOsRcQYMe4gw4rLWeiziC3GlK3pDvlqVhYahujGZOQ62Ux4daoRNlMs/IJLlKekUboXYAGjrBO
	CBoYX5SA==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1v0yhI-00Bh7J-1M;
	Tue, 23 Sep 2025 09:48:28 +0100
Date: Tue, 23 Sep 2025 09:48:28 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Olivia Mackall <olivia@selenic.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] hwrng: core - Allow runtime disabling of the HW RNG
Message-ID: <aNJe3HZHG2uiXNAx@earth.li>
References: <aLWltVMmuYQn8Pwa@earth.li>
 <aMg4h_WeJb9bHeNb@earth.li>
 <aNIXUADMpZWo0iFz@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aNIXUADMpZWo0iFz@gondor.apana.org.au>

On Tue, Sep 23, 2025 at 11:43:12AM +0800, Herbert Xu wrote:
>On Mon, Sep 15, 2025 at 05:02:15PM +0100, Jonathan McDowell wrote:
>>
>> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
>> index 018316f54621..1682a9f1b28c 100644
>> --- a/drivers/char/hw_random/core.c
>> +++ b/drivers/char/hw_random/core.c
>> @@ -341,6 +341,10 @@ static ssize_t rng_current_store(struct device *dev,
>>  	if (sysfs_streq(buf, "")) {
>>  		err = enable_best_rng();
>> +	} else if (sysfs_streq(buf, "none")) {
>> +		if (current_rng)
>> +			cur_rng_set_by_user = 1;
>
>Shouldn't this be set unconditionally?

Yes, I guess so. I'd been guided by enable_best_rng() which only clears 
it if it changes the current RNG, but re-reading I agree that's probably 
the wrong thing here.

J.

-- 
101 things you can't have too much of : 16 - Time.

