Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E893A259F
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 09:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhFJHmi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 03:42:38 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41232 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJHmi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 03:42:38 -0400
Received: from smtpclient.apple (unknown [49.207.221.183])
        by linux.microsoft.com (Postfix) with ESMTPSA id EA67E20B7188;
        Thu, 10 Jun 2021 00:40:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EA67E20B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623310842;
        bh=NLgMG6zTm0P+JIKQU5v1sw2JVUN2gW2yx8M4QUsY+mo=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=qnqtFQKFpyW0cj16ZjYOZ9xsCT3wLnPoX8DVy/JsH9BVsEzUHVyfV4pgg2H9GAGjY
         ajmxsh928ae6NBXyAwdPcZx4poI3BpwhfdMfTbNrqWIPSmrmWBCoCPxhYn6TxHxuZg
         BFqvH9PXgoK2mlhk7VBIV3rzDWYutf0FGbJuCeGM=
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v3 5/7] tee: Support shm registration without dma-buf
 backing
From:   Allen Pais <apais@linux.microsoft.com>
In-Reply-To: <20210609121533.GA2267052@jade>
Date:   Thu, 10 Jun 2021 13:10:35 +0530
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Rijo-john.Thomas@amd.com, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F2A9E44A-137B-4081-AA82-B84FF4761957@linux.microsoft.com>
References: <20210609002326.210024-1-tyhicks@linux.microsoft.com>
 <20210609002326.210024-6-tyhicks@linux.microsoft.com>
 <CAFA6WYOZC0iHzZm6pOxz31eW_=8g2wyJdm4wiOGKggO6-a9MdA@mail.gmail.com>
 <20210609054621.GB4910@sequoia>
 <CAFA6WYOYt2vcQ4ng=Nwu2R7d6=R=DGXQKpQ-+UiENerEtQRKWg@mail.gmail.com>
 <20210609121533.GA2267052@jade>
To:     Jens Wiklander <jens.wiklander@linaro.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

>>=20
>> AFAIK, its due the the inherent nature of tee_shm_alloc() and
>> tee_shm_register() where tee_shm_alloc() doesn't need to know whether
>> its a kernel or user-space memory since it is the one that allocates
>> whereas tee_shm_register() need to know that since it has to register
>> pre-allocated client memory.
>>=20
>>> - Why does tee_shm_register() unconditionally use non-contiguous
>>>  allocations without ever taking into account whether or not
>>>  OPTEE_SMC_SEC_CAP_DYNAMIC_SHM was set? It sounds like that's =
required
>>>  from my reading of =
https://optee.readthedocs.io/en/latest/architecture/core.html#noncontiguou=
s-shared-buffers.
>>=20
>> Yeah, but do we have platforms in OP-TEE that don't support dynamic
>> shared memory? I guess it has become the sane default which is a
>> mandatory requirement when it comes to OP-TEE driver in u-boot.
>>=20
>>> - Why is TEE_SHM_REGISTER implemented at the TEE driver level when =
it is
>>>  specific to OP-TEE? How to better abstract that away?
>>>=20
>>=20
>> I would like you to go through Section "3.2.4. Shared Memory" in TEE
>> Client API Specification. There are two standard ways for shared
>> memory approach with TEE:
>>=20
>> 1. A Shared Memory block can either be existing Client Application
>> memory (kernel driver in our case) which is subsequently registered
>> with the TEE Client API (using tee_shm_register() in our case).
>>=20
>> 2. Or memory which is allocated on behalf of the Client Application
>> using the TEE
>> Client API (using tee_shm_alloc() in our case).
>>=20
>>> Let me know if you agree with the more minimal approach that I took =
for
>>> these bug fix series or still feel like tee_shm_register() should be
>>> fixed up so that it is usable. Thanks!
>>=20
>> =46rom drivers perspective I think the change should be:
>>=20
>> tee_shm_alloc()
>>=20
>> to
>>=20
>> kcalloc()
>> tee_shm_register()
>=20
> I've just posted "[PATCH 0/7] tee: shared memory updates",
> =
https://lore.kernel.org/lkml/20210609102324.2222332-1-jens.wiklander@linar=
o.org/
>=20
> Where tee_shm_alloc() is replaced by among other functions
> tee_shm_alloc_kernel_buf(). tee_shm_alloc_kernel_buf() takes care of =
the
> problem with TEE_SHM_DMA_BUF.
>=20

Thanks Jens. The series looks fine.  Tested too.

- Allen

