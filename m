Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3B72FD089
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Jan 2021 13:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389246AbhATMk1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Jan 2021 07:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389160AbhATLQq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jan 2021 06:16:46 -0500
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF584C061575
        for <linux-integrity@vger.kernel.org>; Wed, 20 Jan 2021 03:16:00 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DLNGm2v28zMqQD9;
        Wed, 20 Jan 2021 12:15:12 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4DLNGl3psPzlh8TX;
        Wed, 20 Jan 2021 12:15:11 +0100 (CET)
Subject: Re: [PATCH v3 04/10] certs: Fix blacklist flag type confusion
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
References: <20210114151909.2344974-1-mic@digikod.net>
 <20210114151909.2344974-5-mic@digikod.net> <YAepvxOBcEU0paqA@kernel.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <fc4d5812-238c-baf7-d7f6-cc123bdb855d@digikod.net>
Date:   Wed, 20 Jan 2021 12:15:10 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <YAepvxOBcEU0paqA@kernel.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 20/01/2021 04:55, Jarkko Sakkinen wrote:
> On Thu, Jan 14, 2021 at 04:19:03PM +0100, Mickaël Salaün wrote:
>> From: David Howells <dhowells@redhat.com>
>>
>> KEY_FLAG_KEEP is not meant to be passed to keyring_alloc() or key_alloc(),
>> as these only take KEY_ALLOC_* flags.  KEY_FLAG_KEEP has the same value as
>> KEY_ALLOC_BYPASS_RESTRICTION, but fortunately only key_create_or_update()
>> uses it.  LSMs using the key_alloc hook don't check that flag.
>>
>> KEY_FLAG_KEEP is then ignored but fortunately (again) the root user cannot
>> write to the blacklist keyring, so it is not possible to remove a key/hash
>> from it.
>>
>> Fix this by adding a KEY_ALLOC_SET_KEEP flag that tells key_alloc() to set
>> KEY_FLAG_KEEP on the new key.  blacklist_init() can then, correctly, pass
>> this to keyring_alloc().
> 
> OK, so thing work by luck now, but given the new patches which allow
> to append new keys they would break, right?

Without this fix, patch 9/10 would allow to remove and modify keys from
the blacklist keyring.

> 
>> We can also use this in ima_mok_init() rather than setting the flag
>> manually.
> 
> What does ima_mok_init() do?

This was initially an addition from David Howells, I only fixed the
argument bit-ORing. ima_mok_init() allocates a blacklist keyring (with
different properties) dedicated to IMA.

>> Note that this doesn't fix an observable bug with the current
>> implementation but it is required to allow addition of new hashes to the
>> blacklist in the future without making it possible for them to be removed.
>>
>> Fixes: 734114f8782f ("KEYS: Add a system blacklist keyring")
>> cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> Nit: Cc

OK

> 
>> Cc: David Woodhouse <dwmw2@infradead.org>
>> Reported-by: Mickaël Salaün <mic@linux.microsoft.com>
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> [mic@linux.microsoft.com: fix ima_mok_init()]
>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
>> ---
>>
>> Changes since v2:
>> * Cherry-pick rewritten v1 patch from
>>   https://lore.kernel.org/lkml/2659836.1607940186@warthog.procyon.org.uk/
>>   to rebase on v5.11-rc3 and fix ima_mok_init().
>> ---
>>  certs/blacklist.c                | 2 +-
>>  include/linux/key.h              | 1 +
>>  security/integrity/ima/ima_mok.c | 4 +---
>>  security/keys/key.c              | 2 ++
>>  4 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/certs/blacklist.c b/certs/blacklist.c
>> index a888b934a1cd..029471947838 100644
>> --- a/certs/blacklist.c
>> +++ b/certs/blacklist.c
>> @@ -162,7 +162,7 @@ static int __init blacklist_init(void)
>>  			      KEY_USR_VIEW | KEY_USR_READ |
>>  			      KEY_USR_SEARCH,
>>  			      KEY_ALLOC_NOT_IN_QUOTA |
>> -			      KEY_FLAG_KEEP,
>> +			      KEY_ALLOC_SET_KEEP,
>>  			      NULL, NULL);
>>  	if (IS_ERR(blacklist_keyring))
>>  		panic("Can't allocate system blacklist keyring\n");
>> diff --git a/include/linux/key.h b/include/linux/key.h
>> index 0f2e24f13c2b..eed3ce139a32 100644
>> --- a/include/linux/key.h
>> +++ b/include/linux/key.h
>> @@ -289,6 +289,7 @@ extern struct key *key_alloc(struct key_type *type,
>>  #define KEY_ALLOC_BUILT_IN		0x0004	/* Key is built into kernel */
>>  #define KEY_ALLOC_BYPASS_RESTRICTION	0x0008	/* Override the check on restricted keyrings */
>>  #define KEY_ALLOC_UID_KEYRING		0x0010	/* allocating a user or user session keyring */
>> +#define KEY_ALLOC_SET_KEEP		0x0020	/* Set the KEEP flag on the key/keyring */
>>  
>>  extern void key_revoke(struct key *key);
>>  extern void key_invalidate(struct key *key);
>> diff --git a/security/integrity/ima/ima_mok.c b/security/integrity/ima/ima_mok.c
>> index 36cadadbfba4..5594dd38ab04 100644
>> --- a/security/integrity/ima/ima_mok.c
>> +++ b/security/integrity/ima/ima_mok.c
>> @@ -38,13 +38,11 @@ __init int ima_mok_init(void)
>>  				(KEY_POS_ALL & ~KEY_POS_SETATTR) |
>>  				KEY_USR_VIEW | KEY_USR_READ |
>>  				KEY_USR_WRITE | KEY_USR_SEARCH,
>> -				KEY_ALLOC_NOT_IN_QUOTA,
>> +				KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_SET_KEEP,
>>  				restriction, NULL);
>>  
>>  	if (IS_ERR(ima_blacklist_keyring))
>>  		panic("Can't allocate IMA blacklist keyring.");
>> -
>> -	set_bit(KEY_FLAG_KEEP, &ima_blacklist_keyring->flags);
>>  	return 0;
>>  }
>>  device_initcall(ima_mok_init);
>> diff --git a/security/keys/key.c b/security/keys/key.c
>> index ebe752b137aa..c45afdd1dfbb 100644
>> --- a/security/keys/key.c
>> +++ b/security/keys/key.c
>> @@ -303,6 +303,8 @@ struct key *key_alloc(struct key_type *type, const char *desc,
>>  		key->flags |= 1 << KEY_FLAG_BUILTIN;
>>  	if (flags & KEY_ALLOC_UID_KEYRING)
>>  		key->flags |= 1 << KEY_FLAG_UID_KEYRING;
>> +	if (flags & KEY_ALLOC_SET_KEEP)
>> +		key->flags |= 1 << KEY_FLAG_KEEP;
>>  
>>  #ifdef KEY_DEBUGGING
>>  	key->magic = KEY_DEBUG_MAGIC;
>> -- 
>> 2.30.0
>>
> 
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> /Jarkko
> 
