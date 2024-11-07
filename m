Return-Path: <linux-integrity+bounces-4070-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D377D9C0FE6
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 21:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC761F23A70
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 20:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA31F217F4A;
	Thu,  7 Nov 2024 20:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4U/K5R6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C7C215F58
	for <linux-integrity@vger.kernel.org>; Thu,  7 Nov 2024 20:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012174; cv=none; b=aytsP2WF2lYFuCloY5hu+nwleZxffP/RIzmgikxvgmTNzJxYlcgx+fP2/KJ6nWRPm7effFr6JYUU9Dv06o96F5Nc5Ad6AQF0PlW/fbd+IDAEBX/qvA661N5PpIkq57LCczBXXP5IYLQ2NNTehLckUIcXnuBcPz/Pst//PDuZkMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012174; c=relaxed/simple;
	bh=KrQCCJfz7dUV3gy5h1U+cUJGbzHq2+EkU7JJQHpAdCs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lHZk1H3U2O3aqdp11aPd8ug2go2sb05EjY7dFEtrEqL+kCl1x8jP4U3Gzdx91banDSQ9jQ6WDf1W4K2lwBgLjuh2NI9eAjYB1mBPjEzn4warEhjdknLoryOiKfyFxX/fb1X5712W1TdDJOafQx2pQQQifcLR5xpGXEVRUFSbexI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4U/K5R6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA528C4CECC;
	Thu,  7 Nov 2024 20:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731012174;
	bh=KrQCCJfz7dUV3gy5h1U+cUJGbzHq2+EkU7JJQHpAdCs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=m4U/K5R6S29asrdAWr3dng9CtYG/Q2I+/Fkvlgw5tXAgDQZu9De4UR/OKZnyTwRvU
	 4ZUPx8wzQB5EKFh/zbh/8YSK539usE8j1FWUSg4EtiZigPH1vhtCfudbnaqlFTGej5
	 F9mfeRbh/VzyOm5lsRVAJog65EvZWIqHdQi/WwFFggXuaQGhMnlvwmnO9FAX0h30GN
	 gm3elRQqbmLP+3tOBJm1X+jspDgUXPjKWUJQjYre4DUs/Fjk9WdFubhNyLJru2O56D
	 0Ws7afprabVy8QCQaG9IHAb5S0zNyykSTr2/jDEaZs3LVyEfDDa5JLG3AxAscfN7rV
	 8dGh3dtKjTdkA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Nov 2024 22:42:50 +0200
Message-Id: <D5G8LOUJ8VSU.929AI8NDTZKI@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <linux-integrity@vger.kernel.org>, "Andy Liang" <andy.liang@hpe.com>,
 <jenifer.golmitz@hpe.com>
Subject: Re: [PATCH] tpm/eventlog: Use kvmalloc() for event log buffer
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Paul Menzel" <pmenzel@molgen.mpg.de>, "Takashi Iwai" <tiwai@suse.de>
X-Mailer: aerc 0.18.2
References: <20241107112054.28448-1-tiwai@suse.de>
 <87f11490-06ab-43a5-8058-102722a3c3ba@molgen.mpg.de>
In-Reply-To: <87f11490-06ab-43a5-8058-102722a3c3ba@molgen.mpg.de>

On Thu Nov 7, 2024 at 2:17 PM EET, Paul Menzel wrote:
> Dear Takashi,
>
>
> Thank you for the patch.
>
> Am 07.11.24 um 12:18 schrieb Takashi Iwai:
> > The TPM2 ACPI table may request a large size for the event log, and it
> > may be over the max size of kmalloc().  When this happens, the driver
>
> What is kmalloc()=E2=80=99s maximum size?

For reference: https://elixir.bootlin.com/linux/v6.11.6/source/include/linu=
x/slab.h#L367

So it would be 1UL << 22 i.e. 4 MB at least. Not sure if MAX_PAGE_ORDER
is larger than 10 on x86-64.

BR, Jarkko

