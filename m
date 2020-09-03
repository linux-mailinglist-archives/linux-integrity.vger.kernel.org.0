Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0351E25C77D
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Sep 2020 18:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgICQyA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Sep 2020 12:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgICQx7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Sep 2020 12:53:59 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6BEC061244
        for <linux-integrity@vger.kernel.org>; Thu,  3 Sep 2020 09:53:59 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id d190so3709809iof.3
        for <linux-integrity@vger.kernel.org>; Thu, 03 Sep 2020 09:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/bbdzFz6N4YNYygPN2I3KRLpBdowZy3Rq/UrfuxGKU=;
        b=DSVBWQUopntYnmyQg7ipw+/klJBjVkEjDMClhAV05JkNmoZJNQSNCSTLt9xgO/E+ZG
         tB3dzc+EcmSoGh24CqxjStoLFVDJoMwXGYAmeXaYShK/xHCR/MgKFpOsAMqjLg+H663u
         tfnWT7d3WXu62/ErTJDb+G+hstA7D4NI+bWDggMeptCleLqA5e5DK9TQtzXX2YGdQkjW
         uYGUt7AeT6AhCA1T/crYKSyCOnw1ObqY2psNTBWV3dgqchPykclG3+QsAD2URq/tFWqC
         vJuEZ8a1p0tEawydF/ewPLWE/03Jgvr9HALGv2mtOFhTlHyAx3XjovjaASuztQCBffx9
         AHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/bbdzFz6N4YNYygPN2I3KRLpBdowZy3Rq/UrfuxGKU=;
        b=DQQ2TldsDXj1TPExyOPq9eBNA4hkbptoexOW3NmP9lI4PJgi/AUTf7s5le6V99HKlG
         BHCNeL62BqvDFSOntBA62ZZijfWYY12fiT2oQNwryPvKeJs3yNGKCgIbNWC2vDe3Y1Rz
         e2swUrLpXetZdEMq1Jf7mDHxuHypdWqY71lJP5MSea7tIhv7K32g1pxaYLdWhsY7NIXQ
         kGbDQacW+HhJeionRyheB7BLq2JpbkD5N+c1C+WV83wGiX4+gLOi1YJK5DjJtJB7Wtqt
         6OxjnReMWRTny6FyRo8ja8JA4jhnPNixaQVeyX9eAjftbRlRmyaHCxC0t+OdtHH2xiPb
         qnDQ==
X-Gm-Message-State: AOAM530y45tY3bl6D4kGYQLVD+IQnkAiM+JhzNztJ1XZEpnfq6w7eHte
        YuloR6JPWi909k0JP1LpcLYlRtdVTfj/OIasgL8=
X-Google-Smtp-Source: ABdhPJwkZ4R2Ms5Xcgg7JmqpNhLQxeSQ0LNu7Xr9TuOBDg5zf7Wa3LJjTs/3+iRhRlFSM+d2ANMb6nXdKr18SZQc/aU=
X-Received: by 2002:a5d:9a15:: with SMTP id s21mr3878844iol.141.1599152038920;
 Thu, 03 Sep 2020 09:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdoA=XBqseT5JfRbTK2HLVbLkZ=QRpTzmcooNijXvtAhaw@mail.gmail.com>
 <1599151643.27597.8.camel@HansenPartnership.com>
In-Reply-To: <1599151643.27597.8.camel@HansenPartnership.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 3 Sep 2020 11:53:47 -0500
Message-ID: <CAFftDdq=X97CNhBrJNhf84G0emcAZuX925fPYgjOix7uJWa=9w@mail.gmail.com>
Subject: Re: tpm:warn(2.0): out of memory for object contexts
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, jarkko.sakkinen@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Sep 3, 2020 at 11:47 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Thu, 2020-09-03 at 10:07 -0500, William Roberts wrote:
> > Hello,
> >
> > I maintain a lot of the userspace components in the tpm2-software
> > opensource community. We had a bug come in where we're getting oom
> > TPM errors when using /dev/tpmrm0. The bug seems to go away when we
> > use the userspace resource manager tpm2-abrmd. Thai leads me to
> > believe that there is a kernel bug.
> >
> > The question is, "is anyone aware of any bugs in the kernel RM that
> > could cause this?"
> >
> > The kernel version is:
> > 5.4.0-42-generic #46-Ubuntu
> >
> > The discussion can be found here:
> >   - https://github.com/tpm2-software/tpm2-pkcs11/issues/567
>
> That bug report is pretty unhelpful.  What specific error messages does
> the kernel give?

I'll ask for more details.

> I'm a heavy TPM key user (so lots of sessions and
> volatile handles) I run RSA keys through the TPM for all my openvpn
> sessions, ssh sessions and gpg transactions (mostly with RSA keys),
> admittedly using the IBM TSS, and I've never seen this in any of my

That shouldn't really matter. That error code shouldn't be possible when going
through an RM.

We've seen bugs in our own RM where if bindkey and tpmkey are the same,
we could hit this issue. Perhaps, similar issue in the in-kernel one. But,
that's just conjecture.

> systems.
>
> James
>
