Return-Path: <linux-integrity+bounces-2013-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A794B898B91
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Apr 2024 17:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F481C21835
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Apr 2024 15:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF51129A99;
	Thu,  4 Apr 2024 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="QEm2tR3l";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="QEm2tR3l"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DB112BF06
	for <linux-integrity@vger.kernel.org>; Thu,  4 Apr 2024 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245799; cv=none; b=KaSQhLoZASLPHvpg5l6McodrKqPDBzxtqDQEX93y9VUX0UGRhwa7gMJpYemrbWtyQ1yDHyyPziMen/weTyWMY/ERpsgE4obytb4l0VB+cMfGjUL4F3YYBjtUOpLgOMyx4HKuR1CBcjR/Dlu3v0nf4eMvk3Kxb0rnE+EoooMt80Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245799; c=relaxed/simple;
	bh=/KZem5JcUAecz9AvyO5d4dul8jaQb17pfHKDYgt+AMg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WF9CCXKu0fBymvIr5ghf8NqLqr/r9c2kQGLV0YqEvPEQqZ9lqORyU9WNLyI9LC28blT7oHt+ndv41bagKGgaRTpfpPVTgURpPyE8v2TcQ3quRnQOkq7q8Y9Es86psM0lJumO1P7vSHnepwCcduidYT8C5dg8Gm0mMTrdNDkFtDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=QEm2tR3l; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=QEm2tR3l; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1712245796;
	bh=/KZem5JcUAecz9AvyO5d4dul8jaQb17pfHKDYgt+AMg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=QEm2tR3lQV5K1wOzv/mO0C1vwosKQdxl4YYEdsVKypPhXwE0D7D8XQLukNaKBsOSp
	 StRAUA1c4WN/juH6K3AKEsD3FJLOYwN7l18myJDyu78euK6JF97q7GkIpXY35uKpOK
	 DMyUDEWHkwmtd2WG7LSTMCIm15GEthuoAzLJTlyA=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 588AE1280BDD;
	Thu,  4 Apr 2024 11:49:56 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 5kIbZ-dZVjeW; Thu,  4 Apr 2024 11:49:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1712245796;
	bh=/KZem5JcUAecz9AvyO5d4dul8jaQb17pfHKDYgt+AMg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=QEm2tR3lQV5K1wOzv/mO0C1vwosKQdxl4YYEdsVKypPhXwE0D7D8XQLukNaKBsOSp
	 StRAUA1c4WN/juH6K3AKEsD3FJLOYwN7l18myJDyu78euK6JF97q7GkIpXY35uKpOK
	 DMyUDEWHkwmtd2WG7LSTMCIm15GEthuoAzLJTlyA=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 856991280941;
	Thu,  4 Apr 2024 11:49:55 -0400 (EDT)
Message-ID: <6857f043301a100ee93b3ea120a2d1d60e83efdb.camel@HansenPartnership.com>
Subject: Re: TPM error 0x0901, possibly related to TPM2_PT_CONTEXT_GAP_MAX
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, William Brown <wbrown@suse.de>, 
	linux-integrity@vger.kernel.org
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, Takashi Iwai <tiwai@suse.de>
Date: Thu, 04 Apr 2024 11:49:54 -0400
In-Reply-To: <D0BFMGM02V7A.1HEWQ05350K07@kernel.org>
References: <424B3F10-D91C-4F47-B33C-BB66FE4DB91A@suse.de>
	 <D0BFJLQ0JKO4.20EW2ZA8GIS5Z@kernel.org>
	 <D0BFMGM02V7A.1HEWQ05350K07@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2024-04-04 at 18:09 +0300, Jarkko Sakkinen wrote:
> [...]
> Emphasis that I might have forgotten something but this is what I can
> remember right now.

What you forgot is that I did originally proposed session degapping in
the kernel resource manager but it was rather complex, so you made me
take it out for lack of a use case.  It dates back to when we used the
old sourceforge tpmdd list which seems to have caused message loss, so
I'm not sure how complete this thread is:

https://lore.kernel.org/lkml/1484772489.2396.2.camel@HansenPartnership.com/

If I compare it to the fragment on sourceforge, you can see a bit more
of it (but sourceforge has lost the patch):

https://sourceforge.net/p/tpmdd/mailman/tpmdd-devel/thread/201702090906.v1996c6a015552%40wind.enjellic.com/#msg35656470

The reality is that unless you context save a session, you don't need
degapping and pretty much every TSS based use of sessions doesn't need
to save them, so people who construct TPM based systems rarely run into
this.  The exception is the tpm2-tools CLI project, which encourages
the context saving of sessions and thus can cause this.  We kept
tripping across this in the Keylime, but the eventual solution was to
dump the tpm2-tools dependency and do a direct TSS connection in the
Keylime agent.

James


