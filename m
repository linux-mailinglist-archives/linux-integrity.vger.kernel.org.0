Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD575EC8FE
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Sep 2022 18:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiI0QGc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Sep 2022 12:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiI0QGD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Sep 2022 12:06:03 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027DE1D6275
        for <linux-integrity@vger.kernel.org>; Tue, 27 Sep 2022 09:04:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bj12so21641460ejb.13
        for <linux-integrity@vger.kernel.org>; Tue, 27 Sep 2022 09:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=liXObbgP3O1j9wnHRMWomBTfFdrqTMOSRmMpI7BXVVY=;
        b=n2Lk2q1OenQsBHB6/6w7EytQnVWgaCyzH63n8WLXHc9dTCHJyXCOhhf2LGOQ4BGMrC
         Fh8x4BoeM8b2tTPzogSAqD5NNiWEWowB8EInMzJnxyyfQVOFNsLTDc2Ov2/aNGCamFFP
         p5QciKn4hMoDlwkMbNEsmkIo4GYpzZn3Tz34o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=liXObbgP3O1j9wnHRMWomBTfFdrqTMOSRmMpI7BXVVY=;
        b=2J8EwoCMEQoPNGTifBNxwDaY8iH9jtqsAl6DQYC6W574ainhucL0MbGnc+JtzmN3+9
         gafapn9mOqzjI15pO5mvjSWW+zX89MWF0XudSA3e/Oo00aApJwgUr+S23OhT3ExRRD1z
         SdkkjN4HQu4MUC9oxKKxVZtNeJ37iQ9T7/Itf5O3oqbTFHLrajcpQfJYH0J26GGwLNmc
         G4bFwBIj4MzaPuiDn9Adf1ewTsowEjQ/9yjlKC+gGSe8uNJGwItKEZLszApxh5gChTrB
         KbMCd3s0F9UTjev4jcULokX3EQSwxKtiSTDyeUOxsWXSYpHAWL7Z/u1XGaWpd/wo4iz/
         1BPQ==
X-Gm-Message-State: ACrzQf13bAeTN0ekfPgGpS0DQMRfDRiAVDVlphd1PfL0mycvyyM2RAM2
        nUx7CW4hNtoL60aKpGAjgx76sdQwabYvSQ==
X-Google-Smtp-Source: AMsMyM4AGZFbW1M7I7l1dyHY8Npbf8EdR0SGYlSGsP8gu2N+TFWqcCYouJ56Ras0wJbFnrvodvm8TQ==
X-Received: by 2002:a17:907:1c91:b0:782:496f:271f with SMTP id nb17-20020a1709071c9100b00782496f271fmr24310666ejc.718.1664294644452;
        Tue, 27 Sep 2022 09:04:04 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id p22-20020aa7cc96000000b00457b5ba968csm1362022edt.27.2022.09.27.09.03.58
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 09:04:01 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id l18so3716488wrw.9
        for <linux-integrity@vger.kernel.org>; Tue, 27 Sep 2022 09:03:58 -0700 (PDT)
X-Received: by 2002:a5d:69ce:0:b0:22b:19d:2856 with SMTP id
 s14-20020a5d69ce000000b0022b019d2856mr18516147wrw.591.1664294638093; Tue, 27
 Sep 2022 09:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220504161439.6.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
 <deafaf6f-8e79-b193-68bf-3ab01bddd5c2@linux.ibm.com> <CAHSSk06+CNQLKS8p_jh8JH7acn6=Ck8W3W2DM75rV3paZQ+MbA@mail.gmail.com>
 <Yw7L+X2cHf9qprxl@kernel.org> <CAE=gft68it0VtFfddCiSQYfz2+Fmoc+6ZK-ounDrjuRJ8nsOLw@mail.gmail.com>
 <96360ec16b21d8b37461a5de083ff794f3604300.camel@linux.ibm.com>
 <Yxl8tbJERqrmsgpU@kernel.org> <96cfd1f3f084f6d145bd22e0989dc046fe15b66a.camel@linux.ibm.com>
 <YylDYU+KTX/KJpqU@kernel.org> <2bc656bf67af52e0b9a68e91c5b574e0ab4ffa8e.camel@linux.ibm.com>
 <Yy21B4EGumiI9XsU@kernel.org>
