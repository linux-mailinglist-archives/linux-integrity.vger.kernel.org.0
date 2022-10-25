Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A501360C0AD
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Oct 2022 03:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJYBNo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Oct 2022 21:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiJYBN2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Oct 2022 21:13:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE5E1C843C;
        Mon, 24 Oct 2022 17:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666657540;
        bh=2a8mkpddzspnTrIRyjDTVLJRXQkyLPiHPxjXNUgcIig=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Nn03TyqkZwxFAMRG2uTBWXVv9Lo33w+f6OjH+DOOW7PbqgoI2aSAt5l88bd7of7vQ
         uQ1WS3tHByaOWgl2LfBz/m+qGoMzQeeAh2HF+0hw8bLJbMoAraw4YM5d/qOzNUeYQ2
         YgAEIonfljkyBRRmGfUww/GEECCHNl10IQqeQ1pU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.83] ([84.162.5.241]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4zAy-1pCahs2HuW-010vAv; Tue, 25
 Oct 2022 02:25:40 +0200
Message-ID: <0094438d-cf8e-da81-c969-119f90baf3db@gmx.de>
Date:   Tue, 25 Oct 2022 02:25:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v8 08/11] tpm, tpm: Implement usage counter for locality
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, jandryuk@gmail.com,
        pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        p.rosenberger@kunbus.com
