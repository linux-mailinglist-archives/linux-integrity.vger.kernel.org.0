Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A81299550
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Oct 2020 19:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789778AbgJZS3x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Oct 2020 14:29:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1789777AbgJZS3x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Oct 2020 14:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603736991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KggODvm7RX2zDubhypxKzbAEvh5UTHnnlgLGb89lhOM=;
        b=PPrVvLUpte2mQJ5k2bvhck0WVkZnnZ6rOSjmYNwCDKq/rhBBaMhXssQqLocdIRmLBPpxYC
        Id52TjlXygzbKA97KxhG8YX0Yqw++xLvTPAELwinWtZtd7D0DzJ4fABdFrJHyDbr6wxI6e
        /xR7CJmUQ0hlZSrCVec0+Nb7aa9Vvhc=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-6dRxRFvFOVSpm4UZoAPQZA-1; Mon, 26 Oct 2020 14:29:49 -0400
X-MC-Unique: 6dRxRFvFOVSpm4UZoAPQZA-1
Received: by mail-oi1-f200.google.com with SMTP id c198so3142939oig.7
        for <linux-integrity@vger.kernel.org>; Mon, 26 Oct 2020 11:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=KggODvm7RX2zDubhypxKzbAEvh5UTHnnlgLGb89lhOM=;
        b=gPSrwwIgx0ggabjOso5TWEAwfSshkPKsJ5J7hj1eYl48E4wpjFzBv3avzm0AAS7uo8
         VVUvOQPh1X01k4GRlcJvFlLJ5W4tBOJKa6LVN49jUQ06Ri8GycOwtjEFy9edk9VkLq22
         rt7DUg8aACiJc3BMtL/izzXPK8zyIL7hRQMIGSJAsXrsDLxt/J5Rhvr/TOTSaurITGAm
         8/Jwy+ZJ8ZiIwFx4+Sm1U3msRm15fQazRddkpTSVDsWOfYOTpX3TyeVuWYF4WR4zve+o
         cS9TST76ZoAwx61XMtugcr/QKAE6GgVveENb38nFnELCcLNPVVcEkl/iSWO0dnveKgkw
         Dobg==
X-Gm-Message-State: AOAM531B1rwnb+rWp7pEEnVHGDxydDFvVch56P41RjAMME0imYuSg1ds
        C1JU+kLFFf2+0/EtVhf6Rt21lD9vIwMyifM53SFGPxVUAel2P/3H5dhE1DUKu2U6jwz9c7/UY4T
        F9iS18M/E5/PdlgLBRqOcthIv8WEL
X-Received: by 2002:a9d:2f69:: with SMTP id h96mr12002058otb.62.1603736988861;
        Mon, 26 Oct 2020 11:29:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3VBw8Mj4UXhDBEkJ1ihlF5mqAKwqDjkPqPVFgEPZewHtqvrNDdyyTZPz+hDRrfr+vXVN2tw==
X-Received: by 2002:a9d:2f69:: with SMTP id h96mr12002039otb.62.1603736988622;
        Mon, 26 Oct 2020 11:29:48 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id 15sm4531012ooy.36.2020.10.26.11.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 11:29:47 -0700 (PDT)
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201013011745.GA41176@linux.intel.com>
 <87tuuyf97r.fsf@jsnitsel.users.ipa.redhat.com>
 <20201018210539.GA575510@kapsi.fi> <87y2k0v6h9.fsf@redhat.com>
 <20201024122007.GD32960@kernel.org>
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
In-reply-to: <20201024122007.GD32960@kernel.org>
Date:   Mon, 26 Oct 2020 11:29:46 -0700
Message-ID: <87o8kox2lh.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Jarkko Sakkinen @ 2020-10-24 05:20 MST:

> On Tue, Oct 20, 2020 at 04:10:42PM -0700, Jerry Snitselaar wrote:
>> 
>> Jarkko Sakkinen @ 2020-10-18 14:05 MST:
>> 
>> > On Tue, Oct 13, 2020 at 08:15:36AM -0700, Jerry Snitselaar wrote:
>> >> 
>> >> Jarkko Sakkinen @ 2020-10-12 18:17 MST:
>> >> 
>> >> > On Thu, Oct 01, 2020 at 11:09:20AM -0700, James Bottomley wrote:
>> >> >> The current state of the TIS TPM is that interrupts have been globally
>> >> >> disabled by various changes.  The problems we got reported the last
>> >> >> time they were enabled was interrupt storms.  With my own TIS TPM,
>> >> >> I've found that this is caused because my TPM doesn't do legacy
>> >> >> cycles, The TIS spec (chapter 6.1 "Locality Usage Per Register")
>> >> >> requires any TIS TPM without legacy cycles not to act on any write to
>> >> >> an interrupt register unless the locality is enabled.  This means if
>> >> >> an interrupt fires after we relinquish the locality, the TPM_EOI in
>> >> >> the interrupt routine is ineffective meaning the same interrupt
>> >> >> triggers over and over again.  This problem also means we can have
>> >> >> trouble setting up interrupts on TIS TPMs because the current init
>> >> >> code does the setup before the locality is claimed for the first time.
>> >> >> 
>> >> >> James
>> >> >
>> >> > You should consider expanding the audience. Jerry, once you have some
>> >> > bandwidth (no rush, does not land before rc2), it would be great that if
>> >> > you could try this. I'm emphasizing this just because of the
>> >> > intersection. I think it would also make senset to get tested-by from
>> >> > Nayna.
>> >> 
>> >> I will run some tests on some other systems I have access to. As noted
>> >> in the other email I did a quick test with a t490s with an older bios
>> >> that exhibits the problem originally reported when Stefan's patch
>> >> enabled interrupts.
>> >
>> > Thank you. As said, I can make a pull request to rc2 or even rc3, if
>> > needed.
>> >
>> > /Jarkko
>> 
>> So outside of the t490s I have access to, it looks like the nuc5 with
>> tpm2.0 device, and and older lenovo D30 with a tpm1.2 device both are
>> not using interrupts. I'm digging around to see if I can find some
>> other systems that I can test interrupts on.
>> 
>> Regards,
>> Jerry
>
> I'm going to test with this C720P chromebook, which has a long standing
> bug in the kernel bugzilla. I got it a while ago but it's stuck in the
> boot.
>
> If that doesn't boot, I'll pick up old Ivylake NUC from the office,
> which has TPM 1.2 and bit newer TPM 2.0 NUC. Should anyway pick them,
> have not used them for testing for a while because of pandemia.
>
> /Jarkko

My search continues through the systems in our labs. Running into the
same issue with the Dells. Looking at the TCPA table it looks like
they aren't set up for interrupts as well. I have some tpm2.0 systems
to still try.

Jerry

