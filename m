Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E445E21948B
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jul 2020 01:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgGHXqu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jul 2020 19:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGHXqt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jul 2020 19:46:49 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADE7C08C5CE
        for <linux-integrity@vger.kernel.org>; Wed,  8 Jul 2020 16:46:47 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id d17so279873ljl.3
        for <linux-integrity@vger.kernel.org>; Wed, 08 Jul 2020 16:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hNVOm+zljioPYiyCEKhVRUSifVw9+Rq4lrANP+/QLBY=;
        b=lcLaSajDl3PXHLI0IsixId3ctDcJw/wcCMiK5LmAriZFBPjCqkHzrpB5Wr8RE5ku3r
         jUWEGuzjjFwKK+MoTRT33yCbdQgTQwKFWb/UnbSfHe2j9OUtBiKy4DK8qeLKCpRc+9Wj
         Bzun1SbvUp06+5xggjiRZELJWnHnhk59in1ncmMWss/+VxfsOQxB1i07p/3CscAo4Vbr
         QjdH83dDvnirLejbklIErYxD/G1RzjIG34SvWUSpq6cQtuEaY7S7Q8EIA2lIqnunGSmj
         pdQe99/xvr+rhtnFuHZvy68oV0FkHeMRCItVNOqykDmMRzv+6icK/e4Zz3KUbgNWAVXS
         LFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hNVOm+zljioPYiyCEKhVRUSifVw9+Rq4lrANP+/QLBY=;
        b=KtVk7CcLl7UVjjKwUxlWwkN1xKySwRTt2XkhcSOG/3WgfwU67oddT7gC6ioZJtxnXy
         OGoS9ZLDBtHfFQlWmXdn/o5FG7YwYe2SaT8wuToKLZvzAtXNE000cuRCHw9qAhw7/4H8
         zQMlKeydqmxE/g5WrlYff/6DedIYSb4puZmxUrJi4sFm2fhdHgTiN+D/AI1PdxREu1TN
         QJjud+MxrBzjNBfyUeI5ape7VRE7UYzBf4Bxfdk7aPPQm0f7csoAt3ieHiZPL78LzDzq
         YaWECJ6Xoib47d7bGPWBooKqOrsP5BDWpYghdGEZmpUvuqFAgcbzooVEtYRykhhJLfZe
         OlIA==
X-Gm-Message-State: AOAM531va2yAEckSbrEBY+jAyVKdspUhTj2X3Lb337GSCUCR7git5KPT
        MXTmlqaHpNSYm8z5J5pu2vwkOlMype8VK/KpiwgdNw==
X-Google-Smtp-Source: ABdhPJxQopmgjC6jnaMAt/WQPRrVXt1aN4OhHEolRLPsjEpEaz9Q/mPmsN9bvmri8KaSrr7ODM5XB1eWwNM+XDZ6cAM=
X-Received: by 2002:a05:651c:1106:: with SMTP id d6mr6280417ljo.214.1594252006292;
 Wed, 08 Jul 2020 16:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200708131424.18729-1-masahisa.kojima@linaro.org>
 <20200708162017.GB549022@linux.intel.com> <CADQ0-X9im8yVVVJbJL5Ssaa49UTOw+M=tYrfhNoODUaY723O8A@mail.gmail.com>
In-Reply-To: <CADQ0-X9im8yVVVJbJL5Ssaa49UTOw+M=tYrfhNoODUaY723O8A@mail.gmail.com>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Thu, 9 Jul 2020 08:46:35 +0900
Message-ID: <CADQ0-X8xF0NpMakEB_Kqd2hVSrMsMB5FqFd7V9F1eLryJbEeFA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] synquacer: add TPM support
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ardb@kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

> Hi Jakko,
I apologize for mis-spelling of your name.
Same mistake also appears in my another reply to "[PATCH v3 1/2] tpm:
tis: add support for MMIO TPM on SynQuacer"

On Thu, 9 Jul 2020 at 08:34, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
>
> Hi Jakko,
>
> > Overally the code looks great. You've run it through checkpatch.pl?
>
> Yes, I have run checkpatch.pl and removed errors.
>
> Regards,
> Masahisa
>
> On Thu, 9 Jul 2020 at 01:20, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Wed, Jul 08, 2020 at 10:14:22PM +0900, Masahisa Kojima wrote:
> > > This adds support for driving the TPM on Socionext SynQuacer platform
> > > using the driver for a memory mapped TIS frame.
> > >
> > > v3:
> > > - prepare new module to handle TPM MMIO access on SynQuacer platform
> > >
> > > v2:
> > > - don't use read/write_bytes() to implement read/write16/32 since that uses
> > >   the wrong address
> > >
> > > Cc: jarkko.sakkinen@linux.intel.com
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: ardb@kernel.org
> > > Cc: devicetree@vger.kernel.org
> > > Cc: linux-integrity@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: peterhuewe@gmx.de
> > > Cc: jgg@ziepe.ca
> > >
> > > Masahisa Kojima (2):
> > >   tpm: tis: add support for MMIO TPM on SynQuacer
> > >   dt-bindings: Add SynQucer TPM MMIO as a trivial device
> > >
> > >  .../devicetree/bindings/trivial-devices.yaml  |   2 +
> > >  drivers/char/tpm/Kconfig                      |  12 ++
> > >  drivers/char/tpm/Makefile                     |   1 +
> > >  drivers/char/tpm/tpm_tis_synquacer.c          | 196 ++++++++++++++++++
> > >  4 files changed, 211 insertions(+)
> > >  create mode 100644 drivers/char/tpm/tpm_tis_synquacer.c
> > >
> > > --
> > > 2.20.1
> > >
> >
> > Overally the code looks great. You've run it through checkpatch.pl?
> >
> > /Jarkko
