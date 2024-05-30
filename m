Return-Path: <linux-integrity+bounces-2704-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 860F38D4314
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 03:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEE06B23BF5
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 01:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94A617545;
	Thu, 30 May 2024 01:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="C5THloNk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C532F17588
	for <linux-integrity@vger.kernel.org>; Thu, 30 May 2024 01:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717033452; cv=none; b=S8HKz734n6TmIzlqlqfbymAx6HxD424BAJJZEzjn0P1jYxcHnrjPJKuKU7+MzUTTZc882BvfZIij8CNuik3Se9r9/LTVl8saYG9TV2ek3WpMr3GkbTopirTocCDTJSGhH3im2k2A5DuP48OqbuXgkXmLvKyGM5nzei5Nwa+YVOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717033452; c=relaxed/simple;
	bh=Dkoyl9eH9xPX6SY5fo5wWTjDVemt885sICBQQfc3AMc=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=W09aFt2OrOaoLA4Y9IcTvtunSBDqBJtTwJaXLx5hxdvWIhZ4nKHUO1J1Ytse036e3nyzylYS+1p5wrtUn08buNVdokPc9Xw5y68QJtDlS32fwr+1KCdnqDtPAFumtc6N7kOrLmldi9js8AghFkJL6TTvYlZC6V3/euOFqkIDLMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=C5THloNk; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-794ab181ff7so28713085a.2
        for <linux-integrity@vger.kernel.org>; Wed, 29 May 2024 18:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1717033450; x=1717638250; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JjXN8NpGNA42fcHFLopHeCrptlo6zAQlCC9qZAnbVGo=;
        b=C5THloNkLbLAcYrrLoEGp9o0KBDS8/i83//+RHaL2/nX59s4ySM8PdqdQFOrD7Zyog
         tZv6l+QPWguSgvD/kgYzUTYw/9nzFirm19heIFYwACEua1mQ6q/nTu4FjX4F0BbPojoJ
         tr5v5Ty58MJtLpxoeZQHg6vVzAdt1BE5sas0OI6T+NuH3V5OgAWmT2JC8D0W+g6xl1bf
         o9t8FwU5038fzpH0fp19zFyaJUImfHYFgpA2BA4/IO0BqWPUa4RNXcJZ1D2Ilv1YKIGO
         f6h9LNV/4IYwHmlpcOjlmO+cOVx+qx/8ZGnfItIxL+OORKg/Abvae8yWpEeqB82s3gaX
         380A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717033450; x=1717638250;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JjXN8NpGNA42fcHFLopHeCrptlo6zAQlCC9qZAnbVGo=;
        b=rizv8tk3Owl2XBZ1Ykr00Dwd0ydDc4rdc1tzRj7r8Tcs4XPdhqGoY6kweD+5PHQOtO
         MIoKZyQHHq8SvmfBQPh4HtEkcZmkpnM54EBecHWxfgd+MVV8VUOFHtaR/kQ2jTDSwM2Z
         ODJ8CW254MJ4ydyCDyNSsefLFpJDleIAn9J4fBFzGpugrEtNeHj9w+lRaSuo0dWKz8OT
         c8ufY0Q0we9MfbXh3aX53SkFEg7LuigYbcj5ETdsZ2EcA9yIoOfDe2O8gvbksgfs5VnX
         nQjTtFvZAiYn/3S3WprzBFmUU/bAZMZ5/OoSfKTTQrSGbUZeyeDi2VndHYMybk77EgDK
         Drdw==
X-Forwarded-Encrypted: i=1; AJvYcCUACThJJYD6OammNMEIvGf4E7WMpA9jGlytEFudeCsu7UiUO+VWVPkBBj/+ER9hM535Q6jt9uJYQ0AgQ21VYvzN0H8fvyaHVS3HKir2K6Sd
X-Gm-Message-State: AOJu0YxpzBBJpuVvZ/0YRfIxstjkc/RuuSFYQVtWG/NYQmw939uF7B60
	kUylnlPzl4yv3m+fWOjHE1mmnwTdBWXVimDEQ/w+M29d9ppCCdGQWcRNkUZ0cw==
