Return-Path: <linux-integrity+bounces-7233-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DBDB9421A
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 05:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D8F2E0D2B
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 03:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C73B263F36;
	Tue, 23 Sep 2025 03:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="alcm/Q8d"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9249725C6F9;
	Tue, 23 Sep 2025 03:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758599010; cv=none; b=jiQq6VtKa10C8/QtwdoWZKDBr+Tj2RgwEtfhDoITMtAb++b6FevRSXnG42qVZkWmYi2jCRuKdULjcWXqIwf20+6dl91RoS+RHFezQHyCPYrIAuFwORzQfHOttFftFE+zIItpuPHU5CfDhFnP7X2mXtb2zXX5Z4bb4X+I56/nWew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758599010; c=relaxed/simple;
	bh=n+aaucY+pxmwURpl+3gOdE43hIKSjfiiLw+SSbWLnLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeltr3WsyV+xI1nAbVUgG5OtI55A5AGtziD9hJA6LBFXtL4+Jzu9VMF4TitSbKiAWZq6R4yV7Jegv8m0sv7P1ildccVfGtU1sEcMuhRJQjAOD7E0hl7n+N2tbhxgT3+mtEAQ+/0JXSnKzW7WqOeZDw56mounPhYNtZiiNCJYBmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=alcm/Q8d; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:cc:to:subject:message-id:date:from:reply-to;
	bh=cCWf20t1hKaVAkOqexyLivMF3D489P5duEEi41epfIc=; b=alcm/Q8dN2Uux1/+87D9QM2eFw
	9J7+kTrAPW4AvlhcP+ONVLO+eY34LabvFUoCf87r3zqigvvTEOsYpzJCPPyybb8tGfDBSQzoeEalX
	A00RTmSXgD79rscYA4DiA0ewHFmMYS3QfBtZdwaiCkm1CQIbZjwb5sc5VsfrQMBcQwW6bFxSn3QFa
	fF0uul5b4/8JyhXWKpcbSkSEkkJD/E12a8TEN0u/9SmThiDuG0HoskVUW5ZM0sTrN1c9JYTIRwRO4
	26IEJKfd7F3TyyWJ22etGcbLFCAiwFDVbAku4A3ofs+CUVzMYDOHP22hTOHhseFFdu707jc8cS7id
	cko3MHqQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1v0tvs-007ZMy-07;
	Tue, 23 Sep 2025 11:43:13 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 23 Sep 2025 11:43:12 +0800
Date: Tue, 23 Sep 2025 11:43:12 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jonathan McDowell <noodles@earth.li>
Cc: Olivia Mackall <olivia@selenic.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] hwrng: core - Allow runtime disabling of the HW RNG
Message-ID: <aNIXUADMpZWo0iFz@gondor.apana.org.au>
References: <aLWltVMmuYQn8Pwa@earth.li>
 <aMg4h_WeJb9bHeNb@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMg4h_WeJb9bHeNb@earth.li>

On Mon, Sep 15, 2025 at 05:02:15PM +0100, Jonathan McDowell wrote:
>
> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> index 018316f54621..1682a9f1b28c 100644
> --- a/drivers/char/hw_random/core.c
> +++ b/drivers/char/hw_random/core.c
> @@ -341,6 +341,10 @@ static ssize_t rng_current_store(struct device *dev,
>  	if (sysfs_streq(buf, "")) {
>  		err = enable_best_rng();
> +	} else if (sysfs_streq(buf, "none")) {
> +		if (current_rng)
> +			cur_rng_set_by_user = 1;

Shouldn't this be set unconditionally?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

