Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0344F27A72C
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 07:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgI1F7g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 01:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgI1F7g (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 01:59:36 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75294C0613CE
        for <linux-integrity@vger.kernel.org>; Sun, 27 Sep 2020 22:59:36 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a9so2961126pjg.1
        for <linux-integrity@vger.kernel.org>; Sun, 27 Sep 2020 22:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=solfXapgbg+iuv30WemFtClyAffk/cNrWlhqezcPjc4=;
        b=GVR8pUin16qFydgY7wqnOlVN9SlHRYIp5/TYxyrkRXJwd/RTeYK1H2Tnrc7wgFNS/P
         y6ImunhgtqFLOTsreDlTm8xoFz0WPvnDXtnpPAf35Qp2hl4kr/6/5YfPZu2SIWqDUk61
         Ffzwra6YN4m4VSKMp/2nyTsquJWDtFsGbTsmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=solfXapgbg+iuv30WemFtClyAffk/cNrWlhqezcPjc4=;
        b=WoWdhxa+7lwdkTeoK0NLjyaHYuHZArnvMXQBW22Z8gu/kUJ9ZoSGmrH+O30hf3qC71
         eBFW8I2TRRWRivdv7op2Nb+qrLF2fa901zh1JZtbT4N6NtYPwUmnHqKVvkiOTx8Lkitr
         4zbtwfbL5OWNqd8zisWs/WiBkQNKf8t1HLExGI5QOT6ksJSEtbdO2nOcaeVLwcNIxAk/
         xRjDxpZ4eRSa5i7sVUuLYXeeoUePxMoI3SgHGv7c2Y5m6Pr7tjTIfLFchysnEN4pAQOb
         p6QWf4zzjSat1oAy7qsqYIMDzPSEG1E6KRLsdbIF8omGtOW8or1SWAslrD5TfnPLZ+Pe
         +Pmg==
X-Gm-Message-State: AOAM532e75UHoK/WZ8xQ49Zyj7VXIgguO7aistBgUuK9WACmTXBx2zSN
        8uteRzJj2jeoCgq/1QayJQNPKA==
X-Google-Smtp-Source: ABdhPJx5Vm84twcDoOJ03H1pP2wO/wkkNOBwdZhNLk5vRY/9aDJKqZG8t8E3T6g02pM8QY3P2plEgw==
X-Received: by 2002:a17:90a:cf07:: with SMTP id h7mr7832036pju.142.1601272775345;
        Sun, 27 Sep 2020 22:59:35 -0700 (PDT)
Received: from ?IPv6:2601:647:4200:3be0:5808:e111:eba3:c439? ([2601:647:4200:3be0:5808:e111:eba3:c439])
        by smtp.gmail.com with ESMTPSA id h10sm8371575pgm.65.2020.09.27.22.59.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2020 22:59:34 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <0c896ca8eb0e30d6e75843cfbf2aa627ddc63feb.camel@HansenPartnership.com>
Date:   Sun, 27 Sep 2020 22:59:33 -0700
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        Hamza Attak <hamza@hpe.com>, nayna@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, zohar@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <246A111F-C72C-4CA2-B439-A6BBE0E85087@rubrik.com>
References: <20200926223150.109645-1-hao.wu@rubrik.com>
 <73405d14d7665e8a4e3e9defde7fb12aeae7784c.camel@HansenPartnership.com>
 <DFD7629C-05BF-46C1-B3D7-92FBBC176D9E@rubrik.com>
 <cf5c8035b7183522fb8a5df4baa95bd24288e61f.camel@HansenPartnership.com>
 <E6E3C07D-57F4-48F5-B4A9-50868B82E779@rubrik.com>
 <0c896ca8eb0e30d6e75843cfbf2aa627ddc63feb.camel@HansenPartnership.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi James,

>  Upping that to 15ms introduces a 100x delay in
> our status wait for the TPM to become ready, potentially slowing down
> all TIS TPM operations by 100x, which will hit us most with the PCR
> writes we do for IMA logging ... that seems like a bad bargain for a
> single TPM family manufacturer.
1. It is unlike to be 100x delay=20
According to=20
=
https://github.com/torvalds/linux/commit/59f5a6b07f6434efac0057dc2f303a96b=
871811b
=
https://github.com/torvalds/linux/commit/424eaf910c329ab06ad03a527ef45dcf6=
a328f00
It only optimize from 14sec to 7sec. Which is only a 2x speed up by =
using sleep time from 5ms to >1ms.
Here we change it back to 15 ms is very unlikely to have 100x delay.=20
The optimization does not worth to have a breakage on chip from one =
manufacturer.

2. In my opinion, the kernel should support all manufacturers which were =
supported before.=20
Not supporting any of them would lead to kernel divergence, because =
those chip users have to
Use it anyway. Maybe we can see the maintainers=E2=80=99 opinion on =
this.

3. I am kind of opposing to coming up smaller values without doing =
comprehensive
qualification on all supported manufacturers. Stable is probably more =
important for such software.
Looking back to these commits that introduced the breakages, only one or =
two
chips are tested. If that is a common case, probably we should refactor
the TPM driver to better support per-manufacturer configuration?   =20

> However, there is another possibility: it's something to do with the
> byte read; I notice you don't require the same slowdown for the burst
> count read, which actually reads the status register and burst count =
as
> a read32.  If that really is the case, for the atmel would =
substituting
> a read32 and just throwing the upper bytes away in tpm_tis_status()
> allow us to keep the current timings?  I can actually try doing this
> and see if it fixes my nuvoton.

If would be helpful if you can find the solution without reducing =
performance.
I think it is a separate problem to address though. Maybe not worth to =
mix
them in the same fix.

Thanks
Hao

> On Sep 27, 2020, at 6:22 PM, James Bottomley =
<James.Bottomley@HansenPartnership.com> wrote:
>=20
> On Sun, 2020-09-27 at 17:11 -0700, Hao Wu wrote:
>> Hi James,
>>=20
>> Maybe there is a misunderstanding. Here I am using tpm_msleep, not
>> msleep. tpm_msleep is using usleep underlaying. See
>> =
https://github.com/torvalds/linux/blob/master/drivers/char/tpm/tpm.h#L188
>=20
> Right, I had missed that.
>=20
>> The reasons I choose 15ms, is because before=20
>> =
https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60=
475e1c3
>> (Where msleep is changed to tpm_msleep (which is essentially
>> usleep)), The actual sleep time is 15ms, thus here we change this
>> back to 15ms to fix regression.
>=20
> Right now most TIS TPMs operate successfully with a sleep in there of
> the range 0.1-0.5ms.  Upping that to 15ms introduces a 100x delay in
> our status wait for the TPM to become ready, potentially slowing down
> all TIS TPM operations by 100x, which will hit us most with the PCR
> writes we do for IMA logging ... that seems like a bad bargain for a
> single TPM family manufacturer.
>=20
> However, there is another possibility: it's something to do with the
> byte read; I notice you don't require the same slowdown for the burst
> count read, which actually reads the status register and burst count =
as
> a read32.  If that really is the case, for the atmel would =
substituting
> a read32 and just throwing the upper bytes away in tpm_tis_status()
> allow us to keep the current timings?  I can actually try doing this
> and see if it fixes my nuvoton.
>=20
> James
>=20
>=20

