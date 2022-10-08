Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBC05F8625
	for <lists+linux-integrity@lfdr.de>; Sat,  8 Oct 2022 19:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJHRGI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 8 Oct 2022 13:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJHRGH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 8 Oct 2022 13:06:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F3D2CDC4;
        Sat,  8 Oct 2022 10:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665248745;
        bh=Tb8EH9348vkLCbF5WRu35I60NkPtSNYF6aeCGlhW9kQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=bQtTi2VbW1YYgScaaxy7v8jiINBt8DOIpV9nyPXLUpvDRe7FN23iArjDFb9zaAhKE
         F+SblUS92zFQSaW/gETz94/mCfyWXN0sZrAQSctmT/9dYtNPzqQqbUO0wqMAMa2Vys
         fk/C6TaNEt5uafjGzsFH5hoFY/DmBE+sgbMFCxNE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.100] ([84.162.5.241]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWASY-1ofbkZ0fms-00Xd9r; Sat, 08
 Oct 2022 19:05:45 +0200
Subject: Re: [PATCH v7 07/10] tmp, tmp_tis: Implement usage counter for
 locality
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
 <20220629232653.1306735-8-LinoSanfilippo@gmx.de>
 <Yr4x6KRSvzlXNdH2@kernel.org> <f0e33bc4-335c-322a-9295-18d6bc0b8286@gmx.de>
 <YsuQEoVuVa00gIdE@kernel.org> <744ad6e1-c4ad-1e6d-f94d-98aa5b105dc6@gmx.de>
 <YuJFuBFtImG/k+C0@kernel.org> <d3f16f0a-cc05-a6f1-17cb-2649b5ab42c8@gmx.de>
Message-ID: <09eefdab-f677-864a-99f7-869d7a8744c2@gmx.de>
Date:   Sat, 8 Oct 2022 19:05:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d3f16f0a-cc05-a6f1-17cb-2649b5ab42c8@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E9hCD+ASl+nhJQlUzQvP/M49+j8ZzuAlF5b6qQu10gY0f/KCTZi
 iaVUxLeM8T9pOSmawjLX7tdLxD3PgWzI3hQTTahhsEaKzyac+KrznZf5txfz4tol+C6A8vX
 bDTK+610WvPKeayKA0+exD5eslqF7jpC3CcIx4pZPcUy7bnOMVfgekV4Kclj9AmH/oy/kSJ
 z/42c/B/31Ub5lx1bI1IA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NvAC+Gzd4g4=:KkAC2SGtT4Kx9pDqFYEXGD
 UUszEekz7Xp5/UXRpuesqmhn2D+pRIzkrYmjd/0B1DY9fUrdpffiXJKtHJqVsTvKJJuyDJpMU
 zyTUEED/4VJTViWIMN2ZsYBNiCGHEb2cq+fmig9DsmblDBV+e1N/3rNusNaOTvJUS626K3vSa
 ipH8oGhsMJE2MU1HuX+NCGHfeKUJq7eKnqp+9MR9BpxXJbaZ1XjsQ3zM/dpz5oMouNmG78cwD
 fNgwo+yUbsUuiPZ3Kvj7lcSp7suOooWILNoKjLD2D8G98g8xeo1ETBraqOP7jq+6NwTOlCOzH
 JfnX9Udm1aDkrpEpkBX1wK4mRwJjQ7o1kzKsrV7BeLszNRNmM12VbsJWT/zVn1y5Yfc9K58ka
 pcqlVQ/azDhKc14VD9oVGbwmUeFKNWa37l/WQLBx1Jd+k9kmvP64VBwmFW/EPWB7QGmQIl4o6
 mQaYvItIoew6+ZxN6zhrrXRH+bDM3xDcC6gDUoqFNpHRMipFNwN3mPaztloYGxUBx61lGlLGe
 rXn3WJ6J9S3GOtE2wQT2U6H9+DaaNTZ1P9X7cWvBcwHOjbXgmSSmyWccQs3bn5TXvy5Lt6Pig
 /Uan0FuVR/wIUuKT8j/t0k7wguILWnTY6aS7IWslIPPrfzZEHh8+Qwvk51Krp4lSBQkMObZLj
 D0tfCPxdiX1lDY6zie5LcmbVYZKZE/JwsEIYTJ1KXQtfshRNfd/HnA8zpzpISDbdE7P8nQY6A
 5V4mCmk1lg2yxW1d92wacBSSm6/uFg6howZckEU+S6qpLSIz1IvTj7A3UlZfTIRcrp8HJoK99
 oIZSsYtwLDgObAV0Z03k7dnH0bIWdydUDyIJ0JmXa9Vtq4qRbJLhhZEeZFZ1R/8LW+KNH7YlJ
 Gb0dlBa3FFhHOKovPnlkwhy/WZjLwK3qHS4PLdct1g91CKG2mf4637erNfKpfmmGYPMAWOpHw
 HMdoycUB3ZVpbTarOhvNYlt/6TMtPJ+E/vNWEWT0KCIj2nFaVmxes/22fA53IgZ3lDBIKfILW
 UQ6rRM/1bH+lbXopupS2FUTP3+TXMQndhdmUebAMhz9FX0VWTL7SKUCc/giCKunFuv6Z9arVS
 erAhwLLln3VbzFWQtTfo3ygw5jfLjGad979vp97NSOHIztdeDrEtCoFFBY2X5Z8yntTaKVYaW
 R2+7wfhAy7T5ucSwCrBQO9EsMi5C4mI+JzWJ/Nt8p2ioSw7H94sr82VQe0MbyJcJugni/5BR+
 /Cyv6OfUaagfRx9E1B0Va8PzNE2EM0abD7jC1hOQjm+ONaOZFK82IE3J4OIDj3616DXAPNsUO
 jUcEwUiWznvZ7OvTKQMLjgFCjkr0dn8RaG+oiu6ts2eUyDkAgDUg4JVFG64f0Zsfzo+NxVp18
 Q4OiOfzreZOe0LCT/35SRdEFbCG7TgYpfetfckfxzC6lcsZiHN2GenQ7HBoSg/2hxXboVmnOE
 QAD5rbYhNWW/XNJtTHS3cab6Rk4Xg+dvR21Xat91n0j9Eq5rnlHIzkwmqU5yowB6ofH80YPxj
 1IIMxHXMqcJ+GcI7jJRAhR4wc0v7x/Q0NdeZfwM1svyAh
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi Jarkko,

On 28.07.22 at 17:45, Lino Sanfilippo wrote:

>>>
>>> This means switching to a complete new locking scheme which affects ma=
ny
>>> parts of the TIS core code. It is also not directly related to what th=
is patch series
>>> is about, namely activating the interrupts for TPM TIS.
>>>
>>> I suggest to first finish polishing this series especially since there=
 have
>>> only been minor issues in the last versions. Once the interrupts work =
we
>>> still can think of implementing another lock handling in a follow up s=
eries.
>>
>> So what if you would use kref instead here?
>>
>
> Sure, that should not be too difficult to do. I will implement this for =
the next version.
>
> Regards,
> Lino
>

First of all, sorry for this very late reply. Unfortunately in the last we=
eks I was
not able to work further on this series due to my private situation.
Nevertheless I tried to implement your suggestion (using krefs for the loc=
ality counting)
meanwhile. However krefs turned out to be a rather bad fit for this task.

The reason is that for the locality handling we have to perform a certain =
action (i.e.
writing to the access register) on two occasions:

1. When the locality is requested while no locality is active
2. When the locality has been released the number of times it has been req=
uested before

Since a kref is designed to track the lifetime of an object which is freed=
 as soon as the
kref counter hits 0, it starts with a counter of 1 when it is created, not=
 with a counter 0
(as we would need it, since at the beginning nothing has claimed the local=
ity yet).
Furthermore while kref provides a built-in mechanism to execute a function=
 when the counter
hits 0 it does not provide anything similar for the case that the counter =
is increased the
first time (i.e when we want to claim the locality by writing to the acces=
s register).

So although certainly doable I do not see much gain from using krefs in th=
is case. Again,
sorry for this late reply.

Regards,
Lino

