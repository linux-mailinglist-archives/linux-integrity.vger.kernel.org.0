Return-Path: <linux-integrity+bounces-4845-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 528EDA385D5
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 15:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5B11892BF3
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 14:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6655221D587;
	Mon, 17 Feb 2025 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jU/PaiYI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FlzhB1cb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jU/PaiYI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FlzhB1cb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCD921D5BB
	for <linux-integrity@vger.kernel.org>; Mon, 17 Feb 2025 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801823; cv=none; b=Qet3ngxrYKaRI80clIoN3Lr4VO+Kj/6KOFdOKUJwa1t5F0WJ0vv/1lXM2ZlxfF0TolBIovscVk6fMyLeDb8rnlMcBx+mY90tLuE4qylutAvODXCtWbZ4sRGvLTZlCoDUr9D836IqTwLhWiio8CIe+WxgFBfXp/lix5BlytxSZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801823; c=relaxed/simple;
	bh=qclJ6vBmY0W7y//YFH/uTvdn9Mf+8Orp37YueVJgi14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lq6A6HM2uW+zMf70cTO179UivkTImHvoiG4qaICrwZyIw2xMLDPhuOyhXC8J4Ie1dHsGrCCxbFOGalccXh++7IpyX2nsi1q2Ev572q1lcGAQ1PzCgPtXap3ISeg7a1r8nvuC9gP4omosqSxdgw/9QN8I2Cebxr2zi2VfpvKkoBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jU/PaiYI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FlzhB1cb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jU/PaiYI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FlzhB1cb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A69C2117A;
	Mon, 17 Feb 2025 14:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739801819;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2FyH6MgOrI33T9tqzhNUP8IDVNVE6z/Mq6p7Wp4VQNg=;
	b=jU/PaiYIV+uW9isVI+P0qTLXado2e0lrNWy/N6T9TGs2jdFAqgMrcISItcduAuERSlfSBD
	tvO/yfFGKv0RNDa4rJ3auR9/MAJdmIJ2KvJkJJkCzBNbYoUKux4LyehM9pp/5TH1RuLlyg
	3YEfT+KyAR5+r8NoH3n7wGN0eLSqiN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739801819;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2FyH6MgOrI33T9tqzhNUP8IDVNVE6z/Mq6p7Wp4VQNg=;
	b=FlzhB1cb8UsZMukypwt/PgWNnppe25XWxLdqHiXS+rUYSggyFognWXkEcPhTaxFQveYc5f
	9bVQoaxJ60B3NTAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739801819;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2FyH6MgOrI33T9tqzhNUP8IDVNVE6z/Mq6p7Wp4VQNg=;
	b=jU/PaiYIV+uW9isVI+P0qTLXado2e0lrNWy/N6T9TGs2jdFAqgMrcISItcduAuERSlfSBD
	tvO/yfFGKv0RNDa4rJ3auR9/MAJdmIJ2KvJkJJkCzBNbYoUKux4LyehM9pp/5TH1RuLlyg
	3YEfT+KyAR5+r8NoH3n7wGN0eLSqiN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739801819;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2FyH6MgOrI33T9tqzhNUP8IDVNVE6z/Mq6p7Wp4VQNg=;
	b=FlzhB1cb8UsZMukypwt/PgWNnppe25XWxLdqHiXS+rUYSggyFognWXkEcPhTaxFQveYc5f
	9bVQoaxJ60B3NTAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDAEE133F9;
	Mon, 17 Feb 2025 14:16:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0NnlMdpEs2dTIAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 17 Feb 2025 14:16:58 +0000
Date: Mon, 17 Feb 2025 15:16:52 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [LTP] [PATCH 2/2] ima_selinux.sh: Detect SELinux before loading
 policy
Message-ID: <20250217141652.GB2397156@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250217130839.2392666-1-pvorel@suse.cz>
 <20250217130839.2392666-2-pvorel@suse.cz>
 <ea6764ea-db92-4f49-ba5a-650f62bcfa23@suse.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea6764ea-db92-4f49-ba5a-650f62bcfa23@suse.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-7.50 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -7.50
