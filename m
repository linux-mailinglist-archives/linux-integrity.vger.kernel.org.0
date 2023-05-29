Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BE4714A16
	for <lists+linux-integrity@lfdr.de>; Mon, 29 May 2023 15:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjE2NRE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 May 2023 09:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjE2NRC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 May 2023 09:17:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C7ADF;
        Mon, 29 May 2023 06:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1685366105; x=1685970905; i=linosanfilippo@gmx.de;
 bh=nEw5zdKnvGixAGnZTZk2CCWjlN++FXM6AUODgPOufEU=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=rwOoi4LDKdScz1EfnRcR+zE5f5p4f2KbwgPQszOFyvr7LTDa9ZdyA0gCFTQUtaQOE/Lt4sL
 iQY2c6v74YnXBu0YgQreNWTOoC0eVkn8F1MeH/KwZLdJ5otZcUgO03F52hpiiOTcHS2pFRPkT
 7qw1fJYlisAbU2AXTbpVxtAJPLIRZD2xGbkJBJ0t1x8B+nV70SgJ+MQQf/6IgKcSYRWXsf3j6
 aZ3wIpkp3VvF4PgJrXZJzT/F/VU+k3j5AUdwUlpo3/tr2J9T6Jn6gAG0pLglJCbRV2kscz+U9
 HcZNhxT3dMMoujkaczZ+zB68MD0iKTPcmGyZUcbdxieUvL8SapDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.37] ([84.162.2.106]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmlTC-1qTIZ43GIY-00jtii; Mon, 29
 May 2023 15:15:04 +0200
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, peterhuewe@gmx.de,
        jgg@ziepe.ca
Cc:     jsnitsel@redhat.com, hdegoede@redhat.com, oe-lkp@lists.linux.dev,
        lkp@intel.com, peterz@infradead.org, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <CSTVVFNKUVJW.P69FKI6IF3ZN@suppilovahvero>
 <da435e0d-5f22-fac7-bc10-96a0fd4c6d54@kunbus.com>
 <a84c447f-cdfb-d33c-62cb-bb5d9aa8510b@linux.intel.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <3d350827-795e-8277-a209-1c1d33ca57fa@gmx.de>
Date:   Mon, 29 May 2023 15:15:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a84c447f-cdfb-d33c-62cb-bb5d9aa8510b@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kAcSttoxkC9xo2oHSAhzcgKLH/CodN48oC1e2M0FD/QHyvQFebr
 KD+eGQ/3x0osnWrZZI24HyqO+Ee2pdysNn8NJQ3OTgpTxIhVXyEYKCfChhkGexEPCR1OIEQ
 eszUxoCG4Y6Ykc/wVQH5VewZbPqPa04ZJa1efzK6sznljjEmYZVSDDtTr1mvNE+KyGsqD02
 zOVzGMg0Kd32MOr7WumkA==
UI-OutboundReport: notjunk:1;M01:P0:XZeSi5CFdwM=;WfL+f6QjOGAY/TuqYU0iIjYHeeh
 4ExgUmkp620vrAq0DzhfaGRqx2EVXg3HBA4LAa+FpKiXUldxuIU7LXCRX6xFD9zosMA2zRylM
 9qW2qo+PJTix7aQwJqVn/HmWazbRqMYFkCf9jQhWTSjxzrhWHzBk/n7R8e3EdNaRVxW03z2A0
 e2lLEke0P66fB5nmfsGqYG0rtA2IaO2DmdAUiDkDmrsGQ808tt96ui/at3whpKV+vHbMywYDs
 9bQ3nECXTMQF/839wMsIozf2I0rYlsE3/c+bfN8iSlmZUD2deMouwLA8lW2S49C9I06UtSUhX
 IEVoGc7pf4LUvabk84GABSV99eoDEQWKoDKkRITvHCptJT/m/YsrcERQxdulNGnEr7BKVRhFc
 tjdHNuUAoK3RXglRepgNlhecG7H58SClQ8KH468kIQezbfIv59CddQ6omIw8RFPKdFNUqyF/w
 tRKrENr1RZ0f9wYqHBP4XZ59gp7FZg5tJ8ps+nnDKx2NOxCWaegPgaSZ+LyZynyAHpro9IF4N
 QhXCS0JFCJGDwIXKOLVI+uVMR6xO/zCW0PJ4hBQ29+GoF+VcxVGtMd8mLredgCeRVvdiKc7Zy
 xxaXpjlrMUcwZt+Jf1101S7kf5gnLakc7Ztpg378aBEGjORDTnbBuOHqoHLHAncUdT+2XmXCc
 V8WGx78X3z6DcF+ay0rhfYq12S73shSuq55TQelH/EmZ5soGAMsDhbvw4XPhiIjHXOaVdMuKy
 Y0QNlfs2B+nigd8VAxL+zaMFwrII6pgxheFnzVZYHHUhP7Gg/SLyDhF4HxfRb8LXa27y7vh8s
 1KFt+WD1Y09lhVu2mgurfqa5nlvRfKDWZ248kMRQDotKBfSibrlY5GC1pH1o4rxkpOEZ645DP
 waYsFZGxzuyE/IL4qUoPe0/0TYOzSXvgzzqeGp8snHrxdJa7tPb1nMPBKPUfgh6ow15/BoWtD
 +vZSPoFOuPkzSUhFEepUDDmE4XQ=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi P=C3=A9ter,

On 29.05.23 at 08:46, P=C3=A9ter Ujfalusi wrote:

>> My hope was that it could also avoid some of (existing or future) DMI e=
ntries. But even if it does not
>> (e.g. the problem P=C3=A9ter Ujfalusi reported with the UPX-i11 cannot =
be fixed by this patch set and thus
>> needs the DMI quirk) we may at least avoid more bug reports due to inte=
rrupt storms once
>> 6.4 is released.
>
> I'm surprised that there is a need for a storm detection in the first
> place... Do we have something else on the same IRQ line on the affected
> devices which might have a bug or no driver at all?
> It is hard to believe that a TPM (Trusted Platform Module) is integrated
> so poorly ;)
>
> But put that aside: I think the storm detection is good given that there
> is no other way to know which machine have sloppy TPM integration.
> There are machines where this happens, so it is a know integration
> issue, right?
>> My only 'nitpick' is with the printk level to be used.
> The ERR level is not correct as we know the issue and we handle it, so
> all is under control.
> If we want to add these machines to the quirk list then WARN is a good
> level to gain attention but I'm not sure if a user will know how to get
> the machine in the quirk (where to file a bug).
> If we only want the quirk to be used for machines like UPX-i11 which
> simply just have broken (likely floating) IRQ line then the WARN is too
> high level, INFO or even DBG would be appropriate as you are not going
> to update the quirk, it is just handled under the hood (which is a great
> thing, but on the other hand you will have the storm never the less and
> that is not a nice thing).
>
> It is a matter on how this is going to be handled in a long term. Add
> quirk for all the known machines with either stormy or plain broken IRQ
> line or handle the stormy ones and quirk the broken ones only.
>

