Return-Path: <linux-integrity+bounces-7625-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C02EC5C577
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Nov 2025 10:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F31D035F21F
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Nov 2025 09:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517AD3081AC;
	Fri, 14 Nov 2025 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRVIg1Ih"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD0B302CB6
	for <linux-integrity@vger.kernel.org>; Fri, 14 Nov 2025 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112892; cv=none; b=D7eWhKkHL6oLxgir0ZIqCP2R9BBmvu6A56LXy6BxKJJE7DSsPMjSUHdaVmUU4BoL0HZgzzkp2j6RzsUXApiEDXAWVBtS+npfeUc7Aw8qprha3Jzie2CB/1xsZCCAtigxVpaOX0jMgDSREzyOjACW4xSodPpH6kFK0ZKf0rxXJSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112892; c=relaxed/simple;
	bh=C8PM7WxuPGZdfL2k/hswcOqc/x9TppYivbKp35Py/N4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgimC8hf9B+Hvs/xBS20/hqBExArxS16I+3qQJAJdKMroRMhMZ/9x4UfKxYBekz3IHayTP3nwkXSlitF9xclglUHZnEBqvcbyXTWFfhpXI7c9xKqK8l0zUKzr1WiIpBIftgFhhHRzUSZ/w1TpX0iFj0qOW218TTZ6pBas6wtW8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRVIg1Ih; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so13025395e9.3
        for <linux-integrity@vger.kernel.org>; Fri, 14 Nov 2025 01:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763112888; x=1763717688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIcvV078uJhN54sARrKY1Rqwcca2J3WG/bWTbfWheiQ=;
        b=lRVIg1IhGsjmG62zRqIW0jDcktXfh9q/PpJATyuviAZzYLc8UHQmXvO2YSvaQhWTRl
         noPEUDml0I4cmFggHx4LH9Ygb9LYsmse3lAv2yNe7BHCptZXffV5q54tPu/h4eLqKQ/G
         BBjMRZ377eMLzVyQEPHwOU1a9MkX+qCedmGee7ga2pxB15UCs1SGHcxBiP7aSGdUqcE7
         CIaB1+MzZJtC/XsoPcf6JQcE2E5L/OMX9SAQRR8AgxVjjyyDBOYzwHP5t9ZZ5lPFM5c9
         O3D4oN3c2jsY+XLEQIA2AWaUqwCpWcWJUWr01hLtFFqX7EHi+aNWgpXSkXTLmFh1vFzY
         lRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112888; x=1763717688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BIcvV078uJhN54sARrKY1Rqwcca2J3WG/bWTbfWheiQ=;
        b=JgpuhswU3aEhVX7sn0eSQ3EwbF0mmSMex2PYPn6lHOVSLdKs7S0iTus/D1HzRxm7nW
         6Oo/xe0lpm0vUzPB0glLdUGZ1vQGJh42b7/Sue1d5SsfU7gKTJaWG5LD2yWAQElVmCFN
         3A/VzDtwALHIpJVw+EBRv329wj+csn/xtMuX8yvwarFiLrbAa/RjO6ZAJqM/GT8BzEcA
         P5ehPndvG/2NsB0v67YQAQJvFkefh78zKgfkJ5h7aBhfMpb4Z05knAjN2UWSreEb/3Jt
         Y4FSsAiSoY1I7LH5IMAWRdDtffxaYksM3JRWv35TiksoZiFiz9eRsGIamQGQEfUG3ECq
         dQew==
X-Forwarded-Encrypted: i=1; AJvYcCU23KvEuPUjbOA2jEF7LqHSxLvKv4FDUFn1qKY0//rviMQRGAdQN18LAtMBM6/pPU9KTauHRLZLWEv19PJSrJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza5CecLs43xq18BQRACx4LAu0XuI3nJvGsE/L1i8JRyluxBRHX
	3BGgmYFyFIjIRJ6iQhGzHlaaN9tGC0bv8hrnby693USCEfgc9cEl3t8u
