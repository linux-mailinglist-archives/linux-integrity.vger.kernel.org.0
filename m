Return-Path: <linux-integrity+bounces-3694-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E540984D0D
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 23:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3F8281827
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 21:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41FA13D25E;
	Tue, 24 Sep 2024 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="kxQorgTc";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="kxQorgTc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC3413F43B;
	Tue, 24 Sep 2024 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727214703; cv=none; b=GshpaFCU6kQo1WaTQNZgyhqwjm8f6OL01sdASkjbrXnkAcBa38s0hfN7BVNYKDbWdSbf7LPZfTwIFZnsiMzwDzhPFtLHvHef8DrDVbNnVvdiv3sXfGIbRMkwBfwHnrKzu0klNRhFZ1dv/TLjPfOPN+tChGIYD38hrVoA49kPqzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727214703; c=relaxed/simple;
	bh=WvrlGdS7gZqfl1m7PPSjfpZgCon5PYfxv6FOC15+ljk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UxulwtRoKk9k8xAtDoGj5J09RdFWoOrUrTiEugftzIzgICCFTLZi+PWUQrGpZMN+sUZtDwKGM4K874Dx6d18S+9ICs4EhcnNlicTSZnH0FcfqJPgIUm5zV0qBWMV+at57YNn+K6OBsBLE0UKtXcXnwIAYN6LrEZtuBVQgnciw5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=kxQorgTc; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=kxQorgTc; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1727214700;
	bh=WvrlGdS7gZqfl1m7PPSjfpZgCon5PYfxv6FOC15+ljk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=kxQorgTcqLizcCjdwi3KoQDLZK42hxn5WPfMoTQXMcZ3+vaeoySfij3mfVmB8Tcds
	 xRnCpBoEWOu4ZFy8QPAdSIvKJufkerMp7nfMJSr29nab/nrsfjY5ujLXDauTwapBXO
	 5zPLC7mBxLmWkXwJgY3lrOuJUDLNWEE2RvnrDxNI=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 97432128746A;
	Tue, 24 Sep 2024 17:51:40 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id nadPx_b3Iijt; Tue, 24 Sep 2024 17:51:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1727214700;
	bh=WvrlGdS7gZqfl1m7PPSjfpZgCon5PYfxv6FOC15+ljk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=kxQorgTcqLizcCjdwi3KoQDLZK42hxn5WPfMoTQXMcZ3+vaeoySfij3mfVmB8Tcds
	 xRnCpBoEWOu4ZFy8QPAdSIvKJufkerMp7nfMJSr29nab/nrsfjY5ujLXDauTwapBXO
	 5zPLC7mBxLmWkXwJgY3lrOuJUDLNWEE2RvnrDxNI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 27F4E12873CB;
	Tue, 24 Sep 2024 17:51:39 -0400 (EDT)
Message-ID: <2b4c10ca905070158a4bc2fb78d5d5b0f32950ad.camel@HansenPartnership.com>
Subject: Re: [PATCH v5 5/5] tpm: flush the auth session only when /dev/tpm0
 is open
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, mapengyu@gmail.com, stable@vger.kernel.org,
 Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 24 Sep 2024 17:51:36 -0400
In-Reply-To: <D4EU5PQLA7BO.2J5MI195F8CIF@kernel.org>
References: <20240921120811.1264985-1-jarkko@kernel.org>
	 <20240921120811.1264985-6-jarkko@kernel.org>
	 <00cf0bdb3ebfaec7c4607c8c09e55f2e538402f1.camel@HansenPartnership.com>
	 <D4EPQPFA8RGN.2PO6UNTDFI6IT@kernel.org>
	 <f9e2072909d462af72a9f3833b2d76e50894e70a.camel@HansenPartnership.com>
	 <D4EU5PQLA7BO.2J5MI195F8CIF@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-09-25 at 00:35 +0300, Jarkko Sakkinen wrote:
> On Tue Sep 24, 2024 at 9:40 PM EEST, James Bottomley wrote:
> > On Tue, 2024-09-24 at 21:07 +0300, Jarkko Sakkinen wrote:
> > > On Tue Sep 24, 2024 at 4:43 PM EEST, James Bottomley wrote:
> > > > On Sat, 2024-09-21 at 15:08 +0300, Jarkko Sakkinen wrote:
> > > > > Instead of flushing and reloading the auth session for every
> > > > > single transaction, keep the session open unless /dev/tpm0 is
> > > > > used. In practice this means applying
> > > > > TPM2_SA_CONTINUE_SESSION to the session attributes. Flush the
> > > > > session always when /dev/tpm0 is written.
> > > > 
> > > > Patch looks fine but this description is way too terse to
> > > > explain how it works.
> > > > 
> > > > I would suggest:
> > > > 
> > > > Boot time elongation as a result of adding sessions has been
> > > > reported as an issue in
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=219229
> > > > 
> > > > The root cause is the addition of session overhead to
> > > > tpm2_pcr_extend().  This overhead can be reduced by not
> > > > creating and destroying a session for each invocation of the
> > > > function. Do this by keeping a session resident in the TPM for
> > > > reuse by any session based TPM command.  The current flow of
> > > > TPM commands in the kernel supports this because
> > > > tpm2_end_session() is only called for tpm errors because most
> > > > commands don't continue the session and expect the session to
> > > > be flushed on success.  Thus we can add the continue session
> > > > flag to session creation to ensure the session won't be flushed
> > > > except on error, which is a rare case.
> > > 
> > > I need to disagree on this as I don't even have PCR extends in my
> > > boot sequence and it still adds overhead. Have you verified this
> > > from the reporter?
> > > 
> > > There's bunch of things that use auth session, like trusted keys.
> > > Making such claim that PCR extend is the reason is nonsense.
> > 
> > Well, the bug report does say it's the commit adding sessions to
> > the PCR extends that causes the delay:
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=219229#c5
> > 
> > I don't know what else to tell you.
> 
> As far as I've tested this bug I've been able to generate similar
> costs with anything using HMAC encryption. PCR extend op itself
> should have same cost with or without encryption AFAIK.

That's true, but the only significant TPM operation in the secure boot
path is the PCR extend for IMA.  The RNG stuff is there a bit, but
there are other significant delays in seeding the entropy pool.  During
boot with IMA enabled, you can do hundreds of binary measurements,
hence the slow down.

> I guess I need provide benchmarks on this to prove that PCR extend is
> not the only site that is affected.

Well, on the per operation figures, it's obviously not, a standard TPM
operation gets a significant overhead because of sessions. However, it
is the only site that causes a large boot slowdown because of the
number of the number of measurements IMA does on boot.

Regards,

James


