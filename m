Return-Path: <linux-integrity+bounces-3239-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C756693F741
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jul 2024 16:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019961C217D7
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jul 2024 14:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2261494CE;
	Mon, 29 Jul 2024 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwwDgkKm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E970548F7;
	Mon, 29 Jul 2024 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262079; cv=none; b=lh6Fsj5PPbqxeySSKxA7e4/JDFAuF6Er5bnDvwFl9jQJj7/oLAOIvVEApxYD4vRr1MB0woe5AqEaZcb9QYVEQ+nXqEi8dEltjeo34HFM9xal3T247dgQD/CxJS2k+iZXRRQtl+JPdFF4IjzZoWl5pSitCC2Fm0PAgJudgymtDz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262079; c=relaxed/simple;
	bh=k2Wgl0ohB56vYKU3fZm6+LvL1i/f4Mqea5qYebNbSZM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pfeyBYepDOUZ/4AYeBGy9HWTqlWlpWAyzEonsEN8kqgbB6YqSnRAXzgs9upoY2/vqU2S+l6XolqFPtVULQLK4cZ35Yd7EYlXz6XAdplXNeujaYIK61cvfHlgWtv3v1SfrY1DhNynf54fMLrfgujYHI/ueUxCpoW81NoSXZsqpgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwwDgkKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F54C32786;
	Mon, 29 Jul 2024 14:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722262079;
	bh=k2Wgl0ohB56vYKU3fZm6+LvL1i/f4Mqea5qYebNbSZM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=JwwDgkKmSb+BuAiNqTCjB6mkuvvynOnWH2ysajbNDNfggq9ZtVdUXJLM5ynrtTb4U
	 xy/0tuM2EgN7KSQ4aF+CColeRsZdaheCQSszOEfr5wuo5dM+OZFgka8642W926GhXc
	 NzYqsyGJQyR4nyHVmm2n+N6LSx0OKB+X0ty4c1GcAYMC+2hhEdg4RF5E7I1ymHug2s
	 +QAk8qFna1fwKKSasA2wabL+Id/M+WoU4mSBEJPsCSZtswPgWimPzda6N6tVjIUdat
	 4A/MMPJAALtXThBSZKoi039axYvqdKzLKSmQWWIeIawYV4KNhXqswBmuErqpOHL4wg
	 8hQYKgxIfPpsg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jul 2024 17:07:55 +0300
Message-Id: <D322YAQANPJS.1XC8XCTMZ5NJ7@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <mpe@ellerman.id.au>,
 <naveen.n.rao@linux.ibm.com>, <zohar@linux.ibm.com>
Subject: Re: [PATCH v2] tpm: ibmvtpm: Call tpm2_sessions_init() to
 initialize session support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
X-Mailer: aerc 0.18.0
References: <20240729132934.311136-1-stefanb@linux.ibm.com>
In-Reply-To: <20240729132934.311136-1-stefanb@linux.ibm.com>

On Mon Jul 29, 2024 at 4:29 PM EEST, Stefan Berger wrote:
> Commit d2add27cf2b8 ("tpm: Add NULL primary creation") introduced
> CONFIG_TCG_TPM2_HMAC. When this option is enabled on ppc64 then the
> following message appears in the kernel log due to a missing call to
> tpm2_sessions_init().
>
> [    2.654549] tpm tpm0: auth session is not active
>
> Add the missing call to tpm2_session_init() to the ibmvtpm driver to
> resolve this issue.
>
> Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  drivers/char/tpm/tpm_ibmvtpm.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtp=
m.c
> index d3989b257f42..1e5b107d1f3b 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -698,6 +698,10 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev=
,
>  		rc =3D tpm2_get_cc_attrs_tbl(chip);
>  		if (rc)
>  			goto init_irq_cleanup;
> +
> +		rc =3D tpm2_sessions_init(chip);
> +		if (rc)
> +			goto init_irq_cleanup;
>  	}
> =20
>  	return tpm_chip_register(chip);

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

