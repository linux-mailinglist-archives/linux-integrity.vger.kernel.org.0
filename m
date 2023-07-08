Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482B874BC1E
	for <lists+linux-integrity@lfdr.de>; Sat,  8 Jul 2023 07:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjGHFhh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 8 Jul 2023 01:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjGHFhN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 8 Jul 2023 01:37:13 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F208D2688
        for <linux-integrity@vger.kernel.org>; Fri,  7 Jul 2023 22:36:59 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-634ddd17647so18051586d6.2
        for <linux-integrity@vger.kernel.org>; Fri, 07 Jul 2023 22:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688794618; x=1691386618;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dLpzT15vthbUVO0k71raasVu18kKS27blTVJmNCp9qw=;
        b=TJeqWacjduwbP6Y+SlQmoAGQHi1lphT6UAEvJNfG8M7m/0FnuH4lofD3tvQHae013R
         g+kAwyHtWpHISigG4/rbyEzd6fpSmCmFdpqI3eUvmpIpr9NDiKwyDsB7p2lRdYY/qAkP
         PkrukE7Z5dEBDUbVtA75oqvybWd1JV9qnpP6SM3Zr5QebCmjbU68jnvQbRl0WDdQJ/8C
         WClvUbL6oPSan2AXFMETYxTuwPuBbRiUYf0EyknQ60FgP+dNrijlvPFt1pax4Az2PMpM
         6gd3Z0UQjg5Ba4axeUMQN9xQ3CHwGy2GsMJYkmBRfLzybyCLDgybzBWGa37xu+RyDfXa
         sxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688794618; x=1691386618;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dLpzT15vthbUVO0k71raasVu18kKS27blTVJmNCp9qw=;
        b=MP9CMxtBtf/nP1StHlnXOg5BFKaCbdLnPhwKl8JRvG/TXjVJHYtND8+/Chx0UIbtAJ
         7QB72JknAlCh8RrhIuz0iKjd3cHCRPZV6gc1n5r0ekkE7TfuP36peKHlLWzcaRuFKU/A
         K8YvemVGz4vGzkgDAv/zMZRaJOrFomPp4d6+PN9SGs2Om65iylRkAsi5w9nax9HYBI7f
         A/7VPp8S1Rig+PxfFBvv4lscrhnRo2Y1jKRc4uLJQEgPQ2TV7q5BfQSmErX3Dfb35PxR
         kX/EGrsmKPg4Z2bjuGvHTPerYlCEMdcJ2+7CvdLVnrlqwILlRPL1asbewXciAHQI26mU
         wc4w==
X-Gm-Message-State: ABy/qLY6jSbD3drraHL8Zr1u4o9VH9bKm1Xf3Z8YXLqfBVIkS+SWUbZ1
        rb9PLFxXg0unfDiJ35voq78WDeT2gYhpHEY3zg==
X-Google-Smtp-Source: APBJJlGlLmfhTVjB4mohkDIyT1aO06AiFpA+DVrG9bmKubtLHJbdM9WNxESZ9ZiNvJziNKwf2PnzYA==
X-Received: by 2002:a0c:df07:0:b0:635:dfe1:c203 with SMTP id g7-20020a0cdf07000000b00635dfe1c203mr6459539qvl.64.1688794618672;
        Fri, 07 Jul 2023 22:36:58 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id o20-20020a0cf4d4000000b0063007ccaf42sm2971617qvm.57.2023.07.07.22.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 22:36:58 -0700 (PDT)
Date:   Sat, 08 Jul 2023 01:36:57 -0400
Message-ID: <2308135fa59ff970ca88649872acf35d.paul@paul-moore.com>
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
Subject: Re: [PATCH RFC v10 5/17] ipe: introduce 'boot_verified' as a trust  provider
References: <1687986571-16823-6-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1687986571-16823-6-git-send-email-wufan@linux.microsoft.com>
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
> IPE is designed to provide system level trust guarantees, this usually
> implies that trust starts from bootup with a hardware root of trust,
> which validates the bootloader. After this, the bootloader verifies the
> kernel and the initramfs.
> 
> As there's no currently supported integrity method for initramfs, and
> it's typically already verified by the bootloader, introduce a property
> that causes the first superblock to have an execution to be "pinned",
> which is typically initramfs.
> 
> When the "pinned" device is unmounted, it will be "unpinned" and
> `boot_verified` property will always evaluate to false afterward.
> 
> We use a pointer with a spin_lock to "pin" the device instead of rcu
> because rcu synchronization may sleep, which is not allowed when
> unmounting a device.
> 
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> ---
>  security/ipe/eval.c          | 72 +++++++++++++++++++++++++++++++++++-
>  security/ipe/eval.h          |  2 +
>  security/ipe/hooks.c         | 12 ++++++
>  security/ipe/hooks.h         |  2 +
>  security/ipe/ipe.c           |  1 +
>  security/ipe/policy.h        |  2 +
>  security/ipe/policy_parser.c | 37 +++++++++++++++++-
>  7 files changed, 126 insertions(+), 2 deletions(-)

The compilation errors continue into this patch.

> diff --git a/security/ipe/policy_parser.c b/security/ipe/policy_parser.c
> index 27e5767480b0..28c14adfe6d2 100644
> --- a/security/ipe/policy_parser.c
> +++ b/security/ipe/policy_parser.c
> @@ -265,6 +265,12 @@ static enum ipe_action_type parse_action(char *t)
>  	return match_token(t, action_tokens, args);
>  }
>  
> +static const match_table_t property_tokens = {
> +	{__IPE_PROP_BOOT_VERIFIED_FALSE,	"boot_verified=FALSE"},
> +	{__IPE_PROP_BOOT_VERIFIED_TRUE,		"boot_verified=TRUE"},
> +	{__IPE_PROP_INVALID,			NULL}
> +};
> +
>  /**
>   * parse_property - Parse the property type given a token string.
>   * @t: Supplies the token string to be parsed.
> @@ -277,7 +283,36 @@ static enum ipe_action_type parse_action(char *t)
>   */
>  static int parse_property(char *t, struct ipe_rule *r)
>  {
> -	return -EBADMSG;
> +	substring_t args[MAX_OPT_ARGS];
> +	struct ipe_prop *p = NULL;
> +	int rc = 0;
> +	int token;
> +
> +	p = kzalloc(sizeof(*p), GFP_KERNEL);
> +	if (!p)
> +		return -ENOMEM;
> +
> +	token = match_token(t, property_tokens, args);
> +
> +	switch (token) {
> +	case __IPE_PROP_BOOT_VERIFIED_FALSE:
> +	case __IPE_PROP_BOOT_VERIFIED_TRUE:
> +		p->type = token;
> +		break;
> +	case __IPE_PROP_INVALID:

You generally don't need to explicitly specify a case if the code
immediately falls through to 'default'.

> +	default:
> +		rc = -EBADMSG;
> +		break;
> +	}
> +	if (rc)
> +		goto err;
> +	list_add_tail(&p->next, &r->props);
> +
> +out:
> +	return rc;
> +err:
> +	kfree(p);
> +	goto out;

Once again, don't use a goto when the jump destination simply does a
return, do the return directly.

>  }
>  
>  /**
> -- 
> 2.25.1

--
paul-moore.com
