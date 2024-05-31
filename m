Return-Path: <linux-integrity+bounces-2764-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130108D6B3E
	for <lists+linux-integrity@lfdr.de>; Fri, 31 May 2024 23:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 744C7B240E3
	for <lists+linux-integrity@lfdr.de>; Fri, 31 May 2024 21:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F72C81726;
	Fri, 31 May 2024 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlaQ60jH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BB980043;
	Fri, 31 May 2024 21:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717189645; cv=none; b=tnENd9JphxsRJpi/s6o3dXYHRh/OvjguOOBZ287WOR5yFogrGAsvri/I1Bc3QTH4eF014mp4S6sou6gtCYsJ0nbaqznEmdRDwTvm6m2SwPyRKkSpnYl3HsyqR1GHjAlMPf/oh8vaxBkixVIL4g1ScVbVUfEfs/EQkYM013p/BeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717189645; c=relaxed/simple;
	bh=VTJxFpufpw/wb7fXrQpiRSaeHxnjVyqQgbQw3GY+JZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5NElhk7OVeiinpK89uP9vRGRE7jyXNc2AWRG34XYqLyXZ2+xtRb7Cau7BpFQKsYlUkxhmNO6Ob7oZz6r7Y7wEm6RS+Yeunb2R0RDYIt8BufecRgaHRz5jK6OkZPJCTyHnRA/o6nZUOqoOrjHeY9Faj57c3Zi/LIVaDm4so+4sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlaQ60jH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76496C116B1;
	Fri, 31 May 2024 21:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717189644;
	bh=VTJxFpufpw/wb7fXrQpiRSaeHxnjVyqQgbQw3GY+JZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JlaQ60jHg/ryzHhfMN0zWbzfasGhDbP58kShYSZQQ0GQQf2sNmego7GVbbbrgguOg
	 tKqXQmUVj04jTSHz83oL8wGtyU52uD+0yxV6BbhMpJfKt/8oaT5mCPKlveTiZcKdd2
	 DWA9ftIrL+DibJzhhV+z7gBSxAXinEtmGWRjo+RPA4QPFCSNbRLYiuq4e4nsbWYZ7B
	 MVfV8Gb4HM7mgsO1y2CeDr/emuKYn/vsIGe+Pzm/myBvMjme9aSMVyf1oImaBKMlCo
	 4sRAzcJuv/t93lyf3o1y6Wl4QEd/49+9zBQgrOHJRDYw7wV+mtZdFZ7HFMk7RqlQh2
	 3SFn7M7WePxaA==
Date: Fri, 31 May 2024 21:07:23 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org,
	serge@hallyn.com, tytso@mit.edu, axboe@kernel.dk, agk@redhat.com,
	snitzer@kernel.org, mpatocka@redhat.com, eparis@redhat.com,
	paul@paul-moore.com, linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	audit@vger.kernel.org, linux-kernel@vger.kernel.org,
	Deven Bowers <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH v19 12/20] dm verity: expose root hash digest and
 signature data to LSMs
Message-ID: <20240531210723.GB2838215@google.com>
References: <1716583609-21790-1-git-send-email-wufan@linux.microsoft.com>
 <1716583609-21790-13-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716583609-21790-13-git-send-email-wufan@linux.microsoft.com>

On Fri, May 24, 2024 at 01:46:41PM -0700, Fan Wu wrote:
> +#ifdef CONFIG_SECURITY
> +
> +#ifdef CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG
> +
> +static int verity_security_set_signature(struct block_device *bdev,
> +					 struct dm_verity *v)
> +{
> +	return security_bdev_setintegrity(bdev,
> +					  LSM_INT_DMVERITY_SIG_VALID,
> +					  v->root_digest_sig,
> +					  v->sig_size);
> +}
> +
> +#else
> +
> +static inline int verity_security_set_signature(struct block_device *bdev,
> +						struct dm_verity *v)
> +{
> +	return 0;
> +}
> +
> +#endif /* CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG */
> +
> +/*
> + * Expose verity target's root hash and signature data to LSMs before resume.
> + *
> + * Returns 0 on success, or -ENOMEM if the system is out of memory.
> + */
> +static int verity_preresume(struct dm_target *ti)
> +{
> +	struct block_device *bdev;
> +	struct dm_verity_digest root_digest;
> +	struct dm_verity *v;
> +	int r;
> +
> +	v = ti->private;
> +	bdev = dm_disk(dm_table_get_md(ti->table))->part0;
> +	root_digest.digest = v->root_digest;
> +	root_digest.digest_len = v->digest_size;
> +	root_digest.alg = crypto_ahash_alg_name(v->tfm);
> +
> +	r = security_bdev_setintegrity(bdev, LSM_INT_DMVERITY_ROOTHASH, &root_digest,
> +				       sizeof(root_digest));
> +	if (r)
> +		return r;
> +
> +	r =  verity_security_set_signature(bdev, v);
> +	if (r)
> +		goto bad;
> +
> +	return 0;
> +
> +bad:
> +
> +	security_bdev_setintegrity(bdev, LSM_INT_DMVERITY_ROOTHASH, NULL, 0);
> +
> +	return r;
> +}
> +
> +#endif /* CONFIG_SECURITY */
> +
>  static struct target_type verity_target = {
>  	.name		= "verity",
>  	.features	= DM_TARGET_SINGLETON | DM_TARGET_IMMUTABLE,

Due to the possibility of table reloads, it looks like the security of this
scheme is dependent on (a) DM_TARGET_SINGLETON, (b) DM_TARGET_IMMUTABLE, *and*
(c) sending LSM_INT_DMVERITY_ROOTHASH and LSM_INT_DMVERITY_SIG_VALID to the
LSM(s) even when there is no signature.  Notably, this differs from the
similar-looking code in fsverity where updates are not possible and
LSM_INT_FSVERITY_BUILTINSIG_VALID is not sent when there's no signature.

Given the subtleties here and the fact that getting any of these things wrong
would allow the LSM checks to be bypassed, it would really be worth leaving a
comment that explicitly documents why this is secure.  And maybe also a 
/* Note: singleton and immutable are depended on by the LSM hooks */ just above
the 'DM_TARGET_SINGLETON | DM_TARGET_IMMUTABLE' in case someone tries to remove
those.  I see they were added only recently, which was a breaking UAPI change,
so I worry about people trying to revert it.

- Eric

