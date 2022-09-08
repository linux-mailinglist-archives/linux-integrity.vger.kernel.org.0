Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E08D5B1408
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Sep 2022 07:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiIHFZU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Sep 2022 01:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiIHFZT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Sep 2022 01:25:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5353C697C;
        Wed,  7 Sep 2022 22:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77687B81F74;
        Thu,  8 Sep 2022 05:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27E1C433C1;
        Thu,  8 Sep 2022 05:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662614715;
        bh=osN0nyK8KwiIgCh1KT2OvlnB6W7vIWDWuXnKS0QOONI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fdFrY63l05XtHxT0jgjBilC5RsfiXOfLR8PaJw5hnprOQn9oBQZ0I0ftP6mjYDi2Z
         bvWqDTib3obv+XUNvFrc5Lr9tV8eyh3Dfg035a2NMyZxdBcO94xp/HVU756mwf9/kL
         2XvD92RzN259RKNwMrYSrp0tZGFABPWp9DAF5VnsEpYvpWHeNINkCOSPVOCmwvwNrl
         xpzciixWdDs//CQl1IiV1gkVL95QUpvw7JTauZCk+m+OCTmefuoeaXDgNjX9EsJg2U
         zlYLc3ZB3S7rzhMSaunVR9OgqD+xUC9iATj/x6QGtsw5NuC4rjADG+xrN5Ndd+M6Qf
         jny6YHh5bu8FA==
Date:   Thu, 8 Sep 2022 08:25:09 +0300
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
Message-ID: <Yxl8tbJERqrmsgpU@kernel.org>
References: <20220504232102.469959-1-evgreen@chromium.org>
 <20220504161439.6.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
 <deafaf6f-8e79-b193-68bf-3ab01bddd5c2@linux.ibm.com>
 <CAHSSk06+CNQLKS8p_jh8JH7acn6=Ck8W3W2DM75rV3paZQ+MbA@mail.gmail.com>
 <Yw7L+X2cHf9qprxl@kernel.org>
 <CAE=gft68it0VtFfddCiSQYfz2+Fmoc+6ZK-ounDrjuRJ8nsOLw@mail.gmail.com>
 <96360ec16b21d8b37461a5de083ff794f3604300.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96360ec16b21d8b37461a5de083ff794f3604300.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 07, 2022 at 07:57:27PM -0400, Mimi Zohar wrote:
> On Wed, 2022-09-07 at 13:47 -0700, Evan Green wrote:
> > On Tue, Aug 30, 2022 at 7:48 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > >
> > > On Mon, Aug 29, 2022 at 02:51:50PM -0700, Matthew Garrett wrote:
> > > > On Mon, Aug 29, 2022 at 2:45 PM Ken Goldman <kgold@linux.ibm.com> wrote:
> > > > >
> > > > > On 5/4/2022 7:20 PM, Evan Green wrote:
> > > > > > Enabling the kernel to be able to do encryption and integrity checks on
> > > > > > the hibernate image prevents a malicious userspace from escalating to
> > > > > > kernel execution via hibernation resume.  [snip]
> > > > >
> > > > > I have a related question.
> > > > >
> > > > > When a TPM powers up from hibernation, PCR 10 is reset.  When a
> > > > > hibernate image is restored:
> > > > >
> > > > > 1. Is there a design for how PCR 10 is restored?
> > > >
> > > > I don't see anything that does that at present.
> > > >
> > > > > 2. How are /sys/kernel/security/ima/[pseudofiles] saved and
> > > > > restored?
> > > >
> > > > They're part of the running kernel state, so should re-appear without
> > > > any special casing. However, in the absence of anything repopulating
> > > > PCR 10, they'll no longer match the in-TPM value.
> > >
> > > This feature could still be supported, if IMA is disabled
> > > in the kernel configuration, which I see a non-issue as
> > > long as config flag checks are there.
> > 
> > Right, from what I understand about IMA, the TPM's PCR getting out of
> > sync with the in-kernel measurement list across a hibernate (because
> > TPM is reset) or kexec() (because in-memory list gets reset) is
> > already a problem. This series doesn't really address that, in that it
> > doesn't really make that situation better or worse.
> 
> For kexec, the PCRs are not reset, so the IMA measurment list needs to
> be carried across kexec and restored.  This is now being done on most
> architectures.  Afterwards, the IMA measurement list does match the
> PCRs.
> 
> Hibernation introduces a different situation, where the the PCRs are
> reset, but the measurement list is restored, resulting in their not
> matching.

As I said earlier the feature still can be supported if
kernel does not use IMA but obviously needs to be flagged.

BR, Jarkko
