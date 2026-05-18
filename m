Return-Path: <linux-integrity+bounces-9599-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICOYFeqKC2p1IwUAu9opvQ
	(envelope-from <linux-integrity+bounces-9599-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 23:55:54 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F29E2574246
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 23:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69180301911A
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 21:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6F5398915;
	Mon, 18 May 2026 21:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IvoDbo4V"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F6C39150E
	for <linux-integrity@vger.kernel.org>; Mon, 18 May 2026 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141352; cv=none; b=eAUm7NNLhKO0NKL+9AyfbwCdUsogPF3ZI19rAGYf88azFMSHF8eYeNjtZRWKWip5UIEE4rMTF2tFvUGj0kXfvSjU7BjFzOhpwDpXhZOH1NDbETAN4NRMRMGttK44kzRVrfArfcieGlMQ4tE1HoYPbDGcUpurc75/B99Y6V69kso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141352; c=relaxed/simple;
	bh=WhaVFwVRm1Wf4thmzuA0e0qjOQLT9x+04R1dduxYWzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPIUVyhvg4b/nFmMwm+ybax3d0ciGsRDD94O9xYhnTsm6ihuj4dYg4Q3Nsf8inAHPWoGhiPEikNpGKshpRs9x2v/SbqHMuhjkjRQfxxO53XFXkMJbN04OULEUuIJ2n3s+xTfvTeD7JospRXrnwoMU8L9jPSCxO40UEDlNyZCWfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IvoDbo4V; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so955ad.0
        for <linux-integrity@vger.kernel.org>; Mon, 18 May 2026 14:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779141350; x=1779746150; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eATlafWR2CpUln9HSfV3CyzBd2Vyaqeh6UVZyYqlodE=;
        b=IvoDbo4V1nj4Q9OWvBMcUPpA6eDFfBAFbu4ry1ujeKWH4fYBAFNjP7BApepEoXKgFW
         echIH2GbEhb+kGhHlHfftLXlBnHDih1oHm9UtaSSK5CAFRUvXh1PCqOj+XI9wKqJnmv9
         BdHZsxEJDc6k4l629t6bytiQfWInZt6CAKX455PJMRgqGvsL+3fHb7ubaoj1OjP5TMpJ
         apWTAqJbeutKX9DtvRx+hRvKlId5JUFry4JYzoUpiHudyEvfAoPlfnA1GOb/KpKOehgq
         VY2sjO/zadidGT8zNRrbzepfosggp1gNZrno+6RpVU2wOW8V9Y0N7qAHPHbOdQPTZ4W2
         afYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779141350; x=1779746150;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eATlafWR2CpUln9HSfV3CyzBd2Vyaqeh6UVZyYqlodE=;
        b=op7LKDRpXEMxTHff548OXIx2lLYCFx5rzXyC2zGobHyGU3GP6zWdWUhyQtPmgtNqp2
         ngZUpqJuuk+M9+1YulzxtC13Isj12ykPUjjEPKLtxKJMF5wobJwKHXnmBOfThi5OSja/
         BlJTvsJnpa0SB68ojnuGGw1GfH9VIzJVocYy7k9W2ucnCiOlmR5+pjYgXUkwjGqyJuFS
         6oSI9ILaw+EAbDXKm9NWOI6bcXhywEt0onIQkn+8QZTLZRsLHItXIAasyByRB2kGn8EU
         hpsdMArCclh0UlvGDDckbhIgOdoqGxjsTfRg+o7Co/RrBINzOMDYx1CRRtPseN/lxv5Q
         0ajg==
X-Forwarded-Encrypted: i=1; AFNElJ+As07SBbsrVKxG9gKzbSgv+tqB+gRREnmYYyGmcwgDxKA/GdVDYv0CzRmohB8DKmSaTLpK2hV0bJBPEO/zk7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJD9au0nyXkyzkSGMJOJYGChP4gtkEgZ4etqFykjbJj22NOZn1
	d1Azy/xmfBdJXHxOVK5V5FLwoBSgk4Go3GaOGpvklKkqbq1FgJibLOjArNoeXPz3kw==
X-Gm-Gg: Acq92OEMRvnUFwafHY0af8QWj6E/NDeyG0kXmErQ9naHbdZI3FmHmLgpNsTBCxtrr0N
	zFU4k1U3Er6mOdRL/5KwEI8TcCog6njkK1O3CNB+pMGLsjYGms1gVeuKsxHbFJt5L614f9Zf+jD
	UvtsXddok4xzJZ1Ds+Wb6DVK7R4ssSLmMtJaBr9ZjCJOPbtRM2/ZBRSqHioEFNnFIy+cvqJenuD
	36FDT/LwAqV9aXK6KMX6gXZYe3UItJcXj1adfGPoSqU/ptkNUAEagfeQQ0PAxHlXTy3xP3ySnel
	n/6Bh4RjBF7GMBQZC1iYHf2vH/L47EgxBUc1TThUD8TVhWsykskWUOeKv9iBlzedyjI0TiQjTUt
	lHjNkXSbVy3/pFaHcXKy4DekRRLfYqTcwuPBk6ARfiusIbzLLxNNZnCQU6FmLBFg1IWl51KB71D
	H1zqckhpxSXxSGdP1wnmolYOGnnXZnCNMAYwbOHT/ICD7qTbXVgzL2WYUta1XdaXAo7o6LsOWDI
	jlg/qLM+9WAUgU0
X-Received: by 2002:a17:902:d512:b0:2bc:dc0b:ab29 with SMTP id d9443c01a7336-2bdb0109472mr3880435ad.0.1779141349445;
        Mon, 18 May 2026 14:55:49 -0700 (PDT)
Received: from google.com (171.46.125.34.bc.googleusercontent.com. [34.125.46.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe498asm164380125ad.39.2026.05.18.14.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 14:55:48 -0700 (PDT)
Date: Mon, 18 May 2026 21:55:43 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
	Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>,
	Arnout Engelen <arnout@bzzt.net>,
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	=?iso-8859-1?Q?C=E2ju?= Mihai-Drosi <mcaju95@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
	debian-kernel@lists.debian.org
Subject: Re: [PATCH v5 00/14] module: Introduce hash-based integrity checking
Message-ID: <20260518215543.GA1878854@google.com>
References: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,arndb.de,suse.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,huawei.com,oracle.com,linux.dev,atomlin.com,oss.cyber.gouv.fr,vger.kernel.org,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,linutronix.de,lists.ozlabs.org,lists.debian.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9599-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samitolvanen@google.com,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: F29E2574246
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Thomas,

On Tue, May 05, 2026 at 11:05:04AM +0200, Thomas Weißschuh wrote:
> The current signature-based module integrity checking has some drawbacks
> in combination with reproducible builds. Either the module signing key
> is generated at build time, which makes the build unreproducible, or a
> static signing key is used, which precludes rebuilds by third parties
> and makes the whole build and packaging process much more complicated.
> 
> The goal is to reach bit-for-bit reproducibility. Excluding certain
> parts of the build output from the reproducibility analysis would be
> error-prone and force each downstream consumer to introduce new tooling.
> 
> Introduce a new mechanism to ensure only well-known modules are loaded
> by embedding a merkle tree root of all modules built as part of the full
> kernel build into vmlinux.

I noticed Sashiko had a few concerns about the build changes. Would you
mind taking a look to see if they're valid?

https://sashiko.dev/#/patchset/20260505-module-hashes-v5-0-e174a5a49fce%40weissschuh.net

Sami

