Return-Path: <linux-integrity+bounces-3807-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D266599CA40
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Oct 2024 14:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D88E1C22596
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Oct 2024 12:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162FA1A4F15;
	Mon, 14 Oct 2024 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I41N0DdH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC36E1A4F10;
	Mon, 14 Oct 2024 12:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728909252; cv=none; b=hhLdz05tbGqrXXPuIa2O7Nm6lYyqYGC1W9Yfh7hd+nxaHpFP2QKTmr8apvfLwWZw95NJq6e6tNGeJmkm8J3WQ3iU8hArJoXcBvxtal40BfG/6znpk+2S95/znxPnBRwI3rVRaJJ3gDelHMkAgV1uiUIrdFGsf195m9TBlxlvjog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728909252; c=relaxed/simple;
	bh=yYnAivK73L7gKzj0xaqZ+Y2uKFJApvzjgUE2Xh9orgc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RWGxtfaNr4p2cc0nc6l9kaN0l7J3+GAbFWKgPWaGG3XO5U27A3yAo/NW/Cby6T0Y7BKPPIDczHlAFQOghELHTFBfmrxKhKWcT7s6oLhCYDnbpPlBt8P0Nt6tk7n3skJ7wHtUYko28rw1peWTzSvuXAE5bz94ORUXtbHyRTan5/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I41N0DdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0811BC4CEC3;
	Mon, 14 Oct 2024 12:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728909251;
	bh=yYnAivK73L7gKzj0xaqZ+Y2uKFJApvzjgUE2Xh9orgc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=I41N0DdHm5dk52jktTT1+e67HTDyMmxCclVQ5dTxI5mynYWlyNK9j2ZzlpfdSIngn
	 W991OlpdW3e1Ly2p6WeLIQ+uh4GwkwC8NvaVPx85JPtUxqmbLcyhf8d2nTVE9hwnhu
	 aJbZ47lVgsrTrxSo3M5HEDcut8kegMS//hC/yTF9+wrWe3GEbUgbVPaUAiIR3geKgn
	 auf1LSyAkYqd0AENjRUV4AL/UgzfxwKOpgmLILwB/LJXBnP6WcuafZiHbW97Y7fmY3
	 u3XywbeygH4PFE/CqquDbrxtxlC01BxMUppjfDpPczxBPDKdx79/kez62cQGXsI/lr
	 Y3JuxK3e/a90Q==
Message-ID: <64710fe1db1432ca8857ec83fff4809ab1550137.camel@kernel.org>
Subject: Re: [PATCH v5 0/5] Lazy flush for the auth session
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
	 <roberto.sassu@huaweicloud.com>, linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, roberto.sassu@huawei.com, 
 mapengyu@gmail.com, David Howells <dhowells@redhat.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
 <serge@hallyn.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe
 <jgg@ziepe.ca>, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Mon, 14 Oct 2024 15:34:02 +0300
In-Reply-To: <04dc04872f2925166f969b43852161d468ee899a.camel@linux.ibm.com>
References: <20240921120811.1264985-1-jarkko@kernel.org>
	 <f69e08167d8354db31013018edf064a2876f8d1c.camel@kernel.org>
	 <21b46f4882f0b9b12304d7786bd88f33a7ad2b97.camel@huaweicloud.com>
	 <a0068539450a81fdd363d078521cb3822c54608b.camel@kernel.org>
	 <e70c55c6edea2a5be7786ee04a85778193237444.camel@kernel.org>
	 <04dc04872f2925166f969b43852161d468ee899a.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-14 at 07:45 -0400, Mimi Zohar wrote:
> > > For server/IMA use case I'll add a boot parameter it can be
> > > either on or off by default, I will state that in the commit
> > > message and we'll go from there.
>=20
> Sounds good.

But only after this patch set lands. I gave this a thought and since
this patch set is specifically for a specific Bugzilla bug that it
closes, I have no interest to increase its scope.

>=20
> >=20
> > Up until legit fixes are place distributors can easily disable
> > the feature. It would be worse if TCG_TPM2_HMAC did not exist.
> >=20
> > So I think it is better to focus on doing right things right,
> > since the feature itself is useful objectively, and make sure
> > that those fixes bring the wanted results.
>=20
> Are you backtracking on having a boot parameter here specifically to
> turn on/off
> HMAC encryption for IMA?

I'm not really sure yet but obviously any change goes through review.

Also fastest route is to send your own RFC's to IMA specific issue.
For me it will take some time (post this patch set).

>=20
> Mimi
>=20
>=20

BR, Jarkko

BR, Jarkko

