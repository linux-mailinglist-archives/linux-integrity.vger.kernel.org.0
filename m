Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781A2736C1E
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jun 2023 14:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjFTMmG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jun 2023 08:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjFTMmF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jun 2023 08:42:05 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C4C10DD;
        Tue, 20 Jun 2023 05:42:04 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qBagI-000343-QS; Tue, 20 Jun 2023 14:41:58 +0200
Message-ID: <2d7ed7bb-38ba-8840-6629-d210937b8513@leemhuis.info>
Date:   Tue, 20 Jun 2023 14:41:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: New kernel warning after updating from LTS 5.15.110 to 5.15.112
 (and 5.15.113)
Content-Language: en-US, de-DE
To:     Greg KH <gregkh@linuxfoundation.org>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        stable@vger.kernel.org
References: <fe6f7aa0-56c2-3729-ce8c-0f2d943b33f4@alliedtelesis.co.nz>
 <ZHQIFLWvrWUNMVxb@debian.me>
 <6e470461-1a9b-ec51-bac5-f2beb1dc11c9@alliedtelesis.co.nz>
 <2b09d2ed-0852-bbc9-b792-aad92235c7fa@gmail.com>
 <03daca5c-e468-8889-4dc2-e625a664d571@alliedtelesis.co.nz>
 <ec5245bd-3103-f0c7-d3ef-85aabb4d4712@alliedtelesis.co.nz>
 <ZH6TIjXeXJVMvSKa@debian.me> <2023060606-unlatch-yiddish-a45f@gregkh>
 <ac5b76af-87dc-b04d-6035-8eda8ba5ed12@kunbus.com>
 <2023060736-immodest-doormat-f957@gregkh>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <2023060736-immodest-doormat-f957@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687264924;c426119d;
X-HE-SMSGID: 1qBagI-000343-QS
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 07.06.23 19:49, Greg KH wrote:
> On Wed, Jun 07, 2023 at 05:47:57PM +0200, Lino Sanfilippo wrote:
>> On 06.06.23 08:45, Greg KH wrote:
>>>>
>>>> Lino, it looks like this regression is caused by (backported) commit of yours.
>>>> Would you like to take a look on it?

>>>> Anyway, telling regzbot:
>>>>
>>>> #regzbot introduced: 51162b05a44cb5
>>>
>>> There's some tpm backports to 5.15.y that were suspect and I'll look
>>> into reverting them and see if this was one of the ones that was on that
>>> list.  Give me a few days...
>>
>> Could you please consider to apply (mainline) commit 0c7e66e5fd69 ("tpm, tpm_tis: Request threaded
>> interrupt handler") to 5.15.y?
>>
>> As Chris confirmed it fixes the regression caused by 51162b05a44cb5 ("tpm, tpm_tis: Claim locality
>> before writing interrupt registers").
>>
>> Commit 0c7e66e5fd69 is also needed for 5.10.y, 6.1.y and 6.3.y.
> 
> Now queued up, thanks.

#regzbot fix: 0c7e66e5fd69
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
