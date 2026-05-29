Return-Path: <linux-integrity+bounces-9694-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKmXOyafGWq7xwgAu9opvQ
	(envelope-from <linux-integrity+bounces-9694-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 29 May 2026 16:13:59 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 952FF603585
	for <lists+linux-integrity@lfdr.de>; Fri, 29 May 2026 16:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 209C93038526
	for <lists+linux-integrity@lfdr.de>; Fri, 29 May 2026 14:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42093E2AD6;
	Fri, 29 May 2026 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Ffu1Tcoi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6E83403FD;
	Fri, 29 May 2026 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780063737; cv=none; b=ZRBVApCdVZNdgg3C7N05iUjTDCTGrWHyHgb8iGwcaPHaq1RG24TON8bFUCy879si2TNtlZmIFg8P1rmLHO6cXZImB3q8+ciZG1u9AagowvC+cPY1KghgXOOLkV7Q+h1Bj5RoOi8YLANV7nUU0n+3v7IqrdWV7B64aPOsFZGI/mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780063737; c=relaxed/simple;
	bh=Bmm7xx0AU1UJVdCUceNEBHC2cQOLU9KmXpJK3I0DQzU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N3UoUWlGpk6eN4gxtbcWKPHil92Zt08MeZCR+MX+HQZKrGlGywwe+MhQWvBnHK/qnbAkSnNFRoBBwGXNfxuNYUIERsnLVT8pZLgYjejYvShW95Xe9dgQykIJdtO8lPambOnJnnYOULyLbUJK6NAWhK2Z2X0rPbWRC49k9fmNKX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Ffu1Tcoi; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1780063733;
	bh=Bmm7xx0AU1UJVdCUceNEBHC2cQOLU9KmXpJK3I0DQzU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Ffu1TcoiiHvUQIS/XhIaiVlQN0ts6wlg6x4vmT/+aqJpN3TZwRnTqlqTIN6oe0J/Y
	 Loraq1S09iiPreTV54Qq30lto6NJNek0TspAL4+yDR+zWP3egmbOkBoLcdyUETSq1k
	 z2Ikep27s0flQMetpJgJkUMNLznRFZzIv4w6GB6g=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:d341::8c71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 5A3611C01C5;
	Fri, 29 May 2026 10:08:53 -0400 (EDT)
Message-ID: <27db53d88a44e057c2f0ed5a637f65e4e18c8c3d.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm-buf: memory-safe allocations
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Jarkko Sakkinen
 <jarkko.sakkinen@opinsys.com>, Arun Menon <armenon@redhat.com>, "Daniel P.
 Smith" <dpsmith@apertussolutions.com>, Alec Brown
 <alec.r.brown@oracle.com>, Ross Philipson <ross.philipson@gmail.com>,
 Stefan Berger <stefanb@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>, David
 Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-security-module@vger.kernel.org
Date: Fri, 29 May 2026 10:08:52 -0400
In-Reply-To: <ahVRefyT4BTKOu0m@kernel.org>
References: <20260522013555.1063716-1-jarkko@kernel.org>
	 <33b4a34ceea0934e238c08e0256b975511ef99c8.camel@HansenPartnership.com>
	 <ahVRefyT4BTKOu0m@kernel.org>
Autocrypt: addr=James.Bottomley@HansenPartnership.com;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hansenpartnership.com,quarantine];
	R_DKIM_ALLOW(-0.20)[hansenpartnership.com:s=20151216];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9694-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,opinsys.com,redhat.com,apertussolutions.com,oracle.com,gmail.com,linux.ibm.com,gmx.de,ziepe.ca,paul-moore.com,namei.org,hallyn.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[James.Bottomley@HansenPartnership.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[hansenpartnership.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[HansenPartnership.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ozlabs.org:url,hansenpartnership.com:dkim]
X-Rspamd-Queue-Id: 952FF603585
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-05-26 at 10:53 +0300, Jarkko Sakkinen wrote:
> On Mon, May 25, 2026 at 01:50:51PM -0400, James Bottomley wrote:
> > On Fri, 2026-05-22 at 04:35 +0300, Jarkko Sakkinen wrote:
> > > Decouple kzalloc from buffer creation, so that a managed
> > > allocation
> > > can be
> > > used:
> > >=20
> > > 	struct tpm_buf *buf __free(kfree) buf =3D
> > > kzalloc(TPM_BUFSIZE,
> > > 						GFP_KERNEL);
> > > 	if (!buf)
> > > 		return -ENOMEM;
> > >=20
> > > 	tpm_buf_init(buf, TPM_BUFSIZE);
> > >=20
> > > Alternatively, stack allocations are also possible:
> > >=20
> > > 	u8 buf_data[512];
> > > 	struct tpm_buf *buf =3D (struct tpm_buf *)buf_data;
> > > 	tpm_buf_init(buf, sizeof(buf_data));
> >=20
> > This isn't really a good idea from a security point of view.
> > =C2=A0Remember the buffer has to be big enough for both the sent and th=
e
> > received data.=C2=A0 Today we simply set TPM_BUFSIZE to the maximum
> > amount a TPM requires and all the send and receives just work.=C2=A0 If
> > we let callers set this size, we're asking for them to get it wrong
> > (or at least forget about the receive part) and for us to get a DMA
> > overrun from the TPM ... which might be potentially exploitable
> > depending on how it occurs (think of an unseal of user chosen data
> > overrunning).
>=20
> It's one patch so you're free to remark the call sites where this
> happens. This is not a majorn concern at all.

Nearly twenty years ago, when the kernel was a lot smaller, a then
kernel luminary called Rusty Russell realized we needed to pay much
more attention to how we design APIs inside the kernel if we wanted it
to grow successfully.  He published his initial thoughts and gave talks
at both the kernel summit and OLS on it:

https://ozlabs.org/~rusty/index.cgi/tech/2008-03-18.html

The key point that's always stuck with me is "hard to misuse beats easy
to use". Later he came up with a rating scale (now known as the Rusty
API classification):

https://ozlabs.org/~rusty/index.cgi/tech/2008-03-30.html

and for chuckles and grins on April fools day he came up with a
negative rating ridiculing some of our dafter API choices:

https://ozlabs.org/~rusty/index.cgi/tech/2008-04-01.html

The point for this patch set is that the sizing of the original tpm_buf
interface scores 10/10 on the Rusty scale (it's impossible to get
wrong).  Simply threading size through the whole API, as this patch
does, may look like the right answer, but it causes a massive reduction
in API score.  In fact, since the buffer has to be sized not only
according to what goes in, but also what gets returned and this is
nowhere mentioned in the new documentation it scores -3 (read the
documentation and you can still get it wrong).  Now by mentioning the
sizing problems in the doc, you can probably get it up to +3 (read the
documentation and you'll get it right) but my question was not if you
got it wrong somewhere in the patch but whether we couldn't do a whole
lot better in terms of API score by designing a better API.

A key point about the 185 version of the TPM spec is that it's really
only a few commands that need larger buffers (the Post Quantum ML-KEM
keys) which doesn't apply to most of the in-kernel TPM callsites.=20
Since tpm_buf_init takes the ordinal, we can actually tell at runtime
(or compile time if the ordinal is a constant) if the command would
need a larger buffer.  We can also tell from the TPM properties whether
the TPM itself can take a larger buffer, so for every current TPM we
could retain the original score 10/10 API and warn at runtime if there
might be a problem.  Then the larger keys seem to fit into 8k, so we
could still retain most of the original API properties of being
difficult to misuse simply by having an 8k size flag (which we could
ignore if the TPM doesn't support it) and warn at runtime if
tpm_buf_init sends an ordinal which might need a larger buffer.  At
worst we should be able to get to an API which scores 5/10 (do it right
or it will break at runtime).

Regards,

James


