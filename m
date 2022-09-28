Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B37E5EDD71
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Sep 2022 15:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbiI1ND7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Sep 2022 09:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbiI1NDx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Sep 2022 09:03:53 -0400
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DBFA0278;
        Wed, 28 Sep 2022 06:03:51 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id D1393921; Wed, 28 Sep 2022 15:03:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id CE12B8E3;
        Wed, 28 Sep 2022 15:03:46 +0200 (CEST)
Date:   Wed, 28 Sep 2022 15:03:46 +0200 (CEST)
From:   Nikolaus Voss <nv@vosn.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>
cc:     Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Yael Tzur <yaelt@google.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: encrypted: fix key instantiation with user-provided
 data
In-Reply-To: <YytPFLsOHHmHEB5I@kernel.org>
Message-ID: <c76ab6ed-f276-428d-2471-6d38bf5b51ab@vosn.de>
References: <20220919072317.E41421357@mail.steuer-voss.de> <YylKR1UQZGhN0+UW@kernel.org> <372b91d-5ee6-ae24-2279-0dc7621489c@vosn.de> <YytPFLsOHHmHEB5I@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 21 Sep 2022, Jarkko Sakkinen wrote:
> On Tue, Sep 20, 2022 at 09:58:56AM +0200, Nikolaus Voss wrote:
>> On Tue, 20 Sep 2022, Jarkko Sakkinen wrote:
>>> On Fri, Sep 16, 2022 at 07:45:29AM +0200, Nikolaus Voss wrote:
>>>> Commit cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided
>>>> decrypted data") added key instantiation with user provided decrypted data.
>>>> The user data is hex-ascii-encoded but was just memcpy'ed to the binary buffer.
>>>> Fix this to use hex2bin instead.
>>>>
>>>> Fixes: cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided decrypted data")
>>>> Cc: stable <stable@kernel.org>
>>>> Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>
>>>> ---
>>>>  security/keys/encrypted-keys/encrypted.c | 6 +++---
>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
>>>> index e05cfc2e49ae..1e313982af02 100644
>>>> --- a/security/keys/encrypted-keys/encrypted.c
>>>> +++ b/security/keys/encrypted-keys/encrypted.c
>>>> @@ -627,7 +627,7 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>>>>  			pr_err("encrypted key: instantiation of keys using provided decrypted data is disabled since CONFIG_USER_DECRYPTED_DATA is set to false\n");
>>>>  			return ERR_PTR(-EINVAL);
>>>>  		}
>>>> -		if (strlen(decrypted_data) != decrypted_datalen) {
>>>> +		if (strlen(decrypted_data) != decrypted_datalen * 2) {
>>>
>>> This looks wrong. What does cap decrypted_data, and why strnlen()
>>> is not used?
>>
>> This is a plausibility check to ensure the user-specified key length
>> (decrypted_datalen) matches the length of the user specified key. strnlen()
>> would not add any extra security here, the data has already been copied.
>
> I'd prefer unconditional use of strnlen() because it always
> gives you at least some guarantees over deducing why strlen()
> is fine in a particular code block.

I agree. Unfortunately, there is no blob size available in 
encrypted_key_alloc(), so this would mean changing function signatures 
and code to get this downstream.

This would be well worth a patch on its own.

>
>
>>>
>>>>  			pr_err("encrypted key: decrypted data provided does not match decrypted data length provided\n");
>>>
>>> Using pr_err() is probably wrong here and has different prefix
>>> than elsewhere in the file (also most of other uses of pr_err()
>>> are wrong apparently). Nothing bad is really happening.
>>
>> It actually _is_ an error preventing key instatiation. User space keyctl
>> cannot be verbose about the reason why instantiation failed so it makes
>> sense to be verbose in kernel space. To me, this seems consistent with other
>> occurrences of pr_err() in this file, maybe I misunderstood you?
>
> Then it should be pr_info(), or even pr_debug(), given that it is not a
> kernel issue.
>
>> Btw, this patch changes neither string length checking nor log levels.
>
> I understand this. It has been my own mistake to ack that pr_err().
>
> However, does not fully apply to strlen() part. Since you are
> changing that line anyway, it'd be better to replace strlen()
> with strnlen(). This e.g. protects the code block changes in
> the context where it is called.

I'd love to do it if it was simple.

Niko

