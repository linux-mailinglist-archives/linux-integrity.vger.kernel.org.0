Return-Path: <linux-integrity+bounces-3279-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57848946A95
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 19:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF001F21017
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 17:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E1F1078B;
	Sat,  3 Aug 2024 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="nQwb9inu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8684F17565
	for <linux-integrity@vger.kernel.org>; Sat,  3 Aug 2024 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722704913; cv=pass; b=gOUQm7sqNQMp2AQUWZcDtfAdC5nAS6OYtq7byTCZSMS6iEUpQSAodG/rYSH0DfJFfRFqfgjkjHnYcuXFJbYY0sP9NnpsDbWR+tNf0BFOc9eQMbCGj3uoJRbuoABxMNgzJVipXIcUSECA92UkBEGaTWb6EI0zKvCNUhINOWnRzps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722704913; c=relaxed/simple;
	bh=cifvxa9BN0FmeQhtgqF8kI96JjPyBcyiWhz638VG0vI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=U/Mj4c6Xjy+1nceurf/T72lk8l8qTPsLwya/dDWI2/mj4QUVSqTaZFWmW96pQnGzGJSy6QZ+nxQ8OqCaOw336LmTN3iVXd/RFl4C7hyU8vWAyPhEB1fk5TG3AQBp0LtMXKhmN7RGnNqT2QIPm2C4bP+/kCbSLnoHd75YHq4b/kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=nQwb9inu; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (91-154-92-171.elisa-laajakaista.fi [91.154.92.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Wbq0P3HdZz49Pv5;
	Sat,  3 Aug 2024 20:08:21 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1722704901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HCwAjClcv9NDRoSgd6xZR0gSJGZbFR5v4o60ezlfXu8=;
	b=nQwb9inuTomLIq1g1V/gK0zwczVFY7kVegrNNAUT0mmgFA+ZIruJzyYEWOcNsvi5QHlAFa
	wkUMigkGjMsiTAhCvSWlCEpOfoxLn1phpug8FkrtQ2w2ZuoEALabs/aRegESvno5pTGEZJ
	5V4Lqesv3KH66wiVMFctcDaujCZKB2UfO5XEmT3DonliuFdsk7+FsALUWHr5a23lRq57ye
	yeYND0LJF+4KJ6xzL2MRKsjiVLlAqmkF76J0TifeO5C3qjy/yqpR8/zp9PaaPPCj5k+fBU
	4EGpZ4MLOwR3F1fde/jVNteN1DvD4xSodd7PZvLzcE2X6pKRT1hLJo8Z4pll+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1722704901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HCwAjClcv9NDRoSgd6xZR0gSJGZbFR5v4o60ezlfXu8=;
	b=N7VuBXrKb+JvtGZlHAJVF5u5mkVPe3kRQ4okjMTSN8Wm6tz5KNeRoI6JA9FCHnyXVb3ERw
	3IPr4hYySbyYV3DnNDTjZ6nKpyUBvKNKp527SJIx4QPM1Pq9HoGlPWhm2xaiyNS4LUrYwg
	1s4rsWmQrR0ArzHLA/oQmhoBWkrq0O+1n7q3Oxc68r6uTtgLCjCTXMihVD03X4swxBTW3P
	auZXoanTxzYjqF9MTjfo1XO5zQllqbz0UPvOdV3/QIyQbbcMcf+2EiFO6zZoY/yn2FrbjV
	f1ScGiIAMVY9m6otppUP2j1vJGwWiG7+a1axRhr9PojEeISzfySWfuLlmtxOLQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1722704901; a=rsa-sha256;
	cv=none;
	b=iSaCHKzoySEy3jEvR6uEHPkBhiCWOK/Db+kvMJGraPGroJ3TeF0YUsqIipppmSUs8X8fef
	SbaDurOAg0fiCYXmsPoRL60AxgqNhntLhvwCBieAwNR7B3eCFm5ulRheEyeltzWp9huTeE
	GG8iRhN1HQyffXFgJrbo+iD8KBirSqBHx3GeB1ScKpnXeRhIWRrc/Fsh84JjZXmwDQ38nx
	Lz+g5r6DEU04V4Ad51vJhPAzAVqH8PDJH9ViU+Kxf62yqlXgx3p8GHNIeZ8F5fR2mP/9ab
	guHiCZsmgD8Z3kjynlLjVH20CsPpMRTpCshtGyEhbH2Yc0jDAE47Tx7brp3fkQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Aug 2024 20:08:20 +0300
Message-Id: <D36FX5RTUSEW.1LZMP91ZPPZZK@iki.fi>
Subject: Re: [PATCH 1/8] tss: Fix handling of TPM_RH_NULL in intel-tss
From: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <openssl-tpm2-engine@groups.io>
Cc: <linux-integrity@vger.kernel.org>, "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.0
References: <20240802202606.12767-1-James.Bottomley@HansenPartnership.com>
 <20240802202606.12767-2-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240802202606.12767-2-James.Bottomley@HansenPartnership.com>

On Fri Aug 2, 2024 at 11:25 PM EEST, James Bottomley wrote:
> Now that we're going to be using the NULL primary to salt sessions,
> the Intel TSS shim needs fixing to cope with this.  In the Intel TSS,
> there are two internal handles representing NULL: ESYS_TR_NONE and
> ESYS_TR_RH_NULL.  We translate TPM_RH_NULL to ESYS_TR_NONE because

Can you split this into two paragraphs.

I'm lost why it has two representations.

> most of the time it does mean no value.  However, for the NULL primary
> handle we must use ESYS_TR_RH_NULL, so check for that specific case
> and fix it.  Additionally remove the intel_handle() code which was
> supposed to do this: it's unused because 0 is never passed in as a
> handle number.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  src/include/intel-tss.h | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/src/include/intel-tss.h b/src/include/intel-tss.h
> index 1870b4e..5b8db20 100644
> --- a/src/include/intel-tss.h
> +++ b/src/include/intel-tss.h
> @@ -251,14 +251,6 @@ intel_sess_helper(TSS_CONTEXT *tssContext, TPM_HANDL=
E auth, TPMA_SESSION flags)
>  				  TPMA_SESSION_CONTINUESESSION | flags);
>  }
> =20
> -static inline TPM_HANDLE
> -intel_handle(TPM_HANDLE h)
> -{
> -	if (h =3D=3D 0)
> -		return ESYS_TR_NONE;
> -	return h;
> -}
> -
>  static inline void
>  TSS_Delete(TSS_CONTEXT *tssContext)
>  {
> @@ -937,8 +929,10 @@ tpm2_CreatePrimary(TSS_CONTEXT *tssContext, TPM_HAND=
LE primaryHandle,
>  	TPM2B_PUBLIC *opub;
>  	TPM_RC rc;
> =20
> -	/* FIXME will generate wrong value for NULL hierarchy */
> -	primaryHandle =3D intel_handle(primaryHandle);
> +
> +	/* TPM_RH_NULL is mapped to ESYS_TR_NONE, which won't work here */

I simply don't understand what E


> +	if (primaryHandle =3D=3D TPM_RH_NULL)
> +		primaryHandle =3D INT_TPM_RH_NULL;
> =20
>  	outsideInfo.size =3D 0;
>  	creationPcr.count =3D 0;
> @@ -993,9 +987,7 @@ tpm2_StartAuthSession(TSS_CONTEXT *tssContext, TPM_HA=
NDLE tpmKey,
>  		      TPM_HANDLE *sessionHandle,
>  		      const char *bindPassword)
>  {
> -	bind =3D intel_handle(bind);
> -	tpmKey =3D intel_handle(tpmKey);
> -	if (bind !=3D ESYS_TR_NONE)
> +	if (bind !=3D TPM_RH_NULL)
>  		intel_auth_helper(tssContext, bind, bindPassword);
> =20
>  	return Esys_StartAuthSession(tssContext, tpmKey, bind, ESYS_TR_NONE,


BR, Jarkko

