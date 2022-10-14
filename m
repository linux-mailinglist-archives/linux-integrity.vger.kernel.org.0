Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7A35FE901
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Oct 2022 08:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJNGk2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Oct 2022 02:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiJNGk1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Oct 2022 02:40:27 -0400
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600F03CBC2;
        Thu, 13 Oct 2022 23:40:16 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id B6E851321; Fri, 14 Oct 2022 08:40:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id B46441316;
        Fri, 14 Oct 2022 08:40:10 +0200 (CEST)
Date:   Fri, 14 Oct 2022 08:40:10 +0200 (CEST)
From:   Nikolaus Voss <nv@vosn.de>
To:     Mimi Zohar <zohar@linux.ibm.com>
cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Yael Tzur <yaelt@google.com>,
        Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] KEYS: encrypted: fix key instantiation with user-provided
 data
In-Reply-To: <924a29d81cc7e0d3e2f62f693a0d8fcef97b9779.camel@linux.ibm.com>
Message-ID: <c620d6ed-d97f-b0c3-574-7b3cd63a7799@vosn.de>
References: <20221013064308.857011E25@mail.steuer-voss.de> <924a29d81cc7e0d3e2f62f693a0d8fcef97b9779.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-448557197-1665729610=:29571"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-448557197-1665729610=:29571
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 13 Oct 2022, Mimi Zohar wrote:
> On Thu, 2022-10-13 at 08:39 +0200, Nikolaus Voss wrote:
>> Commit cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided
>> decrypted data") added key instantiation with user provided decrypted data.
>> The user data is hex-ascii-encoded but was just memcpy'ed to the binary buffer.
>> Fix this to use hex2bin instead.
>>
>> Old keys created from user provided decrypted data saved with "keyctl pipe"
>> are still valid, however if the key is recreated from decrypted data the
>> old key must be converted to the correct format. This can be done with a
>> small shell script, e.g.:
>>
>> BROKENKEY=abcdefABCDEF1234567890aaaaaaaaaa
>> NEWKEY=$(echo -ne $BROKENKEY | xxd -p -c32)
>> keyctl add user masterkey "$(cat masterkey.bin)" @u
>> keyctl add encrypted testkey "new user:masterkey 32 $NEWKEY" @u
>>
>> It is encouraged to switch to a new key because the effective key size
>> of the old keys is only half of the specified size.
>
> Both the old and new decrypted data size is 32 bytes.  Is the above
> statement necessary, especially since the Documentation example does
> the equivalent?

The old key has the same byte size but all bytes must be within the 
hex-ascíi range of characters, otherwise it is refused by the kernel.
So if you wanted a 32 bytes key you get 16 effective bytes for the key. 
In the above example the string size of the $BROKENKEY is 32, while 
the string size of the $NEWKEY is 64.

If you do

$ echo $NEWKEY
6162636465664142434445463132333435363738393061616161616161616161

for the example, the range problem is obvious, so $NEWKEY is still broken. 
That's why it should only be used to recover data which should be 
reencypted with a new key. If you count exactly, the effective key size is 
_slightly_ longer than half of the specified size, but it is still a 
severe security problem.

>
>> The corresponding test for the Linux Test Project ltp has also been
>> fixed (see link below).
>
> The LTP patch still needs to be revised, but the "Link" is a reference
> to the discussion.  Is the above statement necessary?

As long as the patch is not accepted the discussion is helpful. But feel 
free to delete it upon integration ;-).

>
>>
>> Fixes: cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided decrypted data")
>> Cc: stable <stable@kernel.org>
>> Link: https://lore.kernel.org/ltp/20221006081709.92303897@mail.steuer-voss.de/
>> Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>
>
> Otherwise,
>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks Mimi!
--8323329-448557197-1665729610=:29571--
