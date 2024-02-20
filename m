Return-Path: <linux-integrity+bounces-1301-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 993A085C35D
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Feb 2024 19:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A719B22C64
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Feb 2024 18:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DA177652;
	Tue, 20 Feb 2024 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+bzpiCI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961F46D1A8;
	Tue, 20 Feb 2024 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452553; cv=none; b=cFzx2lQWwzXKaLON/qHCaBJpyuRxv8iRfIxP/KEjZMoMd+FL1IdNmzmMsXuGEqScRLpvK/FSNN+fAkf5Xrvoz9V0RQKR5nqTPyUlhx3kAp2ju0EwaoXrWHYfCZrLEsXCM8yH+d2dwzsCEJxjzsGvGpg69Q9Pk5PZ6UI+Cu+OTDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452553; c=relaxed/simple;
	bh=p1J4omeR7L/sbe0nw4cb1G8aiyg6EHnf5Hri3g7YDI4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=A4szuJVGRqn0oTtL/G/rHPDoMAJI8ogn7mA9+IXB33xlSq3cEiDbd41xWI+6TaDdleoCjVDfVhQype9JsbMjnj9uEANpPWOwSfFF2cpqqlZWL6elj4VcLyvqoqDU3ZdhaogdXyzT93tei8GlSfSnwUoa8evQCGWwGajpwhWF+JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+bzpiCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD210C433C7;
	Tue, 20 Feb 2024 18:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708452553;
	bh=p1J4omeR7L/sbe0nw4cb1G8aiyg6EHnf5Hri3g7YDI4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=U+bzpiCIurB6gZIb1U0R2WWptgaVV8YIi7xNUvp+8zi69rOT1+IimNvD2/PQtu37I
	 OExpD4FQmnfXrOoPjEhNIs8Y+HQiFlc9fyjpwMdd6rvGqAR72iuOziiPkugc2OWu6b
	 FtP2hPjlF4Wab3z/Z2iGvtQaLECuG9t4jg6MTE52obLQE7fjcoM6SAQ0RMDXj1IGvb
	 ldCXX9ZjSWkIpzQJIQFTnFNrtCmmvwb5xVldLVkUQb1+EL7XsX6HLNWoIzLhNJIy91
	 msKHTS4udHdQg/maYP8RA8s72UEbFqGpZv+2xPSJ4OzAD0Kq0lYpibJIH5HvQOUytL
	 hZNlPcto/RAkQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Feb 2024 18:09:09 +0000
Message-Id: <CZA3VUBEAZH6.27GXSQ9FDIIA6@seitikki>
Subject: Re: [PATCH v2 0/4] Add missing TPM compatible strings
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Lukas Wunner" <lukas@wunner.de>,
 <robh@kernel.org>
Cc: <devicetree@vger.kernel.org>, <linux-integrity@vger.kernel.org>, "Peter
 Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>
X-Mailer: aerc 0.15.2
References: <cover.1705140898.git.lukas@wunner.de>
 <20240220105536.GA4555@wunner.de> <CZA3STK007KM.2GLEAARLXBLBH@seitikki>
In-Reply-To: <CZA3STK007KM.2GLEAARLXBLBH@seitikki>

On Tue Feb 20, 2024 at 6:06 PM UTC, Jarkko Sakkinen wrote:
> On Tue Feb 20, 2024 at 10:55 AM UTC, Lukas Wunner wrote:
> > Dear Jarkko,
> >
> > since v6.8-rc6 is approaching and the end of this cycle is thus in sigh=
t,
> > please do not forget to merge this series:
> >
> > https://lore.kernel.org/all/cover.1705140898.git.lukas@wunner.de/
> >
> > All 4 patches have a Reviewed-by from you and patch 1 has an Acked-by
> > from Rob.
> >
> > Thanks,
> >
> > Lukas
>
> Thanks for reminding!
>
> Since this patch set only has DT changes and zero actual TPM driver
> changes, I think it would be better if Rob picked this.
>
> Rob, what you think?
>
> I'm good either way but need to check.

Ah, sorry I was looking at wrong lore link (had multiple tabs open).

I will definitely pick this despite one DT patch. Rob, please ignore.

Sorry for causing confusion.

BR, Jarkko

