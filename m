Return-Path: <linux-integrity+bounces-2763-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F01D8D6B12
	for <lists+linux-integrity@lfdr.de>; Fri, 31 May 2024 22:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184B7287AB6
	for <lists+linux-integrity@lfdr.de>; Fri, 31 May 2024 20:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E242A22EEF;
	Fri, 31 May 2024 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCV0st2r"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A140DD26A;
	Fri, 31 May 2024 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717188524; cv=none; b=g33iwToOGa2Sd7eJLlK2ngkQE0KbLMa/kLIJ45B7yx3JIO+8atXXd/xRgA9hAM47G6R37UOxQqO+BoTSBStQTObG7QczHVvky5cJ6SJkr9D9d/yYehtXDBn9i+46S2GV0y2rjAnjuVfYQorp7oCgVFmF1q7u+BxIZKdfopE0gc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717188524; c=relaxed/simple;
	bh=rFnHh2wJYNoB76Ml+22NnUsLEKD+h/GAxFGey/czVOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6bfn4W3V81iwPmpO3omBTG3wRIgBqaryg98uL3LOozJWOERAlX0XPNwB1L39PjP+dK1hPeCdqkI1CRcOQqzgaldGmSoX8WZlVE+uYLwsSHPXrem506APX7Q04TmgWOoRZXj7AfukOBzbMd80AmqwsYBEm2OzcZsm6TJ7Gy+UKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCV0st2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EA2C116B1;
	Fri, 31 May 2024 20:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717188524;
	bh=rFnHh2wJYNoB76Ml+22NnUsLEKD+h/GAxFGey/czVOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cCV0st2rQscuWQRRD66py/Md9Mf8mIse5f5jZSqyArOSjheLY3FWzSZ0nnPnPNuDe
	 dX3NKU8cFLky+rp9zE1/dWqI9QumqMPadZXRguN/uqvqIy8JCxKqaT5mNWb2ddSTOP
	 WW3nTZoNUs3ooPHdjzSuivJ9cfYPEbub+Xi5sXHD8VdV0/X3G2UgRyohnG3NOyg4xP
	 HLW1WEdF0saOukDjTRCAHk8oZxhEhtrC+LbbXgmEUyHYqE4kDzV8OVVj9w3J3qszx/
	 OuZc8w6Q7BVzPPGo29tNFxZb8EPKfAFfd/Cq3VAehojM71REySKXZqSyAjrLTJO2hM
	 NBSeyCI3HYUHQ==
Date: Fri, 31 May 2024 20:48:42 +0000
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
Subject: Re: [PATCH v19 11/20] block,lsm: add LSM blob and new LSM hooks for
 block device
Message-ID: <20240531204842.GA2838215@google.com>
References: <1716583609-21790-1-git-send-email-wufan@linux.microsoft.com>
 <1716583609-21790-12-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716583609-21790-12-git-send-email-wufan@linux.microsoft.com>

On Fri, May 24, 2024 at 01:46:40PM -0700, Fan Wu wrote:
> From: Deven Bowers <deven.desai@linux.microsoft.com>
> 
> Some block devices have valuable security properties that is only
> accessible during the creation time.
>
> For example, when creating a dm-verity block device, the dm-verity's
> roothash and roothash signature, which are extreme important security
> metadata, are passed to the kernel. However, the roothash will be saved
> privately in dm-verity, which prevents the security subsystem to easily
> access that information. Worse, in the current implementation the
> roothash signature will be discarded after the verification, making it
> impossible to utilize the roothash signature by the security subsystem.

This patch seems to be assuming that creating the block device == setting up
dm-verity.  That's not how it actually works.  The way that device-mapper works
is that first a device-mapper device is created, and then targets are loaded
into it.  The targets can be changed later, any number of times.

So, while the creation of the block device is when the LSM blob is allocated,
it's not when the actual contents of it are initialized.  And its contents can
vary over the lifetime of the block device, including changing from something
the LSM "trusts" to something it doesn't "trust".

I'm not sure if this is "just" a documentation issue or if there are bugs
resulting from not handling changes properly.  The code itself *looks* correct,
but seeing it's not clear how much this has been considered and that getting
this wrong would allow the LSM checks to be bypassed, I thought I'd draw
attention to it.  This is really something that ought to be called out
explicitly in comments, for example.

> For example, LSM can use the new LSM blob to save the roothash signature of a
> dm-verity, and LSM can make access decision based on the data inside the
> signature, like the signer certificate.

This isn't what IPE actually does, though.  So this doesn't seem like a
particularly useful example in this context.

> For example, for dm-verity, LSMs can use this hook to save
> the roothash signature of a dm-verity into the security blob,
> and LSMs can make access decisions based on the data inside
> the signature, like the signer certificate.

Likewise.

> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 781c4500491b..eaa28f366d98 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -71,6 +71,9 @@ struct block_device {
>  
>  	struct partition_meta_info *bd_meta_info;
>  	int			bd_writers;
> +#ifdef CONFIG_SECURITY
> +	void			*security;
> +#endif

All the other fields in struct block_device are prefixed with "bd_", so please
use the same pattern for this new field (bd_security).

> diff --git a/security/security.c b/security/security.c
> index b419166979da..743652e5e893 100644
> --- a/security/security.c
> +++ b/security/security.c
[...]
> +/**
> + * security_bdev_setintegrity() - Set the device's integrity data
> + * @bdev: block device
> + * @type: type of integrity, e.g. hash digest, signature, etc
> + * @value: the integrity value
> + * @size: size of the integrity value
> + *
> + * Register a verified integrity measurement of a bdev with LSMs.
> + * LSMs should free the previously saved data if @value is NULL.
> + *
> + * Return: Returns 0 on success, negative values on failure.
> + */
> +int security_bdev_setintegrity(struct block_device *bdev,
> +			       enum lsm_integrity_type type, const void *value,
> +			       size_t size)
> +{
> +	return call_int_hook(bdev_setintegrity, bdev, type, value, size);
> +}
> +EXPORT_SYMBOL(security_bdev_setintegrity);

This might be a good place to explicitly document that the block device's
integrity properties may change over the lifetime of the block device and that
LSMs *must* (not "should") handle all possible types of updates, including
updates from a non-NULL value of a property to a NULL value.

- Eric

