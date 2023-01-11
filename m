Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F9F665B37
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jan 2023 13:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjAKMTS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Jan 2023 07:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjAKMTR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Jan 2023 07:19:17 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5656EC31
        for <linux-integrity@vger.kernel.org>; Wed, 11 Jan 2023 04:19:15 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id i188so15464460vsi.8
        for <linux-integrity@vger.kernel.org>; Wed, 11 Jan 2023 04:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jqYR8u+ShPDghUhG2SZupI4Z6Dc9HvJIuMNJLfh0Qts=;
        b=Z//Hm2nyg5BHKLCTjYVkhCmogGyVZa9QOHJWZ2IJF7073WPl0jDlT53DycbX5xhriG
         UyolDXK53JsA46RQWoSqcwsNCLNE0YC0OKUUlH/WDDAVazl+VI6G9xCCr2+NoFJdv923
         csz5/E9/lQ8ZmqShMnWDcK9M5C7qRPZ2IW6V/c+BNnkKcVCs6v/jIFgJqcb3HkX8XIZr
         sKni6dW09iQL06dqe4TX9kZXZMoDz9WzHZ4EarbMGX+sUbgYMN3XUgBETBIn8BYF80UK
         35jrtr6/DoIwoUsV9CQPYLH23TL9ORYDNNJKwKLfQdPYUYC2zE89s7M9LHSnHeX1cXUb
         XoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqYR8u+ShPDghUhG2SZupI4Z6Dc9HvJIuMNJLfh0Qts=;
        b=T+i+/4ES8EGyP8zWDKUZSXMDKrYXaFuZPeezzPl6090D14rfB9DMp+iZFho3PrKDwc
         1r31ynWqeUGW42nGPDGzQ4LM+GpseFm9gOG8BdQDwSq3QNa6Us3WfYHEWYmC0xsBpj9w
         r7nZBtUYcFec65GTJL1KtFGeCbMevuVmSioKhUPzQGuI/KG1BGxa3iyYI6iGvo8tk3l2
         wfJCZmdBf9nELZX2y7VQf3hH9sPyIWCuFL1d1WVidVQtcmP2F1178KYZU358fmnMt4ut
         sbQ1+usdim50lX67RD5l/WpmNT5g3+4b6YmZzfAuO90o/TLDACB9HnNPGVgVjmLNqPP6
         priw==
X-Gm-Message-State: AFqh2kojtl1NX0dZnjemtyh7pgt7bUv35AhJ1wVQw8mOITOr9Ol0nAUU
        RUfnmPjpRe2/myWoHwc202jVJeL4Lr5RIcj43HLOVQ==
X-Google-Smtp-Source: AMrXdXv/z9VuO+GmPwyPH8g5O5t0SywlYiuaRdA7rmFrdM1AobZUxIxIzeP6QIIndykQIZbxOkwQzauHqG7yIT1/EFk=
X-Received: by 2002:a67:fd56:0:b0:3ce:85d5:8a1 with SMTP id
 g22-20020a67fd56000000b003ce85d508a1mr5243803vsr.78.1673439554265; Wed, 11
 Jan 2023 04:19:14 -0800 (PST)
MIME-Version: 1.0
References: <CADg8p94+rY5B937YweMo=5aGS4Dhz2z4QW-BiAdkVdiWCm-u9w@mail.gmail.com>
 <3bd7c0b2c9937c30082381f92624e98902c72ece.camel@HansenPartnership.com>
 <CADg8p94qd-Kx9Xn2LwqypFeAsV734wv7CvswPmGqJZa+ENPpRg@mail.gmail.com>
 <2910376b6912885f696afebf43b820513c004dbb.camel@HansenPartnership.com>
 <63a8c022-1407-d701-e756-070e299b5803@linux.ibm.com> <CAFftDdr6qs33HaaPK3MMmyi9-mMjUuLURt9PAum6hJ3N3m=_iw@mail.gmail.com>
 <a763fdc8e247e217b5efe860be4aebccb708b245.camel@HansenPartnership.com> <CAFftDdrnoc7zsxqLGuGDVK9fh1xh3E3dT2+9rKm7BPr114ZjFA@mail.gmail.com>
