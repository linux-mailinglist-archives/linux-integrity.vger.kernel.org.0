Return-Path: <linux-integrity+bounces-4844-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9095BA38513
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 14:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C56163EF2
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 13:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894DF125D6;
	Mon, 17 Feb 2025 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I1Hvq/NF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wkOjiTyQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U+n2BevP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="15+8oFxu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BAE748F
	for <linux-integrity@vger.kernel.org>; Mon, 17 Feb 2025 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800080; cv=none; b=sCRHldrIFyHjL7EBOf7Jf+aSJ9D1AB5suxjpPehtGBsYXJJeeQxWY6qua/20Qh75mu1EBtk3jtrseeH8a6zVCBA+dNkTlfp7dIUYI4csB4wKcjpQE8kVA1zb+oyK5Qy7prPh4ogxZ8Eddy+v7A34Ps1XOTUEYE1RX0dMZvV79MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800080; c=relaxed/simple;
	bh=nhBpGltpWl/4XFVS8g8wNW8BYRFXVVaTYZy+QrXQLm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQ4/F7k5FlL/1M12VCBnbdIVar1JXqTgFBVes83lhp8wWTMp5JKULXvydv3v9WgvhpJFqW9A8I5Nb+ewDZ9vk5v1NN6GY0+W2NIrQ9YnIUyj5Z0c12myagvfRdDrgoEfTCHNLqFfzbnGihbI5n83ILTX3Tdgxta2T8WNFiAQc/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I1Hvq/NF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wkOjiTyQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U+n2BevP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=15+8oFxu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B5F4D1F451;
	Mon, 17 Feb 2025 13:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739800076;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UN08rTgrg4jrZMeefBpeLigtywai5ug5K6JSD7x9Vv0=;
	b=I1Hvq/NFZB3TCAmclMQWrxrpzooSsTXdqqgHeeS+r7Wr0OZtkHMKwERjkRSuKrqoWADnSR
	EHRtSOODnp3BBlgC1qZz7o/J9YYJd+un/chkqXWuvK5k61rGYRYQkI3RPNtVvi/yww4HCl
	fEm8vUlY0eQCO15hEmMCFKTddrnO48A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739800076;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UN08rTgrg4jrZMeefBpeLigtywai5ug5K6JSD7x9Vv0=;
	b=wkOjiTyQugLlPB/ytWxU0vnq4ZnxLYGNHqcexRawdalLVFYlBqIzv4T3qj5rJo1IqXAU6r
	PtXKeIaMFBLtZ6Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=U+n2BevP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=15+8oFxu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739800075;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UN08rTgrg4jrZMeefBpeLigtywai5ug5K6JSD7x9Vv0=;
	b=U+n2BevPgjznYUr+McOKcuvz+IADNKdVTUQviekiskFCtupYzNtUrrdANjcMlkTz0hS3fH
	tjrF2rXmHNKIgAc/Vr88ETzsgHoi0Fg4BNkfBWE1WggU63WT0V98+7+0jOA+n3sVRFJYmQ
	dQMGRsTpPvbY8UxTMw5sah65oWLJYsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739800075;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UN08rTgrg4jrZMeefBpeLigtywai5ug5K6JSD7x9Vv0=;
	b=15+8oFxubrTrDvyxUwQ0oXk0wW3mZqQHCYivNEoLzk1JfDT1VkzN21tGPrgUUoqkKNtyiz
	dIhNtTw6w+a18BCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EDF7133F9;
	Mon, 17 Feb 2025 13:47:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RmSqIQs+s2dcFgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 17 Feb 2025 13:47:55 +0000
Date: Mon, 17 Feb 2025 14:47:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
	Andrea Cervesato <andrea.cervesato@suse.de>
Subject: Re: [PATCH 2/2] ima_selinux.sh: Detect SELinux before loading policy
Message-ID: <20250217134754.GA2397156@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250217130839.2392666-1-pvorel@suse.cz>
 <20250217130839.2392666-2-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217130839.2392666-2-pvorel@suse.cz>
X-Rspamd-Queue-Id: B5F4D1F451
X-Spam-Level: 
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.71
X-Spam-Flag: NO

Hi,

> Adding TST_SETUP_EARLY to run test specific setup before loading policy.
> That allows to avoid loading IMA policy (which usually request reboot)
> if the test would be skipped anyway.

> Fixes: aac97cca96 ("ima_setup.sh: Allow to load predefined policy")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/security/integrity/ima/tests/ima_selinux.sh | 3 ++-
>  testcases/kernel/security/integrity/ima/tests/ima_setup.sh   | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
> index 97c5d64ec5..577f7c2aca 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
> @@ -13,9 +13,10 @@

>  TST_NEEDS_CMDS="awk cut grep tail"
>  TST_CNT=2
> -TST_SETUP="setup"
>  TST_MIN_KVER="5.12"

> +TST_SETUP_EARLY="setup"

Hm, unlike TST_SETUP_CALLER, which is defined in ima_setup.sh, using "TST_"
prefixed variables in the test itself is catched by variable checker in
tst_test.sh:

ima_selinux 1 TWARN: Reserved variable TST_SETUP_EARLY used!

I need to redefine the variable to not use "TST_" prefix (see the diff below).
I'm sorry for the noise.

Kind regards,
Petr

+++ testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
@@ -15,7 +15,7 @@ TST_NEEDS_CMDS="awk cut grep tail"
 TST_CNT=2
 TST_MIN_KVER="5.12"
 
-TST_SETUP_EARLY="setup"
+IMA_SETUP_EARLY="setup"
 
 REQUIRED_POLICY_CONTENT='selinux.policy'
 
diff --git testcases/kernel/security/integrity/ima/tests/ima_setup.sh testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 2a9f64978e..befaf7f73c 100644
--- testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -265,7 +265,7 @@ ima_setup()
 		cd "$TST_MNTPOINT"
 	fi
 
-	[ -n "$TST_SETUP_EARLY" ] && $TST_SETUP_EARLY
+	[ -n "$IMA_SETUP_EARLY" ] && $IMA_SETUP_EARLY
 
 	if ! verify_ima_policy; then
 		load_ima_policy

