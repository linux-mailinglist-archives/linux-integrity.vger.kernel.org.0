Return-Path: <linux-integrity+bounces-3824-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EA099FB1B
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Oct 2024 00:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 755E1B21E83
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Oct 2024 22:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE241D63C5;
	Tue, 15 Oct 2024 22:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWyfb1yN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AF01CEAD3;
	Tue, 15 Oct 2024 22:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030467; cv=none; b=DmDFMXw0noTHEHZrzyopfP8aofSE9IDaMrfYd2Yf0h0ZpeqeUInnk0QSXgzbkk1hqGH+A4btl59oOwIrvAq38tSQv0rsMRvVoO8DWlMEefglWgUL+p/R9QArZrJwJCNbg11I6T9a8Ih+AIpdLQU9lKJALSiTwrYtn974FLOzMH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030467; c=relaxed/simple;
	bh=KVI17gbRn/XiNvHg57UmIBJR1zSXb183qGcnq/PSnFY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=C2qtW0jtSZGqnytrv/s6vfu18roJY7tsgxZWMUtIPlNJVJf5si/S9ISe/XLEyrYIfiZsMml3x8veqVUDo8/Uh5LMqAyBiFSaSqsA1X1puLT8ypIyVpvMfJBc2fGTgsUQQ7Dt+bp9NgCGnqmbGpKgyei9K5XF/NNMdg2tdtaUB7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWyfb1yN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A624C4CEC6;
	Tue, 15 Oct 2024 22:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729030466;
	bh=KVI17gbRn/XiNvHg57UmIBJR1zSXb183qGcnq/PSnFY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=TWyfb1yNtLs/bZiJMLn9sLOsR12Az7fmc9HWm7JUASMma8z/e7WSh5Iy2Yt+WoR5H
	 z2/mXgj2uYN7QLdk1si4FOmDxywvpHDEryRlHIAp6fudSWmbJ4J61ItSdVOpD/EoRz
	 hdqtrFGHhbeqNCvvcpn98moS3UjH8RrYtL7v3igorvs09nl1IaH09+Pv3oSlYC7fZl
	 uhQIRx9ltk4FG8YFMOODfJbWnR8aBlp7A3gL/ryQ+1Y3V1RTgj+deTiUfQeSwv9kks
	 jK5cYVScwexhQ38jSJDYQYngOMRa8en2W4UlAHMklLnB4ViaD7+OXRhzDVbUBiF4Qc
	 f+xX/pB5qwCvA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Oct 2024 01:14:22 +0300
Message-Id: <D4WQ58T5O21X.CGFKGFKV630K@kernel.org>
Cc: <James.Bottomley@HansenPartnership.com>, <roberto.sassu@huawei.com>,
 <mapengyu@gmail.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/5] Lazy flush for the auth session
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huaweicloud.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20240921120811.1264985-1-jarkko@kernel.org>
 <f69e08167d8354db31013018edf064a2876f8d1c.camel@kernel.org>
 <21b46f4882f0b9b12304d7786bd88f33a7ad2b97.camel@huaweicloud.com>
 <a0068539450a81fdd363d078521cb3822c54608b.camel@kernel.org>
 <e70c55c6edea2a5be7786ee04a85778193237444.camel@kernel.org>
 <04dc04872f2925166f969b43852161d468ee899a.camel@linux.ibm.com>
 <64710fe1db1432ca8857ec83fff4809ab1550137.camel@kernel.org>
 <036746bc4e37ff10a18b5fdffd6fdee561dd5bfe.camel@linux.ibm.com>
In-Reply-To: <036746bc4e37ff10a18b5fdffd6fdee561dd5bfe.camel@linux.ibm.com>

On Tue Oct 15, 2024 at 11:08 PM EEST, Mimi Zohar wrote:
> > > > since the feature itself is useful objectively, and make sure
> > > > that those fixes bring the wanted results.
>
> The right thing would have been to listen to my concerns when this was in=
itially
> being discussed.  The right thing wasn't enabling TCG_TPM2_HMAC by defaul=
t.

This is debatable as for laptops and desktops having hard drive
encryption do benefit with this. If systemd hadn't added
systemd-cryptenroll I would agree with this. I learned about this
feature two years after its inception in that project, so we needed to
address this as a priority (I did not and will not follow systemd
development proactively, as don't have time for that).

I feel more safe using my laptop with the feature in place at least.

Besides, it is complicated feature enough that it would have been
impossible ever "zero glitch" land it. I don't think there is any
rigid "data centers first" rule really, except maybe for those
businesses that run data centers (and I'm not one of those
businesses).

BR, Jarkko

