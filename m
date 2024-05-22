Return-Path: <linux-integrity+bounces-2554-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF858CC2E1
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 16:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1973D286014
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 14:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34C913D53F;
	Wed, 22 May 2024 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+Q3750N"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C273A1E4AB;
	Wed, 22 May 2024 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387226; cv=none; b=ilLYLiXq3yg8yJ+E7cHX8qb7xlXaVtC5v2c1vqDNlP2Z1+KFotSwcx2aIB0e6SPMVypTQaoYaIz4wEc4cOcYiHudZu5A9rJscVtNe3gyAa6uN7spygceuVFMuYLlS0Lj4chH7pr4nRJcdikgutB4p+xi7GGXQpEwI0acGbJlzFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387226; c=relaxed/simple;
	bh=3+PkXwZXhStybi9etPbkY23fmwd4r7n5f4fGWVhcsr0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=u0ji0dWYZzXClDm0slv68k7NaW253/bhALSw/CkS14T6h4LRyf0cf+ocNjiHhoU0tqtGkdwS9HC/evFR4sO1DgoXorXOJto3SHNd+2+cid3hJ4O4ZjPOlmV80qnE+0FVo8sORSG6gfqFc5BEv7fv4YUW7wtaHBZpR/c8+vjGQYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+Q3750N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69FFC2BBFC;
	Wed, 22 May 2024 14:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716387226;
	bh=3+PkXwZXhStybi9etPbkY23fmwd4r7n5f4fGWVhcsr0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=U+Q3750N/mtGeGDtg27ep1MaI8KU1Lp9FV7E1wpcDVS97Oe9E78fE5wPCwzIKQRaY
	 XXcGk3429FutzkLGl7+WR7Z/Nzut9Y8CcWGLBBdChxj3HKZlBmEk3wWTbvzFM3LOJK
	 ZHZceBTszgPUZm+aHRDxdskFxRn+cK7g63v7rMifPnmCWPZAW3gTsq9ZaqT48KrzvV
	 jaqGcyLgB684qFD6cI5lh7hYMcuSQYOrBP+QZ8wIEzFxeT94bAt058dAl2Df/z+Pr8
	 TctS03IdMMYglE7ZyAY7+k+OIc4wzRcx0myCGNj7Yunut9SQmmeFKaNHNkfV8u9L0k
	 asHKrpx377z/Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 May 2024 17:13:41 +0300
Message-Id: <D1G8HOCIDWTC.2ERVA0CYHLY0B@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Vitor
 Soares" <ivitro@gmail.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240519235122.3380-1-jarkko@kernel.org>
 <20240519235122.3380-2-jarkko@kernel.org>
 <850862655008f84ef0b6ecd99750e8dc395304d1.camel@gmail.com>
 <D1F4V8NMSUNZ.2VCTEKHZZ0LB@kernel.org>
 <17dc838120b56ce342c34611596c7b46dcd9ab5a.camel@HansenPartnership.com>
 <2dd8d49516ec9c7cb8c1182b5b8537b1e82d7067.camel@gmail.com>
 <17a5dcd7aceb356587ef7c8f45b0f6359b2d2a91.camel@HansenPartnership.com>
In-Reply-To: <17a5dcd7aceb356587ef7c8f45b0f6359b2d2a91.camel@HansenPartnership.com>

On Wed May 22, 2024 at 4:35 PM EEST, James Bottomley wrote:
> On Wed, 2024-05-22 at 09:18 +0100, Vitor Soares wrote:
> > On Tue, 2024-05-21 at 08:33 -0400, James Bottomley wrote:
> > > On Tue, 2024-05-21 at 10:10 +0300, Jarkko Sakkinen wrote:
> > > > This benchmark could be done in user space using /dev/tpm0.
> > >=20
> > > Let's actually try that.=C2=A0 If you have the ibmtss installed, the
> > > command to time primary key generation from userspace on your tpm
> > > is
> > >=20
> > > time tsscreateprimary -hi n -ecc nistp256
> > >=20
> > >=20
> > > And just for chuckles and grins, try it in the owner hierarchy as
> > > well (sometimes slow TPMs cache this)
> > >=20
> > > time tsscreateprimary -hi o -ecc nistp256
> > >=20
> > > And if you have tpm2 tools, the above commands should be:
> > >=20
> > > time tpm2_createprimary -C n -G ecc256
> > > time tpm2_createprimary -C o -G ecc256
> > >=20
> > > James
> > >=20
> > >=20
> >=20
> > Testing on an arm64 platform I get the following results.
> >=20
> > hmac disabled:
> > =C2=A0 time modprobe tpm_tis_spi
> > =C2=A0 real=C2=A0=C2=A0=C2=A0 0m2.776s
> > =C2=A0 user=C2=A0=C2=A0=C2=A0 0m0.006s
> > =C2=A0 sys=C2=A0=C2=A0=C2=A0=C2=A0 0m0.015s
> >=20
> > =C2=A0 time tpm2_createprimary -C n -G ecc256
> > =C2=A0 real=C2=A0=C2=A0=C2=A0 0m0.686s
> > =C2=A0 user=C2=A0=C2=A0=C2=A0 0m0.044s
> > =C2=A0 sys=C2=A0=C2=A0=C2=A0=C2=A0 0m0.025s
> >=20
> > =C2=A0 time tpm2_createprimary -C o -G ecc256
> > =C2=A0 real=C2=A0=C2=A0=C2=A0 0m0.638s
> > =C2=A0 user=C2=A0=C2=A0=C2=A0 0m0.048s
> > =C2=A0 sys=C2=A0=C2=A0=C2=A0=C2=A0 0m0.009s
> >=20
> >=20
> > hmac enabled:
> > =C2=A0 time modprobe tpm_tis_spi
> > =C2=A0 real=C2=A0=C2=A0=C2=A0 8m5.840s
> > =C2=A0 user=C2=A0=C2=A0=C2=A0 0m0.005s
> > =C2=A0 sys=C2=A0=C2=A0=C2=A0=C2=A0 0m0.018s
> >=20
> >=20
> > =C2=A0 time tpm2_createprimary -C n -G ecc256
> > =C2=A0 real=C2=A0=C2=A0=C2=A0 5m27.678s
> > =C2=A0 user=C2=A0=C2=A0=C2=A0 0m0.059s
> > =C2=A0 sys=C2=A0=C2=A0=C2=A0=C2=A0 0m0.009s
> >=20
> > =C2=A0 (after first command)
> > =C2=A0 real=C2=A0=C2=A0=C2=A0 0m0.395s
> > =C2=A0 user=C2=A0=C2=A0=C2=A0 0m0.040s
> > =C2=A0 sys=C2=A0=C2=A0=C2=A0=C2=A0 0m0.015s
> >=20
> > =C2=A0 time tpm2_createprimary -C o -G ecc256
> > =C2=A0 real=C2=A0=C2=A0=C2=A0 0m0.418s
> > =C2=A0 user=C2=A0=C2=A0=C2=A0 0m0.049s
> > =C2=A0 sys=C2=A0=C2=A0=C2=A0=C2=A0 0m0.009s
>
> That's interesting: it suggests the create primary is fast (as
> expected) but that the TPM is blocked for some reason.  Is there
> anything else in dmesg if you do
>
> dmesg|grep -i tpm
>
> ?
>
> Unfortunately we don't really do timeouts on our end (we have the TPM
> do it instead), but we could instrument your kernel with command and
> time sent and returned.  That may tell us where the problem lies.

If there was possibility to use bpftrace it is trivial to get histogram
of time used where. I can bake a script but I need to know first if it
is available in the first place before going through that trouble.

BR, Jarkko

