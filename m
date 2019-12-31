Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2A9012D541
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Dec 2019 01:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfLaAaM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Dec 2019 19:30:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26525 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727773AbfLaAaL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Dec 2019 19:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577752208;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=CmG+h3tRmKPV6GlWBKqAXgSLCXrn4ZTuXu3w4hBTz5U=;
        b=aFe6e9G7wgogsxnshI6/HfZ2NQELVkGB/jpYbc6L7IZjTgkPwG7Ni9mrWRLkzXOp2ZJvgx
        lgKUlBCn2U7t9CtAsrbaXGv6hLqiFi0lmIBJReUt8+plNYr0WFmZX1IXiccoH6XFyghuxk
        iXpjTaIHAM72PYmEOufmoaQCr7Ip7FE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-FEevg_D3MHy5cqyP8fy2aw-1; Mon, 30 Dec 2019 19:30:07 -0500
X-MC-Unique: FEevg_D3MHy5cqyP8fy2aw-1
Received: by mail-pj1-f69.google.com with SMTP id n90so669469pji.6
        for <linux-integrity@vger.kernel.org>; Mon, 30 Dec 2019 16:30:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=CmG+h3tRmKPV6GlWBKqAXgSLCXrn4ZTuXu3w4hBTz5U=;
        b=agaM50K/WdgkXccUkxHEuGqslBoLhAFP2aF89/hHRP91rTxgps0YCWXKPPp5Ob7vVY
         FLr48kAMG+YX+bqqVCKtPWxqZD5j9bt7GJ+8nkc/LMG+Emx47FqBgQEpkc8L8R0Hx9DW
         NSbngDnrbYRdbDwI2iI5SCjRqUCUnOO1g83msu5fpeRm/mh9M4cvmIqD8Yqu+QsiNGcd
         7xvm/LkQjmevJmjK+e7u/tVn2kaho94fj/qnUwy1xVQltgzi+x6iBQAH8SbsQOC1tYoj
         hJPyFWdc3j7RMKWWN7NMURrsyhFDQFOOPFOIsFwbGGum2VddsMdYgyyNlb8EStyNrrtE
         p0lw==
X-Gm-Message-State: APjAAAVPtsXGIuLRJ8bwGdl8tM6lDFNI+PjJom2Rp4cQ55fayjrMB9Ml
        o7NjAuyQkzOq2ZidWtxcKghRnomdj6D7dKylnh6vRSPEFbuvsmX9n4JXup9J+RbgYKfl1oDjKXO
        zbvbtQlCkQ3b4xIQNLNoIlFslf5Yy
X-Received: by 2002:a63:3089:: with SMTP id w131mr77651542pgw.453.1577752205952;
        Mon, 30 Dec 2019 16:30:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqwOYmQVS88FaD4PpQrwOLahdl7tuhktgNWnaNvhbz0oJvAazo1lJ0LTduXgrr43BtDQVobOgA==
X-Received: by 2002:a63:3089:: with SMTP id w131mr77651516pgw.453.1577752205591;
        Mon, 30 Dec 2019 16:30:05 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id a26sm44385990pfo.27.2019.12.30.16.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 16:30:04 -0800 (PST)
Date:   Mon, 30 Dec 2019 17:30:00 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch "tpm_tis: reserve chip for duration of tpm_tis_core_init"
 has been added to the 5.4-stable tree
Message-ID: <20191231003000.ywdvfjdhqadnl6wo@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Dan Williams <dan.j.williams@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1577122577157232@kroah.com>
 <CAPcyv4jfpOX85GWgNTyugWksU=e-j=RhU_fcrcHBo4GMZ8_bhw@mail.gmail.com>
 <c6ce34b130210d2d1330fc4079d6d82bd74dcef1.camel@linux.intel.com>
 <50217a688ffa56cf5f150ffd358daba2a88cad48.camel@linux.intel.com>
 <20191228151526.GA6971@linux.intel.com>
 <CAPcyv4i_frm8jZeknniPexp8AAmGsaq0_DHegmL4XZHQi1ThxA@mail.gmail.com>
 <CAPcyv4iyQeXBWvp8V_UPBsOk29cfmTVZGYrrDgyYYqzsQvTjNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPcyv4iyQeXBWvp8V_UPBsOk29cfmTVZGYrrDgyYYqzsQvTjNA@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun Dec 29 19, Dan Williams wrote:
