Return-Path: <linux-integrity+bounces-1784-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A23F87ED8E
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Mar 2024 17:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638641C20E0D
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Mar 2024 16:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B02E1367;
	Mon, 18 Mar 2024 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wHq7+6SB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0qm8eCF2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b5EJUccc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QcnXMiib"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBE425745
	for <linux-integrity@vger.kernel.org>; Mon, 18 Mar 2024 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779479; cv=none; b=Jb/y7OHwC5D8yeAPRPLdZC3949Euu9kZVI63XCnWY/tIRnT739ciNtFpjWPqJmKOjxFb/h9ByxBt8RhNywMy8uIPMlwOPENGqW20M2q5iBbEP98j7oq8ciGteZZQHr7NMQZhsvH8L5Og4QGrp7fkniRwhXS7BM6/nAqVxfH8sfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779479; c=relaxed/simple;
	bh=Nx1MhbuEWL8jxcw26kfqWOXc3BtACXtKLdV3Hvi1eS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXaiHBxOhnGG9+zgTJj1ThzWVe2ec4BENszlb4gqYZXpthmy2mZRvYKTb4WbgWPoh6/Spw6bjCPo6E1vNZyglDMyKOVq1U8YWRwz86EmhT6n0x+lsGLT6sWA7OS4CKPrjWVjYgtAAyJiRl+GHPSLwFaDtUZDcYM3LDwLzunWrUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wHq7+6SB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0qm8eCF2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b5EJUccc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QcnXMiib; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9D6CA5C758;
	Mon, 18 Mar 2024 16:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710779475;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DV5RAmOcj8nTPDoxZH1JmLO6cNX+y1h3mHbu1wUQ2jY=;
	b=wHq7+6SBlcnYQlMXOXv4ZSZ10xarhOA14E0OGT5gO24zO9ApxZV84VIRcCoblljQCskkHz
	dbBqPvAg5n+P9SIqNnhvmJyNZBOYiBJuaoBligx/W34B2VuhO0atps9fTwJQsYMveivIBR
	j3g8EMTTGqOQbCaJisQAcHvQrCjrkkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710779475;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DV5RAmOcj8nTPDoxZH1JmLO6cNX+y1h3mHbu1wUQ2jY=;
	b=0qm8eCF2R2GTiyX4a31jTcBJCgfoBT0EiyuvUJkKkyIpL1Ve/kE/Ld8E/OgNkVtTdntqBo
	c/h7Iijtnd6vjaDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710779474;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DV5RAmOcj8nTPDoxZH1JmLO6cNX+y1h3mHbu1wUQ2jY=;
	b=b5EJUccci4iYGqgUDNMmd91B+ILVAmppHEj9utS+CY52gmWnO9kVp+K4iKk/SeA0E86hdG
	JQmdfwl3H0OftXqlf5dXffCbaLMTMZkOfXggEYZJ/54l1LemZuoIiYoONMR0XRr6hMK95g
	Z9/W5F4PZD7z7wUNIlYADwGv2M8+ie4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710779474;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DV5RAmOcj8nTPDoxZH1JmLO6cNX+y1h3mHbu1wUQ2jY=;
	b=QcnXMiiburpTct8eT7N8i4hLxOjSWYoVgKsUopru/x8E+PiGKAm448dymhgB1UVo0feWsB
	vamxphlfLu70W3AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30976136A5;
	Mon, 18 Mar 2024 16:31:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x+0GC1Js+GU4ZwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 18 Mar 2024 16:31:14 +0000
Date: Mon, 18 Mar 2024 17:31:12 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	linux-integrity@vger.kernel.org,
	Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Vitaly Chikunov <vt@altlinux.org>,
	Ken Goldman <kgold@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Bruno Meneguele <bmeneg@redhat.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	George Wilson <gcwilson@linux.ibm.com>,
	Tergel Myanganbayar <tergelmyanganbayar2024@u.northwestern.edu>,
	=?iso-8859-2?Q?Andr=E9?= Draszik <git@andred.net>,
	Frank Sorenson <sorenson@redhat.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [ima-evm-utils: PATCH v2 1/1] Change license to
 LGPL-2.0-or-later and GPL-2.0-or-later
Message-ID: <20240318163112.GA408613@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <103252ffff09c607e83c887cab2e0af5404d62ff.1710774200.git.dmitry.kasatkin@gmail.com>
 <20240318162523.GA1185@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240318162523.GA1185@sol.localdomain>
X-Spam-Score: 0.08
X-Spamd-Result: default: False [0.08 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.92)[86.23%];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLw8ptx9ferrt7kobz7hd5cuwh)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[17];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[northwestern.edu:email,hansenpartnership.com:email,suse.cz:email,altlinux.org:email,huawei.com:email,andred.net:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,huawei.com,linux.ibm.com,altlinux.org,hansenpartnership.com,redhat.com,u.northwestern.edu,andred.net];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

> On Mon, Mar 18, 2024 at 05:07:24PM +0200, Dmitry Kasatkin wrote:
> > Currently libimaevm provided by this project is used by the tool evmctl,
> > which is also provided by this project.

> > An issue was reported about using libimaevm with other software. Its
> > GPL2-only license makes it incompatible to use with other licenses, in
> > particular GPL3-only.

> > To address this issue, change the project license to GPL-2.0-or-later
> > and libimaevm to LGPL 2.0 or later.

> > This patch includes all acks received so far.

> > Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> > Acked-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
> > Acked-by: Petr Vorel <pvorel@suse.cz>
> > Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> > Acked-by: Stefan Berger <stefanb@linux.ibm.com>
> > Acked-by: Vitaly Chikunov <vt@altlinux.org>
> > Acked-by: Ken Goldman <kgold@linux.ibm.com>
> > Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Acked-by: Bruno Meneguele <bmeneg@redhat.com>
> > Acked-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Acked-by: George Wilson <gcwilson@linux.ibm.com>
> > Acked-by: Tergel Myanganbayar <tergelmyanganbayar2024@u.northwestern.edu>
> > Acked-by: André Draszik <git@andred.net>
> > Acked-by: Frank Sorenson <sorenson@redhat.com>
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Acked-by: Vivek Goyal <vgoyal@redhat.com>

> Acked-by: Eric Biggers <ebiggers@google.com>

> I misread this and thought you were just trying to change the license of the
> library, in which case you wouldn't need my ack.  It's worth emphasizing in the
> subject line and first paragraph that you're trying to change the whole
> project's license.

+1

Kind regards,
Petr

> - Eric

