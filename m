Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A9724A9AF
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Aug 2020 00:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHSWsU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 18:48:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31402 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726209AbgHSWsT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 18:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597877298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZFD28YYZsyQsBffYM0naGMCpkuLe/3iV2FQIzsyMw84=;
        b=NI4mRkRvVYRmoe66g/fdcPY23kuDfqxSThDgF5A6YmeSNa2vlQID+GQ4R9KJhmFSKiHsam
        oOPBVoINapeJVvLKhsG40sdTXR53yU1wegcW+SG8tMju0A+axRpVikzBs/BJHIjAkCyxHA
        ysTOWwKj9gPQ6yOR35PRK0p717wg/LA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-ri57KJPiNjmrjKC1ZN2mBA-1; Wed, 19 Aug 2020 18:48:15 -0400
X-MC-Unique: ri57KJPiNjmrjKC1ZN2mBA-1
Received: by mail-qv1-f70.google.com with SMTP id j13so40559qvi.17
        for <linux-integrity@vger.kernel.org>; Wed, 19 Aug 2020 15:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=ZFD28YYZsyQsBffYM0naGMCpkuLe/3iV2FQIzsyMw84=;
        b=AnMM2KzV8TJB83ND+jcVGeI/TSSH2CJJKE1PG8ZSRpXs8eCxqU/+lQFXgZw5GWcO8K
         QbpYh7YIMa1MpmaW4I2fmK7im+/PIeqTa3YfMVufqLmFg+UUegzPmMpqRSMyPvYPC0Mi
         KP/y4wGK6T/SqptD+v09gXrVrQ0OO+BsKhWZDxotywK4//888JndVsV5NDXgzSQjWdS4
         GtCWFbfLTDfeU/tZZh5QQgWMiTwQFOcru3iiuFZZ0lDip42qHr3YNHY7hKiob70bpBBL
         ef4KVZ/KMZCCzrrVPC1G3NhF2UtV7ckpt4RmASetIW/xRkabOmBXKA/dsdIuD0C6PSgu
         dPyw==
X-Gm-Message-State: AOAM531cS8Hiv9rdZ+zguwRm6xhT0zvkXE1FvSltiYP1ABAchgfXg2OE
        TFsMfYbtH+EBVRJheQ3i5F1Sx6BoxsHV7j2znDWLTUCyajABBqenUGMOqWepCHjucyyVQQupWzW
        k9h/fu7g91PTSiMNTS1LkkNPwRnpe
X-Received: by 2002:ac8:24d9:: with SMTP id t25mr122793qtt.15.1597877294914;
        Wed, 19 Aug 2020 15:48:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCGUJSMmJk1e1DvvXFa4/qRBrJdwEO1aClIDGu+v1KSRTsPhwiALJMybCW++SjWcZ5ZXW0Sg==
X-Received: by 2002:ac8:24d9:: with SMTP id t25mr122777qtt.15.1597877294626;
        Wed, 19 Aug 2020 15:48:14 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id z10sm633079qtf.24.2020.08.19.15.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 15:48:13 -0700 (PDT)
References: <20200818161955.GD137138@linux.intel.com> <20200818162630.GE137138@linux.intel.com> <20200818164602.GZ1152540@nvidia.com> <39eb6b408e7f060ab241954102d06f97d1f99611.camel@linux.ibm.com> <20200818183603.GC1152540@nvidia.com> <14eaf21a808e333ca414c954d8f3a2f7b6dbf2ca.camel@linux.ibm.com> <20200819120238.GD1152540@nvidia.com> <59f983156fed466d568c324de72ef733c1a15d76.camel@linux.ibm.com> <20200819140943.GH1152540@nvidia.com> <e33cca9a33a151cf35f12aca9dfd42378d632322.camel@linux.ibm.com> <20200819221647.GN9942@linux.intel.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Jason Gunthorpe <jgg@nvidia.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR registers
In-reply-to: <20200819221647.GN9942@linux.intel.com>
Date:   Wed, 19 Aug 2020 15:48:11 -0700
Message-ID: <87lfiamevo.fsf@jsnitsel.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Jarkko Sakkinen @ 2020-08-19 15:16 MST:

> On Wed, Aug 19, 2020 at 10:53:38AM -0400, Mimi Zohar wrote:
>> On Wed, 2020-08-19 at 11:09 -0300, Jason Gunthorpe wrote:
>> > On Wed, Aug 19, 2020 at 09:27:33AM -0400, Mimi Zohar wrote:
>> > > On Wed, 2020-08-19 at 09:02 -0300, Jason Gunthorpe wrote:
>> > > > On Tue, Aug 18, 2020 at 02:55:50PM -0400, Mimi Zohar wrote:
>> > > > 
>> > > > > The problem is that there isn't just one single userspace library or
>> > > > > application for reading PCRs.  So now not only is there the kernel
>> > > > > "boot_aggregate" regression testing, but regression testing of the tool
>> > > > > itself to support multiple methods of reading the PCRs.
>> > > > 
>> > > > I was thinking just open code 
>> > > >   open("/dev/tpm")
>> > > >   write(read_pcrs_cmd)
>> > > >   read(read_pcrs_cmd)
>> > > >  
>> > > > It isn't particularly hard to retrive the PCRs, don't really need to
>> > > > depend on a library.
>> > > 
>> > > Ok, do you want to contribute it to ima-evm-utils?  While you're at it,
>> > > do you also have code to parse the TPM 2.0 event log that you could
>> > > contribute?
>> > > 
>> > > Seriously, we shouldn't be (re-)writing code to do this.
>> > 
>> > The kernel should not be used a dumping ground to work around a
>> > dysfunctional userspace either. :(
>> > 
>> > You've basicaly said you can't rely on a sane userspace library
>> > because *reasons* so we need to dump stuff in the kernel instead.
>> > 
>> > It is not a good justification to add new uAPI.
>> > 
>> > James seems to have the same basic conclusion too, unfortunately.
>> 
>> "dysfunctional" is dropping existing TPM 1.2 sysfs support, which was
>> done without consideration about existing applications/tools (e.g. ima-
>> evm-utils, ltp) and without community input.  It's not only James that
>> is advocating for exporting the TPM PCRs, but Jerry Snitselaar, who
>> reviewed this patch and exported the TPM version, and Nayna Jain, who
>> exported the TPM 2.0 event log.  I'm pretty sure there are a number of
>> other people who would agree.
>> 
>> Mimi
>
> This is not true. TPM 1.2 sysfs was not dropped.
>
> Not adding something does not mean technically dropping something.
>
> /Jarkko

When reviewing it I honestly didn't give much(any?) thought to whether
it should be there. My thought was it adhered to the 1 value per file
rule unlike the 1.2 pcrs file and that was about it.

IIRC when 2.0 was added there was the issue of things like the 1.2 pcrs
not conforming to standards, possible issues of races, and a question of
what exactly should be exported.  1.2 has a number of files for doing
things that I think were also handled by ppi and userspace.

I guess the question is where does the line get drawn. My exporting the
major version of the tpm probably could've been handled instead with a
pr_info spitting it out for people to grab out of dmesg.


Jerry

