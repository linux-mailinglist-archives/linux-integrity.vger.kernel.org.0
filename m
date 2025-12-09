Return-Path: <linux-integrity+bounces-7875-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6BBCB00AE
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Dec 2025 14:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F16CD301A1B9
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Dec 2025 13:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AABB288525;
	Tue,  9 Dec 2025 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dXyT3H0v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XNE1Yg3i";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ah62tPCg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0T5uCkzN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5508219A7A
	for <linux-integrity@vger.kernel.org>; Tue,  9 Dec 2025 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765286356; cv=none; b=iOWIqPOtIhxlcpyMWvcx4r0dUayasCBC5ikqN6y8uzwV0CUz8Mb1upqWyCP8tpvF1SUFKRylQs28gO8oSXNcypi8Gio1Wfqm8BcAz6fE6yK9MVB5n85vnZp3meBxQUt/0dG+aH83G0NfDJ0QtraftAkiVdoIUIwSv4U6ZP6j+fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765286356; c=relaxed/simple;
	bh=RjXZVDam+Nlxj7dKKXc2K9YczSPRoFq0dS8S5USh89k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YojOJsgxpAo+JESmb7o4W5H/lBaNMa+AZISNCB0IXqEEQjE322H5M1e+GIC/JIUYx3BgNaiEHmZWUYVhXx0mdJVlPpkwOv80kqbhCeEvcYT+wOIgSs6udXy9i06oYNvuR9Jl8RyEMoiSLvY7XIAJ3uth8Ny0Sc8yoddY4pRZcfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dXyT3H0v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XNE1Yg3i; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ah62tPCg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0T5uCkzN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 233515BE30;
	Tue,  9 Dec 2025 13:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765286345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sylz5wWwmP56dJcE/RoAYIM6tFs023Qu1Eal5VNdntg=;
	b=dXyT3H0vmdbo6oPMOZ/9l8UzulPXt/Mn8MP2RpAS6qsKfuztTfFZNyFlXvseGkYCRg+gRx
	jeDOvirOjU3dky67yAYHpXvTBdVQ7Fsy7UusWoa4GbFAOGy2NXPaovdluZTotvbEDLLzo/
	LLsBHfPBuuJA2SJRAZgm7yq4/yCZpw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765286345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sylz5wWwmP56dJcE/RoAYIM6tFs023Qu1Eal5VNdntg=;
	b=XNE1Yg3iljK6OHnEpvyx5ZxLm2fHdtLeuWxZQP9Gi/frZQ5MVKCDkMPasNdSHzAP22KHan
	T4jTt61ekzHgOECw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ah62tPCg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0T5uCkzN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765286344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sylz5wWwmP56dJcE/RoAYIM6tFs023Qu1Eal5VNdntg=;
	b=ah62tPCglLY8qMDeVJzFizNg/P9TZzGM6ol0+Is+IytsQx94qvNwPjwcQRCNXXHxNmU2Ks
	vWYdj482IBSSVWuoWpVWPTy7+cP8oobxKSmJx8kb0e30OMDX7vznmgU+pe+Zq1uXejNl67
	FfRUxt+O5fCKu+Mmglzern/Y4bQCOhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765286344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sylz5wWwmP56dJcE/RoAYIM6tFs023Qu1Eal5VNdntg=;
	b=0T5uCkzN6qxaN6f3sHRcAM4ktnifCCkiiMkffyPsx2BcFmrEdcg7QYXQFLWObTwvMj4qYG
	n/xNRGWZVYUwOGCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 104773EA63;
	Tue,  9 Dec 2025 13:19:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7LkZA8ghOGkdEwAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Tue, 09 Dec 2025 13:19:04 +0000
Date: Tue, 9 Dec 2025 14:19:48 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Cc: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
	Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org, Jan Stancek <jstancek@redhat.com>
Subject: Re: [PATCH v3 1/4] shell: Add tst_sudo.c helper
Message-ID: <aTgh9CIRfVWniUZD@yuki.lan>
References: <20251127082638.224110-1-pvorel@suse.cz>
 <20251127082638.224110-2-pvorel@suse.cz>
 <CAEemH2cUYekSphFW_uj2w1FzYt3RWXDDnhmQ5TFAyr0T3HFxow@mail.gmail.com>
 <CAEemH2e6ivP0rzfTBp5LnZ8n-oe7moqfHszgs2QyYVMUTUQ_wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEemH2e6ivP0rzfTBp5LnZ8n-oe7moqfHszgs2QyYVMUTUQ_wQ@mail.gmail.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,yuki.lan:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 233515BE30
X-Spam-Flag: NO
X-Spam-Score: -4.51

Hi!
> > I feel that the filename tst_sudo.c is a bit misleading. The helper
> > doesn’t
> > replicate sudo behavior (authentication, privilege escalation), it simply
> > drops from root to a fixed UID/GID before executing a command.
> >
> > So readers may expect a “sudo-like” elevation wrapper when, however
> > it’s a privilege-dropping trampoline.
> >
> > What about renaming it to:
> >   tst_runas.c,
> >   tst_runas_nobody.c, or
> >   tst_drop_privs.c?
> >
> 
> 
> Personally, I prefer the tst_runas_nody.c because it reflects the
> default privilege,
> but due it supports the more env so contains "su" maybe better:
>   tst_su_switch.c, tst_su_cmd.c

Maybe just tst_runas.c I think that 'runas' in the name is probably the
best description.

-- 
Cyril Hrubis
chrubis@suse.cz

