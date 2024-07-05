Return-Path: <linux-integrity+bounces-3020-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5B2928B48
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2024 17:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A921F25DC1
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2024 15:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA24016D9C0;
	Fri,  5 Jul 2024 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="tz+hmpXt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4EA16C685;
	Fri,  5 Jul 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720191907; cv=pass; b=AHqA1P7dJkk2r0JUz4YsHcZnGMPkdqzy2+jeQpnly2ricjHlDP2Zou7jW7z7Ybwd+aGoNpYYAzTfoPOHXrkpkJAyk5ko5QbjXwfZuvussNp/yS1kwl+zdC8R3brli9wMXrwPz3HM86AJBa24eEy7y8mQoUArp4gktn93wLP52g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720191907; c=relaxed/simple;
	bh=HKSqxvF3CxgL10ACjEGWckPH1vvYFkiWNx3iwMo7AA8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qknMxEf6Zdul1Fh6tOKtR0bKIUBhJLL76Kgky14PS0sFSKd1pPTjPjf/wvQEQN4KXtRziGJsss8K2RSVBfeTgExiKxa2ubxwPq4SVMJXBLO1+ecGW5F9i63/8ymYdsQraYGu50lfmbzMVVgcgHRerJD5TPY1pk7Yfd0niaTuKTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=tz+hmpXt; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (83-245-197-232.elisa-laajakaista.fi [83.245.197.232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4WFxdK1ljHz49PwY;
	Fri,  5 Jul 2024 18:04:52 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1720191896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I1T+P8FyFyyO/m0YF8++lEjDIL2XJa3WTUGx4ue/aE0=;
	b=tz+hmpXtF1An88gQr0KIJGScQpFm9ckn28+DNI1w3j6Szh4QE25ZaWuBdev/21V5xPKvYv
	9zZFbc9MLE1XhHARcQI6MRa9BLLXCFUglXSSiJFV7BjUUEJ8xZZ9q2eL8AbnB/Glgwsdjz
	uBCE/xpB06MqFgvHhvr33FvOFMrYmrPfb9XGAOLb0FoUku+tzqGgZ678BTb5TjLvGh/07B
	tJmDtzy/oXp+CjjLWvXth/WmIO14ScQsuZ4ooFE+OBqlLYZ7FnumaE+g0OodSt/Hvmenvy
	RPUtuADcZcTiKCE2uZ7o1KEqmT9/r9APUxyNp6adyE48aV0IrMf9yLT6Iv54Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1720191896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I1T+P8FyFyyO/m0YF8++lEjDIL2XJa3WTUGx4ue/aE0=;
	b=vaXREb1LYrwVwE0h3MpNdszwKsXTcSaLnu4TdlVWLAcLEkOn/g5LgkKvolcVHh/hzz4auC
	F+TbRHJln7ORldVNDcQ7Yq7a3kjInW+T6K7kP2xxqnz7zMhH6m+8/k0Hu8gg4eMCwH+ofJ
	gDCy1swxqWthMbedsKeUooVDg25SiUgpn6RZSq/alr8bixgSpvVuXf/yrxZimEv0haMk3H
	JiZLddFit1tdH5EQA4QTPO0cVKegJ4mZiEP54wh1cW3y57Njy7Sl2srSruc+EXBV6MiNFU
	ZWVYPtMs4Ubg6qnnR2NCiy5RbfJV03e27YwtQbw5n8Qi/n6AqAKrZKB6qn8N3w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1720191896; a=rsa-sha256;
	cv=none;
	b=T1mf1NkKLBvs1+EKIb8wizUNhUGJMm0UWU9rHP/XzyLr1iLHEEAL3v8xormQWi5kqTiKmN
	cil9l5+OnPLreYdwbSjUdz1awdQozS84jb8YGru6VUtfrUjjSOg5HAimV3LXK9TZ7jV3++
	qEcGaTGW86Rp9P6UfML7sGHAPrVPGTAozVpueotKdr7EU8lFzUop3XSrbm98cY3YB/galj
	DJZYeQZtSXPnIS7zrLo3FrQdmbW3N49CqtQwgWlEokXNzaouaYLa/4czsHYlVc57cxVkIE
	dAgxN4WiGIodm3JAcfJ383jzhx0T6eZQ6tnkusBxzdXQpnUwLJMpVlcqlNoCYA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jul 2024 18:04:52 +0300
Message-Id: <D2HP4TX4S873.2OS2LXAWT58C4@iki.fi>
Cc: "Thorsten Leemhuis" <regressions@leemhuis.info>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, <stable@vger.kernel.org>, "Peter Huewe"
 <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Ard Biesheuvel" <ardb@kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, <linux-kernel@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] tpm: Address !chip->auth in
 tpm_buf_append_hmac_session*()
From: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Stefan Berger"
 <stefanb@linux.ibm.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240703182453.1580888-1-jarkko@kernel.org>
 <20240703182453.1580888-4-jarkko@kernel.org>
 <c90ce151-c6e5-40c6-8d3d-ccec5a97d10f@linux.ibm.com>
 <D2GJSLLC0LSF.2RP57L3ALBW38@kernel.org>
 <bffebaaa-4831-459f-939d-adf531e4c78b@linux.ibm.com>
 <D2HOI1829XOO.3ERITAWX9N5IC@kernel.org>
In-Reply-To: <D2HOI1829XOO.3ERITAWX9N5IC@kernel.org>

On Fri Jul 5, 2024 at 5:35 PM EEST, Jarkko Sakkinen wrote:
> On Fri Jul 5, 2024 at 5:05 PM EEST, Stefan Berger wrote:
> > The original thread here
> >
> > https://lore.kernel.org/linux-integrity/656b319fc58683e399323b880722434=
467cf20f2.camel@kernel.org/T/#t
> >
> > identified the fact that tpm2_session_init() was missing for the ibmvtp=
m=20
> > driver. It is a non-zero problem for the respective platforms where thi=
s=20
> > driver is being used. The patched fixed the reported issue.
>
> All bugs needs to be fixed always before features are added. You are
> free now to submit your change as a feature patch, which will be
> reviewed and applied later on.
>
> > Now that you fixed it in v4 are you going to accept my original patch=
=20
> > with the Fixes tag since we will (likely) have an enabled feature in=20
> > 6.10 that is not actually working when the ibmvtpm driver is being used=
?
>
> There's no bug in tpm_ibmvtpm driver as it functions as well as in 6.9.
>
> I can review it earliest in the week 31, as feature patch. This was my
> holiday week, and I came back only to fix the bug in the authentication
> session patch set.
>
> > I do no think that this is true and its only tpm_ibmvtpm.c that need th=
e=20
> > call to tpm2_session_init. All drivers that use TPM_OPS_AUTO_STARTUP=20
> > will run tpm_chip_register -> tpm_chip_bootstrap -> tpm_auto_startup ->=
=20
> > tpm2_auto_startup -> tpm2_sessions_init
>
> Right my bad. I overlooked the call sites and you're correct in that
> for anything with that flag on, it will be called.
>
> It still changes nothing, as the commit you were pointing out in the
> fixes tag does not implement initialization code, and we would not have
> that flag in the first place, if it was mandatory [1].
>
> [1] It could be that it is mandatory perhaps, but that is a different
> story. Then we would render the whole flag out. I think this was anyway
> good insight, even if by unintentionally, and we can reconsider removing
> it some day.

I should have rejected the patch set based on not validating chip->auth
in opaque API that tpm2-sessions is, and it should not fail caller like
that no matter how world outside of it is structured. It's a time-bomb
like it is in the mainline because of this.  I missed that detail
and your transcript exposed the bug.

Working around an *identified* bug in the caller *is not* a bug fix.

BR, Jarkko

