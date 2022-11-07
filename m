Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C2D61FECC
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Nov 2022 20:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiKGTkU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Nov 2022 14:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbiKGTkR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Nov 2022 14:40:17 -0500
X-Greylist: delayed 23277 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Nov 2022 11:40:16 PST
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FC81002;
        Mon,  7 Nov 2022 11:40:16 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4N5hQg66hwzMpnwh;
        Mon,  7 Nov 2022 20:40:11 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4N5hQf1g6kzMppr8;
        Mon,  7 Nov 2022 20:40:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1667850011;
        bh=VH93TVKDv81HuBQ2xHBKdoTVjfRzV8BT2O9T7VUP1yU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=1FSixZE59TqN7/U2wk6U358AgKcPAc215cfWjYqdZd8499FHiwXvxC4hhrjTocp+S
         GrM+Uau+gfxhk+Ko1o7Y75FwYY4xhbblREVkyllHPImuHcXA27SxxrF2mAXsPwUxEz
         bmpRUBLo4dihIijNPrr10GQ6EDBCfJ0/57vGOnqE=
Message-ID: <e2909fe5-7fc4-c73a-b33a-e65fed1d837f@digikod.net>
Date:   Mon, 7 Nov 2022 20:40:09 +0100
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
 <8692915f-437c-56fd-8984-d6febf533fa9@digikod.net>
 <706c75af-9569-42fd-ba68-533ed931d55d@t-8ch.de>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <706c75af-9569-42fd-ba68-533ed931d55d@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 07/11/2022 17:35, Thomas Weißschuh wrote:
> On 2022-11-07 17:20+0100, Mickaël Salaün wrote:
>> On 07/11/2022 16:55, Thomas Weißschuh wrote:
>>> On 2022-11-07 14:12+0100, Mickaël Salaün wrote:
>>>> This is a follow-up of
>>>> https://lore.kernel.org/r/c8c65713-5cda-43ad-8018-20f2e32e4432@t-8ch.de
>>>>
>>>> Added Jarkko, Mark Pearson, Eric Snowberg and more ML in Cc.
>>>>
>>>>
>>>> On 04/11/2022 02:47, Thomas Weißschuh wrote:
>>>>> When the blacklist keyring was changed to allow updates from the root
>>>>> user it gained an ->update() function that disallows all updates.
>>>>> When the a hash is blacklisted multiple times from the builtin or
>>>>> firmware-provided blacklist this spams prominent logs during boot:
>>>>>
>>>>> [    0.890814] blacklist: Problem blacklisting hash (-13)
>>>>>
>>>>> As all these repeated calls to mark_raw_hash_blacklisted() would create
>>>>> the same keyring entry again anyways these errors can be safely ignored.
>>>>
>>>> These errors can indeed be safely ignored, however they highlight issues
>>>> with some firmware vendors not checking nor optimizing their blocked hashes.
>>>> This raises security concerns, and it should be fixed by firmware vendors.
>>>
>>> Thanks, I was not aware that these are worth fixing.
>>>
>>>>> Fixes: 6364d106e041 ("certs: Allow root user to append signed hashes to the blacklist keyring")
>>>>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>>>>> ---
>>>>>     certs/blacklist.c | 4 +++-
>>>>>     1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/certs/blacklist.c b/certs/blacklist.c
>>>>> index 41f10601cc72..5f7f2882ced7 100644
>>>>> --- a/certs/blacklist.c
>>>>> +++ b/certs/blacklist.c
>>>>> @@ -191,7 +191,9 @@ static int mark_raw_hash_blacklisted(const char *hash)
>>>>>     				   BLACKLIST_KEY_PERM,
>>>>>     				   KEY_ALLOC_NOT_IN_QUOTA |
>>>>>     				   KEY_ALLOC_BUILT_IN);
>>>>> -	if (IS_ERR(key)) {
>>>>> +
>>>>> +	/* Blacklisting the same hash twice fails but would be idempotent */
>>>>> +	if (IS_ERR(key) && PTR_ERR(key) != -EACCES) {
>>>>
>>>> We should not hide EACCES errors. This logs issues, which is correct for
>>>> duplicate hashes, and can help firmware vendors to fix their database. I'd
>>>> really like to see a different log message instead: change the duplicate
>>>> entry error code from EACCES to EEXIST, and call pr_warn for this specific
>>>> case.
>>>
>>> Returning EACCES would require some deeper changes to how the keyring is set up
>>
>> I guess you meant EEXIST?
> 
> Indeed, sorry.
> 
>>> or even changes to the keyring core itself to introduce a key_create() (without
>>> update) function.
>>>
>>> Is this something you would take a look at, or should I try to do it?
>>> (I have no previous knowledge about the keyring subsystem)
>>
>> Please take a look. I think it should not be too complex.
> 
> Will do.
> 
> My plan is to create a new function key_create() that does takes the core logic
> of key_create_or_update() and fails with EEXIST if needed.
> 
>>> In any case it probably would also be good to log the problematic hashes
>>> themselves, so users can properly report the issue to their firmware vendors.
>>
>> Agree
> 
> I'll send a patch for that, too.

Good!

Jarkko, David, any though?

> 
> As for this patch's Fixes-tag, it could refer to either the commit that
> introduced the logging in the first place or the one that actively started to
> trigger it:
> * 734114f8782f ("KEYS: Add a system blacklist keyring")
> * 6364d106e041 ("certs: Allow root user to append signed hashes to the blacklist keyring")
> 
> Personally I'd tend to use the latter.

Even if commit 6364d106e041 is not directly the cause of the issue, it 
makes it visible, so I agree that you should keep the current Fixes tag.


> 
>>>>>     		pr_err("Problem blacklisting hash (%ld)\n", PTR_ERR(key));
>>>>>     		return PTR_ERR(key);
>>>>>     	}
>>>>>
>>>>> base-commit: ee6050c8af96bba2f81e8b0793a1fc2f998fcd20
