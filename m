Return-Path: <linux-integrity+bounces-4574-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EA8A12ECC
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jan 2025 23:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995753A595A
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jan 2025 22:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90611DD0D4;
	Wed, 15 Jan 2025 22:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ep/p2WaH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEA01991AF;
	Wed, 15 Jan 2025 22:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736981834; cv=none; b=RTYuwiDM0rtX6kkfs/V1tuvow8bYTpGdN8+7IlOUOshBEHEXn2se1hmK2sWqyYToIM6ATdyPmxQOP7eTv6xEZhk8nI3V9s7YDPV8zEtjw2d5XxD71Rl6EFtMIziLHC/7BA3vt3YM2lYq0C7i/VA6+foqTeEpRlqhQL+LF9xYSnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736981834; c=relaxed/simple;
	bh=mYB9Gt0BsmQrA7uaueijExQDwc5lV4ChkIz6jqeaTCE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=EdNAU68DulIWXEhwv+kRtkwN0QBNQlu6W+eUmjODiGwioTvy17ILbY2hM3Swcx2voRw3h67KBlHkeNBwOku3NCr+eA3gxIVXEQ+0DBoYlP7pe3yldm70qwZbgLvWyiYO6bE43ndkpPv/R5+yy1tL8ERmERNST7iigmegCm2dypI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ep/p2WaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898E2C4CED1;
	Wed, 15 Jan 2025 22:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736981834;
	bh=mYB9Gt0BsmQrA7uaueijExQDwc5lV4ChkIz6jqeaTCE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ep/p2WaH5RQYWtwgggQkxdbHcLWnO63pRI2WHnvERRPkx4hBP8q46ohCdxo146nFg
	 R5l/Qxz5gNm4DTWX0cTh46R4qIDGpgN3ddkI74CrsQ90CtxuLMtyu302ineIYzI4vX
	 S3+y6Yq78ltAeJEeA/8ry9GNbc9bKaLFKqQWXjTgRGH6/IAEhJXXXdj0A26OBYbkBW
	 SYZ8RU+MiJUnT47H/38LgtmIKSbSDVHvw6sidbEUQUuJf1h4XoIbMyEhFQXaq3q/3h
	 ybttAOotkZoNt250J9cLYGXntdv6BzJbGZv4cFlEp8IIcDBUs+eDwTsfCM61OfKYxI
	 sfRYLsYsyn5PQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jan 2025 00:57:09 +0200
Message-Id: <D730O4K9L593.1CJKTW6NO6TUB@kernel.org>
Subject: Re: [PATCH v9] tpm: Map the ACPI provided event log
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Colin Ian King"
 <colin.i.king@gmail.com>, "Reiner Sailer" <sailer@us.ibm.com>, "Seiji
 Munetoh" <munetoh@jp.ibm.com>, "Kylene Jo Hall" <kjhall@us.ibm.com>,
 "Stefan Berger" <stefanb@us.ibm.com>, "Andrew Morton" <akpm@osdl.org>
Cc: "Ard Biesheuvel" <ardb@kernel.org>, <stable@vger.kernel.org>, "Andy
 Liang" <andy.liang@hpe.com>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20250115212237.57436-1-jarkko@kernel.org>
 <583ca33e-aeb3-4401-8f72-9ad1a26d895d@linux.ibm.com>
In-Reply-To: <583ca33e-aeb3-4401-8f72-9ad1a26d895d@linux.ibm.com>

On Thu Jan 16, 2025 at 12:03 AM EET, Stefan Berger wrote:
>
>
> On 1/15/25 4:22 PM, Jarkko Sakkinen wrote:
> > The following failure was reported:
> >=20
> > [   10.693310][    T1] tpm_tis STM0925:00: 2.0 TPM (device-id 0x3, rev-=
id 0)
> > [   10.848132][    T1] ------------[ cut here ]------------
> > [   10.853559][    T1] WARNING: CPU: 59 PID: 1 at mm/page_alloc.c:4727 =
__alloc_pages_noprof+0x2ca/0x330
> > [   10.862827][    T1] Modules linked in:
> > [   10.866671][    T1] CPU: 59 UID: 0 PID: 1 Comm: swapper/0 Not tainte=
d 6.12.0-lp155.2.g52785e2-default #1 openSUSE Tumbleweed (unreleased) 588cd=
98293a7c9eba9013378d807364c088c9375
> > [   10.882741][    T1] Hardware name: HPE ProLiant DL320 Gen12/ProLiant=
 DL320 Gen12, BIOS 1.20 10/28/2024
> > [   10.892170][    T1] RIP: 0010:__alloc_pages_noprof+0x2ca/0x330
> > [   10.898103][    T1] Code: 24 08 e9 4a fe ff ff e8 34 36 fa ff e9 88 =
fe ff ff 83 fe 0a 0f 86 b3 fd ff ff 80 3d 01 e7 ce 01 00 75 09 c6 05 f8 e6 =
ce 01 01 <0f> 0b 45 31 ff e9 e5 fe ff ff f7 c2 00 00 08 00 75 42 89 d9 80 e=
1
> > [   10.917750][    T1] RSP: 0000:ffffb7cf40077980 EFLAGS: 00010246
> > [   10.923777][    T1] RAX: 0000000000000000 RBX: 0000000000040cc0 RCX:=
 0000000000000000
> > [   10.931727][    T1] RDX: 0000000000000000 RSI: 000000000000000c RDI:=
 0000000000040cc0
> >=20
> > Above shows that ACPI pointed a 16 MiB buffer for the log events becaus=
e
> > RSI maps to the 'order' parameter of __alloc_pages_noprof(). Address th=
e
> > bug with kvmalloc() and devm_add_action_or_reset().
>
> Before at it was (at least) failing when the BIOS requested an excessive=
=20
> size. Now since you don't want to limit the size of the log I suppose=20
> you wouldn't also want to set a size of what is excessive so that the=20
> driver could dev_warn() the user of an excessive-sized buffer ...
>
> >=20
> > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > Cc: stable@vger.kernel.org # v2.6.16+
> > Fixes: 55a82ab3181b ("[PATCH] tpm: add bios measurement log")
> > Reported-by: Andy Liang <andy.liang@hpe.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219495
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Sorry there was small glitch because I had a small diff unamended
to the commit. See the last diff:

https://lore.kernel.org/linux-integrity/20250115224315.482487-1-jarkko@kern=
el.org/T/#u

I guess the reviewed-by still holds, right? :-)

BR, Jarkko

