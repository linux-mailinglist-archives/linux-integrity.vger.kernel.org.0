Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC234CBF10
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Mar 2022 14:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiCCNpG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Mar 2022 08:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiCCNpG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Mar 2022 08:45:06 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A78A18A796
        for <linux-integrity@vger.kernel.org>; Thu,  3 Mar 2022 05:44:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 247E2218B8;
        Thu,  3 Mar 2022 13:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646315059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5h6PhZkZVkImb/Kg+DH+jKdsYSfBkNGMeRBt1kpBkV8=;
        b=Bqr+ROybMtA4eyr0QDUzYW5pvSAVq/F940uBuCZmlLDUqxNV1VLifKgE0isVXz/CGbEwRU
        OIKx+5bE62wGXCr3zIyZsRfcvjv+F6MuX3U8ZwqrCEgbYlX0h108njj+nnTRcQZOIunJHl
        H3AWVqr2zDJ8VuGLKm88Fy+X5dvjAXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646315059;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5h6PhZkZVkImb/Kg+DH+jKdsYSfBkNGMeRBt1kpBkV8=;
        b=NoASqYIbBUPHz7uELqT0BraHKB4xITt94tWFKXWXIbmLtxiGnCfrkGEwIQumQOy5TV6bxl
        hKbosJtydOvZOkCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD01113C23;
        Thu,  3 Mar 2022 13:44:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JV6tLTLGIGICYwAAMHmgww
        (envelope-from <chrubis@suse.cz>); Thu, 03 Mar 2022 13:44:18 +0000
Date:   Thu, 3 Mar 2022 14:46:39 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Yael Tzur <yaelt@google.com>, linux-integrity@vger.kernel.org,
        ltp@lists.linux.it
Subject: Re: [LTP] [PATCH v4] syscalls/keyctl09: test encrypted keys with
 provided decrypted data.
Message-ID: <YiDGvzETiI/nxwW/@yuki>
References: <20220223200731.1859670-1-yaelt@google.com>
 <Yh+S7JD2q8oalRoM@yuki>
 <YiBcyvtqTX1CerM4@pevik>
 <YiC4Pj1sH8UIHY7k@yuki>
 <YiDB7wO3Se/vN15+@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiDB7wO3Se/vN15+@pevik>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi!
> > > > I this case I guess that in this case the change is so minimal that we
> > > > can add this test into LTP once it reaches Linus tree.
> > > Cyril, maybe we could finally merge our policy (waiting ack for you):
> > > https://patchwork.ozlabs.org/project/ltp/patch/20220203101803.10204-1-rpalethorpe@suse.com/
> > > and put keyctl09 into runtest/staging now.
> 
> > I guess that we still did not agree on exactly how this should be
> > handled or did we?
> 
> Isn't it enough "Once a feature is part of the stable kernel ABI the associated
> test must be moved out of staging." ?

The main problem is that someone has to make sure that it happens and
the process would be prone to errors. What I proposed instead was a flag
that would set a kernel version in which the ABI is going to be merged
and put the test right into the final runtest files. Then we can simply
skip the test on older kernels or do anything else we see as a
reasonable solution. At the same time we can easily add automatic
checker that would look for these flags in metadata into the CI which
would, for instance, send email to the ML once the flag is supposed to
be removed.

In this case it does not actually matter, since the test is guarded by a
kernel config option that is introduced by the patchset and the change
is fairly miniminal, so I do not think that there would be any changes
to the ABI anyways.

-- 
Cyril Hrubis
chrubis@suse.cz
