Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D481E123356
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Dec 2019 18:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfLQRSw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Dec 2019 12:18:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31307 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727531AbfLQRSv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Dec 2019 12:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576603129;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=CKPKIyJZy6U8LXytr+HzyJpjpcjvTy2Qoof8V3zblHk=;
        b=C6Gc04ttE7mb4mGW1KITsK+6HgQBjtDVVFGYb1PrA+m9+gRcDii8EP84YTyh4fUVEEHSiv
        Ubj3Au8mPYhlG96ogkmpkvVMTJ7/7pPZCOTYUsQX1WCWiVIApRtciwmicpuxy3ZeMxCDFq
        Yyk+7rGz5mgIVImx/iXevrfS+Lao/JU=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-XYo_i_sHP36PEwOYqIC3qw-1; Tue, 17 Dec 2019 12:18:48 -0500
X-MC-Unique: XYo_i_sHP36PEwOYqIC3qw-1
Received: by mail-yb1-f199.google.com with SMTP id b194so1010169yba.21
        for <linux-integrity@vger.kernel.org>; Tue, 17 Dec 2019 09:18:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=CKPKIyJZy6U8LXytr+HzyJpjpcjvTy2Qoof8V3zblHk=;
        b=UyceIGKc2u55na1hbwU2ON5/4kRBy91CMZ8SSep3dn1qm+ag0viz6eb6XudaGkx+81
         oM3PY36ewe8bbu4nz3u5Fbr1AkfXHP7Q3c+hfYnoslwYnuvmcveCZJGcQosDPfqnHuAA
         dZxujiuq9m8HFhZPT54nD6rMDYqSMAZid7tSIhmxTY2Ns+1j30+t9C2T8Z1/VNtc4Yda
         trclYD+3hVfr1J7anlXfwrFRClkdZ9s0CkGqHx0+CJtA1+4qm1h/TcpuMAb111tVorMm
         cxt1JcMU6lYBRO/Ho80uGiV9TAWIv2fE9DIv1FJR2o/AUELXsMH8ZbV4sJrzZnnBxj8e
         QHug==
X-Gm-Message-State: APjAAAWhvjRyOvL6Od/vgRKJ7A95/AaOeUTqX0W04awln5yGclxVCffU
        xdKv3t8tKGr10NjUp22U/ZJy3qeSlFlaoRE5SPAUJrYqhj7PbufRqxS6hV3Oz5EuP3v5JoFrt65
        E3ucytJDdDPc2E+c+dlUiZEYS/zFz
X-Received: by 2002:a25:1286:: with SMTP id 128mr14032735ybs.214.1576603127010;
        Tue, 17 Dec 2019 09:18:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqzZrH0mBs2K/Kr+dAvXBSDBHex+NYXpJ/cSs5fhNlzaQzHOdQV1tnra7qB6pm6f7dWba0Vm3w==
X-Received: by 2002:a25:1286:: with SMTP id 128mr14032717ybs.214.1576603126752;
        Tue, 17 Dec 2019 09:18:46 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id h184sm6884054ywa.70.2019.12.17.09.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 09:18:45 -0800 (PST)
Date:   Tue, 17 Dec 2019 10:18:44 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm_tis: reserve chip for duration of
 tpm_tis_core_init
Message-ID: <20191217171844.huqlj5csr262zkkk@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>, linux-integrity@vger.kernel.org
References: <20191211231758.22263-1-jsnitsel@redhat.com>
 <20191211235455.24424-1-jsnitsel@redhat.com>
 <5aef0fbe28ed23b963c53d61445b0bac6f108642.camel@linux.intel.com>
 <CAPcyv4h60z889bfbiwvVhsj6MxmOPiPY8ZuPB_skxkZx-N+OGw@mail.gmail.com>
 <20191217020022.knh7uxt4pn77wk5m@cantor>
 <CAPcyv4iepQup4bwMuWzq6r5gdx83hgYckUWFF7yF=rszjz3dtQ@mail.gmail.com>
 <5d0763334def7d7ae1e7cf931ef9b14184dce238.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <5d0763334def7d7ae1e7cf931ef9b14184dce238.camel@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Dec 17 19, Jarkko Sakkinen wrote:
>On Mon, 2019-12-16 at 18:14 -0800, Dan Williams wrote:
>> On Mon, Dec 16, 2019 at 6:00 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>> > On Mon Dec 16 19, Dan Williams wrote:
>> > > On Mon, Dec 16, 2019 at 4:59 PM Jarkko Sakkinen
>> > > <jarkko.sakkinen@linux.intel.com> wrote:
>> > > > On Wed, 2019-12-11 at 16:54 -0700, Jerry Snitselaar wrote:
>> > > > > Instead of repeatedly calling tpm_chip_start/tpm_chip_stop when
>> > > > > issuing commands to the tpm during initialization, just reserve the
>> > > > > chip after wait_startup, and release it when we are ready to call
>> > > > > tpm_chip_register.
>> > > > >
>> > > > > Cc: Christian Bundy <christianbundy@fraction.io>
>> > > > > Cc: Dan Williams <dan.j.williams@intel.com>
>> > > > > Cc: Peter Huewe <peterhuewe@gmx.de>
>> > > > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> > > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> > > > > Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> > > > > Cc: stable@vger.kernel.org
>> > > > > Cc: linux-integrity@vger.kernel.org
>> > > > > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
>> > > > > Fixes: 5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing IRQ's")
>> > > > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> > > >
>> > > > I pushed to my master with minor tweaks and added my tags.
>> > > >
>> > > > Please check before I put it to linux-next.
>> > >
>> > > I don't see it yet here:
>> > >
>> > > http://git.infradead.org/users/jjs/linux-tpmdd.git/shortlog/refs/heads/master
>> > >
>> > > However, I wanted to make sure you captured that this does *not* fix
>> > > the interrupt issue. I.e. make sure you remove the "Fixes:
>> > > 5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing IRQ's")"
>> > > tag.
>> > >
>> > > With that said, are you going to include the revert of:
>> > >
>> > > 1ea32c83c699 tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts
>> >
>> > Dan, with the above reverted do you still get the screaming interrupt?
>>
>> Yes, the screaming interrupt goes away, although it is replaced by
>> these messages when the driver starts:
>>
>> [    3.725131] tpm_tis IFX0740:00: 2.0 TPM (device-id 0x1B, rev-id 16)
>> [    3.725358] tpm tpm0: tpm_try_transmit: send(): error -5
>> [    3.725359] tpm tpm0: [Firmware Bug]: TPM interrupt not working,
>> polling instead
>>
>> If the choice is "error message + polled-mode" vs "pinning a cpu with
>> interrupts" I'd accept the former, but wanted Jarkko with his
>> maintainer hat to weigh in.
>>
>> Is there a simple sanity check I can run to see if the TPM is still
>> operational in this state?
>
>What about T490S?
>
>/Jarkko
>

Hi Jarkko, I'm waiting to hear back from the t490s user, but I imagine
it still has the problem as well.

Christian, were you able to try this patch and verify it still
resolves the issue you were having with the kernel failing to get the
timeouts and durations from the tpm?

Thanks,
Jerry

