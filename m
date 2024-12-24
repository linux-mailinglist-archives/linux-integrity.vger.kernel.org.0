Return-Path: <linux-integrity+bounces-4469-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B41F9FB922
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Dec 2024 05:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97B41607F8
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Dec 2024 04:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ACA4D9FB;
	Tue, 24 Dec 2024 04:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsP5UrcC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33E821106;
	Tue, 24 Dec 2024 04:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735013927; cv=none; b=QUR1s6/jsOPUp7k7XysxAX0vJUXEfIyJI4Xjo6vjFsKIitMyDk8RhCzvYiMEDNCT4zeLMclTrklUcdcr7XOJ1MFsV5RQKtAiRZksj84gyYd4dgxpuPSZaJQe7NDzQrMyCAcNRmlJZ26afx5CEVWPAy9xjLBxvhbk2fVt8oFILCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735013927; c=relaxed/simple;
	bh=tIdIYP1YhQ7GU+RskcLEWdyC86YX4CMaX09zAKjTEuU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=E/NUS+lfqZINtIFezzU2FC7r0uCJgav847SiQSMRlrcLQZd0+pT4h6xqYYCcgJ9bE55fsBNnBEB4U2CihJlj22t8WKvb4SHclGe7dbo6TSJXaci8EV/av+1ryto4OHra04ulddjx3de5ih+PUhSFon/AnFzaACvI7cO5aE5aaFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsP5UrcC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0E4C4CED0;
	Tue, 24 Dec 2024 04:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735013927;
	bh=tIdIYP1YhQ7GU+RskcLEWdyC86YX4CMaX09zAKjTEuU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=CsP5UrcCpUEqCqM+7LFucmDpt0beFJiium1J7q9gV7GS4jL/wskHHmMz38BFOza7Y
	 f474h7bdVe5ui1Z7kpaQnNo3hFqqr4BTrOF8HECf7qRIzNWEeUZeqLfobuFpinBDQ9
	 M5A3/DDRtGx6fSxiJ5R+/51nblAd68vd+yq7U+Wt1oFRZ3gDqzTRvA22wVkfujWj5u
	 nXXFrxrEmK++AQxLcM3oY4fn8tN7bcjeXFQZbsgZPNHY0RDrL91QVFlYWVvVG2lnBo
	 yN4a/avGxosPeY/NZek4W1yrRiRUFOkMyMKB6HRIQCeq18FslYWhS9RMnZmgkZ0fXg
	 7WIFSwzY4uSBQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Dec 2024 06:18:42 +0200
Message-Id: <D6JN3SL6SY8T.1VYULNCNNAHGJ@kernel.org>
Cc: <stable@vger.kernel.org>, "Andy Liang" <andy.liang@hpe.com>, "Matthew
 Garrett" <mjg59@srcf.ucam.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] tpm: Map the ACPI provided event log
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>,
 <linux-integrity@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Colin Ian King"
 <colin.i.king@gmail.com>, "Joe Hattori" <joe@pf.is.s.u-tokyo.ac.jp>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Stefan Berger"
 <stefanb@linux.ibm.com>, "Ard Biesheuvel" <ardb@kernel.org>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "Al Viro" <viro@zeniv.linux.org.uk>, "Kylene Jo
 Hall" <kjhall@us.ibm.com>, "Reiner Sailer" <sailer@us.ibm.com>, "Seiji
 Munetoh" <munetoh@jp.ibm.com>, "Andrew Morton" <akpm@osdl.org>
X-Mailer: aerc 0.18.2
References: <20241224040334.11533-1-jarkko@kernel.org>
In-Reply-To: <20241224040334.11533-1-jarkko@kernel.org>

On Tue Dec 24, 2024 at 6:03 AM EET, Jarkko Sakkinen wrote:
> The following failure was reported:
>
> [   10.693310][    T1] tpm_tis STM0925:00: 2.0 TPM (device-id 0x3, rev-id=
 0)
> [   10.848132][    T1] ------------[ cut here ]------------
> [   10.853559][    T1] WARNING: CPU: 59 PID: 1 at mm/page_alloc.c:4727 __=
alloc_pages_noprof+0x2ca/0x330
> [   10.862827][    T1] Modules linked in:
> [   10.866671][    T1] CPU: 59 UID: 0 PID: 1 Comm: swapper/0 Not tainted =
6.12.0-lp155.2.g52785e2-default #1 openSUSE Tumbleweed (unreleased) 588cd98=
293a7c9eba9013378d807364c088c9375
> [   10.882741][    T1] Hardware name: HPE ProLiant DL320 Gen12/ProLiant D=
L320 Gen12, BIOS 1.20 10/28/2024
> [   10.892170][    T1] RIP: 0010:__alloc_pages_noprof+0x2ca/0x330
> [   10.898103][    T1] Code: 24 08 e9 4a fe ff ff e8 34 36 fa ff e9 88 fe=
 ff ff 83 fe 0a 0f 86 b3 fd ff ff 80 3d 01 e7 ce 01 00 75 09 c6 05 f8 e6 ce=
 01 01 <0f> 0b 45 31 ff e9 e5 fe ff ff f7 c2 00 00 08 00 75 42 89 d9 80 e1
> [   10.917750][    T1] RSP: 0000:ffffb7cf40077980 EFLAGS: 00010246
> [   10.923777][    T1] RAX: 0000000000000000 RBX: 0000000000040cc0 RCX: 0=
000000000000000
> [   10.931727][    T1] RDX: 0000000000000000 RSI: 000000000000000c RDI: 0=
000000000040cc0
>
> Above shows that ACPI pointed a 16 MiB buffer for the log events because
> RSI maps to the 'order' parameter of __alloc_pages_noprof(). Address the
> bug by mapping the region when needed instead of copying.
>
> Cc: stable@vger.kernel.org # v2.6.16+
> Fixes: 55a82ab3181b ("[PATCH] tpm: add bios measurement log")
> Reported-by: Andy Liang <andy.liang@hpe.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219495
> Suggested-by: Matthew Garrett <mjg59@srcf.ucam.org>
> Tested-by: Andy Liang <andy.liang@hpe.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Doing some weird truncate here would be pointless even if it is "too
large". It's HPE's problem, not ours. The onnly piece of code where the
fix makes any mentionable changes is really acpi.c and I've tested that
quite throughly already...

In some other version of the hardware the size was BTW 8 MiB (according
to TPM2 table contents) and later on it changed to 16 MiB (according to
transcript above i.e. RSI). That is weird but I don't think we should
care.

BR, Jarkko

