Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95DB016684B
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2020 21:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgBTU3g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Feb 2020 15:29:36 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:39188 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgBTU3g (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Feb 2020 15:29:36 -0500
Received: by mail-il1-f195.google.com with SMTP id f70so24815331ill.6
        for <linux-integrity@vger.kernel.org>; Thu, 20 Feb 2020 12:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7l+FT6munxBXrALG6DC/5awqtQKggKRCTCa4lFfJl9g=;
        b=NWCFZ1Jlg1VxVXiqNG0t09k+xBrAxTKb5lkq3Fq52F7xDqtkKs/+IYtzlFLiWMZalw
         FVhEK3/1/nm486mMFPmkPNd+vL+rpMn9FGCsiEL1zsbNvGHItWhhESMj+Q0I+GXI6qcV
         bjWBeVJCenyNAvlTQ08rgHFWJCVt+26Y+pRfRhPeBeVG+HYdgwTBPgvHt+yc3oUe5EOK
         UFJSApEahs3+vr9q+SOF6IDl211kbpE0qOszb4OVPvzfWigel00QIFpwon8pLmpT3N7w
         N5hcukllrlZpTXxte4GUT6z8JIi756Kb+tC79/Ik/iaCiWXSZ0kuogEGYZt9PGLR5IEI
         nDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7l+FT6munxBXrALG6DC/5awqtQKggKRCTCa4lFfJl9g=;
        b=dBs/ezy8angzq0hTkkRm+A5xcKp7EiykQXI4nznIRwwY7eV8CifcmQzTl6WF6Yr7ma
         bdya39DYQJHeOduUKhXrjzgxlHBZ2WxSlcLMk2+1b9TV0PJSbbdeVinqYIysf2F8MxMm
         YuHYQDn0FOsPXY5tgbCYS06yCRGLBrwwu0yghuPPdCkuzwUaoUobe9KdFFImYxKraxKZ
         S9pSzHQEeq27G8T9TS3ZXcWXDHjAKdaUYH+oXPIhVVQlIUitUhG/8KRhg+clSNiC5KgO
         uZxmy8JLDy+ti4nSmy8xluicJ8JhYeqib6p4chiGdRG22d6T6oSCn48nQcb4of/Jsw/B
         HXnw==
X-Gm-Message-State: APjAAAXELj2rkfneqlKrsPEHchzlQTN84iACoH6QggNLOl2kRmyxmmB5
        vQH0qAoY4AmYp2LYUjVbPpEOLWF3VpIVONEBeq1IjQ==
X-Google-Smtp-Source: APXvYqwv3lS8jY9twjiBfSS0VK1LBcbhWzMQR1p6zblW9XWlkG+/97pvbpoV7G46vMFhLaEkHvck0Ywt1dWWiUHBQmc=
X-Received: by 2002:a92:d609:: with SMTP id w9mr33421779ilm.46.1582230574892;
 Thu, 20 Feb 2020 12:29:34 -0800 (PST)
MIME-Version: 1.0
References: <20200102215518.148051-1-matthewgarrett@google.com> <0257b88752b4acdb8715da2fa1c5dfbf9fb1b34b.camel@linux.intel.com>
In-Reply-To: <0257b88752b4acdb8715da2fa1c5dfbf9fb1b34b.camel@linux.intel.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 20 Feb 2020 12:29:24 -0800
Message-ID: <CACdnJuvJyE7u+HSonm7-AcK9EabZobn46vEFVdrTSRcwNvz0_A@mail.gmail.com>
Subject: Re: [PATCH V2] tpm: Don't make log failures fatal
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jan 3, 2020 at 3:26 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, 2020-01-02 at 13:55 -0800, Matthew Garrett wrote:
> > If a TPM is in disabled state, it's reasonable for it to have an empty
> > log. Bailing out of probe in this case means that the PPI interface
> > isn't available, so there's no way to then enable the TPM from the OS.
> > In general it seems reasonable to ignore log errors - they shouldn't
> > interfere with any other TPM functionality.
> >
> > Signed-off-by: Matthew Garrett <mjg59@google.com>
> > Cc: stable@vger.kernel.org
>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Hi Jarkko,

Is this queued anywhere? Thanks!
