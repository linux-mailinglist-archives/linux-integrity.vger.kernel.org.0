Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C8037328E
	for <lists+linux-integrity@lfdr.de>; Wed,  5 May 2021 00:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhEDWzt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 May 2021 18:55:49 -0400
Received: from mout.gmx.net ([212.227.17.22]:49837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhEDWzs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 May 2021 18:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620168879;
        bh=UGACqj9zwLpHiYaYzndwkzcnLYYo8OQpEl5bpb03nUY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QrzkwocH1shzHdAziK/FiWMv5dXNeARanAK8KOPiiaOtuy77LPSguGAHtmN3O+0pJ
         cSQRin5GdhE2m0c0xQ6S+PV9bnTooy1Petyx2P8pPmfmZEYrvz1xvkPaH+lT+C0pNs
         7Xv1pheu6X8e/L9DK6+KEuxG/IwS1k7g9UyS6xrk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.51] ([78.42.220.31]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDNf-1lCjar3tzr-00qjG8; Wed, 05
 May 2021 00:54:39 +0200
Subject: Re: [PATCH v3 1/4] tpm: Use a threaded interrupt handler
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com, keescook@chromium.org,
        jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
References: <20210501135727.17747-1-LinoSanfilippo@gmx.de>
 <20210501135727.17747-2-LinoSanfilippo@gmx.de> <YJATRNMqzyAprCbL@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <1364a268-7173-7253-543e-792ff2104e98@gmx.de>
Date:   Wed, 5 May 2021 00:54:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YJATRNMqzyAprCbL@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/Yi5u3KSyC43Lm8q9HAiLF27ChgGz89lz/ljAulxigSKRjU8k5A
 3TTWVb+7xOOVpuvnk1vvSY51dODT2dIvggDWE27SqOvF7DBN0TyKu9ZooVRN3ZjEuCdIpIM
 EPBQximc3ZwX8/VdsN+uQFuiEIJQhb9XQeq3RZ/o0tYWySqRmZMVQC/VZfhiCpdcoktnH1I
 pqsfQbb/4kdpxIvBS+v4w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vNv6U7rmw98=:wPkkAypu6Ivl3IX4nzNzyT
 eRZEtnQ1wSi7MRdcVtgskiXXzGoPuPBsxLeIFvdvMEy/PDCPPvOHTUDHmQjTNc83gmXKXgsJR
 nCQuImCeoftz0ZO34yNS9Lji/eBLJcwFeayCeA3zD2MXlkKrNCKRIQT55dfdk7FftsDEgm05G
 BHzhmESPeQthBODzrzR5BxUfC90r+8jznl2wItFXA13RyBvS02jMWUGOVJ4IC5UFBJrEA6sym
 bRYb+am4WSnlWHl83g+X2oil1PUlZ0Fzg8C688032UksTyy8PfSDJIhqKiUL2D+KDslseXW3n
 jruwmTQj/Ox6zCJu8Q81u3zKpNVIfwQ4NA2HFMEYsjXu2S8PDOSUWylZdtf4RtwtnTAnk6Pxy
 Y1DXZY6DN9ullIcM53/E/zTntwD76KMzzzQUqA3EVuhlA8wSmlTXzl1/8AZuOv4J808lTVXU8
 URnGHVeHvWNHICQtRMGXm87uaNVRcKaXVXg9Sj+046wAqAl88zzYQ6sZO0+porERn3eke8i+M
 ckisbyk1ewk8iDUrZVLBPHEfi25OS0hUBzPUPV946+u7oFrwqUR8gwDnbFOCv2YYZEcLBCj1m
 CD7cIpVdxHCDeo7m7jeBlnKoIKHeshGZRJw9P3izIxzxNxp0hycAU+sD9RALTNfIX9rOcAQ9l
 B3bnSv8ikFa/Ua5N+qwMRH5BtrGIWMrOvR290r3AKd8QPCAwXmrBJ8mH4cgIS1jgFeRoeeA1M
 QCVTBsqISkj6QlbBGcP/4E4AqS0pukTQAVsl+jWQbyGzKLE7DmyZgOX/hQaSBVKfTiPv8Wj+7
 pq2ruLJWfRCSeg/ZP614hpsa7D5ryFtpzHabZIjnR9K6d4BwmvJIhPJNp7LA0sQgPXnUcX0/a
 Qi9KNJqvrlMmg5IIFepcHskkNHp5QJOrvx3nhSOnLwUkC0Zg4EzL5syHLAWa/NQq1FB5+eZW5
 0c+4LxW+RpHGsSNsXe+IY3O1XeMY3oKS+aE7Ji2vTZP9qXT8t+5LXwRx55czH4r/+kixQ7XCr
 PFI+kAtoDPx0XuY+1YX/kC6W0mNnnF2cJQRt02gUcEp9mpVnY7we/5hjpXnpcANSQvluuKz5a
 2SnDYp0ruTiThaP7LX05tew7X7jxI+D4rs3qfL1k9bZuDAySaUevI+O3GMPXZuV+wbwcQC2Kb
 3BiPb7jimX5zzqkQCKdNHf1fsGHistkFmQsyl+gUDN/Uciba02lOu+SIDt/u7ZyO2eYkw8UBj
 4to91MpQ9J5tbazHY
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi,


On 03.05.21 at 17:14, Jarkko Sakkinen wrote:
> On Sat, May 01, 2021 at 03:57:24PM +0200, Lino Sanfilippo wrote:
>> The interrupt handler uses tpm_tis_read32() and tpm_tis_write32() to ac=
cess
>> the interrupt status register. In case of SPI those accesses are done w=
ith
>> the spi_bus_lock mutex held. This means that the status register cannot
>> be read or written in interrupt context.
>>
>> For this reason request a threaded interrupt handler so that the requir=
ed
>> accesses can be done in process context.
>>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
>
> No fixes tag.
>
> The short summary scopes now the whole TPM subsystem ("tpm:"), but the f=
ix
> is targetted *only* for tpm_tis_spi. How about "tpm, tpm_tis_spi: Allow =
to
> sleep in the interrupt handler"?
>
> This also changes the semantics tpm_tis_*, not just tpm_tis_spi, which i=
s
> not acceptable. We cannot backport a fix like this.
>
> Probably you should just add a parameter to tpm_tis_core_init() to hint
> that threaded IRQ is required, and then only conditionally do so.
>

Sure, this is doable although to be honest I dont see the issue with also =
the
non-SPI code running in the threaded interrupt handler. The functionality =
should
not change (especially since interrupts are not even working right now) an=
d it would
save us a special treatment of the SPI case.


Regards,
Lino
