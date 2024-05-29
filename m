Return-Path: <linux-integrity+bounces-2698-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7208D3686
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 14:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336391F2202A
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 12:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2692E18131A;
	Wed, 29 May 2024 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfgTyPx+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034CB181313
	for <linux-integrity@vger.kernel.org>; Wed, 29 May 2024 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986234; cv=none; b=kaomjlipAjrI+ZswjrdFkQb963Wd4O+Hf6x2WYRdGrfpV3Wo5CDOktDow1moeJhmjGqQNRJ74g9uv3tK9BmN+3NYjCVhoq/+1G5QwVE0Ly1decc5jTjPjSFjar9kCaGBm+ixVQcoRMwCL4iRZkQ2J1zrMpyVabhbuDc5T+qcAYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986234; c=relaxed/simple;
	bh=aSwOw8wOxZJ2nW6MhU68gC2hqjSrBM/wy9YvEHcCqxE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YxjMeVK/T4BkVJlFm7xKKqxp0RtwMyNNq6YZPtHUeqJF7fAonRqDHcIsWmy4HCifDzQ4EFaTNO2F+fb0piRfBY1iWOZ0dBocgssCQSHe54hP0JV/6+Oie0YDnAvVYqgOsxQ1JKPX5hoiO9a4wd97q6djhTPgIfamKlOvLNGK89I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfgTyPx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A145EC2BD10;
	Wed, 29 May 2024 12:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716986233;
	bh=aSwOw8wOxZJ2nW6MhU68gC2hqjSrBM/wy9YvEHcCqxE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=WfgTyPx+nZhmD/644QGtn4/Aa5Lk3tteqzGnrr7+A/KzBGuer6c/LO+1h1Amf+Hlt
	 PX8GohJCqeaaROFVIAJn4H1KiY5PynH77M0Dn8FjOHU2Ei7XKC9fqhU/GYC1oCUj27
	 kplW1MzaheZY0GsdMQffDYVmUDYu2SshsZrk71m5VkNmJ9l86JxXED0gxXBt38sqTr
	 crLWA9vF2sp+hIiU+ceh4jqCsybR/7EdZ+gt8csnBxcFoG7AwmUkwAQv1LNwqpQJEw
	 zebz3GEhqMfcqEBPjGOTAdldJgUUdfElmOCZUv2Pf1jlzdYQfFuVGPGPSPN84v+WiF
	 DxUuoLFacVqPA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 May 2024 15:37:11 +0300
Message-Id: <D1M4TLERD89J.2UZTK98FQTYWP@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <linux-integrity@vger.kernel.org>
Subject: Re: Ping: [PATCH] tpm_tis: don't flush never initialized work
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jan Beulich" <jbeulich@suse.com>
X-Mailer: aerc 0.17.0
References: <908e5878-61f9-7a75-129f-ac236fbc8b0a@suse.com>
 <CVIQPE7W60RN.2QQ8DLCMFV4CW@suppilovahvero>
 <9a1e2ac0-54a8-b88b-3953-22624da5d4b2@suse.com>
 <365c120f-dfb0-4155-b83f-e0b8d4ead486@suse.com>
 <D1M4L6MZ6IFC.21HFGZ10104Y0@kernel.org>
 <b9b1692e-fbfe-4b4e-9769-fb7c88d7b5c7@suse.com>
In-Reply-To: <b9b1692e-fbfe-4b4e-9769-fb7c88d7b5c7@suse.com>

On Wed May 29, 2024 at 3:32 PM EEST, Jan Beulich wrote:
> On 29.05.2024 14:26, Jarkko Sakkinen wrote:
> > On Wed May 29, 2024 at 10:47 AM EEST, Jan Beulich wrote:
> >> Has this possibly fallen through the cracks?
> >=20
> > Not possibly that is what exactly has happened, sorry.
> >=20
> > I tweaked a bit the commit message:
> >=20
> > commit 2c0943eba0bd765e1e4a90234e669a26a9304b74 (HEAD -> master)
> > Author: Jan Beulich <jbeulich@suse.com>
> > Date:   Wed May 29 15:23:25 2024 +0300
> >=20
> >     tpm_tis: Do *not* flush uninitialized work
> >=20
> >     tpm_tis_core_init() may fail before tpm_tis_probe_irq_single() is
> >     called, in which case tpm_tis_remove() unconditionally calling
> >     flush_work() is triggering a warning for .func still being NULL.
> >=20
> >     Cc: stable@vger.kernel.org # v6.5+
> >     Fixes: 481c2d14627d ("tpm,tpm_tis: Disable interrupts after 1000 un=
handled IRQs")
> >     Signed-off-by: Jan Beulich <jbeulich@suse.com>
> >     Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> >     Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> >=20
> > Does this make sense to you?
>
> Sure, that's entirely up to you.

Ok, cool, it should mirror soon to linux-next. Earliest time to PR it is
next week (rc3) because I sent one already yesterday.

> Jan

BR, Jarkko

