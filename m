Return-Path: <linux-integrity+bounces-2863-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECF590BB51
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Jun 2024 21:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBD5282ABA
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Jun 2024 19:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3FD187542;
	Mon, 17 Jun 2024 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="mnZWjMMH";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="JxNXz4hM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB8511CAB;
	Mon, 17 Jun 2024 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718653357; cv=none; b=klx5RFcPAUtCwC7SWRH79s5W/SC0wjovpfXUDxHnv5s2AI6GVq5vKspYViwKocuhtKM6YqK5SBva6u4g+6t9jaJCHxNearSIhLle6TAHYdLaQp44H/uI5TU6C4b552rhZtQFsUfhIB72GS7d+CZ7e0DeP7GaMrqigxYoABfv1YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718653357; c=relaxed/simple;
	bh=1vcmeQncdRyeP1TvaAAoOSNuO5Z2zRz6JdZWHlyc5wU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aTrTiUx5dqJHM0/8zQn5tyD166qJZnOTSbjKmWx8r62RpDhtjCtzu/YIC4T0gXlHzk789IloMlEqcBtk1ybBsAYlGLqMYuvZk5glmL8amZQnR/HEdK20zm7tQBa9VuOxLwyxLRPZVfyqLEE2fAVNbL2UVds78Tzb0j2KbJMYw+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=mnZWjMMH; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=JxNXz4hM; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1718653355;
	bh=1vcmeQncdRyeP1TvaAAoOSNuO5Z2zRz6JdZWHlyc5wU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=mnZWjMMH2Pf/d/viFToDHlEEbQ8HapspA6ZtZT+kGzj2dfKsXkB+8bEXLYrITguK+
	 NhnGQoYWNqSqgNEmKjM8VNJzH1iRqRhtR5gprRK1Wzl90YRWaic93Er+4w4p4KtU1W
	 kqGa+OmkXJDMWZtsWDI83weBETvlGLVnmvHpVieo=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 23FA71287250;
	Mon, 17 Jun 2024 15:42:35 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 6AnscMlQ7NK4; Mon, 17 Jun 2024 15:42:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1718653354;
	bh=1vcmeQncdRyeP1TvaAAoOSNuO5Z2zRz6JdZWHlyc5wU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=JxNXz4hMIJNuIaS2NAP/VmIBIqhBMsY90IEZCeCGJOh67Z+KbLhKYCyMbh5iyytP9
	 fn7ydQPacHeEFBG6cB+WnQaQitcP3DESIbyxtYuw5Hz5w948hQI8qpy4KM8souBzmc
	 NDgDGVPY1QydIfxAFzf/3sTMQuIUtrGMorgI1SWI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 510EE12870A6;
	Mon, 17 Jun 2024 15:42:34 -0400 (EDT)
Message-ID: <dfc4feaef0d63d616bab8cdec5d409369f9dacf1.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: ibmvtpm: Call tpm2_sessions_init() to initialize
 session support
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, jarkko@kernel.org
Cc: linux-kernel@vger.kernel.org, mpe@ellerman.id.au, 
	naveen.n.rao@linux.ibm.com
Date: Mon, 17 Jun 2024 15:42:32 -0400
In-Reply-To: <20240617193408.1234365-1-stefanb@linux.ibm.com>
References: <20240617193408.1234365-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-06-17 at 15:34 -0400, Stefan Berger wrote:
> Fix the following type of error message caused by a missing call to
> tpm2_sessions_init() in the IBM vTPM driver:
> 
> [    2.987131] tpm tpm0: tpm2_load_context: failed with a TPM error
> 0x01C4
> [    2.987140] ima: Error Communicating to TPM chip, result: -14
> 
> Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  drivers/char/tpm/tpm_ibmvtpm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c
> b/drivers/char/tpm/tpm_ibmvtpm.c
> index d3989b257f42..1e5b107d1f3b 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -698,6 +698,10 @@ static int tpm_ibmvtpm_probe(struct vio_dev
> *vio_dev,
>                 rc = tpm2_get_cc_attrs_tbl(chip);
>                 if (rc)
>                         goto init_irq_cleanup;
> +
> +               rc = tpm2_sessions_init(chip);
> +               if (rc)
> +                       goto init_irq_cleanup;

This looks wrong: the whole thing is designed to occur in the bootstrap
phase from tpm_chip_register() (which tpm_ibmvtpm.c definitely calls),
so why isn't it happening?

James


