Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2D73A67F3
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Jun 2021 15:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhFNNfm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Jun 2021 09:35:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41638 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233298AbhFNNfm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jun 2021 09:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623677618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9WIoH3bMxlzEbaNs643nVHUek4HkoIBLDMy1+LRw8LQ=;
        b=gb/CMba6WV49KjWra/I/Db4c7JtGbI5aBTLo17jrArtdU4q9RlFft0/fB79zNmViX6Yar+
        QsIyN4J4F9H6BuwcRHdysf6uyx3y8Dihdso8bwbp3lWY/ZUXOri+ZuUYe87eTN0TpIYAO7
        V5x6EHjfrJ/D6CS2kyZ+kUj8lZl4w8A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-p6y9jBa8P7C7Ndl3yXBRjQ-1; Mon, 14 Jun 2021 09:33:36 -0400
X-MC-Unique: p6y9jBa8P7C7Ndl3yXBRjQ-1
Received: by mail-ed1-f72.google.com with SMTP id v8-20020a0564023488b0290393873961f6so12875924edc.17
        for <linux-integrity@vger.kernel.org>; Mon, 14 Jun 2021 06:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9WIoH3bMxlzEbaNs643nVHUek4HkoIBLDMy1+LRw8LQ=;
        b=jsfntxhZdv+R5FvIi+axeEt4EhJG1lCXORU2h7nuDR1Lh8CIEghVdmrfqfClgMtzpw
         F+SWzAOT9XrcL2fhq1KGDDiRtPPEDXzcTTOuS7AQbr8H+9cwgXamPN8STNirhzpCQeJE
         G4a50gmGwuyyvl+W+BOYvdYuZDpMAOKZ2wd9g6zUdsWjTlJGkCpQixM0jCDgj8ObFzYK
         L1Pf8GdR9b7IuxUhJOIhx0p8eSj4Xex6rmKSleebCB/FYHDWAAMMSh4GBwRDNwM8tJbK
         AaAJMWDgONhAh57oBHXGvCDmYZla0jPspbf9ncpMx/g1BR5N8Bujbf8ZHoewi7eL0eTp
         MYIg==
X-Gm-Message-State: AOAM530uAdY83PlMQ2C6M4rzezY8DyOjjnAoMa7jlh15RiJ8trQDksCe
        vL/onICOBcU6zY/JMKqhgZUCH0V1gMlU+ISNpVNRtIr+/BEW0hQdOX0UXbmRcQBnCLUcLKqlvQx
        n4pyTPM061zY8Y4fNDeGlV1kpeuc+
X-Received: by 2002:a17:906:2da1:: with SMTP id g1mr15061040eji.47.1623677614756;
        Mon, 14 Jun 2021 06:33:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyz7aBGBmWm4rrwVqIkHZ2KmRn9EglFNn0x93pFjopsH0bw4GoXEEKATGZZziEUDupFP4S9eQ==
X-Received: by 2002:a17:906:2da1:: with SMTP id g1mr15061021eji.47.1623677614546;
        Mon, 14 Jun 2021 06:33:34 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id br21sm7359551ejb.124.2021.06.14.06.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 06:33:34 -0700 (PDT)
Subject: Re: Recent tpm_tis IRQ handling changes are causing kernel backtraces
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <34442b17-c8e6-9d33-831f-fcbf3a38552b@redhat.com>
 <e4afc566-0114-c5a3-ebda-a775132e999d@redhat.com>
 <YFEEas6kH3FUoKJe@kernel.org>
 <8b592417-dc1d-a7f8-0e17-09b6bb1df33a@redhat.com>
 <YJlsdgxPIm5I6Jk8@kernel.org>
 <4f525bca-3836-7f5c-7913-e54d620473aa@redhat.com>
 <81aa6340-f854-8f26-f599-03b116cc3c29@redhat.com>
 <20210527140025.vl3ply6wnn7rsygg@kernel.org>
 <27d71b81-1e89-1b5d-ddaf-a8928bac90fd@redhat.com>
 <20210531043616.u3v25qzkkrik5apq@kernel.org>
 <89d5b891-97d8-caed-4eb1-6d4d485a2fd1@redhat.com>
Message-ID: <5680899e-9040-7641-e6ac-23edd2d988cf@redhat.com>
Date:   Mon, 14 Jun 2021 15:33:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <89d5b891-97d8-caed-4eb1-6d4d485a2fd1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 6/1/21 6:04 PM, Hans de Goede wrote:
> Hi,
> 
> On 5/31/21 6:36 AM, Jarkko Sakkinen wrote:
>>> Interestingly enough the first backtrace is also happening on a:
>>> "Dell Inc. XPS 13 9310/0MRT12, BIOS 2.2.0 04/06/2021"
>>>
>>> So it seems that at least with 5.12.6 (which has the last 2 fixes)
>>> all reports are about the XPS 13 9310. I wonder if there is an
>>> issue with the TPM interrupt line on the XPS 13 9310; I've asked the
>>> reporters to try adding tpm_tis.interrupts=0 to their kernel commandline.
>>
>> This is helpful for sure that these all are happening on matching hardware.
> 
> So our kernel-backtrace tracking info (ABRT) just recorded a third backtrace
> with a kernel >= 5.12.6, again on the XPS 13 9310, so now we have 3 variants:
> 
> 1. Backtrace starting with a call to ima_add_boot_aggregate
> https://bugzilla.redhat.com/show_bug.cgi?id=1963712
> 
> 2. Backtrace starting with a call to tpm_dev_async_work:
> https://bugzilla.redhat.com/show_bug.cgi?id=1964974
> (note this one is not easily reproducible)
> 
> 3. Backtrace starting with a call to rng_dev_read:
> https://bugzilla.redhat.com/show_bug.cgi?id=1920510
> 
> 3. is the new one. All bugs linked above are public, all 3 backtraces
> so far have only been reported on the XPS 13 9310 (with kernel >= 5.12.6)
> and I've asked all the reporters to check if tpm_tis.interrupts=0 helps.

Quick status update, I've got a response from a XPS 13 9310 user in:

https://bugzilla.redhat.com/show_bug.cgi?id=1920510

Indicating that a. he can reproduce this with the latest >= 5.12.6 kernels;
and b. it goes away when specifying tpm_tis.interrupts=0 as I expected
(I expected this because all the bug-reports started when the interrupt
code got fixed/re-enabled a while ago).

Si I think that there just is something broken wrt the interrupt setup
on the XPS 13 9310 and that we should probably add an antry for the
XPS 13 9310 to the already existing tpm_tis_dmi_table pointing to the
also already existing tpm_tis_disable_irq callback.

If other people agree that that is probably the best way forward ?
then I can prepare a patch and ask the user to test this.

Regards,

Hans



