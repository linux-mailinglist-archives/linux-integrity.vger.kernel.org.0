Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C3A61F980
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Nov 2022 17:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbiKGQXl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Nov 2022 11:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiKGQXL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Nov 2022 11:23:11 -0500
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0437E240B6
        for <linux-integrity@vger.kernel.org>; Mon,  7 Nov 2022 08:20:59 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4N5c0n3vwFzMq4Rq;
        Mon,  7 Nov 2022 17:20:57 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4N5c0k0hNRzMppDn;
        Mon,  7 Nov 2022 17:20:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1667838057;
        bh=/Hxzji7LOlrPI3D4EEkzO0ARX8DsTpF3mgj/GUpF6Pk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gFUGW4Fw6Ro4F87y5z93lAFXMNDQZkpgvZFUYBth1xVO6RFSg0Y/jNrArCaLGqe35
         TSBOCoY9PGKmpc3SkoK5uTdTeNIgngOdglJXnnNg5tnBX8WbJBdiO5Hlt012/cN+7y
         1VhNMm1AnRtPLiI+eoj2usye0DamHZ44AldN0MM8=
Message-ID: <8692915f-437c-56fd-8984-d6febf533fa9@digikod.net>
Date:   Mon, 7 Nov 2022 17:20:53 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH] certs: Prevent spurious errors on repeated blacklisting
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20221104014704.3469-1-linux@weissschuh.net>
 <3b997266-067c-975c-911a-da146fe9033a@digikod.net>
 <db5890d8-3a3d-4ca7-bb58-655c26164587@t-8ch.de>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <db5890d8-3a3d-4ca7-bb58-655c26164587@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 07/11/2022 16:55, Thomas Weißschuh wrote:
> On 2022-11-07 14:12+0100, Mickaël Salaün wrote:
>> This is a follow-up of
>> https://lore.kernel.org/r/c8c65713-5cda-43ad-8018-20f2e32e4432@t-8ch.de
>>
>> Added Jarkko, Mark Pearson, Eric Snowberg and more ML in Cc.
>>
>>
>> On 04/11/2022 02:47, Thomas Weißschuh wrote:
>>> When the blacklist keyring was changed to allow updates from the root
>>> user it gained an ->update() function that disallows all updates.
>>> When the a hash is blacklisted multiple times from the builtin or
>>> firmware-provided blacklist this spams prominent logs during boot:
>>>
>>> [    0.890814] blacklist: Problem blacklisting hash (-13)
>>>
>>> As all these repeated calls to mark_raw_hash_blacklisted() would create
>>> the same keyring entry again anyways these errors can be safely ignored.
>>
>> These errors can indeed be safely ignored, however they highlight issues
>> with some firmware vendors not checking nor optimizing their blocked hashes.
>> This raises security concerns, and it should be fixed by firmware vendors.
> 
> Thanks, I was not aware that these are worth fixing.
> 
>>> Fixes: 6364d106e041 ("certs: Allow root user to append signed hashes to the blacklist keyring")
>>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>>> ---
>>>    certs/blacklist.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/certs/blacklist.c b/certs/blacklist.c
>>> index 41f10601cc72..5f7f2882ced7 100644
>>> --- a/certs/blacklist.c
>>> +++ b/certs/blacklist.c
>>> @@ -191,7 +191,9 @@ static int mark_raw_hash_blacklisted(const char *hash)
>>>    				   BLACKLIST_KEY_PERM,
>>>    				   KEY_ALLOC_NOT_IN_QUOTA |
>>>    				   KEY_ALLOC_BUILT_IN);
>>> -	if (IS_ERR(key)) {
>>> +
>>> +	/* Blacklisting the same hash twice fails but would be idempotent */
>>> +	if (IS_ERR(key) && PTR_ERR(key) != -EACCES) {
>>
>> We should not hide EACCES errors. This logs issues, which is correct for
>> duplicate hashes, and can help firmware vendors to fix their database. I'd
>> really like to see a different log message instead: change the duplicate
>> entry error code from EACCES to EEXIST, and call pr_warn for this specific
>> case.
> 
> Returning EACCES would require some deeper changes to how the keyring is set up

I guess you meant EEXIST?

> or even changes to the keyring core itself to introduce a key_create() (without
> update) function.
> 
> Is this something you would take a look at, or should I try to do it?
> (I have no previous knowledge about the keyring subsystem)

Please take a look. I think it should not be too complex.

> 
> In any case it probably would also be good to log the problematic hashes
> themselves, so users can properly report the issue to their firmware vendors.

Agree

> 
>>>    		pr_err("Problem blacklisting hash (%ld)\n", PTR_ERR(key));
>>>    		return PTR_ERR(key);
>>>    	}
>>>
>>> base-commit: ee6050c8af96bba2f81e8b0793a1fc2f998fcd20
