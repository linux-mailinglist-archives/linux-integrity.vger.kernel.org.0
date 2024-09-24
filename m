Return-Path: <linux-integrity+bounces-3691-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1068D984B2B
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 20:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247F11C22D5E
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 18:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2DB1ACDFD;
	Tue, 24 Sep 2024 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="GHjq1k/X";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="GHjq1k/X"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44911AC8BD;
	Tue, 24 Sep 2024 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203234; cv=none; b=Z6ssXapbESmeoqOZ8NXFTsZbME8itxqK4J40r8erNK4xKqOLvb7RgzqQfRdw9w53Vic1YHlwUfickFgtRp8+oTO9ZVyW8FWqYxT6wddegGNtKOAa11eKflCUNDWy0V7IdwjImOoMOXSXPGXf0G1tuYY/HFQ/VncLX+hpSIDJnrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203234; c=relaxed/simple;
	bh=G1+iYIMXKAAhu1gUsBdeajNa7W5sVJ0o6F2+3mbKOXE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NQABsTEAxQJBgjxaaJszbojo77WTRMir3YCy+GVJrtJ97mt6cVaGjDCRMkLaase8vn+OOaMG/feMbVF3Te9hCo94A8nOz+uMXu8bxHqEH7bjXw6kWxnBDO0dCgkB2FJFLyKiQcj0NAdCqI+SB3mABmbOjDQ4+01E9YcT7nkxtrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=GHjq1k/X; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=GHjq1k/X; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1727203231;
	bh=G1+iYIMXKAAhu1gUsBdeajNa7W5sVJ0o6F2+3mbKOXE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=GHjq1k/XXWOKXVMctBEZ82cIt2RE9mZ2W72rTFazLDck4JZ4cvMa8kDy0Sx5HjW9T
	 Lu4R3wCNSpsG4B3VJ0XU+pxui0QCh2+LRNsXvMgywSb11SPemeISuFtpWsOg+idsmG
	 XRyqjGA96IMn7Qr4lb5o33hkV2VKYCdoZcQQ9ZOM=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 961441280EA1;
	Tue, 24 Sep 2024 14:40:31 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id HHszksyqbAgN; Tue, 24 Sep 2024 14:40:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1727203231;
	bh=G1+iYIMXKAAhu1gUsBdeajNa7W5sVJ0o6F2+3mbKOXE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=GHjq1k/XXWOKXVMctBEZ82cIt2RE9mZ2W72rTFazLDck4JZ4cvMa8kDy0Sx5HjW9T
	 Lu4R3wCNSpsG4B3VJ0XU+pxui0QCh2+LRNsXvMgywSb11SPemeISuFtpWsOg+idsmG
	 XRyqjGA96IMn7Qr4lb5o33hkV2VKYCdoZcQQ9ZOM=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1E0291280300;
	Tue, 24 Sep 2024 14:40:30 -0400 (EDT)
Message-ID: <f9e2072909d462af72a9f3833b2d76e50894e70a.camel@HansenPartnership.com>
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
Date: Tue, 24 Sep 2024 14:40:28 -0400
In-Reply-To: <D4EPQPFA8RGN.2PO6UNTDFI6IT@kernel.org>
References: <20240921120811.1264985-1-jarkko@kernel.org>
	 <20240921120811.1264985-6-jarkko@kernel.org>
	 <00cf0bdb3ebfaec7c4607c8c09e55f2e538402f1.camel@HansenPartnership.com>
	 <D4EPQPFA8RGN.2PO6UNTDFI6IT@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-09-24 at 21:07 +0300, Jarkko Sakkinen wrote:
> On Tue Sep 24, 2024 at 4:43 PM EEST, James Bottomley wrote:
> > On Sat, 2024-09-21 at 15:08 +0300, Jarkko Sakkinen wrote:
> > > Instead of flushing and reloading the auth session for every
> > > single transaction, keep the session open unless /dev/tpm0 is
> > > used. In practice this means applying TPM2_SA_CONTINUE_SESSION to
> > > the session attributes. Flush the session always when /dev/tpm0
> > > is written.
> > 
> > Patch looks fine but this description is way too terse to explain
> > how it works.
> > 
> > I would suggest:
> > 
> > Boot time elongation as a result of adding sessions has been
> > reported as an issue in
> > https://bugzilla.kernel.org/show_bug.cgi?id=219229
> > 
> > The root cause is the addition of session overhead to
> > tpm2_pcr_extend().  This overhead can be reduced by not creating
> > and destroying a session for each invocation of the function.  Do
> > this by keeping a session resident in the TPM for reuse by any
> > session based TPM command.  The current flow of TPM commands in the
> > kernel supports this because tpm2_end_session() is only called for
> > tpm errors because most commands don't continue the session and
> > expect the session to be flushed on success.  Thus we can add the
> > continue session flag to session creation to ensure the session
> > won't be flushed except on error, which is a rare case.
> 
> I need to disagree on this as I don't even have PCR extends in my
> boot sequence and it still adds overhead. Have you verified this
> from the reporter?
> 
> There's bunch of things that use auth session, like trusted keys.
> Making such claim that PCR extend is the reason is nonsense.

Well, the bug report does say it's the commit adding sessions to the
PCR extends that causes the delay:

https://bugzilla.kernel.org/show_bug.cgi?id=219229#c5

I don't know what else to tell you.

James


