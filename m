Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5646836E1D7
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Apr 2021 01:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhD1WpS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Apr 2021 18:45:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:45645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231161AbhD1WpR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Apr 2021 18:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619649860;
        bh=lfM0b86QVJIiTK94KUkJxH14cAx67lUsiW8iyt1m8tc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kYF8wFz3BKylx31jyeBXSgedk0wvSNApEIkkmfm2xaeAStFz+ZFZYswD0mJfHtEO9
         CpzwlaRFcC7x6MBzOipbyDxokM8xBNPufXH31dIJ2cnpIVo0t53uCB4jTyDyys68wg
         TiC2pPjJX5h/voLHERYbcFGOPsmJras7z45ybYjg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.51] ([78.42.220.31]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2V4J-1lS1e72tTT-013sbV; Thu, 29
 Apr 2021 00:44:20 +0200
Subject: Re: [PATCH v2 2/4] tpm: Simplify locality handling
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com, keescook@chromium.org,
        jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1619394440-30646-1-git-send-email-LinoSanfilippo@gmx.de>
 <1619394440-30646-3-git-send-email-LinoSanfilippo@gmx.de>
 <YIii8RQR/Mcc7PKJ@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <bfad2da7-dd4a-4d63-88cd-6b752265b736@gmx.de>
Date:   Thu, 29 Apr 2021 00:44:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YIii8RQR/Mcc7PKJ@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uPlEDioHHNt1K5vd/2y57LTMHv1gbS4MxIM55pC21O6l4O3XQIu
 C3Xt5eBYZ/uwkedGTGWwEOXw8h4rzyayHMz6KXNgpgAWbdIe1s4b9IP3hsHv4up3LaDq7+3
 B70onVyk1djhadkjwcye4mWwb0RZIJipoqbnFUYKo9EPQFlFzZ/hLlmVdzn9X8PdRhqcSdk
 d8AhbhDrhdp7cBqbfHVVw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qS5vj4p5im8=:anq5/meDncc3PHRrphEGoJ
 BEZU95dPs989SBa6GpI3Xq+eRxZyQBCcrQLxBg/ywBd7XZQGVpOkbxEVm/LutylR+Rxn7jykK
 EB77tltVgKH2edofrBXtyT9+/v2pfbiKMk9mlwbqCuGeoj1IYwHIhZLqqlZYH0lny9DfEYG6D
 RRYq5D8axUczt/ZRLkgEuTrPGg+cIuifXrgKhdVKEgehwoFFm3oyzEn2TRSdQix7ea/tAojQW
 BOQbPLcQT/r6K7rfxkP7bSnAgff+rXmTMoeDiyXAwHKItXOdN8yubfZiqvnIZ8lCj/us8h6u2
 hIvNdVS5OerAcadgZKWjrtS/nchqkp7GEEqpofKaZ0v9CZ3XvK8FDZrPrB8Nd3zuqtJ/rKRkQ
 pCnbLRJJSalHlsDGihqr/fbotS0FnfiTJQi2lIacjkWK6VIbmVvk0L5Kqlv+wv19MBdnE9h/s
 ZD8IHAbF6rEmoPSOne+K/ix13xL/ZJAIFWjmdlOIDSmHI21fxu/1An1ZtHAPLxKMe9kZH8cGL
 TOD/zrVS0utmiXNb2VGPS15iJH21svcK/JKH76oBDBsU6QDdQ6wMfkwjulUMt+Dklc0MZdMxs
 w+padv/QKMLI1K3ieECUxBI3cNlLNEm103C7l4C9Lja35LMP9UFiFR4Svq3FqsVs8SxNRT9aM
 hSyurcW5aknigtzI9NLHV/OxBoHKRl82v1q2Kp51r/bFFIHho2qiaSMO5bA4V1Zu8BsVe5F8n
 8/zzQgphzjSunysqpYWp7f4a4LJ7ICnE4Bs7LWfYWOEVF3PDRfTYGiHEm+7zWD0NIf8sqDSwY
 9rASgsUJkUDMtNBKlYJgDx+iwy8aegeK5UypaMOWansPBB+lMN5bk0UHll1DmoAb148IO4+Gd
 4sDinpIXxkZ/u2we8bjHBtGj9MubOCU0kRZS/Y4nF63jydtjbwYz5Y8enpm8eszArNqAOIjau
 25vDW4uVWQ7dkiGQSBz4BHEn/jDP7VBcDFpqQ2czrtonqRj9ZWbesl3atcFvi90ZjTEvRHNu8
 RQ4Lhd/jY3CarmnlT+RC196g7e/L3DujqBmQ8GhVFhOtrp8kKboG/NZFp7VpSwJ1gYWB/+dlB
 7PbSV/L0yTrlXMWW9BGofQVYh8Nwq996GNc1LOf3IUft421XcdaCKfcrSA2CQ//28NakGGSzd
 lvvyVLS2s0jpWLSmqzZf18g4h+HSW0F81/JX3LxBA5x99us8Dw2Wmfl03ZC+YhQZETKHxNXA/
 /qmkBkabxJBDbxw55
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi,

On 28.04.21 at 01:49, Jarkko Sakkinen wrote:
>> Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transm=
it()")
>> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> Hi, what hardware? Just if I could find something comparable lying aroun=
d.
>

I tested these patches on an Infineon OPTIGA SLB 9670. This is an SPI devi=
ce with
TPM 2.0 support.

Regards,
Lino
