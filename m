Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7198358B767
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Aug 2022 19:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiHFRxw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 6 Aug 2022 13:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiHFRxw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 6 Aug 2022 13:53:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C4E12092;
        Sat,  6 Aug 2022 10:53:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5AB6B80782;
        Sat,  6 Aug 2022 17:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F89C433D7;
        Sat,  6 Aug 2022 17:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659808428;
        bh=GXDqVRZt9fdXIfL0GZFMKDRO82fbPD8G2cDtXPmaYEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pA+YEv/T1494pOISyvBjjA45QG1mQ5JyeD65x7a0wclrMPUWlHh+ivGbKEpK/EPP/
         yTVyNMzbazqE7ttFwVdqTkbEk3mP6osAAMksS5pQI0Gmz+IkU3SPV8ztVg8dJc4ATU
         t9uQDHecC/EGxAWXMd+gHECoaIGVi7ogwM7KsYFuMy8FZFwTAD//uWWY1OYmWne5+N
         Oa7ZS99ADjxCERiFHNF0v7ysTWwh5E0T1DrvR5rqcvzeC/xDk/OSeYzV02YQv5B0su
         j7xtIoD8GWLJSZVQLbDzHG9BHdB+tiqaUpSiTq/ASlCnHC4rfZztT1HZVLuK/eJjrY
         WjeRsdv0MzQdg==
Date:   Sat, 6 Aug 2022 20:53:45 +0300
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
Message-ID: <Yu6qqdfSJScYItmn@kernel.org>
References: <20220803210228.158993-1-jarkko@kernel.org>
 <87pmhgikhk.fsf@kernel.org>
 <5653318a776a8044f413ed1a4b6e3965fac2297e.camel@HansenPartnership.com>
 <87czdfi6t9.fsf@kernel.org>
 <Yu6qQHMoBzC4zprg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yu6qQHMoBzC4zprg@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Aug 06, 2022 at 08:52:04PM +0300, Jarkko Sakkinen wrote:
> On Fri, Aug 05, 2022 at 08:43:30AM +0300, Kalle Valo wrote:
> > James Bottomley <James.Bottomley@HansenPartnership.com> writes:
> > 
> > > On Thu, 2022-08-04 at 09:35 +0300, Kalle Valo wrote:
> > >> Jarkko Sakkinen <jarkko@kernel.org> writes:
> > > [...]
> > >> > M...rten Lindahl (1):
> > >> >       tpm: Add check for Failure mode for TPM2 modules
> > >> 
> > >> Some encoding problems in the name? At least my Gnus didn't show them
> > >> correctly.
> > >
> > > My mail tool correctly renders the 'å' character, and lore has it too:
> > >
> > > https://lore.kernel.org/all/20220803210228.158993-1-jarkko@kernel.org/
> > >
> > > So I think you have a local UTF-8 translation problem.
> > 
> > Odd, I haven't noticed any UTF-8 problems in my setup but Gnus/Emacs is
> > known to be picky. After some more investigation I noticed this in
> > Jarkko's email:
> > 
> > Content-Type: text/plain; charset=y
> > 
> > I admit I'm not up to par with the latest cool stuff but that charset
> > can't be valid, right? :)
> > 
> > -- 
> > https://patchwork.kernel.org/project/linux-wireless/list/
> > 
> > https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> 
> I must have pressed 'y' and enter, instead of enter,
> when git send-email asked whether to use UTF-8 or
> something like that.
> 
> Sorry about that :-) I don't recall doing that but
> that is what it looks like for me.

I'll update my scripting to make sure that it cannot
happen again.

BR, Jarkko