X-Google-Smtp-Source: AGHT+IHXci0OO4XwCTtBxInLkT4T/ekembfibhyph2b2S2yaT2IF0CDBqyIyOJ5rHbQjEbyfTzapiA==
X-Received: by 2002:a05:620a:2403:b0:794:8ffe:c79b with SMTP id af79cd13be357-794e9da1764mr108898385a.19.1717033449619;
        Wed, 29 May 2024 18:44:09 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794ba86855bsm375195885a.69.2024.05.29.18.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 18:44:09 -0700 (PDT)
Date: Wed, 29 May 2024 21:44:08 -0400
Message-ID: <2ecde610ca3f0cabcbb111e3432f2dd5@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, eparis@redhat.com
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>, Fan Wu <wufan@linux.microsoft.com>
Subject: Re: [PATCH v19 13/20] ipe: add support for dm-verity as a trust  provider
References: <1716583609-21790-14-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1716583609-21790-14-git-send-email-wufan@linux.microsoft.com>

On May 24, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
> 
> Allows author of IPE policy to indicate trust for a singular dm-verity
> volume, identified by roothash, through "dmverity_roothash" and all
> signed and validated dm-verity volumes, through "dmverity_signature".
> 
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> ---
> v2:
>   + No Changes
> 
> v3:
>   + No changes
> 
> v4:
>   + No changes
> 
> v5:
>   + No changes
> 
> v6:
>   + Fix an improper cleanup that can result in
>     a leak
> 
> v7:
>   + Squash patch 08/12, 10/12 to [11/16]
> 
> v8:
>   + Undo squash of 08/12, 10/12 - separating drivers/md/ from security/
>     & block/
>   + Use common-audit function for dmverity_signature.
>   + Change implementation for storing the dm-verity digest to use the
>     newly introduced dm_verity_digest structure introduced in patch
>     14/20.
> 
> v9:
>   + Adapt to the new parser
> 
> v10:
>   + Select the Kconfig when all dependencies are enabled
> 
> v11:
>   + No changes
> 
> v12:
>   + Refactor to use struct digest_info* instead of void*
>   + Correct audit format
> 
> v13:
>   + Remove the CONFIG_IPE_PROP_DM_VERITY dependency inside the parser
>     to make the policy grammar independent of the kernel config.
> 
> v14:
>   + No changes
> 
> v15:
>   + Fix one grammar issue in KCONFIG
>   + Switch to use security_bdev_setintegrity() hook
> 
> v16:
>   + Refactor for enum integrity type
> 
> v17:
>   + Add years to license header
>   + Fix code and documentation style issues
>   + Return -EINVAL in ipe_bdev_setintegrity when passed type is not
>     supported
>   + Use new enum name LSM_INT_DMVERITY_SIG_VALID
> 
> v18:
>   + Add Kconfig IPE_PROP_DM_VERITY_SIGNATURE and make both DM_VERITY
>     config auto-selected
> 
> v19:
>   + No changes
> ---
>  security/ipe/Kconfig         |  27 ++++++++
>  security/ipe/Makefile        |   1 +
>  security/ipe/audit.c         |  29 ++++++++-
>  security/ipe/digest.c        | 118 +++++++++++++++++++++++++++++++++++
>  security/ipe/digest.h        |  26 ++++++++
>  security/ipe/eval.c          |  93 ++++++++++++++++++++++++++-
>  security/ipe/eval.h          |  12 ++++
>  security/ipe/hooks.c         |  93 +++++++++++++++++++++++++++
>  security/ipe/hooks.h         |   8 +++
>  security/ipe/ipe.c           |  15 +++++
>  security/ipe/ipe.h           |   4 ++
>  security/ipe/policy.h        |   3 +
>  security/ipe/policy_parser.c |  24 ++++++-
>  13 files changed, 449 insertions(+), 4 deletions(-)
>  create mode 100644 security/ipe/digest.c
>  create mode 100644 security/ipe/digest.h

