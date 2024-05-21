Return-Path: <linux-integrity+bounces-2500-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BEA8CA855
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 09:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EB6BB20F5A
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 07:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BD0433C0;
	Tue, 21 May 2024 07:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="km+FGFD3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6C67F;
	Tue, 21 May 2024 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716275012; cv=none; b=CeWm1g3IA/OE1ixwtZNqOSDkT0MqpwtLtdOXDpdb5WVs3ix1EsDf4I7WlnWWICdubtSdBoxSbWZh1xTpClqn1bMAieS/W00gwNFn5tM1KheXsizQK9eE9T4T7/D2ik8JpOc5Oi4U+a1/cD1X2+hTdoaacgJQHITDDd8S1vEgp8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716275012; c=relaxed/simple;
	bh=u3CzgZI3h6Zg9NQorYxVO1gGZ9hrIRBuBi4cULF3hrE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l1BcXKiorylxirG3qQMXGgs3WrEM6dKiEEJjTjP75F6MuJp9Q9OhpgpzEWRiJrjJkt1E9Vl2s5b86b/6jO5aMO98fI/qhCSedzYdaXf205Bsw9A29O5lTsrPFce2wtQ56WFmA/5upEaAVDHjZ3e8zfLmeF/4mGfs3ysbBvLFa6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=km+FGFD3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-420104e5336so17698565e9.1;
        Tue, 21 May 2024 00:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716275009; x=1716879809; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WxF5n7qDkRueSSj0xKO3Ah7fjyguZUL6aRwMvg17H9s=;
        b=km+FGFD3QgdAAZvciPVURock+M1T3QouCm4dS96CwsHJlaWnxMa6fQZIs1JAoFWeYO
         54MNp2WMqSqzPRaqpzTqGSWPBiPUezzj+3+eZ/IkQMKSIJYSaDhwkuEB+dFDN8V3dn7t
         xvXK5EdZ+R6NLIMCZOfhgd1AOyQ3z8+86ZDp6tL7dv6b2O7erfsHgLgkSt/RubC1M9ER
         HYXyiw5B2EVWUkRUMawqcaPavuZxG8zM+k3H62NT8jPpmlRiS4IbgPap5LBEbTQ5M0oi
         73Je/7CV+IpM1s8KLVcLqoa8eQRFgpdXl6v5eaTh/rn2z0Y38mkFskibaNz32l4sUOnN
         BOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716275009; x=1716879809;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WxF5n7qDkRueSSj0xKO3Ah7fjyguZUL6aRwMvg17H9s=;
        b=RrclKuu14WpNro2dHv42cjhI/SB71gQfOyLxDGSi/nL153JjurH38bjYuE2ntcIij5
         6jVUbxgJh8lpg8gAN4t4weldRavjC3fPEHWZXa90lvBGRpYFM2PWtzchs0za/Wmt+us5
         la1QB65L72SSaLpUsw0dGzlrW8r7OM+2HIitWmQ91Sx7nVMrcDxxPF35+wEyzSD7ihBq
         9TPuC3y6j5X74KdbLIAChYN0NirgmyzZoZ/atSuxedKlMdw1R7VU8njJ2mQxfFP0cahl
         OTcAQ7X+kaD6mFbLuM47szAS/0bkvBd1eydl5waC94kqbVhNOu24uim2OVIJgQvfIRLK
         gr8w==
X-Forwarded-Encrypted: i=1; AJvYcCWcbmTYEyJUiKfgAqpguZOsBJW33awQWe9+7mfDTKAWK67ZrouszgcyngGzpJSmekSiC4d+O8ySlxZJZIcJh1L8ZvN0I3s3iPXwaFEI1L7dTiPqtqF+inT81Dok/46Usy47/VOm5eV+4oQpN96q1FPZaiJPtSdjoglS7d6qQ2WkU2gRXQRPOX0f5QA5K2ejo9kfA7n0
X-Gm-Message-State: AOJu0Yx8uio5O61foOe8qYZG0d0TgCuIL4febGhMtvhO8BJjSnR213xc
	7geTXZuaqt2P9iI3+2NPzEQDGukOEI3pbO3/EI0/YpSTf2aChB/v
X-Google-Smtp-Source: AGHT+IFaTrabiwR+w+lWFOxZDRlmiUnzq7DKLoUptWC+HaO1u/vttdXzcVKESVVjIhge8Io1WarqkA==
X-Received: by 2002:a05:600c:1c90:b0:418:c6a:1765 with SMTP id 5b1f17b1804b1-420e1a2f67fmr73717055e9.16.1716275008983;
        Tue, 21 May 2024 00:03:28 -0700 (PDT)
Received: from ?IPv6:2001:8a0:e622:f700:5c54:f235:e62f:720e? ([2001:8a0:e622:f700:5c54:f235:e62f:720e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42016a511a7sm323822455e9.0.2024.05.21.00.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 00:03:28 -0700 (PDT)
Message-ID: <850862655008f84ef0b6ecd99750e8dc395304d1.camel@gmail.com>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: Vitor Soares <ivitro@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, James.Bottomley@HansenPartnership.com, Peter
 Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Mimi Zohar
 <zohar@linux.ibm.com>,  David Howells <dhowells@redhat.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,  "Serge E. Hallyn"
 <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org
Date: Tue, 21 May 2024 08:03:24 +0100
In-Reply-To: <20240519235122.3380-2-jarkko@kernel.org>
References: <20240519235122.3380-1-jarkko@kernel.org>
	 <20240519235122.3380-2-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jarkko,

On Mon, 2024-05-20 at 02:51 +0300, Jarkko Sakkinen wrote:
> Causes performance drop in initialization so needs to be opt-in.
> Distributors are capable of opt-in enabling this. Could be also handled b=
y
> kernel-command line in the future.
>=20
> Reported-by: Vitor Soares <ivitro@gmail.com>
> Closes:
> https://lore.kernel.org/linux-integrity/bf67346ef623ff3c452c4f968b7d90091=
1e250c3.camel@gmail.com/#t
> Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> =C2=A0drivers/char/tpm/Kconfig | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index e63a6a17793c..db41301e63f2 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -29,7 +29,7 @@ if TCG_TPM
> =C2=A0
> =C2=A0config TCG_TPM2_HMAC
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "Use HMAC and encryp=
ted transactions on the TPM bus"
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default y
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default n
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select CRYPTO_ECDH
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select CRYPTO_LIB_AESCFB
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select CRYPTO_LIB_SHA256

I did the test on my side, and with TCG_TPM2_HMAC set to "n" the time to pr=
obe
tpm_tis_spi driver has reduced to:
real    0m2.009s
user    0m0.001s
sys     0m0.019s

Thanks for your help.

Best regards,
Vitor Soares