X-Spam-Flag: NO

Hi Andrea,

> Hi!

> On 2/17/25 14:08, Petr Vorel wrote:
> > Adding TST_SETUP_EARLY to run test specific setup before loading policy.
> > That allows to avoid loading IMA policy (which usually request reboot)
> > if the test would be skipped anyway.

> > Fixes: aac97cca96 ("ima_setup.sh: Allow to load predefined policy")
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >   testcases/kernel/security/integrity/ima/tests/ima_selinux.sh | 3 ++-
> >   testcases/kernel/security/integrity/ima/tests/ima_setup.sh   | 2 ++
> >   2 files changed, 4 insertions(+), 1 deletion(-)

> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
> > index 97c5d64ec5..577f7c2aca 100755
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
> > @@ -13,9 +13,10 @@
> >   TST_NEEDS_CMDS="awk cut grep tail"
> >   TST_CNT=2
> > -TST_SETUP="setup"
> >   TST_MIN_KVER="5.12"
> > +TST_SETUP_EARLY="setup"
> > +
> >   REQUIRED_POLICY_CONTENT='selinux.policy'
> >   setup()
> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > index 1f1c267c4b..2a9f64978e 100644
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > @@ -265,6 +265,8 @@ ima_setup()
> >   		cd "$TST_MNTPOINT"
> >   	fi
> > +	[ -n "$TST_SETUP_EARLY" ] && $TST_SETUP_EARLY
> > +
> Why not doing ". ima_setup.sh" at the end of setup() ?

I do not understand what you mean. How would it help?

Also since 04021637f4 ("tst_test.sh: Cleanup getopts usage")
shell library is required to be run at the end of a shell test,
just before tst_run.

FYI at least for some tests (these with $REQUIRED_BUILTIN_POLICY, e.g.
evm_overlay.sh) it makes sense to check /proc/cmdline content (e.g. run
load_ima_policy()) before the test specific setup to quit early enough. But OTOH
it's best to postpone loading the policy after other checks are done (e.g. here
check for SELinux), because loading policy often requires reboot. Maybe best
would be to do $REQUIRED_BUILTIN_POLICY check *before running the setup and
keep loading the policy *after* the setup. Maybe I should postpone loading
(see the diff below).

Kind regards,
Petr

> >   	if ! verify_ima_policy; then
> >   		load_ima_policy
> >   	fi
> Andrea

diff --git testcases/kernel/security/integrity/ima/tests/ima_selinux.sh testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
index c8eb80b641..97c5d64ec5 100755
--- testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
+++ testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
@@ -13,10 +13,9 @@
 
 TST_NEEDS_CMDS="awk cut grep tail"
 TST_CNT=2
+TST_SETUP="setup"
 TST_MIN_KVER="5.12"
 
-IMA_SETUP_EARLY="setup"
-
 REQUIRED_POLICY_CONTENT='selinux.policy'
 
 setup()
diff --git testcases/kernel/security/integrity/ima/tests/ima_setup.sh testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index befaf7f73c..f7ec5aeb35 100644
--- testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -245,6 +245,8 @@ load_ima_policy()
 
 ima_setup()
 {
+	local load_policy
+
 	SECURITYFS="$(mount_helper securityfs $SYSFS/kernel/security)"
 
 	IMA_DIR="$SECURITYFS/ima"
@@ -265,13 +267,15 @@ ima_setup()
 		cd "$TST_MNTPOINT"
 	fi
 
-	[ -n "$IMA_SETUP_EARLY" ] && $IMA_SETUP_EARLY
+	verify_ima_policy
+	load_policy=$?
+
+	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
 
-	if ! verify_ima_policy; then
+	if [ $load_policy -ne 0 ]; then
 		load_ima_policy
 	fi
 
-	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
 }
 
 ima_cleanup()

