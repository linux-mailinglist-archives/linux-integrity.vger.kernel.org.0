Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4A601221C7
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Dec 2019 03:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfLQCAa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Dec 2019 21:00:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21426 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726133AbfLQCA3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Dec 2019 21:00:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576548027;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=rPjKUP3c5OBgFxjGzOJRPYxmS5qHOOKhkgjmkw+YN2I=;
        b=GRv3q7R1DJYZDD3PgdWg3qSLYytVgP+gPIfWPQHf/CzRjl3bB5J5DfcI87DR7wFzeYG8ui
        JH/9wxd91NXfgEMPVZYijnQN2frcREMMjp2GZuuNMoWxLmx3sOjMYXRUO2jCPq4tKNzwJM
        FxHp9zUYxKI01pOcrWXdPSeKeRz57cU=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-Jn6oDZShO82gDbec7R57xA-1; Mon, 16 Dec 2019 21:00:26 -0500
X-MC-Unique: Jn6oDZShO82gDbec7R57xA-1
Received: by mail-yb1-f197.google.com with SMTP id x186so8032701yba.6
        for <linux-integrity@vger.kernel.org>; Mon, 16 Dec 2019 18:00:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=rPjKUP3c5OBgFxjGzOJRPYxmS5qHOOKhkgjmkw+YN2I=;
        b=eIuSXmmc5M0/tOLqICBuKJcWU3B5MVHw+gwgkgb3eTPaU+D4brXGTsYL2lqb1wvNxW
         DAtVfD+dbDJDzcqyDK5ELNIsb3N3RuVgQwqbhUgJovHr0MSFigxsDeq104xlvdH2xsBw
         +08FKvSELosjU9nkRYwJojBt4WeKrujFESIE8Z8Vdby7CUYYM07lcRTwAAnhA7jdRuvC
         LL9fHzeIUWzd5VO9sw5JYQI+xToDjJ4GBLUg2BXucoJ0L2+sV3qYBql8fpGk7UAd8W9E
         afn30Xmj3zmlzR5NzbTlo2ANuMMSyw9OGZL0Q8T6Xebo5dDm3/Ho++z5brYilqvTnakw
         sxlQ==
X-Gm-Message-State: APjAAAXaE+qHALAcK3b22JDoUdbwVhvqCh8UlvMDYfnNhHr0efI+v90U
        KNUZYSUzK2o8cLpVzGaZBLnQDp8yrRMa5NaZs9+KzBwt8up4sqG0EFtbz0UIseLxETzfWDDQ3MJ
        bTGdahoD97/dCdcvWgTqiAg6AVK0n
X-Received: by 2002:a25:8c9:: with SMTP id 192mr4617225ybi.328.1576548025512;
        Mon, 16 Dec 2019 18:00:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqzSHXlqGOcOwe8mrQawvzd98LxvqAZaVnHrkCZ/xB8ek5ZKZOwysxZHuTASPJ2GCZv3Avp1zw==
X-Received: by 2002:a25:8c9:: with SMTP id 192mr4617202ybi.328.1576548025222;
        Mon, 16 Dec 2019 18:00:25 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id n1sm2256975ywe.78.2019.12.16.18.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 18:00:24 -0800 (PST)
Date:   Mon, 16 Dec 2019 19:00:22 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm_tis: reserve chip for duration of
 tpm_tis_core_init
Message-ID: <20191217020022.knh7uxt4pn77wk5m@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Dan Williams <dan.j.williams@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>, linux-integrity@vger.kernel.org
References: <20191211231758.22263-1-jsnitsel@redhat.com>
 <20191211235455.24424-1-jsnitsel@redhat.com>
 <5aef0fbe28ed23b963c53d61445b0bac6f108642.camel@linux.intel.com>
 <CAPcyv4h60z889bfbiwvVhsj6MxmOPiPY8ZuPB_skxkZx-N+OGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPcyv4h60z889bfbiwvVhsj6MxmOPiPY8ZuPB_skxkZx-N+OGw@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon Dec 16 19, Dan Williams wrote:
>On Mon, Dec 16, 2019 at 4:59 PM Jarkko Sakkinen
><jarkko.sakkinen@linux.intel.com> wrote:
>>
>> On Wed, 2019-12-11 at 16:54 -0700, Jerry Snitselaar wrote:
>> > Instead of repeatedly calling tpm_chip_start/tpm_chip_stop when
>> > issuing commands to the tpm during initialization, just reserve the
>> > chip after wait_startup, and release it when we are ready to call
>> > tpm_chip_register.
>> >
>> > Cc: Christian Bundy <christianbundy@fraction.io>
>> > Cc: Dan Williams <dan.j.williams@intel.com>
>> > Cc: Peter Huewe <peterhuewe@gmx.de>
>> > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> > Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> > Cc: stable@vger.kernel.org
>> > Cc: linux-integrity@vger.kernel.org
>> > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
>> > Fixes: 5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing IRQ's")
>> > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>>
>> I pushed to my master with minor tweaks and added my tags.
>>
>> Please check before I put it to linux-next.
>
>I don't see it yet here:
>
>http://git.infradead.org/users/jjs/linux-tpmdd.git/shortlog/refs/heads/master
>
>However, I wanted to make sure you captured that this does *not* fix
>the interrupt issue. I.e. make sure you remove the "Fixes:
>5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing IRQ's")"
>tag.
>
>With that said, are you going to include the revert of:
>
>1ea32c83c699 tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts

Dan, with the above reverted do you still get the screaming interrupt?

>5b359c7c4372 tpm_tis_core: Turn on the TPM before probing IRQ's
>
>...in your -rc3 pull?
>

