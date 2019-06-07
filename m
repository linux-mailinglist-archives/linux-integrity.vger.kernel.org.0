Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8362D3879C
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2019 12:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfFGKDi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jun 2019 06:03:38 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40553 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfFGKDh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jun 2019 06:03:37 -0400
Received: by mail-it1-f196.google.com with SMTP id q14so776437itc.5
        for <linux-integrity@vger.kernel.org>; Fri, 07 Jun 2019 03:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iXkL1vVxNkQCEf8uIM1j/K14yJ9boqMG1SgO7jduIvc=;
        b=YYxEGmddlTZo7bYwJ78QEjiVFt60Vd1vKrd7FfgLha73Bfp5xhojPc11T2qge0Ee9U
         iEqXavk/gZtf5msWQQkYvZ1FzL7dWqtbtuoUThGhH857ANjy9kFBzvrXgfqZfV/ZT3cC
         kVpAjDoZ9MZX4pFbBjFZoTTZeA9lLePg/eIHn088JZOyRjycYI9mfwz/Vb9bd/ma1wIO
         G95UnNdBWaTK+dtIs8xMKXGvMdyYZoX8UiJcndYL5Rl9Jt1jBBP+Q2my6vMGB1gSgAoV
         abk/Dr7gHvMTE+6TxfkThW8/Jdj/PtnPfHBO7GUcd+pe0z7IWh9xEwhLM+cdB0H4qBbF
         ZCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iXkL1vVxNkQCEf8uIM1j/K14yJ9boqMG1SgO7jduIvc=;
        b=CMwE1QjmX8N3Koy8DsPlfGi/ibACElQpthL0v4AP/L1+JqbgPzEg1baG+QmQL4vMJH
         j1isF8UqhKeufRL7S4ECLiAmcGm6EyVKdAzJPVcJWYC/g9vyUPgpZygyf3pyaTaPhMva
         BlKWGCSwjjvDWVGf9UMufgSF9JY8iCYIcog4epZ5qcFs+Sze4J0kW7LF1wDJ3gpGblh5
         /cov/lpjmyK9Mz3e14vN3CQizvrwzGFOCyjz0TOYBwW7v3MEOESYplwqQXCOQNseBIKd
         v96ThAhCps9ZJCCIHFUUwM6z8lKOyNcmQ5KDPMXfAHwqJSmxwyGmQzw5hEI1wnju0Bkk
         P21w==
X-Gm-Message-State: APjAAAU4ukfUdUkkg5ULemp/0fPEYJYdf4y0Gx1FvgUNmRGjOhkaNPlh
        rbqgiEeqzIhZCSYY+iINkTe1P1a+x5Q0OR1JgD3hwfTYFn0=
X-Google-Smtp-Source: APXvYqx5BvzpPElJuxssZGqIo/LIQYox9lJ48Af/yrJsR3eUMkJQWs/vjbsQgg7qQmQ96IMfzCBOykjsxchEhdgwN+E=
X-Received: by 2002:a02:ce37:: with SMTP id v23mr34148542jar.2.1559901817170;
 Fri, 07 Jun 2019 03:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190605181140.35559-1-matthewgarrett@google.com>
 <CAKv+Gu_GxV1GySRz-xju6RsB0Qdra=nN=CL+M=jvQ1e2V6p_ig@mail.gmail.com> <CACdnJusonjd_2eciwA8MgJNS7GntGGBqoAMHuJBRHsuqrn4aGQ@mail.gmail.com>
In-Reply-To: <CACdnJusonjd_2eciwA8MgJNS7GntGGBqoAMHuJBRHsuqrn4aGQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 7 Jun 2019 12:03:26 +0200
Message-ID: <CAKv+Gu-rqW7VrQ_jiGQLcx2xTc-khOoV7_FOQ0N7tbU932QhFQ@mail.gmail.com>
Subject: Re: [PATCH] efi: Fix TPM code build failure on ARM
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        =?UTF-8?Q?Peter_H=C3=BCwe?= <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 6 Jun 2019 at 18:04, Matthew Garrett <mjg59@google.com> wrote:
>
> On Thu, Jun 6, 2019 at 4:39 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Wed, 5 Jun 2019 at 20:11, Matthew Garrett <matthewgarrett@google.com> wrote:
> > >
> > > asm/early_ioremap.h needs to be #included before tpm_eventlog.h in order
> > > to ensure that early_memremap is available.
> > >
> >
> > Doesn't that make it tpm_eventlog.h's job to #include it?
>
> tpm_eventlog.h doesn't use early_memremap directly, it's expanded from
> the macros declared in tpm.c .

Fair enough

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
