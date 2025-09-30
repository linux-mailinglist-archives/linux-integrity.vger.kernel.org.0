Return-Path: <linux-integrity+bounces-7315-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A068BACC99
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 14:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB8C17C7C4
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 12:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BE01B4236;
	Tue, 30 Sep 2025 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9uz80kz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC4825D527
	for <linux-integrity@vger.kernel.org>; Tue, 30 Sep 2025 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759234369; cv=none; b=Pa1VPS9jnQkzZplEM7qUJD/5iwFGhfOQqbx6NDkyKDMBuHHv1tNxtrpwjMv0ry3cPyp9/X9379m6rGDwixx/TAlcOrlTbnQ8Y9ow3/L+RRfepG6KXr3uv+yeHYNSn4/Kj5ha2Y+OhUix1XikBW90jlXo1BPtKAMdUUf1WOl4FAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759234369; c=relaxed/simple;
	bh=8hAe6inhz0E/QWnBDuNMlbdqmEfM/Hzecqaiue2MllA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBcQ2WLuLmm+bJfbzT/l599ONln8UyfNIumPEG0wRh6T5sUQYIKtpss6SeBwuuhZZK6vLVUb6qTacCc5z1t260sbPkb+ss9UuKSuLi6I23+xZGb0XK06YIQOKQjWS532Xv+IK5Yy4G0Tort+5V2dW3ujNHe32ta28koOrScJTGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C9uz80kz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759234366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CWIgSoKL3urKBOhTmtSOXc8Pl4O+FoLwxpjwzaySij8=;
	b=C9uz80kznLvVCdCiEkKy0EsM65IkkAxBmnhmxWsd5pIl1QmPj0arT4eOf1FEDajgGGEP9L
	oZi6J5AHZH1VXQl9fvky+HmzuIYt6WzQpe+1sdAeN38eJIaT0BIxRZVGtcj1O+7eB+X8XJ
	w8jjArwkBkaheLszZ0EUO+1epNSEuNE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-mYWeX8zNN46xwBWfMe4dyQ-1; Tue, 30 Sep 2025 08:12:44 -0400
X-MC-Unique: mYWeX8zNN46xwBWfMe4dyQ-1
X-Mimecast-MFC-AGG-ID: mYWeX8zNN46xwBWfMe4dyQ_1759234364
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b4068ff9c19so170741066b.0
        for <linux-integrity@vger.kernel.org>; Tue, 30 Sep 2025 05:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759234363; x=1759839163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWIgSoKL3urKBOhTmtSOXc8Pl4O+FoLwxpjwzaySij8=;
        b=vRKPmwOXUHkWFTtCo9FiC8z0Qp7/mUJwwXlTO5DnO4kfMBU1ODUbb70SxR/x2b/dHX
         dd8dbkr620WCCJRRPQHTrum3C7gCQ8tzxPzqeMnQ9odo5RcbsdWw42BUThS+j3x75HLV
         4eqn5Mf4acofjMsjB3seS4J09WMHidwcNvhUqGWCOms0RnXq/23jjmjlwCiRbL6aYkiP
         caMrzmd3QMc0IOmKRNaHJbuRI6zcFlq7yC/pQ43gQaP+jKeWw+J1RbPBpRZ/6Bn86N4F
         LCfOMFvJwmJKa7YhbuxLrEPakcJhzsIYIPgHkhMdWLshaGPHFtS4fJBYSbA4naE9jSk8
         RgsA==
X-Gm-Message-State: AOJu0Yy0z2hB2VTS1sReup9KVG7NT9t/fAWthavYmMzXYX9oCekKfUgY
	b/UXyEBUFhYP1tcBPPWmm8Th6MBXmz1G3+kY4CXMm1lnWKuikALLk9Aue3BIZid4ooXErWQ+djw
	yVq68lfLHp6FndCwrS3Mt2wuSxvHnWmUMTpB+Zrwfj6tes6wEpBD0tqMqBdLsBPBntkVbmw==
X-Gm-Gg: ASbGnctAVPVlaTOQQQmDKApY9TkVTagh8//TNmmkmCoUk6GhRCDwNQln3j1pjS55Eag
	Rthl40er0dcwFrlsK7l8EEnHc96y2Gf9w4M7vqzFn4uyhui8gsXlt6ro+8+36iQFLKzZJB/gg7A
	hwWRhOHLIVu2sqyzm1TxA8uf582R2bQnbFTrxu3BeWos4pKxSFpPzORZgn4nIpRLztyi9gYqZKg
	VbAEhNMa6kRDvhlxZ4HqPwsrGzII6qa6ikwyMHKiOqMx3DfMT9WRFy/1LTqot8p+oe73TqCqyLT
	RNxkX76ATRXpjkjLcwGUDUNwL1wfJgZU7/r6Jb9uSLnD0Kq2nmG/TCn8c+BqAnMnWYbq8kY5Jnc
	3o3E3MXqqHLp4A3qEnxk/ag==
X-Received: by 2002:a17:907:3c8f:b0:b04:36bb:545 with SMTP id a640c23a62f3a-b34bb12fc3dmr2371562766b.48.1759234363472;
        Tue, 30 Sep 2025 05:12:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCMW+GDcVwUnAC/efDdJR1OCcQoMagIWww3faxZxGxD2S8ezNsWbFnZUmUdO9qvxkKur0+NA==
X-Received: by 2002:a17:907:3c8f:b0:b04:36bb:545 with SMTP id a640c23a62f3a-b34bb12fc3dmr2371558866b.48.1759234363046;
        Tue, 30 Sep 2025 05:12:43 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3b05779sm9854125a12.49.2025.09.30.05.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:12:42 -0700 (PDT)
Date: Tue, 30 Sep 2025 14:12:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, dpsmith@apertussolutions.com, 
	ross.philipson@oracle.com, Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/10] KEYS: trusted: Use tpm_ret_to_err() in
 trusted_tpm2
Message-ID: <7icpto3rnm2f4u6zaxl4xy7zvar3q4hhpgelq2gnazszdkwc3m@5dtivkqs5xdg>
References: <20250929194832.2913286-1-jarkko@kernel.org>
 <20250929194832.2913286-4-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250929194832.2913286-4-jarkko@kernel.org>

On Mon, Sep 29, 2025 at 10:48:25PM +0300, Jarkko Sakkinen wrote:
>From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>
>Use tpm_ret_to_err() to transmute TPM return codes in trusted_tpm2.
>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>---
>v3:
>- No changes.
>v2:
>- New patch split out from the fix.
>---
> security/keys/trusted-keys/trusted_tpm2.c | 26 ++++++-----------------
> 1 file changed, 7 insertions(+), 19 deletions(-)

Nice clean up!

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

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
>


