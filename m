Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FEA1D29BA
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 10:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgENIKa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 04:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgENIK3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 04:10:29 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 450FE2065D
        for <linux-integrity@vger.kernel.org>; Thu, 14 May 2020 08:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589443829;
        bh=Xf8DEKxe/HcjD/EnXUO0eGUCvnkUXJ1xE0FLARkXWGA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=duE6MUlt6a33ZXoDy7N06eQHQyJ/iHiLmi5D2wHAxeAgbOknJICTp+xqAdplGkW2j
         i5XrVwIx/uQ1IcFBHeuzfv3bUp8sGlSKGrLqMK59hWGrvIfGZqLtF7vo9qIqTLR6Du
         Lpp/rMgvabhQTGnRggk1LoQiN29/oHbTvEp1DotI=
Received: by mail-il1-f169.google.com with SMTP id b15so840349ilq.12
        for <linux-integrity@vger.kernel.org>; Thu, 14 May 2020 01:10:29 -0700 (PDT)
X-Gm-Message-State: AOAM533m1h3cqi4ZGA9I9Q0jmqODYuIE+yJ0A3BjoNzAyhXYLqjVbkKC
        TgR99vwC0ag3ughtTKvvEXHOszATxku9PpKFzRs=
X-Google-Smtp-Source: ABdhPJzLDW5i+bsVSa0+yv6nTiwlQQoNIUBFaLtTnTHWfUUOiQdB3YRebMCuPtmgfnVQxRKwkMV+5PD5wlM31zp8nLY=
X-Received: by 2002:a92:a312:: with SMTP id a18mr3541237ili.80.1589443828605;
 Thu, 14 May 2020 01:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200512040113.277768-1-loic.yhuel@gmail.com> <CAMj1kXFfLvUXU1A-7jnh3KMy5Qguhq0k9Cw=O0iBmbToowV_8A@mail.gmail.com>
 <ab9df4468cc294c67a67ef336019379033e7c90c.camel@linux.intel.com>
In-Reply-To: <ab9df4468cc294c67a67ef336019379033e7c90c.camel@linux.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 14 May 2020 10:10:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHX2Hf_QeKF4m-4yfjzcM2=AFV-EzthQvDO1pOsyaSsZw@mail.gmail.com>
Message-ID: <CAMj1kXHX2Hf_QeKF4m-4yfjzcM2=AFV-EzthQvDO1pOsyaSsZw@mail.gmail.com>
Subject: Re: [PATCH] tpm: check event log version before reading final events
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     =?UTF-8?Q?Lo=C3=AFc_Yhuel?= <loic.yhuel@gmail.com>,
        linux-integrity@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>, javierm@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 14 May 2020 at 03:09, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, 2020-05-12 at 08:44 +0200, Ard Biesheuvel wrote:
> > Hi Lo=C3=AFc,
> >
> > Thanks for the fix.
> >
> > On Tue, 12 May 2020 at 06:01, Lo=C3=AFc Yhuel <loic.yhuel@gmail.com> wr=
ote:
> > > This fixes the boot issues since 5.3 on several Dell models when the =
TPM
> > > is enabled. Depending on the exact grub binary, booting the kernel wo=
uld
> > > freeze early, or just report an error parsing the final events log.
> > >
> > > We get an event log in the SHA-1 format, which doesn't have a
> > > tcg_efi_specid_event_head in the first event, and there is a final ev=
ents
> > > table which doesn't match the crypto agile format.
> > > __calc_tpm2_event_size reads bad "count" and "efispecid->num_algs", a=
nd
> > > either fails, or loops long enough for the machine to be appear froze=
n.
> > >
> > > So we now only parse the final events table, which is per the spec al=
ways
> > > supposed to be in the crypto agile format, when we got a event log in=
 this
> > > format.
> > >
> >
> > So what functionality do we lose here? Can we still make meaningful
> > use of the event log without the final log? I thought one was
> > incomplete without the other?
>
>
> Nope it would be incomplete [*].
>
> So probably would make sense to at least issue a warning in this case.
>
> [*] https://www.kernel.org/doc/Documentation/security/tpm/tpm_event_log.r=
st
>

Right.

I'll take the current patch as a fix for now.

I agree it makes sense to add a warning, but I'd like to understand
better which exact condition we should warn about.
Currently, tpm_read_log_efi() simply disregards the final log if it is
not in crypto agile format, but is there any point to exposing
anything in that case?
