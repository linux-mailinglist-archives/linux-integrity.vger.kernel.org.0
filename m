Return-Path: <linux-integrity+bounces-6895-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272D9B32CD2
	for <lists+linux-integrity@lfdr.de>; Sun, 24 Aug 2025 03:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C631220000F
	for <lists+linux-integrity@lfdr.de>; Sun, 24 Aug 2025 01:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753BC14A0BC;
	Sun, 24 Aug 2025 01:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Zvz/QxBO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902B827472;
	Sun, 24 Aug 2025 01:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755997987; cv=pass; b=dVbDASRUkEWU6uidIzxVJfTeXZtlMJgWUqpBuvv7wOGTpDeg7kEhG+mNF3U3ZlhTwjScPhhQDi7lbu+4roLPsEvbDmS4Wxno3LDtldYg3h+QcekIree8N2XNCVFM7e4WEIjaCMejwYCQesWARuAGZ56UzDZI3oKCIvjmlHdSrXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755997987; c=relaxed/simple;
	bh=XSfOXoGV36jaig1sxaVyAc8naFDar9puPuNaTXzXejY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OaHvsLZyUhEr9Zrg+ufUZ/oMmkv1MOjCSJM2htx+j1YWHgT9zDRVzwM65V0NdDwbzvS9hDrkyBuoiKbOxMPFUmT/zc0t2isCQ8GRlc7q+1AFVpo6pefFFo/rIexgfBVgeEwA07SysCvUaxq0ttQtfL0h3eofDh7O2tTszu1T92g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Zvz/QxBO; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755997981; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Eo75Wq+vHC1m1OMSZ4abhVYC0tXNS6yK+FOMGQzcuphW3Au6gpx93uPDSvSU56legI/2ra+arZENX4TrtuPVMVeoD4GmVOS0V6iDm+YCtQUOVbpn/UHbYsfvXpKIs0N7iwumWPEEh7tkTvDNXnqrdkzw4UadsyoBhi1iuNRJ0lE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755997981; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8urtE5G9VerAIvZ1zVkeFBLmQAOAHA21DdXhCeHqFMo=; 
	b=aaUC86I2llb8BPxdmdcr596nRiyVuQ4AWgjTDI9fXfnlMTlKFW7RKNl24Onbn8NkssMr/hDhUMQHwqLH/Xjq1slTQrTwTBYf5RPrgLdCTHRyYsrRhf9+GuFOjxOKYhf9AZlaOQ9TkyF+ZEM43Slo91Pba12NK3EV0qud5bt/XFg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755997981;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=8urtE5G9VerAIvZ1zVkeFBLmQAOAHA21DdXhCeHqFMo=;
	b=Zvz/QxBOR07OF1QCJ3IViM/xyrakbE10NtUv9yEyO/3z7TrSxC0JsrN4pzrtr15U
	kx36VwlWZC2n0TkMR4LH7KYHGlNGINRj8od2ZoaVeWAq/7jUaCrbnU3chet02mOD1LM
	YkJBlHUjYzIr88ktfZ3/eB5P/PdPE59upK0N1Fcw=
Received: by mx.zohomail.com with SMTPS id 1755997978522933.5616722441524;
	Sat, 23 Aug 2025 18:12:58 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: Using Rust on non-Rust side of kernel
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <aKpKxaJyZsSMfy_o@kernel.org>
Date: Sat, 23 Aug 2025 22:12:44 -0300
Cc: rust-for-linux@vger.kernel.org,
 linux-integrity@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1DF705A6-9743-4BAF-9904-63E9F5B72831@collabora.com>
References: <aKmyg0auI8jHuAmZ@kernel.org>
 <BE42A51A-60C4-4E79-8459-CADEAB8DC3BA@collabora.com>
 <aKpJbIEZss_l-8wb@kernel.org> <aKpKxaJyZsSMfy_o@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Jarkko,

