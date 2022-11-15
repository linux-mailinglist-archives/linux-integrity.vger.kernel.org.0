Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A508629B94
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Nov 2022 15:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiKOOKG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Nov 2022 09:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKOOKF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Nov 2022 09:10:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5805F75
        for <linux-integrity@vger.kernel.org>; Tue, 15 Nov 2022 06:10:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9D12B22CFD;
        Tue, 15 Nov 2022 14:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668521402;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a9mfWSOs+km3lAQH5DVpKF7lZvN/oSMCLOpAa4F70jU=;
        b=yiJXF6QVUbJKXZO9icDNGlfI+aErZY3t3cDRMRX1QOyBSOXOSQhksYHNMCC46r1U3EMF/h
        NnU4u1rA5ejHMLFB1EPXaEvRbte4GiFLGpkcBLU8OJYjYenWNmDihnnyxBPbwzkHSG/Jci
        Q/Ml6ImIzYeA8wnWF5B7D4qHHaufJtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668521402;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a9mfWSOs+km3lAQH5DVpKF7lZvN/oSMCLOpAa4F70jU=;
        b=/3r7zeeLPvTciEWIKPYeK4xDAHSxy69RxksK+pVLD1Osg245AhNhj8Ud9eNtUPF4zkEf0k
        JKGBKiPZWuBy8hCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77EF413273;
        Tue, 15 Nov 2022 14:10:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ylNoG7qdc2MjdwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 15 Nov 2022 14:10:02 +0000
Date:   Tue, 15 Nov 2022 15:10:01 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>
Subject: Re: [RFC PATCH ima-evm-utils] Save ima-evm-utils sourceforge wiki
Message-ID: <Y3OduXPCoMsYAaN7@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20221114222451.832058-1-zohar@linux.ibm.com>
 <Y3OG3vzaPYCWntCa@pevik>
 <df8c5ff94c0297754c0649be0bc0ee1427a853c1.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df8c5ff94c0297754c0649be0bc0ee1427a853c1.camel@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> Hi Petr,

> On Tue, 2022-11-15 at 13:32 +0100, Petr Vorel wrote:
> > Hi Mimi, all,

> > > The sourceforge wiki info is dated and requires a major overhaul.  Some
> > > of the information already exists in the linux kernel documentation.
> > > For now, save it with the referenced html files.
> > May I ask why you in the end reverted this from next-testing?
> > fdd58fa ("Revert "Save ima-evm-utils sourceforge wiki"") has no explanation.
> > Maybe I missed some email.

> > I like moving docs to git repository.

> Oh!  It's not being removed permanently, just reverted temporarily. 
> Since pandoc wasn't installed all of the tests failed.  The patch just
> needs to be re-worked a bit.
> (I tweaked the fsverity test and wanted to see the github action
> results.)
Good to know, thanks for info.

Kind regards,
Petr

> thanks,

> Mimi

