Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3CC5A7411
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Aug 2022 04:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiHaCsh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Aug 2022 22:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiHaCsb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Aug 2022 22:48:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D6AB3B23;
        Tue, 30 Aug 2022 19:48:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 807A06192E;
        Wed, 31 Aug 2022 02:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6159DC433C1;
        Wed, 31 Aug 2022 02:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661914109;
        bh=HDZw+4aeyhFB+8/0wyIB8tKlUh9S28kYnuv3E3uguOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WvAG5aG/hHeV1gHfHRfEO0l7SRfA4T6lBiLKHq8jHG9DGYWURWd1pfyfNm5CpQz+i
         CYrTD4GGdjHlZVwUWV9qM3QbbIUKg7oMfZmeSoWxbp/XNKWHCFc2UEr0aTgtjmTIO3
         /Zi+UuDe98tzXQMQgg99DF/zS/tjB3Za0J7XsHxrFJIjKUI5+sEuObXse0Qhorigv3
         +ks0pjNzuddDketown7oA8OKiLAZqC/Sqg5uL4clVmaustKf94RUnW9yIzgIfssWjQ
         hMidFpB1SQGAvPIYN+Vsf0+K+MK88umRoDZFSI8G7MWXx2i68EPRIp7atJ03gfWySI
         x6fyt+oiMgVAA==
Date:   Wed, 31 Aug 2022 05:48:25 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Matthew Garrett <mgarrett@aurora.tech>
Cc:     Ken Goldman <kgold@linux.ibm.com>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, dlunev@google.com,
        zohar@linux.ibm.com, jejb@linux.ibm.com,
        linux-integrity@vger.kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        gwendal@chromium.org, linux-pm@vger.kernel.org,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: TPM: hibernate with IMA PCR 10
Message-ID: <Yw7L+X2cHf9qprxl@kernel.org>
References: <20220504232102.469959-1-evgreen@chromium.org>
 <20220504161439.6.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
 <deafaf6f-8e79-b193-68bf-3ab01bddd5c2@linux.ibm.com>
 <CAHSSk06+CNQLKS8p_jh8JH7acn6=Ck8W3W2DM75rV3paZQ+MbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHSSk06+CNQLKS8p_jh8JH7acn6=Ck8W3W2DM75rV3paZQ+MbA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 29, 2022 at 02:51:50PM -0700, Matthew Garrett wrote:
> On Mon, Aug 29, 2022 at 2:45 PM Ken Goldman <kgold@linux.ibm.com> wrote:
> >
> > On 5/4/2022 7:20 PM, Evan Green wrote:
> > > Enabling the kernel to be able to do encryption and integrity checks on
> > > the hibernate image prevents a malicious userspace from escalating to
> > > kernel execution via hibernation resume.  [snip]
> >
> > I have a related question.
> >
> > When a TPM powers up from hibernation, PCR 10 is reset.  When a
> > hibernate image is restored:
> >
> > 1. Is there a design for how PCR 10 is restored?
> 
> I don't see anything that does that at present.
> 
> > 2. How are /sys/kernel/security/ima/[pseudofiles] saved and
> > restored?
> 
> They're part of the running kernel state, so should re-appear without
> any special casing. However, in the absence of anything repopulating
> PCR 10, they'll no longer match the in-TPM value.

This feature could still be supported, if IMA is disabled
in the kernel configuration, which I see a non-issue as
long as config flag checks are there.

BR, Jarkko
