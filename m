Return-Path: <linux-integrity+bounces-1936-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE160892CA4
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Mar 2024 19:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25AD41F22976
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Mar 2024 18:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D292E3E5;
	Sat, 30 Mar 2024 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=system.is header.i=@system.is header.b="hpojdvj0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD132C6B2
	for <linux-integrity@vger.kernel.org>; Sat, 30 Mar 2024 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711824517; cv=none; b=W4qhW8rjBH1YwZHHR8lVBisAbs7jwoApwdLL7x7O2lg3fzDIjl9HjqamkFqeXYma2Tcdy+70lVMwWD/7PkQe/bsi8FHGFvqeE479xZ3TzfBfHXbJEy5O9T8P0sjahnZ8FGietP9cAq1mk6eGoG/jUyl5yydtk/IOold2LoEVAeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711824517; c=relaxed/simple;
	bh=ChvsaYFkh1mI/1w5mZ+AqNfJp/uxVrmx4+Nf0FhGn/c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nsKpi5tWB2hjjCXwCwT6V7Myxqfs16wt5swys2fPnsqgO2QUE66UHTVL7qTMdKpg6yvtAMwVmC2R7PjrQi6i1bOC+qOeWwHtjX/Raiu4iQrGoAaCPBQZYRYZxIcVHxjhGzhiOKl/maa7IhdOqCTVBDdljbCIQNU2pM/TiVcECJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=system.is; spf=pass smtp.mailfrom=system.is; dkim=pass (1024-bit key) header.d=system.is header.i=@system.is header.b=hpojdvj0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=system.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=system.is
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4155a763f5dso2117455e9.1
        for <linux-integrity@vger.kernel.org>; Sat, 30 Mar 2024 11:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=system.is; s=google; t=1711824513; x=1712429313; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GQpMFBQmZy3Vg/AT6nKbt/KF5VpFsVixMxIUF8A+3Os=;
        b=hpojdvj0W4EqBFPxGIa4zVeooQmCbfdBE1scmU81E/i8N5Zr829qKekR7dluJnoVt/
         vq6dK7L8YCdV92/sYr7f9WgRPmzfBs2yJJW1Q3vHqMwBEab+jtRZ/NH8TxN5eh+fJSpB
         vCSw7BIa8ssPspcbNLvaFNvTg8uz4LQ3g2w/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711824513; x=1712429313;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQpMFBQmZy3Vg/AT6nKbt/KF5VpFsVixMxIUF8A+3Os=;
        b=iuf5mC3am0vhXbeeZU1ZO78e5NGepYm0VvNkXXVqTDlBEqne0D7oEbpT5Ed4tvDABl
         IscMAwo+t0THaZS9fELDnBWmuI/6yQd5tm3QwRmcop6fZTr2qLBxqiwW2A3P7bcFJCBi
         IEAiDm9Of8mw++FKMUD24CesDQdJQTwrmgsw5vfl7H4g0ESGlnMbT+7EGLNWd++Vgeee
         l2hSyNdzbKqS8q+4VTAvN7qjnpnx+oYUSVkk68Od9YhzAd5XJ7p9/DdL68Eg0BeiB4ml
         uzDUa8LgCjfWpZVPK/Wvma/Wc05IPTwBFf/Sne+CrMxoTHpITgdxBPILTCs5L7ZIEaHG
         kmqg==
X-Forwarded-Encrypted: i=1; AJvYcCX0AXOapwcDjZO86rF+ZuHqx6b5yq13LDsBaSQK9OErGo+y6RiJQrO0mWk1xm0Vc0YolsdVqhEpidDbC2VGQWUNxAcPDGyqjOwVfYgEGOlM
X-Gm-Message-State: AOJu0Yw6EgSOltkxnTw9gE7CT/FKwX32+YDr5XVEyXUzTFR1AFN0AUB7
	VvOT0i/c68X4WWyD4DiXp/V7tRMNxlsxLJ58dFg3x8pPWlkqa/+SMr9XPO6pgj4=
X-Google-Smtp-Source: AGHT+IGlSOyw7lUcJBwVAbpeOgf7maGgcyRDenhJfGb1+y5FtcmWWcZqTILIPW0uTzZHXmKfaQESng==
X-Received: by 2002:a05:600c:1907:b0:414:8aaa:acb5 with SMTP id j7-20020a05600c190700b004148aaaacb5mr3777772wmq.16.1711824513450;
        Sat, 30 Mar 2024 11:48:33 -0700 (PDT)
