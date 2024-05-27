Return-Path: <linux-integrity+bounces-2653-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7958D057F
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 17:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E231C20F9D
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 15:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A3F15FA80;
	Mon, 27 May 2024 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5Hfrrxa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39A615FA7B;
	Mon, 27 May 2024 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821524; cv=none; b=EsRYEPLsqji60xpHek3hfD35n9GkpI0BHyTJfaUGP83HM92MDtzuS7v9qa06IgFPFxHR3A/3HwX8P57xjMRYOOv/VHOcHO7HLLVDC6T03f+fSuAC9jCotivEqUHWhBnh3cvEQQerGJMGoscE3FlWwNCdDJYURjNbhrhxZPPYLA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821524; c=relaxed/simple;
	bh=ImMZfgRsZFXfWQAVmERqzBC5LKdW7ohPaMAiz36iLwI=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NPFAqVSiFw5nmXujrHz4+dTCeRNrcuKW9Dw9EeZolphwzS9BsQ5Ex6b4zgGoZDwuHmzuLGdnDH7o0xS7gKAnNUPv70GkoLxHiNlYpVjHCK9FEkIp0w8dsBBpF/SkOmEUQf51XFxtvlMEBMUPjChW2n0qkmd4noWOp/+sfb3+amo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5Hfrrxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BC9C2BBFC;
	Mon, 27 May 2024 14:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716821523;
	bh=ImMZfgRsZFXfWQAVmERqzBC5LKdW7ohPaMAiz36iLwI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Z5HfrrxaTZxA2QLjto7nWWSyecMZ5/RzCLbr9YsvoRK8FLZAGC3lqmNM2n9ywOVCr
	 T14ajjTIeilY0sNOsqNdjjq4/Md1h2xgN8PAMAjw1PgOrD5/Eb99TOoclnDAxLgLSB
	 n1T4rv4W1ogVdxaOlNu1G1EuCOoRlOdjSkkjTRswHjaHMNHEhH9L2FaLRvBhZjhy+x
	 xrxlh/Z6LQG6ev8OcUCIfVhaWmPMZ9mGLNhgk5bE5hZqzndo18KXsGJE62F49zUmoE
	 tMcqSLB+ZItIokElSemioFWsh6lJPyRTLP2OnOfB3W1xeyPf1JvgkQ/60+0HCAgb/N
	 0B0EQx9X4bTmg==
Content-Type: multipart/mixed;
 boundary=d773c951b33f28bb9ab2c8e27c9213d67f0cb55c49fd88ec81ab535ef8c4
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 27 May 2024 17:51:58 +0300
Message-Id: <D1KIFPNBNGKH.IJKFRXH8WINU@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Vitor Soares" <ivitro@gmail.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240519235122.3380-1-jarkko@kernel.org>
 <20240519235122.3380-2-jarkko@kernel.org>
 <850862655008f84ef0b6ecd99750e8dc395304d1.camel@gmail.com>
 <D1F4V8NMSUNZ.2VCTEKHZZ0LB@kernel.org>
 <17dc838120b56ce342c34611596c7b46dcd9ab5a.camel@HansenPartnership.com>
 <2dd8d49516ec9c7cb8c1182b5b8537b1e82d7067.camel@gmail.com>
 <17a5dcd7aceb356587ef7c8f45b0f6359b2d2a91.camel@HansenPartnership.com>
 <D1G8HOCIDWTC.2ERVA0CYHLY0B@kernel.org>
 <0c12c9ea10aa97e246230fc33e6b35c571102b48.camel@gmail.com>
 <D1GAZSIOZVWW.2UZBFHASIG21U@kernel.org>
 <3e4bbd0f0fe9f57fd7555a3775e8d71031c0d6c5.camel@gmail.com>
In-Reply-To: <3e4bbd0f0fe9f57fd7555a3775e8d71031c0d6c5.camel@gmail.com>

