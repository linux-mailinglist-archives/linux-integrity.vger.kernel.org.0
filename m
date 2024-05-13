Return-Path: <linux-integrity+bounces-2366-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D908C40C0
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 14:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566371C21125
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 12:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00F914F9C8;
	Mon, 13 May 2024 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lHGxvWhz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F51114F103;
	Mon, 13 May 2024 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715603407; cv=none; b=AY9BFYXFiAD8+6lT/EaLwSRGz8rriD/Mv0qLJ+XrQt02M92zPjhw54kiJEmcCTK7FFH/OILhNTFG5M+3m8cQMK2S6yUOmFxH+DmygmxFj/QsyspkWLkm6LH7JeLbHYXO8f8jbj9EM/n4YTg3J1nPGjnYlJm1rW5Riaw1CDpUBV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715603407; c=relaxed/simple;
	bh=klDLt6cTPVK6ApU/9oChL0NQAOp316WjTDRHsPK3g+c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ea+xZLQoWU6x366y4s1GJKbWWIEghOve8IlqoiikqO+SlhRiPeo+mI0N50SmuRw97lSf8GK5pCFVQatlHhYC3LvYdjQpZgUiLGnDaMkU46sTAkXS8pL/jGJR9EFJ/VHgQI1wA4jaxFbgWJMWxFS+BGFMswEN3YI84nwl1M07F9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lHGxvWhz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=klDLt6cTPVK6ApU/9oChL0NQAOp316WjTDRHsPK3g+c=;
	t=1715603405; x=1716813005; b=lHGxvWhzWk1gL1p3kmwyuYcplclO86S/PGyo1kdD28Hkiof
	6kt322e1ui7hDHzecxNaf4uGNCPdKHgVBU3eCOMXtMBKa7tsUv1kvVEjdZH/7t9LlHjL+4YEZC8qu
	gGLSsB4etvrh2p12Qhm/1y0PqEc4kD6PiBCHBcGZ/gdw8MsJgaXiNHqlwz3nL4hWSJe/vdDTTnyzh
	qrDPs3PuEhHl5PZaceBnIFYGRBtKylpLz2nNqhhB82qnHk/OUweVbEpEtvF+Dk5Fz3k0pxYIzi2dq
	FIrJFtHybwPZLsSjTFFJ3bfbCuEqBt4jytH6uIpYE61eE/LGBUiMQLv1saPvAIJw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s6Uo9-00000002G9H-0idr;
	Mon, 13 May 2024 14:29:33 +0200
Message-ID: <d4f4666bf745e83ea00b466b7a7cfb5132b8c7b9.camel@sipsolutions.net>
Subject: Re: [PATCH] arch/x86/um: Disable UBSAN sanitization
From: Johannes Berg <johannes@sipsolutions.net>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Cc: x86@kernel.org, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org,  zohar@linux.ibm.com,
 linux-integrity@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Mon, 13 May 2024 14:29:31 +0200
In-Reply-To: <20240513122754.1282833-1-roberto.sassu@huaweicloud.com>
References: <20240513122754.1282833-1-roberto.sassu@huaweicloud.com>
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

On Mon, 2024-05-13 at 14:27 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Disable UBSAN sanitization on UML, since UML does not support it.
>=20

Luckily, that isn't actually true, nor does it actually do this at all.
Please fix the commit message.

johannes

