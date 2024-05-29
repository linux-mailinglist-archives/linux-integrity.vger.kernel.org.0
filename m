Return-Path: <linux-integrity+bounces-2696-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F868D3659
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 14:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A374D1C2103F
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 12:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484CF180A96;
	Wed, 29 May 2024 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjJt4w2u"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2426F180A95
	for <linux-integrity@vger.kernel.org>; Wed, 29 May 2024 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716985575; cv=none; b=BopNBE6x7BUhqy1PzF5e1oiME4KM6lE/L5+CD37selnb1oYXMG7FIox9R02kI5iya3yN03HeWnLVkhrEMjR2spVuQEO1B6sBLLvvobKV51KgbSKZe9omVcs/WyHxezjZRXi2SqeCrOnCwEt/NmW8z88gbzyI/G2zu0QUCz8CS5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716985575; c=relaxed/simple;
	bh=7TjWV4izADX6tLqqn4deyJNzUArBrnRXPfHN5A5fF5E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EvDO/sLHAlY2yQa04BhY5sCn9M+ez2qrvWn9t3+F+2sXuYimXed6aVZCrpBmB4aNHhuXbJyxpo9DmBnJ4ecP058KdYCWlRbnzhpdsZ/SlFxNhqPFinkhjpJFkzr9b2Jhul7sYeEqp3lfOGKh1kvLdaPuPejNTMMb7lArdnqjQ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjJt4w2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C97C32782;
	Wed, 29 May 2024 12:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716985574;
	bh=7TjWV4izADX6tLqqn4deyJNzUArBrnRXPfHN5A5fF5E=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=AjJt4w2uWKUxBVZDZrl4RVXW63l0sDvS49T7LtG9t3LIA8G4jaYeUOWO57CBWAFk1
	 4WgomJq5pGR//ke7NUOIQIPblV4DNAamhaib2nA83RJW2ySA8fvq5hpwWqIkUpuPIJ
	 BeZzBwhGFrhbQka0UpRL+nuIIkwku5ctHxDdKXSQ+sUHAaHOOfjRpB40dFWAFz5bBu
	 pI9NqH3RimJklDQrBXr1vpJWlVMuk/BuWQixy68dUXgwxP9OaplrcOWylYIMy8Y7PA
	 7kOILs3dqK6Dyi+E2t9JHO4rhCC68EI1yz9KN+B2fQERESZY/YNLy13NVZthVUhGCM
	 /7TtPNRtwfkCg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 May 2024 15:26:11 +0300
Message-Id: <D1M4L6MZ6IFC.21HFGZ10104Y0@kernel.org>
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
In-Reply-To: <365c120f-dfb0-4155-b83f-e0b8d4ead486@suse.com>

On Wed May 29, 2024 at 10:47 AM EEST, Jan Beulich wrote:
> Has this possibly fallen through the cracks?

Not possibly that is what exactly has happened, sorry.

I tweaked a bit the commit message:

commit 2c0943eba0bd765e1e4a90234e669a26a9304b74 (HEAD -> master)
Author: Jan Beulich <jbeulich@suse.com>
Date:   Wed May 29 15:23:25 2024 +0300

    tpm_tis: Do *not* flush uninitialized work

    tpm_tis_core_init() may fail before tpm_tis_probe_irq_single() is
    called, in which case tpm_tis_remove() unconditionally calling
    flush_work() is triggering a warning for .func still being NULL.

    Cc: stable@vger.kernel.org # v6.5+
    Fixes: 481c2d14627d ("tpm,tpm_tis: Disable interrupts after 1000 unhand=
led IRQs")
    Signed-off-by: Jan Beulich <jbeulich@suse.com>
    Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
    Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Does this make sense to you?

> Jan

BR, Jarkko

