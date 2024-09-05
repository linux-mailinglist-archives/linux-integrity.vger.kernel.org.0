Return-Path: <linux-integrity+bounces-3443-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EE096DBBB
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 16:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D229328323F
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 14:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A595619DFB8;
	Thu,  5 Sep 2024 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LT2emT1x"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ECC1DFD8;
	Thu,  5 Sep 2024 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546381; cv=none; b=OxeR/AN4jrDa4FyPKnQymtABBj8SO/EzEt5fH7j39DgbJkBizRxSFGETDtmTszgATri4q1dy2DRV2sHdziEET7fnLlqiI1dbV0TQB5jlRgOCztk9aLzVhkpAGfyT+oE/Q91jxhb3V8get/kmu1w6XVB1toZmxjDvdIEkAHW656E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546381; c=relaxed/simple;
	bh=cjIK4MXp2ychqW40KbQPt1aZ9lUypAyZZyXEdWDht28=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lUMVsU2cp+rGqBVCYhI+hM4lYFYk7uWW8/X6r2jcf6EeiP/2JCfL5Ncz0M6HTcO10rfFRop2DLjm51NmrwocwjVTo83q9IhvEw/hYF7lYSc9klYJLw2DBqBm3BKXCpOCVy5arIhZPYoBS2d5wZ+y4wU4qqrN2A7dxQHELhT0rk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LT2emT1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1696C4CEC5;
	Thu,  5 Sep 2024 14:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725546381;
	bh=cjIK4MXp2ychqW40KbQPt1aZ9lUypAyZZyXEdWDht28=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=LT2emT1xvJ0FhLoGFLsWTR30Nr7s1gp/0JQHuJd0rqQXSTFLN26dVSci4YQmtqkb1
	 0T2VWkl0bW555WoLgXDkL4er5ehSlUK1+UI1hg0uRT1SmDv7C11kKwOAdyAgiH0dEO
	 SzeTyo0+tkxhWzyrcivLgoCMXT4It1F7Dv0DZg3tNzAYtXFEa8DWdpawrCDO+QAmJe
	 quT1X04TnwiNcVXjUoocSEg0OlBOljNnXW+TLcBISeQjCvKuXPZNEf+BvEx+6DteNJ
	 O78VDKO7XTonkh2xFA5tI29414mpqNTfzf34YKE+wt2bNUIWphHdTh1LmzrNgWuPnV
	 P2/IZZ/yopH1Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Sep 2024 17:26:17 +0300
Message-Id: <D3YF52E4EVJ0.2ZJSCR5FCVIGX@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <mpe@ellerman.id.au>,
 <naveen.n.rao@linux.ibm.com>, <zohar@linux.ibm.com>,
 <stable@vger.kernel.org>, "kernel test robot" <lkp@intel.com>, "Mingcong
 Bai" <jeffbai@aosc.io>
Subject: Re: [PATCH v2 RESEND] tpm: export tpm2_sessions_init() to fix
 ibmvtpm building
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Kexy Biscuit" <kexybiscuit@aosc.io>, <stefanb@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
X-Mailer: aerc 0.18.2
References: <20240905085219.77240-2-kexybiscuit@aosc.io>
In-Reply-To: <20240905085219.77240-2-kexybiscuit@aosc.io>

On Thu Sep 5, 2024 at 11:52 AM EEST, Kexy Biscuit wrote:
> Commit 08d08e2e9f0a ("tpm: ibmvtpm: Call tpm2_sessions_init() to
> initialize session support") adds call to tpm2_sessions_init() in ibmvtpm=
,
> which could be built as a module. However, tpm2_sessions_init() wasn't
> exported, causing libmvtpm to fail to build as a module:
>
> ERROR: modpost: "tpm2_sessions_init" [drivers/char/tpm/tpm_ibmvtpm.ko] un=
defined!
>
> Export tpm2_sessions_init() to resolve the issue.
>
> Cc: stable@vger.kernel.org # v6.10+
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408051735.ZJkAPQ3b-lkp@i=
ntel.com/
> Fixes: 08d08e2e9f0a ("tpm: ibmvtpm: Call tpm2_sessions_init() to initiali=
ze session support")
> Signed-off-by: Kexy Biscuit <kexybiscuit@aosc.io>
> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
> ---
> V1 -> V2: Added Fixes tag and fixed email format
> RESEND: The previous email was sent directly to stable-rc review
>
>  drivers/char/tpm/tpm2-sessions.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-ses=
sions.c
> index d3521aadd43e..44f60730cff4 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -1362,4 +1362,5 @@ int tpm2_sessions_init(struct tpm_chip *chip)
> =20
>  	return rc;
>  }
> +EXPORT_SYMBOL(tpm2_sessions_init);
>  #endif /* CONFIG_TCG_TPM2_HMAC */

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

