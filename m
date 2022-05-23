Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7B45317E2
	for <lists+linux-integrity@lfdr.de>; Mon, 23 May 2022 22:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiEWUSw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 May 2022 16:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiEWUSv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 May 2022 16:18:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4DDBC6C1;
        Mon, 23 May 2022 13:18:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43BD36149B;
        Mon, 23 May 2022 20:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DC3C34115;
        Mon, 23 May 2022 20:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653337129;
        bh=Oky30mjAy0XGOGk+HiHtKArSHvHDCwGmwJ+TCJIjeDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2dXEBCj3h1i3M928gOSl4FNrOYJjx+/+sguY3zRzwr3q9oyG4ZcUur3iIGsIl2Ki
         He+1qcxxhR++a3Qxckm/qlUsVmMq54672jqZULZGod3Ag/WhgP88ZaLx4u9esEwCqN
         ht42Fd9+tNQHx8o+MRd90nhJkTJm7ONOJa1lDfoSBQ9G1ZJw2MOWYlovThuZiXpzDT
         LcWK4cLRyzX4nuen2/5NbvThXZa+aXNWOdM8NeJyZ8vKY4FzpowoTXN5E0nYpyR285
         m350lgf4O0H4M1Q5OXI47tRF4lBv5p0uW5I19wkyCq921tqvgQp9spjecOd7+X0N5H
         +i4Q3iKlEX6QQ==
Date:   Mon, 23 May 2022 23:17:08 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     GUO Zihua <guozihua@huawei.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, keyrings@vger.kernel.org
Subject: Re: [PATCH v2] keys: Use struct_size and size_add helper with alloc
Message-ID: <YovrxNMktll1Q61T@kernel.org>
References: <20220523014155.27840-1-guozihua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523014155.27840-1-guozihua@huawei.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 23, 2022 at 09:41:55AM +0800, GUO Zihua wrote:
> Use struct_size helper for calculating size of flexible struct, following
> the best practice.
> 
> Reference: https://lore.kernel.org/all/CAHk-=wiGWjxs7EVUpccZEi6esvjpHJdgHQ=vtUeJ5crL62hx9A@mail.gmail.com/
> 
> Note: HASH_SIZE here is a SHA256_DIGEST_SIZE whoes value is 32, so
> adding 1 should be fine here.
> 
> Signed-off-by: GUO Zihua <guozihua@huawei.com>

Instead

"""
Link: https://lore.kernel.org/all/CAHk-=wiGWjxs7EVUpccZEi6esvjpHJdgHQ=vtUeJ5crL62hx9A@mail.gmail.com/
Signed-off-by: GUO Zihua <guozihua@huawei.com>
"""

You should split this into two patches as said in
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#separate-your-changes

Also these are bug fixes and the commit message does not contain
any description of the issue, e.g.

"""
When issuing

CF='-Wflexible-array-sizeof' make C=2 security/keys/encrypted-keys/encrypted.o

the following is observed:

security/keys/encrypted-keys/encrypted.c:670:28: warning: using sizeof on a flexible structure
security/keys/encrypted-keys/encrypted.c: note: in included file:
"""

And then explain why struct_size() addresses this issue, and provide
Fixes tag.

> 
> ---
> 
> v2:
>     Update the commit message, removing the part about "potential issue"
>     following Jarkko's suggestion.
> 
> ---
>  security/keys/encrypted-keys/encrypted.c | 7 +++++--
>  security/keys/user_defined.c             | 2 +-
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
> index e05cfc2e49ae..37349580e855 100644
> --- a/security/keys/encrypted-keys/encrypted.c
> +++ b/security/keys/encrypted-keys/encrypted.c
> @@ -613,6 +613,7 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>  	long dlen;
>  	int i;
>  	int ret;
> +	size_t epayload_datalen = 0;
>  
>  	ret = kstrtol(datalen, 10, &dlen);
>  	if (ret < 0 || dlen < MIN_DATA_SIZE || dlen > MAX_DATA_SIZE)
> @@ -667,8 +668,10 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>  	if (ret < 0)
>  		return ERR_PTR(ret);
>  
> -	epayload = kzalloc(sizeof(*epayload) + payload_datalen +
> -			   datablob_len + HASH_SIZE + 1, GFP_KERNEL);
> +	epayload_datalen = size_add(payload_datalen, datablob_len);
> +	epayload_datalen = size_add(epayload_datalen, HASH_SIZE + 1);
> +	epayload = kzalloc(struct_size(epayload, payload_data,
> +				epayload_datalen), GFP_KERNEL);
>  	if (!epayload)
>  		return ERR_PTR(-ENOMEM);
>  
> diff --git a/security/keys/user_defined.c b/security/keys/user_defined.c
> index 749e2a4dcb13..334fed36e9f3 100644
> --- a/security/keys/user_defined.c
> +++ b/security/keys/user_defined.c
> @@ -64,7 +64,7 @@ int user_preparse(struct key_preparsed_payload *prep)
>  	if (datalen <= 0 || datalen > 32767 || !prep->data)
>  		return -EINVAL;
>  
> -	upayload = kmalloc(sizeof(*upayload) + datalen, GFP_KERNEL);
> +	upayload = kmalloc(struct_size(upayload, data, datalen), GFP_KERNEL);
>  	if (!upayload)
>  		return -ENOMEM;
>  
> -- 
> 2.36.0
> 

BR, Jarkko
