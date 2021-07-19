Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BAB3CD042
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Jul 2021 11:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbhGSIc7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Jul 2021 04:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbhGSIc6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Jul 2021 04:32:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A62C061767
        for <linux-integrity@vger.kernel.org>; Mon, 19 Jul 2021 01:14:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r11so21090350wro.9
        for <linux-integrity@vger.kernel.org>; Mon, 19 Jul 2021 02:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rammhold-de.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GeYs5mUjYDt0F2pt9uFHOrxKHtsEsE7bcDIp+B4aHvo=;
        b=bhk6S9NOUkSPKEjpHWFtoWIrtMtNdrMDrY5331MwknZwHcBc/vMseahQRkTCnlR9A2
         6EKlOTD94+BUjmtwWwufy845nmzbvkGyuoJ6R5OL7MizcQXw4FwX282tzMZBmYl1+zU6
         jBfoOBB4/QBA7a2XetktBSzCym1/4KiHpdkG6+gbCCnQ3GeJ8+3rWey5LWuhUZQdZLp0
         tZ5NamtSPFmX+ROipJX5O2h5Nq5iZEAEUtC+OyeEvwRnVqtd1Mz0HrAhJ88f54T4x8X8
         R0ostqChH3EE4MFoUylTYQUf00mCBjbG+mmlsas0blGJu2KCLyHiTHlHGa/a6HbY/jh4
         RwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GeYs5mUjYDt0F2pt9uFHOrxKHtsEsE7bcDIp+B4aHvo=;
        b=HzleZhD33NdiGMDwGyCUuJ8AmyXAkh4fQSA8rE5mj7u+R9V/sPTw69HMBaLUGtCu8z
         sGOtmjB6eSRK+iFb8bSb+bi/tp4ctaXWhLKp6P42uoRhmGNIiK4MnZDIMjuWReQztYCg
         qNru3ZL0gDpi3VURSKgr3RZvcLJZbXOiiFqf4sEVzZKWprsk2Bl7pdx4sMz6SdGFGmSv
         4YDAbOFMmHcYLyjAAqDPllPderKE4OnfnqCwfMzRe5EJ7OqGwiKhHhdn/lvPBRisYSJ6
         jC29FGH2SYtCcJDT86mOywXFCxZpY8mH0SO68pcppFjt2jfrLeIt+ZF70+gfz1QopZ04
         a9oQ==
X-Gm-Message-State: AOAM531kF4lX9m6Gx77bvg7a3EEzjGO8/Tskcw1iOtx7OIRjTCpTdayC
        /A/rLWD6OxxzjQAmlLSlGe/fdw==
X-Google-Smtp-Source: ABdhPJzMCiKr5hj44zPyPDDx5BtCn4p8iU7luZUs62uKGnRmZidwZz3cAr2zupNUfWNosVeWl1wRwQ==
X-Received: by 2002:a5d:464b:: with SMTP id j11mr28745704wrs.356.1626686016925;
        Mon, 19 Jul 2021 02:13:36 -0700 (PDT)
Received: from localhost ([2a00:e67:1fd:a:4af1:ba6e:49d3:2e89])
        by smtp.gmail.com with ESMTPSA id r18sm19820621wrt.96.2021.07.19.02.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 02:13:36 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:13:35 +0200
From:   andreas@rammhold.de
To:     Sumit Garg <sumit.garg@linaro.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH] KEYS: trusted: Fix trusted key backends when building as
 module
Message-ID: <20210719091335.vwfebcpkf4pag3wm@wrt>
References: <20210716081722.4130161-1-andreas@rammhold.de>
 <0a684d56-66d0-184e-4853-9faafa2d243d@pengutronix.de>
 <CAFA6WYNC2xasX4uKmgcK+ZmA4HUh5PhCci+e12VFWPfF0b0eWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFA6WYNC2xasX4uKmgcK+ZmA4HUh5PhCci+e12VFWPfF0b0eWQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 13:36 19.07.21, Sumit Garg wrote:
> On Mon, 19 Jul 2021 at 12:40, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >
> > Hello Andreas,
> >
> > On 16.07.21 10:17, Andreas Rammhold wrote:
> > > Before this commit the kernel could end up with no trusted key sources
> > > even thought both of the currently supported backends (tpm & tee) were
> > > compoiled as modules. This manifested in the trusted key type not being
> > > registered at all.
> >
> > I assume (TPM) trusted key module use worked before the TEE rework? If so,
> >
> > an appropriate Fixes: Tag would then be in order.
> >
> > > When checking if a CONFIG_… preprocessor variable is defined we only
> > > test for the builtin (=y) case and not the module (=m) case. By using
> > > the IS_ENABLE(…) macro we to test for both cases.
> >
> > It looks to me like you could now provoke a link error if TEE is a module
> > and built-in trusted key core tries to link against trusted_key_tee_ops.
> >
> 
> That's true.
> 
> > One solution for that IS_REACHABLE(). Another is to address the root cause,
> > which is the inflexible trusted keys Kconfig description:
> >
> > - Trusted keys despite TEE support can still only be built when TCG_TPM is enabled
> > - There is no support to have TEE or TPM enabled without using those for
> >   enabled trusted keys as well
> > - As you noticed, module build of the backend has issues
> >
> > I addressed these three issues in a patch[1], a month ago, but have yet to
> > receive feedback.
> 
> That's an oversight on my part since this patch was part of the new
> CAAM trust source patch-set. Although I do admit that it was on my
> TODO list. So I have provided some feedback on that patch. Can you
> post the next version as an independent fix patch?

Thank you both for the feedback. In light of thes feedback and the
patchset that Ahmad posted I'll not address the issue and not send a v2
of this.

I'll try to squeeze in some time to test the other patch and provide
feedback.

Andi
