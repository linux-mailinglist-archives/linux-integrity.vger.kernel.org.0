Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6428C5429FD
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jun 2022 10:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiFHIyD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jun 2022 04:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiFHIxj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jun 2022 04:53:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872B337E8B1;
        Wed,  8 Jun 2022 01:12:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9BF0ECE2535;
        Wed,  8 Jun 2022 08:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99192C3411D;
        Wed,  8 Jun 2022 08:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654675336;
        bh=09GflePoermPFREk/n9az26hTfpo0H7Xj5McEsLlFJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCDxQYVmYqZidM5WW39gUjkgm4WMrJxNpUzfJj4EhOFOWPvu4V6xp81uL1rsn0o+o
         QfQLpX+VGhCgIeYK3mtLHVuI8dSweZq8nflfguxlEXwyeOYwDjG7enN91wpByGeRRr
         dFYK7sIqQQQTMkqrcDMK/aZF7epgSy243V6VEgaasLwJGBF1MgoMG05c8rzdkGeFKS
         wx+0tVXAfb9C7a6q8HlfqwmkkBgDg8bDaMZIhnkie0eomYRUFvzv/dtsCX4jl4b2GW
         MNJVIAOcln1Nv2khtLWUW3ofqY348n/xXnIr6/R4mlvggciQt+UjFANuWbgcZBzVq4
         xdEPxs0uQM+Jg==
Date:   Wed, 8 Jun 2022 11:00:19 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     jejb@linux.ibm.com, zohar@linux.ibm.com, dhowells@redhat.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security:trusted_tpm2: Fix memory leak in
 tpm2_key_encode()
Message-ID: <YqBXExY7M012ENt7@iki.fi>
References: <20220608025938.447908-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608025938.447908-1-niejianglei2021@163.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The short summary (as mentioned in review):

"KEYS: trusted: Fix memory leak in tpm2_key_encode()"

Also, you should version your patches, and provide a change log.

See: https://www.kernel.org/doc/html/v5.18/process/submitting-patches.html#the-canonical-patch-format

For git format-patch  you can simply supply "-vX" to get
the-canonical-patch-format version included.

On Wed, Jun 08, 2022 at 10:59:38AM +0800, Jianglei Nie wrote:
> tpm2_key_encode() allocates a memory chunk from scratch with kmalloc(),
> but it is never freed, which leads to a memory leak. Free the memory
> chunk with kfree() in the return path.
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---

Here you can write:

v3:
...
v2:
...

>  security/keys/trusted-keys/trusted_tpm2.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 0165da386289..dc9efd6c8b14 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -57,8 +57,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  		unsigned char bool[3], *w = bool;
>  		/* tag 0 is emptyAuth */
>  		w = asn1_encode_boolean(w, w + sizeof(bool), true);
> -		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
> +		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode")) {
> +			kfree(scratch);
>  			return PTR_ERR(w);
> +		}
>  		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
>  	}
>  
> @@ -69,8 +71,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  	 * trigger, so if it does there's something nefarious going on
>  	 */
>  	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
> -		 "BUG: scratch buffer is too small"))
> +		 "BUG: scratch buffer is too small")) {
> +		kfree(scratch);
>  		return -EINVAL;
> +	}
>  
>  	work = asn1_encode_integer(work, end_work, options->keyhandle);
>  	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
> @@ -79,8 +83,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  	work1 = payload->blob;
>  	work1 = asn1_encode_sequence(work1, work1 + sizeof(payload->blob),
>  				     scratch, work - scratch);
> -	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed"))
> +	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed")) {
> +		kfree(scratch);
>  		return PTR_ERR(work1);
> +	}
>  
>  	return work1 - payload->blob;
>  }
> -- 
> 2.25.1
> 

BR, Jarkko
