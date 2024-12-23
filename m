Return-Path: <linux-integrity+bounces-4463-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39869FB41B
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Dec 2024 19:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9FA188496D
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Dec 2024 18:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390951C07C3;
	Mon, 23 Dec 2024 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ma77nd8w"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5221B6CFE;
	Mon, 23 Dec 2024 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734979362; cv=none; b=ORNgFWP21bfzWdV43+ygIAfaJp+KHirst399YfeSRShrrUn8Yv8PwH7+fPQhSupYTRObBayQVQ1YcxW2baa6h1F78CQyafF/5ysvVFCNZI9CEzbMojVwu0dlWkeROxddd+1adK7WHHL8QR983/G6V7Xy8YkuPVn1hI8teLECl10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734979362; c=relaxed/simple;
	bh=nmNLPuF0b0SkMRFd3dwgE4963RNLX8W3j1FJMq2a0JA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=joZGhMM+yuUv7UPmh1i73Gd0tasaPxy7QIn1881BP7P7CDbcjdoGYGpyz9o0nD33EVZkNIoUTUQsBwvstwDL2rxNzjQ6bSvEcyTkFr2Xg1LOG4iFKRXAxZ2Et6C7cK9bdMAPR6RLrRdi13n0kAtGCXGZYnCFaK1Cpf9xrS2XYwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ma77nd8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E85AC4CED3;
	Mon, 23 Dec 2024 18:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734979361;
	bh=nmNLPuF0b0SkMRFd3dwgE4963RNLX8W3j1FJMq2a0JA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Ma77nd8wO6js0sRAaB03DKLUUR3RNhqmtqfir/+xQfoYyR5yYSOrVGoi0Vk2qZi5t
	 dmt+cnx+cgf5PUe6d/BZkxhfdvKK+mTM3RYpzzw13XswfL5QAVjrJQctCyfKBUJb3n
	 /eisJac25MAXOTTDrJjecAWLdqHtsWNd2u/rT2SAVCh40Bc+Qar+oOgRNw4juRD+om
	 jiwjBmxklqZUdwNjGPMCEsJwcfR6EgdWAF946f34tzps94357Xtu8On9MnjQhE5f/w
	 z/G5/WyK0HuK57M1wSTb5fjjuyO2xNRrMY15zdsppFGY8ypcf2KXCgcquvMLLJ16oA
	 wIR7mphgscR9Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Dec 2024 20:42:36 +0200
Message-Id: <D6JAUP5NAXZ2.MU9167EXYHGM@kernel.org>
Cc: <stable@vger.kernel.org>, "Andy Liang" <andy.liang@hpe.com>, "Matthew
 Garrett" <mjg59@srcf.ucam.org>, "Roberto Sassu" <roberto.sassu@huawei.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tpm: Map the ACPI provided event log
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>,
 <linux-integrity@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Colin Ian King"
 <colin.i.king@gmail.com>, "Joe Hattori" <joe@pf.is.s.u-tokyo.ac.jp>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Stefan Berger"
 <stefanb@linux.ibm.com>, "Ard Biesheuvel" <ardb@kernel.org>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "Al Viro" <viro@zeniv.linux.org.uk>, "Kylene Jo
 Hall" <kjhall@us.ibm.com>, "Seiji Munetoh" <munetoh@jp.ibm.com>, "Reiner
 Sailer" <sailer@us.ibm.com>, "Andrew Morton" <akpm@osdl.org>
X-Mailer: aerc 0.18.2
References: <20241222143022.297309-1-jarkko@kernel.org>
In-Reply-To: <20241222143022.297309-1-jarkko@kernel.org>

On Sun Dec 22, 2024 at 4:30 PM EET, Jarkko Sakkinen wrote:
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
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

As you can see from the bug comments clearly both v2 and v3 pass the
tests in the failing hardware. I don't think it is really a problem for
us to map 16 MB of address space, as that is zero cost of resources,
even if there is only some dozens of kilobytes of data. Since ACPI
does that it will never be available for general consumption anyway.

Also I've tested the following configurations in QEMU:

1. TPM2 FIFO (or TIS)
2. TPM2 CRB
3. TPM1 FIFO

95 insertions and 65 deletions is neither too bad figure, and as
side-effect makes tpm1.c and tpm2.c pretty much chip independent.

James earlier suggestion to "fix" also OF and other stuff is
purposely left out as we don't falling tree over there. They
should continue to use devm_kmalloc() for the moment although
in principle zero copy mapping is always better (but definitely
notin the scope of bug fix).

BR, Jarkko

