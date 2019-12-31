Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4F0312D550
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Dec 2019 01:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfLaAeD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Dec 2019 19:34:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50327 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727781AbfLaAeD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Dec 2019 19:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577752442;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=qftNDtaZo3ULGRqvQSgu3WPfMkeZPf0iuGFu53nIq9A=;
        b=FWgzqnoC0+cgC7z17B9NDaUxzoNpYN0IW9CaD77A3BVtprrZmmRs6qNFZ53njh2nTCb7MK
        /U4xOS8gabOBbuicWe+AYoKMLeoHJ3VUO07I7CTdrSg744BrJxtPO+R/JXSu5etlkTeaNQ
        /KU4cjRHc4gM/Cgjm6siPDlpUHtQCm4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223--eRxpYzgM1GMDrlYVCfAeg-1; Mon, 30 Dec 2019 19:34:00 -0500
X-MC-Unique: -eRxpYzgM1GMDrlYVCfAeg-1
Received: by mail-pj1-f72.google.com with SMTP id q88so685662pjb.2
        for <linux-integrity@vger.kernel.org>; Mon, 30 Dec 2019 16:34:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=qftNDtaZo3ULGRqvQSgu3WPfMkeZPf0iuGFu53nIq9A=;
        b=PQe5i1oE0YHBsuJ/Pwj9mXUx1NvbGZohD2jY/FN77UmXvq8vXlQUSV7pOcakNPLPbR
         AN4sivfG6BdZwcd8oJrsyb1H6L6S/26FUYvNvc65WYhrqNsYJexUL2DI9mcHnuK1Gguv
         MRT3QZ64vEowFnmohghxH1jHWwjf3o8yZFnj9WuTBySGkWmjW2misUVlGqm+aHjrNRhd
         8VYjvZtaURz/dAzYs76C04DumB5B98jVrzsG3UnoMUWytTwfGa9Ez8r1ZxTCtMgCXwrs
         h0zhGIx6QJRTfLy5P1Ub4PJ7xWQko4+5DW2AMM+WbNE7jBhUVE8nq6vuj78DO+t9nmLk
         0sOA==
X-Gm-Message-State: APjAAAUCFGNq7wbnlUaVIhbWFR50e3eFCSdKZcreVwYNqNbaOzwkn60v
        H5hHEU0MO6gEIue6I0fqz217a8MguD2MwoV5sCLJMxbEk+woM4iTTjjiXtFUIobg9HKTdzqtXJZ
        HaUy2injx4ewOoTvhyUx1IjuQUK/m
X-Received: by 2002:a63:cf08:: with SMTP id j8mr73919641pgg.292.1577752439963;
        Mon, 30 Dec 2019 16:33:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqwZwkkMBxFxll1aEN5EY1ibYiENvv7pvVZS4C3JEyBBDfqQzdb6HcWQEGzKVHCoU+cXWgAeDw==
X-Received: by 2002:a63:cf08:: with SMTP id j8mr73919621pgg.292.1577752439734;
        Mon, 30 Dec 2019 16:33:59 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id d2sm749409pjv.18.2019.12.30.16.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 16:33:58 -0800 (PST)
Date:   Mon, 30 Dec 2019 17:33:55 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch "tpm_tis: reserve chip for duration of tpm_tis_core_init"
 has been added to the 5.4-stable tree
Message-ID: <20191231003355.l4zhdingdw5h2ntx@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
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
 <2c4a80e0d30bf1dfe89c6e3469d1dbfb008275fa.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <2c4a80e0d30bf1dfe89c6e3469d1dbfb008275fa.camel@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Dec 31 19, Jarkko Sakkinen wrote:
>On Sun, 2019-12-29 at 23:41 -0800, Dan Williams wrote:
>> This looked like the wrong revert to me, and testing confirms that
>> this does not fix the problem.
>>
>> As I mentioned in the original report [1] the commit that bisect flagged was:
>>
>>     5b359c7c4372 tpm_tis_core: Turn on the TPM before probing IRQ's
>>
>> That commit moved tpm_chip_start() before irq probing. Commit
>> 21df4a8b6018 "tpm_tis: reserve chip for duration of tpm_tis_core_init"
>> does not appear to change anything in that regard.
>>
>> Perhaps this hardware has always had broken interrupts and needs to be
>> quirked off? I'm trying an experiment with tpm_tis_core.interrupts=0
>> workaround.
>>
>>
>> [1]: https://lore.kernel.org/linux-integrity/CAA9_cmeLnHK4y+usQaWo72nUG3RNsripuZnS-koY4XTRC+mwJA@mail.gmail.com/
>
>I think for short term, yes, it is better to revert the commits
>that make things more broken.
>
>for-linus-v5.5-rc5 branch contains three commits that exactly do
>this i.e. the reverts that Stefan sent and revert to Jerry's earlier
>commit.
>
>After that is out of the table it is easier to analyze how the code
>should be actually refactored. Like, I have no idea when I get
>local HW that can reproduce this and Jerry still seems to have the
>same issue. It'd be nice make the exactly right changes instead of
>reverts but situation is what it is.
>

Unfortunately I haven't found a system yet where I get into this code
path. So I've been relying on Dan's testing and the owner of the
t490s.

>Please check the branch and ACK/NAK if I can add tested-by's (and
>other tags).
>
>/Jarkko
>

