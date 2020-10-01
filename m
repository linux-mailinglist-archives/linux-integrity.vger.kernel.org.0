Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEEE27F668
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Oct 2020 02:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbgJAABx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Sep 2020 20:01:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23066 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgJAABx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Sep 2020 20:01:53 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601510511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R3atLD4INrF5xRGSMks+r3kfby9e8pzmzJ+5rzI9r7g=;
        b=h0lh4U6xuhCc+U9vnNSAVuCGME6XvMPppDAe2EDXjRxHL6Yb8TYUuEAucWBAmYujqH71ft
        GwrwBTQD4WAU1qhx31XuO1QHK1ak2BxFf4xfQaCrZYcarK4Fq6HbZ6LbGuPTicGN55cXvZ
        9I58Jeb7K7A0/9dlRygHw/lvDKtAcNE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-aPa9X5VPPnKvWmvE8aU57Q-1; Wed, 30 Sep 2020 20:01:50 -0400
X-MC-Unique: aPa9X5VPPnKvWmvE8aU57Q-1
Received: by mail-ot1-f70.google.com with SMTP id f15so1144622oto.6
        for <linux-integrity@vger.kernel.org>; Wed, 30 Sep 2020 17:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=R3atLD4INrF5xRGSMks+r3kfby9e8pzmzJ+5rzI9r7g=;
        b=QfjJCUM75cNpn46o4E05o0nofGzIuQ0/oK8ZttFLf3zc/KjgwJKFxaLI1mEy7luGvl
         PneD7FzqqSwdxG4/jyaddecB4TqZQOddot3FuPEJZG61xk+grrd8IKfmq/gI6WwnYW9W
         5jCyo+Yb0xoQYahin4A8ZQXEgC1k5hrjTED5f/59OcLpa0oNAjIdJ5aNVrbwVezpYYfG
         3aJLqrCHpwlBr98MCGmwNSHUXXEmedm779osRdopMsepvR6jfEEcZPRCz+UZlZMlPt92
         qzbC9wGkSd2y6qZKZsiUdlL2MFn6gcRvQJbJ0nNV6wGePKU1CUcoOPb4gnn+KV086f46
         +UKQ==
X-Gm-Message-State: AOAM533fOqGLzNgZyrBEv0RKLwOVs3MAPVZN8tom2s+Gtxk0UHeSG8Wc
        CiNQOaq/z7mtdiUH+8wL7ZyCUfvzGFRY0+ng6GrAcFaMmgRanF7Mu5zV2r5ovz3lp2OaP/l+0Yw
        rtnHKmCReDAk0u3Hpoy8AQgO21IR4
X-Received: by 2002:a9d:4c01:: with SMTP id l1mr3171940otf.341.1601510509327;
        Wed, 30 Sep 2020 17:01:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmkKjjO254a18tWAkyQBRG+7Wmwv8PHnXv6gLSpD0PDdgBjqDvc/O9VbBpSLyLVR6MBMRfRg==
X-Received: by 2002:a9d:4c01:: with SMTP id l1mr3171923otf.341.1601510509074;
        Wed, 30 Sep 2020 17:01:49 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id m3sm811476otc.72.2020.09.30.17.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 17:01:48 -0700 (PDT)
References: <20200929223216.22584-1-James.Bottomley@HansenPartnership.com> <20200929223216.22584-2-James.Bottomley@HansenPartnership.com> <87eemjgdy3.fsf@jsnitsel.users.ipa.redhat.com> <8ed5a80a9b2cfa37f0b8348906d292a7b1a1c02e.camel@HansenPartnership.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Laurent Bigonville <bigon@debian.org>
Subject: Re: [PATCH 1/4] tpm_tis: Clean up locality release
In-reply-to: <8ed5a80a9b2cfa37f0b8348906d292a7b1a1c02e.camel@HansenPartnership.com>
Date:   Wed, 30 Sep 2020 17:01:46 -0700
Message-ID: <87h7reddat.fsf@jsnitsel.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


James Bottomley @ 2020-09-30 16:03 MST:

> On Wed, 2020-09-30 at 14:19 -0700, Jerry Snitselaar wrote:
>> James Bottomley @ 2020-09-29 15:32 MST:
>> 
>> > The current release locality code seems to be based on the
>> > misunderstanding that the TPM interrupts when a locality is
>> > released: it doesn't, only when the locality is acquired.
>> > 
>> > Furthermore, there seems to be no point in waiting for the locality
>> > to be released.  All it does is penalize the last TPM
>> > user.  However, if there's no next TPM user, this is a pointless
>> > wait and if there is
>> > a
>> > next TPM user, they'll pay the penalty waiting for the new locality
>> > (or possibly not if it's the same as the old locality).
>> > 
>> > Fix the code by making release_locality as simple write to release
>> > with no waiting for completion.
> [...]
>> My recollection is that this was added because there were some chips
>> that took so long to release locality that a subsequent
>> request_locality call was seeing the locality as already active,
>> moving on, and then the locality was getting released out from under
>> the user.
>
> Well, I could simply dump the interrupt code, which can never work and
> we could always poll.
>
> However, there also appears to be a bug in our locality requesting
> code.  We write the request and wait for the grant, but a grant should
> be signalled by not only the ACCESS_ACTIVE_LOCALITY being 1 but also
> the ACCESS_REQUEST_USE going to 0.  As you say, if we're slow to
> relinquish, ACCESS_ACTIVE_LOCALITY could already be 1 and we'd think we
> were granted, but ACCESS_REQUEST_USE should stay 1 until the TPM
> actually grants the next request.
>
> If I code up a fix is there any chance you still have access to a
> problem TPM?  Mine all seem to grant and release localities fairly
> instantaneously.
>
> James

Sorry, I seemed to make a mess of it. I don't have access to a system where it
occurred, but cc'ing Laurent since he reported the problem and might
still have access to the system.

I'd say fix up the check for locality request to look at
ACCESS_REQUEST_USE, and go with this patch to clean up locality release.
Hopefully Laurent still has access and can test. I do have a laptop now
where I should be able to test the other bits in your patchset since
this is one of the models that hit interrupt storm problem when Stefan's
2 patches were originally applied. Lenovo applied a fix to their bios,
but this should still have the older one version that has the issue. I'm
on PTO this week, but I will try to spend some time in the next couple
days reproducing and then trying your patches.

Regards,
Jerry

