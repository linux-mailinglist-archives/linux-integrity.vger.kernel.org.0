Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1D19E24C
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Aug 2019 10:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfH0IXp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Aug 2019 04:23:45 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:35663 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfH0IXp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Aug 2019 04:23:45 -0400
Received: by mail-yb1-f193.google.com with SMTP id c9so7945150ybf.2;
        Tue, 27 Aug 2019 01:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sm73ZOn84KCsaZVW7TpDDfd2AlAByGzQhgPSNdOo0Dc=;
        b=Mrs27iG2NYzFQYGoa+PQBlmSfHZaWweQU6KcsL0cOPNzYy5EDTxvam4Uha2ZK6U9tQ
         h5Nhs3bHXQ/ml3/BMLSr6C6foAzYTQOHDkioOwyZPOg4aqumNViprMcQ7GbaRCVjdeqU
         6rMZCpKn6pibnTfo00pS4OIPKeOtMb1eiNL2Jb1AcJIVDiZRhUbZ8UFSPhSKL+lBcyh9
         G1xQQqdacyJ5RxnLze/6T688SWr2/wnvg4kPD769TVVF0X2P9uNqZsf0Q8SivvIaWtjW
         DJdEG9ARV/CfxHqKQQRlhDf0hUSIJCCk9z2yhZ2RqatrWt6EvbsbIM1WN/XlA1PtsgaL
         4rvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sm73ZOn84KCsaZVW7TpDDfd2AlAByGzQhgPSNdOo0Dc=;
        b=rnkTv6QYF/KV/GuIx+XgOkaXx5vTKpc/vG2qhOlBOnMeQ4OixBYTZMzCVF7lnVXTry
         5IO28iBVJhpnY6aCmEo95NzT5mjF51IP9paaMrrVekY9XbCJPWCIaHWyDQOCn+0z6Jf9
         vVVrB/4y2BWi8C2iJRYRjy3cN/zp3ws+u0fRcGp71pC0pKQ5oBz7iXV5U84WyXF0z/7e
         vYnop5nP9VbdVxmoN6AmvfXsskqyaQgS8ImFxv1F6YPmImRKeoCYt6nfxwgpEK0kViYV
         xESPzQGBzoFGzxyUK6B/apfKLwNkB6iIq9PudQAqmV8wmVviv5drxmIlZBNsraH5Vp9p
         968w==
X-Gm-Message-State: APjAAAXzE42ToxCZRKmYuikKTYFh04+kFMSW3MW4SM/OJHqJ37JL1upm
        FsHGj0d/IySeUSO0+T0YD7RHp71APkOe6cSG6xs=
X-Google-Smtp-Source: APXvYqxShZNzlbU/LtCs1iaBTOtOJGvti4h+Io8nfnTWt4NUD03ijpF+Zm0LROz1THfYJBJsusE7q+9XLEqMpFSd9Ug=
X-Received: by 2002:a25:2f42:: with SMTP id v63mr15563438ybv.228.1566894224570;
 Tue, 27 Aug 2019 01:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190826081752.57258-1-kkamagui@gmail.com> <CACdnJutomLNthYDzEc0wFBcBHK5iqnk0p-hkAkp57zQZ38oGPA@mail.gmail.com>
In-Reply-To: <CACdnJutomLNthYDzEc0wFBcBHK5iqnk0p-hkAkp57zQZ38oGPA@mail.gmail.com>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Tue, 27 Aug 2019 17:23:33 +0900
Message-ID: <CAHjaAcSFhQsDYL2iRwwhyvxh9mH4DhxZ__DNzhtk=iiZZ5JdbA@mail.gmail.com>
Subject: Re: [PATCH] x86: tpm: Remove a busy bit of the NVS area for
 supporting AMD's fTPM
To:     Matthew Garrett <mjg59@google.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

>
> On Mon, Aug 26, 2019 at 1:18 AM Seunghun Han <kkamagui@gmail.com> wrote:
> > To support AMD's fTPM, I removed the busy bit from the ACPI NVS area like
> > the reserved area so that AMD's fTPM regions could be assigned in it.
>
> drivers/acpi/nvs.c saves and restores the contents of NVS regions, and
> if other drivers use these regions without any awareness of this then
> things may break. I'm reluctant to say that just unilaterally marking
> these regions as available is a good thing, but it's clearly what's
> expected by AMD's implementation. One approach would be to have a
> callback into the nvs code to indicate that a certain region should be
> handed off to a driver, which would ensure that we can handle this on
> a case by case basis?

If the regions allocated in the NVS region need to be handled by a
driver, the callback mechanism is good for it. However, this case
doesn't need it because the regions allocated in NVS are just I/O
regions.

In my opinion, if the driver wants to handle the region in the NVS
while suspending or hibernating, it has to use register_pm_notifier()
function and handle the event. We already had the mechanism that could
ensure that the cases you worried about would be handled, so it seems
to me that removing the busy bit from the NVS region is fine.

Seunghun
