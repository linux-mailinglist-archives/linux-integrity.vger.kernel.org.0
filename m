Return-Path: <linux-integrity+bounces-3745-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B88A0993B5E
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Oct 2024 01:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E82D284612
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Oct 2024 23:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCD9192592;
	Mon,  7 Oct 2024 23:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJ0A6vOp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC802191F91;
	Mon,  7 Oct 2024 23:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728344707; cv=none; b=Ap0Uv7RzMwXe5teH2dQpoXiZouYaoFe1FbvT5obzQJZrJ0alJUFQe/77l3KieNC2Fbeo+vvBgIQxfAajw7PUZ/AuHZPI8RdzQNW+k6q0oY/4VIiSuDTbyHMss9MLxtUDTwZJV3Lcq4LqjEdJSuGzwqJ5xZD18oV88pKR5crQ1GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728344707; c=relaxed/simple;
	bh=pxoATet1YBznyVvU9aVNkP16cxo0TvrxIsY6voDpuRI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rk/O7OSfvQ42h53NQKdbGzlqY9g1Or9ZRtbDDVPOSpOB7I1eNWh4E1gBT0JmX6vN3zxt7MJpb1+0cEM52Q5rJAoatIY11WmdfmSvS/hvYFheEjNrzz5JYEAMGjcCauLr0Fako+J+40hwJ5R26d5duy3NC9WPp5Y8b+CkS04eoFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJ0A6vOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97C8C4CEC6;
	Mon,  7 Oct 2024 23:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728344707;
	bh=pxoATet1YBznyVvU9aVNkP16cxo0TvrxIsY6voDpuRI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XJ0A6vOpzIj9U57D/Wz7VPkM9cxQbnSBizjE9HpP/EVmFnxBMzXoGV/LIpWHoesSP
	 avw/u3Vhyy32yr7LWi3GuBRlAGqlmESWsIZ1p7jX7jv2EfUqiNCMVDIUhU5ylyzpf2
	 ei5NSp/DE8YJ6pT3KTFS7PZxUe/HQ6aMrdnXdIFB/KLAF7OMjAik6vD/wfjW0IuHL7
	 EFBin+xpXM3fbj9e65GxaBLDwHn9iGDoYla86RqkBz6P5bCbj4jB1aPAQRsenYFO5q
	 yH5NgYbyTqZNXnMS6Ux2WjDSncOa20ObOTDnb92V7VNbjCSR9w5ZHD1G04tKyIByZQ
	 AX2iDyjEZasoA==
Message-ID: <e2dbcd020b3a3bc74bbd829b1299008b5504cc45.camel@kernel.org>
Subject: Re: [PATCH v5 0/5] Lazy flush for the auth session
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, roberto.sassu@huawei.com, 
 mapengyu@gmail.com, David Howells <dhowells@redhat.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
 <serge@hallyn.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe
 <jgg@ziepe.ca>, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 08 Oct 2024 02:45:03 +0300
In-Reply-To: <3fed38bc5c9de9e1a16fd5c1413ba8a965d26dac.camel@linux.ibm.com>
References: <20240921120811.1264985-1-jarkko@kernel.org>
	 <D4D05FKB9VSG.33COYTJHUX6EM@kernel.org>
	 <3fed38bc5c9de9e1a16fd5c1413ba8a965d26dac.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-01 at 14:10 -0400, Mimi Zohar wrote:
> On Sun, 2024-09-22 at 20:51 +0300, Jarkko Sakkinen wrote:
> > On Sat Sep 21, 2024 at 3:08 PM EEST, Jarkko Sakkinen wrote:
> > > This patch set aims to fix:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D219229.
> > >=20
> > > The baseline for the series is the v6.11 tag.
> > >=20
> > > v4:
> > > https://lore.kernel.org/linux-integrity/20240918203559.192605-1-jarkk=
o@kernel.org/
> > > v3:
> > > https://lore.kernel.org/linux-integrity/20240917154444.702370-1-jarkk=
o@kernel.org/
> > > v2:
> > > https://lore.kernel.org/linux-integrity/20240916110714.1396407-1-jark=
ko@kernel.org/
> > > v1:
> > > https://lore.kernel.org/linux-integrity/20240915180448.2030115-1-jark=
ko@kernel.org/
> > >=20
> > > Jarkko Sakkinen (5):
> > > =C2=A0 tpm: Return on tpm2_create_null_primary() failure
> > > =C2=A0 tpm: Implement tpm2_load_null() rollback
> > > =C2=A0 tpm: flush the null key only when /dev/tpm0 is accessed
> > > =C2=A0 tpm: Allocate chip->auth in tpm2_start_auth_session()
> > > =C2=A0 tpm: flush the auth session only when /dev/tpm0 is open
> > >=20
> > > =C2=A0drivers/char/tpm/tpm-chip.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 14 ++++
> > > =C2=A0drivers/char/tpm/tpm-dev-common.c |=C2=A0=C2=A0 8 +++
> > > =C2=A0drivers/char/tpm/tpm-interface.c=C2=A0 |=C2=A0 10 ++-
> > > =C2=A0drivers/char/tpm/tpm2-cmd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 3 +
> > > =C2=A0drivers/char/tpm/tpm2-sessions.c=C2=A0 | 109 ++++++++++++++++++=
------
> > > ------
> > > =C2=A0include/linux/tpm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > > =C2=A06 files changed, 102 insertions(+), 44 deletions(-)
> >=20
> >=20
> > Roberto, James, speaking of digest cache. This patch set has no aim
> > to
> > fix those issues but I do believe that it should improve also that=20
> > feature.
> >=20
> > If I don't get soon patch reviews for the patch set, I'll pick the
> > 2nd
> > best option: disable bus encryption on all architectures including
> > x86
> > and ARM64 (being by default on).
> >=20
> > It's a force majeure situation. I know this would sort out the
> > issue
> > but I really cannot send these as a pull request with zero reviewe-
> > by's.
> >=20
> > I expect this to be closed by tomorrow.
>=20
> Jarkko, sorry to be so late to this discussion.=C2=A0 The bus
> HMAC/encryption really
> impacts IMA as well.=C2=A0 Even with this patch set, it's slow.=C2=A0 My
> preference would
> be to disable bus encryption on all architectures until there is a
> boot/runtime
> option allowing it to be disabled for IMA as discussed in the other
> thread.

No worries, I was getting nervous because of a job switch, now
I have time since cannot move this forward for week or two anyway
:-)

I'm totally +1 to make bus encyption opt-in instead of opt-out.
It's just not there yet.

My fixes fix one use case, i.e. the boot process for AMD, so in
that sense they are totally legit. But it is pretty clear by now
that tons of similar patches and small tweaks will be required.

As it is my 2nd work week, I can implement such patch, *next
week*. Up until that there is time to give any feedback.

>=20
> In the other thread, I also mentioned that the Kconfig is incorrectly
> worded.=20
> The performance degradation is not limited to encryption, but the
> HMAC itself.=20
> Please change "Saying Y here adds some encryption overhead to all
> kernel to TPM
> transactions." to "Saying Y here adds overhead to all kernel to TPM
> transactions."

I'll keep this in mind!

I'd prefer to do a single patch set probably with my previous fixes
and this, as they are already tested by the reporter anyway and pile
this as a new patch on top. I.e. have basically all that I'd put to
the next PR.

>=20
> thanks,
>=20
> Mimi

BR, Jarkko

