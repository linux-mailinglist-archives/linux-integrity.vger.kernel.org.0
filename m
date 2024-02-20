Return-Path: <linux-integrity+bounces-1300-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B48F85C358
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Feb 2024 19:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE711F228D4
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Feb 2024 18:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8053779F8;
	Tue, 20 Feb 2024 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEvbezhE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C657602B;
	Tue, 20 Feb 2024 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452407; cv=none; b=pyB1AaTswo85dspyrO9jsgGsaf0rygIeD+/YoOI5uUi48vB/qa7pnthr0DoYw56qbLLHBNKP9zdsLZhD0k4NpcKbmF2l/x87wFwHFytOMTWRjANwF69IGLkssTTM5wb/gl4aQ8LmKJl3oBZLHH18PZnDKRX6me13/2BBnOvIHT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452407; c=relaxed/simple;
	bh=LPrpXLHqe4UXA0SOtgNgHEqOcj7pbqm/Xyphpzkf9dM=;
	h=Mime-Version:Content-Type:Date:Cc:Subject:From:To:Message-Id:
	 References:In-Reply-To; b=ITcpVnuME/FFIUQZrwV8zS6m9f2q9Hm/Uylm4zwpCQrqvMwD4ow/hk15SFQSVwegZwx5NWsEWD0ARxJWwUY3AFos/H9+j1YLW7cFAGnjydqLfNlAtZmGBYoME49XiBhr4G3252bGvj5VMeXabkeXsOJEMEt0wefVKlVxz1VGH/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEvbezhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2EDC433F1;
	Tue, 20 Feb 2024 18:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708452407;
	bh=LPrpXLHqe4UXA0SOtgNgHEqOcj7pbqm/Xyphpzkf9dM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=BEvbezhETqlvoxDBJw9bdtOnfRq7BrDJSgwLa/uGfUBset97h0us+8Moi79OonQVc
	 kyFptyKrvran1ntHrwaOveQ+OqA+2xaFxa9PSM+9seEqfxMAoKgSNvOPFy404+LLRQ
	 5UC42AUSrDSvWGuqYMW2UGmSOBk3TFWc4mFfpueZOaUJYxKnctja3CTI+nk+o12mOl
	 5NRF3jG0jPAv+X+5AUiyH5rJcVgfwTBnQL/CuI+znUqZyFJpeSZmk1lPlrO50aynpP
	 EgAYeJhlFq5fZ350ADoXV3Q8CM4DQFBmzOJNIArkvAgYtH+2dbbciLltOpLtsCZMj5
	 OHFJH0+51EHMA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Feb 2024 18:06:44 +0000
Cc: <devicetree@vger.kernel.org>, <linux-integrity@vger.kernel.org>, "Peter
 Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>
Subject: Re: [PATCH v2 0/4] Add missing TPM compatible strings
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Lukas Wunner" <lukas@wunner.de>, <robh@kernel.org>
Message-Id: <CZA3STK007KM.2GLEAARLXBLBH@seitikki>
X-Mailer: aerc 0.15.2
References: <cover.1705140898.git.lukas@wunner.de>
 <20240220105536.GA4555@wunner.de>
In-Reply-To: <20240220105536.GA4555@wunner.de>

On Tue Feb 20, 2024 at 10:55 AM UTC, Lukas Wunner wrote:
> Dear Jarkko,
>
> since v6.8-rc6 is approaching and the end of this cycle is thus in sight,
> please do not forget to merge this series:
>
> https://lore.kernel.org/all/cover.1705140898.git.lukas@wunner.de/
>
> All 4 patches have a Reviewed-by from you and patch 1 has an Acked-by
> from Rob.
>
> Thanks,
>
> Lukas

Thanks for reminding!

Since this patch set only has DT changes and zero actual TPM driver
changes, I think it would be better if Rob picked this.

Rob, what you think?

I'm good either way but need to check.

BR, Jarkko

