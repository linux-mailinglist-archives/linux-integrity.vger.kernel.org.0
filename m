Return-Path: <linux-integrity+bounces-8093-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EF145CC8A8B
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Dec 2025 17:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56B2330412CD
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Dec 2025 16:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E47337100;
	Wed, 17 Dec 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uFjd6wnM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eSvTBOj7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PoOGu4tQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SIvYNUc9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF86E336ED1
	for <linux-integrity@vger.kernel.org>; Wed, 17 Dec 2025 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765987074; cv=none; b=ASN81lnS5MFCopQpvYMtMA77k0tPeyg1O/ztRHoEGFbtQQQHJg29Kt6GLwyfwA/USEWVuomk3/gi9FNoeijnJrgGDP+JoXTagSf65M4e90D5eF6DAKZgBtdnNsVz4jDTxVavN7T4xQoIuYn7xZarjv2TnrSPyKvBrIAT7uUzDH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765987074; c=relaxed/simple;
	bh=r2A/mIQSs3DOO1COMmqbzdm//cAwIxroYyZYqxrwec8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8w1fkJ93MKTlgT3FOEmeWW0seaUR/1MMOiAclm7eOdcqZfzwQ2ExjrRUsvlwuEd14vBHUjwLXUNZqoXgKBIGPb4hAkguLQwdddOYXdn5dx+JMpl902FiJxMIn/q+haPy5BRuaSsCrLP62a1oGFHkgdoYdr5jk05cbf6QLkyooA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uFjd6wnM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eSvTBOj7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PoOGu4tQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SIvYNUc9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EC9145BCF9;
	Wed, 17 Dec 2025 15:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765987067;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iqYoKKyYnhjsX29Qbz9+KoEF7v9iudpVQeAQiVNs0k8=;
	b=uFjd6wnM5fRCgIGN7CsCUW4sTWZj9Plld+d+la0767tmq0Yr9ie9sbpPBbRAENHOoqCijO
	3uw/lNvb8wXoOcvETYrhDWe5l+Wn+kGbedpQGb5jf2bWlbk1B3Tp5k4XSAkoUzW8tpP91c
	O7uDgD+LJKfsHj9d1g4TxNxUZRywzLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765987067;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iqYoKKyYnhjsX29Qbz9+KoEF7v9iudpVQeAQiVNs0k8=;
	b=eSvTBOj7JASxE1VbDkkJ6pmGKV8vyZorfQhUbc0hTYLXBeC7q+LD32UZ5ryZhinht0A+t3
	yoPus52eLNhlKSCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765987065;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iqYoKKyYnhjsX29Qbz9+KoEF7v9iudpVQeAQiVNs0k8=;
	b=PoOGu4tQIo3N6BKXgfmgv4ZJJXkB2UA7/ddtxhQUkRLUKc4qWZsy0Xm8Zh/l2+ADTRZUs8
	QqBneIjMRt8a9O1rwgyK6PxCU5Fz+3Eye24lYi96c/ai9OzZUBuvJZ7eylex0MOrN2Uywq
	Jh45R6n+RWrN+agW3lTEuViYq0H/IqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765987065;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iqYoKKyYnhjsX29Qbz9+KoEF7v9iudpVQeAQiVNs0k8=;
	b=SIvYNUc9Bgl1sEqfGwM94OpJMV5jwEjQAO96BdDgAV9zTaFmCNrl213Vy8I73H9+TSw9VO
	8crs+QYfxXE9T6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 874503EA63;
	Wed, 17 Dec 2025 15:57:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bxpgH/nSQmlnXwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 17 Dec 2025 15:57:45 +0000
Date: Wed, 17 Dec 2025 16:57:44 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: Li Wang <liwang@redhat.com>, ltp@lists.linux.it,
	Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org, Jan Stancek <jstancek@redhat.com>
Subject: Re: [PATCH v4 1/4] shell: Add tst_runas.c helper
Message-ID: <20251217155744.GA75994@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20251209185557.20598-1-pvorel@suse.cz>
 <20251209185557.20598-2-pvorel@suse.cz>
 <CAEemH2ej8-e_S4LgcKKkt08dUhyF0TreWp-QvXzQ1QGQYbywJg@mail.gmail.com>
 <aULIhXrMA4dgTwGg@yuki.lan>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aULIhXrMA4dgTwGg@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -7.50

> Jo!
:)
> > > +       char *uid_env = getenv(TST_TO_STR_(LTP_USR_UID));
> > > +       char *gid_env = getenv(TST_TO_STR_(LTP_USR_GID));

> > So far this format is correct.

> > But as I pointed in the last thread, here using TST_TO_STR_ might be a
> > potential
I'm sorry to overlook this.

> > issue if someday we make changes on that to become two-level macro.
> > It likely to interpreted as  getenv("65534");

> > So on the safe side, I’d still recommend writing it explicitly:

> >     char *uid_env = getenv("LTP_USR_UID");
> >     char *gid_env = getenv("LTP_USR_GID");

> +1

The reason I used the macro is that I prefer to use constants instead of a plain
text (also danger of typo). But changed to your proposal and merged whole
patchset.

Thanks all for your review.

Kind regards,
Petr

> > The rest whole patch set looks good:

> > Reviewed-by: Li Wang <liwang@redhat.com>

> For the rest also from me:

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

