Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28D391221E5
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Dec 2019 03:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfLQCPK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Dec 2019 21:15:10 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41826 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfLQCPG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Dec 2019 21:15:06 -0500
Received: by mail-ot1-f66.google.com with SMTP id r27so11589252otc.8
        for <linux-integrity@vger.kernel.org>; Mon, 16 Dec 2019 18:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=hSvfaH25oAhh/GJ5npVnk0ddU3zMTib4iqi8IyCVFEM=;
        b=H9I9GiVpWz3ou92JWp8c1ew2PSghYxs9X61n4SENvkc+Wc4FNaIeifhOIQEtUCewZl
         rP4BR4mbkSPSP5WQj71gZL26K230ZwlroMZ6VOPHct1q4iYB66x6lAOGvFFokwlRRBkB
         MhW4wefVdz9KzTJNneSUPvef3VFF0dclBoKE6fck79RCYKB34QIiU8lY2DWQqFDNVVQI
         2caJ3kiToCCAKxZKcQaqI+TGG+GOZimzRvdDmphoM/DMoY810RmCBdJOcd+n6iYOKFue
         GZSiU4qUhexoq9lQme2oOyOPHkyAb7MnedxIngBoR5i/3R9H6WCtrroU68Qwn2+JCu2w
         JHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=hSvfaH25oAhh/GJ5npVnk0ddU3zMTib4iqi8IyCVFEM=;
        b=PB0Dt93bMAoU6VfyWWVdLf9YdQgo9H++bzEM06DJ5/GoOHxmX4tF7NImAEKaFSUZOW
         sFq71z4BWoYHBhK6j8UXWl4rz6wsIrMeZbMguYi52aC1bSfA9mSkCjxpPJ0EYxrpt7pc
         4MidOuVipj5oJjzwkiJ7emhvxR3gQoOhAGqXIbl8OmJOZ3X0bfr9kboXvKV0ixLqEzWr
         dvwHnG131wmYrDOCkS+ereZzQ+2CyKmAWGisyxHes9idPq9c4ga3I+2lTHw/l9YOZoxm
         LrB1IBU4F3/BVCKj0WixrzZc5f9DEFPImrZk/vLeBsoZtIIcnMeymlvUTDR2RLA0reZy
         bX2g==
X-Gm-Message-State: APjAAAVcLTX4JPZdtjF9tADpegcyWlFyH69DFyLG+SK8c5EXOyQSSxSB
        9dwGyBRZ02Wb6322+D7UzzyeOKSpYEsFxkRfqtFX1g==
X-Google-Smtp-Source: APXvYqwqpw8bUx0FpOqaVuTzR8UZTy3esLt2CYxeCMQz+CNnkplkrTyZNMZfbc/wcQk/2LOPJSzrHwpwo1It2GUJQqc=
X-Received: by 2002:a9d:4789:: with SMTP id b9mr32985141otf.247.1576548905572;
 Mon, 16 Dec 2019 18:15:05 -0800 (PST)
MIME-Version: 1.0
References: <20191211231758.22263-1-jsnitsel@redhat.com> <20191211235455.24424-1-jsnitsel@redhat.com>
 <5aef0fbe28ed23b963c53d61445b0bac6f108642.camel@linux.intel.com>
 <CAPcyv4h60z889bfbiwvVhsj6MxmOPiPY8ZuPB_skxkZx-N+OGw@mail.gmail.com> <20191217020022.knh7uxt4pn77wk5m@cantor>
In-Reply-To: <20191217020022.knh7uxt4pn77wk5m@cantor>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 16 Dec 2019 18:14:54 -0800
Message-ID: <CAPcyv4iepQup4bwMuWzq6r5gdx83hgYckUWFF7yF=rszjz3dtQ@mail.gmail.com>
Subject: Re: [PATCH v2] tpm_tis: reserve chip for duration of tpm_tis_core_init
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 16, 2019 at 6:00 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>
> On Mon Dec 16 19, Dan Williams wrote:
> >On Mon, Dec 16, 2019 at 4:59 PM Jarkko Sakkinen
> ><jarkko.sakkinen@linux.intel.com> wrote:
> >>
> >> On Wed, 2019-12-11 at 16:54 -0700, Jerry Snitselaar wrote:
> >> > Instead of repeatedly calling tpm_chip_start/tpm_chip_stop when
> >> > issuing commands to the tpm during initialization, just reserve the
> >> > chip after wait_startup, and release it when we are ready to call
> >> > tpm_chip_register.
> >> >
> >> > Cc: Christian Bundy <christianbundy@fraction.io>
> >> > Cc: Dan Williams <dan.j.williams@intel.com>
> >> > Cc: Peter Huewe <peterhuewe@gmx.de>
> >> > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> >> > Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >> > Cc: stable@vger.kernel.org
> >> > Cc: linux-integrity@vger.kernel.org
> >> > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
> >> > Fixes: 5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing IRQ's")
> >> > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> >>
> >> I pushed to my master with minor tweaks and added my tags.
> >>
> >> Please check before I put it to linux-next.
> >
> >I don't see it yet here:
> >
> >http://git.infradead.org/users/jjs/linux-tpmdd.git/shortlog/refs/heads/master
> >
> >However, I wanted to make sure you captured that this does *not* fix
> >the interrupt issue. I.e. make sure you remove the "Fixes:
> >5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing IRQ's")"
> >tag.
> >
> >With that said, are you going to include the revert of:
> >
> >1ea32c83c699 tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts
>
> Dan, with the above reverted do you still get the screaming interrupt?

Yes, the screaming interrupt goes away, although it is replaced by
these messages when the driver starts:

[    3.725131] tpm_tis IFX0740:00: 2.0 TPM (device-id 0x1B, rev-id 16)
[    3.725358] tpm tpm0: tpm_try_transmit: send(): error -5
[    3.725359] tpm tpm0: [Firmware Bug]: TPM interrupt not working,
polling instead

If the choice is "error message + polled-mode" vs "pinning a cpu with
interrupts" I'd accept the former, but wanted Jarkko with his
maintainer hat to weigh in.

Is there a simple sanity check I can run to see if the TPM is still
operational in this state?
