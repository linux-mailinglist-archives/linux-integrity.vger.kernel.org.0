Return-Path: <linux-integrity+bounces-2370-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 120648C416D
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 15:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E141F245DC
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 13:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D6C152165;
	Mon, 13 May 2024 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="flRn3mXZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CE6DF6C;
	Mon, 13 May 2024 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715605731; cv=none; b=MlH1gvueAWKip+cTrmfK1a84+sPpi4Q302TpBxI76xf9CQKgy8F6UGuzc6x69fKZ1NC2H5gAYoKRDQItZra5RcdYEdH66ro4OGv/BXObxMK9dQaaHg17qVFg27zsmMgSFMaPlScBHmJgxbNtVy0afdLYWyKoPVeNAiAnh4Yhmf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715605731; c=relaxed/simple;
	bh=zoSxVBCVN+gkwt4Gp0eaYQXVfaorf0WQt7DhqdHnm2c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XuoI8sKAyfO4TtSMSO3B9IjT9I4ATzr4Zg+e9mnkaD9k9WzVP8L/mTpGrR1iurTsR0wknp596EArI/y9aDx3QZY9RWUzdDWRYiyBBe6KeeJP5ZucirplaIsC86DUHUdYynHr8IG9U600HYeFITThzxDSQVNZNjT0PDEUa9fmFP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=flRn3mXZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zoSxVBCVN+gkwt4Gp0eaYQXVfaorf0WQt7DhqdHnm2c=;
	t=1715605729; x=1716815329; b=flRn3mXZiejYyJXcHhi6iCknEDNovmuCCT9UeWelz/lZF5h
	H29WY6QKlt/mYp400YZbS8+tyV/y/+GtqrSV4jQ1eC0xgJ9G8uKpRJFe6tsryf7WWaQh4saapqWr8
	OUv+ZxLJH2L+Zb4K9AZ6zaCmLms0aasIgvE2LcEmZ3semzjPT8KzaVT3YZ+hRZkXL0uqyxNGlQqHM
	N4e2zhWvfclmRw97KKAfEZyNzWhkj3E7t8BbLuGz32nQ0bBN5khO9LvFMP62ncdEpwrIn6DOJkjsL
	LZZ6lYri1masynJFV2FkVv1SDG6WXi+vKP4mEIWfumR3sdbV3ZrJn+C+joYr6uqw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s6VPs-00000002HwD-0hyI;
	Mon, 13 May 2024 15:08:32 +0200
Message-ID: <d4f9861effd64c155f93cc712d2c7660b1cf2e4a.camel@sipsolutions.net>
Subject: Re: [PATCH] arch/x86/um: Disable UBSAN sanitization
From: Johannes Berg <johannes@sipsolutions.net>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Cc: x86@kernel.org, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org,  zohar@linux.ibm.com,
 linux-integrity@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Mon, 13 May 2024 15:08:30 +0200
In-Reply-To: <dba181a54e76ba2916ecd4747f76e40e6fbbb757.camel@huaweicloud.com>
References: <20240513122754.1282833-1-roberto.sassu@huaweicloud.com>
	 <d4f4666bf745e83ea00b466b7a7cfb5132b8c7b9.camel@sipsolutions.net>
	 <096121b3e74a7971b5e6a3d77ca8889380de1885.camel@huaweicloud.com>
	 <f88384a305b90708db3b30012f9edf09690dc5ee.camel@sipsolutions.net>
	 <dba181a54e76ba2916ecd4747f76e40e6fbbb757.camel@huaweicloud.com>
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

On Mon, 2024-05-13 at 14:58 +0200, Roberto Sassu wrote:
> On Mon, 2024-05-13 at 14:52 +0200, Johannes Berg wrote:
> > On Mon, 2024-05-13 at 14:42 +0200, Roberto Sassu wrote:
> > > On Mon, 2024-05-13 at 14:29 +0200, Johannes Berg wrote:
> > > > On Mon, 2024-05-13 at 14:27 +0200, Roberto Sassu wrote:
> > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > >=20
> > > > > Disable UBSAN sanitization on UML, since UML does not support it.
> > > > >=20
> > > >=20
> > > > Luckily, that isn't actually true, nor does it actually do this at =
all.
> > > > Please fix the commit message.
> > >=20
> > > Thanks, I was actually wondering. I based that statement based on
> > > ARCH_HAS_UBSAN=3Dn.
> > >=20
> > > Any other solution would be ok.
> >=20
> > Not sure I get it. What you're doing in the patch is perfectly fine and
> > almost certainly required, but you're definitely not disabling UBSAN on
> > ARCH=3Dum as you described in the commit message?
>=20
> Ok, I guess the right word is instrumentation (got it from commit
> d4be85d068b44). And the reason is that the vDSO is executing in user
> space. Will fix it.

No, UBSAN is fine, but you're only disabling it for the vDSO :) The
commit message doesn't even mention the vDSO though.

johannes

