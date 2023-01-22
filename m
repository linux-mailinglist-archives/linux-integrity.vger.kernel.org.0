Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAE9677386
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Jan 2023 00:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjAVXmC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 22 Jan 2023 18:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjAVXmB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 Jan 2023 18:42:01 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A47411EB2
        for <linux-integrity@vger.kernel.org>; Sun, 22 Jan 2023 15:41:57 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id x40so15743710lfu.12
        for <linux-integrity@vger.kernel.org>; Sun, 22 Jan 2023 15:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zjuqfJ4N+xivLIIZdZR8REthLcBLstWRajPLFyBTaEM=;
        b=a9/90LjEvgCbhxaGnOoPEm4zqqLRCeb5duaUXVogxmilJ/35ztYjEX3+tQDqB3F7YQ
         lY4tZe0AuAaK9AIP/0Xs7hqArb9cTQnRqz7/4Phn4HaqmqulhESY5AqqQgN1nZ2kt7tC
         Al//YuXfP/nvgnYEfjcr1wT/qsPnfLzfvbwczz3ZC1bYoSBLn2OLUkhrBHRxcDPOv70Q
         9xALPWdYznHC8njE63PqAV8iuzmnpRgFbOLjxVJMfWQTB27EgdR1E9Hpsi38udaPvcpT
         2GZlDX59al6ZYx0Px5b9iGTUyCo2CY5Z+2UbY/9u9cZP2Rxh5XRhl68Bw8s8O7cYB2H0
         aRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjuqfJ4N+xivLIIZdZR8REthLcBLstWRajPLFyBTaEM=;
        b=o3kJORHErEry8DDF87oVfjAN1+frpEUJNi0pU8NR45IRVgo906O+tb4Lg5G2JORq0x
         6pEOFZ1Z1DaxHtnP7wHyTq64u4BKwTLH10zQzoQYLz8mnFruUeXj7+F0PCnIpWHZfUJc
         yFxle6oXn4Nnu5YAmVdW+9SwQ6/C7ZFgcW9/x3ctVCD19rssYMCqF5vNGS5Mc6XPB9eb
         bL7i6EbK/zMxACVRY6o2+8Imj1XVeYzFRbIlMyJ+meTpMXYuGp5UJvIeQM8CU8CMhM6v
         13J2eF9NhOG62kP+hEJ+ynV6KwrrBMDwJhnthHjJ6fhNQQFBqSvx+scEsN/zcBZB149V
         H8WQ==
X-Gm-Message-State: AFqh2krHpKcSNI7+azJyuSuXFFfouv19SrdNRzpfEfEkJ90m02oFoqhP
        J4s9roFiweM+qdG1Km7JWwQP5WT3sWCEgUHBVQo=
X-Google-Smtp-Source: AMrXdXtUy0a6sr4zx3aywzpUHIn1MpaBaJ0ugHd3D9BRltbjkguHIEKrCNRAql0zSVfjm7ZZiFYdBQ==
X-Received: by 2002:a19:2d46:0:b0:4a4:68b7:d645 with SMTP id t6-20020a192d46000000b004a468b7d645mr4761304lft.44.1674430914987;
        Sun, 22 Jan 2023 15:41:54 -0800 (PST)
Received: from google.com (38.165.88.34.bc.googleusercontent.com. [34.88.165.38])
        by smtp.gmail.com with ESMTPSA id a4-20020a056512390400b004949f7cbb6esm6403590lfu.79.2023.01.22.15.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 15:41:54 -0800 (PST)
Date:   Sun, 22 Jan 2023 23:41:48 +0000
From:   Matt Bobrowski <mattbobrowski@google.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima: fix error handling logic when file measurement
 failed
Message-ID: <Y83JvB7+IwxqRgMZ@google.com>
References: <Y7T1eAAVXoZ70MPM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7T1eAAVXoZ70MPM@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hey Mimi,

Just a gentle ping on this one. 

On Wed, Jan 04, 2023 at 03:41:44AM +0000, Matt Bobrowski wrote:
> Restore the error handling logic so that when file measurement fails,
> the respective iint entry is not left with the digest data being
> populated with zeroes.
> 
> Fixes: 54f03916fb89 ("ima: permit fsverity's file digests in the IMA measurement list")
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---
>  security/integrity/ima/ima_api.c  | 2 +-
>  security/integrity/ima/ima_main.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index c1e76282b5ee..1e3a7a4f8833 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -292,7 +292,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
>  		result = ima_calc_file_hash(file, &hash.hdr);
>  	}
>  
> -	if (result == -ENOMEM)
> +	if (result && result != -EBADF && result != -EINVAL)
>  		goto out;
>  
>  	length = sizeof(hash.hdr) + hash.hdr.length;
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 377300973e6c..b1ae0f2751f1 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -337,7 +337,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  	hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
>  
>  	rc = ima_collect_measurement(iint, file, buf, size, hash_algo, modsig);
> -	if (rc == -ENOMEM)
> +	if (rc != 0 && rc != -EBADF && rc != -EINVAL)
>  		goto out_locked;
>  
>  	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
> -- 
> 2.39.0.314.g84b9a713c41-goog

/M
