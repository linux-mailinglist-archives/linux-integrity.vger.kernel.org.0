Return-Path: <linux-integrity+bounces-8113-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 91507CCBACD
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Dec 2025 12:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE2D4301EBDA
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Dec 2025 11:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A8432693A;
	Thu, 18 Dec 2025 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tDhRxNAM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SOyn5zC0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jzgUfpO7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n88zK61j"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAF9325723
	for <linux-integrity@vger.kernel.org>; Thu, 18 Dec 2025 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766058467; cv=none; b=WG9bEYUxbJC4AfPLzXpQbzQ69gHvmoUo28zejyo8X1ol/zszUTyu8vt0p+DH7yoi4lIraIW+MI7cxdGgvQoy9897oApS+bOqny8jJY5nTaVk1fGez5+mFt1Mzgg/hTPi0zpwK6pBNgrGrATdfpW1uBSyeCDyRd3XswMZk2PmJg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766058467; c=relaxed/simple;
	bh=d0xyOedFIrZxm4NSlMzxN0p9ko4/67CevG0jRIMYrMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdwPwK+kkJmozlKmnqKO7Fl1EKrG5Xy1Z9PfkcXyd13KomcEQCZBbzIVip7T+LOP53QcP358BSVuALqWr0C5g2ssMv2Z4wCiEixj8cNVmmBb0VYiDSBytkE8u8DCtQn7X8tDGWdjfRurnSxYTEa9UCS3/z92ifyEO16preluCZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tDhRxNAM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SOyn5zC0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jzgUfpO7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n88zK61j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B4F35BD9A;
	Thu, 18 Dec 2025 11:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766058464;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d0xyOedFIrZxm4NSlMzxN0p9ko4/67CevG0jRIMYrMY=;
	b=tDhRxNAMutZeRSaqtmrfIRLfKLvsXAai3lDXV2pboCNxYfJF5UNnihH5SpfeHk1TidtZ4c
	JJjct2EKf8TGG0h4/cWCK+ChXh/YkneWIqT+mAmBN7d8QHJsbZ3zi1QAYT1tmACOelX6Ed
	Q6LwQ9PgDWi+7batTY6i6aDTDX8olKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766058464;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d0xyOedFIrZxm4NSlMzxN0p9ko4/67CevG0jRIMYrMY=;
	b=SOyn5zC0UuFFKiiC6IRTtxO85VIC8nlYYHjHjr38yOFH75PL3HD+X7cNzaIi7MGTlLW5AK
	vy0KkTdleIqDbDDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766058463;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d0xyOedFIrZxm4NSlMzxN0p9ko4/67CevG0jRIMYrMY=;
	b=jzgUfpO7N+LXL3v8jNUv4Hovqogb6PNjQeCtsDvWBBajt2lbkDYuRjPOeAeSKPsgahNAa5
	fgLeDGKeD1VPHl8zcBvkDBc9JZ9066nstKl02T/t/o9aVNHE6Gat2TNg2kAndglUyWNTCX
	eXebNAh4U9c18QUgMfFXlK+E0kD6SUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766058463;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d0xyOedFIrZxm4NSlMzxN0p9ko4/67CevG0jRIMYrMY=;
	b=n88zK61jWF2tjVLUCU64eYUivR/bX8Jw1Sp1txM5DD7Kg9gXndamlMWaHvtLs0gusmm/+Y
	7cpGJdmH1PgqHpBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC8DD3EA63;
	Thu, 18 Dec 2025 11:47:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BB84MN7pQ2k8agAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 18 Dec 2025 11:47:42 +0000
Date: Thu, 18 Dec 2025 12:47:33 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: ltp@lists.linux.it, Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
	Jan Stancek <jstancek@redhat.com>, Li Wang <liwang@redhat.com>
Subject: Re: [PATCH v4 2/4] tst_test.sh: Add TST_USR_{G,U}ID variables
Message-ID: <20251218114733.GA98183@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20251209185557.20598-1-pvorel@suse.cz>
 <20251209185557.20598-3-pvorel@suse.cz>
 <aULQlhbHltLTbdG4@yuki.lan>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aULQlhbHltLTbdG4@yuki.lan>
X-Spam-Flag: NO
X-Spam-Score: -7.50
X-Spam-Level: 
X-Spamd-Result: default: False [-7.50 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]

> Hi!
> > Add TST_USR_{G,U}ID variables with the default values from tst_runas.c.

> > These can be used as a default values for tests which use tst_runas and
> > need to know UID/GID for other commands.

> > It will be used in LTP IMA tests.

...
> > +# see testcases/lib/tst_runas.c
> > +export TST_USR_UID="${LTP_USR_UID:-65534}"
> > +export TST_USR_GID="${LTP_USR_GID:-65534}"

> Do we need this? We already have the default values in the C code...

I've merged the patch without notice this, therefore just to clarify.
I hoped I was clear in the commit message, obviously not.
Yes, just for a record you find the answer in the next patch:
https://lore.kernel.org/ltp/aULUsVxLIXFM19IV@yuki.lan/

So I hope everything is OK.

Kind regards,
Petr