> On 23 Aug 2025, at 20:12, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Sun, Aug 24, 2025 at 02:06:24AM +0300, Jarkko Sakkinen wrote:
>> Hi,
>>=20
>> Would it be possible to response in plain text?
>=20
> Is highlighted at lore [1]:
>=20
> "[not found]   <BE42A51A-60C4-4E79-8459-CADEAB8DC3BA@collabora.com>"
>=20
> Also it is quite cluttered to read your response in mutt, as you can
> probably see from my earlier response :-)
>=20
> Not disregarding the response but it is right now quite convoluted.
>=20
> See [2] for more information.
>=20
> [1] =
https://lore.kernel.org/rust-for-linux/aKpJbIEZss_l-8wb@kernel.org/T/#t
> [2] https://www.kernel.org/doc/html/latest/process/email-clients.html
>=20
> BR, Jarkko

Sorry. Yeah I am aware of plain-text, but I was on the go and turns out =
that my
phone is not properly configured. Let me copy-and-paste this here so we =
have
the full context and also so that it shows up in lore.

I didn't have the time to read your response by the way, but I will get =
back to
you in the next couple of days.


=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94


Hi Jarkko,

I must admit that I had a hard time understanding what you=E2=80=99re =
trying to say.

> On 23 Aug 2025, at 09:22, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> =EF=BB=BFOn Sat, Aug 23, 2025 at 03:12:48PM +0300, Jarkko Sakkinen =
wrote:
>> Hi
>>=20
>> As of today can we possibly do this:
>>=20
>> 1. drivers/char/tpm (C code)
>> 2. drivers/char/tpm/protocol (imported tpm2_protocol)
>>=20

What do you mean?

>> ?
>>=20
>> And then build FFI from C to Rust for building commands that we need
>> today etc.
>>=20
>> There's one particular challenge where this could help: early boot =
code
>> for D-RTM (i.e., Trenchboot) as given my crate is just a thing in =
stack
>> with no deps, it could be linked also to that payload.
>>=20
>> This would be much better integration step for TPM2 than having a
>> separate driver on Rust side. We could start with tpm2-cmd1/cmd2, =
then
>> move on to tpm2-space.c i.e. get all structural processing inside =
Rust.

Can you expand on what these cmds are?

>>=20
>> tpm2_protocol is light on definitions and should not need any kernel
>> specific Rust shenanigans.

You mean the Rust abstractions?

>>=20
>> Consider it as value like integer but just a bit more complex =
internaal
>> represention but in the end it is just a value on stack.

Not sure what you mean here either.

>>=20
>> My goal with tpm2_protocol is to have ACPICA alike model of imports =
as
>> the crate is driven by TCG spec updates and it is very likely to be
>> also used by TPM-RS (also via import style process).
>=20
> The source code since 0.10.0 version has been relocated here:
>=20
> =
https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/tpm2-protocol.git
>=20
> The representation of commands and responses defined is pretty well
> high-lighted by
>=20
> https://bsky.app/profile/jarkk0.bsky.social/post/3lx2n2uvxos2h
>=20
> I'm also working on a test that measures the estimated compile time
> size and realized run-time size (suggested by Philip Tricca) so that
> we know where we are at on stack usage.
>=20
> I've started to optimize it after development phase with some
> low-hanging fruit cut already in 0.10.0 but this work is barely
> starting [1].
>=20
> There's also a kselftest compatible test that can be run with
> "make test" in the repo using only rustc (build + run circa
> 2 seconds on my laptop).
>=20
> [1] =
https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/tpm2-protocol.git/c=
ommit/?id=3Dcd6641bf9e8c8fde8726bece9eb6cdc630d893c2
>=20
> BR, Jarkko



My somewhat limited understanding here is that you=E2=80=99re trying to =
implement
Rust code that can be called from the rest of the kernel, but that =
otherwise
doesn=E2=80=99t depend on it? =20

If so, I did try something similar [0]. Perhaps this is useful to you =
and is
somewhat applicable to your use case as well?

[0]: https://lwn.net/Articles/970565/=

