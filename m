Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E25C2FC9A7
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Jan 2021 04:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730726AbhATD5A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 19 Jan 2021 22:57:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:45330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730618AbhATD4l (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Jan 2021 22:56:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D171C23119;
        Wed, 20 Jan 2021 03:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611114959;
        bh=3AvgxTJdp+RU3BzY1wWjRvowXxpOC3V1C2LWh/GqTfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fA0XvHh+B0gb+qlrucTaI6CrS7ZT736WBQwMMzofoxz5pctCvhaQe7uRYU7a+wO7i
         wxZNE1HrRL7w0crWXOUd499BHHSfH3hmS95wJ0Ild3EwY3aYd/KgUttbXjzWmRzjMY
         J9sQDWXRFI76a0s66oLpcRaHEo0fM4HD1AdZBPdHAGN8AWJAcvJRWVEdmK5kUKpE9j
         iKrme+VuTJcLPVa71popsRrqDQkTdvNXt/q6pBEBifziJ1WzdBp7l3Eez7tSHceOPN
         O4Epkeb3Fa2g5IoJ/6f3kIzzZKHycXS/4GJKnGRf+KnnT32EhHE/W2AsZhwo6Me9Al
         iDNfq+exXeiYg==
Date:   Wed, 20 Jan 2021 05:55:53 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 04/10] certs: Fix blacklist flag type confusion
Message-ID: <YAepvxOBcEU0paqA@kernel.org>
References: <20210114151909.2344974-1-mic@digikod.net>
 <20210114151909.2344974-5-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210114151909.2344974-5-mic@digikod.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 14, 2021 at 04:19:03PM +0100, Mickaël Salaün wrote:
> From: David Howells <dhowells@redhat.com>
> 
> KEY_FLAG_KEEP is not meant to be passed to keyring_alloc() or key_alloc(),
> as these only take KEY_ALLOC_* flags.  KEY_FLAG_KEEP has the same value as
> KEY_ALLOC_BYPASS_RESTRICTION, but fortunately only key_create_or_update()
> uses it.  LSMs using the key_alloc hook don't check that flag.
> 
> KEY_FLAG_KEEP is then ignored but fortunately (again) the root user cannot
> write to the blacklist keyring, so it is not possible to remove a key/hash
> from it.
> 
> Fix this by adding a KEY_ALLOC_SET_KEEP flag that tells key_alloc() to set
> KEY_FLAG_KEEP on the new key.  blacklist_init() can then, correctly, pass
> this to keyring_alloc().

OK, so thing work by luck now, but given the new patches which allow
to append new keys they would break, right?

> We can also use this in ima_mok_init() rather than setting the flag
> manually.

What does ima_mok_init() do?
> Note that this doesn't fix an observable bug with the current
> implementation but it is required to allow addition of new hashes to the
> blacklist in the future without making it possible for them to be removed.
> 
> Fixes: 734114f8782f ("KEYS: Add a system blacklist keyring")
> cc: Mimi Zohar <zohar@linux.vnet.ibm.com>

Nit: Cc

> Cc: David Woodhouse <dwmw2@infradead.org>
> Reported-by: Mickaël Salaün <mic@linux.microsoft.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> [mic@linux.microsoft.com: fix ima_mok_init()]
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> ---
> 
> Changes since v2:
> * Cherry-pick rewritten v1 patch from
>   https://lore.kernel.org/lkml/2659836.1607940186@warthog.procyon.org.uk/
>   to rebase on v5.11-rc3 and fix ima_mok_init().
> ---
>  certs/blacklist.c                | 2 +-
>  include/linux/key.h              | 1 +
>  security/integrity/ima/ima_mok.c | 4 +---
>  security/keys/key.c              | 2 ++
>  4 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index a888b934a1cd..029471947838 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c
> @@ -162,7 +162,7 @@ static int __init blacklist_init(void)
>  			      KEY_USR_VIEW | KEY_USR_READ |
>  			      KEY_USR_SEARCH,
>  			      KEY_ALLOC_NOT_IN_QUOTA |
> -			      KEY_FLAG_KEEP,
> +			      KEY_ALLOC_SET_KEEP,
>  			      NULL, NULL);
>  	if (IS_ERR(blacklist_keyring))
>  		panic("Can't allocate system blacklist keyring\n");
> diff --git a/include/linux/key.h b/include/linux/key.h
> index 0f2e24f13c2b..eed3ce139a32 100644
> --- a/include/linux/key.h
> +++ b/include/linux/key.h
> @@ -289,6 +289,7 @@ extern struct key *key_alloc(struct key_type *type,
>  #define KEY_ALLOC_BUILT_IN		0x0004	/* Key is built into kernel */
>  #define KEY_ALLOC_BYPASS_RESTRICTION	0x0008	/* Override the check on restricted keyrings */
>  #define KEY_ALLOC_UID_KEYRING		0x0010	/* allocating a user or user session keyring */
> +#define KEY_ALLOC_SET_KEEP		0x0020	/* Set the KEEP flag on the key/keyring */
>  
>  extern void key_revoke(struct key *key);
>  extern void key_invalidate(struct key *key);
> diff --git a/security/integrity/ima/ima_mok.c b/security/integrity/ima/ima_mok.c
> index 36cadadbfba4..5594dd38ab04 100644
> --- a/security/integrity/ima/ima_mok.c
> +++ b/security/integrity/ima/ima_mok.c
> @@ -38,13 +38,11 @@ __init int ima_mok_init(void)
>  				(KEY_POS_ALL & ~KEY_POS_SETATTR) |
>  				KEY_USR_VIEW | KEY_USR_READ |
>  				KEY_USR_WRITE | KEY_USR_SEARCH,
> -				KEY_ALLOC_NOT_IN_QUOTA,
> +				KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_SET_KEEP,
>  				restriction, NULL);
>  
>  	if (IS_ERR(ima_blacklist_keyring))
>  		panic("Can't allocate IMA blacklist keyring.");
> -
> -	set_bit(KEY_FLAG_KEEP, &ima_blacklist_keyring->flags);
>  	return 0;
>  }
>  device_initcall(ima_mok_init);
> diff --git a/security/keys/key.c b/security/keys/key.c
> index ebe752b137aa..c45afdd1dfbb 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -303,6 +303,8 @@ struct key *key_alloc(struct key_type *type, const char *desc,
>  		key->flags |= 1 << KEY_FLAG_BUILTIN;
>  	if (flags & KEY_ALLOC_UID_KEYRING)
>  		key->flags |= 1 << KEY_FLAG_UID_KEYRING;
> +	if (flags & KEY_ALLOC_SET_KEEP)
> +		key->flags |= 1 << KEY_FLAG_KEEP;
>  
>  #ifdef KEY_DEBUGGING
>  	key->magic = KEY_DEBUG_MAGIC;
> -- 
> 2.30.0
> 

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
