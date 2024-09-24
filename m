Return-Path: <linux-integrity+bounces-3675-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E03984705
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 15:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694D51F22FF8
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 13:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B361A726A;
	Tue, 24 Sep 2024 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="kCWNoyFT";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="kCWNoyFT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD3C1EEF9;
	Tue, 24 Sep 2024 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727185689; cv=none; b=NBbGfrUZfZj4B1S7PdUPH4UarJrpNC2XZ89p5f9/v13bSJ281/FKMzPtDZU66HhIhr+6tH0MwCCSoe64lZMKu5USJmLu2tkpSJ63+313iB+cID3MnXWoCr+1+1TTbn20ApAOGva5udLh1U30G7uDyVx+YRNsESkcTAqw0t4t8cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727185689; c=relaxed/simple;
	bh=ELA9QuUzftM2R+CxQDJRbgabg3MJ01WGpQ1z6E/qh2U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fnEXbt79rGK0aCjbzP6b8ZzIbtehdSB3MBOrLlMWa5Ky+w9DVsG3h63fNj72WnRBO5KQQYZJ13JwugyyQdymxvNhpa22PzBKqhzrGMYanBlvsx8zaeyp6w23fYrhc3UGSJTo0UfntlT/0Y7sL+gulRPNXKEhinx2H9h066TuGn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=kCWNoyFT; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=kCWNoyFT; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1727185686;
	bh=ELA9QuUzftM2R+CxQDJRbgabg3MJ01WGpQ1z6E/qh2U=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=kCWNoyFTnO5ZeTHhnts309UAqo+Zqg9NMDY+3SJcB0aXeG3133cLoHhmJAWxIZvyS
	 NhCCvKW6xTQ9tiI/tKoKosOgKOQ9Ov60mN6dm9/5lPV353zNc6EBpfzZ0rTNeWVjR/
	 SKtXD99HjXf9KDxEM8BDyYXTApDRpeGfvpIRqEQg=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id A67D71281683;
	Tue, 24 Sep 2024 09:48:06 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id XVAF8rrNFW-d; Tue, 24 Sep 2024 09:48:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1727185686;
	bh=ELA9QuUzftM2R+CxQDJRbgabg3MJ01WGpQ1z6E/qh2U=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=kCWNoyFTnO5ZeTHhnts309UAqo+Zqg9NMDY+3SJcB0aXeG3133cLoHhmJAWxIZvyS
	 NhCCvKW6xTQ9tiI/tKoKosOgKOQ9Ov60mN6dm9/5lPV353zNc6EBpfzZ0rTNeWVjR/
	 SKtXD99HjXf9KDxEM8BDyYXTApDRpeGfvpIRqEQg=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 51923128118D;
	Tue, 24 Sep 2024 09:48:05 -0400 (EDT)
Message-ID: <c26a295d96b14173b5693c5933e92bbda84764cc.camel@HansenPartnership.com>
Subject: Re: [PATCH v5 0/5] Lazy flush for the auth session
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, mapengyu@gmail.com, Mimi Zohar
 <zohar@linux.ibm.com>,  David Howells <dhowells@redhat.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,  "Serge E. Hallyn"
 <serge@hallyn.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe
 <jgg@ziepe.ca>, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 24 Sep 2024 09:48:02 -0400
In-Reply-To: <D4D05FKB9VSG.33COYTJHUX6EM@kernel.org>
References: <20240921120811.1264985-1-jarkko@kernel.org>
	 <D4D05FKB9VSG.33COYTJHUX6EM@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 2024-09-22 at 20:51 +0300, Jarkko Sakkinen wrote:
> On Sat Sep 21, 2024 at 3:08 PM EEST, Jarkko Sakkinen wrote:
> > This patch set aims to fix:
> > https://bugzilla.kernel.org/show_bug.cgi?id=219229.
> > 
> > The baseline for the series is the v6.11 tag.
> > 
> > v4:
> > https://lore.kernel.org/linux-integrity/20240918203559.192605-1-jarkko@kernel.org/
> > v3:
> > https://lore.kernel.org/linux-integrity/20240917154444.702370-1-jarkko@kernel.org/
> > v2:
> > https://lore.kernel.org/linux-integrity/20240916110714.1396407-1-jarkko@kernel.org/
> > v1:
> > https://lore.kernel.org/linux-integrity/20240915180448.2030115-1-jarkko@kernel.org/
> > 
> > Jarkko Sakkinen (5):
> >   tpm: Return on tpm2_create_null_primary() failure
> >   tpm: Implement tpm2_load_null() rollback
> >   tpm: flush the null key only when /dev/tpm0 is accessed
> >   tpm: Allocate chip->auth in tpm2_start_auth_session()
> >   tpm: flush the auth session only when /dev/tpm0 is open
> > 
> >  drivers/char/tpm/tpm-chip.c       |  14 ++++
> >  drivers/char/tpm/tpm-dev-common.c |   8 +++
> >  drivers/char/tpm/tpm-interface.c  |  10 ++-
> >  drivers/char/tpm/tpm2-cmd.c       |   3 +
> >  drivers/char/tpm/tpm2-sessions.c  | 109 ++++++++++++++++++--------
> > ----
> >  include/linux/tpm.h               |   2 +
> >  6 files changed, 102 insertions(+), 44 deletions(-)
> 
> 
> Roberto, James, speaking of digest cache. This patch set has no aim
> to fix those issues but I do believe that it should improve also that
> feature.
> 
> If I don't get soon patch reviews for the patch set, I'll pick the
> 2nd best option: disable bus encryption on all architectures
> including x86 and ARM64 (being by default on).
> 
> It's a force majeure situation. I know this would sort out the issue
> but I really cannot send these as a pull request with zero reviewe-
> by's.
> 
> I expect this to be closed by tomorrow.

Hey come on, you knew I was running plumbers last week so I had all the
lead up and teardown stuff to do as well.  I'm only just digging
through accumulated email.

Patches 1-2 are fully irrelevant to the bug, so I ignored them on the
grounds that improvement to the error flow could be done through the
normal patch process

Patch 3 is completely unnecessary: the null key is only used to salt
the session and is not required to be resident while the session is
used (so can be flushed after session creation) therefore keeping it
around serves no purpose once the session is created and simply
clutters up the TPM volatile handle slots. (I don't know of a case
where we use all the slots in a kernel operation, but since we don't
need it lets not find out when we get one).  So I advise dropping patch
3.

I've reviewed 4 and 5.

Regards,

James


