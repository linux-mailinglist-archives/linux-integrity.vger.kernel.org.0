Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCFD752745
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jul 2023 17:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbjGMPeg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jul 2023 11:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbjGMPeT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jul 2023 11:34:19 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F422D48;
        Thu, 13 Jul 2023 08:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689262442; x=1689867242; i=linosanfilippo@gmx.de;
 bh=AC2RBZA0N9RMCn7XiFb7g7VTZZV5BgZub39Y6k6C61o=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=YM3E6VrUAEyZEPsbhJ5tjTTAEl/pO3a679p+YZr/UKpm/nryQ8vcc6WOCybFawFf0wNRzBY
 uS+pT2krFzNxziMWXGF32F1RDdy4/qdCxkAFFa35HlCMWeyAe3VxUXQePA95v39T+wkUfxCmP
 f7AxUg5V9fZFKyVdyf7t0U0PJ7IvcFmpttdZHjea6+z4QmtHgjprzHUbUb7jhaL4G78H48Xw5
 iuDoIG0o5XAqVSVcCQS5JL5K3GFGNIFR13gD9gSNikMxtL+iLj4WwsLHnXL5hg5CCXc9p/x7I
 WU1TtK0HtfoIsxbO7XnTCdfYrkOgjwzF0yJLZrAiYSpqbzeaWpjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.10.87] ([180.183.243.38]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbAgq-1pn6Tx3d4C-00bbDd; Thu, 13
 Jul 2023 17:34:02 +0200
Message-ID: <d9051309-618d-edac-8ed7-061f740d0096@gmx.de>
Date:   Thu, 13 Jul 2023 17:33:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] tpm/tpm_tis: Disable interrupts for Framework
 Laptop Intel 12th gen
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, Grundik <ggrundik@gmail.com>,
        Christian Hesse <list@eworm.de>,
        linux-integrity@vger.kernel.org
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
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
 <0f272843a33a1706dbcbb2d84b02e3951ee60cbb.camel@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <0f272843a33a1706dbcbb2d84b02e3951ee60cbb.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:78VQjn+iF+tebOEulfJFQdV5ztIL2JV5S0ry84hHkR8EDZp67Zo
 APn5Zce3PTq/esOHqdmzoc4p41Gz+y6KGxsPAQMYzL8I6jYTb5a6nADus30fMuV8KGErJBy
 NFLT46d8zVMYqpPUkf6lDIKlBxsxnvZGmAGJU5ltd8+iVrTL2RnzssMdb6e1oXCriHBdqHY
 iNvOOnryVmBn7UozzQH5A==
UI-OutboundReport: junk:10;M01:P0:iAwsYVtselo=;h7FIz2BjPy4UU/VZ2UCCrzgCeK9+l
 VG9RWb12gTQuv77jvZT6Fz4/+IR05qxCJ35rCrrUZUmLoponj53x0W2ujG+7w8yvr215hFvB8
 L6tUgfBGCSFLVEbLV87YCTtmQwESqMSF1KGC2D31vwZPbAZK0Rq3iQtK3lBc2BPjwHSva9TgA
 sE5tNMtynwDK03CXc3uTftEoaO1WP8ywOUmpow6bAnjm2BKlKhLXWy6+8U1GFmey3AaXKNXIX
 NXQPjYUKUWMsaKwLR51hS1p+xc6ZlOe88NMiyxMlf4ZknDFPHZAq20hJCLvvCEgVuO5IVcQ4P
 5I2/h5SppZEurJd31XV8iv6v5X1a96URAhyZ2UH3nODAWpVYcnARMo3BSUL6qjhYnVvJ2Pz05
 jibSS1DcKEwr+OtsJTo+l0n0SYSMHy2mo28dkKGeESH8nDgAa56Doi8YDy40cQWd8uDXP/yBt
 LwK39zjzf4woHr+y31oDR8DuvLVx+r8kzv1ds8yecaqm7X83VTUbe6kaT53W1tADMwQZxd80A
 rNDBZbUllfPs3oLL5P3Pwi83+K99CD6/52seqEm/+yzfHq0u1cC73r0gWst9gE1tXoPyHdtYx
 0AGTwYWiSmNmhHaCeAEB2mRYSohseO2mzN35cmfglg8cwWboBil0/k7SwaNQ33AFv21tEepF1
 QRVdoAz4yYVzur4PxxitV+FRHjw237pAnmUinxvwh6mSKWQrT7km8zvBzQ9/xeJ8rZZJyxbBB
 2a52jYKyArrreSkR/ldsjVNTVDNvoZJyWpFq/f2pZjXVpKH6VuE4nVK8JWG+H5253MgETLFeq
 DgpNngU+RXZeUwR4mesLZ/Ex9hqLGjjxy/5u0ZfAgZTCvT1T7zWssMR/vIuou9tgv6eiQGINC
 xUuO4A0yGqvRA+mNYSSo8lGtWsrC0qPADSyNZFHmrjzpUAVB9LtmNC5AohXdFmDYduER+/SyJ
 D+J2Aj/3IA7I6iS3SAbk6pVgFu5OYNtBRZLan0ZKr5Prt3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 11.07.23 23:50, Jarkko Sakkinen wrote:
> On Tue, 2023-07-11 at 15:41 +0300, Grundik wrote:
>> On Tue, 2023-07-11 at 00:29 +0300, Jarkko Sakkinen wrote:
>>> On Mon, 2023-07-10 at 23:13 +0200, Christian Hesse wrote:
>>>
>>>
>>> OK, this good to hear! I've been late with my pull request (past rc1)
>>> because of kind of conflicting timing with Finnish holiday season and
>>> relocating my home office.
>>>
>>> I'll replace v2 patches with v3 and send the PR for rc2 after that.
>>> So unluck turned into luck this time :-)
>>>
>>> Thank you for spotting this!
>>
>> I want to say: this issue is NOT limited to Framework laptops.
>>
>> For example this MSI gen12 i5-1240P laptop also suffers from same
>> problem:
>>         Manufacturer: Micro-Star International Co., Ltd.
>>         Product Name: Summit E13FlipEvo A12MT
>>         Version: REV:1.0
>>         SKU Number: 13P3.1
>>         Family: Summit
>>
>> So, probably just blacklisting affected models is not the best
>> solution...
>
> It will be supplemented with
>
> https://lore.kernel.org/linux-integrity/CTYXI8TL7C36.2SCWH82FAZWBO@suppi=
lovahvero/T/#me895f1920ca6983f791b58a6fa0c157161a33849
>
> Together they should fairly sustainable framework.
>
> Lino, can you add the same fixes tag as for this. It would probably
> ignore inline comments to keep the patch minimal since it is a
> critical fix. Just do the renames, remove inline comments and
> send v3.
>
> For tpm_tis_check_for_interrupt_storm(), you can could rename it
> simply as tpm_tis_update_unhandle_irqs() as that it what it does
> (my review did not include a suggestion for this).
>
> This way I think it should be fairly trivial to get a version that
> can be landed.
>
> To put short:
> 1. Do the renames as suggested, they are good enough for me.
> 2. Drop inline comments, their usefulness is somewhat questionable
>    and they increase the diff.
> 3. Generally aim for minimal diff but I think this should be good
>    enough if you do steps 1 and 2.
>
> If you don't have the time at hand, I can carefully do these cleanups
> and apply the patch. If you have the time and motivation, go ahead
> and send v3.
>> BR, Jarkko


No problem, I can do this. But note that the next version will be v4 not
v3 (as v3 is the version you recently reviewed).


Regards,
Lino

