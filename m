Return-Path: <linux-integrity+bounces-2584-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9624D8CD5CE
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 16:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C025B22260
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 14:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EF114BFBC;
	Thu, 23 May 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgfjaYGf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBB414C5AF;
	Thu, 23 May 2024 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474602; cv=none; b=ctQcT+Cf3nld3b+2B0XQuG/HmxMb9O8RbPLS0Oq36c544M1gzLDzYDYcP9xomzjj8ZM3CvjnvsfqwatP6JuJack7L6ul4utHzYcwkNY97ZDlDAcqCOPVusFSNI/gnyZm4ge/F5wE5O59UuXFIHWPHMUYwJnn5sJfKF5R3TseoQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474602; c=relaxed/simple;
	bh=fvip7+D9YF2c4AO5Qy8M/EolAc0WJbVaqxiGtI7E1HY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=dyYFQBmcNjeJDbx4gYVPRHf1yXsEWGnNm0cdVFWuWpjm0AfdkjeYzgic9ZAuUEwHJulKCj8ISUGcdNFj9zMDgzLcVRuUXlAhtgDqFzVnc5yn+2DeYjFUU6egnd+hK6KJm/jt6TIFY0i/DZZzqaA6AermYMITEjW8iSOrzGpRGDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgfjaYGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC29DC2BD10;
	Thu, 23 May 2024 14:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716474601;
	bh=fvip7+D9YF2c4AO5Qy8M/EolAc0WJbVaqxiGtI7E1HY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AgfjaYGfTLx8PEg8ihusHbBUYBDcPCGh466DknoJhZoEvWvzW0LfGbbL18FKCdYqH
	 zsekJOeAP1BiwyL+hfs8IZeCtvs5g0JKchcFxiD6VbaKnxAVo4FSsVla86B7jdeU3H
	 zTbngm19uu3P7IX63bi0PzgFJpQvoxjKyWnqf5aVan56JnppNF3dGGnxHQxIVCSx+I
	 xCNgpZIfRGBaNEuKKvjjZwoUf+d+QlJzgFs55e11vbW0PbqLBpHAV5kialOFHzPsXu
	 dZVvSUyNvaN6XS28ViIyeTt+TPnG+yRTocKDpe2uFBfj7QIzpnC3JzJOtgFzNvEB9y
	 Q/++cU7W5M0Yw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 May 2024 17:29:56 +0300
Message-Id: <D1H3GNK4GHSW.2DNFO64RJYXR2@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "David Woodhouse" <dwmw2@infradead.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Ben Boeckel" <me@benboeckel.net>,
 "David Howells" <dhowells@redhat.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "Andrew Morton" <akpm@linux-foundation.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "Paul Moore" <paul@paul-moore.com>, "James Morris"
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "open
 list:CRYPTO API" <linux-crypto@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>, "open list:SECURITY SUBSYSTEM"
 <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3] KEYS: trusted: Use ASN.1 encoded OID
X-Mailer: aerc 0.17.0
References: <20240523142056.17159-1-jarkko@kernel.org>
 <D1H3DW5XHHBS.3V527WMDQ829U@kernel.org>
In-Reply-To: <D1H3DW5XHHBS.3V527WMDQ829U@kernel.org>

On Thu May 23, 2024 at 5:26 PM EEST, Jarkko Sakkinen wrote:
> On Thu May 23, 2024 at 5:20 PM EEST, Jarkko Sakkinen wrote:
> > There's no reason to encode OID_TPMSealedData at run-time, as it never
> > changes.
> >
> > Replace it with an encoded u8-array, which has the same number of
> > elements:
> >
> > 	67 81 05 0A 01 05
> >
> > Include OBJECT IDENTIFIER (0x06) tag and length as the prologue so that
> > the OID can be simply copied to the blob leading to:
> >
> > 	06 06 67 81 05 0A 01 05
> >
> > Since this in stationary place in the buffer it is guaranteed to always
> > fit and not further checks are required.
> >
> > Reviewed-by: David Howells <dhowells@redhat.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> Does not really substitute distribution kernel testing, which is
> IMHO essential for something like TPM2 boot in systemd but for
> simple patches like this, the following does a trivial smoke
> test:
>
> export LINUX_OVERRIDE_SRCDIR=3D<path to a kernel tree with a trusted keys=
 patch>
> git clone https://gitlab.com/jarkkojs/linux-tpmdd-test.git
> cd linux-tpmdd-test
> cmake -Bbuild && make -Cbuild buildroot-prepare
> make -Cbuild/buildroot/build
> build/buildroot/build/images/run-tests.sh
>
> I'm planning to migrate at some point to systemd and make it
> appear more like distribution tho..
>
> For recompiling just kernel only thing needed is:
>
> rm -rf build/buildroot/build/build/linux-custom
> make -Cbuild/buildroot/build
>
> I've put this also to the MAINTAINERS entry of TPM driver although
> I use it also for keyrings etc. Also it is open for contributions
> via Gitlab merge requests (not requesting them per se but I'm open
> to such possibility).

Right and this is fully CI compatible with both Github and Gitlab
with only a single tweak: BR2_PACKAGE_HOST_QEMU needs to be added
to the qemu config. It is CI agnostic test environment to put=20
short.

I've had this also deployed to the CI in the past. It can run both
x86 and aarch64 based runners and even emulates hardware TPM in
three different modes (TPM 1.2, TPM 2.0 FIFO, TPM 2.0 CRB).

I've been just wondering why we need kernel tree changes for Gitlab
CI when you can pretty easily just bootstrap toolchain and qemu
and call it a day (and with trimmed builds it is quite fast too).

BR, Jarkko

