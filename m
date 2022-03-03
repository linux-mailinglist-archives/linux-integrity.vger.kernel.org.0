Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C8B4CBF8A
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Mar 2022 15:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiCCOIR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Mar 2022 09:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiCCOIQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Mar 2022 09:08:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133A062F9
        for <linux-integrity@vger.kernel.org>; Thu,  3 Mar 2022 06:07:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E298D1F388;
        Thu,  3 Mar 2022 14:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646316448;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NQhr5IYmQVaOS1RbI6Ru8vbdrrsag32VvXk5LTmb6Pg=;
        b=BMRV8bvG9v/yEVz/B5kPCvvT+DG3wsRPkvhNanEBk/f5sYtwJjl2ZDnBf2tJQaMo2pUYyP
        UBmS8r5jykXOiao3KoovmAnJSwfgBuPovt6nBJwlECcLgK6gJCOFlHNpdYQXelJJjPwWDF
        RGQOvndApGKNV/Swew/mgG1HdNOyXGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646316448;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NQhr5IYmQVaOS1RbI6Ru8vbdrrsag32VvXk5LTmb6Pg=;
        b=XeqV53ESQaENSQjWRRwORGk1nYbZ144lmaSqSDWczFEuObCn/tiagNz+xjcava1k+P8LLy
        JukqAP9GH4Dq4mAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B002113C35;
        Thu,  3 Mar 2022 14:07:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kdZJKaDLIGK0bgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 03 Mar 2022 14:07:28 +0000
Date:   Thu, 3 Mar 2022 15:07:27 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Yael Tzur <yaelt@google.com>, linux-integrity@vger.kernel.org,
        ltp@lists.linux.it
Subject: Re: [LTP] [PATCH v4] syscalls/keyctl09: test encrypted keys with
 provided decrypted data.
Message-ID: <YiDLn3GMNFu482XG@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220223200731.1859670-1-yaelt@google.com>
 <Yh+S7JD2q8oalRoM@yuki>
 <YiBcyvtqTX1CerM4@pevik>
 <YiC4Pj1sH8UIHY7k@yuki>
 <YiDB7wO3Se/vN15+@pevik>
 <YiDGvzETiI/nxwW/@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiDGvzETiI/nxwW/@yuki>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Cyril,

[ Cc Richie, Li, Jan ]

> Hi!
> > > > > I this case I guess that in this case the change is so minimal that we
> > > > > can add this test into LTP once it reaches Linus tree.
> > > > Cyril, maybe we could finally merge our policy (waiting ack for you):
> > > > https://patchwork.ozlabs.org/project/ltp/patch/20220203101803.10204-1-rpalethorpe@suse.com/
> > > > and put keyctl09 into runtest/staging now.

> > > I guess that we still did not agree on exactly how this should be
> > > handled or did we?

> > Isn't it enough "Once a feature is part of the stable kernel ABI the associated
> > test must be moved out of staging." ?

> The main problem is that someone has to make sure that it happens and
> the process would be prone to errors. What I proposed instead was a flag
> that would set a kernel version in which the ABI is going to be merged
> and put the test right into the final runtest files. Then we can simply
> skip the test on older kernels or do anything else we see as a
> reasonable solution. At the same time we can easily add automatic
> checker that would look for these flags in metadata into the CI which
> would, for instance, send email to the ML once the flag is supposed to
> be removed.
OK, you're missing that kernel version. OTOH things get sometimes backported,
thus it's not error prone (if we forget to leave that flag after kernel being
released).

Also version is hard to say if you use maintainer tree (which applies patches on
previous rc1 than what is being in Linus tree). Thus maintainer's tree would be
left, also IMHO next tree has no specific version in uname, thus we'd only
support rc from Linus' tree.

But anyway, if all agree that this is better than both solutions Richie
implemented I'd try to find time to implement it so that we have finally a
solution.

> In this case it does not actually matter, since the test is guarded by a
> kernel config option that is introduced by the patchset and the change
> is fairly miniminal, so I do not think that there would be any changes
> to the ABI anyways.
Correct. At this stage IMHO we can dare to merge it.

Kind regards,
Petr