Received: from [89.17.157.224] (224-157-17-89.fiber.hringdu.is. [89.17.157.224])
        by smtp.gmail.com with ESMTPSA id fc11-20020a05600c524b00b0041408e16e6bsm9309717wmb.25.2024.03.30.11.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 11:48:32 -0700 (PDT)
Message-ID: <05c7d10b23e74269efd720eedbb1773931b0ad46.camel@system.is>
Subject: Re: [PATCH v7 12/21] tpm: Add NULL primary creation
From: =?ISO-8859-1?Q?Gabr=EDel_Arth=FAr_?= =?ISO-8859-1?Q?P=E9tursson?=
	 <gabriel@system.is>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, 
	linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org, Ard
	Biesheuvel <ardb@kernel.org>
Date: Sat, 30 Mar 2024 18:48:31 +0000
In-Reply-To: <20240213171334.30479-13-James.Bottomley@HansenPartnership.com>
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
	 <20240213171334.30479-13-James.Bottomley@HansenPartnership.com>
Autocrypt: addr=gabriel@system.is; prefer-encrypt=mutual; keydata=LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptUUlOQkZtUWRjOEJFQUMwWFNNT2l6Z2xsWVUxVFVpS3Y1WDNMQjVuc3JJMythVU5DTmFGTC9PdWtjU3VONitPCmNYQU1Ec1QyS3NuczF6dGVCWmhyYXVYWnc4dWFWWmpNSkRUbmE5cHoxbTM5YkFBTTZmek9aQ01BWWU0bU9VamYKemJqajV3ZlFvVXNaMDF1ekxNeUJUY0Q2SVVFRmY1QzVLU0N6TElSM0g2alp3ZDR0Z3k3dFcyb1FLL2dxOENESQpxUmVVamdmblNEeStuTElJc3ZxL3dFNFRBL0I5MFd5azlrcDVKdEM3UXRDQjhiaGN5TmVCQTcrVXVWVjhSMU9OCno3VXZyOGFnN0RiMmRTVEdTVVdQRi9Qckw5SXM3WTFBTU1FeUMxMEY4SGNTUUo3K3FhdkJ2Q3ZuVCtOUEs2V04KWmF2Q0hqU2FMditlTUFpZGcySXZCM2QzTUxISzl6NTJzK1NFdTFaVzdCRGc1bTdoTjFhSXRQK3pZaFNFSnRNTwp1cXdzTnFWSGhOU3lHNGxTKzRSR2M5QkFnaEc3QzAwN2ZPcGVBS1FZaHJFbkRHR2lkbTJvemhJMW9KVHFKblB0CkJFa1lRZUdlUjh2YVRhMEFHUkRsN3p0amdMWmpaUmM0WXVvb3Z0MEM1N2RFaWNoWVZVL3ZiUHo1WUIwa0c4SnYKb0VKQzFleU9PTHhKTmJMbXFVWThWNS84SVJpWGQ5azRMUFpMOEV0azNIYUhWMHRpWUpqUWd1MXlzT2JjaFZwTAord1JOS3JuUTh0Qml3QTJkdWhQblVjdS9FWGthUGdBK0o4cExULzFlMnVXVHhPNHNxT0ZzbG1DR1FWN1dMNXFZCkNScUExT0NoK2hQ
 SjZHYzdYQ2U1TTYweG8wVHFBaHhuYkFqNWFxdW5pRTNML1dBbGNHUXV5d EFMMXdBUkFRQUIKdEM5SFlXSnl3NjFsYkNCQmNuUm93N3B5SUZERHFYUjFjbk56YjI0Z1BHZGhZbkpwWld4QWMzbHpkR1Z0TG1segpQb2tDVGdRVEFRZ0FPQlloQkxZbU1WWjUvWVU2cWd5d1ZVbXhQKzNjbUUzbUJRSlprSFhQQWhzQkJRc0pDQWNDCkJoVUlDUW9MQWdRV0FnTUJBaDRCQWhlQUFBb0pFRW14UCszY21FM21ISEFQL0EzOHpWQ2ZTalBkMGJXRlpNVzAKM2JLRGN5aDZCUWNRWk1zS0dEUm9MWDJSZjlobUVwZmFFSkZUZDNlR20zcUg1L0VrWERKY2FCRjhGSi9QME9PcAp1KzVHS0xtSnl5L0FBdFJYWnpSMkxSRTM4TEFXOUhzbUt5NXNUakdyK2FhRTdKT1JBOUd6dGFUUWhubG4vN3p0CkE4ZXRVTEpib2g5TCtHbW1iZW5wZWdSRXRPVy9oaFhEejJHVlZJZkRpRDRwT1ZsQXp1b1VmZC9KbHFneHZLdncKcHFkRVErdCsrMkxkWEJUOTQ3bTQ5OW9qcENZQitPbTZWMzBOd2tiVlF1RnFNejFnMlhPZStvVnVUaW44dzFWMgpxQUNlVENPcFhWZkZud1Y0L0ZqcjI2UDhHbzg4Z2ZhYVkyR29pN1A0bC9DOTJXc3F6WDc5VytSU2l3QkdXTi9hCmxNV09Ibm83SGc2anZWcXJSNjFta0d0SzU4S3RPdXpnRTAzTlBqbUMrL3I4RkhzZlFlQjcrNWFaejlyVk9Mc00KNm1vYnVpUWJqWmtJTVU5cHdkLzVWcFRtT0FBdDBPNThFb0xzd1crcm1naFhNdy81bENQZkNxL2IzR3k4RDBlSwpZWUdQME14cGdWZFVSUk1CbFFBUGkvc2xrQnNjL3lmWXZTTUhnSGFyNEk0
 SWk2Ky8wNHg4b0Y3ZGJwbGxsb1JyCmRORE1RdDgzRlBta0NMU3l2b2Z2NC tHQWtxS2dyM3JRVy9wWTdxejRyVTFwamZSTEFGaFVrdk8zd2pocEhjU2cKaDhPdnF3a1drR1UweHZ6cHhuRHdCN2RlNmRGNDA5ODdXVG1YVmhJd2Z0VjZ0SUNwbHJhVnhWLzBiaUlCU0MvTgp3NEg3OThhaGgyNUJmZks3RThhUnJiTk0KPTQ5cU0KLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-13 at 12:13 -0500, James Bottomley wrote:
