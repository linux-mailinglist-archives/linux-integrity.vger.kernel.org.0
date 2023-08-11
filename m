Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B81E7788D9
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Aug 2023 10:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjHKISb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Aug 2023 04:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHKISb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Aug 2023 04:18:31 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF7AE40;
        Fri, 11 Aug 2023 01:18:29 -0700 (PDT)
Received: from 46.183.103.8.relaix.net ([46.183.103.8] helo=[172.18.99.178]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qUNLo-0002DU-3L; Fri, 11 Aug 2023 10:18:28 +0200
Message-ID: <a588d1d3-12e0-b078-b6cc-b0a63c54ab37@leemhuis.info>
Date:   Fri, 11 Aug 2023 10:18:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tpm/tpm_tis: Disable interrupts for Framework
 Laptop Intel 12th gen
Content-Language: en-US, de-DE
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>,
        Christian Hesse <mail@eworm.de>, stable@vger.kernel.org,
        roubro1991@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Grundik <ggrundik@gmail.com>, Christian Hesse <list@eworm.de>,
        linux-integrity@vger.kernel.org
References: <20230710133836.4367-1-mail@eworm.de>
 <20230710142916.18162-1-mail@eworm.de>
 <20230710231315.4ef54679@leda.eworm.net>
 <bd0587e16d55ef38277ab1f6169909ae7cde3542.camel@kernel.org>
 <bb5580e93d244400c3330d7091bf64868aa2053f.camel@gmail.com>
 <0f272843a33a1706dbcbb2d84b02e3951ee60cbb.camel@kernel.org>
 <fdd5fd9ece045ebd1888672a75f157e64ade98fb.camel@gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <fdd5fd9ece045ebd1888672a75f157e64ade98fb.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691741910;edc95982;
X-HE-SMSGID: 1qUNLo-0002DU-3L
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 06.08.23 18:30, Grundik wrote:
> On Wed, 2023-07-12 at 00:50 +0300, Jarkko Sakkinen wrote:
>>> I want to say: this issue is NOT limited to Framework laptops.
>>>
>>> For example this MSI gen12 i5-1240P laptop also suffers from same
>>> problem:
>>>         Manufacturer: Micro-Star International Co., Ltd.
>>>         Product Name: Summit E13FlipEvo A12MT
> [...]
>>
>> It will be supplemented with
>> https://lore.kernel.org/linux-integrity/CTYXI8TL7C36.2SCWH82FAZWBO@suppilovahvero/T/#me895f1920ca6983f791b58a6fa0c157161a33849
>>
>> Together they should fairly sustainable framework.
> 
> Unfortunately, they dont. Problem still occurs in debian 6.5-rc4
> kernel, with forementioned laptop. According to sources, these patches
> are applied in that kernel version.

Jarkko & Lino, did you see this msg Grundik posted that about a week
ago? It looks like there is still something wrong there that need
attention. Or am I missing something?

FWIW, two more users reported that they still see similar problems with
recent 6.4.y kernels that contain the "tpm,tpm_tis: Disable interrupts
after 1000 unhandled IRQs" patch. Both also with MSI laptops:

https://bugzilla.kernel.org/show_bug.cgi?id=217631#c18
https://bugzilla.kernel.org/show_bug.cgi?id=217631#c20

No reply either afaics.

Ciao, Thorsten
