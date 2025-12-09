Return-Path: <linux-integrity+bounces-7879-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2197FCB0DD8
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Dec 2025 19:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1C283053922
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Dec 2025 18:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12296302CAB;
	Tue,  9 Dec 2025 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MRtAog7E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TPdu7rfm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MRtAog7E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TPdu7rfm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E922243367
	for <linux-integrity@vger.kernel.org>; Tue,  9 Dec 2025 18:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765305846; cv=none; b=bu2HL56LgpBChdLlADErvEZ2XYYngWTZoqqQ8NoBs0uIxcVhXqOx2DOU9ki7Bf+gSkFXyMYC/tPKQqfoJCXN1DJd3mrdYE/+bR4aOO6gMPzLFMsn5CuSfljJk+tjn+sTus2JifygGFPHhs5UvCXoB//MaipbtPDYc6a0otZGzdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765305846; c=relaxed/simple;
	bh=SfTSHO6rAuHzBqpPWcZylAGO8JoMr5LgzO5TxgJrH/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzHT5gB3MVkgJR0bkX4VRbuJycvinQH+cTLibTDqewGluhHLtByx1YFeRSiBBE+Sfq5A4iUJX0L1+1f9IbACkPCesfdrwRrqUfUCGykkDTlQKTDLyJwAfCTzf2qReeQrSQinQufQfd8EgM+gH5C1NiiSC0/L+w3gU0uMCiSeQqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MRtAog7E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TPdu7rfm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MRtAog7E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TPdu7rfm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6721D3375E;
	Tue,  9 Dec 2025 18:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765305842;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8BGlZEtEoLR/HVSJWFSPyomvWBcE5Nn2v4lwdYy2MqA=;
	b=MRtAog7EQcSERm0C39xErGa0fVm5C3w4y7VICKZ8Z7YCtqW7Ei2qzxCn8iZEsSAnvWnpBn
	hniwAQyX/gbcgMiA2LZQbqIv0MduGEOq7QfysAeluMoI7LrOdQLMK48AkyjOQ+/fRxnBA9
	QMsit257F8FLQRiQbGKuqwEM07Tt4Fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765305842;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8BGlZEtEoLR/HVSJWFSPyomvWBcE5Nn2v4lwdYy2MqA=;
	b=TPdu7rfm8A5pDINKX/rHcVE3bfiejZSi1v5o/9tJATqD2V3AY2nSqiYxu/8uivvH8gSU1h
	QBo+l8DRgC5OmxDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765305842;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8BGlZEtEoLR/HVSJWFSPyomvWBcE5Nn2v4lwdYy2MqA=;
	b=MRtAog7EQcSERm0C39xErGa0fVm5C3w4y7VICKZ8Z7YCtqW7Ei2qzxCn8iZEsSAnvWnpBn
	hniwAQyX/gbcgMiA2LZQbqIv0MduGEOq7QfysAeluMoI7LrOdQLMK48AkyjOQ+/fRxnBA9
	QMsit257F8FLQRiQbGKuqwEM07Tt4Fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765305842;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8BGlZEtEoLR/HVSJWFSPyomvWBcE5Nn2v4lwdYy2MqA=;
	b=TPdu7rfm8A5pDINKX/rHcVE3bfiejZSi1v5o/9tJATqD2V3AY2nSqiYxu/8uivvH8gSU1h
	QBo+l8DRgC5OmxDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 276153EA63;
	Tue,  9 Dec 2025 18:44:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kQZgCPJtOGlbPgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 09 Dec 2025 18:44:02 +0000
Date: Tue, 9 Dec 2025 19:44:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: Li Wang <liwang@redhat.com>, ltp@lists.linux.it,
	Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org, Jan Stancek <jstancek@redhat.com>
Subject: Re: [PATCH v3 1/4] shell: Add tst_sudo.c helper
Message-ID: <20251209184400.GA16151@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20251127082638.224110-1-pvorel@suse.cz>
 <20251127082638.224110-2-pvorel@suse.cz>
 <CAEemH2cUYekSphFW_uj2w1FzYt3RWXDDnhmQ5TFAyr0T3HFxow@mail.gmail.com>
 <CAEemH2e6ivP0rzfTBp5LnZ8n-oe7moqfHszgs2QyYVMUTUQ_wQ@mail.gmail.com>
 <aTgh9CIRfVWniUZD@yuki.lan>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTgh9CIRfVWniUZD@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.50

> Hi!
> > > I feel that the filename tst_sudo.c is a bit misleading. The helper
> > > doesn’t
> > > replicate sudo behavior (authentication, privilege escalation), it simply
> > > drops from root to a fixed UID/GID before executing a command.

> > > So readers may expect a “sudo-like” elevation wrapper when, however
> > > it’s a privilege-dropping trampoline.

> > > What about renaming it to:
> > >   tst_runas.c,
> > >   tst_runas_nobody.c, or
> > >   tst_drop_privs.c?



> > Personally, I prefer the tst_runas_nody.c because it reflects the
> > default privilege,
> > but due it supports the more env so contains "su" maybe better:
> >   tst_su_switch.c, tst_su_cmd.c

> Maybe just tst_runas.c I think that 'runas' in the name is probably the
> best description.

LGTM. I'll send v4.

Kind regards,
Petr