References: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
 <20221017235732.10145-9-LinoSanfilippo@gmx.de>
 <20221018062508.GB25237@wunner.de> <Y1TQiIw0m+8BSzMs@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <Y1TQiIw0m+8BSzMs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qQ4IHt/U6ocipV4Dxu3NbTQMjffawFWFuuca3MhFEIpycsYmc8Y
 cBPU2xrVt1CrHtsHZQrz1DU7c/i50Ws+CIWbDPRIoDfbnaI1BBvOCbRjH57FIgIGp6SlGDS
 80i4PNh4fCqNam+R9rZAZnZzpVzAYXxbm/URStLrytAZNdM/VdjfALkYaAzIVFC/S+GH4PO
 Bw+aBKllTYCBUcHT+NAkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RYCmhr6w+Nk=:dj9Ek1J0oIBVP5T8p2S9Pi
 TkWcgj22dK+QSwLUD8/d+L92rXf2Lr3JPQNnm5Rxkx8kjhpuUdBoynxV89KhCLmP4PVDLPvyo
 XnoXj4c/quQHwz6+0HEsmmqHgJt3E2ZY5pUCEfJTEz1F1qylIikCPInY4LmhWz/r9P+XECBW2
 BsmxoTpKPm+YGRCtWinBJkU/HRiP1vyKiPwGLNFoRdet7M7lHQ7d5JNOE80YFBFANYP5D1Sje
 STdI70JaWowqRganf9RogSHWfBig8ZbR4N3AV2ZOpdQKCyPAp4qNu/kxk7vcxjLrfp5mXdNq+
 JRHlWzNRYwYKKlBoTHMR/Q61lyQRAUSlsSFnOE1mekzycKjs2r0rXQZUFkvrfNmhLIYpP9S+m
 VOk5V4B3FCVmmuEIvHnkqF3ZL+utTBzvtSacMRWJhkyqwrLhXHdpB+ycrkFJ+WbmiWN9GvA6R
 b4Dli7LRXTX0i7mH7uF7QUv1FjEDZfNU5TulNU1GH3QIiphg+GajqDTLFjMrRjWdyGm5z4bJ0
 abdqCEZ5VKl7q3dWpdHmXFZabDcCshB1xHUDj0IKQNXDGY9/DsMcL+cBtIVfN/GqCRdF0+Vn/
 adI4pPhJa7wkV2kmUlRzLdKLzZTMLniDjRt4m5BgbzPzhfBCUQ4Rsyha6OchQRX2zw2a1mrEq
 3iaDJGz8cUFvWSGpvbHNFLRsib9mWxS0fSkWGboLZs+MrJ5X+1BSsumvOzJU9QN+1k3xp2Xq2
 COm0vqq/MlGuni+NWXW2OGCkC23jAMxru4W3fTJYuHjCz2/IqKGSLr0/4iCPhs2tLO02mSgYl
 0Q5M0/ETMzCbUWg6P2HIya2M8MRplZJTYeLj+U2g74IN/3cEWAgmGopxGfLuzmb9obW1AeiMq
 z+5M3YVngvTOhLLzaI88sLOggIcgXSHP6pZo2jKOtcPwrdUAEI4vC7sdjUcwMM71YxKBhrzcF
 NlZrLLj4JmFYiZzI3QdDw4/+GGLgamKKiafTCxC9CxpPHi38yHNCP5Yh/gg54iEYto3xec2g5
 VxHn6TgNZ45v/XvpNC/pxUeAMbZwRBg6YtlbAJhvv8kQBfIGcIV/Q4ii44hgjj0IDm6Ayo1gG
 ybV9krKEF8orzwmEI9a9DuVpezJ+mAQwg/7dngXBO9hgzCQ+/G/ISNSXx7q3HZGdERBIM4mHC
 YUHxzlSOTzwAJ0DIfpGcE3b/mJP5Na1CF3xXy+Ifl+ObNN+PTi4jK3bd6owlxnR3eWZ0GI7ph
 5avTGnX3tqme3IYM8ofknyCUIFYDR+QhGOEhI7EgblYxacxBreYR2jtevfoPUEJH84pbddLKq
 oFF0kGlofw2FmHiHQLU+BXItOKpEkbM1wkmdeSGy9F514Cm9mmr5mEZtA2bsUe4cdbb8GeDOU
 TnRXymWPOiqUnlEXvMuv+OXbk4blqTxPSmgRXulvsOg9f+/zmPCx6k226OlMwXLNh44awE2yE
 8poAZSoeO+dhZT3NqxknLC3dgpR5DGF1t5JAS2k6fgdiiEL8os3Y8kngDTcC03WDp/IfJFWoE
 sdtKH0xiaZR5pvwbxE/qWmr9s2EhHJXVUanpC6VQ83VnD
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 23.10.22 07:26, Jarkko Sakkinen wrote:
> On Tue, Oct 18, 2022 at 08:25:08AM +0200, Lukas Wunner wrote:
>> On Tue, Oct 18, 2022 at 01:57:29AM +0200, Lino Sanfilippo wrote:
>>> Implement a usage counter for the (default) locality used by the TPM T=
IS
>>> driver:
>>> Request the locality from the TPM if it has not been claimed yet, othe=
rwise
>>> only increment the counter. Also release the locality if the counter i=
s 0
>>> otherwise only decrement the counter. Ensure thread-safety by protecti=
ng
>>> the counter with a mutex.
>>>
>>> This allows to request and release the locality from a thread and the
>>> interrupt handler at the same time without the danger to interfere wit=
h
>>> each other.
>> [...]
>>> +static int tpm_tis_release_locality(struct tpm_chip *chip, int l)
>>>  {
>>>  	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
>>>
>>> -	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
>>> +	mutex_lock(&priv->locality_count_mutex);
>>> +	priv->locality_count--;
>>> +	if (priv->locality_count =3D=3D 0)
>>> +		tpm_tis_release_locality_locked(priv, l);
>>> +	mutex_unlock(&priv->locality_count_mutex);
>>>
>>>  	return 0;
>>>  }
>>
>> Hm, any reason not to use struct kref for the locality counter?
>> Provides correct memory ordering (no mutex needed) and allows for
>> calling a release function too upon reaching 0.
>
> I proposed for last version kref. I have no idea why this is still
> using mutex. And now I apparently have proposed rcu for the whole
> struct (forgot what I had put my feedback for earlier version).
>
> This keeps being confusing patch as the commit message does not
> really go to the bottom line why mutex is really the best possible
> choice here.
>


I actually tried to implement this via kref but then came to the
conclusion it is rather not a good choice for our case. Please
see my response to your former request to implement this via kref:

https://lore.kernel.org/all/09eefdab-f677-864a-99f7-869d7a8744c2@gmx.de/

Regards,
Lino

