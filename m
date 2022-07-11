Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C44570C95
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Jul 2022 23:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiGKVQG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Jul 2022 17:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiGKVQF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Jul 2022 17:16:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE3180511;
        Mon, 11 Jul 2022 14:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657574151;
        bh=nv8eBRdrt/nRBtfZuGKt31XOt7uveMy1h9GnSDHGp8U=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=g/X13VjHb6trtBKvysWHApEgqf9syLb1aI/mOASSgbB0q0T59UmStoh3EhhEfgvAv
         tNIVvCtTgzk1LIOjPDFwdhuXYHusR8GLvRGq/LXySG+BIbrmxkDNn+4PfKzkHzWKSq
         TVCpx0kzbsl4fxFNoz5xe+WJeefWRcFUT62U0t3A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.69] ([46.223.3.243]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MO9zH-1nvwkh3x6H-00OUCg; Mon, 11
 Jul 2022 23:15:51 +0200
Message-ID: <ce36a48c-8e54-807d-038d-06cb77bdad23@gmx.de>
Date:   Mon, 11 Jul 2022 23:15:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 07/10] tmp, tmp_tis: Implement usage counter for
 locality
Content-Language: en-US
To:     Jason Andryuk <jandryuk@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        l.sanfilippo@kunbus.com, lukas@wunner.de, p.rosenberger@kunbus.com
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
 <20220629232653.1306735-8-LinoSanfilippo@gmx.de>
 <CAKf6xpvY1peO-mWM+bjaHnXhrqpOrGbyrOOaT18-myWYSJ88Sw@mail.gmail.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <CAKf6xpvY1peO-mWM+bjaHnXhrqpOrGbyrOOaT18-myWYSJ88Sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6GpvZKvLIXEPEdvSK7eLKgDmlPTvX2NSSs3Beb9jGlI6qLEasbe
 gD9pT35uGHkjtcCziU+XE+3WxNdZ0CzxuOCy9fJXmbmv0+s+z0fJ4PkMGwLmgoB13oqSoaj
 ql79pd3r7A8xT7k551Op42RPCBqmVmFtcY2B608DhfayY47xFfWP+G4gsqCU16q6uS45tPF
 +AdMouTQsv8PTMGfFTqjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oKygosC5WxE=:oVF3szAJ9rF10SZFQWJikH
 +Qhc+9C7J6SC5jAIpeC/Xs0yF0e8KjcXf6ZD/5wKKja+GGMCVZHL3BgG7yu1tt6+cn7V3gX89
 1TtdQNbEpohh5KZIdSPZqSlYL3ccZk6S0x+Xc1HMVUJXu/KZ2ZrS926y8xb6LeP3/N8g/DLF0
 cx10INId+5+fdGRldiojOB0urrl3Z21pg5D1ar2EgcyoWyjLOdIsJHtYQvai4C8kiljseS2HM
 IKcL/chYtXYQvlDCxefUbku92nxK/nMt1VsRM2WKcYjiXlSSB03U8Gv/1fjgLi0XuiLrF+32E
 YOcVLh72l3NEZ+6BTnBUXhHCi+y1URmJEO6+g1vbIav2Rc6BAiO3qjGvg92b+w3VJo0aeQfhp
 vgI2FhdlV9loBpTVQnmulAn6tQU2skRbp22iw0NG8w5IGVruN55M35h06Z+OKoV11fROOEi6O
 X3Y/AVJSo0F9/aOFUvsHo0Vdk5Y9+E30FQahuHl3Cpydby4HJYUDxRzgK0GUR9vSecUxdHeAU
 +INh+be4IYw9T+N8ZC84fNqmf9jdUmhPk19PvaCJVvrwovs3Jb+7VcyehYkKsragLOHOBzej6
 brByv8iTbLs+kUSRgnD3DnWQ8zX0WJmmff7JcPvGNShxAZiq25QEgVxPSbGvsbx9hggSGZ2/S
 7r1JQT1L2Ihzd+Apyq60DD41yYHPIt87eTd5b6e1S/K1a8ZLEAU2SrdlMX3UYmBZ7eh8RMJ4p
 e5G8yZ7dwQGdyGmOBDFnhdiPQbOa4efD4C+7EOZR+I3TqPd3mfll30Tk1cWrLnnLoHrZ9oocG
 EDEy7iwREDLzHwkuDMGuHXNFZ6ji1CEdpQ5qn9efZOGakupS2flSYf0bhB8l1JitS8P/0Q/ZT
 93hzbWYbs5V73mf87P2ngHNpKry+soC86D3EN+tfi585I4Yca00/V41kKa7R4jVdf2NsvkUrj
 sR2NBvJmVrR3yYSZ0dVVvyV+Wvjrzz1v3AGhNf+rndvCqDFXJSmdQ3P7dmwMeCudgEs/+CxpA
 ig8//fQf8yf9jsHasU6QoLBe+hlQdrPyM6iFVTtpBhEy3mqjR91mojLVIlvZSsucr+i5ZskVP
 RtE+13+s3wijy3z49UCbnWduA+ZkC3wFxaef3tNSMWNFKRj/gUyOBfHyw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 11.07.22 21:39, Jason Andryuk wrote:
> Hi,
>
> This patch subject has a typo "tmp, tmp_tis" -> "tpm, tpm_tis"
>

Right, thanks for the hint!

> On Wed, Jun 29, 2022 at 7:28 PM Lino Sanfilippo <LinoSanfilippo@gmx.de> =
wrote:
>>
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> Implement a usage counter for the (default) locality used by the TPM TI=
S
>> driver:
>> Request the locality from the TPM if it has not been claimed yet, other=
wise
>> only increment the counter. Also release the locality if the counter is=
 0
>> otherwise only decrement the counter. Ensure thread-safety by protectin=
g
>> the counter with a mutex.
>>
>> This allows to request and release the locality from a thread and the
>> interrupt handler at the same time without the danger to interfere with
>> each other.
>>
>> By doing this refactor the names of the amended functions to use the pr=
oper
>> prefix.
>>
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> Tested-by: Michael Niew=C3=B6hner <linux@mniewoehner.de>
>> ---
>>  drivers/char/tpm/tpm_tis_core.c | 75 ++++++++++++++++++++++-----------
>>  drivers/char/tpm/tpm_tis_core.h |  2 +
>>  2 files changed, 53 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis=
_core.c
>> index bd4eeb0b2192..e50a2c78de9f 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>
>> @@ -215,6 +226,20 @@ static int request_locality(struct tpm_chip *chip,=
 int l)
>>         return -1;
>>  }
>>
>> +static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
>> +{
>> +       struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
>> +       int ret =3D 0;
>> +
>> +       mutex_lock(&priv->locality_count_mutex);
>> +       if (priv->locality_count =3D=3D 0)
>> +               ret =3D tpm_tis_request_locality_locked(chip, l);
>> +       if (!ret)
>> +               priv->locality_count++;
>> +       mutex_unlock(&priv->locality_count_mutex);
>> +       return ret;
>> +}
>> +
>
> This function should check that the requested locality matches the
> current locality otherwise this sequence would seemingly succeed
> though locality 0 is the one acquired.
>
> tpm_tis_request_locality(chip, 0);
> tpm_tis_request_locality(chip, 1);

This should not really be an issue since the TPM TIS driver only uses
locality 0.

>
> Regards,
> Jason

Regards,
Lino
