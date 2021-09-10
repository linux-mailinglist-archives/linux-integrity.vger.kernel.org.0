Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94E14067B7
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Sep 2021 09:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhIJHej (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Sep 2021 03:34:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49980 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhIJHei (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Sep 2021 03:34:38 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 951F92224B;
        Fri, 10 Sep 2021 07:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631259207;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4qyQ/7BG1TnU+IxQhJuIDF+njuM0HBdCGgeE9nQGkt0=;
        b=xIZNzejKPAteZ+XD/fSvMw/qmZUw8JhyeeDpvQ2CG13LBWnInOlA5bsCXmgw36X7TcgQ0+
        hZciwoiqHOSAq19oCOyLZhNZEt74OuWiY8XIdTXqbEIzhlUV+19L0s7TpiISeOsekceRM8
        M6FN/iND0LquJ+XXLb1j0OdDnTSEIJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631259207;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4qyQ/7BG1TnU+IxQhJuIDF+njuM0HBdCGgeE9nQGkt0=;
        b=/y2pjDRtNCKBOuSWS8TKe6WQ1ZcRfe4BTWrlOfr/AJXAKM8nvoVnQ+OvzdnVczzCTejEV/
        Uk6YQzdQAqb4IiCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38A5F13D1D;
        Fri, 10 Sep 2021 07:33:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id d1kWC0cKO2HQNQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 10 Sep 2021 07:33:27 +0000
Date:   Fri, 10 Sep 2021 09:33:25 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Alex Henrie <alexh@vpitech.com>
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zohar@linux.ibm.com, alexhenrie24@gmail.com
Subject: Re: [PATCH ltp] IMA: Add tests for uid, gid, fowner, and fgroup
 options
Message-ID: <YTsKRfSj7lAxKfQH@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210909165111.51038-1-alexh@vpitech.com>
 <20210909165111.51038-2-alexh@vpitech.com>
 <YTpswsqlDS5tI7NC@pevik>
 <20210909183545.a33cb2c25f13eb2a1d7b64ac@vpitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909183545.a33cb2c25f13eb2a1d7b64ac@vpitech.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Alex,

> On Thu, 9 Sep 2021 22:21:22 +0200
> Petr Vorel <pvorel@suse.cz> wrote:

> > > Requires "ima: add gid support".
> > I haven't test the patch yet, but LTP supports (unlike kselftest) various kernel
> > versions. Thus there should be some check to prevent old kernels failing.
> > You could certainly wrap new things with if tst_kvcmp. If there is a chance new
> > functionality can be detected, we prefer it because various features are
> > sometimes backported to enterprise distros' kernels.

> > Also, adding new test ima_measurements02.sh with TST_MIN_KVER would also work,
> > although for IMA tests I usually kept everything in a single file.

> I'll add a tst_kvcmp check under the assumption that this feature will
> be added before Linux 5.15.
+1. Please let me know when you manage to get this mainlined (merged into Mimi's
tree is enough), we should also add the commit hash of this feature.

> > > +++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> > > @@ -8,6 +8,7 @@

> > >  TST_NEEDS_CMDS="awk cut sed"
> > You should add sudo:

> > TST_NEEDS_CMDS="awk cut sed sudo"

> Will do.
+1

> > >  TST_SETUP="setup"
> > > +TST_CLEANUP="cleanup"
> > >  TST_CNT=3
> > >  TST_NEEDS_DEVICE=1

> > > @@ -20,6 +21,13 @@ setup()
> > >  	TEST_FILE="$PWD/test.txt"
> > >  	POLICY="$IMA_DIR/policy"
> > >  	[ -f "$POLICY" ] || tst_res TINFO "not using default policy"
> > > +
> > > +	cat $IMA_POLICY > policy-original
> > This might not work if CONFIG_IMA_READ_POLICY is not set. There is
> > check_policy_readable() helper in ima_setup.sh. Is it really needed anyway?

> It looks like CONFIG_IMA_WRITE_POLICY only makes it possible to add new
> rules at runtime, not remove them, so the cleanup code didn't actually
> work. I'll remove it.

FYI I have on my TODO list loading policy before testing [1].

> > > +}
> > > +
> > > +cleanup()
> > > +{
> > > +	cat policy-original > $IMA_POLICY
> > Again, this will not work if CONFIG_IMA_WRITE_POLICY not set.
> > And this is very likely not to be set.

> The new tests require the policy to be writable. I'll move the
> check_policy_writable function from ima_policy.sh to ima_setup.sh and
> use it in ima_measurements.sh as well.

+1.

FYI there is IMA specific README.md [2], in case anything needs to be updated.

> Thanks for the feedback,
yw. Thanks for taking care about testing!

Kind regards,
Petr

> -Alex

[1] https://github.com/linux-test-project/ltp/issues/720
[2] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/security/integrity/ima/README.md
