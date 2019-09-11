Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADDFAF9A8
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2019 11:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfIKJ6u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Sep 2019 05:58:50 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:44759 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfIKJ6u (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Sep 2019 05:58:50 -0400
Received: by mail-lf1-f46.google.com with SMTP id q11so1000439lfc.11
        for <linux-integrity@vger.kernel.org>; Wed, 11 Sep 2019 02:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OpRBkszw25mp0fLeRyh2TfOJBy5aBP0yZdtE3UYaIn0=;
        b=tIa4tKpGu2lvlqrbZK+ql90Qf50L4HwtMxl7FXHX8p8wrkkwWdTg3F4csGry2o+RDm
         S11Ivh+Q4acv2tKgMEm4L9dvp/5Zi5/JM+Tew0rVLYzKNUa9oSvXsJ+VAif2D6IE+EFW
         y7GHsUTdJ92OQL1KTkhAxCu9iiIENgawQIB1LFmzHcKC2v3WTyBUEcAOvFNybpYlBt1T
         cglzFQis42UKhg4izMPmKd+xzDe6ov5PX/5xjgJFbIgBagWeLmckvPstUVnFs7TdBogN
         tBdo/FQQk/GsdaFUZqYPxlpHdB5qgGTC0MScEAkptpTj+yGhxhi8YAFFQ7pPrjHVaK2p
         2bHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OpRBkszw25mp0fLeRyh2TfOJBy5aBP0yZdtE3UYaIn0=;
        b=SRVKBooqHrcZfm1NGIOM45cQ72aBI2vws5/1SSGO58XcSxeAT9aCxxRZ9/2znKRXOV
         0TIA4veybbbT92R8dBt5xGsyBDd3dUKWgDCGxAXSM6IG+VYlgJyO8wIhufumfRc2ZqZt
         XdiOFLA9liqJa6NJZZx59Os/v9nxbDrJrmyWzemhzFrlWLxjJkeLxoellnBGE23TnSNM
         tR5oeWJJlk7RORJbb9KWMLbMtAI8h6SERTm0omo06D3h8zw72RmVtkSCZFLY3aWzvlpH
         DDm6yuc0QlIIQnGLZHSz0MZWKU6xRPE4XPQi3IBNdlFLtm/aCJ0+r16ksyM4uGN3itAg
         q0Sg==
X-Gm-Message-State: APjAAAXJysDY0zNbXDVXY/qXEdLWUXOll70nZKXrxvU57d1QpgZSKq64
        3EySPb6LLMecSOb7jri23Urn9tuV8dWDKENVyzNcrQ==
X-Google-Smtp-Source: APXvYqxMs8S/Wx/3db1xRxgCBPmB0doHxxfRLd4geJFOU/Wcf2aNrd5rqAUSGdtHOxCgrnDcmYGt9DTiy+YxoIkoAG4=
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr23917542lfp.61.1568195927793;
 Wed, 11 Sep 2019 02:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <c253ca7292b397f1352d2ee00fce0b011f84abff.camel@linux.intel.com>
 <1567952431.4614.140.camel@linux.ibm.com> <CAFA6WYPq8Tq6=jTqnWQf9w9pzdJu8AcX-CFBWPwoVmMaLEJKhg@mail.gmail.com>
 <20190910114336.GA7018@linux.intel.com> <20190911092708.GA20023@linux.intel.com>
 <20190911092926.GA20970@linux.intel.com> <20190911093637.GA21744@linux.intel.com>
In-Reply-To: <20190911093637.GA21744@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 11 Sep 2019 15:28:36 +0530
Message-ID: <CAFA6WYOdgxEjCYMsgqCUjq7mydH3apxmqxjkyLbqiKfc_1R5Tg@mail.gmail.com>
Subject: Re: KEYS-TRUSTED git
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     jejb@linux.ibm.com, Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 11 Sep 2019 at 15:06, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Sep 11, 2019 at 10:29:26AM +0100, Jarkko Sakkinen wrote:
> > On Wed, Sep 11, 2019 at 10:27:08AM +0100, Jarkko Sakkinen wrote:
> > > On Tue, Sep 10, 2019 at 12:43:36PM +0100, Jarkko Sakkinen wrote:
> > > > On Mon, Sep 09, 2019 at 11:57:45AM +0530, Sumit Garg wrote:
> > > > > @Jarkko: No worries, I understand the situation.
> > > >
> > > > I made the call to add them anyway to my TPM tree.
> > >
> > > Also,
> > >
> > > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > >
> > > I think I give a shot of doing one more PR to 5.4 because that would
> > > help both your and James' work because this is the kind of intersection
> > > point betwen them.
> >
> > Polished short summaries a bit:
> >
> > 1. Start with capital letter.
> > 2. s/tpm2/TPM2/g
>
> Now also in my next branch. I wait for 24h or so and if no alarms are
> rised I'll send a PR. The code changes for the most part mechanically
> move stuff, which makes me confident that I can still do a PR with
> these changes.

Did you notice an issue reported by kbuild test robot? It looks like
asymmetric keys based on TPM also relied on old tpm_buf method. So we
need to transition them also to use new tpm_buf method. I can work on
corresponding changes required but need your help to test it.

-Sumit

>
> /Jarkko
