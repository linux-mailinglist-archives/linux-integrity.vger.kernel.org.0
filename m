Return-Path: <linux-integrity+bounces-7220-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3377B8FBEE
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 11:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C743BA53D
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 09:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5E4286889;
	Mon, 22 Sep 2025 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8fNtN5e"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E80283FDB
	for <linux-integrity@vger.kernel.org>; Mon, 22 Sep 2025 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758533163; cv=none; b=fXZAH1LyeLBaiSYamOiq0z5YiPF5Si5f2UD6WiYMytf9S6f3/9LchZWloOQCZ2RFgAPN26P4O80vDUkSUvTbJp3PmOds0ccsKYUiwofU8srd5IPJZsLVWWZdlld1J40Qig8KMDmQmRDBOSnYf/9FvV6cBRt+GqNCVzr9nRIA53M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758533163; c=relaxed/simple;
	bh=nyjXxEfScQl0f+qKx/QuarmizK/Rrjns65gQi1ZZxv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRXubMk197YH6PiySluZJhniH9rTgQA9jUv/eEYwYBW/fjN/kLWAmoN7ILTW/sjabDy4xsHERADZKyX1DyNmWfpF7PZwu6Cpj0Hd10qFt2g16QiCXSJGYJenKZP81uYdm2mVKUsPUguiSpmqjCKUHtqoMCIxYWchttL+4MHBYDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8fNtN5e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758533160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9cF8ChkrVjedqQcH45KxT9cWQe9wu1GihjCbg8HEDV4=;
	b=e8fNtN5emDdcZIHOcHHkqA8ewmLEZ5htGW0SRzhllMBJCeLVkUq/ubTv2fId75tTzE+n43
	63IYYLobwfGAJkdcQSBAm/3I03x9XShFKtFDcts6+rsXII00+6tMaKiZkyVrOT2tLfCczD
	Rp+d3B/O/tUh25vqk1yLCf0dbS2zcIg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-O9C7c2nFPKSDGXjMktyiHg-1; Mon, 22 Sep 2025 05:25:59 -0400
X-MC-Unique: O9C7c2nFPKSDGXjMktyiHg-1
X-Mimecast-MFC-AGG-ID: O9C7c2nFPKSDGXjMktyiHg_1758533158
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ed9557f976so3854612f8f.3
        for <linux-integrity@vger.kernel.org>; Mon, 22 Sep 2025 02:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758533157; x=1759137957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cF8ChkrVjedqQcH45KxT9cWQe9wu1GihjCbg8HEDV4=;
        b=HvMBQ6wTtRVugo1dZIAUN80v6+OStyVu0Lh3TUHGh69D66h/vboZYz9qTSzyPM/uJF
         jf63Jl02pL7+u4Qx2Rv8rkKQx9NP/yzamzaGUE3kp1zElxb6zRLuzxKl/sD6W8ShOa3O
         Rrm7hcJQQxnlEKXz2IJPKhKCRhvSrms6NL7gqnEOiuf2F/OTPVJYY4S/EdF799v8m/K4
         9nEwXtLP4/kd0A+B0mc+MZJYkFFhkaprA6XPJer+BsnEObqC98UZZrV74zkhlDuPVWrM
         Ahba3e5MFyL7hGFYChdcSBzi6SogoQdDGFN78u1WPbf33uvVibQk9s6IUJO7E0zZ7oyW
         Z7Ag==
X-Gm-Message-State: AOJu0YxaRx0iMMEjUuH+fzHe/0XIWDkyGRYWdEtcqbZLxg+oKBU9djbc
	VrcEEoEiLbof1A9c+5Xs3dlTf1fQM4ooiO3+i4L602UHj2YFWRR/j57sXxFFseQmzA9sR0Scaht
	h3NnUkwiQcJx7lvH/JzriIhgwB093qWlb3kerdNo8XYoZrKRXTITIfPlDJMpmtZYMteMU3Gt7XW
	kzzA==
X-Gm-Gg: ASbGncsVCEPhAM7s1onkVceoulejACli3U7N6dHHAUHsEcC8EELQUxuw3RDCWhogYyd
	/45z4Rqrwc8w1XQkr/qKua0OeVRR7JQ9fx7rrAZJ5SwZpMyt9kOduF3qsoy0Cfsgyz4c4LLP+bQ
	7nGlH+aTaaeOenlsl/+YJ3mDs4th4fgdzB5miFm7zMjeFlDRAwjt2rixhMO32tCE6e6OVAGFv5J
	0pUAaKE1IFgD245hIHBm4N1O4DIuh8R12xWGlcA4RfOjeyOmqubKuPtlDoYdqYyzDmaPvNa9yF1
	RHkH+CAGg0x9icIWmtuGniXfIILY154Wl7Ef0t7Mrg==
X-Received: by 2002:a05:6000:184f:b0:3f9:bc33:2fab with SMTP id ffacd0b85a97d-3f9bc333465mr4024939f8f.60.1758533157373;
        Mon, 22 Sep 2025 02:25:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7fSov+1CGFL3df2Ud9PtHq3VhZvRxdYHyIR+xrzsZf0CNdXIba9+m6tklp40NhmnBLxQYvQ==
