Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDD61FC34B
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2020 03:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgFQBWB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 21:22:01 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34059 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726505AbgFQBWA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 21:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592356918;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKcVkt2+V0rAAQaA+C9A4ggXy/RSZQnXIwV16xzF2I4=;
        b=KefiUXT6HbBK1+3Tf7XgI24JmZiA/pkRvM3enyvj5QelWoXCu6Krm9LKakaNKvYZ7BtgEw
        CQgRMTJHD3iJe4muMRnym1xdksWJob1hMpUl9dWaLTO2de+ijmb5ZHWsvb3+1EEavFxjol
        M0ffJ3gG6eFeXRDZ/8MvcidAmvooCoM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-iqf3PhM8M12CF4qziW7skA-1; Tue, 16 Jun 2020 21:21:52 -0400
X-MC-Unique: iqf3PhM8M12CF4qziW7skA-1
Received: by mail-qv1-f71.google.com with SMTP id f18so448158qvr.22
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jun 2020 18:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=CKcVkt2+V0rAAQaA+C9A4ggXy/RSZQnXIwV16xzF2I4=;
        b=Clpbr3fMYdhS157fe5WNyBiWw5WxO6mtBsfabsMKHQP1lrD54EGGsNulGSDdR+b83c
         V/jiKvsupkYwFOeiBEaRJIExhBZ8LRs8CYFd3d1M2XyAoga77BPQU4VqEXg2Vc4MODm/
         2yY91rCoqVrHVMVhrcX6wSOoqBGYihPpe1DkjgnqrMYpek/7+h+gFXtwyha22103cqSA
         PQwQiTpV4k/LKDYVo2uQwBlkjFkeebW1djW7AziXyZbel+JyURaUtW4mXxezN36yuQPb
         04HKou8oSjHNPkd6izUy0FbS/+/YC6ixB9q0AkfouHKK1IECLhQmf3nNOrOK3JR6Es6U
         kBWA==
X-Gm-Message-State: AOAM532UTY7N6bUUT86V+qN7EXGv0abTZYhCkWfxxie5LsCwZSklkKu7
        2s0TwFUb1yG7YuqB+VVlEPgJAoKSfV1esh9WSsEDUkvSayOb6j96+pkp9YoiPo2u0zNLJkwbm/7
        GcWrgig/VlOCF4aRd2HrI0Xc81LZ5
X-Received: by 2002:a37:73c2:: with SMTP id o185mr22797233qkc.356.1592356911235;
        Tue, 16 Jun 2020 18:21:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUZLQ/kpAL+2o1drH4wn+lrUqNaCRFjT/1DJ1wH9AVfIuncwSmlsojG1XWurSh8YMUK78QBA==
X-Received: by 2002:a37:73c2:: with SMTP id o185mr22797215qkc.356.1592356910862;
        Tue, 16 Jun 2020 18:21:50 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id z4sm17115671qtu.33.2020.06.16.18.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 18:21:50 -0700 (PDT)
Date:   Tue, 16 Jun 2020 18:21:48 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Bruno Meneguele <bmeneg@redhat.com>, Petr Vorel <pvorel@suse.cz>,
        ltp@lists.linux.it, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Petr Cervinka <pcervinka@suse.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Maurizio Drocco <maurizio.drocco@ibm.com>
Subject: Re: [LTP v2 1/1] ima_tpm.sh: Fix for calculating boot aggregate
Message-ID: <20200617012148.hhpvxqov2py7fvvc@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20200527071434.28574-1-pvorel@suse.cz>
 <1590601280.16219.1.camel@linux.ibm.com>
 <20200528140747.GA8401@dell5510>
 <1590679145.4457.39.camel@linux.ibm.com>
 <20200528160527.GA27243@dell5510>
 <20200615194134.GF129694@glitch>
 <1592252491.11061.181.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1592252491.11061.181.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon Jun 15 20, Mimi Zohar wrote:
