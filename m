Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37277122157
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Dec 2019 02:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfLQBSM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Dec 2019 20:18:12 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39150 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfLQBSM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Dec 2019 20:18:12 -0500
Received: by mail-oi1-f194.google.com with SMTP id a67so4860748oib.6
        for <linux-integrity@vger.kernel.org>; Mon, 16 Dec 2019 17:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gQlxuukx7ZYSQZmNiora65lLQtsKLdrcwl34+cNn20I=;
        b=ZML1YlPfc4X1lcJ2MEbwwuNUKRegQeZ1YWVhElf9aNxBihtxGgtQUSJL6yDQFiM2rL
         y/lqLODFRtPxZRmMnuW9B1kUabr/9AGAClBFwX0znrz0wJsyiRGYNjaCepLaxTeWBNBX
         SiVi4m+QZl/9PWp2i/Gej2UCGi0YWW8IAKtvPz0U5FZS7Amc68+vfcu8BwfvUeSscuVF
         kUfLmgSgMrtPuf0Vc+yijMqQUx6yzFsgm3vk0Y0emxOOEaff735UHNk7VQWa65n7NFlF
         8COOeab+RZx6zAqGm2MLWzNGm3Zrmk68eKfmuXeXklk3Q1r3cMwqb0r/fmpqOyWsTBPs
         vwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gQlxuukx7ZYSQZmNiora65lLQtsKLdrcwl34+cNn20I=;
        b=n4bxTg4muH/0g2H7/faDCVeRqEzdHqbn4++BRt0Ech/ZgQBxMavKw/4oaOp3fALxkv
         nKQbL8zP05mCR6SrL6ho7HSG1a4ng8qQSfKbzVJNo0h1bXJV+R1w/j9+kIg/7ouT9pEb
         JO9ldYvTLINuo/LoXwcE25eTdNxAPTJRazULBayIuaL2OqyywESKcfAHvkGBZzzJtxaG
         4F+Iau8b09yOBAelkNldQO/joxKe2egNuq0F/3wd4de3DxT1DNaQ7kmwzpasIExeaeO5
         0Svpw8HPmSj+1MRCa0bIAmM0qfVr8urngra3mlxD7bk+UBKsmvAG8HlktoLWYm6r8gLh
         EbGQ==
X-Gm-Message-State: APjAAAVHONlA2Van0i03XSZHMVCUOFnPpHanu0xYMuwyRt+JkWYGajlu
        c041LxZSDN/6o9pouq/tRVVbFAeyo+N9yXD0PeDFig==
X-Google-Smtp-Source: APXvYqyALUz6qMsfZ8CPqN2DhPrepKX8K+FY6z1DAn5DPLETrrCCRCs0bMrUATx7fxnThIB2URczhSpUKLEZ1cMtY+s=
X-Received: by 2002:aca:c354:: with SMTP id t81mr1065974oif.149.1576545490980;
 Mon, 16 Dec 2019 17:18:10 -0800 (PST)
MIME-Version: 1.0
References: <20191211231758.22263-1-jsnitsel@redhat.com> <20191211235455.24424-1-jsnitsel@redhat.com>
 <5aef0fbe28ed23b963c53d61445b0bac6f108642.camel@linux.intel.com>
In-Reply-To: <5aef0fbe28ed23b963c53d61445b0bac6f108642.camel@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 16 Dec 2019 17:18:00 -0800
Message-ID: <CAPcyv4h60z889bfbiwvVhsj6MxmOPiPY8ZuPB_skxkZx-N+OGw@mail.gmail.com>
Subject: Re: [PATCH v2] tpm_tis: reserve chip for duration of tpm_tis_core_init
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
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

On Mon, Dec 16, 2019 at 4:59 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, 2019-12-11 at 16:54 -0700, Jerry Snitselaar wrote:
> > Instead of repeatedly calling tpm_chip_start/tpm_chip_stop when
> > issuing commands to the tpm during initialization, just reserve the
> > chip after wait_startup, and release it when we are ready to call
> > tpm_chip_register.
> >
> > Cc: Christian Bundy <christianbundy@fraction.io>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Peter Huewe <peterhuewe@gmx.de>
> > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > Cc: stable@vger.kernel.org
> > Cc: linux-integrity@vger.kernel.org
> > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
> > Fixes: 5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing IRQ's")
> > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>
> I pushed to my master with minor tweaks and added my tags.
>
> Please check before I put it to linux-next.

I don't see it yet here:

http://git.infradead.org/users/jjs/linux-tpmdd.git/shortlog/refs/heads/master

However, I wanted to make sure you captured that this does *not* fix
the interrupt issue. I.e. make sure you remove the "Fixes:
5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing IRQ's")"
tag.

With that said, are you going to include the revert of:

1ea32c83c699 tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before probing for interrupts
5b359c7c4372 tpm_tis_core: Turn on the TPM before probing IRQ's

...in your -rc3 pull?
