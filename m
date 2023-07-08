Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2729874BC41
	for <lists+linux-integrity@lfdr.de>; Sat,  8 Jul 2023 07:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjGHFil (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 8 Jul 2023 01:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjGHFhu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 8 Jul 2023 01:37:50 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1197C26B8
        for <linux-integrity@vger.kernel.org>; Fri,  7 Jul 2023 22:37:03 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7653bd3ff2fso262948885a.3
        for <linux-integrity@vger.kernel.org>; Fri, 07 Jul 2023 22:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688794623; x=1691386623;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Hz3LNSJIA32LS0w6BjIcScwNW8naJ0tmp1lMEgiYII=;
        b=WMjK0HEyLb6k8Lr9S8HYjINbqxFLs2ibv2n9WI7AnF2cBRrod0QTwW2rDHTsYk8Ju5
         QKB7L7j1kAZdO89V+9fU9rA4znRoQV17IMA0VV5QCToHaNcGDHjU3KUEuict4N+aLesT
         sGaK8i9hrVkpBpuqqFMmufNeAqpBBQk+AV3rOUbbVxRJZyPg14Ii71zfzyg9kGDrxOgO
         x7cB0oc2kSF4xkvDUiJgla79AxECldOnSOLbNF8Q5utVVSYRg0vz5LfBbBvKLux3/XYe
         k2XmHMVL8eIZ404ULZpznHcq70SU7ouLCfw21989uHJmHsIHYP4UnIDmKiR3XQJY+fK/
         23ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688794623; x=1691386623;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Hz3LNSJIA32LS0w6BjIcScwNW8naJ0tmp1lMEgiYII=;
        b=TcIHdxd7UeTiBdzOvdRtjyNFSBjaKuJKKD5kz1fsgCM4eJhlvO4bna+zl2CI4XKolp
         75J0G4xAf0KmZFUiI0IxNAvYPJdKXLu1rKGjAzAY8cn8dKdgQBi6vo7KulkFWQNNO7jM
         KjKKq1zePLy0+vXPkocFscboKKSaw5g33sEkYhgFInqzYU6TyvNGf8D9dArOqcXJuICe
         mPLBrpxmDofm1RC5R8rCtrCUIz9Y54ug04rVoCaUTBoAUZh/7/Uaj63fbHRjWzJg8cvP
         AkjG54lCyZc2Twa+BLaJBuC+6KVavtjDSdb5sdtx30ux6l4NHHfaoyGlIu46tJZpEzHP
         uxww==
X-Gm-Message-State: ABy/qLbGkYHkanUoi2tKG2kj/qLlvtuEzeBXRV8FqjCf2VgeYxo55NNz
        zqK4Qo4MavjxPCXw6V19EmdP
X-Google-Smtp-Source: APBJJlGE5kRrswBX0Y9fpwcc9M53MKX/WP5JEebgbuewEsG3HG+C8bw51ha3b43wJWNhFgxWAHSXSg==
X-Received: by 2002:a0c:9a06:0:b0:631:e696:7b6 with SMTP id p6-20020a0c9a06000000b00631e69607b6mr6291591qvd.53.1688794622811;
        Fri, 07 Jul 2023 22:37:02 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id a6-20020a0cca86000000b0062df126ca11sm2943746qvk.21.2023.07.07.22.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 22:37:02 -0700 (PDT)
Date:   Sat, 08 Jul 2023 01:37:02 -0400
Message-ID: <f1e5890316985ff642d17201e28e9d11.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk,
        agk@redhat.com, snitzer@kernel.org, eparis@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, audit@vger.kernel.org,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Fan Wu <wufan@linux.microsoft.com>
Subject: Re: [PATCH RFC v10 12/17] ipe: add support for dm-verity as a trust  provider
References: <1687986571-16823-13-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1687986571-16823-13-git-send-email-wufan@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Jun 28, 2023 Fan Wu <wufan@linux.microsoft.com> wrote:
> 
> Allows author of IPE policy to indicate trust for a singular dm-verity
> volume, identified by roothash, through "dmverity_roothash" and all
> signed dm-verity volumes, through "dmverity_signature".
> 
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> ---
>  security/ipe/Kconfig         |  18 +++++
>  security/ipe/Makefile        |   1 +
>  security/ipe/audit.c         |  25 ++++++
>  security/ipe/digest.c        | 142 +++++++++++++++++++++++++++++++++++
>  security/ipe/digest.h        |  26 +++++++
>  security/ipe/eval.c          | 101 ++++++++++++++++++++++++-
>  security/ipe/eval.h          |  13 ++++
>  security/ipe/hooks.c         |  51 +++++++++++++
>  security/ipe/hooks.h         |   8 ++
>  security/ipe/ipe.c           |  15 ++++
>  security/ipe/ipe.h           |   4 +
>  security/ipe/policy.h        |   3 +
>  security/ipe/policy_parser.c |  21 ++++++
>  13 files changed, 427 insertions(+), 1 deletion(-)
>  create mode 100644 security/ipe/digest.c
>  create mode 100644 security/ipe/digest.h

...

> diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
> index 6f94f5c8a0c3..9651e582791e 100644
> --- a/security/ipe/hooks.c
> +++ b/security/ipe/hooks.c
> @@ -192,3 +195,51 @@ void ipe_sb_free_security(struct super_block *mnt_sb)
>  {
>  	ipe_invalidate_pinned_sb(mnt_sb);
>  }
> +
> +#ifdef CONFIG_IPE_PROP_DM_VERITY
> +/**
> + * ipe_bdev_free_security - free IPE's LSM blob of block_devices.
> + * @bdev: Supplies a pointer to a block_device that contains the structure
> + *	  to free.
> + */
> +void ipe_bdev_free_security(struct block_device *bdev)
> +{
> +	struct ipe_bdev *blob = ipe_bdev(bdev);
> +
> +	kfree(blob->digest);
> +	kfree(blob->digest_algo);
> +}
> +
> +/**
> + * ipe_bdev_setsecurity - save data from a bdev to IPE's LSM blob.
> + * @bdev: Supplies a pointer to a block_device that contains the LSM blob.
> + * @key: Supplies the string key that uniquely identifies the value.
> + * @value: Supplies the value to store.
> + * @len: The length of @value.
> + */
> +int ipe_bdev_setsecurity(struct block_device *bdev, const char *key,
> +			 const void *value, size_t len)
> +{
> +	struct ipe_bdev *blob = ipe_bdev(bdev);

Before you can interpret the @key value, you need to first determine
which type of block device you have been handed.  It is possible that
multiple block device types could share the same key with very
different meanings for that key, yes?

> +	if (!strcmp(key, DM_VERITY_ROOTHASH_SEC_NAME)) {
> +		const struct dm_verity_digest *digest = value;
> +
> +		blob->digest = kmemdup(digest->digest, digest->digest_len, GFP_KERNEL);
> +		if (!blob->digest)
> +			return -ENOMEM;
> +
> +		blob->digest_algo = kstrdup_const(digest->algo, GFP_KERNEL);
> +		if (!blob->digest_algo)
> +			return -ENOMEM;
> +
> +		blob->digest_len = digest->digest_len;
> +		return 0;
> +	} else if (!strcmp(key, DM_VERITY_SIGNATURE_SEC_NAME)) {
> +		blob->dm_verity_signed = true;
> +		return 0;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +#endif /* CONFIG_IPE_PROP_DM_VERITY */

--
paul-moore.com