>On Sat, Dec 28, 2019 at 9:17 AM Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> On Sat, Dec 28, 2019 at 7:15 AM Jarkko Sakkinen
>> <jarkko.sakkinen@linux.intel.com> wrote:
>> >
>> > On Fri, Dec 27, 2019 at 08:11:50AM +0200, Jarkko Sakkinen wrote:
>> > > Dan, please also test the branch and tell if other patches are needed.
>> > > I'm a bit blind with this as I don't have direct access to the faulting
>> > > hardware. Thanks. [*]
>> > >
>> > > [*] https://lkml.org/lkml/2019/12/27/12
>> >
>> > Given that:
>> >
>> > 1. I cannot reproduce the bug locally.
>> > 2. Neither of the patches have any appropriate tags (tested-by and
>> >    reviewed-by). [*]
>> >
>> > I'm sorry but how am I expected to include these patches?
>>
>> Thanks for the branch, I'll get it tested on the failing hardware.
>> Might be a few days due to holiday lag.
>
>This looked like the wrong revert to me, and testing confirms that
>this does not fix the problem.
>
>As I mentioned in the original report [1] the commit that bisect flagged was:
>
>    5b359c7c4372 tpm_tis_core: Turn on the TPM before probing IRQ's
>
>That commit moved tpm_chip_start() before irq probing. Commit
>21df4a8b6018 "tpm_tis: reserve chip for duration of tpm_tis_core_init"
>does not appear to change anything in that regard.
>
>Perhaps this hardware has always had broken interrupts and needs to be
>quirked off? I'm trying an experiment with tpm_tis_core.interrupts=0
>workaround.
>

Hi Dan,

Just to make sure I understand correctly are you saying you still have
the screaming interrupt with the flag commit reverted, or that it is
polling instead of using interrupts [2]? Was that testing with both
commits reverted, or just the flag commit?  What kernel were you
running before you saw the issue with 5.3 stable?  On that kernel you
weren't seeing the polling message, and interrupts were working?  Are
you able to boot a 5.0 kernel on the system? It would be interesting
to see how it was behaving before the power gating changes. I think it
would be using polling due to how the code behaves because of that
flag. It looks like without the flag being enabled by Stefan's commit
TPM_GLOBAL_INT_ENABLE will never get cleared because tpm_tis_probe_irq_single
expects tpm_tis_send to clear it if there is a problem, and without the
flag being set that whole section of code is skipped.

Unfortunately I'm having no luck tracking down a system where I can actually
test and debug this interrupt code.

Reverting the following commits should get you to a point where it is using
polling at least. This will bring back Christian's problem with tpm_get_timeouts
failing, but that can be solved with wrapping that with tpm_chip_start/tpm_chip_stop.
Christian, were you having any issues with interrupts? You system was going into
this code as well.

21df4a8b6018 | 2019-12-17 | tpm_tis: reserve chip for duration of tpm_tis_core_init (Jerry Snitselaar)
1ea32c83c699 | 2019-09-02 | tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts (Stefan Berger)
5b359c7c4372 | 2019-09-02 | tpm_tis_core: Turn on the TPM before probing IRQ's (Stefan Berger)

Jarkko, another problem has been reported that appears to have shown up around the time of the gating changes:

[    4.098104] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
[    5.138572] ima: Error Communicating to TPM chip
[    5.143727] ima: Error Communicating to TPM chip
[    5.148881] ima: Error Communicating to TPM chip
[    5.154037] ima: Error Communicating to TPM chip
[    5.159209] ima: Error Communicating to TPM chip
[    5.164370] ima: Error Communicating to TPM chip
[    5.169517] ima: Error Communicating to TPM chip
[    5.174673] ima: Error Communicating to TPM chip

I've located a system where it occurs, so I'll try to bisect and figure out what is going wrong.

Regards,
Jerry

[2] https://lore.kernel.org/linux-integrity/CAPcyv4iepQup4bwMuWzq6r5gdx83hgYckUWFF7yF=rszjz3dtQ@mail.gmail.com/

>
>[1]: https://lore.kernel.org/linux-integrity/CAA9_cmeLnHK4y+usQaWo72nUG3RNsripuZnS-koY4XTRC+mwJA@mail.gmail.com/
>

