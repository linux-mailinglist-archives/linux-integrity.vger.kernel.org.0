Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC734DB931
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Mar 2022 21:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242527AbiCPUM2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Mar 2022 16:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238194AbiCPUM0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Mar 2022 16:12:26 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74F86E378
        for <linux-integrity@vger.kernel.org>; Wed, 16 Mar 2022 13:11:11 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id w16so6408952ybi.12
        for <linux-integrity@vger.kernel.org>; Wed, 16 Mar 2022 13:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P5ccPjlwvN6G7YG3kMJjxNTOj4bP6DWTa06PH7G9E9U=;
        b=OT1j6OmloLGO5NfXQzmTa69nmEPpf+9cAkNKdgNZpTGdw1EKwYmmorkVaCCFCVWxoD
         YcYhqPhBNd6Zlb9bQGNg4lg/OIN+plybOgzpwEoyRy4H4bfzah87RtgGVeT1g2HvwybK
         ZU2TdEHiVNQCxPb2zjETjmL2zsyVa1lmLIKvTMa4kUJn9kdsgLFACL2sX9IVZh2ilMmU
         z7Bm3rcxUc9QaKh4pCLA/Kmm+/qarBV2/kcoMqDTso0eQAfxKFPOFVsGFwOh/JRjVo+m
         dniNO8KO373rHqWv7JiEIiz/9A5aEuYzWlFQSDW1tLm9tjKw0j0/CjQSDJu2JK7DUkOE
         3SGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5ccPjlwvN6G7YG3kMJjxNTOj4bP6DWTa06PH7G9E9U=;
        b=h+NqIdsCdLP2KWuvpUus61JoQNbHRbAHmLa+8HTSFTf+g0y/dSy8UZIbyYrv5jODUk
         /eFqUgxSGMzBNJF1+X3xWE50Pjs+b18XSk9yHrW1Xcz/gEXz8qNwiqfE0vZflkEJ/6Eh
         DM1tNpnpRQu9j4Asn8k1Pw17boguIW1t/KwhPGhfRXgKQcZ/wqm51pF3Z5lZ9AtlftFm
         cCCYLVbrWNmUOtW8obCwRPSVQxIcEhbmJ58AuLFYoEs5SvEOXnH8M4xmqrRicIVoM/yI
         ITUzUTyglSKaDRfCIX8ZOMuj+HQv9tj3KuL0Xybly/bV3GPmMqNmYO5XAkrYINwI+bXu
         fmlg==
X-Gm-Message-State: AOAM530I/qLBOGmkhcayIHIdtCGOraw7t2zq0OH9Dp9FeroJM1Pvo+Dx
        LQfGVaMx943jEp7SVm107sSwAWWtJ/Y72myWQAKX+A==
X-Google-Smtp-Source: ABdhPJwmrPANuOf3TT0IN8v8tFOnluLCYR9U/RecniklTnAmIDVF+bPBEGqrEoDekO5yKUcAY7i4QWzIKpDmCA7PC4g=
X-Received: by 2002:a25:5b57:0:b0:633:6b5c:86ad with SMTP id
 p84-20020a255b57000000b006336b5c86admr1839977ybb.113.1647461470801; Wed, 16
 Mar 2022 13:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220223200731.1859670-1-yaelt@google.com> <Yh+S7JD2q8oalRoM@yuki>
 <YiBcyvtqTX1CerM4@pevik> <YiC4Pj1sH8UIHY7k@yuki> <YiDB7wO3Se/vN15+@pevik>
 <YiDGvzETiI/nxwW/@yuki> <YiDLn3GMNFu482XG@pevik>
In-Reply-To: <YiDLn3GMNFu482XG@pevik>
From:   Yael Tzur <yaelt@google.com>
Date:   Wed, 16 Mar 2022 16:10:59 -0400
Message-ID: <CAKoutNsc-JWQd1MOTFk7Hd_MgsFKj=6qi=uusKez2HgatTNCdQ@mail.gmail.com>
Subject: Re: [LTP] [PATCH v4] syscalls/keyctl09: test encrypted keys with
 provided decrypted data.
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Cyril Hrubis <chrubis@suse.cz>, linux-integrity@vger.kernel.org,
        ltp@lists.linux.it
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 3, 2022 at 9:07 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Cyril,
>
> [ Cc Richie, Li, Jan ]
>
> > Hi!
> > > > > > I this case I guess that in this case the change is so minimal that we
> > > > > > can add this test into LTP once it reaches Linus tree.
> > > > > Cyril, maybe we could finally merge our policy (waiting ack for you):
> > > > > https://patchwork.ozlabs.org/project/ltp/patch/20220203101803.10204-1-rpalethorpe@suse.com/
> > > > > and put keyctl09 into runtest/staging now.
>
> > > > I guess that we still did not agree on exactly how this should be
> > > > handled or did we?
>
> > > Isn't it enough "Once a feature is part of the stable kernel ABI the associated
> > > test must be moved out of staging." ?
>
> > The main problem is that someone has to make sure that it happens and
> > the process would be prone to errors. What I proposed instead was a flag
> > that would set a kernel version in which the ABI is going to be merged
> > and put the test right into the final runtest files. Then we can simply
> > skip the test on older kernels or do anything else we see as a
> > reasonable solution. At the same time we can easily add automatic
> > checker that would look for these flags in metadata into the CI which
> > would, for instance, send email to the ML once the flag is supposed to
> > be removed.
> OK, you're missing that kernel version. OTOH things get sometimes backported,
> thus it's not error prone (if we forget to leave that flag after kernel being
> released).
>
> Also version is hard to say if you use maintainer tree (which applies patches on
> previous rc1 than what is being in Linus tree). Thus maintainer's tree would be
> left, also IMHO next tree has no specific version in uname, thus we'd only
> support rc from Linus' tree.
>
> But anyway, if all agree that this is better than both solutions Richie
> implemented I'd try to find time to implement it so that we have finally a
> solution.
>
> > In this case it does not actually matter, since the test is guarded by a
> > kernel config option that is introduced by the patchset and the change
> > is fairly miniminal, so I do not think that there would be any changes
> > to the ABI anyways.
> Correct. At this stage IMHO we can dare to merge it.
>
> Kind regards,
> Petr

Hi Petr and Cyril,

I wanted to check whether there is pending action left on my end?

Thanks,
Yael
