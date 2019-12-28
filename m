Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D81C12BFAA
	for <lists+linux-integrity@lfdr.de>; Sun, 29 Dec 2019 00:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfL1XkX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 28 Dec 2019 18:40:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53639 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726187AbfL1XkX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 28 Dec 2019 18:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577576421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Is3zCMnykm3YLB/25LcQIuM+CSYuIJcnmCpT0uGhuGA=;
        b=QQhT8V6iDiWAcnIABm6XtyhMlWHsmokSbTWfCLAOqB0D13RwJKxf8iHiXr0ZTQuNxGoH+6
        qyJtYKebI6cRpcj4W2TPGxxk5ic+zDbhlbVSdTJ9/mIfgot0VxmiSs4LpHjIhJtH1/mK/u
        tDQh79mapzmltP7yK0zCY6xHYsAXjTg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-AYc6K1atOpuwGB9E1WHVJw-1; Sat, 28 Dec 2019 18:40:20 -0500
X-MC-Unique: AYc6K1atOpuwGB9E1WHVJw-1
Received: by mail-lj1-f198.google.com with SMTP id l2so5580571lje.14
        for <linux-integrity@vger.kernel.org>; Sat, 28 Dec 2019 15:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Is3zCMnykm3YLB/25LcQIuM+CSYuIJcnmCpT0uGhuGA=;
        b=h74DYPtQrKxllCVSh+0zhkGg9RWxILUefpxo/3sk6IcMlKQfqNPOkvXeLhqMGbFzkt
         xp3KaWaEjTleIa9yKohFg4Djkc5ozJJh0RRVbVXsIVkidpWDOkho0PPY/cN6SOubAI+z
         bxb3wN+VBfhZz0yBl2BU9uLYUTPEYa8gI0Zb25PW0XW/pB3DEY44xEtFZ5V1JqFmlSH8
         czEU/X8BG375KNkZ0IQn5lwN9JUJMDk2xMmXiM3t5WUnwHaTHuna/tjpVu37hVvB/fHr
         BrNuGIW6QS9a1j9rwgEaAzqjs4QDmoesY6t8nxqP2kMwostC5IJkHe2faWbTnzf+Pjop
         eWMA==
X-Gm-Message-State: APjAAAVviIzDw+OR5he1QV0Jdo3YmaRFbXOGCvYhWw/isic8L3r4/B7/
        13lY1wjk2SYUIFYEzYSOq5v2jIIXl1YORanpLrv4PLTBFZdz0gcvZbYe/OgVAFlmbM75tFnz/1B
        t/BgsvzjEzfxWc2ccMIKMA239qYmFqkBgVj9Lszcqwe4+
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr31637658ljo.41.1577576418442;
        Sat, 28 Dec 2019 15:40:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzOuhqb8WZQbccD0PFPulnZMqC/UpEhWcURSgW+wh+/9jktf1hFRczfhVM4qdeQVKbwlm1pads2IcbsEjsmChg=
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr31637641ljo.41.1577576418278;
 Sat, 28 Dec 2019 15:40:18 -0800 (PST)
MIME-Version: 1.0
References: <1577122577157232@kroah.com> <CAPcyv4jfpOX85GWgNTyugWksU=e-j=RhU_fcrcHBo4GMZ8_bhw@mail.gmail.com>
 <c6ce34b130210d2d1330fc4079d6d82bd74dcef1.camel@linux.intel.com>
 <50217a688ffa56cf5f150ffd358daba2a88cad48.camel@linux.intel.com> <20191228151526.GA6971@linux.intel.com>
In-Reply-To: <20191228151526.GA6971@linux.intel.com>
From:   Jerry Snitselaar <jsnitsel@redhat.com>
Date:   Sat, 28 Dec 2019 16:39:53 -0700
Message-ID: <CALzcdduip_XX5cRC662YUgRdb4UqcLSg+pomF29NkZdHep6sbg@mail.gmail.com>
Subject: Re: Patch "tpm_tis: reserve chip for duration of tpm_tis_core_init"
 has been added to the 5.4-stable tree
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Dec 28, 2019 at 8:15 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, Dec 27, 2019 at 08:11:50AM +0200, Jarkko Sakkinen wrote:
> > Dan, please also test the branch and tell if other patches are needed.
> > I'm a bit blind with this as I don't have direct access to the faulting
> > hardware. Thanks. [*]
> >
> > [*] https://lkml.org/lkml/2019/12/27/12
>
> Given that:
>
> 1. I cannot reproduce the bug locally.
> 2. Neither of the patches have any appropriate tags (tested-by and
>    reviewed-by). [*]
>
> I'm sorry but how am I expected to include these patches?
>
> [*] https://patchwork.kernel.org/project/linux-integrity/list/?series=208305
>
> /Jarkko
>

Hi Jarkko, sorry I've been under the weather the past couple of days.
I will try to get some testing of your branch done tomorrow. I'm
trying to find a system that use tpm_tis and uses interrupts to test
as well.