--d773c951b33f28bb9ab2c8e27c9213d67f0cb55c49fd88ec81ab535ef8c4
Content-Type: multipart/alternative;
 boundary=4bb3e9695174164a956389b9b6ac81a78e8d4f30d87d2757013463a477c8

--4bb3e9695174164a956389b9b6ac81a78e8d4f30d87d2757013463a477c8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

On Thu May 23, 2024 at 10:59 AM EEST, Vitor Soares wrote:
> On Wed, 2024-05-22 at 19:11 +0300, Jarkko Sakkinen wrote:
> > On Wed May 22, 2024 at 5:58 PM EEST, Vitor Soares wrote:
> > > I did run with ftrace, but need some more time to go through it.
> > >=20
> > > Here the step I did:
> > > kernel config:
> > > =C2=A0 CONFIG_FUNCTION_TRACER
> > > =C2=A0 CONFIG_FUNCTION_GRAPH_TRACER
> > >=20
> > > ftrace:
> > > =C2=A0 # set filters
> > > =C2=A0 echo tpm* > set_ftrace_filter
> > >=20
> > > =C2=A0 # set tracer
> > > =C2=A0 echo function_graph > current_tracer
> > >=20
> > > =C2=A0 # take the sample
> > > =C2=A0 echo 1 > tracing_on; time modprobe tpm_tis_spi; echo 0 > traci=
ng_on
> > >=20
> > > regards,
> > > Vitor Soares
> >=20
> > I'm now compiling distro kernel (OpenSUSE) for NUC7 with v6.10 contents=
.
> >=20
> > After I have that setup, I'll develop a perf test either with perf or
> > bpftrace. I'll come back with the possible CONFIG_* that should be in
> > place in your kernel. Might take up until next week as I have some
> > conference stuff to prepare but I try to have stuff ready early next
> > week.
> >=20
> > No need to rush with this as long as possible patches go to rc2 or rc3.
> > Let's do a proper analysis instead.
> >=20
> > In the meantime you could check if you get perf and/or bpftrace to=20
> > your image that use to boot up your device. Preferably both but
> > please inform about this.
> >=20
>
> I already have perf running, for the bpftrace I might not be able to help=
.

The interesting function to look at with/without hmac is probably
tpm2_get_random().

I attached a patch that removes hmac shenigans out of tpm2_get_random()
for the sake of proper comparative testing.

BR, Jarkko

--4bb3e9695174164a956389b9b6ac81a78e8d4f30d87d2757013463a477c8--

--d773c951b33f28bb9ab2c8e27c9213d67f0cb55c49fd88ec81ab535ef8c4
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-fixup.patch
Content-Type: text/x-patch; charset=utf-8; name=0001-fixup.patch

