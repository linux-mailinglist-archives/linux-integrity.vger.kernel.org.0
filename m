Return-Path: <linux-integrity+bounces-8090-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56734CC862F
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Dec 2025 16:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FBCC300FFB7
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Dec 2025 15:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DE928695;
	Wed, 17 Dec 2025 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pnwhDDqt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="exd3w8pd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p2ZhrvLM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kkJm++Jc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2E51C84BB
	for <linux-integrity@vger.kernel.org>; Wed, 17 Dec 2025 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984332; cv=none; b=tbmUP40tuVKE3F8vbD6cZUl12cVEqZ1WDuDC42sX+WlCeMTStgQfFAs9VkNTZBIrevezN5kPdN+2waDzeu3zPcJTp+NwnMq/805gVMmwgukgOJVOb5iIeXo+n8XYPiBjb7lOiH4Epp5B3A4px2DpLi0IhTqsHX3K8wzCkaTQHek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984332; c=relaxed/simple;
	bh=Tk+8+xwVzj792TZn97DKMkpQsZz/U6cp6brfVrGUkp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAZvvxJMRmw3DxuK4h+WfoVnGM1NI6vA/WK1xw9IJZbG9V1Q8JwQNvGf1TwM6HAw/Wo73U6LYckUyyKBtDE/Zi9Z9GKc+cCg2Eg4YxnqtY4VaDNvHgjrTvZGzNoXv1gogvPm106qum6sRqTkY72ZcLMTud/OTcesZ1Xg0kthlsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pnwhDDqt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=exd3w8pd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p2ZhrvLM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kkJm++Jc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3FC6033686;
	Wed, 17 Dec 2025 15:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765984328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YncB7umH4aaG+XTQEorT0kMDfmen0vuVl1nXsAZRMQ0=;
	b=pnwhDDqtrHV+Yc2nd2Dk2XPKiz2slneMO+aR5o4qR3vE7lfNRAvil2ngRYRUKffRBVeTvS
	HeM5NyBVPS665XkEo/EURo6CmEnMdz+Jj3fFk4p6PuccTIamQbn39UZMTMvyF1DYH2upzE
	qcl7YLB6g0Vev2PjUmkt6tpGdZNxQWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765984328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YncB7umH4aaG+XTQEorT0kMDfmen0vuVl1nXsAZRMQ0=;
	b=exd3w8pdqR/H4QTKD1/lBRdZPm3VBx+7YLrxd4562+cILIN2puGpi/53qcuUpauVPNeb3M
	XLx/aV8+9A0yRbDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765984327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YncB7umH4aaG+XTQEorT0kMDfmen0vuVl1nXsAZRMQ0=;
	b=p2ZhrvLM7J94RqCQkxSgAbuSbrAmI02e7Wjoogpce4L4h6/GFxH/LOMxj1JpHHrBeIB+kh
	1oUMb5L7SyKpdumZjiG2D43wA2qjaaPlxEISaJer7A7NSpKQM1YTQUZ0rbgdEwR0Yrku4w
	7eRpi3NMS2GQFn8s/sMSHolhX54u/64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765984327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YncB7umH4aaG+XTQEorT0kMDfmen0vuVl1nXsAZRMQ0=;
	b=kkJm++JcZd/gK9qfrjuN0JrzI7PJCv/Lz6f0wsYb4P1GSTJ5fAjtxkaXXVz1l/qiRtbV/v
	mf6fXMBRrEnjlqBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24F2D3EA63;
	Wed, 17 Dec 2025 15:12:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SjvjA0fIQmmNNAAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Wed, 17 Dec 2025 15:12:07 +0000
Date: Wed, 17 Dec 2025 16:13:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Cc: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
	Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org, Jan Stancek <jstancek@redhat.com>
Subject: Re: [PATCH v4 1/4] shell: Add tst_runas.c helper
Message-ID: <aULIhXrMA4dgTwGg@yuki.lan>
References: <20251209185557.20598-1-pvorel@suse.cz>
 <20251209185557.20598-2-pvorel@suse.cz>
 <CAEemH2ej8-e_S4LgcKKkt08dUhyF0TreWp-QvXzQ1QGQYbywJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEemH2ej8-e_S4LgcKKkt08dUhyF0TreWp-QvXzQ1QGQYbywJg@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,yuki.lan:mid,suse.cz:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

Jo!
> > +       char *uid_env = getenv(TST_TO_STR_(LTP_USR_UID));
> > +       char *gid_env = getenv(TST_TO_STR_(LTP_USR_GID));
> >
> 
> 
> So far this format is correct.
> 
> But as I pointed in the last thread, here using TST_TO_STR_ might be a
> potential
> issue if someday we make changes on that to become two-level macro.
> It likely to interpreted as  getenv("65534");
> 
> So on the safe side, I’d still recommend writing it explicitly:
> 
>     char *uid_env = getenv("LTP_USR_UID");
>     char *gid_env = getenv("LTP_USR_GID");

+1

> The rest whole patch set looks good:
> 
> Reviewed-by: Li Wang <liwang@redhat.com>

For the rest also from me:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

