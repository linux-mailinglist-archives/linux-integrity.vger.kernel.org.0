Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18F8565D2B
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Jul 2022 19:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiGDRpb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Jul 2022 13:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiGDRpa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Jul 2022 13:45:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E446FD5;
        Mon,  4 Jul 2022 10:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656956716;
        bh=TQ4lBTrLpuo+eOz6EySprVM5Znbg7fuRxnxioDxOg14=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=KdSpeikfbSf3EQvihQEIF7SS8Ku4HT8j4pwvPpvzdscJiSTAGpcBNw7Keo9Mzuthe
         6rGLo1KQU+SeKl4fjXkZ7r0Pjb89kEesrFMcRj3K4woHDhKoR78JojJmsU0y697my/
         UYr0I3hN7/fqKcmPWje1pgA6VUU5pO72cHt46wIM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.69] ([46.223.3.210]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpNy-1nYoCU1GHi-00Zuiw; Mon, 04
 Jul 2022 19:45:16 +0200
Message-ID: <f0e33bc4-335c-322a-9295-18d6bc0b8286@gmx.de>
Date:   Mon, 4 Jul 2022 19:45:12 +0200
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
 <Yr4x6KRSvzlXNdH2@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <Yr4x6KRSvzlXNdH2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7NEXJUNaT6KySY/atP+dQn+HYXS4nNzYgcoi8I8faZCB2VCxL+n
 yJulzOSntGDyPF4x/sqJy1J/rMK6r8TXz2h9Sge/BlwpsIPea8Vv1tvANcQA0MZTOjKR7I4
 QqP4x4B191n3TVgy3bBeG+m5PAOWg6e+ZRS5l8f40DXk6WxOuVGO5Toszy3emCPnoSLaADa
 fGLWpUlMq1Vn70JOOej7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zQEcDyYnCbo=:CohU44Go8P38dFklNt1xAx
 i2sEaBRJ+kMTHJl0QXkQIMBsp2JqsM8O4ow9cVJ8iMxy3al9JX7AwlOa1SQtTLoQfgAr2Om8I
 hes53IsJXO8BpiZXBQaynG0OVCyUaD83Uk8dyQiePxgV9j55qvruUKGjMZN7rA6LsmgDduer+
 0J3ZzZIIbbNGKL8wBy/To+N5RJ5EuFYsNH0sQwudOoSX1/LuTaX9ZrSD40ZSN9LVo/0TRiqzD
 lwzdBA+BlWOXtiwyN6kYT7h/N5uGkbwjFquPfTEyMjN04koittlS/M5jlIN4rMoT14EzjAGCj
 FsQgNhrvK5DS7FEyXGK+q1AboHt8suvK07fFi1bwtA8h0lqTUBri+VdqCwnkAT03Rzb6z6F0n
 VGh+hKz0gSjFH6jmbg3xFiqNf/5+87N8grbInyE8cdnpvsHYwx8NAJ8VncaQPIR+UdaHSSVSA
 r/7Djlyd7OuuXlLx7ArLYG5+S0/z1glrMygUkJO3tG/WSdc1faX8pgXaMXaXW82JTRPMlOVv4
 3Hrjte4f4xCShJCzhBaTsufFx5EaiiSeMl11vOVZFzzjSUVWpycG1BCAAWLW2XzmvHz70E9sx
 /oR6Nbj6ZD9m3CaeZj91c/PerBSpiR6ixw5BKfzFet4xoJPknajniKMKh6DxkexdW851Bp38E
 UnYBQTHk1grHLS+/zSt5kicdYuE8yRj335enTcOIGxW8GR0Ck2oRAIW6l8HY0aTYIVgVvtYOc
 bxR9ABt0kbxr7F/+dD5FxHhhF4ry4hVNDKcGZbW8fK2rrgBpe4igMdHyp9yypZDpWBdlsceE5
 8T5CQPDJH44mjIh25KtHH33vKt2ST+Mc5XmK9RfX7b8+Sh0iF/zeNBVuspTAPqMygs9nmxPxM
 FUEly1NjnLfDt8D/B0WfoFCCoJrOqd2MWuriarjwCezfqs/+62lmBeXtMKJ1j8hvfOSiQ4YD1
 iFKo0dIG+rPFfHi3hVPBS6EFgz8ZgVa0EC9CczEl+WdWF/2Ku54U3qMT+C2dM+QmeE0wwktpN
 KsH9FDR24qO+rRzPL+vANigeZRgJTgImA1HMoFUlhKAAeK7xIAznKJhjED5XKjywLfVpkOEWt
 4c/vswxXu20Hgyx1Epi6bqBJom+Kx0IZtMfpF3BO9M8/4o89lsYDkDTYQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 01.07.22 01:29, Jarkko Sakkinen wrote:

>
> I'm kind of thinking that should tpm_tis_data have a lock for its
> contents?

Most of the tpm_tis_data structure elements are set once during init and
then never changed but only read. So no need for locking for these. The
exceptions I see are

- flags
- locality_count
- locality


whereby "flags" is accessed by atomic bit manipulating functions and thus
does not need extra locking. "locality_count" is protected by the locality=
_count_mutex.
"locality" is only set in check_locality() which is called from tpm_tis_re=
quest_locality_locked()
which holds the locality_count_mutex. So check_locality() is also protecte=
d by the locality_count_mutex
(which for this reason should probably rather be called locality_mutex sin=
ce it protects both the "locality_count"
and the "locality" variable).

There is one other place check_locality() is called from, namely the inter=
rupt handler. This is also the only
place in which "locality" could be assigned another value than 0 (aka the =
default). In this case there
is no lock, so this could indeed by racy.

The solution I see for this is:
1. remove the entire loop that checks for the current locality, i.e. this =
code:

	if (interrupt & TPM_INTF_LOCALITY_CHANGE_INT)
		for (i =3D 0; i < 5; i++)
			if (check_locality(chip, i))
				break;

So we avoid "locality" from being changed to something that is not the def=
ault.


2. grab the locality_count_mutex and protect "locality":

if (interrupt & TPM_INTF_LOCALITY_CHANGE_INT)
	mutex_lock(&priv->locality_count_mutex);
		for (i =3D 0; i < 5; i++)
			if (check_locality(chip, i))
				break;
	mutex_unlock(&priv->locality_count_mutex);


I dont see the reason why we should store which locality is the active one=
, since the only thing
that ever would change it from 0 (i.e. the default which we use) to someth=
ing else is some external instance.

So I would vote for option 1.



>
> I kind of doubt that we would ever need more than one lock for it,
> and it would give some more ensurance to not be race, especially
> when re-enabling interrupts this feels important to be "extra safe".
>
> I looked at this commit, and did not see anything that would prevent
> using a spin lock instead of mutex. With a spin lock priv can be
> accessed also in the interrupt context.
>
> So instead prepend this patch with a patch that adds:
>
>         struct spin_lock lock;
>
> And something like:
>
>         static inline struct tpm_tis_data *tpm_tis_priv_get(struct tpm_c=
hip *chip)
>         {
>                 struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev=
);
>
>                 spin_lock(&priv->lock);
>                 return priv;
>         }
>
>         static inline void tpm_tis_priv_put(struct tpm_tis_data *priv)
>         {
>                 spin_unlock(&priv->lock);
>         }
>
> And change the sites where priv is used to acquire the instance with thi=
s.
>

In this patch we need the mutex to protect the locality counter. We have t=
o hold the mutex
while we do a register access that requires a locality (to make sure that =
the locality is not
released by another thread shortly before we do the access).

We cannot do the register access while holding a spinlock, since for SPI t=
he (SPI) bus
lock mutex is used which needs a sleepable context. That is not given whil=
e holding a spinlock,
so I think we have no choice here unfortunately.

Regards,
Lino





