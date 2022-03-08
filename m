Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCB24D1CA7
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Mar 2022 17:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbiCHQD2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Mar 2022 11:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbiCHQD1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Mar 2022 11:03:27 -0500
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570C2E38
        for <linux-integrity@vger.kernel.org>; Tue,  8 Mar 2022 08:02:28 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KCg824QBGzMqMKV;
        Tue,  8 Mar 2022 17:02:26 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KCg800Qv1zlhSMS;
        Tue,  8 Mar 2022 17:02:23 +0100 (CET)
Message-ID: <218eb9dc-d9bd-0173-5343-f44b58545aef@digikod.net>
Date:   Tue, 8 Mar 2022 17:02:23 +0100
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20210712170313.884724-1-mic@digikod.net>
 <20210712170313.884724-6-mic@digikod.net> <YidDznCPSmFmfNwE@iki.fi>
 <995fc93b-531b-9840-1523-21ae2adbe4ba@digikod.net> <YidX3jqNJeFfr1G1@iki.fi>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v8 5/5] certs: Allow root user to append signed hashes to
 the blacklist keyring
In-Reply-To: <YidX3jqNJeFfr1G1@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 08/03/2022 14:19, Jarkko Sakkinen wrote:
> On Tue, Mar 08, 2022 at 01:18:28PM +0100, Mickaël Salaün wrote:
>>
>> On 08/03/2022 12:53, Jarkko Sakkinen wrote:
>>> On Mon, Jul 12, 2021 at 07:03:13PM +0200, Mickaël Salaün wrote:
>>>> From: Mickaël Salaün <mic@linux.microsoft.com>
>>>>
>>>> Add a kernel option SYSTEM_BLACKLIST_AUTH_UPDATE to enable the root user
>>>> to dynamically add new keys to the blacklist keyring.  This enables to
>>>> invalidate new certificates, either from being loaded in a keyring, or
>>>> from being trusted in a PKCS#7 certificate chain.  This also enables to
>>>> add new file hashes to be denied by the integrity infrastructure.
>>>>
>>>> Being able to untrust a certificate which could have normaly been
>>>> trusted is a sensitive operation.  This is why adding new hashes to the
>>>> blacklist keyring is only allowed when these hashes are signed and
>>>> vouched by the builtin trusted keyring.  A blacklist hash is stored as a
>>>> key description.  The PKCS#7 signature of this description must be
>>>> provided as the key payload.
>>>>
>>>> Marking a certificate as untrusted should be enforced while the system
>>>> is running.  It is then forbiden to remove such blacklist keys.
>>>>
>>>> Update blacklist keyring, blacklist key and revoked certificate access rights:
>>>> * allows the root user to search for a specific blacklisted hash, which
>>>>     make sense because the descriptions are already viewable;
>>>> * forbids key update (blacklist and asymmetric ones);
>>>> * restricts kernel rights on the blacklist keyring to align with the
>>>>     root user rights.
>>>>
>>>> See help in tools/certs/print-cert-tbs-hash.sh .
>>>>
>>>> Cc: David Howells <dhowells@redhat.com>
>>>> Cc: David Woodhouse <dwmw2@infradead.org>
>>>> Cc: Eric Snowberg <eric.snowberg@oracle.com>
>>>> Cc: Jarkko Sakkinen <jarkko@kernel.org>
>>>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
>>>> Link: https://lore.kernel.org/r/20210712170313.884724-6-mic@digikod.net
>>>> ---
>>>>
>>>> Changes since v6:
>>>> * Rebase on keys-cve-2020-26541-v3: commit ebd9c2ae369a ("integrity:
>>>>     Load mokx variables into the blacklist keyring").
>>>>
>>>> Changes since v5:
>>>> * Rebase on keys-next, fix Kconfig conflict, and update the asymmetric
>>>>     key rights added to the blacklist keyring by the new
>>>>     add_key_to_revocation_list(): align with blacklist key rights by
>>>>     removing KEY_POS_WRITE as a safeguard, and add
>>>>     KEY_ALLOC_BYPASS_RESTRICTION to not be subject to
>>>>     restrict_link_for_blacklist() that only allows blacklist key types to
>>>>     be added to the keyring.
>>>> * Change the return code for restrict_link_for_blacklist() from -EPERM
>>>>     to -EOPNOTSUPP to align with asymmetric key keyrings.
>>>>
>>>> Changes since v3:
>>>> * Update commit message for print-cert-tbs-hash.sh .
>>>>
>>>> Changes since v2:
>>>> * Add comment for blacklist_key_instantiate().
>>>> ---
>>>>    certs/Kconfig     | 10 +++++
>>>>    certs/blacklist.c | 96 ++++++++++++++++++++++++++++++++++++-----------
>>>>    2 files changed, 85 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/certs/Kconfig b/certs/Kconfig
>>>> index 0fbe184ceca5..e0e524b7eff9 100644
>>>> --- a/certs/Kconfig
>>>> +++ b/certs/Kconfig
>>>> @@ -103,4 +103,14 @@ config SYSTEM_REVOCATION_KEYS
>>>>    	  containing X.509 certificates to be included in the default blacklist
>>>>    	  keyring.
>>>> +config SYSTEM_BLACKLIST_AUTH_UPDATE
>>>> +	bool "Allow root to add signed blacklist keys"
>>>> +	depends on SYSTEM_BLACKLIST_KEYRING
>>>> +	depends on SYSTEM_DATA_VERIFICATION
>>>> +	help
>>>> +	  If set, provide the ability to load new blacklist keys at run time if
>>>> +	  they are signed and vouched by a certificate from the builtin trusted
>>>> +	  keyring.  The PKCS#7 signature of the description is set in the key
>>>> +	  payload.  Blacklist keys cannot be removed.
>>>> +
>>>>    endmenu
>>>> diff --git a/certs/blacklist.c b/certs/blacklist.c
>>>> index b254c87ceb3a..486ce0dd8e9c 100644
>>>> --- a/certs/blacklist.c
>>>> +++ b/certs/blacklist.c
>>>> @@ -15,6 +15,7 @@
>>>>    #include <linux/err.h>
>>>>    #include <linux/seq_file.h>
>>>>    #include <linux/uidgid.h>
>>>> +#include <linux/verification.h>
>>>>    #include <keys/system_keyring.h>
>>>>    #include "blacklist.h"
>>>>    #include "common.h"
>>>> @@ -26,6 +27,9 @@
>>>>     */
>>>>    #define MAX_HASH_LEN	128
>>>> +#define BLACKLIST_KEY_PERM (KEY_POS_SEARCH | KEY_POS_VIEW | \
>>>> +			    KEY_USR_SEARCH | KEY_USR_VIEW)
>>>> +
>>>>    static const char tbs_prefix[] = "tbs";
>>>>    static const char bin_prefix[] = "bin";
>>>> @@ -80,19 +84,51 @@ static int blacklist_vet_description(const char *desc)
>>>>    	return 0;
>>>>    }
>>>> -/*
>>>> - * The hash to be blacklisted is expected to be in the description.  There will
>>>> - * be no payload.
>>>> - */
>>>> -static int blacklist_preparse(struct key_preparsed_payload *prep)
>>>> +static int blacklist_key_instantiate(struct key *key,
>>>> +		struct key_preparsed_payload *prep)
>>>>    {
>>>> -	if (prep->datalen > 0)
>>>> -		return -EINVAL;
>>>> -	return 0;
>>>> +#ifdef CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE
>>>> +	int err;
>>>> +#endif
>>>> +
>>>> +	/* Sets safe default permissions for keys loaded by user space. */
>>>> +	key->perm = BLACKLIST_KEY_PERM;
>>>> +
>>>> +	/*
>>>> +	 * Skips the authentication step for builtin hashes, they are not
>>>> +	 * signed but still trusted.
>>>> +	 */
>>>> +	if (key->flags & (1 << KEY_FLAG_BUILTIN))
>>>> +		goto out;
>>>> +
>>>> +#ifdef CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE
>>>> +	/*
>>>> +	 * Verifies the description's PKCS#7 signature against the builtin
>>>> +	 * trusted keyring.
>>>> +	 */
>>>> +	err = verify_pkcs7_signature(key->description,
>>>> +			strlen(key->description), prep->data, prep->datalen,
>>>> +			NULL, VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
>>>> +	if (err)
>>>> +		return err;
>>>> +#else
>>>> +	/*
>>>> +	 * It should not be possible to come here because the keyring doesn't
>>>> +	 * have KEY_USR_WRITE and the only other way to call this function is
>>>> +	 * for builtin hashes.
>>>> +	 */
>>>> +	WARN_ON_ONCE(1);
>>>> +	return -EPERM;
>>>> +#endif
>>>> +
>>>> +out:
>>>> +	return generic_key_instantiate(key, prep);
>>>>    }
>>>> -static void blacklist_free_preparse(struct key_preparsed_payload *prep)
>>>> +static int blacklist_key_update(struct key *key,
>>>> +		struct key_preparsed_payload *prep)
>>>>    {
>>>> +	return -EPERM;
>>>>    }
>>>>    static void blacklist_describe(const struct key *key, struct seq_file *m)
>>>> @@ -103,9 +139,8 @@ static void blacklist_describe(const struct key *key, struct seq_file *m)
>>>>    static struct key_type key_type_blacklist = {
>>>>    	.name			= "blacklist",
>>>>    	.vet_description	= blacklist_vet_description,
>>>> -	.preparse		= blacklist_preparse,
>>>> -	.free_preparse		= blacklist_free_preparse,
>>>> -	.instantiate		= generic_key_instantiate,
>>>> +	.instantiate		= blacklist_key_instantiate,
>>>> +	.update			= blacklist_key_update,
>>>>    	.describe		= blacklist_describe,
>>>>    };
>>>> @@ -154,8 +189,7 @@ static int mark_raw_hash_blacklisted(const char *hash)
>>>>    				   hash,
>>>>    				   NULL,
>>>>    				   0,
>>>> -				   ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
>>>> -				    KEY_USR_VIEW),
>>>> +				   BLACKLIST_KEY_PERM,
>>>>    				   KEY_ALLOC_NOT_IN_QUOTA |
>>>>    				   KEY_ALLOC_BUILT_IN);
>>>>    	if (IS_ERR(key)) {
>>>> @@ -232,8 +266,10 @@ int add_key_to_revocation_list(const char *data, size_t size)
>>>>    				   NULL,
>>>>    				   data,
>>>>    				   size,
>>>> -				   ((KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW),
>>>> -				   KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_BUILT_IN);
>>>> +				   KEY_POS_VIEW | KEY_POS_READ | KEY_POS_SEARCH
>>>> +				   | KEY_USR_VIEW,
>>>> +				   KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_BUILT_IN
>>>> +				   | KEY_ALLOC_BYPASS_RESTRICTION);
>>>>    	if (IS_ERR(key)) {
>>>>    		pr_err("Problem with revocation key (%ld)\n", PTR_ERR(key));
>>>> @@ -260,25 +296,43 @@ int is_key_on_revocation_list(struct pkcs7_message *pkcs7)
>>>>    }
>>>>    #endif
>>>> +static int restrict_link_for_blacklist(struct key *dest_keyring,
>>>> +		const struct key_type *type, const union key_payload *payload,
>>>> +		struct key *restrict_key)
>>>> +{
>>>> +	if (type == &key_type_blacklist)
>>>> +		return 0;
>>>> +	return -EOPNOTSUPP;
>>>> +}
>>>> +
>>>>    /*
>>>>     * Initialise the blacklist
>>>>     */
>>>>    static int __init blacklist_init(void)
>>>>    {
>>>>    	const char *const *bl;
>>>> +	struct key_restriction *restriction;
>>>>    	if (register_key_type(&key_type_blacklist) < 0)
>>>>    		panic("Can't allocate system blacklist key type\n");
>>>> +	restriction = kzalloc(sizeof(*restriction), GFP_KERNEL);
>>>> +	if (!restriction)
>>>> +		panic("Can't allocate blacklist keyring restriction\n");
>>>
>>>
>>> This prevents me from taking this to my pull request. In moderns standards,
>>> no new BUG_ON(), panic() etc. should never added to the kernel.
>>>
>>> I missed this in my review.
>>>
>>> This should rather be e.g.
>>>
>>>           restriction = kzalloc(sizeof(*restriction), GFP_KERNEL);
>>> 	if (!restriction) {
>>> 		pr_err("Can't allocate blacklist keyring restriction\n");
>>>                   return 0;
>>>           }
>>>
>>> Unfortunately I need to drop this patch set, because adding new panic()
>>> is simply a no-go.
>>
>> I agree that panic() is not great in general, but I followed the other part
>> of the code (just above) that do the same. This part of the kernel should
>> failed if critical memory allocation failed at boot time (only). It doesn't
>> impact the kernel once it is running. I don't think that just ignoring this
>> error with return 0 is fine, after all it's a critical error right?
> 
> It's not good reason enough to crash the whole kernel, even if it is a
> critical error (e.g. run-time foresincs). Even WARN() is not recommended
> these days [*].

I think that what Greg said in this email is that WARN*() should only be 
used for cases that should never happen, it is definitely not 
deprecated, but WARN_ON_ONCE() may be a better idea though. WARN*() 
helps detect such thought-to-be-impossible cases, that can happen e.g. 
with code refactoring.

A lot of initialization/boot code (e.g. without user space nor external 
interactions, mostly __init functions) do panic if there is unexpected 
and unrecoverable errors like failed memory allocations. I think 
handling such errors otherwise would be more complex for no benefit. 
Moreover, delegating such error handling to user space could create new 
(silent) issues.

> 
> For the existing panic()-statements: I'm happy to review patches that
> render them out. >
> Not sure tho, if this fails should it be then "everything blacklisted".
> Just one thing to consider.

Well, if it fail it will be "nothing will work afterwards". Do you have 
a working and useful scenario for this kind of error?

> 
>> Calling panic() seems OK here. Is there a better way to stop the kernel for
>> such critical error? If the kernel cannot allocate memory at this time, it
>> would be useless to try continuing booting.
> 
> [*] https://lore.kernel.org/linux-sgx/YA0tvOGp%2FshchVhu@kroah.com/
