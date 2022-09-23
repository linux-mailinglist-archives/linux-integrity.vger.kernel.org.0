Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8190E5E7BE2
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Sep 2022 15:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiIWNbC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Sep 2022 09:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiIWNay (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Sep 2022 09:30:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E22E6DE9;
        Fri, 23 Sep 2022 06:30:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F4FD62510;
        Fri, 23 Sep 2022 13:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6481AC433D6;
        Fri, 23 Sep 2022 13:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663939851;
        bh=l1JlluurWiwvkKH7l5/tNNLVpHEQly8opDz1dsRJSOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TB2uLYC0uWJqGmCUafRtEj3CAiR5CnJiMB8w1NeQkeoHgEHqP4OJSUMGbgzYSqwO5
         8TNpqzkzimHavz8/puunVuqIGDKx5UmmX6UCMlpDOO2wAJMKp0+eKgdlaAdAxHpeFp
         foSM3FT9zvDgoCxL4DTMddeQ+W1J2Ncya5pastOM+lGnRQl84Xfrl9VNCFemqaP5bm
         RRrhmGijiYJ3/Z1Yc8Rh+2UtbgP+IGSbESZVkhwOuT3fOWN0zLNLx1zs/msuBmMbVq
         Ra0s/Jg/4XvF+oSrV9qxB3UrlTpuQ0mBAg1cGbEn7rOSCLyi2WSZAlPZhgfsxbc1Jx
         ytbGFRjQTJjeA==
Date:   Fri, 23 Sep 2022 16:30:47 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Evan Green <evgreen@chromium.org>,
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
Subject: Re: TPM: hibernate with IMA PCR 10
Message-ID: <Yy21B4EGumiI9XsU@kernel.org>
References: <20220504161439.6.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
 <deafaf6f-8e79-b193-68bf-3ab01bddd5c2@linux.ibm.com>
 <CAHSSk06+CNQLKS8p_jh8JH7acn6=Ck8W3W2DM75rV3paZQ+MbA@mail.gmail.com>
 <Yw7L+X2cHf9qprxl@kernel.org>
 <CAE=gft68it0VtFfddCiSQYfz2+Fmoc+6ZK-ounDrjuRJ8nsOLw@mail.gmail.com>
 <96360ec16b21d8b37461a5de083ff794f3604300.camel@linux.ibm.com>
 <Yxl8tbJERqrmsgpU@kernel.org>
 <96cfd1f3f084f6d145bd22e0989dc046fe15b66a.camel@linux.ibm.com>
 <YylDYU+KTX/KJpqU@kernel.org>
 <2bc656bf67af52e0b9a68e91c5b574e0ab4ffa8e.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bc656bf67af52e0b9a68e91c5b574e0ab4ffa8e.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 21, 2022 at 04:15:20PM -0400, Mimi Zohar wrote:
> On Tue, 2022-09-20 at 07:36 +0300, Jarkko Sakkinen wrote:
> > On Sat, Sep 10, 2022 at 10:40:05PM -0400, Mimi Zohar wrote:
> > > On Thu, 2022-09-08 at 08:25 +0300, Jarkko Sakkinen wrote:
> > > > On Wed, Sep 07, 2022 at 07:57:27PM -0400, Mimi Zohar wrote:
> > > > > On Wed, 2022-09-07 at 13:47 -0700, Evan Green wrote:
> > > > > > On Tue, Aug 30, 2022 at 7:48 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > > > >
> > > > > > > On Mon, Aug 29, 2022 at 02:51:50PM -0700, Matthew Garrett wrote:
> > > > > > > > On Mon, Aug 29, 2022 at 2:45 PM Ken Goldman <kgold@linux.ibm.com> wrote:
> > > > > > > > >
> > > > > > > > > On 5/4/2022 7:20 PM, Evan Green wrote:
> > > > > > > > > > Enabling the kernel to be able to do encryption and integrity checks on
> > > > > > > > > > the hibernate image prevents a malicious userspace from escalating to
> > > > > > > > > > kernel execution via hibernation resume.  [snip]
> > > > > > > > >
> > > > > > > > > I have a related question.
> > > > > > > > >
> > > > > > > > > When a TPM powers up from hibernation, PCR 10 is reset.  When a
> > > > > > > > > hibernate image is restored:
> > > > > > > > >
> > > > > > > > > 1. Is there a design for how PCR 10 is restored?
> > > > > > > >
> > > > > > > > I don't see anything that does that at present.
> > > > > > > >
> > > > > > > > > 2. How are /sys/kernel/security/ima/[pseudofiles] saved and
> > > > > > > > > restored?
> > > > > > > >
> > > > > > > > They're part of the running kernel state, so should re-appear without
> > > > > > > > any special casing. However, in the absence of anything repopulating
> > > > > > > > PCR 10, they'll no longer match the in-TPM value.
> > > > > > >
> > > > > > > This feature could still be supported, if IMA is disabled
> > > > > > > in the kernel configuration, which I see a non-issue as
> > > > > > > long as config flag checks are there.
> > > > > > 
> > > > > > Right, from what I understand about IMA, the TPM's PCR getting out of
> > > > > > sync with the in-kernel measurement list across a hibernate (because
> > > > > > TPM is reset) or kexec() (because in-memory list gets reset) is
> > > > > > already a problem. This series doesn't really address that, in that it
> > > > > > doesn't really make that situation better or worse.
> > > > > 
> > > > > For kexec, the PCRs are not reset, so the IMA measurment list needs to
> > > > > be carried across kexec and restored.  This is now being done on most
> > > > > architectures.  Afterwards, the IMA measurement list does match the
> > > > > PCRs.
> > > > > 
> > > > > Hibernation introduces a different situation, where the the PCRs are
> > > > > reset, but the measurement list is restored, resulting in their not
> > > > > matching.
> > > > 
> > > > As I said earlier the feature still can be supported if
> > > > kernel does not use IMA but obviously needs to be flagged.
> > > 
> > > Jumping to the conclusion that "hibernate" is acceptable for non-IMA
> > > enabled kernels misses the security implications of mixing (kexec) non-
> > > IMA and IMA enabled kernels. 
> > > I would prefer some sort of hibernate marker, the equivalent of a
> > > "boot_aggregate" record.
> > 
> > Not sure if this matters. If you run a kernel, which is not aware
> > of IMA, it's your choice. I don't undestand why here is so important
> > to protect user from doing illogical decisions.
> > 
> > If you want non-IMA kernels to support IMA, CONFIG_IMA should not
> > probably even exist because you are essentially saying that any
> > kernel play well with IMA.
> 
> That will never happen, nor am I suggesting it should.
> 
> Enabling hibernate or IMA shouldn't be an either-or decision, if at all
> possible.  The main concern is that attestation servers be able to
> detect hibernation and possibly the loss of measurement
> history.  Luckily, although the PCRs are reset, the TPM
> pcrUpdateCounter is not.
> 
> I would appreciate including a "hibernate" marker, similar to the
> "boot_aggregate".

Yeah, I guess that would not do harm.

BR, Jarkko