>On Mon, 2020-06-15 at 16:41 -0300, Bruno Meneguele wrote:
>> On Thu, May 28, 2020 at 06:05:27PM +0200, Petr Vorel wrote:
>> > Hi Mimi,
>> > ...
>> > > > > With just this change, the ima_tpm.sh test is failing.  I assume it is
>> > > > > failing because it is reading the SHA1 TPM bank, not the SHA256 bank
>> > > > > to calculate the boot_aggregate hash.
>> > > > First question: is it correct to take sha256? Because on my test below it's
>> > > > reading sha1, because that's the content of /sys/kernel/security/ima/ascii_runtime_measurements
>> >
>> > > > I thought just kernel commit: 6f1a1d103b48 ima: ("Switch to ima_hash_algo for
>> > > > boot aggregate") from current linux-integrity tree is needed, but I tested it on
>> > > > b59fda449cf0 ("ima: Set again build_ima_appraise variable") (i.e. having all
>> > > > Robeto's ima patches,  missing just last 2 commits from next-integrity head).
>> > > > What is needed to get your setup?
>> >
>> > > This isn't a configuration problem, but an issue of reading PCRs and
>> > > calculating the TPM bank appropriate boot_aggregate.  If you're
>> > > calculating a sha256 boot_aggregate, then the test needs to read and
>> > > calculate the boot_aggregate by reading the SHA256 TPM bank.
>> > OK, I tested it on TPM 1.2 (no TPM 2.0 available atm).
>> > I guess you have TPM 2.0, that's why I didn't spot this issue.
>> >
>> > To sum that: my patch is required for any system without physical TPM with with
>> > kernel with b59fda449cf0 + it also works for TPM 1.2 (regardless kernel
>> > version), because TPM 1.2 supports sha1 only boot aggregate.
>> >
>> > But testing on kernel with b59fda449cf0 with TPM 2.0 is not only broken with
>> > this patch, but also on current version in master, right? As you have
>> > sha256:3fd5dc717f886ff7182526efc5edc3abb179a5aac1ab589c8ec888398233ae5 anyway.
>> > So this patch would help at least testing on VM without vTPM.
>> >
>>
>> If we consider to delay this change until we have the ima-evm-utils
>> released with the ima_boot_aggregate + make this test dependent on
>> both ima-evm-utils and tsspcrread, would it be worth to SKIP the test in
>> case a TPM2.0 sha256 bank is detected instead of FAIL? Thus we could
>> have the test fixed for TPM1.2 && no-TPM cases until we get the full
>> support for multiple banks?
>
>As long as we're dealing with the "boot_aggregate", Maurizio just
>posted a kernel patch for including PCR 8 & 9 in the boot_aggregate.
> The existing IMA LTP "boot_aggregate" test is going to need to
>support this change.
>
>I'd appreciate if someone could send me a TPM event log, the PCRs, and
>the associated IMA ascii_runtime_measurements "boot_aggregate" from a
>system with a discrete TPM 2.0 with PCRs 8 & 9 events.
>
>>
>> > ...
>> > > > > The ima-evm-utils next-testing branch has code to calculate the
>> > > > > boot_aggregate based on multiple banks.
>> > > > I see, 696bf0b ("ima-evm-utils: calculate the digests for multiple TPM banks")
>> > > > I wonder whether it's reasonable trying to port that to ima_boot_aggregate.c or
>> > > > just depend on evmctl. External dependencies are sometimes complicated, but for
>> > > > IMA I incline to just require evmctl.
>> >
>> > > Unlike TPM 1.2, the TPM 2.0 device driver doesn't export the TPM PCRs.
>> > >  Not only would you have a dependency on ima-evm-utils, but also on a
>> > > userspace application(s) for reading the TPM PCRs.  That dependency
>> > > exists whether you're using evmctl to calculate the boot_aggregate or
>> > > doing it yourself.
>> > Hm, things get complicated.
>> > Yep I remember your patch to skip verifying TPM 2.0 PCR values
>> > https://patchwork.ozlabs.org/project/ltp/patch/1558041162.3971.2.camel@linux.ibm.com/
>> > At least thanks to Jerry Snitselaar since v5.6 we have
>> > /sys/class/tpm/tpm*/tpm_version_major. We could check this (+ try also
>> > /sys/class/tpm/tpm0/device/description for older kernels).
>> >
>> > BTW on my system there is also /sys/class/tpm/tpm0/ppi/version, which has 1.2,
>> > not sure if it indicate TPM 1.2, but I wouldn't rely on that.
>> >
>>
>> IIUC 'tpm_version_major' should be the only safe reference of the actual
>> TCG spec version being implemented by the hw TPM, in a sysfs standard
>> output.
>
>That was only upstreamed in linux-v5.6.  Has it been backported?
>

Not that I know of. Since it isn't using chip->ops and only
looks at chip->flags it could probably be backported, but I'd
have to take a look at it.

>The PCRs are not exported for TPM 2.0, unfortunately, making
>regression tests dependent on a userspace app.  The existing LTP
>ima_tpm.sh test looks for the PCRs in either
>/sys/class/tpm/tpm0/device/pcrs or /sys/class/misc/tpm0/device/pcrs.
> Perhaps piggyback on the pseudo PCR file to test for TPM 1.2.
>
>>
>> > ...
>> > > > > There's also a new test to verify the boot_aggregate.
>> >
>> > > > > $ VERBOSE=1 make check TESTS=boog_aggregate.test
>> > > > BTW I got some errors
>> > > > ...
>> > > > make  check-TESTS
>> > > > make[2]: Entering directory '/home/foo/ima-evm-utils/tests'
>> > > > make[3]: Entering directory '/home/foo/ima-evm-utils/tests'
>> > > > make[4]: Entering directory '/home/foo/ima-evm-utils/tests'
>> > > > make[4]: Nothing to be done for 'boog_aggregate.log'.
>> > > > make[4]: Leaving directory '/home/foo/ima-evm-utils/tests'
>> > > > fatal: making test-suite.log: failed to create boog_aggregate.trs
>> > > > fatal: making test-suite.log: failed to create boog_aggregate.log
>> > > > make[3]: *** [Makefile:516: test-suite.log] Error 1
>> > > > make[3]: Leaving directory '/home/foo/ima-evm-utils/tests'
>> > > > make[2]: *** [Makefile:625: check-TESTS] Error 2
>> > > > make[2]: Leaving directory '/home/foo/ima-evm-utils/tests'
>> > > > make[1]: *** [Makefile:692: check-am] Error 2
>> > > > make[1]: Leaving directory '/home/foo/ima-evm-utils/tests'
>> > > > make: *** [Makefile:514: check-recursive] Error 1
>> >
>> > > [Cc'ing Vitaly]
>> >
>> > > The boot_aggregate.trs and boot_aggregate.log files are being created
>> > > in the tests/ directory.  Is that directory read-only?
>> > Yes, drwxr-xr-x. Testing on fresh clone and issue persists.
>> >
>>
>> Yes, same thing here.. but didn't really check the reason for that. Will
>> take a time later to see what's happening.
>
>Thanks, much appreciated.  I'm not seeing that here.
>
>Mimi
>

