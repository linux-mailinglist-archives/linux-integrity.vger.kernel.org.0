Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF0F2A0AC0
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Oct 2020 17:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgJ3QLl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Oct 2020 12:11:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22463 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbgJ3QLl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Oct 2020 12:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604074299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mS7ARt4RdQyMjDRNe9fSX77yquV/Kk/jvixJ46Hb7R4=;
        b=cDCaB7C/9uzCmPwxlLBUPSYt5q1btH0El8G80k1hdEdkuPHE2wVpppTKfFhtnmGcc5yEnT
        qnTgTLvhI/dI+1JbwB5EpL3MMDYFnYhz1r3kfcSSHRQnJ2ZAKEDu8RF5MW7T0TVFLzyzFW
        fbzGwPmSN31sUT5y/Q3JD31knXks97Y=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-waJncg5sMWar98T9MHqsIA-1; Fri, 30 Oct 2020 12:11:35 -0400
X-MC-Unique: waJncg5sMWar98T9MHqsIA-1
Received: by mail-oi1-f197.google.com with SMTP id c198so2901498oig.7
        for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2020 09:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=mS7ARt4RdQyMjDRNe9fSX77yquV/Kk/jvixJ46Hb7R4=;
        b=ZRQ5vVT68hFTB5VLSjBphc+LM7oHj80M0S4YLFmiTHWNGpBo8BhlwyBsXGcyAIwZkD
         gXp/z+4hpmjP/hlX1fj4ILhNASVMCAK2o5fcYkckP3GhatJuGJp9zGbdyGJwJIumGi8F
         47OAeiFTFFTJFjw18MoZgbekcaZ7FQ2FoZOH/mXRa63ow0Vh+LBUMr9Mo9wdjR5m0oAb
         AGDEDaq16WdjFt8jwo5exniqH4wGuZvoC7X2kgE3uuZJEJgW2cC9iKQB4VcLlwSYrUcT
         LQfsobf2Pj/dKR3PoSBIHdaUsb41hvCowTf9uvm/WBd4J+LbLRBX1tp1NU+WDfVhuevh
         7bdw==
X-Gm-Message-State: AOAM532lILxFJbCNlN0O2EEnl/UekYA41mSThHMfwd09/uwaCxw4UFOD
        BzbKwHZvf97Bw7BgGV9Zotrdpfx2sLTLL9U9j8bHbuj0UmA7m39HKZd1TL7VwSM6h2eGzxBRvLl
        oRarZ0ggyt8lBi+3d/m3n3GkISpD0
X-Received: by 2002:a05:6830:1151:: with SMTP id x17mr2271347otq.302.1604074292968;
        Fri, 30 Oct 2020 09:11:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQujv8QQp2g/eTv1ECVXgdxrt57d6jVfhbM9y5rQEwqDMZ2w4ZThXZkzw8lnGKtmkB0bnbkw==
X-Received: by 2002:a05:6830:1151:: with SMTP id x17mr2271330otq.302.1604074292770;
        Fri, 30 Oct 2020 09:11:32 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id t83sm1466506oie.58.2020.10.30.09.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 09:11:31 -0700 (PDT)
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-5-James.Bottomley@HansenPartnership.com>
 <87zh4hg4wg.fsf@redhat.com> <20201024121718.GC32960@kernel.org>
 <20201030124335.GD522355@kernel.org>
 <837dbe43b7507a765553260289de5fd8eee397c4.camel@HansenPartnership.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 4/5] tpm_tis: fix IRQ probing
In-reply-to: <837dbe43b7507a765553260289de5fd8eee397c4.camel@HansenPartnership.com>
Date:   Fri, 30 Oct 2020 09:11:30 -0700
Message-ID: <87sg9vbsnh.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


James Bottomley @ 2020-10-30 08:49 MST:

> On Fri, 2020-10-30 at 14:43 +0200, Jarkko Sakkinen wrote:
> [...]
>> I tested this with:
>> 
>> - 
>> https://ark.intel.com/content/www/us/en/ark/products/84861/intel-nuc-kit-nuc5i5myhe.html
>>   dTPM 1.2
>> - 
>> https://ark.intel.com/content/www/us/en/ark/products/74483/intel-nuc-kit-dc53427hye.html
>>   dTPM 2.0
>> 
>> I did not get "TPM interrupt not working, polling instead" to klog.
>> But I neither see tpm0 in /proc/interrupts. What I'm doing wrong?
>
> That's usually what you get when ACPI specifies the interrupt isn't
> connected (we don't try to probe it).
>
> James

That is the problem I've been running into. When I do find a system
with a tpm and using tpm_tis, it usually seems to not have the interrupt
connected.

Should this commit have:

Fixes: 570a36097f30 ("tpm: drop 'irq' from struct tpm_vendor_specific")

That is where TPM_CHIP_FLAG_IRQ was added and not set for tpm_tis.

