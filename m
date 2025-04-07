Return-Path: <linux-integrity+bounces-5642-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DFBA7DEFA
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 15:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FE83B9178
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 13:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECF5253F03;
	Mon,  7 Apr 2025 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAeMkpdg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5E5253B65
	for <linux-integrity@vger.kernel.org>; Mon,  7 Apr 2025 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744032018; cv=none; b=n5fi2cSAoUu2QdNRmVQiACo85T1bPZkLEA1R8AdJmyCEdLDD8MKAQdO65HKHNofMi5bgxfVG3uScGlQ3AccmGTUnjPQIqced5/h6gULqE6wGoCYrFhUfJe5kIENPJjzCRvUsQhcxm+ikcMU3FcnlvBAFB/Ron8yi189Gz8ViefQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744032018; c=relaxed/simple;
	bh=IBAFSYEftFSEOjm2cNkui0kQbyc4fGxVU2sHcdp1J4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXttGLEQ/1a68SBZ+NsWszELdxGvUFii1BEqz5RiHbRJ06UaenWLyzrfmPnuo9srRYvTe56l2dMdqtlYk3d1ia4WutS017ilTpp8VNp7JNPAPZrX0k5K14DuuK6OXKGXE5eqNMPqv5k93MZEQYwGRRneDeYPmtGjJbd4MYA9nd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bAeMkpdg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744032014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=puvyqjVmSzk0HYb0KyLQqy8hU7+rU+A/opPj1bWYc1Q=;
	b=bAeMkpdgieavYfe/pfHJ9cVvV4/OvXgt8/4LKiSEvmc5vWteKr9Rtj3ixI7PK0aac8J++O
	ryTHdfAeeUVD1/Sg+FHG2YEUIznKOPDNsxje2KHQgRc0FTsurDjVRYcPrKp0Z6uWn6ligZ
	5t0GTU0ppDriHQymfQMXEEQd5r3u1Cs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-KAthe07pM2G4hluYzZXfJA-1; Mon, 07 Apr 2025 09:20:12 -0400
X-MC-Unique: KAthe07pM2G4hluYzZXfJA-1
X-Mimecast-MFC-AGG-ID: KAthe07pM2G4hluYzZXfJA_1744032011
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ceb011ea5so29273965e9.2
        for <linux-integrity@vger.kernel.org>; Mon, 07 Apr 2025 06:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744032011; x=1744636811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puvyqjVmSzk0HYb0KyLQqy8hU7+rU+A/opPj1bWYc1Q=;
        b=h0q99RuVK1Q+ZR4aLGUYG2ePQy23XDfm7KTuxCeT91FTh9huBTIdxuYT+fz7r/PWNz
         BluwxZeZD42/5bGsDQ+5vySn7rIzb6/R86T/mdz3MK1YFXEuYBp4yBCoTi+i0I2CmCxy
         VL5lGC6jlCKJvyLSJpGo4ARm5fiY084wNEcGYJbl6wwl3aTqzcg+Ji0Hrvn2JOAAqq35
         8+w5zjGFRzGEWHoNenbB4Uc11zmEBWutzkv8BXvulBbyLnd8YTCMnORT2uOzQUvI8EQF
         yGHNU0rmqdHZnQn1gUfF/oWTsk7t+uvgwl8jp8c1MVu8OnYDAT79o2V2Xh1zKehF510d
         Vz4w==
X-Forwarded-Encrypted: i=1; AJvYcCWE7SpVLjnfZKWW/G3baR4RMTCdxTJ0WuPcS6sNocW+eAKYg1uKRONoXAygGIlEurakKBnX9FQxX7MO4e7z2Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSzxKe/6irmjcFxxTRUWhF8QouBgJ6j3jVHces7GfBQzPmpKsL
	m39BUkhVESK0DTjvTV9aoDRdpG5QBNhVP+2g1NrLo5+9g2wL4G3r6/387wIHxqMJM4AYsHss+MA
	XxLvmpUXfCt2Sfbh5dgbCgVvaqdscqGWQXL9g/EwRm2KS37rDXEUryKUWYEu3GLCucQ==
X-Gm-Gg: ASbGncsSrXIiXk9+Uva7pcPox9EplYiqRoH4dOBHcKPTpsLp1+L9OGWPWZsQkCWgeOu
	K9hLx40+XRbCvWvYUeu8NGG8Vb0Y0+2iTbU2DyQ1f+kp6ioiYkt+WWfF/ZJ8r4QG4Ue/g5viBvA
	sbdrqXKAcaDxPvC7FasEy7/lzrWyDAvz0VDPfJm3lj98zWe3lH/S5uJtOH0e4ptPlakgl0LROon
	kvgSQLw8cJ8rmT24ZmXdCQva7lVrosnbFOoIgeW9Mer9NFYTybggli3zfKieGDG6wtZ5RpBuK7n
	abHsqfKZPY5vMSQw8H2abC9vMAano35HBspBR+OsftpCx+bBCmGFW2uH2B/rbUmK
X-Received: by 2002:a05:600c:510d:b0:43d:2230:303b with SMTP id 5b1f17b1804b1-43ecf9c3e5emr89278715e9.20.1744032011106;
        Mon, 07 Apr 2025 06:20:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEVMmWlPQZtDsnMFLZbMAxM9zqTMfp14GmzwUzy662LRZwj/J32cgeouoGgUEXLfLAfpiOEg==