Even in the long run I would always prefer a generic solution whenever it
is possible. Quirks are fine for issues that cant be solved in another way
or really require individual treatment.
While I agree that ERR is not a good choice for the "falling back to polli=
ng"
message I do not have a strong opinion on whether WARN, NOTICE or INFO is =
more
appropriate. Jarko seems to prefer WARN.


>>>> Detect an interrupt storm by counting the number of unhandled interru=
pts
>>>> within a 10 ms time interval. In case that more than 1000 were unhand=
led
>>>> deactivate interrupts, deregister the handler and fall back to pollin=
g.
>>>
>>> I know it can be sometimes hard to evaluate but can you try to explain
>>> how you came up to the 10 ms sampling period and 1000 interrupt
>>> threshold? I just don't like abritrary numbers.
>>
>> At least the 100 ms is not plucked out of thin air but its the same tim=
e period
>> that the generic code in note_interrupt() uses - I assume for a good re=
ason.
>> Not only this number but the whole irq storm detection logic is taken f=
rom
>> there:
>>
>>>
>>>> This equals the implementation that handles interrupt storms in
>>>> note_interrupt() by means of timestamps and counters in struct irq_de=
sc.
>>> The number of 1000 unhandled interrupts is still far below the 99900
> used in
>> note_interrupt() but IMHO enough to indicate that there is something se=
riously
>> wrong with interrupt processing and it is probably saver to fall back t=
o polling.
>
> Except that if the line got the spurious designation in core, the
> interrupt line will be disabled while the TPM driver will think that it
> is still using IRQ mode and will not switch to polling.

In the case that an interrupt storm cant be detected (since there might no=
t even
be one) I am fine with adding a quirk.

>
> A storm of 1000 is better than a storm of 99900 for sure but quirking
> these would be the desired final solution. imho
>
As I wrote above I prefer a generic solution whenever possible.

> There are many buts around this ;)
>


Regards,
Lino