...

> diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
> index b68719bf44fb..51f1e63c295c 100644
> --- a/security/ipe/hooks.c
> +++ b/security/ipe/hooks.c
> @@ -191,3 +193,94 @@ void ipe_unpack_initramfs(void)
>  {
>  	ipe_sb(current->fs->root.mnt->mnt_sb)->initramfs = true;
>  }
> +
> +#ifdef CONFIG_IPE_PROP_DM_VERITY
> +/**
> + * ipe_bdev_free_security() - Free IPE's LSM blob of block_devices.
> + * @bdev: Supplies a pointer to a block_device that contains the structure
> + *	  to free.
> + */
> +void ipe_bdev_free_security(struct block_device *bdev)
> +{
> +	struct ipe_bdev *blob = ipe_bdev(bdev);
> +
> +	ipe_digest_free(blob->root_hash);
> +}
> +
> +#ifdef CONFIG_IPE_PROP_DM_VERITY_SIGNATURE
> +static void ipe_set_dmverity_signature(struct ipe_bdev *blob,
> +				       const void *value,
> +				       size_t size)
> +{
> +	blob->dm_verity_signed = size > 0 && value;
> +}
> +#else
> +static inline void ipe_set_dmverity_signature(struct ipe_bdev *blob,
> +					      const void *value,
> +					      size_t size)
> +{
> +}
> +#endif /* CONFIG_IPE_PROP_DM_VERITY_SIGNATURE */
> +
> +/**
> + * ipe_bdev_setintegrity() - Save integrity data from a bdev to IPE's LSM blob.
> + * @bdev: Supplies a pointer to a block_device that contains the LSM blob.
> + * @type: Supplies the integrity type.
> + * @value: Supplies the value to store.
> + * @size: The size of @value.
> + *
> + * This hook is currently used to save dm-verity's root hash or the existence
> + * of a validated signed dm-verity root hash into LSM blob.
> + *
> + * Return: %0 on success. If an error occurs, the function will return the
> + * -errno.
> + */
> +int ipe_bdev_setintegrity(struct block_device *bdev, enum lsm_integrity_type type,
> +			  const void *value, size_t size)
> +{
> +	const struct dm_verity_digest *digest = NULL;
> +	struct ipe_bdev *blob = ipe_bdev(bdev);
> +	struct digest_info *info = NULL;
> +
> +	if (type == LSM_INT_DMVERITY_ROOTHASH) {
> +		if (!value) {
> +			ipe_digest_free(blob->root_hash);
> +			blob->root_hash = NULL;
> +
> +			return 0;
> +		}
> +		digest = value;
> +
> +		info = kzalloc(sizeof(*info), GFP_KERNEL);
> +		if (!info)
> +			return -ENOMEM;
> +
> +		info->digest = kmemdup(digest->digest, digest->digest_len,
> +				       GFP_KERNEL);
> +		if (!info->digest)
> +			goto dmv_roothash_err;
> +
> +		info->alg = kstrdup(digest->alg, GFP_KERNEL);
> +		if (!info->alg)
> +			goto dmv_roothash_err;
> +
> +		info->digest_len = digest->digest_len;
> +
> +		if (blob->root_hash)
> +			ipe_digest_free(blob->root_hash);

The above if/free looks like a new addition from v18 and I'm not quite
sure why the `blob->root_hash` NULL check is necessary as
ipe_digest_free() does a IS_ERR_OR_NULL() check right at the top.

Likely harmless and doubtful to have any noticable performance impact,
but I wanted to mention it just in case ...

> +		blob->root_hash = info;
> +
> +		return 0;
> +dmv_roothash_err:
> +		ipe_digest_free(info);
> +
> +		return -ENOMEM;
> +	} else if (type == LSM_INT_DMVERITY_SIG_VALID) {
> +		ipe_set_dmverity_signature(blob, value, size);
> +
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +#endif /* CONFIG_IPE_PROP_DM_VERITY */

--
paul-moore.com

