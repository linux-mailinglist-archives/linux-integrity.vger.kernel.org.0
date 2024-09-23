Return-Path: <linux-integrity+bounces-3666-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B723E97ECC3
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2024 16:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F52B1F21CF7
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2024 14:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8599019993E;
	Mon, 23 Sep 2024 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Co9wgEHp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B00198846
	for <linux-integrity@vger.kernel.org>; Mon, 23 Sep 2024 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727100270; cv=none; b=IJaElZXIZBAhNbsZvmkhw0k3xRwtQNDdHUWdy/IJjSjDYE0zYDpuNflc9XBhiOVw8yJ/PB+L35MHS9T2QuGs/4krNNjPIPPMUvx1iCjEv1maPK/4adgtblrX8Nhc4q6ff9h05q5Jm53NewqFHA/kVRTQzBS+1yR5Hl7IpJtpBx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727100270; c=relaxed/simple;
	bh=gSx9WElPoDc3GpnWNuZWuoC3lDWAnGUmRJLHC+V4aD0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o1QL8b6WkxDNU8IMj1TYYeyIGoXYf4h6cOw/33lzZ0eDwcj284euqzJVeudo/MnQaQ0ypJtZo0wZUI7HPk1DsHWKcXTQSpJzHnk3TdAt8TsSEBttX0T4DXuaewtXu2vdjR3pi0sBc12ZOkL6xENjOByb794ox3wQmz+VBZmvOPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Co9wgEHp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727100267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BZBpzUBCLdRFe7Fe/66+8sc2jK73AsIgYMvGRGKjsF8=;
	b=Co9wgEHpJHUmhH3tvxs9kByWhVpQA/Zbih7RMgDLJYiUkajW4gmJEA6xSTP44p2cjYOasS
	9ufrncPBQlDO8HaCvUkbOL0+Z2q894fnsmriWU8shFLb1d5wRgQEIHzCPhxOI+z0W9yM7o
	d6U80aJtOOcQo05RDW5MjqIlpBAuXJ4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-J-NuBEIEN22XD9dWQO2_KQ-1; Mon,
 23 Sep 2024 10:04:24 -0400
X-MC-Unique: J-NuBEIEN22XD9dWQO2_KQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B2021955D4B;
	Mon, 23 Sep 2024 14:04:21 +0000 (UTC)
Received: from [10.45.226.79] (unknown [10.45.226.79])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C34C19560A3;
	Mon, 23 Sep 2024 14:04:17 +0000 (UTC)
Date: Mon, 23 Sep 2024 16:04:15 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: luca.boccassi@gmail.com
cc: dm-devel@lists.linux.dev, snitzer@kernel.org, serge@hallyn.com, 
    wufan@linux.microsoft.com, David Howells <dhowells@redhat.com>, 
    Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org, 
    linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH] dm verity: fallback to platform keyring also if key in
 trusted keyring is rejected
In-Reply-To: <20240922161753.244476-1-luca.boccassi@gmail.com>
Message-ID: <6b3e0e45-5efe-3032-62b8-75dcd45c879c@redhat.com>
References: <20240922161753.244476-1-luca.boccassi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On Sun, 22 Sep 2024, luca.boccassi@gmail.com wrote:

> From: Luca Boccassi <bluca@debian.org>
> 
> If enabled, we fallback to the platform keyring if the trusted keyring doesn't have
> the key used to sign the roothash. But if pkcs7_verify() rejects the key for other
> reasons, such as usage restrictions, we do not fallback. Do so.
> 
> Follow-up for 6fce1f40e95182ebbfe1ee3096b8fc0b37903269
> 
> Suggested-by: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: Luca Boccassi <bluca@debian.org>

Hi

I'm not an expert in keyrings.

I added keyring maintainers to the CC. Please review this patch and 
Ack/Nack it.

Mikulas

> ---
>  drivers/md/dm-verity-verify-sig.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-verity-verify-sig.c
> index d351d7d39c60..a9e2c6c0a33c 100644
> --- a/drivers/md/dm-verity-verify-sig.c
> +++ b/drivers/md/dm-verity-verify-sig.c
> @@ -127,7 +127,7 @@ int verity_verify_root_hash(const void *root_hash, size_t root_hash_len,
>  #endif
>  				VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
>  #ifdef CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_PLATFORM_KEYRING
> -	if (ret == -ENOKEY)
> +	if (ret == -ENOKEY || ret == -EKEYREJECTED)
>  		ret = verify_pkcs7_signature(root_hash, root_hash_len, sig_data,
>  					sig_len,
>  					VERIFY_USE_PLATFORM_KEYRING,
> -- 
> 2.39.5
> 


