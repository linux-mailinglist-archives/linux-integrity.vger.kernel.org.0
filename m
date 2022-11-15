Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2F862AFC7
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Nov 2022 00:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiKOX4r (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Nov 2022 18:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiKOX4q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Nov 2022 18:56:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6510312AC5;
        Tue, 15 Nov 2022 15:56:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 197E9B81B7B;
        Tue, 15 Nov 2022 23:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAE5C433D6;
        Tue, 15 Nov 2022 23:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668556602;
        bh=fmtFU9r9azSVNfkJz1lP+IVE4pNw8RU+BlNPODiczaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFSHlT/si1HQjrtKxvXQyXtXyZGov9zxqMGHT6YE2JWGYxER/Hld5fpIYPTrF2px5
         TdJLH3GlcVUIXjSDaRyJ+Xaov0a3rRo59fUe/UICFnYhMupXezw50MKoiQkDXTKwmc
         qAYO+dEJKLZpxIOlHabKPX472GiVki3bU9dEiqEsmsdj/7Ad91cyzH0aOU8uEfZot5
         tLMeyF+Ph58MXR7BY9cvd7otCA9kpZANPlpdz5WY/OqrhC60/FFhXgdDsBw0jSFek/
         g/BMqSiQb9PqI3zXnheikF9TkIaozqLOpC02nXJwIDIfD+Vs1yrhxlEmhx4JRdy6rn
         F86PHXmbwZECw==
Date:   Wed, 16 Nov 2022 01:56:39 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 3/3] certs: don't try to update blacklist keys
Message-ID: <Y3QnNwWrOjpNwZ6r@kernel.org>
References: <20221109025019.1855-1-linux@weissschuh.net>
 <20221109025019.1855-4-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221109025019.1855-4-linux@weissschuh.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Nov 09, 2022 at 03:50:19AM +0100, Thomas Weiﬂschuh wrote:
> When the same key is blacklisted repeatedly we don't want to log an

Who is "we"?

> error. These duplicates can be provided by buggy firmware. Instead of
> spamming the bootlog with errors we use a warning that can still be seen
> by OEMs when testing.
> 
> Also extend BLACKLIST_KEY_PERM as otherwise the EACCES will shadow the
> EEXIST.

How? I.e. please state how you extend it, and why new need the extra bits.

> Link: https://lore.kernel.org/all/c8c65713-5cda-43ad-8018-20f2e32e4432@t-8ch.de/
> Link: https://lore.kernel.org/all/20221104014704.3469-1-linux@weissschuh.net/
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  certs/blacklist.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index 6e260c4b6a19..ac8e3166b6d7 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c
> @@ -26,7 +26,7 @@
>   */
>  #define MAX_HASH_LEN	128
>  
> -#define BLACKLIST_KEY_PERM (KEY_POS_SEARCH | KEY_POS_VIEW | \
> +#define BLACKLIST_KEY_PERM (KEY_POS_WRITE | KEY_POS_SEARCH | KEY_POS_VIEW | \
>  			    KEY_USR_SEARCH | KEY_USR_VIEW)
>  
>  static const char tbs_prefix[] = "tbs";
> @@ -183,16 +183,19 @@ static int mark_raw_hash_blacklisted(const char *hash)
>  {
>  	key_ref_t key;
>  
> -	key = key_create_or_update(make_key_ref(blacklist_keyring, true),
> -				   "blacklist",
> -				   hash,
> -				   NULL,
> -				   0,
> -				   BLACKLIST_KEY_PERM,
> -				   KEY_ALLOC_NOT_IN_QUOTA |
> -				   KEY_ALLOC_BUILT_IN);
> +	key = key_create(make_key_ref(blacklist_keyring, true),
> +			 "blacklist",
> +			 hash,
> +			 NULL,
> +			 0,
> +			 BLACKLIST_KEY_PERM,
> +			 KEY_ALLOC_NOT_IN_QUOTA |
> +			 KEY_ALLOC_BUILT_IN);
>  	if (IS_ERR(key)) {
> -		pr_err("Problem blacklisting hash %s: %pe\n", hash, key);
> +		if (PTR_ERR(key) == -EEXIST)
> +			pr_warn("Duplicate blacklisted hash %s\n", hash);
> +		else
> +			pr_err("Problem blacklisting hash %s: %pe\n", hash, key);
>  		return PTR_ERR(key);
>  	}
>  	return 0;
> -- 
> 2.38.1
> 

BR, Jarkko