> +	/* unique: key specific; for ECC it is two points */
> +	tpm_buf_append_u16(&template, 0);
> +	tpm_buf_append_u16(&template, 0);

Shouldn't the points be 32 bytes each in size, filled with zeros?

The TCP TPM 2.0 Provisioning Guidance defines the SRK Template as a
diff on top of Template L-2 (for ECC keys) as defined in the EK
Credential Profile 2.0 document.

Template L-2 calls for the X and Y points to be of 32 bytes each,
filled with zeros. The Provisioning Guidance does not call for zero-
sized points.

For example, let's create an ECC Endorsement Key using the standard
template then print its name:

   tpm2_createek -G ecc -c /dev/null -u ./ek.pub
   tpm2_loadexternal -c n -u ./ek.pub

Equivalently using tpm2_createprimary:

   perl -e 'print "\0"x64' | tpm2_createprimary -C e -o ./ek.pub -G ecc -a =
'fixedtpm|fixedparent|sensitivedataorigin|adminwithpolicy|restricted|decryp=
t' -L 837197674484b3f81a90cc8d46a5d724fd52d76e06520b64f2a1da1b331469aa -u -
   tpm2_loadexternal -c n -u ./ek.pub

You'll find that the key's public modulus matches that of the EK
Certificate imprinted by the manufacturer, indicating we got the
template correct.

To generate a standard SRK key, the TCG TPM2 Provisioning Guidance
states we should:

	1. set userWithAuth,
	2. clear adminWithPolicy
	3. set noDA, and
	4. clear the authorization policy.

There's no mention of alterations to the unique field.

Let's also create the key in the null hierarchy:

   perl -e 'print "\0"x64' | tpm2_createprimary -C n -o ./null.pub -G ecc -=
a 'fixedtpm|fixedparent|sensitivedataorigin|userwithauth|noda|restricted|de=
crypt' -u -
   tpm2_loadexternal -c n -u ./null.pub

The name does not match the kernel's name for the null key.

