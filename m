Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2DB58DC97
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Aug 2022 18:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245133AbiHIQ5j (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Aug 2022 12:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244966AbiHIQ5i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Aug 2022 12:57:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0784C219C;
        Tue,  9 Aug 2022 09:57:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97E2260E06;
        Tue,  9 Aug 2022 16:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A798AC433D7;
        Tue,  9 Aug 2022 16:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660064257;
        bh=WAASOV4CwOcN1cCgsBmLQSOIEbY6fPAxVQ3aBPMZSjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nqn/o6ze2W0Ul8vxCqBwsXAzm/gQNYQyTssUpsiCxLZcphwO5hP8Nc9kHCJJnwZz0
         HyohtgLGko93UrJfbfNy1WEvbIQyEUUof6QlovbYeQ+VUkuPyw8C2rOZZfBgtGWLAI
         ATGo0fb5Rhpo8+/mWiEV8NJiue3G7YRbm8uL96kyAcBtOw8Cr0v0IpcIMxMPPB/fa8
         ryF8OBPKSTc1y/3UkVc/7GNupz6+6Q2VrqLrgkd3GRdf09LtDv9igBA0vzn+UUag3u
         VaA4trBiNXFdPPSGkLpugAWfcfF0SVbjfVyDC61AZMlQFn8OGgFatWUk7War+MzCds
         94OHjupe9KP8A==
Date:   Tue, 9 Aug 2022 19:57:33 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] tpmdd updates for v5.20
Message-ID: <YvKR/a0BeD+QB4XF@kernel.org>
References: <20220803210228.158993-1-jarkko@kernel.org>
 <87pmhgikhk.fsf@kernel.org>
 <5653318a776a8044f413ed1a4b6e3965fac2297e.camel@HansenPartnership.com>
 <87czdfi6t9.fsf@kernel.org>
 <Yu6qQHMoBzC4zprg@kernel.org>
 <87o7wun91z.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7wun91z.fsf@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 08, 2022 at 04:45:12PM +0300, Kalle Valo wrote:
> Jarkko Sakkinen <jarkko@kernel.org> writes:
> 
> >> Odd, I haven't noticed any UTF-8 problems in my setup but Gnus/Emacs is
> >> known to be picky. After some more investigation I noticed this in
> >> Jarkko's email:
> >> 
> >> Content-Type: text/plain; charset=y
> >> 
> >> I admit I'm not up to par with the latest cool stuff but that charset
> >> can't be valid, right? :)
> >
> > I must have pressed 'y' and enter, instead of enter,
> > when git send-email asked whether to use UTF-8 or
> > something like that.
> >
> > Sorry about that :-) I don't recall doing that but
> > that is what it looks like for me.
> 
> Hehe, that indeed sounds likely. Thanks, I was curious where that 'y'
> came from :)

Thanks for reporting this :-) Always good to sanity check, when
there is a visible inconsistency.

BR, Jarkko
