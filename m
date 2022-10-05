Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661785F522A
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Oct 2022 12:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiJEKEe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Oct 2022 06:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJEKEd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Oct 2022 06:04:33 -0400
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193F05726D;
        Wed,  5 Oct 2022 03:04:30 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 80BDB10D3; Wed,  5 Oct 2022 12:04:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 7DFAB10D2;
        Wed,  5 Oct 2022 12:04:22 +0200 (CEST)
Date:   Wed, 5 Oct 2022 12:04:22 +0200 (CEST)
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
In-Reply-To: <42dbb8f6bc0a3e8339a5283bf26a50bd7bec3767.camel@linux.ibm.com>
Message-ID: <aac62bfc-2425-ffeb-1c49-e0963bdbfa99@vosn.de>
References: <20220919072317.E41421357@mail.steuer-voss.de>    <53730789a41358673b1715dd650706e9ffcb1199.camel@linux.ibm.com>    <35fd816-d755-967-5712-b5496875ac7a@vosn.de>   <2ee1e3e68d847001c4bf856d980a553e52de5023.camel@linux.ibm.com>  
 <439012d8-dd4-7fd2-3788-49cf72faa99@vosn.de>  <6b4229386dced275f745619f190f64a71b7c0aec.camel@linux.ibm.com>  <2fe0144d-ee19-ec17-9566-16bce6386925@vosn.de> <42dbb8f6bc0a3e8339a5283bf26a50bd7bec3767.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 28 Sep 2022, Mimi Zohar wrote:
> On Wed, 2022-09-28 at 14:08 +0200, Nikolaus Voss wrote:
>> On Wed, 21 Sep 2022, Mimi Zohar wrote:
>>> On Wed, 2022-09-21 at 09:24 +0200, Nikolaus Voss wrote:
>>>> On Tue, 20 Sep 2022, Mimi Zohar wrote:
>>>>> On Tue, 2022-09-20 at 18:23 +0200, Nikolaus Voss wrote:
>>>>>> On Tue, 20 Sep 2022, Mimi Zohar wrote:
>>>>>>> On Fri, 2022-09-16 at 07:45 +0200, Nikolaus Voss wrote:
>>>>>>>> Commit cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided
>>>>>>>> decrypted data") added key instantiation with user provided decrypted data.
>>>>>>>> The user data is hex-ascii-encoded but was just memcpy'ed to the binary buffer.
>>>>>>>> Fix this to use hex2bin instead.
>>>>>>>
>>>>>>> Thanks, Nikolaus.  We iterated a number of times over what would be the
>>>>>>> safest userspace input.  One of the last changes was that the key data
>>>>>>> should be hex-ascii-encoded.  Unfortunately, the LTP
>>>>>>> testcases/kernel/syscalls/keyctl09.c example isn't hex-ascii-encoded
>>>>>>> and the example in Documentation/security/keys/trusted-encrypted.rst
>>>>>>> just cat's a file.  Both expect the length to be the length of the
>>>>>>> userspace provided data.   With this patch, when hex2bin() fails, there
>>>>>>> is no explanation.
>>>>>>
>>>>>> That's true. But it's true for all occurrences of hex2bin() in this file.
>>>>>> I could pr_err() an explanation, improve the trusted-encrypted.rst example
>>>>>> and respin the patch. Should I, or do you have another suggestion?
>>>>>
>>>>>> I wasn't aware of keyctl09.c, but quickly looking into it, the user data
>>>>>> _is_ hex-ascii-encoded, only the length is "wrong": Imho, the specified
>>>>>> length should be the binary length as this is consistent with key-length
>>>>>> specs in other cases (e.g. when loading the key from a blob).
>>>>>> keyctl09.c could be easy to fix, if only the length is modified. Should
>>>>>> I propose a patch? What is the correct/appropriate workflow there?
>>>>>
>>>>> I'm concerned that this change breaks existing encrypted keys created
>>>>> with user-provided data.  Otherwise I'm fine with your suggestion.
>>>>
>>>> Ok, but this change does not touch the hex-ascii format of encrypted key
>>>> blobs?
>>>
>>> True, but any persistent data based on this key would be affected.
>>
>> Persistent data is stored encypted with e.g. the master key in hex-ascii
>> already and should not be affected. Only persistent data stored
>> unencrypted is affected, but the encrypted-keys stuff is just about
>> avoiding that. Or do I still misunderstand something?
>
> Perhaps an existing encrypted key usage example would help clarify what
> is meant by persistent data.  The two original encrypted key usages are
> the EVM HMAC key and ecryptfs.  The EVM key is an encrypted key used to
> calculate the EVM HMAC, which is stored in security.evm.  In that
> scenario, the persistent data would be the data stored in security.evm.
>
> Would this patch break existing kernel/application persistent data
> based on encrypted keys created with user-provided data?

As far as I can tell, it does not.

Niko
