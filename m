Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C369369880C
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Feb 2023 23:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBOWok (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Feb 2023 17:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjBOWoi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Feb 2023 17:44:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC13C265B3
        for <linux-integrity@vger.kernel.org>; Wed, 15 Feb 2023 14:44:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1C06F1F6E6;
        Wed, 15 Feb 2023 22:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676501070;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=scZfFLdEqisrBWMXu0uO9q2iHRXD8ILs4ZtCmLoN6t0=;
        b=Xl2eyHYKLt0FOXJbgdJEOJblqDLJgJ47172lnwBYHJ7X2zkGjzrW0owxfL9KpAoK71rybK
        66Uw5lUnNbDKGWmORZTe+5SXw6RqeM1tuxqO9SjSpZtRpzV5lcFXTaWASrGmC7xhBMbH5I
        AEqF78gelbpJKtcjfAgU0/aT9pj8KYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676501070;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=scZfFLdEqisrBWMXu0uO9q2iHRXD8ILs4ZtCmLoN6t0=;
        b=nqUA7zAEcOnZcMKYJebOYtUwEJpvyjAXhN2ygD6FVTPy6Oh/TKR8FKIsCAlWru2P5yJZ4a
        VE6T7HshCJQAOoDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B390134BA;
        Wed, 15 Feb 2023 22:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8Rb9H01g7WONSwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 15 Feb 2023 22:44:29 +0000
Date:   Wed, 15 Feb 2023 23:44:28 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     dmitry.kasatkin@gmail.com, vt@altlinux.org, stefanb@linux.ibm.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils 0/3] CI: Tumbleweed openSSL fix
Message-ID: <Y+1gTC0cjCo6Aw0v@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230214210035.585395-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214210035.585395-1-pvorel@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> Tested:
> https://github.com/pevik/ima-evm-utils/actions/runs/4177976359/jobs/7236222413

Thanks for merging this.

My test was working:
https://github.com/pevik/ima-evm-utils/actions/runs/4177976359

But the same code now fails for Fedora.
I wonder what exactly is wrong now:
https://github.com/mimizohar/ima-evm-utils/actions/runs/4188686859/jobs/7260231106
https://github.com/pevik/ima-evm-utils/actions/runs/4188761663/jobs/7260289846

FAIL: fsverity
==============

which: no fsverity in (../src:../fsverity-utils:/github/home/ima-evm-utils-install/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin)
dd is /usr/bin/dd
mkfs is /usr/sbin/mkfs
blkid is /usr/sbin/blkid
e2fsck is /usr/sbin/e2fsck
tune2fs is /usr/sbin/tune2fs
evmctl is ../src/evmctl
setfattr is /usr/bin/setfattr
./functions.sh: line 90: ../linux: No such file or directory
=================================
 Run with FAILEARLY=1 ./fsverity.test _cleanup_env cleanup
 To stop after first failure
=================================
PASS: 0 SKIP: 0 FAIL: 1

FAIL fsverity.test (exit status: 1)

FAIL: portable_signatures
=========================

evmctl is /__w/ima-evm-utils/ima-evm-utils/tests/../src/evmctl
./functions.sh: line 90: ../linux: No such file or directory
./functions.sh: line 90: ../linux: No such file or directory

Kind regards,
Petr

> Petr Vorel (3):
>   tests/install-swtpm.sh: Update ibmswtpm2 to 1682
>   github: travis: Remove COMPILE_SSL from tumbleweed
>   github: Put openSSL build into own section

>  .github/workflows/ci.yml | 8 ++++++--
>  .travis.yml              | 2 +-
>  tests/install-swtpm.sh   | 2 +-
>  3 files changed, 8 insertions(+), 4 deletions(-)
