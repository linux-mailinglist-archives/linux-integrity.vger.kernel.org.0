Return-Path: <linux-integrity+bounces-5354-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABDEA6B620
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 09:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2553B9248
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 08:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A62D1EFFA0;
	Fri, 21 Mar 2025 08:40:03 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A500B1E5739;
	Fri, 21 Mar 2025 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742546403; cv=none; b=nmNvGY+QS9hzRn1Txjrzz10LnfWVLKMivxMe1ssWNrBdpanuYLY/7v2L9ljHe/7j3f0M0VOGFIGpjIeJ7mxYYz9USNcqCY1ZZdMAf/D+P+hZp3aI4S5W+FlvlaB3mY6MsMpuIXAW435lzOUzo13Q+jzfyMGaCQ50R60SAL1mdcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742546403; c=relaxed/simple;
	bh=EsV15d4XaElLZh9cc7vhzqYzwZExX7m6h/piCJGD2Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkdEbJVzxIj/f6+47TBmgcu5JwE5OTTTVE58GQ0iab/A8y3Ber2QFwf7CWkdH0RYctzVIytZxQnywOqM7J5JfiHWtrXn9/UsxhoeSUfjtffqjUOBV9TkHf7fdOyYAsDBL34LfarAUNZViO4hhNKHYk0k2r4WH8JdZimCmMywbig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 17EDFE80188;
	Fri, 21 Mar 2025 09:39:57 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 50FF3160206; Fri, 21 Mar 2025 09:39:55 +0100 (CET)
Date: Fri, 21 Mar 2025 09:39:55 +0100
From: Lennart Poettering <mzxreary@0pointer.de>
To: lee joey <joeyli.kernel@gmail.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	joeyli <jlee@suse.com>
Subject: Re: [PATCH] Revert "integrity: Do not load MOK and MOKx when secure
 boot be disabled"
Message-ID: <Z90l26ADmS87tu0k@gardel-login>
References: <Z9wDxeRQPhTi1EIS@gardel-login>
 <CAGLnvc_eyLEasc4tKYnYp2c1M+YYRxaoXt2BmJ3kgAec6YTmzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGLnvc_eyLEasc4tKYnYp2c1M+YYRxaoXt2BmJ3kgAec6YTmzg@mail.gmail.com>

On Fr, 21.03.25 15:13, lee joey (joeyli.kernel@gmail.com) wrote:

> Hi Lennart,
>
> Lennart Poettering <mzxreary@0pointer.de> 於 2025年3月20日 週四 下午8:02寫道：
> >
> > This reverts commit 92ad19559ea9a8ec6f158480934ae26ebfe2c14f.
> >
> > This original commit this reverts creates a strange situation: it
> > ensures more restrictive behaviour if SecureBoot is off then when it
> > is on, which is the opposite of what one would expect.
> >
> > Typically, one would expect that if SB is off the validation of
> > resources during the pre-kernel and kernel initialization is less
> > restrictive, not more restrictive. But this check turned the world on
> > its head.
> >
>
> SB off means that the chain of trust is broken. Which means that all
> mechanisms rely on SB are non-secure. Meanwhile, if the integrity of kernel
> can be guaranteed by other mechanism (e.g. TPM), then mok should not
> be loaded when SB off.

Why not? as you say, chain of trust is broken: the kernel itself is
not immediately integrity protected and neither is the firmware. Hence
filtering out keys in this case is really pointless.

> > I'd like to ask for this commit to be reverted. If SB is on all bets are
> > off regarding integrity of boot loaders and stuff, hence it makes no
> > sense to be restrictive here: you cannot regain integrity once you gave
> > it up once, hence if all bets are off anyway we might as well import any
> > Mok keys passed to us into the kernel keyring.
> >
> > Or to say this differently: if an attacker got control of the pre-kernel
> > boot phase they might as well patch around in the firmware apis to make
> > the kernel believe it is in SB mode even if it is not. Hence the check
> > carries no value. It doesn't protect anything in any effective way.
>
> If this is the case, the check of MokListTrustedRT can also be
> removed.

I think it makes sense to honour explicit knobs, such as
MokListTrustedRT: It has a very clear meaning: it indicates whether to
import the keys or not.

This is quite different from SB state, which is not explicit about
importing keys at all, it just indicates whether firmware level
validation of signatures is done or not.

> All mok can directly be added to machine keyring then link with
> secondary keyring.
> Because attacker can create MokListTrusted/MokListTrusted variables to cheat
> bootloader or kernel. The check of MokListTrustedRT is useless.

Yeah, it does not carry immediate security value if SB is off. But it
does allow finer-grained control by pre-boot code of how the kernel
later sets up things. Hence I'd keep it.

> > You might wonder what signed dm-verity gives me if I have SB off. If
> > we authenticate the boot phase up to Linux userspace via TPM-based PCR
> > policies (i.e. measured boot) we can be sure of the boot integrity
> > without having to rely on SB. But then we'd still like to use
> > dm-verity based code signing for userspace.
>
> hm... I am a bit confused. So, this patch can help the above
> scenario?

The revert I posted will allow us to populate the kernel keyring used
for dm-verity signature checks from pre-boot even if SB is off. Via
local or remote attestation during boot we can later validate this
chosen boot path, and hence can a-posteriori validate that everything
is OK even if the a-priori SB check is not done. But once we have
validated that we then have the key in the kernel keyring for later
dm-verity validations, which is all we wanted.

Lennart

--
Lennart Poettering, Berlin

