Return-Path: <linux-integrity+bounces-9023-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIArM1mpvWkAAAMAu9opvQ
	(envelope-from <linux-integrity+bounces-9023-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Mar 2026 21:08:57 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5252E0BD5
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Mar 2026 21:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 785143014F5F
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Mar 2026 20:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5303CB2E1;
	Fri, 20 Mar 2026 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LodkSHxI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A300F34CFAC;
	Fri, 20 Mar 2026 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774037308; cv=none; b=Av1i+baBPjwkaa8gRdcu9CD0vacKNAocQmZSurX849c7fVpfCDk6pVQ9aijVGPTdiHRFZdSmE0xlmWbi4BjQWfWHhEe1qrmp7VM6HW+4AuiBElQbBHPITT/WbrF6Z30xWOHsXVb6EOHM1jLjWB42NtaEw54fbBOywuHt6AtCC6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774037308; c=relaxed/simple;
	bh=vx3bx2hdX+DWgaO/OJedYdtXCDdFIOissz/oOsXsnDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5Ega9n8kTkhwQkLP4iKkKyIMmRUbZZs3sf5FkKhhQuqbznjd1JdQRSgoSTSakapbS3II4Ef2OhxyyTiYIXta2lnqLNCmxV+GNCGr1VKTDenfCxTjvcokoAjin8RDpiNmvYdAfMeTzX/vF29Y+OXpibMvJ8x0YK9VWlxrpD5mFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LodkSHxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9029DC4CEF7;
	Fri, 20 Mar 2026 20:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774037308;
	bh=vx3bx2hdX+DWgaO/OJedYdtXCDdFIOissz/oOsXsnDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LodkSHxIvJNRjJ0QlVSnqUTNKoqzLyjXZ+54g67kcbIxbHi60e6zwY7sNAClqP5I8
	 Q8LvyL15y9l4BrWYAyfVyIIV5Ae2PUhuSvF8Tp2iBHEWwRvbRAAerY9UGvJQbo1jgO
	 X+e7I546E6wrP2trtDpWAItyrn1Eq+NL/30BDr8aQ86kT9t8+AjMy+h54FWzzg6mP5
	 HWiSzZ9TLocC75m0qhCvQOW++S5+Eu/6Wu4GOw2T8CvWhJotr/QVSMlhk+nwwAuixm
	 PCdCV1b6N27TqbyXHcS5Ok0Rm4d52ULLI/Z30UhtoRYyx/PEvmHYPxWduAIUaDc2GJ
	 DvhLcsnwXbPYg==
Date: Fri, 20 Mar 2026 21:06:13 +0100
From: Nicolas Schier <nsc@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/8] module: Move 'struct module_signature' to UAPI
Message-ID: <ab2otbZrni1GKn0U@derry.ads.avm.de>
References: <20260305-module-signature-uapi-v3-0-92f45ea6028c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yJawVUAGknQ6l3sb"
Content-Disposition: inline
In-Reply-To: <20260305-module-signature-uapi-v3-0-92f45ea6028c@linutronix.de>
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9023-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,infradead.org,kernel.org,suse.com,google.com,atomlin.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,iogearbox.net,linux.dev,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nsc@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,derry.ads.avm.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA5252E0BD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--yJawVUAGknQ6l3sb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2026 at 10:31:36AM +0100, Thomas Wei=DFschuh wrote:
> This structure definition is used outside the kernel proper.
> For example in kmod and the kernel build environment.
>=20
> To allow reuse, move it to a new UAPI header.
>=20
> While it is not a true UAPI, it is a common practice to have
> non-UAPI interface definitions in the kernel's UAPI headers.
>=20
> This came up as part of my CONFIG_MODULE_HASHES series [0].
> But it is useful on its own and so we get it out of the way.
>=20
> [0] https://lore.kernel.org/lkml/aZ3OfJJSJgfOb0rJ@levanger/
>=20
> Signed-off-by: Thomas Wei=DFschuh <thomas.weissschuh@linutronix.de>
> ---
> Changes in v3:
> - Also adapt the include path for the custom sign-file rule in the bpf se=
lftests.
>   (My manual run of BPF CI still fails, due to an BUG() on s390,
>   I don't see how this is due to this patch)
> - Link to v2: https://lore.kernel.org/r/20260305-module-signature-uapi-v2=
-0-dc4d81129dee@linutronix.de
>=20
> Changes in v2:
> - Drop spurious definition of MODULE_SIGNATURE_TYPE_MERKLE.
> - s/modules/module/ in two patch subjects.
> - Pick up review tags.
> - Link to v1: https://lore.kernel.org/r/20260302-module-signature-uapi-v1=
-0-207d955e0d69@linutronix.de
>=20
> ---
> Thomas Wei=DFschuh (8):
>       extract-cert: drop unused definition of PKEY_ID_PKCS7
>       module: Drop unused signature types
>       module: Give 'enum pkey_id_type' a more specific name
>       module: Give MODULE_SIG_STRING a more descriptive name
>       module: Move 'struct module_signature' to UAPI
>       tools uapi headers: add linux/module_signature.h
>       sign-file: use 'struct module_signature' from the UAPI headers
>       selftests/bpf: verify_pkcs7_sig: Use 'struct module_signature' from=
 the UAPI headers
>=20
>  arch/s390/kernel/machine_kexec_file.c              |  6 ++--
>  certs/extract-cert.c                               |  2 --
>  include/linux/module_signature.h                   | 30 +---------------
>  include/uapi/linux/module_signature.h              | 41 ++++++++++++++++=
++++++
>  kernel/module/signing.c                            |  4 +--
>  kernel/module_signature.c                          |  2 +-
>  scripts/Makefile                                   |  1 +
>  scripts/sign-file.c                                | 19 +++-------
>  security/integrity/ima/ima_modsig.c                |  6 ++--
>  tools/include/uapi/linux/module_signature.h        | 41 ++++++++++++++++=
++++++
>  tools/testing/selftests/bpf/Makefile               |  1 +
>  .../selftests/bpf/prog_tests/verify_pkcs7_sig.c    | 28 ++-------------
>  12 files changed, 101 insertions(+), 80 deletions(-)
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20260302-module-signature-uapi-61fa80b1e2bb
>=20

Thanks for these patches!

For the whole series:

Reviewed-by: Nicolas Schier <nsc@kernel.org>

--=20
Nicolas

--yJawVUAGknQ6l3sb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmm9qLUACgkQB1IKcBYm
Emm24hAAtnE71JBVW9GLy5SvZjxPMmvU7d7e2U0M4eVgP9+ddzbw7tF/ZjE42raS
w1jpL29qt7ESYnCXSkuH7/ABfeH0ALjPsm0Wsz9wl3l9dqqPAnYcRNxc2VzH6BNA
rrVYspjDhrArD6fzZHXi9t7gaN2md/qr8GQVl2tzYXq+ORadVve64niJ5HXVEGtk
igmI03sH5OaQXvg78v/Ui51AdL+8HbHNZUxG3G5n1VN8Qag0/aH6hfcwlSmayNvn
W0iAghaJHI4qfPufwYl+FPCKVGE10+rIKQx4AUQcm0fysHAn+4LSOnFqI2mCwL6y
oqbZdOAOdCh6YezgtK/WdwVdrZNVYNuukHmm1FPuGXIU/bIA1me5oC1NmEsWtqQB
QgI3yvKBO7UrtNYmElLOMDt2FnlSB6l5XX7FqWBHGlfhHymzo8vVNkWuRw6/z63P
ezdeAR0qwkxesxRSgwJdcICz2r7G2MAmWBJgSBRzdTIyGF3GHwb8uOQLNEXag6Dm
9SjsnyS5mkq4CWHKanGqUrfUFvw04DPM5o/7D6l5Uj41kJ0scVixHT36NtJkg4hG
k2rFFfEp/qmTcb3V8fVVBzHFKuasNWAzkHLRviOxugoFXjC7ctxU7+YcmAB3yez1
ZRZTrXsVpAtC1xI+L4J/vIFW4jZlXgte8nOZK3/TWAlAYMGp7pk=
=Qr2Y
-----END PGP SIGNATURE-----

--yJawVUAGknQ6l3sb--