In-Reply-To: <Yy21B4EGumiI9XsU@kernel.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 27 Sep 2022 09:03:21 -0700
X-Gmail-Original-Message-ID: <CAE=gft7CnUVPqKpCHKPSpa3z-NR9pimhUJbz+qTkVV0E6WeoPw@mail.gmail.com>
Message-ID: <CAE=gft7CnUVPqKpCHKPSpa3z-NR9pimhUJbz+qTkVV0E6WeoPw@mail.gmail.com>
Subject: Re: TPM: hibernate with IMA PCR 10
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Ken Goldman <kgold@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniil Lunev <dlunev@google.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Sep 23, 2022 at 6:30 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Wed, Sep 21, 2022 at 04:15:20PM -0400, Mimi Zohar wrote:
> > On Tue, 2022-09-20 at 07:36 +0300, Jarkko Sakkinen wrote:
> > > On Sat, Sep 10, 2022 at 10:40:05PM -0400, Mimi Zohar wrote:
> > > > On Thu, 2022-09-08 at 08:25 +0300, Jarkko Sakkinen wrote:
> > > > > On Wed, Sep 07, 2022 at 07:57:27PM -0400, Mimi Zohar wrote:
> > > > > > On Wed, 2022-09-07 at 13:47 -0700, Evan Green wrote:
> > > > > > > On Tue, Aug 30, 2022 at 7:48 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Aug 29, 2022 at 02:51:50PM -0700, Matthew Garrett wrote:
> > > > > > > > > On Mon, Aug 29, 2022 at 2:45 PM Ken Goldman <kgold@linux.ibm.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On 5/4/2022 7:20 PM, Evan Green wrote:
> > > > > > > > > > > Enabling the kernel to be able to do encryption and integrity checks on
> > > > > > > > > > > the hibernate image prevents a malicious userspace from escalating to
> > > > > > > > > > > kernel execution via hibernation resume.  [snip]
> > > > > > > > > >
> > > > > > > > > > I have a related question.
> > > > > > > > > >
> > > > > > > > > > When a TPM powers up from hibernation, PCR 10 is reset.  When a
> > > > > > > > > > hibernate image is restored:
> > > > > > > > > >
> > > > > > > > > > 1. Is there a design for how PCR 10 is restored?
> > > > > > > > >
> > > > > > > > > I don't see anything that does that at present.
> > > > > > > > >
> > > > > > > > > > 2. How are /sys/kernel/security/ima/[pseudofiles] saved and
> > > > > > > > > > restored?
> > > > > > > > >
> > > > > > > > > They're part of the running kernel state, so should re-appear without
> > > > > > > > > any special casing. However, in the absence of anything repopulating
> > > > > > > > > PCR 10, they'll no longer match the in-TPM value.
> > > > > > > >
> > > > > > > > This feature could still be supported, if IMA is disabled
> > > > > > > > in the kernel configuration, which I see a non-issue as
> > > > > > > > long as config flag checks are there.
> > > > > > >
> > > > > > > Right, from what I understand about IMA, the TPM's PCR getting out of
> > > > > > > sync with the in-kernel measurement list across a hibernate (because
> > > > > > > TPM is reset) or kexec() (because in-memory list gets reset) is
> > > > > > > already a problem. This series doesn't really address that, in that it
> > > > > > > doesn't really make that situation better or worse.
> > > > > >
> > > > > > For kexec, the PCRs are not reset, so the IMA measurment list needs to
> > > > > > be carried across kexec and restored.  This is now being done on most
> > > > > > architectures.  Afterwards, the IMA measurement list does match the
> > > > > > PCRs.
> > > > > >
> > > > > > Hibernation introduces a different situation, where the the PCRs are
> > > > > > reset, but the measurement list is restored, resulting in their not
> > > > > > matching.
> > > > >
> > > > > As I said earlier the feature still can be supported if
> > > > > kernel does not use IMA but obviously needs to be flagged.
> > > >
> > > > Jumping to the conclusion that "hibernate" is acceptable for non-IMA
> > > > enabled kernels misses the security implications of mixing (kexec) non-
> > > > IMA and IMA enabled kernels.
> > > > I would prefer some sort of hibernate marker, the equivalent of a
> > > > "boot_aggregate" record.
> > >
> > > Not sure if this matters. If you run a kernel, which is not aware
> > > of IMA, it's your choice. I don't undestand why here is so important
> > > to protect user from doing illogical decisions.
> > >
> > > If you want non-IMA kernels to support IMA, CONFIG_IMA should not
> > > probably even exist because you are essentially saying that any
> > > kernel play well with IMA.
> >
> > That will never happen, nor am I suggesting it should.
> >
> > Enabling hibernate or IMA shouldn't be an either-or decision, if at all
> > possible.  The main concern is that attestation servers be able to
> > detect hibernation and possibly the loss of measurement
> > history.  Luckily, although the PCRs are reset, the TPM
> > pcrUpdateCounter is not.
> >
> > I would appreciate including a "hibernate" marker, similar to the
> > "boot_aggregate".
>
> Yeah, I guess that would not do harm.

I think I understand it. It's pretty much exactly a boot_aggregate
marker that we want, correct?

Should it have its own name, or is it sufficient to simply infer that
a boot_aggregate marker that isn't the first item in the list must
come from hibernate resume?

Should it include PCR10, to essentially say "the resuming system may
have extended this, but we can't reason about it and simply treat it
as a starting value"?
-Evan

>
> BR, Jarkko