In-Reply-To: <CAFftDdrnoc7zsxqLGuGDVK9fh1xh3E3dT2+9rKm7BPr114ZjFA@mail.gmail.com>
From:   Sughosh Ganu <sughosh.ganu@linaro.org>
Date:   Wed, 11 Jan 2023 17:49:03 +0530
Message-ID: <CADg8p94cniETuUFYBw5tOYxBOSMwjYxYZ6Q-bp=WgYvH-e=U_g@mail.gmail.com>
Subject: Re: Seal/Unseal trusted keys against PCR policy
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Ken Goldman <kgold@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

hi Bill,

On Sat, 7 Jan 2023 at 04:43, William Roberts <bill.c.roberts@gmail.com> wrote:
>
>
>
> On Fri, Jan 6, 2023, 17:07 James Bottomley <James.Bottomley@hansenpartnership.com> wrote:
>>
>> On Fri, 2023-01-06 at 16:23 -0600, William Roberts wrote:
>> > On Fri, Jan 6, 2023, 15:55 Ken Goldman <kgold@linux.ibm.com> wrote:
>> > >
>> > > On 12/28/2022 5:48 PM, James Bottomley wrote:
>> > > > The main thing you have to do is connect to the TPM not through
>> > > > the
>> > > > resource manager so the policy session survives multiple commands
>> > > >
>> > > > export TPM_DEVICE=/dev/tpm0
>> > >
>> > > Just FYI, as James says, command line utilities interact with the
>> > > resource manager.  When I want to run command line programs through
>> > > the
>> > > resource manager, I use a proxy to keep the /dev/tpmrm0 session
>> > > connected.
>> > >
>> > > https://github.com/kgoldman/ibmtss/blob/master/utils/tpmproxy.c hol
>> > > ds an
>> > > open source proxy.
>> > >
>> >
>> > If you need to do this in production that tpmproxy allows anyone to
>> > connect to it. So while it's open it would circumvent the permissions
>> > on /dev/tpmrm0. You can just use tpm2-tools, which uses contexts and
>> > avoids this problem.
>>
>> The specific issue with this is that using contexts, no-one could
>> figure out a way to pass the session into the kernel:
>>
>> https://lore.kernel.org/linux-integrity/CADg8p94kTNkoByjLhEij3KkigLxhwU8PxnO82cRaO0Ejh7T3Zg@mail.gmail.com/
>>
>> How should this be done?
>
>
> tpm2_sessionconfig prints the raw handle for this purpose. I think we added it when someone specifically needed the raw handle  to pass to the kernel.

I tried getting the raw handle using the tpm2_sessionconfig command on
the context file, and I did get the session handle. The session digest
also matches the policy digest that was used at the time of the
trusted key creation. However, when I pass the session handle value
through the policyhandle parameter for the key loading operation, the
unsealing fails.

I run the following commands for the key load operation.

# tpm2_startauthsession -S session.ctx --policy-session
# tpm2_policypcr -S session.ctx -l sha256:10
# tpm2_sessionconfig session.ctx  <--- Running this gives me the session handle.
# keyctl add trusted kmk-trusted "load `cat kmk-trusted.blob`
keyhandle=0x81000001 hash=sha256 policyhandle=0x03000000" @u

[  217.219048] tpm tpm0: A TPM error (2328) occurred unsealing
[  217.222214] trusted_key: key_unseal failed (-1)
add_key: Operation not permitted

After running these commands, I get the above error. I am able to get
the key unsealing work with the tss commands from IBM that James had
highlighted earlier.

-sughosh

>
> https://github.com/tpm2-software/tpm2-tools/blob/8cbc4bbaebc4fa135e35dabd6d9ab36ac05eb72b/tools/tpm2_sessionconfig.c#L66
>
> Apologies for any HTML, I have no idea what Gmail on Android does, I have no plaintext option. Yes there are other mail clients, and yes I think they all suck :-p
>>
>>
>> James
>>
>>
