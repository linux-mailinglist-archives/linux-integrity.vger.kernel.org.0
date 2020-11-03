Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3787B2A5A68
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Nov 2020 00:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbgKCXAj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Nov 2020 18:00:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729575AbgKCXAj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Nov 2020 18:00:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604444437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L9mfvxxDVnXE7HOJwrh1dWYZDDV6c0U7iEZhRVZ6LsA=;
        b=fyCwM1zalGZYGR8FnQVI4/4oA3K3C83qRqtKW+HY/vE+YCxTs1EnoK8i0AkU71/PzfsYoF
        iO08kvYVKd6J99nrFAQiupN3ENRb+1fmXtN6JwqOsfKbMqQuq8qV/K+AWfrZFnWq01hqA7
        rQVJMlM93EnCoYxwMUQRxLA2E46mL1E=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-k_63LZnHOBanvlx1Kt6gwA-1; Tue, 03 Nov 2020 18:00:35 -0500
X-MC-Unique: k_63LZnHOBanvlx1Kt6gwA-1
Received: by mail-ot1-f72.google.com with SMTP id j17so2252016ots.9
        for <linux-integrity@vger.kernel.org>; Tue, 03 Nov 2020 15:00:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=L9mfvxxDVnXE7HOJwrh1dWYZDDV6c0U7iEZhRVZ6LsA=;
        b=mQNxVTMEv0iaP7PZbvAVaBwlLEykaOBmZgfIbMMst5kOL54yh1/nO9dUwTIt03t1ms
         568K/w1OKFukelGTjQJtIqdT4mEVtoKYCxznNa5HMEy35pV5EHMcdn9IuNgM3UTUs8Pk
         MGwtwqg11CZQ3CJtzq6HTT81cVaJnm7hqpccu+nvVhcORLleI+nZiCqJ7fdoyj/XbHWv
         xJ+dIms5uqkFR5JGssqDDIzvAMkQyoVjBYzJvIInayaTC2UiFiDnO+1zT95WxAsqXe8h
         YnD540iEYKowL99MJ+ogQvtNxWv54B7vERgVazQq805AyC71X53BFi6rKVLhp+pQWRxZ
         SucA==
X-Gm-Message-State: AOAM533Ev0yhwf0JIUhJwoz62xTwOFqfFQXCoLHGGVsCwxZHX2wMRC3w
        zIIukI6wxsryD/bTXpky/yLbiwzqsctpk2j6m7IBvEI4aqcakOujWog21TBPHnu7LrNnfuFiF4t
        ybmEb5KfLldl8FhL9TtJZB6iYsKYB
X-Received: by 2002:aca:170b:: with SMTP id j11mr887728oii.144.1604444434601;
        Tue, 03 Nov 2020 15:00:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJJxNSO7pcBmscWcHKdrQvDPEeReH0WhdtKAT2BaOjB5CQk+5NzdEGGIbbX3suo2gefaFuvg==
X-Received: by 2002:aca:170b:: with SMTP id j11mr887715oii.144.1604444434414;
        Tue, 03 Nov 2020 15:00:34 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id e3sm21931oig.31.2020.11.03.15.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 15:00:33 -0800 (PST)
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-5-James.Bottomley@HansenPartnership.com>
 <87zh4hg4wg.fsf@redhat.com> <20201024121718.GC32960@kernel.org>
 <20201030124335.GD522355@kernel.org>
 <837dbe43b7507a765553260289de5fd8eee397c4.camel@HansenPartnership.com>
 <87sg9vbsnh.fsf@redhat.com> <20201103044328.GA58053@kernel.org>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 4/5] tpm_tis: fix IRQ probing
In-reply-to: <20201103044328.GA58053@kernel.org>
Date:   Tue, 03 Nov 2020 16:00:29 -0700
Message-ID: <87pn4uoxki.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Jarkko Sakkinen @ 2020-11-02 21:43 MST:

> On Fri, Oct 30, 2020 at 09:11:30AM -0700, Jerry Snitselaar wrote:
>> 
>> James Bottomley @ 2020-10-30 08:49 MST:
>> 
>> > On Fri, 2020-10-30 at 14:43 +0200, Jarkko Sakkinen wrote:
>> > [...]
>> >> I tested this with:
>> >> 
>> >> - 
>> >> https://ark.intel.com/content/www/us/en/ark/products/84861/intel-nuc-kit-nuc5i5myhe.html
>> >>   dTPM 1.2
>> >> - 
>> >> https://ark.intel.com/content/www/us/en/ark/products/74483/intel-nuc-kit-dc53427hye.html
>> >>   dTPM 2.0
>> >> 
>> >> I did not get "TPM interrupt not working, polling instead" to klog.
>> >> But I neither see tpm0 in /proc/interrupts. What I'm doing wrong?
>> >
>> > That's usually what you get when ACPI specifies the interrupt isn't
>> > connected (we don't try to probe it).
>> >
>> > James
>> 
>> That is the problem I've been running into. When I do find a system
>> with a tpm and using tpm_tis, it usually seems to not have the interrupt
>> connected.
>> 
>> Should this commit have:
>> 
>> Fixes: 570a36097f30 ("tpm: drop 'irq' from struct tpm_vendor_specific")
>> 
>> That is where TPM_CHIP_FLAG_IRQ was added and not set for tpm_tis.
>
> Have you tested 4eea703caaac?
>
> /Jarkko

Is that the right commit id?

4eea703caaac tpm: drop 'iobase' from struct tpm_vendor_specific | 2016-06-25 | (Christophe Ricard)