X-Received: by 2002:a05:600c:510d:b0:43d:2230:303b with SMTP id 5b1f17b1804b1-43ecf9c3e5emr89278465e9.20.1744032010642;
        Mon, 07 Apr 2025 06:20:10 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-213.retail.telecomitalia.it. [79.53.30.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d661sm12381031f8f.66.2025.04.07.06.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 06:20:10 -0700 (PDT)
Date: Mon, 7 Apr 2025 15:20:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org, stable@vger.kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Howells <dhowells@redhat.com>, 
	Lukas Wunner <lukas@wunner.de>, Ignat Korchagin <ignat@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Ard Biesheuvel <ardb@kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] tpm: Mask TPM RC in tpm2_start_auth_session()
Message-ID: <rxygujdrx3d22mv2jcbp2mjr52noyf6c346vi7iljjf4ova2wz@zkoqxvcudi35>
References: <20250407071731.78915-1-jarkko@kernel.org>
 <20250407072057.81062-1-jarkko@kernel.org>
 <2mjtwprr3dujf4wbu5licb3jtzxujimcz5iahrgqymu6znwbbq@cslxwt7ejva3>
 <Z_O3PU5XDbDirlUO@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z_O3PU5XDbDirlUO@kernel.org>

On Mon, Apr 07, 2025 at 02:30:05PM +0300, Jarkko Sakkinen wrote:
>On Mon, Apr 07, 2025 at 10:04:09AM +0200, Stefano Garzarella wrote:
>> On Mon, Apr 07, 2025 at 10:20:57AM +0300, Jarkko Sakkinen wrote:
>> > tpm2_start_auth_session() does not mask TPM RC correctly from the callers:
>> >
>> > [   28.766528] tpm tpm0: A TPM error (2307) occurred start auth session
>> >
>> > Process TPM RCs inside tpm2_start_auth_session(), and map them to POSIX
>> > error codes.
>> >
>> > Cc: stable@vger.kernel.org # v6.10+
>> > Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
>> > Reported-by: Herbert Xu <herbert@gondor.apana.org.au>
>> > Closes: https://lore.kernel.org/linux-integrity/Z_NgdRHuTKP6JK--@gondor.apana.org.au/
>> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>> > ---
>> > v3:
>> > - rc > 0
>> > v2:
>> > - Investigate TPM rc only after destroying tpm_buf.
>> > ---
>> > drivers/char/tpm/tpm2-sessions.c | 31 +++++++++++++++++--------------
>> > include/linux/tpm.h              |  1 +
>> > 2 files changed, 18 insertions(+), 14 deletions(-)
>> >
>> > diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
>> > index 3f89635ba5e8..abd54fb0a45a 100644
>> > --- a/drivers/char/tpm/tpm2-sessions.c
>> > +++ b/drivers/char/tpm/tpm2-sessions.c
>> > @@ -40,11 +40,6 @@
>> >  *
>> >  * These are the usage functions:
>> >  *
>> > - * tpm2_start_auth_session() which allocates the opaque auth structure
>> > - *	and gets a session from the TPM.  This must be called before
>> > - *	any of the following functions.  The session is protected by a
>> > - *	session_key which is derived from a random salt value
>> > - *	encrypted to the NULL seed.
>> >  * tpm2_end_auth_session() kills the session and frees the resources.
>> >  *	Under normal operation this function is done by
>> >  *	tpm_buf_check_hmac_response(), so this is only to be used on
>> > @@ -963,16 +958,13 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
>> > }
>> >
>> > /**
>> > - * tpm2_start_auth_session() - create a HMAC authentication session with the TPM
>> > - * @chip: the TPM chip structure to create the session with
>> > + * tpm2_start_auth_session() - Create an a HMAC authentication session
>> > + * @chip:	A TPM chip
>> >  *
>> > - * This function loads the NULL seed from its saved context and starts
>> > - * an authentication session on the null seed, fills in the
>> > - * @chip->auth structure to contain all the session details necessary
>> > - * for performing the HMAC, encrypt and decrypt operations and
>> > - * returns.  The NULL seed is flushed before this function returns.
>> > + * Loads the ephemeral key (null seed), and starts an HMAC authenticated
>> > + * session. The null seed is flushed before the return.
>> >  *
>> > - * Return: zero on success or actual error encountered.
>> > + * Returns zero on success, or a POSIX error code.
>> >  */
>> > int tpm2_start_auth_session(struct tpm_chip *chip)
>> > {
>> > @@ -1024,7 +1016,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
>> > 	/* hash algorithm for session */
>> > 	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
>> >
>> > -	rc = tpm_transmit_cmd(chip, &buf, 0, "start auth session");
>> > +	rc = tpm_transmit_cmd(chip, &buf, 0, "StartAuthSession");
>> > 	tpm2_flush_context(chip, null_key);
>> >
>> > 	if (rc == TPM2_RC_SUCCESS)
>> > @@ -1032,6 +1024,17 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
>> >
>> > 	tpm_buf_destroy(&buf);
>> >
>> > +	if (rc > 0) {
>>
>> To avoid the nesting blocks, can we include `TPM2_RC_SUCCESS` case in the
>> switch or move the `if (rc == TPM2_RC_SUCCESS)` before it?
>
>What do you mean by "avoiding nesting blocks"?

Ooops, I thought `rc` was unsigned always returning TPM2_RC_* values,
but it looks it's not the case.

I meant the switch "block" inside the if block, at the end exactly what
you did in tpm_to_ret() in v4 :-)

Thanks,
Stefano


