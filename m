Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F775EDC4E
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Sep 2022 14:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbiI1MIs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Sep 2022 08:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiI1MIs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Sep 2022 08:08:48 -0400
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC0B65551;
        Wed, 28 Sep 2022 05:08:44 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 37908933; Wed, 28 Sep 2022 14:08:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 3449D597;
        Wed, 28 Sep 2022 14:08:38 +0200 (CEST)
Date:   Wed, 28 Sep 2022 14:08:38 +0200 (CEST)
From:   Nikolaus Voss <nv@vosn.de>
To:     Mimi Zohar <zohar@linux.ibm.com>
cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yael Tzur <yaelt@google.com>
Subject: Re: [PATCH] KEYS: encrypted: fix key instantiation with user-provided
 data
In-Reply-To: <6b4229386dced275f745619f190f64a71b7c0aec.camel@linux.ibm.com>
Message-ID: <2fe0144d-ee19-ec17-9566-16bce6386925@vosn.de>
References: <20220919072317.E41421357@mail.steuer-voss.de>   <53730789a41358673b1715dd650706e9ffcb1199.camel@linux.ibm.com>   <35fd816-d755-967-5712-b5496875ac7a@vosn.de>  <2ee1e3e68d847001c4bf856d980a553e52de5023.camel@linux.ibm.com> 
 <439012d8-dd4-7fd2-3788-49cf72faa99@vosn.de> <6b4229386dced275f745619f190f64a71b7c0aec.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 21 Sep 2022, Mimi Zohar wrote:
> On Wed, 2022-09-21 at 09:24 +0200, Nikolaus Voss wrote:
>> On Tue, 20 Sep 2022, Mimi Zohar wrote:
>>> On Tue, 2022-09-20 at 18:23 +0200, Nikolaus Voss wrote:
>>>> On Tue, 20 Sep 2022, Mimi Zohar wrote:
>>>>> On Fri, 2022-09-16 at 07:45 +0200, Nikolaus Voss wrote:
>>>>>> Commit cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided
>>>>>> decrypted data") added key instantiation with user provided decrypted data.
>>>>>> The user data is hex-ascii-encoded but was just memcpy'ed to the binary buffer.
>>>>>> Fix this to use hex2bin instead.
>>>>>
>>>>> Thanks, Nikolaus.  We iterated a number of times over what would be the
>>>>> safest userspace input.  One of the last changes was that the key data
>>>>> should be hex-ascii-encoded.  Unfortunately, the LTP
>>>>> testcases/kernel/syscalls/keyctl09.c example isn't hex-ascii-encoded
>>>>> and the example in Documentation/security/keys/trusted-encrypted.rst
>>>>> just cat's a file.  Both expect the length to be the length of the
>>>>> userspace provided data.   With this patch, when hex2bin() fails, there
>>>>> is no explanation.
>>>>
>>>> That's true. But it's true for all occurrences of hex2bin() in this file.
>>>> I could pr_err() an explanation, improve the trusted-encrypted.rst example
>>>> and respin the patch. Should I, or do you have another suggestion?
>>>
>>>> I wasn't aware of keyctl09.c, but quickly looking into it, the user data
>>>> _is_ hex-ascii-encoded, only the length is "wrong": Imho, the specified
>>>> length should be the binary length as this is consistent with key-length
>>>> specs in other cases (e.g. when loading the key from a blob).
>>>> keyctl09.c could be easy to fix, if only the length is modified. Should
>>>> I propose a patch? What is the correct/appropriate workflow there?
>>>
>>> I'm concerned that this change breaks existing encrypted keys created
>>> with user-provided data.  Otherwise I'm fine with your suggestion.
>>
>> Ok, but this change does not touch the hex-ascii format of encrypted key
>> blobs?
>
> True, but any persistent data based on this key would be affected.

Persistent data is stored encypted with e.g. the master key in hex-ascii 
already and should not be affected. Only persistent data stored 
unencrypted is affected, but the encrypted-keys stuff is just about 
avoiding that. Or do I still misunderstand something?

>
>>
>>>
>>> The LTP example decrypted data length is 32, but the minimum decrypted
>>> data size is  20.  So it's a bit more than just changing the LTP
>>> decrypted data size.   The modified LTP test should work on kernels
>>> with and without this patch.
>>
>> So this would mean OR-ing old and new variant for the test?
>>
>> The current implementation of the test will fail anyway as the key size is
>> below the minimum of 20 and thus should have failed before.
>
> The existing keyctl09 test is a plain text string.  Converting it to
> hex-ascii (e.g. hexdump, xdd) solves the length issue.  For those
> already using encrypted keys with user provided data, this might also
> resolve the persistent data usage case mentioned above.

The unencrypted data from testcases/kernel/syscalls/keyctl/keyctl09.c 
looks like hex-ascii to me:
#define ENCRYPTED_KEY_VALID_PAYLOAD    "new enc32 user:masterkey 32 abcdefABCDEF1234567890aaaaaaaaaa"

And beeing it hex-ascii is checked in encrypted.c driver:
 		for (i = 0; i < strlen(decrypted_data); i++) {
 			if (!isxdigit(decrypted_data[i])) {
 				pr_err("encrypted key: decrypted data provided must contain only hexadecimal characters\n");
 				return ERR_PTR(-EINVAL);
 			}
 		}

It was never possible to provide unencrypted data other than hex-ascii, it 
just wasn't decoded to binary, so the resulting key was simply wrong and 
rendered CONFIG_USER_DECRYPTED_DATA useless. Because the resulting binary 
key was limited to the hex-ascii range of values.

> Perhaps keep the existing test.  On success issue a warning. 
> On failure, retry with the converted plain text string.

With that being said, I would expect the existing test fail and the 
corrected test to pass.

Niko

