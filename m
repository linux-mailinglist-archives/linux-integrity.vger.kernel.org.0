Return-Path: <linux-integrity+bounces-2294-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F808B7FCA
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Apr 2024 20:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0FBB1C224F8
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Apr 2024 18:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EB417B509;
	Tue, 30 Apr 2024 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZghseKe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C1A23C9;
	Tue, 30 Apr 2024 18:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502245; cv=none; b=ZUfiV6XWsMHDIhJcNOfPYxd+ZhMn+DsltYg+PsrJY9rzxHQCdNz4T9qDOT+uSSHXWc2FoU7DfoOdcI/VTU/gpDmYNG/EOogJUC9C9fWqWif2RDNR5f+hkHlFJ4g9rC/qKmjaKGLODIWpT7+2q0Uf0sQ9JLeT+P8uGKwXoIsUGLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502245; c=relaxed/simple;
	bh=qDmVP3Z263mehJEKIAM6sxnyT4ISQCN50RXxZcDMnBU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cGPM6+Ge6QoZEIQKknQxemjWcdx5zpvastTocYPlGrkDujy34q87zzJtRjo99Hruaa9k/ap6bLzY26VxKaQHjtRolJH6uve4ihryWtuwaCr+dvhE6QO57M+WdKE7mvDjUGgHqMzx8VRsk8vsIgMjIqPN0bV+o3/o2VoFCO9l6/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZghseKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62332C2BBFC;
	Tue, 30 Apr 2024 18:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714502244;
	bh=qDmVP3Z263mehJEKIAM6sxnyT4ISQCN50RXxZcDMnBU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ZZghseKen9Sba9JgLNlryf0H56+3T+JzTN8jKXmQSKZMIgaABfawOpY4y6kcmw1JM
	 rNG4Zt8x0zge1cCTSh5zebe5KzmtYmY0womsAUFpeOwFIJVg/XG+ie/NlExMIfFVKE
	 RU9i7qd41X/nXGNEW9Qe8owlin8QWBP3AkBc4PZOounMm30zj4Wp+lgu5xtS60bXiX
	 9cld9hJTUHrYlJoMDJMouyBr1SbACFgLcfBIqziYaxZvHr1lBrxL9O6jd7/PynDk/e
	 IYC/XLAzSuyF1sTLpv6nHCtcXRu+Qf+1FbAeE1bofVoUAQqmyBO5FJnQJhS4Sv74wA
	 iJZ/6NERyGQXw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Apr 2024 21:37:21 +0300
Message-Id: <D0XOBKC3XWJK.3U49LYWO3POOL@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v8 00/22] add integrity and security to TPM2
 transactions
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
 <D0WYH9UDXCZC.3OZ9MSOVTDBE1@kernel.org>
 <D0WYKBCRV1BS.EWPTEY7QUG85@kernel.org>
 <D0X0BN0RI4UG.2T8WRIFTWXE96@kernel.org>
 <3e6bafc8-99df-4e84-8f3a-8181c9f84e24@linux.ibm.com>
In-Reply-To: <3e6bafc8-99df-4e84-8f3a-8181c9f84e24@linux.ibm.com>

On Tue Apr 30, 2024 at 2:18 PM EEST, Stefan Berger wrote:
>
>
> On 4/29/24 19:49, Jarkko Sakkinen wrote:
> > On Tue Apr 30, 2024 at 1:26 AM EEST, Jarkko Sakkinen wrote:
> >> Right and obviously 3rd option is to send a PR to
> >> https://gitlab.com/jarkkojs/linux-tpmdd-test.
> >>
> >> I.e. patch file goes to patches/qemu (BR2_GLOBAL_PATCH_DIR
> >> points there).
> >=20
> > Stefan, can I do a "zero QEMU changes" negative test for
> > changing null seed by somehow reseting swtpm? That would
> > be best possible option (if it is possible).
>
> You cannot easily reset swtpm without changing 'something' and resetting=
=20
> the NULL seed only works when running TPM2_Startup. You could modify=20
> some TPM2 command to do what HierarchyStartup does with the nullSeed to=
=20
> simulate what you want.

Hmm... I'm not too eager to modify swtpm itself.

So one hacky option might be to run swtpm using system() in an
interposer program and that program would again create chardev
using cuse.

That program would again have to modify traffic "at some point".

Maybe +1 command after TPM2_StartAuthSession or later?

BR, Jarkko

