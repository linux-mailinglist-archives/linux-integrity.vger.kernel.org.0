Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228F4602609
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Oct 2022 09:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJRHnD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Oct 2022 03:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJRHnC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Oct 2022 03:43:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E0536DD9;
        Tue, 18 Oct 2022 00:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666078922;
        bh=9lQ3c21/dV2FzwdL7z4S9pE8ufyt4NxvrP77mf5nnvw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DIufbi9gKL2fRWPU54oASLbY1JtHeg/On4z5OkIjGFeDVZNb3tJUpvgLOaqt0f4Gm
         /ZXjXnUSOo1zqj6wLFhPSnnwtMUXjV9neIIpWhW2DJGRLcQObkNGY6vodW66HrIvJO
         zUqDGG9WhRp0Rr1D11cXKKkHnDsf7Mszmf8EW+ww=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.46] ([84.162.5.241]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLR1V-1oSkyf2fdz-00IQzc; Tue, 18
 Oct 2022 09:42:02 +0200
Message-ID: <3b768ce9-085a-220e-6e9c-154cbe44475f@gmx.de>
Date:   Tue, 18 Oct 2022 09:42:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 08/11] tpm, tpm: Implement usage counter for locality
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        p.rosenberger@kunbus.com
References: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
 <20221017235732.10145-9-LinoSanfilippo@gmx.de>
 <20221018062508.GB25237@wunner.de>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <20221018062508.GB25237@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lCVFtOoqDbzmfsxfmDZwaK8PlSks6PrDY2ub2oJa6d4iRAUVzJ5
 H4JKZMwuNIg86+/+6H5UuqixPY9ECP/TQ9ikq5C50bWTPLF2Sb+TfNRc2iyBIV/dqiCC3AL
 SrOE0AQasKeq3fNVu7PEYdVtW6BXPC3B6eQHqn9+FYjP4iOMg/muQfGZ1FcQHGIs7kmw1db
 yOmBW8SfrfmVkym835syQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QHHZQdOwWoE=:w+13iBpNo5DcSdrSXyeB27
 ULjzb2BII62ByJiW+Yvtku+cRV3Cha5RDrpkLYnNcnEP/p7nwo7nzsohVRhKB9Zmgz0XsUOOj
 5gwYYICnTSAFjgdKZOu9kg7o3PABFloDv6hbbI1JECugBn9ZruVfo2c+UotNurGC1fsnXmhlr
 /lzE47NCcynpgN6dLoRlwU+72dAYJyhNyxe+6cE0V1evx8W442ZT7riDQWN9mdE4dLtmDGoY4
 lfwz2IN+xzKFg0BfVxwmvhMqxsP0uMBOzd5M6ESjZ/qKGOUdYp88lJioo65+lqUb8C3fj6l/9
 lRaNHyNTe1Uq0jmI4V5AAQGmyCAWp3+0OlZT0Qh81zZOzfnOZ03kbQKLLt+5fm7B6k0HK88bJ
 9YZ+4wcgkoCn0/3Z4oyio3FjraoRS56hm9YoT6gS6IFxu9SQkPzunNYgLYoigRsoHHbuJNJ9z
 DdSonuFd95I4clIDG/AYRCoByqRFaVM6t8jrfEbOCJ9o+Udg64v50K+EL8StPXyGz0lMQE45y
 8vZj9M005oKTVoRhjJj8lV3MAQMXPCODOTN/O/+yj2/3laASQRQJe+JAdAVdV7RYgd9lamOkc
 35yjyoX4pwq3C3XYehc+lWykFAcyGCBwmxcQuojm/mfrBb3iq4M67Z1fegMmzk9czU3D0FvR3
 TkwFPJ7PSWYD2R/YSAwQdEYjozL5MZ2zdNdUPefbYDQgShivicNpKniMX3WDopvOBzTHU4dbd
 9E4JdN76daood2f4mERV2QOg5ERyJFXvE5rV10j42sjCFfbx6MKIN+SxKBXSxGgbB1POBC78i
 Qz5wqeW1T0tcbkrqO3AijsYNr9P+z1rtyyIu6Uf1H2v0diIh0BX4LqKiEv6cljqY5hbxH/aUk
 uw3WtXy34CdLsVuLvpmUyJyOMbmTxqX/aME2Q++SzT6ImpP735jnKpN/50HAEE7OE0XWZ9x6U
 T1Co5iFIc1DwQ54oxkfzrPRxXUBgqGv3MoklZZodLdTBI9Xe5uK3cJuA/1acoDkY+l0i8dyXK
 97MD6Aex35RtGvAslitITQCycIVu9yQODGshuh/rA0UPQ8ulJoztm209D6apnvsSGQbrHI83P
 K2tRwjjginePU9NKwlwGdSfkY9lkbbT9ZIi6JIxO3kZCPUR958cDs0mapsuN3+kAz+ntdXeEh
 srrALtkomn8WMlO73vWdYwSnUXnOezSJZ9RE/UlY1ho8gR3lEV2BoDIPy8dqURtkbPJWci0Ts
 VzpfCxn9563I7Rd4xOJomd585Eq2mm/bbeUzjOFg3ymZpTaEN8GaKnox8u0jXuH8WRNOydV78
 xisXYK1VlqAYE2qraU/NVpKJ3Ncy5CwejTIFOcXbGNgQrOf5ZIpjAbpeTYEFA7VTcP+NbjO/d
 u/nGkxo2YKmKx0Myl0XjgpBTkApiXbzXytvIrLeDbvUISqWDyqMIbE9bGGtah+jHR4WvNbt/b
 +GhLF5ir1+zfNqO3f9Ff1abC3rB3dBOx7FH/fhIt4Zlm5XMKgK2QX7XVESblIwHrMCgny0uMf
 qT+OgBHPnAJB0k9XHe6gFrC33O6GYhQT/gnyIjq3IFceMhsWwndIq43iXT7uFSlyMp/NrPaQ+
 QUtmAIsqyqBCBFOEH7r0Z2SGvFLZq3WaCzDnqn0Fp//j+h9nNBEy4h3K3fl+DkBY/WuwXIToA
 Aup39gxGTbVc54jmYYi1B2irnABHyV33Ez8P9hJfTbIGToQ0Q==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 18.10.22 08:25, Lukas Wunner wrote:
> Hm, any reason not to use struct kref for the locality counter?
> Provides correct memory ordering (no mutex needed) and allows for
> calling a release function too upon reaching 0.
>

I already tried this but krefs turned out to be not very usable
in this case. See my post here:

https://lore.kernel.org/lkml/09eefdab-f677-864a-99f7-869d7a8744c2@gmx.de/

Regards,
Lino

