Return-Path: <linux-integrity+bounces-8927-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKpFHulxqWnH7AAAu9opvQ
	(envelope-from <linux-integrity+bounces-8927-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 05 Mar 2026 13:07:05 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3611F21146D
	for <lists+linux-integrity@lfdr.de>; Thu, 05 Mar 2026 13:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84162311455B
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Mar 2026 11:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C9739B94B;
	Thu,  5 Mar 2026 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="epOXvEYF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gAG/KorA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176AA39B4A0;
	Thu,  5 Mar 2026 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772711886; cv=none; b=ma3sAEYicrFbZiX31Ar+n+ez+mG0vCl8YveTgDvB+oj4q2QFQuOQUd6tYpyrGR4+utz4h+tZmOk1hKrhuwTHt4/FnyJ3E0X81FXIkwxbNoNMup09A9LscGuaDH4c0U3fJFeoqDfKez6h1Y3so68xDttrqgaV3HtisH04cKPTioY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772711886; c=relaxed/simple;
	bh=lQpkY97FXYvFu6KVd6eFf478rwrT+i37jF5ukDU+Zvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcwXC6WYCL6xvQOKzsIwhIlgUcUS/gjxLM1KVKYtb7Pt5zOZwR/1Eo6xT+Ky/XSSjQl30GjQYBh/GsP//NiAyS2TwR7daqq39sdFbhv22OrX4LwGZht8+jrllRhyifCGxO/9mIvb8hEG+m8MS7gBEaJ3opUPVpusd3G+BASq+d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=epOXvEYF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gAG/KorA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 5 Mar 2026 12:58:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772711883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d6syHwbcJv580VHeSUIYU4rxBbORQCA2dTBGXm60dYs=;
	b=epOXvEYFDZhBpuqU3nSXjaw33fj6DwE0AcxGM6YW2unWe/NdpRJEwx6m+5b2dHiuwtwf7f
	3dT9xM7J6+iEu2bp5huCHR3mShENmLqKomFH8CJVshoOlIboV4LLETWx1jHPRtrRDE5ZyO
	/l2o3FOmZsp5uozB47hHIv1WkgG8AFzBvpr8wJ8qVNLqjHJ1jcNw0lrkSDYGW4X2KtY6bl
	6vNEvDKQnD9fZ8Q/AE49+wZ19RAprTKqmOdlIdxf2r+cQGzLizzeEIu4/l4TxazJ7fEdbg
	8F9TlnST21pp6yGAuDGTdFtVs2NAY6JTj3asEUIeAPB7+OrlQmkapLEy6bEmDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772711883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d6syHwbcJv580VHeSUIYU4rxBbORQCA2dTBGXm60dYs=;
	b=gAG/KorAF45MwMXm9i7AOXil7yWMDgfAX/62f8kwV+bkUVotUFSvmqlADQBFJuI5jFE9Ct
	g6CTZdn7vZsnSMDA==
From: =?utf-8?B?PT91dGYtOD9xP1Rob21hc19XZWk9QzM9OUZzY2h1aD89?= <thomas.weissschuh@linutronix.de>
To: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/8] module: Give 'enum pkey_id_type' a more specific
 name
Message-ID: <20260305125639-96c4c8e6-b758-4bd6-aa11-db76f6f8c3c3@linutronix.de>
References: <20260305-module-signature-uapi-v3-3-92f45ea6028c@linutronix.de>
 <20260305-module-signature-uapi-v3-0-92f45ea6028c@linutronix.de>
 <287135.1772707967@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <287135.1772707967@warthog.procyon.org.uk>
X-Rspamd-Queue-Id: 3611F21146D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	FROM_EXCESS_BASE64(1.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	TAGGED_FROM(0.00)[bounces-8927-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,suse.com,google.com,atomlin.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,iogearbox.net,linux.dev,fomichev.me,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 10:52:47AM +0000, David Howells wrote:
> 
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de> wrote:
> 
> > -enum pkey_id_type {
> > -	PKEY_ID_PKCS7 = 2,	/* Signature in PKCS#7 message */
> > +enum module_signature_type {
> > +	MODULE_SIGNATURE_TYPE_PKCS7 = 2,	/* Signature in PKCS#7 message */
> >  };
> 
> It might be best to just kill the enum and replace it with a single #define.

I am about to introduce another value in [0].
But personally I don't really care one way or another.

[0] https://lore.kernel.org/lkml/20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net/