RnJvbSA5MTk1MWFkODZlZDYyNDQxNmExNWVkZjRmNjU3YWI1NTNjODRjNWQxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYXJra28gU2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPgpE
YXRlOiBNb24sIDI3IE1heSAyMDI0IDE3OjUwOjU0ICswMzAwClN1YmplY3Q6IFtQQVRDSF0gZml4
dXAKClNpZ25lZC1vZmYtYnk6IEphcmtrbyBTYWtraW5lbiA8amFya2tvQGtlcm5lbC5vcmc+Ci0t
LQogZHJpdmVycy9jaGFyL3RwbS90cG0yLWNtZC5jIHwgMTcgKystLS0tLS0tLS0tLS0tLS0KIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvY2hhci90cG0vdHBtMi1jbWQuYyBiL2RyaXZlcnMvY2hhci90cG0vdHBtMi1j
bWQuYwppbmRleCAxZTg1NjI1OTIxOWUuLmUxMDEzNzYyNzQxYSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9jaGFyL3RwbS90cG0yLWNtZC5jCisrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtMi1jbWQuYwpA
QCAtMjk0LDI4ICsyOTQsMTcgQEAgaW50IHRwbTJfZ2V0X3JhbmRvbShzdHJ1Y3QgdHBtX2NoaXAg
KmNoaXAsIHU4ICpkZXN0LCBzaXplX3QgbWF4KQogCWlmICghbnVtX2J5dGVzIHx8IG1heCA+IFRQ
TV9NQVhfUk5HX0RBVEEpCiAJCXJldHVybiAtRUlOVkFMOwogCi0JZXJyID0gdHBtMl9zdGFydF9h
dXRoX3Nlc3Npb24oY2hpcCk7Ci0JaWYgKGVycikKLQkJcmV0dXJuIGVycjsKLQogCWVyciA9IHRw
bV9idWZfaW5pdCgmYnVmLCAwLCAwKTsKLQlpZiAoZXJyKSB7Ci0JCXRwbTJfZW5kX2F1dGhfc2Vz
c2lvbihjaGlwKTsKKwlpZiAoZXJyKQogCQlyZXR1cm4gZXJyOwotCX0KIAogCWRvIHsKIAkJdHBt
X2J1Zl9yZXNldCgmYnVmLCBUUE0yX1NUX1NFU1NJT05TLCBUUE0yX0NDX0dFVF9SQU5ET00pOwot
CQl0cG1fYnVmX2FwcGVuZF9obWFjX3Nlc3Npb25fb3B0KGNoaXAsICZidWYsIFRQTTJfU0FfRU5D
UllQVAotCQkJCQkJfCBUUE0yX1NBX0NPTlRJTlVFX1NFU1NJT04sCi0JCQkJCQlOVUxMLCAwKTsK
IAkJdHBtX2J1Zl9hcHBlbmRfdTE2KCZidWYsIG51bV9ieXRlcyk7Ci0JCXRwbV9idWZfZmlsbF9o
bWFjX3Nlc3Npb24oY2hpcCwgJmJ1Zik7CiAJCWVyciA9IHRwbV90cmFuc21pdF9jbWQoY2hpcCwg
JmJ1ZiwKIAkJCQkgICAgICAgb2Zmc2V0b2Yoc3RydWN0IHRwbTJfZ2V0X3JhbmRvbV9vdXQsCiAJ
CQkJCQlidWZmZXIpLAogCQkJCSAgICAgICAiYXR0ZW1wdGluZyBnZXQgcmFuZG9tIik7Ci0JCWVy
ciA9IHRwbV9idWZfY2hlY2tfaG1hY19yZXNwb25zZShjaGlwLCAmYnVmLCBlcnIpOwogCQlpZiAo
ZXJyKSB7CiAJCQlpZiAoZXJyID4gMCkKIAkJCQllcnIgPSAtRUlPOwpAQCAtMzQ1LDEyICszMzQs
MTAgQEAgaW50IHRwbTJfZ2V0X3JhbmRvbShzdHJ1Y3QgdHBtX2NoaXAgKmNoaXAsIHU4ICpkZXN0
LCBzaXplX3QgbWF4KQogCX0gd2hpbGUgKHJldHJpZXMtLSAmJiB0b3RhbCA8IG1heCk7CiAKIAl0
cG1fYnVmX2Rlc3Ryb3koJmJ1Zik7Ci0JdHBtMl9lbmRfYXV0aF9zZXNzaW9uKGNoaXApOwotCiAJ
cmV0dXJuIHRvdGFsID8gdG90YWwgOiAtRUlPOworCiBvdXQ6CiAJdHBtX2J1Zl9kZXN0cm95KCZi
dWYpOwotCXRwbTJfZW5kX2F1dGhfc2Vzc2lvbihjaGlwKTsKIAlyZXR1cm4gZXJyOwogfQogCi0t
IAoyLjQ1LjEKCg==
--d773c951b33f28bb9ab2c8e27c9213d67f0cb55c49fd88ec81ab535ef8c4--

