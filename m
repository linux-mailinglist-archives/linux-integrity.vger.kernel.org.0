Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20858294558
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Oct 2020 01:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439239AbgJTXKt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Oct 2020 19:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28040 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2410519AbgJTXKs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Oct 2020 19:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603235447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nhnrGheJeLVXFzx3fEcESV2W9aWqrZXJl+ITK+G850Q=;
        b=J+aOqtMaRliBO7wH2jsMdItmirrLcZiDLaID64ZOkNpalwTvGqK7ahZBJlEwtoU1L77V1R
        uzo6V8R8UZEjdBmJ8Rkny/OPw6+NqzuvClMFTy0d5HRLkY5pOr2iMX5OH3LK5upHK1+cWS
        hKPW4ZEAXpKcyTjthOswnCg6X97mC0Q=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-JcIf9GATOGaTQIDJEAFcpQ-1; Tue, 20 Oct 2020 19:10:45 -0400
X-MC-Unique: JcIf9GATOGaTQIDJEAFcpQ-1
Received: by mail-qt1-f198.google.com with SMTP id r4so232486qta.9
        for <linux-integrity@vger.kernel.org>; Tue, 20 Oct 2020 16:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=nhnrGheJeLVXFzx3fEcESV2W9aWqrZXJl+ITK+G850Q=;
        b=l5Q5PJ2V67xUohYoV2rI4aAphxmYYPsN5SLmDL0Dn6/o9qEup7GlEOzizfneF2TFi3
         omttP3oigTp4zY07NVp4+osff0kGFB+O9rjLR5eLYo0mEgrOvE1dVznM0xM2/pJmUuim
         J4lYofuMUOyD8j23MfQNr6+vgMU4dzDk46amvc+lw5sfB1OL1hXn4hPbmHN1foSBmhoH
         LBIWMdz20FlCL25ihVmVIjFWeiPct+IQbUu11Tl3DZvFOhKx4z1/Q7Ai2SEBBz80wBzn
         ATWcxYfCLSpAs2Se7CI/iof7FUgujCkliCMuG5F5r94CnOIMDa0cLZK5ywnsD3ZeF5v/
         aXHA==
X-Gm-Message-State: AOAM530hDSATK+h7P8O7a9XX8rrblCL3MXqceM1S34VUnDVU5MF0b80y
        oqxsoVQ57zeIO61eLHEXr0WAdRM/CLOY7bVE7xP29t/vEUxYrdNWg5TFIT5QQRb9t9KRZjJ0dA6
        dnQeBjTfJJLl8JPjyK4X1661X98V/
X-Received: by 2002:a0c:8d8b:: with SMTP id t11mr278387qvb.13.1603235445072;
        Tue, 20 Oct 2020 16:10:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxF0l98jVLk7BUTWi3YkuDcVrvOtd+xhRgNCJrVdNXHeNdm5GV6jYDaNh127A12QUVIYjtrMQ==
X-Received: by 2002:a0c:8d8b:: with SMTP id t11mr278356qvb.13.1603235444791;
        Tue, 20 Oct 2020 16:10:44 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id b12sm89901qtj.12.2020.10.20.16.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 16:10:43 -0700 (PDT)
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201013011745.GA41176@linux.intel.com>
 <87tuuyf97r.fsf@jsnitsel.users.ipa.redhat.com>
 <20201018210539.GA575510@kapsi.fi>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     equired@linux.intel.com,
        justmentioningitbecauseIthinkthatwouldbeagood@linux.intel.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Borislav Petkov <bp@alien8.de>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v2 0/5] tpm_tis: fix interrupts (again)
In-reply-to: <20201018210539.GA575510@kapsi.fi>
Date:   Tue, 20 Oct 2020 16:10:42 -0700
Message-ID: <87y2k0v6h9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Jarkko Sakkinen @ 2020-10-18 14:05 MST:

> On Tue, Oct 13, 2020 at 08:15:36AM -0700, Jerry Snitselaar wrote:
>> 
>> Jarkko Sakkinen @ 2020-10-12 18:17 MST:
>> 
>> > On Thu, Oct 01, 2020 at 11:09:20AM -0700, James Bottomley wrote:
>> >> The current state of the TIS TPM is that interrupts have been globally
>> >> disabled by various changes.  The problems we got reported the last
>> >> time they were enabled was interrupt storms.  With my own TIS TPM,
>> >> I've found that this is caused because my TPM doesn't do legacy
>> >> cycles, The TIS spec (chapter 6.1 "Locality Usage Per Register")
>> >> requires any TIS TPM without legacy cycles not to act on any write to
>> >> an interrupt register unless the locality is enabled.  This means if
>> >> an interrupt fires after we relinquish the locality, the TPM_EOI in
>> >> the interrupt routine is ineffective meaning the same interrupt
>> >> triggers over and over again.  This problem also means we can have
>> >> trouble setting up interrupts on TIS TPMs because the current init
>> >> code does the setup before the locality is claimed for the first time.
>> >> 
>> >> James
>> >
>> > You should consider expanding the audience. Jerry, once you have some
>> > bandwidth (no rush, does not land before rc2), it would be great that if
>> > you could try this. I'm emphasizing this just because of the
>> > intersection. I think it would also make senset to get tested-by from
>> > Nayna.
>> 
>> I will run some tests on some other systems I have access to. As noted
>> in the other email I did a quick test with a t490s with an older bios
>> that exhibits the problem originally reported when Stefan's patch
>> enabled interrupts.
>
> Thank you. As said, I can make a pull request to rc2 or even rc3, if
> needed.
>
> /Jarkko

So outside of the t490s I have access to, it looks like the nuc5 with
tpm2.0 device, and and older lenovo D30 with a tpm1.2 device both are
not using interrupts. I'm digging around to see if I can find some
other systems that I can test interrupts on.

Regards,
Jerry

