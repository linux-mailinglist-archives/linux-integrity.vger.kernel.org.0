Return-Path: <linux-integrity+bounces-2836-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BD28FC553
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jun 2024 10:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BEA21F221D8
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jun 2024 08:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B5514AD0E;
	Wed,  5 Jun 2024 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJjtK90w"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7401922FC
	for <linux-integrity@vger.kernel.org>; Wed,  5 Jun 2024 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574690; cv=none; b=VfF2HpFWzBoo28OeusqFGDR6h8IrEimuuE3FwsG1D4tX0dRGkys18yhh5F6vctaJfafR2ZK80AuiM5gwPUW3swA11QepAC4Cu0Bfd9aIlUrsnuLWGpYg9KDRBmxOokmG9MKeqP1xp/IesnbtQml9A5YdQJeVvtJrWHrCk3sP/WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574690; c=relaxed/simple;
	bh=5ALkOcn8NPSHKv4/SEUapnC4KG6VH13x7tLJN3YOm+w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ofnrCa7/cw9ZN6pol1elWY2d+PnN9thn02TGkrF1hWYQQGsVUQ15r6GzXI3RUdMMJnEZVptmMUhj0HucAm2k/KYZuS3BBMyhx3Q4IYOXEpMiqluMjG17bMsznexUkmojrfy25xWCO57jgxYuGEf1VGspBX3XoZw+IR/xVOSeBnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJjtK90w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCA3C3277B;
	Wed,  5 Jun 2024 08:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717574690;
	bh=5ALkOcn8NPSHKv4/SEUapnC4KG6VH13x7tLJN3YOm+w=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ZJjtK90wTgtd64FEE8ruhK6urAJBoaOL7SvFWFcriAfGzk0lN7gL3hKwHiHjGE4kj
	 j0QWB2UxyaJxx6PrX5vHdPkwepbcfRRXJ63A0v+bxXSxNS7kwxIwSnaesaNNxt+KHK
	 pD3b4HoGobJGN+H2pEu28aVSEocG/ifq9WvUhovCw+Bi9+rV+HX0AFG22n5ZxRoEza
	 d5RPQRMgBKuYkVM2MKKqI2F6jbFobV9oiXmHJmRW63tYsWrrcnU7+AOlzAu9RfzN2O
	 CrvRBd5VcdacMzhDUuSiyxG9uNRGvQTisx2dnGcGzUGG+0f6BNRg/4jmZ3iadWfdof
	 IAdFOVpmXXGmw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Jun 2024 11:04:47 +0300
Message-Id: <D1RXEUIVLX4F.144PVD2JYNZ3M@kernel.org>
Cc: <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: tpm_crb: Call acpi_put_table() on firmware bug
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Joe Hattori" <dev@hattorij.com>, <peterhuewe@gmx.de>
X-Mailer: aerc 0.17.0
References: <D1RIRVZ2K03E.1JHL5XMMLN9JL@kernel.org>
 <20240605073329.1640668-1-dev@hattorij.com>
In-Reply-To: <20240605073329.1640668-1-dev@hattorij.com>

On Wed Jun 5, 2024 at 10:33 AM EEST, Joe Hattori wrote:
> Hi Jarkko,
>
> Thank you for your time and feedback on my previous patch.
>
> 1. Drop the hyphens.
>  - I have removed them from the commit message in the v2 patch below.
> 2. Wouldn't it be memory corruption, and not a leak?
>  - The validation_count field not returning to 0 causes
>    acpi_tb_release_table() not being called, which means memory is not
>    being unmapped. Therefore, I assume it is a memory leak.
> 3. Why would ACPICA return corrupted data in this case?
>  - It is mostly unlikely that it returns corrupted data, but it would
>    happen when the ACPI table is misconfigured by the firmware. Although
>    this event is rare, I thought it would still be nice to take care of
>    the error path.
>   =20
> Please find the updated patch v2 attached to this email.

Actually: no. And when you send a patch send them as separate entities
and version them [1].

And I don't believe you because I don't live in a belief system. There
is total zero evidence provided of anything.

And even if this was the case you should then submit the bug fix to
ACPICA itself, not here.

Thus, NAK.

Please don't waste everyones time by inventing imaginary problems.
It would be way more productive to solve some actual problems.

[1] https://www.kernel.org/doc/html/v6.9/process/submitting-patches.html

BR, Jarkko

