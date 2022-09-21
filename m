Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7415BF791
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Sep 2022 09:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiIUHY0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Sep 2022 03:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiIUHY0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Sep 2022 03:24:26 -0400
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA5B7CB48;
        Wed, 21 Sep 2022 00:24:22 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 92390E74F; Wed, 21 Sep 2022 09:24:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 8F854E737;
        Wed, 21 Sep 2022 09:24:18 +0200 (CEST)
Date:   Wed, 21 Sep 2022 09:24:18 +0200 (CEST)
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
In-Reply-To: <2ee1e3e68d847001c4bf856d980a553e52de5023.camel@linux.ibm.com>
Message-ID: <439012d8-dd4-7fd2-3788-49cf72faa99@vosn.de>
References: <20220919072317.E41421357@mail.steuer-voss.de>  <53730789a41358673b1715dd650706e9ffcb1199.camel@linux.ibm.com>  <35fd816-d755-967-5712-b5496875ac7a@vosn.de> <2ee1e3e68d847001c4bf856d980a553e52de5023.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 20 Sep 2022, Mimi Zohar wrote:
> On Tue, 2022-09-20 at 18:23 +0200, Nikolaus Voss wrote:
>> On Tue, 20 Sep 2022, Mimi Zohar wrote:
>>> On Fri, 2022-09-16 at 07:45 +0200, Nikolaus Voss wrote:
>>>> Commit cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided
>>>> decrypted data") added key instantiation with user provided decrypted data.
>>>> The user data is hex-ascii-encoded but was just memcpy'ed to the binary buffer.
>>>> Fix this to use hex2bin instead.
>>>
>>> Thanks, Nikolaus.  We iterated a number of times over what would be the
>>> safest userspace input.  One of the last changes was that the key data
>>> should be hex-ascii-encoded.  Unfortunately, the LTP
>>> testcases/kernel/syscalls/keyctl09.c example isn't hex-ascii-encoded
>>> and the example in Documentation/security/keys/trusted-encrypted.rst
>>> just cat's a file.  Both expect the length to be the length of the
>>> userspace provided data.   With this patch, when hex2bin() fails, there
>>> is no explanation.
>>
>> That's true. But it's true for all occurrences of hex2bin() in this file.
>> I could pr_err() an explanation, improve the trusted-encrypted.rst example
>> and respin the patch. Should I, or do you have another suggestion?
>
>> I wasn't aware of keyctl09.c, but quickly looking into it, the user data
>> _is_ hex-ascii-encoded, only the length is "wrong": Imho, the specified
>> length should be the binary length as this is consistent with key-length
>> specs in other cases (e.g. when loading the key from a blob).
>> keyctl09.c could be easy to fix, if only the length is modified. Should
>> I propose a patch? What is the correct/appropriate workflow there?
>
> I'm concerned that this change breaks existing encrypted keys created
> with user-provided data.  Otherwise I'm fine with your suggestion.

Ok, but this change does not touch the hex-ascii format of encrypted key 
blobs?

>
> The LTP example decrypted data length is 32, but the minimum decrypted
> data size is  20.  So it's a bit more than just changing the LTP
> decrypted data size.   The modified LTP test should work on kernels
> with and without this patch.

So this would mean OR-ing old and new variant for the test?

The current implementation of the test will fail anyway as the key size is 
below the minimum of 20 and thus should have failed before.

Niko
