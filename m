Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF41651AC4
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Dec 2022 07:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiLTGeB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Dec 2022 01:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbiLTGdu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Dec 2022 01:33:50 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADCAE0C5
        for <linux-integrity@vger.kernel.org>; Mon, 19 Dec 2022 22:33:47 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id q128so10882633vsa.13
        for <linux-integrity@vger.kernel.org>; Mon, 19 Dec 2022 22:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bd6bPFPDM+yhjJOFjj4y0MnFiVla5reSopchJCmo2uo=;
        b=SOGE2ivdbw+HCGr6QkVhH9d1AO2A8+Lz24EwcxaDj9wYc+RTUmEbuKGxQOEfWvfeCq
         hzB3RvxDjSCMjqSCQjrDCRzuaV/BYgAtdBimfLkj7XiyovDran8Rh/1VU0uXEbky5BPz
         NEz+0UdPqs1r5BGWmR5+PzEiVF5RWGYnXaywvjDRpvNDHt4OWM7b2dJCSFZPAnR/p2Zg
         1YN8M9mmY4lhMZKhE8yHgFV7vFvpkelZNbRzE0uQnKHq0JAJvtRdyhY/SI58iwNYTwbx
         iX3PS8PI97bH9D51jlJoW/pzNUjsBB0kENU51BLAK97VH8h1EqpGH7hDxlYvdSaialKS
         wSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bd6bPFPDM+yhjJOFjj4y0MnFiVla5reSopchJCmo2uo=;
        b=IGFQ3PoQXb3E/dvwtIGL0t7TvPAl95lTdKeRGZWGvfJ7/pq7aS91YxVc0xT88vZV0P
         ZlL7jZLvhwZ2oWgVwjA7IBFEbb8hWrwtQq7LcYOVazHc5FnihYegQTA7YL94H46nmo8/
         PQXyHYQbDF45pP0e+k2CTMkRKL8R03nxZyRzPaIO6lhlPWnwPhgc7LrOYHDCdM1f4mOX
         hQj6gWagYZXPk6lohIm9Mzqv0J9WfZo12DbzhcmX+NsEVfkqpEDwKip3pcRUj7hPNN4W
         juDUx3uHfYmxS64O/a5VPqPNGGWyynRGmKI15RIg7+Bbcel94ywyeBhJqcLJEYzr55V+
         iEzA==
X-Gm-Message-State: AFqh2krBOP64PZnf0J6J6QHH0Pf1Kqdvqe5APPmd4GOOfVlzaoN8cr/c
        wQI3c0RtCbq/v+kEfSPLWFU4lpr905ul0wCEOkACncdu4XnhFQ==
X-Google-Smtp-Source: AMrXdXtwVcYXiJUYTpQ1k56RpF0UJKUjTxEtlmozOhgd8lmDaSmoYiWrkP/XTeyPITXC3E51Lp61a0RElxWT1TkcXqw=
X-Received: by 2002:a67:d785:0:b0:3ba:70d5:ed27 with SMTP id
 q5-20020a67d785000000b003ba70d5ed27mr1680261vsj.69.1671518026008; Mon, 19 Dec
 2022 22:33:46 -0800 (PST)
MIME-Version: 1.0
References: <CADg8p96Obiio+CUOCKzKqqc6m+B+zSDgs6SWLKSpSo5po94ApQ@mail.gmail.com>
 <ddefa55ad5c5f0dc0248a4017ea31e8e5d7a5328.camel@HansenPartnership.com>
In-Reply-To: <ddefa55ad5c5f0dc0248a4017ea31e8e5d7a5328.camel@HansenPartnership.com>
From:   Sughosh Ganu <sughosh.ganu@linaro.org>
Date:   Tue, 20 Dec 2022 12:03:35 +0530
Message-ID: <CADg8p972AxWMTQbAXc=+zX9STtLdRKUmopbjEbq0rfFP_TKwrg@mail.gmail.com>
Subject: Re: Question on loading trusted key with keyctl command
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 19 Dec 2022 at 18:20, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Mon, 2022-12-19 at 15:50 +0530, Sughosh Ganu wrote:
> > hi,
> > I am trying to enable the evm hmac solution on my qemu arm64 virt
> > platform running Debian. I am using the swtpm 2.0 implementation for
> > the TPM trusted source. Before I get into trying out the evm hmac
> > solution on the target system, I wanted to check creating the trusted
> > and encrypted keys.  Other details on my set up are as follows
> >
> > Distro - Debian 11
> > TPM - swtpm
> > Linux kernel - Linux version 6.1.0-13032, commit 77856d911a8c [1]
> > keyctl --version
> > keyctl from keyutils-1.6.1 (Built 2020-02-10)
> >
> > When trying to follow the steps highlighted in the
> > Documentation/security/keys/trusted-encrypted.rst, I can generate the
> > trusted key. However, when I try to load the trusted key using the
> > command shown in the document, it throws an error. Has there been a
> > change in the code, or am I missing some step when trying to load the
> > trusted key?
> >
> > Steps that I am following (after having created the SRK).
> >
> > # keyctl add trusted kmk "new 32 keyhandle=0x81000001" @u
> > # keyctl show
> > Session Keyring
> >  442944693 --alswrv      0     0  keyring: _ses
> >  925986946 --alswrv      0 65534   \_ keyring: _uid.0
> >  401286062 --alswrv      0     0       \_ trusted: kmk
> > # keyctl pipe 401286062 > kmk.blob
> > # keyctl add trusted kmk "load `cat kmk.blob` keyhandle=0x81000001"
> > @u
> > add_key: Invalid argument
>
> kmk is your invalid argument ... you already have a key there.  Either
> unlink %trusted:kmk or add the new key at kmk1.

I was able to load the key after clearing the keyring. Thanks James
and Mimi for your pointers.

-sughosh