X-Gm-Gg: ASbGncsRsm4mw1f9x6euVx0CSbK8hw4M8tbzSOcqukrWIUTBo/lByh3YB/wOWc27uwQ
	CqQOshr1VpJjn2zp/DvwIcM/ENdXnVev+RA36ZTVRmep4YUZ/lpVvpd37Cz/nkJ9J+sJR6EKmQS
	2CcaoBsU98ej9i12VmxaETKvhg8iLF04v45k7p2Pt7lCCTPyoUBeahtdrr4iZyaFSzxKG8SDfNs
	oj78xwTv1heInIL1+15WTFknvPRBrEoTGMvhOHx8k7i5c9v9Vtj0nMxSIYQvNVI/B8Ceml3TQ5D
	97/GQjWdvHZnJX212BaoF/Ga3Ea1tjRUAQS7LVu67ERTpoXN8nB2vsCU2u3rgjJPOEDJz3pWa+0
	dga+S4vvEcpJPqQimDuCr09ffo2ZWbW/21Opt3+A5QURMDlnZrMFQQaRgRf1HDwMJuWmxPyutJG
	SDjgx/9XlPnZideH4tgOu40UW2HSdUXo9NRu7/YwYxOb1YEL3fmEBD
X-Google-Smtp-Source: AGHT+IHMhMM/WcqOC+40/CZXzxi+sVHMlKI3vfKumXj5CG2qbmIl/AdQzRU5H/oZ2Xbc89Ibz5CWGw==
X-Received: by 2002:a05:600c:a44:b0:477:5aaa:57a6 with SMTP id 5b1f17b1804b1-4778fe69cb3mr22853755e9.10.1763112887580;
        Fri, 14 Nov 2025 01:34:47 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e8e6a1sm131781785e9.11.2025.11.14.01.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:34:47 -0800 (PST)
Date: Fri, 14 Nov 2025 09:34:45 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Eric Biggers <ebiggers@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, linux-hardening@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KEYS: encrypted: Replace deprecated strcpy and
 improve get_derived_key
Message-ID: <20251114093445.0ec74428@pumpkin>
In-Reply-To: <20251113215546.136145-1-thorsten.blum@linux.dev>
References: <20251113215546.136145-1-thorsten.blum@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Nov 2025 22:55:45 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> strcpy() is deprecated; use the safer strscpy() and use its return
> value, the number of bytes copied, instead of calling strlen() on the
> destination buffer again. String truncation can be ignored since
> 'derived_buf' is guaranteed to be large enough.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Revert some changes to include the trailing '\0' even if key_type == 0
>   since this would change the bytes passed to sha256() (Eric Biggers)
> - Use strscpy() and its return value instead
> - Link to v1: https://lore.kernel.org/lkml/20251113135831.98587-1-thorsten.blum@linux.dev/
> ---
>  security/keys/encrypted-keys/encrypted.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
> index 15841466b5d4..94408909f1dd 100644
> --- a/security/keys/encrypted-keys/encrypted.c
> +++ b/security/keys/encrypted-keys/encrypted.c
> @@ -12,6 +12,7 @@
>   */
>  
>  #include <linux/uaccess.h>
> +#include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> @@ -330,23 +331,17 @@ static int get_derived_key(u8 *derived_key, enum derived_key_type key_type,
>  			   const u8 *master_key, size_t master_keylen)
>  {
>  	u8 *derived_buf;
> -	unsigned int derived_buf_len;
> -
> -	derived_buf_len = strlen("AUTH_KEY") + 1 + master_keylen;
> -	if (derived_buf_len < HASH_SIZE)
> -		derived_buf_len = HASH_SIZE;
> +	size_t derived_buf_len;
> +	const char *key_name;
> +	ssize_t len;
>  
> +	derived_buf_len = max(strlen("AUTH_KEY") + 1 + master_keylen, HASH_SIZE);
>  	derived_buf = kzalloc(derived_buf_len, GFP_KERNEL);
>  	if (!derived_buf)
>  		return -ENOMEM;
> -
> -	if (key_type)
> -		strcpy(derived_buf, "AUTH_KEY");
> -	else
> -		strcpy(derived_buf, "ENC_KEY");
> -
> -	memcpy(derived_buf + strlen(derived_buf) + 1, master_key,
> -	       master_keylen);
> +	key_name = key_type ? "AUTH_KEY" : "ENC_KEY";
> +	len = strscpy(derived_buf, key_name, derived_buf_len);
> +	memcpy(derived_buf + len + 1, master_key, master_keylen);
>  	sha256(derived_buf, derived_buf_len, derived_key);

I'm not sure this is an improvement, but has this code ever been correct?
The buffer passed to sha256 is either:
	"AUTH_KEY"'\0'master_key
or
	"ENC_KEY"'\0'master_key
For short master_key the buffer is HASH_SIZE bytes and padded with zeros (ok).
However for long master_key the length is calculated using "AUTH_KEY" so
there is an additional trailing '\0' in the "ENC_KEY" case.

	David



>  	kfree_sensitive(derived_buf);
>  	return 0;


