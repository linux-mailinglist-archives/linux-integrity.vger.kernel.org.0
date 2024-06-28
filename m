Return-Path: <linux-integrity+bounces-2938-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0F291B447
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jun 2024 02:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A543C1C210CF
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jun 2024 00:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD86A38;
	Fri, 28 Jun 2024 00:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="dw3FWGCl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A10C3FF1;
	Fri, 28 Jun 2024 00:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719536077; cv=none; b=ayND6MJ/BBxT+NWFi5nIo6esine/dzMQY8fBAyvk5Z1VfsUtKwGVQdwdghYf2dOmEfaBjcPwHaZhQVJlbFJzzV36TYxmxh/lwcOf9TRT1UDirW/PVH9izdj7LpoK92wyBLurbTK92Zmilxqq8zoUXxfD/Yr+fkhZnWqudILcgNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719536077; c=relaxed/simple;
	bh=ftjf9Zry7d4W0sWAh+GqOrORzQ7DO8qY20Opciici6Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lXPiGdwo0j+dmShQLn5x1wLSwjhEF4cvlb3RLC95dINVOACotNnPb/1eWRJwNBdtPNVtuIczRrLnzNBkwZsroiM8Vw+ZFoWkrYuvsj860bQNm6T1jtfhKboD4Hp6CE6yd0IvaU0CfJ8vW5VJwqm/LKIoc6hM0ePICLhoY1ASMTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=dw3FWGCl; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1719536073;
	bh=nK6ECkNoWWUSbgwv/8Nj8pwVUjgeZlZeQEQ65DI3FjQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dw3FWGCl3P1VHFi8yriJUkoxa2i6gMD7vyIVjlRNnE+dSEi+QCTwW0ti6cCo5P4Bs
	 Zp3+N4QjGAhAIo8fSBG3V7is3heKklaJWPI9TaBUyK4mKGrSlcM3YdU88fBX3+PUO0
	 Ov86/kuCrhKKMq/OGTA7/A72/hTPsZeOIaTAcxQ+sxc1670631sByC0lgYD/+XZbTu
	 WjPM68tNBEq7AepAepoqZwDLK0CxECqLpBQxNeKkHmeeTOGzKx9F07F2ovZr1f2oLK
	 1rBKnDY5fQZu705WcZ0eE65kSe4wuCMr9VUjixPNpprQQAkCa2r/iCpo92AVDTJFQW
	 FHBUTpnaglwjQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9H5N6hF0z4w2N;
	Fri, 28 Jun 2024 10:54:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: regressions@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, naveen.n.rao@linux.ibm.com, Stefan Berger
 <stefanb@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 jarkko@kernel.org
Subject: Re: [PATCH] tpm: ibmvtpm: Call tpm2_sessions_init() to initialize
 session support
In-Reply-To: <20240617193408.1234365-1-stefanb@linux.ibm.com>
References: <20240617193408.1234365-1-stefanb@linux.ibm.com>
Date: Fri, 28 Jun 2024 10:54:31 +1000
Message-ID: <87pls1lwe0.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stefan Berger <stefanb@linux.ibm.com> writes:
> Fix the following type of error message caused by a missing call to
> tpm2_sessions_init() in the IBM vTPM driver:
>
> [    2.987131] tpm tpm0: tpm2_load_context: failed with a TPM error 0x01C4
> [    2.987140] ima: Error Communicating to TPM chip, result: -14
>
> Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  drivers/char/tpm/tpm_ibmvtpm.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index d3989b257f42..1e5b107d1f3b 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -698,6 +698,10 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
>  		rc = tpm2_get_cc_attrs_tbl(chip);
>  		if (rc)
>  			goto init_irq_cleanup;
> +
> +		rc = tpm2_sessions_init(chip);
> +		if (rc)
> +			goto init_irq_cleanup;
>  	}
>  
>  	return tpm_chip_register(chip);

#regzbot ^introduced: d2add27cf2b8 

