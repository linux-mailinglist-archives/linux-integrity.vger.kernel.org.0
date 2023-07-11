Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272C174EFC6
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jul 2023 15:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjGKNCY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jul 2023 09:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjGKNCY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jul 2023 09:02:24 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283CF171E;
        Tue, 11 Jul 2023 06:01:59 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qJCyT-0000Lw-6c; Tue, 11 Jul 2023 15:00:13 +0200
Message-ID: <3739ab8f-b1f2-dbbf-dffe-0ea5808c1d95@leemhuis.info>
Date:   Tue, 11 Jul 2023 15:00:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/2] tpm/tpm_tis: Disable interrupts for Framework
 Laptop Intel 12th gen
Content-Language: en-US, de-DE
To:     Grundik <ggrundik@gmail.com>, Jarkko Sakkinen <jarkko@kernel.org>,
        Christian Hesse <list@eworm.de>,
        linux-integrity@vger.kernel.org
Cc:     Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>,
        Christian Hesse <mail@eworm.de>, stable@vger.kernel.org,
        roubro1991@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20230710133836.4367-1-mail@eworm.de>
 <20230710142916.18162-1-mail@eworm.de>
 <20230710231315.4ef54679@leda.eworm.net>
 <bd0587e16d55ef38277ab1f6169909ae7cde3542.camel@kernel.org>
 <bb5580e93d244400c3330d7091bf64868aa2053f.camel@gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <bb5580e93d244400c3330d7091bf64868aa2053f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1689080520;f9977a24;
X-HE-SMSGID: 1qJCyT-0000Lw-6c
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11.07.23 14:41, Grundik wrote:
> On Tue, 2023-07-11 at 00:29 +0300, Jarkko Sakkinen wrote:
>> On Mon, 2023-07-10 at 23:13 +0200, Christian Hesse wrote:
>>
>>
>> OK, this good to hear! I've been late with my pull request (past rc1)
>> because of kind of conflicting timing with Finnish holiday season and
>> relocating my home office.
>>
>> I'll replace v2 patches with v3 and send the PR for rc2 after that.
>> So unluck turned into luck this time :-)
>>
>> Thank you for spotting this!
> 
> I want to say: this issue is NOT limited to Framework laptops.
> 
> For example this MSI gen12 i5-1240P laptop also suffers from same
> problem:
>         Manufacturer: Micro-Star International Co., Ltd.
>         Product Name: Summit E13FlipEvo A12MT
>         Version: REV:1.0
>         SKU Number: 13P3.1
>         Family: Summit
> 
> So, probably just blacklisting affected models is not the best
> solution...

Hmmm. Jarkko, you earlier in the thread said: "I'm about to send a PR to
Linus with a pile of IRQ fixes for v6.4 feature.". Could any of those
potentially help Grundik or those with the Framework laptop? Is that
worth testing?

Ciao, Thorsten
