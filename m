Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6384C33E6
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Feb 2022 18:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiBXRnI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Feb 2022 12:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiBXRnI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Feb 2022 12:43:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5D42177E6;
        Thu, 24 Feb 2022 09:42:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 305E11F37C;
        Thu, 24 Feb 2022 17:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645724556;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oHRcXNAyVVLBmzjtITjvYsLkaLmEBNuckTKDj2JF/sQ=;
        b=qjReW5R4Uw6x5aNoKjevXfGCZdphemqRh+9z7KgeK3+PdYeNitd3JjyDgtrF3cOvwLPNcB
        l2aZuvycJ72O/Pz5lP05+t5WE7B0FcDV6FDiGRlVv7YF6pFhEy3P9EPo4H5EXxqMYtNvv7
        p9XPBICZw3U8HzfYz2NYBH77pGILyI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645724556;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oHRcXNAyVVLBmzjtITjvYsLkaLmEBNuckTKDj2JF/sQ=;
        b=bP3zwb+almDjPEBWW1T5UZXt9hS5kwf0Isr6ycFHkERR7tAq0C/x9r4nhTzdINjCy5ksIS
        gO2TXUQiUS1GncAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCD7713B15;
        Thu, 24 Feb 2022 17:42:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EjarK4vDF2J4GwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 24 Feb 2022 17:42:35 +0000
Date:   Thu, 24 Feb 2022 18:42:29 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     zohar@linux.ibm.com, dvyukov@google.com, ebiggers@kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com
Subject: Re: [PATCH 2/2] integrity: double check iint_cache was initialized
Message-ID: <YhfDhYQYZTU0clAf@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210322154207.6802-2-zohar@linux.ibm.com>
 <20220224142025.2587-1-pvorel@suse.cz>
 <418628ea-f524-05a1-8bfc-a688fa2d625d@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418628ea-f524-05a1-8bfc-a688fa2d625d@schaufler-ca.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Casey,

> On 2/24/2022 6:20 AM, Petr Vorel wrote:
> > Hi Mimi, Tetsuo, Kees, all,

> > FYI this commit merged as 92063f3ca73a ("integrity: double check iint_cache was initialized")
> > is the reason for openSUSE distro installer going back from lsm= to deprecated
> > security= when filling default grub parameters because security=apparmor or
> > security=selinux does not break boot when used with ima_policy=tcb, unlike
> > using lsm.

> OK, color me confused. Integrity isn't an LSM. It doesn't
> call security_add_hooks().
Really: "Initially I also questioned making "integrity" an LSM.  Perhaps it's
time to reconsider." [1]

> > @Kees, @Mimi sure, people who use ima_policy=tcb will just remove lsm parameter
> > or add "integrity" to it but I wonder whether there could be "integrity"
> > automatic inclusion when using ima_policy=tcb. Although the point of lsm= (and
> > CONFIG_LSM) is to have *ordered* list of enabled LSMs and it wouldn't be clear
> > on which place.

> Why would adding integrity to the lsm= make sense? It's not an LSM.

> Sorry, but something is wrong here.
np. I explained that: try to boot with "ima_policy=tcb lsm=" or "ima_policy=tcb
lsm=whatever" (whatever != integrity).

Also have look at commit 92063f3ca73a ("integrity: double check iint_cache was
initialized") which explain why it's needed.

Kind regards,
Petr

[1] https://lore.kernel.org/linux-integrity/3ed2004413e0ac07c7bd6f10294d6b6fac6fdbf3.camel@linux.ibm.com/
