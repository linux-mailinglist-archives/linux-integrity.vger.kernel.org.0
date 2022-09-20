Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EE45BEB10
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Sep 2022 18:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiITQXn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Sep 2022 12:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiITQXm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Sep 2022 12:23:42 -0400
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7AB186D4;
        Tue, 20 Sep 2022 09:23:38 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id C0293C206; Tue, 20 Sep 2022 18:23:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id BE5DAC140;
        Tue, 20 Sep 2022 18:23:34 +0200 (CEST)
Date:   Tue, 20 Sep 2022 18:23:34 +0200 (CEST)
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
In-Reply-To: <53730789a41358673b1715dd650706e9ffcb1199.camel@linux.ibm.com>
Message-ID: <35fd816-d755-967-5712-b5496875ac7a@vosn.de>
References: <20220919072317.E41421357@mail.steuer-voss.de> <53730789a41358673b1715dd650706e9ffcb1199.camel@linux.ibm.com>
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
> On Fri, 2022-09-16 at 07:45 +0200, Nikolaus Voss wrote:
>> Commit cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided
>> decrypted data") added key instantiation with user provided decrypted data.
>> The user data is hex-ascii-encoded but was just memcpy'ed to the binary buffer.
>> Fix this to use hex2bin instead.
>
> Thanks, Nikolaus.  We iterated a number of times over what would be the
> safest userspace input.  One of the last changes was that the key data
> should be hex-ascii-encoded.  Unfortunately, the LTP
> testcases/kernel/syscalls/keyctl09.c example isn't hex-ascii-encoded
> and the example in Documentation/security/keys/trusted-encrypted.rst
> just cat's a file.  Both expect the length to be the length of the
> userspace provided data.   With this patch, when hex2bin() fails, there
> is no explanation.

That's true. But it's true for all occurrences of hex2bin() in this file.
I could pr_err() an explanation, improve the trusted-encrypted.rst example 
and respin the patch. Should I, or do you have another suggestion?

I wasn't aware of keyctl09.c, but quickly looking into it, the user data 
_is_ hex-ascii-encoded, only the length is "wrong": Imho, the specified 
length should be the binary length as this is consistent with key-length 
specs in other cases (e.g. when loading the key from a blob).
keyctl09.c could be easy to fix, if only the length is modified. Should 
I propose a patch? What is the correct/appropriate workflow there?

Thanks,
Niko
