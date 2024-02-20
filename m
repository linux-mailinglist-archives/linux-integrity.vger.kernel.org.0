Return-Path: <linux-integrity+bounces-1302-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD0585C374
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Feb 2024 19:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7220B2530C
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Feb 2024 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C736C77A03;
	Tue, 20 Feb 2024 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3pmgEoL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2FE762EC;
	Tue, 20 Feb 2024 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452760; cv=none; b=ooOhSXb3JKcP+xDlnXFbpvc2zCfAjrJQshR9MzvvtskW2QEs90qswfSjW5doPfbxJnWba3j1boAy+5/ES1gRS7w4R+UKbgVtoneEs74f7y+dpsujfh3ChH8OXK1zDW/fa5O8J0TQElixzGO+P1AKw66By0yQz5Fo73DVIF/q0I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452760; c=relaxed/simple;
	bh=dhawpZTrANv0JFsuVpeapW+tVzNPo9GSiWB+4tW8h84=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=rXC9P2PNiEleQTgjzi/6I3fK5PaI8lAjUeNcnQ0KO/gluFmxy/mwkBwkKkG3idSuiw37mdla03QHXQJYPRenBkXBaMyxJQyT5Wwnc0BiSTE7R7lcHDTI7FP3Fx5kbO4YDexU2qeUvKvRp1HHJAt0H5XU7YZNfOyOPpp/kXJ/PFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3pmgEoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74316C433C7;
	Tue, 20 Feb 2024 18:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708452760;
	bh=dhawpZTrANv0JFsuVpeapW+tVzNPo9GSiWB+4tW8h84=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=M3pmgEoLcwb/ahgOEvhq0P/XHyzkbxD+b0rbPYoIjx3caUXBdvyBknj8QXFtphibH
	 6SfTXgLcPPxFDAADeEzSTR3IPFGX8XIo6OX/oNqKzA4r1/3XqEa82FTxXRKj569S46
	 fVxZ9Z9Lg8M80tN/3LzOf3xHCv+KWwPphbA+/aVW7CeJDs/oNZqHxIokDJILgpxK+A
	 Ww6mvxE4CI7fi/QoKwQRHjOXA/ZAWt8HIkbcGNY9IEirwGCK+3i0UfHDDI8KZga/l5
	 WCHHui/5SQ2bz8iKJwvDOK0gCua0+Z05wZeReDrgIruILiorw1Qe24WFc/R7rZNLhY
	 +D9WovKUznYSA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Feb 2024 18:12:36 +0000
Message-Id: <CZA3YHCSBQK1.F170HT9T3WG3@seitikki>
Subject: Re: [PATCH v2 0/4] Add missing TPM compatible strings
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Lukas Wunner" <lukas@wunner.de>,
 <robh@kernel.org>
Cc: <devicetree@vger.kernel.org>, <linux-integrity@vger.kernel.org>, "Peter
 Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>
X-Mailer: aerc 0.15.2
References: <cover.1705140898.git.lukas@wunner.de>
 <20240220105536.GA4555@wunner.de> <CZA3STK007KM.2GLEAARLXBLBH@seitikki>
 <CZA3VUBEAZH6.27GXSQ9FDIIA6@seitikki>
In-Reply-To: <CZA3VUBEAZH6.27GXSQ9FDIIA6@seitikki>

On Tue Feb 20, 2024 at 6:09 PM UTC, Jarkko Sakkinen wrote:
> On Tue Feb 20, 2024 at 6:06 PM UTC, Jarkko Sakkinen wrote:
> > On Tue Feb 20, 2024 at 10:55 AM UTC, Lukas Wunner wrote:
> > > Dear Jarkko,
> > >
> > > since v6.8-rc6 is approaching and the end of this cycle is thus in si=
ght,
> > > please do not forget to merge this series:
> > >
> > > https://lore.kernel.org/all/cover.1705140898.git.lukas@wunner.de/
> > >
> > > All 4 patches have a Reviewed-by from you and patch 1 has an Acked-by
> > > from Rob.
> > >
> > > Thanks,
> > >
> > > Lukas
> >
> > Thanks for reminding!
> >
> > Since this patch set only has DT changes and zero actual TPM driver
> > changes, I think it would be better if Rob picked this.
> >
> > Rob, what you think?
> >
> > I'm good either way but need to check.
>
> Ah, sorry I was looking at wrong lore link (had multiple tabs open).
>
> I will definitely pick this despite one DT patch. Rob, please ignore.
>
> Sorry for causing confusion.

OK, should be good now:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/=
?h=3Dnext

BR, Jarkko

