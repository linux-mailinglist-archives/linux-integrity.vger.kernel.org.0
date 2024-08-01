Return-Path: <linux-integrity+bounces-3243-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CAE94543A
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Aug 2024 23:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949441F224A1
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Aug 2024 21:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831911487F1;
	Thu,  1 Aug 2024 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="SojdjJ3S"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3E0DF49;
	Thu,  1 Aug 2024 21:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722548910; cv=pass; b=g1H+b+VfP2K636P7I5eM5KI2DGsQ2d8tzbjLw4CyOvtkxXVz6BjfGuSqy4BLE3WuKTEo8W/eaZ99MvhpOK3je1jyDGPi3OCJQizfj0I5Dm9YATHPhglbv6oMvYShr0xzVWlBKaVEbXsmnifEcWqfMTCfYS1i/qFf9bHlRYoigqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722548910; c=relaxed/simple;
	bh=ZO3XA4CcsmcRe7FcHo4W8o2Ga50j2vmLjqPTn4HcuXQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=JlqTNFn2dR6yE/L/EwgRg5hDU9GiWzxcnVa/sHGk70eJBkk2eQ8pM5vgzWOLmpS1FYVSPewzhHgG05X+igornSSlHowsG6oiduiL0yv97Lb1fNgdTuGQoSauriAgxa5GlrCENsESBMYyOq6oI3reeDT1ghFELjJnV7UOLBGJmAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=SojdjJ3S; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (91-154-92-171.elisa-laajakaista.fi [91.154.92.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4WZjJK0bqdz49Q0P;
	Fri,  2 Aug 2024 00:48:17 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1722548898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTNTSSPsb4ORaTHQPc0RPyrJwlrU/KKte+XLlL8P/cA=;
	b=SojdjJ3SH8N/Z5P/x9LAB/ko97rXjIzhNvBo8gp3EwokbtJTmVwxFdP3rAM8yyL98JvzlB
	QV5gAeseyJz2ySD7zUM4lW8rIVrsIDClKUKtkVcwvbn4fPHM1iTiFV0ahZ1sEh2FqjFDvD
	lbIO14xPbrcsmO35Vw8Mnk5YAQWiTHYxlKyxfRfG4NpSNTH8+DYX3REm+5yqSK+lCpeRad
	Wg4YPNEUe7AX80Xmtc783VRMfIhhVxD4a4IvSz4p26cCWtNGVxHZFKDq5oECGdB8QbyJcq
	xYc7iNxGpiyDvUko8Qse9I1Adb1n0QNhxSFgGkDPglxViLfe6jbV97Neo5PiLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1722548898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTNTSSPsb4ORaTHQPc0RPyrJwlrU/KKte+XLlL8P/cA=;
	b=PGBC+b/acN+zLuWlk9RW9f0cE06sd78mkwZzu/YH2Sebust82s0uGXRYsDVQT717dXyNPt
	8sBvG9NyTGq0qRxqsR7X4RNanx7LrlnmRkZA/kMFcsYlE15pBh8c+oNsWKQCyg0SWsTHRU
	0LsLQqBu76mQ1r7EZQXO1E/k1A7mJKk1Yiem/ayKuKztwRUTWIOXOShTYYM2Ofd7LvmZ6H
	qDHGwY95TVs2QPP8nSahpAhDiZYhaQFCGZJ+JplLGTLMx9hElcl9/1UJ+IoeM8GbTlxXn7
	oZMp1AA0Awa9iMXLelYrf462cwiu/337RwBafqDoMoB8E4Z4181xJbZ+ErPI0A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1722548898; a=rsa-sha256;
	cv=none;
	b=R9CP4BjQXi4eaqnJp1264aVeeM/unlJA4TdcVTQwmL5BjGJv0+kVibqkvfbqEarEvmfvV1
	Id9pKsATfWvll4leGkyxdwhzpyFUj5NAUM3FlgDT0DyBmU+1Rpw+RzDWs65dUr3273EAri
	wCyvzAbmlRv+8b4XzmGEKJFiCFKJA3hxrj4sNO1Dj42nzXlMaatVYA5m+mLFAzAuCx9yQ0
	aYTvums30v+FLUIC/gpn8zflIFLU9b/kiOBIRp1gDQzF37NW0uDsNQSMRCd8WBOYf3pSjS
	+w+LhLfRPVS07vaOMGgcfRKE2MpYzsRKhYuzpFtld5DrgxWC9QP287g0E9N0PA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Aug 2024 00:48:15 +0300
Message-Id: <D34WMEE9AIKU.1KLX21J35LNJA@iki.fi>
To: "Stefan Berger" <stefanb@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <jarkko@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <mpe@ellerman.id.au>,
 <naveen.n.rao@linux.ibm.com>, <zohar@linux.ibm.com>
Subject: Re: [PATCH v2] tpm: ibmvtpm: Call tpm2_sessions_init() to
 initialize session support
From: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
X-Mailer: aerc 0.17.0
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

Applied!

BR, Jarkko

