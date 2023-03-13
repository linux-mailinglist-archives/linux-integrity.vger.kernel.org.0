Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECB96B700E
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Mar 2023 08:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjCMHWh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Mar 2023 03:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCMHWg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Mar 2023 03:22:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248E15072F
        for <linux-integrity@vger.kernel.org>; Mon, 13 Mar 2023 00:22:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BF8CA225B1;
        Mon, 13 Mar 2023 07:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678692144;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y7GGJJyQjMWOVje4/QCOYl82zjp49KCIMHSKga2o9hM=;
        b=IiKpe7l+wzfyAl6E7JehIeo/BhcgzhjU5asRpKX3kQvqwmzjrBwz0llfM0w0R++KEy3PFa
        RHQi4xAzv6kdb985jD2kk/L/eqEZlpFl4ut+ik8UZfkk/D+xr3QYml5WfI1m8B3jMQZFpH
        E21oD3quC6H0c6EoPUH5PxTB4wbT/O4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678692144;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y7GGJJyQjMWOVje4/QCOYl82zjp49KCIMHSKga2o9hM=;
        b=0oLyLAn7cbB3+1YAOgH1cHAHW9i2g+WPnsIOUxHywTw8ZqvAjPFhnyfZ1rpFonhQe/j1pg
        7OrepbukbMSAyRBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8966013517;
        Mon, 13 Mar 2023 07:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3CmxHzDPDmQaWgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 13 Mar 2023 07:22:24 +0000
Date:   Mon, 13 Mar 2023 08:22:22 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [PATCH ima-evm-utils] fsverity.test: Add /usr/sbin into $PATH
Message-ID: <20230313072222.GA550975@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230310104729.32078-1-pvorel@suse.cz>
 <fee39e794cec39474b54d5a3da3a79e40acdce47.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fee39e794cec39474b54d5a3da3a79e40acdce47.camel@linux.ibm.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> On Fri, 2023-03-10 at 11:47 +0100, Petr Vorel wrote:
> > Unlike GitHub CI, tests which run by packaging tools often run as non-root,
> > thus required tools aren't visible:

> > ./functions.sh: line 45: type: mkfs: not found
> > mkfs is required for test
> > ./functions.sh: line 45: type: blkid: not found
> > blkid is required for test
> > ./functions.sh: line 45: type: e2fsck: not found
> > e2fsck is required for test
> > ./functions.sh: line 45: type: tune2fs: not found
> > tune2fs is required for test

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi Mimi,

> > some would maybe appreciate option to skip all tests,
> > but this is enough for me.

> Hi Petr,

> Thank you for the patch.  It's now queued in next-testing.
Thank you.

> The UML kernel opens up a lot of options going forward.  For now all
> the tests are lumped together, but they should be separated based on
> ima-evm-utils selftests vs. the kernel tests.  Even that might not be
> granular enough.
Thanks for info, sounds reasonable.

> For now from the command line, the environment variable "TESTS"
> overrides the set of tests as defined in the Makefile to execute.  For
> example, "export TESTS="ima_sign.test sign_verify.test"; make -e check"
> executes just the two tests.
Also, TESTS= would skip all the tests (but prefer to run them).

> Also commit b573b7d4a186 ("Introduce TST_LIST variable to select a test
> to execute")  can define the set of tests to execute.
Good to know (this one is hidden in test functions).

Kind regards,
Petr
