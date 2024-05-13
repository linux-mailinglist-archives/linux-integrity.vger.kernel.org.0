Return-Path: <linux-integrity+bounces-2368-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B7E8C410E
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 14:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D881F22DD1
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 12:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A775F14F9D7;
	Mon, 13 May 2024 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tIPcgE+l"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DED314C5A3;
	Mon, 13 May 2024 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604797; cv=none; b=tZ8vv24gSKQMfGzExoreBmy/txjyuhcaGsMFXAEu8p4ZSgto0Np7DgdTPoYr0ZeXZ+et5nlY5PV3dHfZGKHAs6EpBCLhEuDbys211HCqybuKtSuxagS9O70DHnBfE6Y+T/nYLq2Z04pGIKjkKAvn1S2xGehrh6bDgG6dzSy9lA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604797; c=relaxed/simple;
	bh=8bkkbkRkMtHeGtx/q1XYfdnXfjo5YYKtbt2tSjRiBYo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q2tKykPBhb2SQ7w1C+++8I+cIFhJDZSrVFy3707g2OtEagvpXm3L4eK87aa26mdtj2zERcb+uEGhOm/IM3DYU4IsK19ip9zgXFdOt5hCucZzxsDKvdN+i9icAnSBSvr3FftBkNvd+doQICWnCEdvGMx85grBzr4GyV+0Fc4Sso0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tIPcgE+l; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8bkkbkRkMtHeGtx/q1XYfdnXfjo5YYKtbt2tSjRiBYo=;
	t=1715604796; x=1716814396; b=tIPcgE+llQTThOuMOnayQFnJgv93Wyr/m3thMFFaf/l6mZ1
	KA5ie0be39IgSF3hxKROFtLr6LxtKWjwJSmN9jrOQ82duhDstfRxQs6VwbK2VoqP6iFT9mwgL8pBo
	bSpUrCYsSx+cHae1N5sgXeeujfmeBnaykhI8fpRUkCk6Y40nLVcmBhzAEMPa05YOFDhd26Xg5Ag2q
	AXYixoMCZ04+KzatReLMHpB/QqHLfCPSfrPkg5m1emp9gcow9JYh2R+Dh9v1PJmQ8tFZRoPdQK2dQ
	84hUj+EJOjcMAbfCUiJcxjE0EOv+PJyXj73PfGapo8TxEOvpNcKBJ0iifxLvlaYQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s6VAo-00000002HEm-0LUs;
	Mon, 13 May 2024 14:52:58 +0200
Message-ID: <f88384a305b90708db3b30012f9edf09690dc5ee.camel@sipsolutions.net>
Subject: Re: [PATCH] arch/x86/um: Disable UBSAN sanitization
From: Johannes Berg <johannes@sipsolutions.net>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Cc: x86@kernel.org, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org,  zohar@linux.ibm.com,
 linux-integrity@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Mon, 13 May 2024 14:52:56 +0200
In-Reply-To: <096121b3e74a7971b5e6a3d77ca8889380de1885.camel@huaweicloud.com>
References: <20240513122754.1282833-1-roberto.sassu@huaweicloud.com>
	 <d4f4666bf745e83ea00b466b7a7cfb5132b8c7b9.camel@sipsolutions.net>
	 <096121b3e74a7971b5e6a3d77ca8889380de1885.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-05-13 at 14:42 +0200, Roberto Sassu wrote:
> On Mon, 2024-05-13 at 14:29 +0200, Johannes Berg wrote:
> > On Mon, 2024-05-13 at 14:27 +0200, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >=20
> > > Disable UBSAN sanitization on UML, since UML does not support it.
> > >=20
> >=20
> > Luckily, that isn't actually true, nor does it actually do this at all.
> > Please fix the commit message.
>=20
> Thanks, I was actually wondering. I based that statement based on
> ARCH_HAS_UBSAN=3Dn.
>=20
> Any other solution would be ok.

Not sure I get it. What you're doing in the patch is perfectly fine and
almost certainly required, but you're definitely not disabling UBSAN on
ARCH=3Dum as you described in the commit message?

johannes

