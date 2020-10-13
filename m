Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE43D28CC93
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 13:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgJML3B (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Oct 2020 07:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgJML3B (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Oct 2020 07:29:01 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB1AC0613D0
        for <linux-integrity@vger.kernel.org>; Tue, 13 Oct 2020 04:29:00 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id x16so6684138ljh.2
        for <linux-integrity@vger.kernel.org>; Tue, 13 Oct 2020 04:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0fe/rUPknWKjJHQfNjjMwuy0QlI3MJO2qD6YuDAy3qE=;
        b=X04ds4sw8SJNth6bHlu9JhQBVORr5yXBEE2b8Ov6oelmRazUaaNvD13K/TWOr7gyQd
         JtSzTS0gJ58yo0XSpqWYK1jQHHs/1WMjRF3P1PTENrCFQnIpZ5LiVmcWjBwm9T+zuUW2
         SObFz5u+I6H+0434419wjVX6I/i1yL21PJbuy64REF65mLZ1WpcTPD35PS+JZGo92Aob
         y7O2v7+WQ3tMF6CnPEJ6hDtes809zD5L1gVi2BClPDgRPJuYgAoZ+OVqNAzmgAcalLmv
         x31cXMyUTmcv177luuQPMuZSOZ0Nom9Ci2+XWlhVqB1ZJJtUZ5FN0hrOTB5f9PgVV+6l
         pixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0fe/rUPknWKjJHQfNjjMwuy0QlI3MJO2qD6YuDAy3qE=;
        b=m3lyuUl39nSlwsNuqJ7Mc1k/Sn9um7Rmo//EvnrE4G7eiiHY/c6r2ad8WYJFWPPPJG
         UtlkAvOw4p03u1h+Q33c+C5zdiM3NNgh9QxlvzWMmaKFaLLSvz8vp7cmFGlmxJLSJYtu
         G7od+XfVBFzYOiMhebgGJzVq09Qh4qKQn/YiSd+ZjnNk1f1KKgAlb+okF1KlYE9Hm/gS
         uZ2tT48Sjv47NkQvUjy648pveakwgwxawDgm9ZYCAPB8p2h1NJIFhnciRRBfmpKHWJZz
         dB1+ujKNipQd56cmQC7BMtgUT/MaQmGQaiuhVe+LPAZBwGtCGXBrg4DSnBmamZAWtcH2
         RqBQ==
X-Gm-Message-State: AOAM530KkyOXDIJfpaEp23XMFbmcmOCdcR6p53YLX1wx6bxnGidqxKHh
        B6ZNFCbBwXK1FbipvW8X7B51We4x09EHehH38FEsXA==
X-Google-Smtp-Source: ABdhPJxOlDao8AKCPBsqF7gTeRCRcVgwmk5ldXZOHlGJBEkPdQNH+RZ2Xsbw1swjy/dOe6vjwFkeKOoQY7F5HG7Wnf4=
X-Received: by 2002:a2e:9d8d:: with SMTP id c13mr11367812ljj.339.1602588538772;
 Tue, 13 Oct 2020 04:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <1602065268-26017-1-git-send-email-sumit.garg@linaro.org>
 <1602065268-26017-5-git-send-email-sumit.garg@linaro.org> <20201013022157.GA47751@linux.intel.com>
In-Reply-To: <20201013022157.GA47751@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 13 Oct 2020 16:58:47 +0530
Message-ID: <CAFA6WYO6zNKtxhpNpTpqAjZnMPrEygs1k7Gwg3hwJV8Ynrr=qQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] MAINTAINERS: Add entry for TEE based Trusted Keys
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        Luke Hinds <lhinds@redhat.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 13 Oct 2020 at 07:52, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Oct 07, 2020 at 03:37:48PM +0530, Sumit Garg wrote:
> > Add MAINTAINERS entry for TEE based Trusted Keys framework.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >  MAINTAINERS | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 48aff80..eb3d889 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9663,6 +9663,14 @@ F:     include/keys/trusted-type.h
> >  F:   include/keys/trusted_tpm.h
> >  F:   security/keys/trusted-keys/
> >
> > +KEYS-TRUSTED-TEE
> > +M:   Sumit Garg <sumit.garg@linaro.org>
> > +L:   linux-integrity@vger.kernel.org
> > +L:   keyrings@vger.kernel.org
> > +S:   Supported
> > +F:   include/keys/trusted_tee.h
> > +F:   security/keys/trusted-keys/trusted_tee.c
> > +
> >  KEYS/KEYRINGS
> >  M:   David Howells <dhowells@redhat.com>
> >  M:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > --
> > 2.7.4
>
> I'm sorry but I think I have changed my mind on this. This has been
> spinning for a while and sometimes conclusions change over the time.
>
> I don't think that we really need a separate subsystem tag.

I don't see it as a separate subsystem but rather a kind of underlying
trust source (TEE) driver plugged into existing trusted keys
subsystem. We could relate it to the RNG subsystem as well where there
is a subsystem maintainer and specific driver maintainers.

IMO, having a dedicated entry like this brings clarity in maintenance
and in future we may have more trust sources like this added where
everyone may not have access to all the trust sources to test.

> I'd be for a
> new M-entry or R-entry to the existing subsystem tag. It's essential to
> have ack from someone with ARM and TEE knowledge but this way too heavy
> for the purpose.

If you still think otherwise then I am fine with a new M-entry for
existing trusted keys subsystem as well.

>
> I also see it the most manageable if the trusted keys PR's come from a
> single source.

I echo here with you to have a single source for trusted keys PR's
irrespective of whether we go with a separate trust source entry or
update existing subsystem entry.

-Sumit

>
> /Jarkko