X-Received: by 2002:a05:6000:184f:b0:3f9:bc33:2fab with SMTP id ffacd0b85a97d-3f9bc333465mr4024904f8f.60.1758533156898;
        Mon, 22 Sep 2025 02:25:56 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.126.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3fee58e6e25sm3153566f8f.58.2025.09.22.02.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:25:56 -0700 (PDT)
Date: Mon, 22 Sep 2025 11:25:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, 
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] tpm: Use -EPERM as fallback error code in tpm_ret_to_err
Message-ID: <tnxfamnvxoanaihka3em7ktmzkervoea43zn2l3mqxvnuivb6n@p5nn34vns3zf>
References: <20250922072332.2649135-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250922072332.2649135-1-jarkko@kernel.org>

On Mon, Sep 22, 2025 at 10:23:32AM +0300, Jarkko Sakkinen wrote:
>From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>
>Using -EFAULT here was not the best idea for tpm_ret_to_err as the fallback
>error code as it is no concise with trusted keys.
>
>Change the fallback as -EPERM, process TPM_RC_HASH also in tpm_ret_to_err,
>and by these changes make the helper applicable for trusted keys.
>
>Cc: stable@vger.kernel.org # v6.15+
>Fixes: 539fbab37881 ("tpm: Mask TPM RC in tpm2_start_auth_session()")
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>---
> include/linux/tpm.h                       |  9 +++++---
> security/keys/trusted-keys/trusted_tpm2.c | 26 ++++++-----------------
> 2 files changed, 13 insertions(+), 22 deletions(-)
>
>diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>index dc0338a783f3..667d290789ca 100644
>--- a/include/linux/tpm.h
>+++ b/include/linux/tpm.h
>@@ -449,13 +449,16 @@ static inline ssize_t tpm_ret_to_err(ssize_t ret)
> 	if (ret < 0)
> 		return ret;
>
>-	switch (tpm2_rc_value(ret)) {
>-	case TPM2_RC_SUCCESS:

I slightly prefer the `case TPM2_RC_SUCCESS` but I don't have a strong 
opinion.

>+	if (!ret)
> 		return 0;

If we want to remove the `case TPM2_RC_SUCCESS`, can we just merge this 
condition with the if on top, I mean:

	if (ret <= 0)
		return ret;

>+
>+	switch (tpm2_rc_value(ret)) {
> 	case TPM2_RC_SESSION_MEMORY:
> 		return -ENOMEM;
>+	case TPM2_RC_HASH:
>+		return -EINVAL;
> 	default:
>-		return -EFAULT;
>+		return -EPERM;
> 	}
> }
>
>diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
>index 024be262702f..e165b117bbca 100644
>--- a/security/keys/trusted-keys/trusted_tpm2.c
>+++ b/security/keys/trusted-keys/trusted_tpm2.c
>@@ -348,25 +348,19 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> 	}
>
> 	blob_len = tpm2_key_encode(payload, options, &buf.data[offset], blob_len);
>+	if (blob_len < 0)
>+		rc = blob_len;
>
> out:
> 	tpm_buf_destroy(&sized);
> 	tpm_buf_destroy(&buf);
>
>-	if (rc > 0) {
>-		if (tpm2_rc_value(rc) == TPM2_RC_HASH)
>-			rc = -EINVAL;
>-		else
>-			rc = -EPERM;
>-	}
>-	if (blob_len < 0)

nit: since `blob_len` is not accessed anymore in the error path, can we 
avoid to set it to 0 when declaring it?

Thanks,
Stefano

>-		rc = blob_len;
>-	else
>+	if (!rc)
> 		payload->blob_len = blob_len;
>
> out_put:
> 	tpm_put_ops(chip);
>-	return rc;
>+	return tpm_ret_to_err(rc);
> }
>
> /**
>@@ -468,10 +462,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
> 		kfree(blob);
> 	tpm_buf_destroy(&buf);
>
>-	if (rc > 0)
>-		rc = -EPERM;
>-
>-	return rc;
>+	return tpm_ret_to_err(rc);
> }
>
> /**
>@@ -534,8 +525,6 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> 	tpm_buf_fill_hmac_session(chip, &buf);
> 	rc = tpm_transmit_cmd(chip, &buf, 6, "unsealing");
> 	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
>-	if (rc > 0)
>-		rc = -EPERM;
>
> 	if (!rc) {
> 		data_len = be16_to_cpup(
>@@ -568,7 +557,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>
> out:
> 	tpm_buf_destroy(&buf);
>-	return rc;
>+	return tpm_ret_to_err(rc);
> }
>
> /**
>@@ -600,6 +589,5 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
>
> out:
> 	tpm_put_ops(chip);
>-
>-	return rc;
>+	return tpm_ret_to_err(rc);
> }
>-- 
>2.39.5
>


