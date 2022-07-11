Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E296570C4B
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Jul 2022 23:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiGKVDX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Jul 2022 17:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiGKVDX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Jul 2022 17:03:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1D43C8F6;
        Mon, 11 Jul 2022 14:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657573386;
        bh=/e4wBbBOuZ/wan9DlfBIaDZRmWKhFZgpdItI3Vb8dT8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=KMPiOjdNfGX2NaClnTiR09De8oe1O2cL84je+2jsLjT393qrhg7/0aNO38NnH3+ck
         /iwaTVcmt2U4BjXO4GyHleXCVEkrIojbYGUmtaqpYlXyidWtOWJma0NoBtnRziJPYj
         71oR20X/NS7iYoV2x3CDs+lAA+XSZ1gZmr56cOPc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.69] ([46.223.3.243]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7R1T-1nULhv2hQL-017nhS; Mon, 11
 Jul 2022 23:03:06 +0200
Message-ID: <62cec6b9-396b-83d0-b10f-78b0bb61e317@gmx.de>
Date:   Mon, 11 Jul 2022 23:03:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 07/10] tmp, tmp_tis: Implement usage counter for
 locality
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
 <20220629232653.1306735-8-LinoSanfilippo@gmx.de>
 <Yr4x6KRSvzlXNdH2@kernel.org> <f0e33bc4-335c-322a-9295-18d6bc0b8286@gmx.de>
 <YsuQEoVuVa00gIdE@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <YsuQEoVuVa00gIdE@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TcHnp8kxL8x6dUHGTg2b5c/Jv3NHdaY/Ow/zTYFWMChyyi116B8
 X1N2pk5OaYLOhaFLWxu3gb/K3joNEz33lJDmQroBBTn0x87a1aY4I+Utzrsej2etGqUlCSl
 XkywLwGOrIrtagzkip+rf/RbVnd1CWM+1+ZESH+yHwd0w8cjFyufmkFz4Xb/GlRAEomPeR5
 EVNBJGCJRr9J8jNQyXhmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y0orydPIqMI=:J6xQXvU57zIqQ0hzPZpZFL
 nxpKiTg/59nnivtSWNVqDULDrU1r7sEfjf3D2DfoTbMuVDjJvso7qQ5SyRx3r7y82il5FBcY7
 0ADJ4ncdHtfTFQseYSpt9Jc5E1sHncOxTvYGQS7aSYgMAPSH3G1hMpUR6JOpAo60ddM2vQFfj
 qjqPHQE40EeF+S/bDpKw4VQ0LlZ4n9ae3KegLaWT4eU9RV/JD8lI6oZeDZhweEYjy+RsEreoy
 gVI1876/hkt0n796PKYGYwJnSBRn5EEJmsAeAxSTq23Pf98V3lva5818QSCJ9sVjPGk28fCEs
 X5rJ9uf3VDPCY7FUn6S7SvGmzo5UE3qGw+D4AYNZe6hvdkAcd4V/wZp89AdAZQ17MxB8FIm5q
 xmMStm5DFJPTh/Qj9Scit3+6ccUdIE5ZyzWv68CU2OceGMDYtPM8fdttniWAGM5Qqrdv36Bnq
 iTi26CisWThLc+Qz8ZNbT/OfLJBwW/aA30Xn03w5isFXwVrVyX/aoC8uqVPo85+TxlYKkWBw0
 5N8df+W7cElOb8M2LiviR6T19HgoDgZNCJ41pjXhtFABhwtS+9xtkmSoyzJs8z4Qldvx96/WR
 uYkBhz02tjjcsqm1puS2hWhTQLPHyFhBmGGRwDNwFDQgW/6UTPdMu1yk28Z2wPlWFPdj7bWUj
 FzrvpeaAjlrFGWQBcyQGJMBKXI20S35W54CBAWbbt19PEosa5fkCzfH1XZWVuHWPIMhDMYoyR
 u1xL+5PQC7RhTUPqsfSovkrwwgRrMmnHPKxtHtxx9aWRC/r4tH/cU+1wvcYLK5fvV5Wrss0ag
 vqx9SND9hy65Zcy+I51wrRM0bvIksBU26eKt0B6bycDVBY5UKHJ3Sr5zxn5uF90+VZ86LbQmO
 EC+MwZzsctyybkOFx/ErbXcHTZPqEAesDbSEMxGQfsPZtWhYnh8a2HOHdTSr4l0SA1Y6VQqme
 6G8ehCieCiJeqEGWsWWeZyhTx5nLqjhMenHsQ+MrS3nCya7OVHkRBDTK7xOEgKRIQuPEk5ADD
 9ZYv8lICjKwiAIHUwQWMQp2yiqwLCFtYYyQvv0dQUTyk6NnQIgVWT1gkcEKmya56qIXv3cEp8
 6hUt4U7F2Q5mmoJ9DrzdrDKi43/M3Za/rSxXcJCh3A6Dw8vgwcJQVZbmg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 11.07.22 04:50, Jarkko Sakkinen wrote:
> On Mon, Jul 04, 2022 at 07:45:12PM +0200, Lino Sanfilippo wrote:
>>
>>
>> On 01.07.22 01:29, Jarkko Sakkinen wrote:
>>
>>>
>>> I'm kind of thinking that should tpm_tis_data have a lock for its
>>> contents?
>>
>> Most of the tpm_tis_data structure elements are set once during init an=
d
>> then never changed but only read. So no need for locking for these. The
>> exceptions I see are
>>
>> - flags
>> - locality_count
>> - locality
>
> I'd still go for single data struct lock, since this lock would
> be taken in every transmit flow.

Well in both cases, transmit and receive, we end up in wait_for_tmp_stat()=
.
Whatever lock we hold at this time cannot be taken in the interrupt
handler, since this would deadlock (wait_for_tmp_stat() waits for the inte=
rrupt
handler to complete but holds the lock that the interrupt handler needs to=
 proceed).

So in the interrupt handler we need something that is not held during the =
whole
transmit/receive flow.

This is the reason why the locality_count_mutex only protects the one thin=
g we
have to take care of in the interrupt handler, namely the locality counter=
.


> It makes the whole thing easier
> to maintain over time, and does not really affect scalability>
> This brings me to another question: what does this lock protect
> against given that tpm_try_get_ops() already takes tpm_mutex?
> It's not clear and that should be somehow reasoned in the commit
> message.

See above, we cannot take the tpm mutex in the interrupt handler for the s=
ame
reason.

> Anyway, *if* a lock is needed the granularity should be the whole
> struct.
>
> BR, Jarkko

Regards,
Lino
