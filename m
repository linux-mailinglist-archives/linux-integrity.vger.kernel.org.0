Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5940D4CB6D3
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Mar 2022 07:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiCCGPY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Mar 2022 01:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiCCGPY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Mar 2022 01:15:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E73145ACD
        for <linux-integrity@vger.kernel.org>; Wed,  2 Mar 2022 22:14:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 029611F383;
        Thu,  3 Mar 2022 06:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646288078;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jfTudueYrA5s2/BQpYODQ25bKfR5/dSHKUc1lu/BkMc=;
        b=T+KvAvFBCYgdvadqAdulbLsRocNLD/rDBvdU/WRMfnqGBPAVUnMKNSZuQxKsZ7YafJOUtV
        MClrUJlX81jdi7gaus63BUWSnrFdIiI4mYUQ2ACM/IqTfklA7jDAALQxXDaSqCrvH0mRD5
        rdZ46J/18Xov4swkRevm5b0Aahl8rXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646288078;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jfTudueYrA5s2/BQpYODQ25bKfR5/dSHKUc1lu/BkMc=;
        b=xjVhRe4n0D7JtkpVlc4eVVgEJA4PpLkgqtL7izB1BgaFp7FB9ElRqDNxV9+/1amMqIU1bj
        2WCoMonZQM9MwnDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5F65132C1;
        Thu,  3 Mar 2022 06:14:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QYAFKs1cIGKrIAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 03 Mar 2022 06:14:37 +0000
Date:   Thu, 3 Mar 2022 07:14:34 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Yael Tzur <yaelt@google.com>, linux-integrity@vger.kernel.org,
        ltp@lists.linux.it
Subject: Re: [LTP] [PATCH v4] syscalls/keyctl09: test encrypted keys with
 provided decrypted data.
Message-ID: <YiBcyvtqTX1CerM4@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220223200731.1859670-1-yaelt@google.com>
 <Yh+S7JD2q8oalRoM@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh+S7JD2q8oalRoM@yuki>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Cyril, Yael,

> Hi!
> The test looks good to me now.

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> Looking at the kernel counterpart it is still in the next tree. We
> usually wait until the kernel functionality is part of a kernel release
> in order to make sure that there are no changes done to the
> kernel-userspace API.
Good (last time I checked it wasn't there).
For my record:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20220302&id=cd3bc044af483422cc81a93f23c78c20c978b17c

> I this case I guess that in this case the change is so minimal that we
> can add this test into LTP once it reaches Linus tree.
Cyril, maybe we could finally merge our policy (waiting ack for you):
https://patchwork.ozlabs.org/project/ltp/patch/20220203101803.10204-1-rpalethorpe@suse.com/
and put keyctl09 into runtest/staging now.

Kind regards,
Petr
