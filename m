Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1208F28D10A
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 17:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbgJMPPn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Oct 2020 11:15:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44612 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730376AbgJMPPn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Oct 2020 11:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602602141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4of6x2n+t6J6ILQ0e1sdPtpJVNXpN5f9khAUX3gFI0s=;
        b=HQkMdAvrzxtE2R+LiPWWmF9fm/fHxzIjTzVBxSmzduLhUtqpIB+djwojBy39XcjLAHblCX
        bf0PpwLxwBKsL0UHddXuGdsJXAuracUoNMg8pStuBH2LLmNgaY52earpG8ZX2OXjWoC4sx
        49Vv0WM1m4j+EzTu5j2AtuAfufFk5Y8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-TNdpEqCnM1uGs6MjLBbpJg-1; Tue, 13 Oct 2020 11:15:39 -0400
X-MC-Unique: TNdpEqCnM1uGs6MjLBbpJg-1
Received: by mail-qk1-f198.google.com with SMTP id q15so15131372qkq.23
        for <linux-integrity@vger.kernel.org>; Tue, 13 Oct 2020 08:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=4of6x2n+t6J6ILQ0e1sdPtpJVNXpN5f9khAUX3gFI0s=;
        b=lG2q1/4m8ICJLiDHmZXNXoeCUdkTLWgmpko7CyjMVkoBGS3cbhT4D7wUM+KEbIS2YC
         fPTvgRwovKSTdJ1pVvdG8ZFIEV4nvgW/zAUMIpFG+aY+o3YenH0ZLVnMHZL/3pxI/4HG
         7muuRO6EOcKpcn+N/oRvuFENI6f2LD6oWSAB4RGRduXLPtZJ3t2UPav88roXA09Ay/4P
         UlK8uORYvwxii+ccH0DOfrdoPnzgaosYkfYJH6f2laumLawvNMUlS/VqxCa7vb5ebJHm
         K+RKIwdZnRwDMDcn1hoHnzmdVhIhFDlL1/gg5ni0BIIWgjZolsA2bWllBm6kaS6uhQM5
         ocmA==
X-Gm-Message-State: AOAM533vPoclo8nHVm39PU53XSpA2LNqiTADJ7Eb52I7aWRkCCmVX74l
        B17T4RswltRqwJfQWTqEVJ4NOZ4nWB18lDNIErhircZF6cuGS87gJZUaz/28nB/VEmD//Yp6SsB
        Yvwuc4s0lbekvLqGP2vX+UIJc25Tj
X-Received: by 2002:a05:6214:a0f:: with SMTP id dw15mr336320qvb.44.1602602138484;
        Tue, 13 Oct 2020 08:15:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5fYcWwVI8xO3lHEyplWAYhdnXb2h5Z9Yw4D7v5Ayw2TYm0752QLHFr10kvrMou1YExaqzYA==
X-Received: by 2002:a05:6214:a0f:: with SMTP id dw15mr336292qvb.44.1602602138233;
        Tue, 13 Oct 2020 08:15:38 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id x5sm53760qtk.68.2020.10.13.08.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 08:15:37 -0700 (PDT)
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201013011745.GA41176@linux.intel.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     equired@linux.intel.com,
        justmentioningitbecauseIthinkthatwouldbeagood@linux.intel.com
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Borislav Petkov <bp@alien8.de>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v2 0/5] tpm_tis: fix interrupts (again)
In-reply-to: <20201013011745.GA41176@linux.intel.com>
Date:   Tue, 13 Oct 2020 08:15:36 -0700
Message-ID: <87tuuyf97r.fsf@jsnitsel.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Jarkko Sakkinen @ 2020-10-12 18:17 MST:

> On Thu, Oct 01, 2020 at 11:09:20AM -0700, James Bottomley wrote:
>> The current state of the TIS TPM is that interrupts have been globally
>> disabled by various changes.  The problems we got reported the last
>> time they were enabled was interrupt storms.  With my own TIS TPM,
>> I've found that this is caused because my TPM doesn't do legacy
>> cycles, The TIS spec (chapter 6.1 "Locality Usage Per Register")
>> requires any TIS TPM without legacy cycles not to act on any write to
>> an interrupt register unless the locality is enabled.  This means if
>> an interrupt fires after we relinquish the locality, the TPM_EOI in
>> the interrupt routine is ineffective meaning the same interrupt
>> triggers over and over again.  This problem also means we can have
>> trouble setting up interrupts on TIS TPMs because the current init
>> code does the setup before the locality is claimed for the first time.
>> 
>> James
>
> You should consider expanding the audience. Jerry, once you have some
> bandwidth (no rush, does not land before rc2), it would be great that if
> you could try this. I'm emphasizing this just because of the
> intersection. I think it would also make senset to get tested-by from
> Nayna.

I will run some tests on some other systems I have access to. As noted
in the other email I did a quick test with a t490s with an older bios
that exhibits the problem originally reported when Stefan's patch
enabled interrupts.

>
> Speaking of the changelog, I almost never have encounter a patch set
> that does not have a changelog in the cover letter. And I'm not able to
> interpret the process text in a way that it would ask to scatter
> changelogs to the patches, and not put them to the cover letter [*].
>
> Thus, I trust what I see as commodity. Not only that but it also helps a
> lot with to see quickly what has changed, especially if the patches are
> such that you have to take them in eventually.
>
> In my own patch sets, I've recently started to xref associated lore korg
> discussions in the change log entries, when it applies. I started to do
> this with the SGX series when I had missed to address a number of Boris'
> comments. It has helped a lot with my own tracking and I assume it is
> also helpful for reviewers and maintainers to get the context, when they
> need it.
>
> The last paragraph is not something I demand. I'm merely just mentioning
> it because I think it is a good practice for any patch set.
>
> [*] https://lore.kernel.org/linux-integrity/14edea1f5092c2b8442165756b2ee32e56bed1eb.camel@HansenPartnership.com/
>
> /Jarkko

