Return-Path: <linux-integrity+bounces-4086-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9E69C61CF
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2024 20:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E690CB873C0
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2024 18:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CCC2144DD;
	Tue, 12 Nov 2024 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzp8TFWI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D0021442E;
	Tue, 12 Nov 2024 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434262; cv=none; b=bvPVplfK3iVuoIyUjfLA2hxZp3w7giB+4f+2rb97V6b1ZNXBv50vd65YFWd8PbywXkH93aGZxoqOX1Zleh5LrSFxhlMRwiPv5ch110SP6Bldc+0lJn5q5vYy/tMSrNpL2GEZDcmYTrZ5luGekphidcSVBcIEwetfk+wBs6nom9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434262; c=relaxed/simple;
	bh=1URpfIrCXwUDp20J+85VGQv7B1uElnbl53FjCZonyuU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tghjhhlh79DypIZNxH7EvsYIR1eyA4EwQvMEdKb6FpBHS6eYX7PCWLFxYEbyqPSeWXd975/JmHg2Ccvouv7hPAOVBiBKvsQT3tlHh4maVJeF7ufVVVD84jX2l+Lre9fmrZZpebKq3ZswBQg0PjppzaILA7p5yD5tle6rL+1wbRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzp8TFWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B00DC4CECD;
	Tue, 12 Nov 2024 17:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731434262;
	bh=1URpfIrCXwUDp20J+85VGQv7B1uElnbl53FjCZonyuU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=uzp8TFWIFln5YzU8/cX9CtUrWs5/n5PMJb84/N0vbWt9G2svGTOsIS6sPvrWSf3aU
	 NRzhnS9uXgiQJpr6qWxBRSt+i0qynR4FxOg6xKI+wZDs2bTEsU3RAp9IcopSU/OCan
	 Ej97IxAi+iT1N1J/5O0tjEcTzj0cCvyh2cT5RfcKV5s60VDlMtm+/vJTJkGn3k2GUb
	 5MuuIlMe8zAxOIllEesaN1NwDjEeySr7nZovPNksQUKp4now4Bazi1ffDLtpUA2aw4
	 hjX8lqRp2oo5M8ptdAJhIcG6AxznFK96TR938ddqFz1f1W93x02NI9gg9+AIq49gF7
	 IdCmW06ypgxQQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Nov 2024 19:57:37 +0200
Message-Id: <D5KE7X6LMR5Z.AA8PPWDBPQP7@kernel.org>
Cc: "Roberto Sassu" <roberto.sassu@huawei.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: Opt-in in disable PCR integrity protection
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mimi Zohar" <zohar@linux.ibm.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>
X-Mailer: aerc 0.18.2
References: <20241107095138.78209-1-jarkko@kernel.org>
 <76d9ae11c339b589a8ec94f010e7439b7ce7d283.camel@HansenPartnership.com>
 <D5FZT0QPHL0O.231WD6VUHC48X@kernel.org>
 <10296fd8b0fcbf1d813577ef41738ffea12b70d1.camel@HansenPartnership.com>
 <dd51366e50de86e8a6002f2f53801c53a9b770f3.camel@linux.ibm.com>
In-Reply-To: <dd51366e50de86e8a6002f2f53801c53a9b770f3.camel@linux.ibm.com>

On Mon Nov 11, 2024 at 9:53 PM EET, Mimi Zohar wrote:
> > The original open coded the empty auth append with struct
> > tpm2_null_auth since it's the only user.  However, since we do have
> > another user in trusted keys, it might make sense to consolidate.
>
> Instead of delaying the current patch from being upstreamed, perhaps this=
 change
> can be deferred?

Yes.

BR, Jarkko

