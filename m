Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5C428D1B6
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 18:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbgJMQFa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Oct 2020 12:05:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35039 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726744AbgJMQFa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Oct 2020 12:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602605127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p0Tz8evedSifogb9rZCuS/Xg4EHTVNHYINzvoRUEKpc=;
        b=H8qyh9WTjYh3cNDToEhdsZ4hLfChhzZa6psNf/USCGp45tQM6OC792O8DqIwIlCWzr0eHq
        /wShDzHlGHeNF8mMBM+SMaor+bRcbKPt9thhfyGpPmC7DgeF7n28GJoC3cFL8obtHwit5k
        pFviwuGC9uzEikS+LWK5ne6m9Efu5kw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-y0Cv40C6OjaeKpqyXwVC0A-1; Tue, 13 Oct 2020 12:05:25 -0400
X-MC-Unique: y0Cv40C6OjaeKpqyXwVC0A-1
Received: by mail-qt1-f198.google.com with SMTP id n8so179180qtf.10
        for <linux-integrity@vger.kernel.org>; Tue, 13 Oct 2020 09:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=p0Tz8evedSifogb9rZCuS/Xg4EHTVNHYINzvoRUEKpc=;
        b=HHwgx0I/oavqe3qFfMR5d8POXwB5HQiJUqXH2Zk8BGWLUqPMyM9bg7ZgjRAQOso/Gy
         BfEtloglqjvCjXxgl0+oEgcubmaytQ4TFZCk+CI7jd0HOEFM7Svb6Ur8Er5ztShyQERr
         r6vxUwqShDGuCJTtNM2KFiMmCrgr5lw2Bra9X8/wMVHDohiqf1c4Ng4fjZbVrhVodKWZ
         ceVSzgRWzWI9D3w0Y+6vXVBpPkZuDnc74JvcBnB/40LkdamCaPXdAaLjYmX8GOpy0O6e
         TEtrif0Qeli54Q78QvtHQ0Gn8+CbJQoWPjLQVjzx8iW+K8hTk+FoL0GaEcMRNjDeGHQy
         34kg==
X-Gm-Message-State: AOAM532jjGwFD8hmDKyDEz9VENYRxq6pdLnpcdIZpc+ork+pZTpaxpoP
        pQjM3Xd3UjtcOjMyNmeNxGH4iU7jNyzqzuAJQB9Tb5VLUf5fCjsa9zqSHT9x69FmxJpbnOraq/s
        TyJvAwUMXLyWw9WJngxjgPjSFvICq
X-Received: by 2002:a05:622a:104:: with SMTP id u4mr338290qtw.163.1602605123619;
        Tue, 13 Oct 2020 09:05:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJye+1/GTcdh4j7pmy7I1w2pa6l+jP5JZppoXEyZ7Ad1GjG1Ogaitgbl1Oozy43Bi3gCY5s+Jw==
X-Received: by 2002:a05:622a:104:: with SMTP id u4mr338250qtw.163.1602605123276;
        Tue, 13 Oct 2020 09:05:23 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id 61sm100143qta.19.2020.10.13.09.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 09:05:22 -0700 (PDT)
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201013011745.GA41176@linux.intel.com>
 <87tuuyf97r.fsf@jsnitsel.users.ipa.redhat.com>
 <e6930fa6df318ee2f51e13f6402d264fedb5d9ab.camel@HansenPartnership.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     equired@linux.intel.com,
        justmentioningitbecauseIthinkthatwouldbeagood@linux.intel.com,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        "Peter Huewe" <peterhuewe@gmx.de>, Borislav Petkov <bp@alien8.de>,
        Nayna Jain <nayna@linux.ibm.com>,
        Hans de Goede <jwrdegoede@fedoraproject.org>
Subject: Re: [PATCH v2 0/5] tpm_tis: fix interrupts (again)
In-reply-to: <e6930fa6df318ee2f51e13f6402d264fedb5d9ab.camel@HansenPartnership.com>
Date:   Tue, 13 Oct 2020 09:05:19 -0700
Message-ID: <87lfgaf6ww.fsf@jsnitsel.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


James Bottomley @ 2020-10-13 08:24 MST:

> On Tue, 2020-10-13 at 08:15 -0700, Jerry Snitselaar wrote:
>> Jarkko Sakkinen @ 2020-10-12 18:17 MST:
>> 
>> > On Thu, Oct 01, 2020 at 11:09:20AM -0700, James Bottomley wrote:
>> > > The current state of the TIS TPM is that interrupts have been
>> > > globally disabled by various changes.  The problems we got
>> > > reported the last time they were enabled was interrupt
>> > > storms.  With my own TIS TPM, I've found that this is caused
>> > > because my TPM doesn't do legacy cycles, The TIS spec (chapter
>> > > 6.1 "Locality Usage Per Register") requires any TIS TPM without
>> > > legacy cycles not to act on any write to an interrupt register
>> > > unless the locality is enabled.  This means if an interrupt fires
>> > > after we relinquish the locality, the TPM_EOI in the interrupt
>> > > routine is ineffective meaning the same interrupt triggers over
>> > > and over again.  This problem also means we can have trouble
>> > > setting up interrupts on TIS TPMs because the current init
>> > > code does the setup before the locality is claimed for the first
>> > > time.
>> > > 
>> > > James
>> > 
>> > You should consider expanding the audience.
>
> Well, most people interested in testing this sort of thing are already
> on the integrity list.
>
>> >  Jerry, once you have some bandwidth (no rush, does not land before
>> > rc2), it would be great that if you could try this. I'm emphasizing
>> > this just because of the intersection. I think it would also make
>> > senset to get tested-by from Nayna.
>> 
>> I will run some tests on some other systems I have access to. As
>> noted in the other email I did a quick test with a t490s with an
>> older bios that exhibits the problem originally reported when
>> Stefan's patch enabled interrupts.
>
> Well, it means there's still some other problem.  I was hoping that
> because the rainbow pass system originally exhibited the same symptoms
> (interrupt storm) fixing it would also fix the t490 and the ineffective
> EOI bug looked like a great candidate for being the root cause.
>

Adding Hans to the list.

IIUC in the t490s case the problem lies with the hardware itself. Hans,
is that correct?

> How amenable are you to debugging this?  I originally figured out the
> problem with the rainbow pass by putting ratelimited printks in the
> interrupt routine and most of the TIS transmission ones, but it's
> somewhat labour intensive doing it this way.
>
> James

