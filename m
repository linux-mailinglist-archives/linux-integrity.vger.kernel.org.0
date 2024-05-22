Return-Path: <linux-integrity+bounces-2557-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D49548CC3A0
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 16:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036E11C2136A
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 14:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668311E4AB;
	Wed, 22 May 2024 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGq/vWpx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F3A20DC3;
	Wed, 22 May 2024 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389905; cv=none; b=MIMoj1RBYpcSJl5H1JX86fbqre2zwSAUSLNv1w5HXcdDvc8uWUZ85vZ5hf6hOu+6TTdsP8MWDtj0ydzbmrIyFHxWKyHujtgQT2v4X0J9r1zS4gyoNBs8pVxtKM1JkBLxxx8Kc8FKYxGCRIpdwuee62HZH5HjYEKcZSgCx7U04MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389905; c=relaxed/simple;
	bh=XN9q7pfoZyp2ltqc8vW26QnT8MPfP4Q9y9CZKqpIp2Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jDFJ3ZwdQQp0+ddfmjlIv23yohJQw34k/VLTSAhyBNmJMx7XL+GYGe5ZoKMLhyG2jOFmijnYK/L4kHNs+CLumQUBCSrJkcAV7LxWBGwuo79+Oq0ZTiOT8UfNHOgGqMRRnKUJS556XIWOO5f3sS/6PObLGnz2iKWg0lyXNQepkeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGq/vWpx; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-351b683f2d8so731274f8f.3;
        Wed, 22 May 2024 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716389902; x=1716994702; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7IEPcq2lTeRu7a0OQTydzeGeJjKD2AmTI+1q/3ymA0s=;
        b=DGq/vWpxhKU8zZ0Ot8HFsA0BadqS3vEY1f9lHv57Lrf1fijC458ELFkOzJs695boDo
         G2/EGJgjAnk0+fhgHekaARyd2CDS5xpTht9GIplrqEiuPRoUKvXFwhSgdFQDYgW5An0x
         GEYVdRKAp1bB6Y1thJPA0rFaY2Pne1s1HZVHVZrrPqT2exuFcXQWnYjjrogLjN5GMegA
         uV0kxPWVBF5dsio5VldzvkbzwJZJLrKaCERCTMyA3R5ybSlQnNZfOy7ca32NOgb/ABGp
         c+kOvvypJboL6vJZLfZCn8ObOLRzGTGDs/MkfIVTfgSr7uh+WJrdk1O9I5Pyacoxw7Ua
         000w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716389902; x=1716994702;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7IEPcq2lTeRu7a0OQTydzeGeJjKD2AmTI+1q/3ymA0s=;
        b=QhZhQjD97dobeyfWtCUR+PjEGYBUi/FwKVYiIffhcSUG8XqLV66pFFs3RxN859SZTP
         jA/RE+gqaXL5Ww7dBKS4Jzh5wo2urd155wdfpjq04qBHSaIDTuJxN/E3I9hxwEGmhVpV
         4bScnjvfObjNux0+xXKaUNLsVM7wwey3IY5pDmBM68BPoVKb6Z7xHlXtWL1MqWLAuNNX
         s2I27f0b91n9vyuENp83iDwL+zE9LHrYiPJr5+cL9Zg/NyWu81s9wXYUCO/SQYjo2wbo
         p5kP7K1I8jujIyEsqf1G27BmhDJo2hHUtzHaMUKjXYbyfrfq5x2dxtW2nOlyX/sztP68
         oJyg==
X-Forwarded-Encrypted: i=1; AJvYcCWJeE4UWifTtd4tjIzoKQ3NGRdxQmx/TZ6QFs7U+nTXwlQGA2x9YT7I1cmCIWREaM/h+Mbmx5ezJ4sF9NlRUEKVNBqd4/JVv6ghHfcUjwZ0y2A/QKXz/b3qUGFk4ephd2A7H22w5EFQb/kQ03Eiv2406UW3krI7RUDgj98CtPOLvjo/H+xmen+B7GxWKsqACRLMav4a
X-Gm-Message-State: AOJu0YzJIgRylKaLP7awlR9Fj427lwqf2wRd3GxuK+Wuz0SFvbaRXuj1
	ZWMQ8IQ/KTrR7H0f/CI0tMjzIE+QNXwFnViMPfopXKSSUCPGjuQc
X-Google-Smtp-Source: AGHT+IGk6oQ6BcwPJumweQH7i5dvpil/X4R33QMqHg4uhptf+9bkM+ey5K+ROmbS85J8j6eUkancoQ==
X-Received: by 2002:adf:ea02:0:b0:34a:d5e:afd2 with SMTP id ffacd0b85a97d-354d8c7c9ffmr1471648f8f.4.1716389901816;
        Wed, 22 May 2024 07:58:21 -0700 (PDT)
Received: from ?IPv6:2001:8a0:e622:f700:597:127d:3af6:7529? ([2001:8a0:e622:f700:597:127d:3af6:7529])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-352f264c7f1sm14682397f8f.42.2024.05.22.07.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 07:58:21 -0700 (PDT)
Message-ID: <0c12c9ea10aa97e246230fc33e6b35c571102b48.camel@gmail.com>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: Vitor Soares <ivitro@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, James Bottomley
	 <James.Bottomley@HansenPartnership.com>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>, David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Wed, 22 May 2024 15:58:20 +0100
In-Reply-To: <D1G8HOCIDWTC.2ERVA0CYHLY0B@kernel.org>
References: <20240519235122.3380-1-jarkko@kernel.org>
	 <20240519235122.3380-2-jarkko@kernel.org>
	 <850862655008f84ef0b6ecd99750e8dc395304d1.camel@gmail.com>
	 <D1F4V8NMSUNZ.2VCTEKHZZ0LB@kernel.org>
	 <17dc838120b56ce342c34611596c7b46dcd9ab5a.camel@HansenPartnership.com>
	 <2dd8d49516ec9c7cb8c1182b5b8537b1e82d7067.camel@gmail.com>
	 <17a5dcd7aceb356587ef7c8f45b0f6359b2d2a91.camel@HansenPartnership.com>
	 <D1G8HOCIDWTC.2ERVA0CYHLY0B@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-22 at 17:13 +0300, Jarkko Sakkinen wrote:
> On Wed May 22, 2024 at 4:35 PM EEST, James Bottomley wrote:
> > On Wed, 2024-05-22 at 09:18 +0100, Vitor Soares wrote:
> > > On Tue, 2024-05-21 at 08:33 -0400, James Bottomley wrote:
> > > > On Tue, 2024-05-21 at 10:10 +0300, Jarkko Sakkinen wrote:
> > > > > This benchmark could be done in user space using /dev/tpm0.
> > > >=20
> > > > Let's actually try that.=C2=A0 If you have the ibmtss installed, th=
e
> > > > command to time primary key generation from userspace on your tpm
> > > > is
> > > >=20
> > > > time tsscreateprimary -hi n -ecc nistp256
> > > >=20
> > > >=20
> > > > And just for chuckles and grins, try it in the owner hierarchy as
> > > > well (sometimes slow TPMs cache this)
> > > >=20
> > > > time tsscreateprimary -hi o -ecc nistp256
> > > >=20
> > > > And if you have tpm2 tools, the above commands should be:
> > > >=20
> > > > time tpm2_createprimary -C n -G ecc256
> > > > time tpm2_createprimary -C o -G ecc256
> > > >=20
> > > > James
> > > >=20
> > > >=20
> > >=20
> > > Testing on an arm64 platform I get the following results.
> > >=20
> > > hmac disabled:
> > > =C2=A0 time modprobe tpm_tis_spi
> > > =C2=A0 real=C2=A0=C2=A0=C2=A0 0m2.776s
> > > =C2=A0 user=C2=A0=C2=A0=C2=A0 0m0.006s
> > > =C2=A0 sys=C2=A0=C2=A0=C2=A0=C2=A0 0m0.015s
> > >=20
> > > =C2=A0 time tpm2_createprimary -C n -G ecc256
> > > =C2=A0 real=C2=A0=C2=A0=C2=A0 0m0.686s
> > > =C2=A0 user=C2=A0=C2=A0=C2=A0 0m0.044s
> > > =C2=A0 sys=C2=A0=C2=A0=C2=A0=C2=A0 0m0.025s
> > >=20
> > > =C2=A0 time tpm2_createprimary -C o -G ecc256
> > > =C2=A0 real=C2=A0=C2=A0=C2=A0 0m0.638s
> > > =C2=A0 user=C2=A0=C2=A0=C2=A0 0m0.048s
> > > =C2=A0 sys=C2=A0=C2=A0=C2=A0=C2=A0 0m0.009s
> > >=20
> > >=20
> > > hmac enabled:
> > > =C2=A0 time modprobe tpm_tis_spi
> > > =C2=A0 real=C2=A0=C2=A0=C2=A0 8m5.840s
> > > =C2=A0 user=C2=A0=C2=A0=C2=A0 0m0.005s
> > > =C2=A0 sys=C2=A0=C2=A0=C2=A0=C2=A0 0m0.018s
> > >=20
> > >=20
> > > =C2=A0 time tpm2_createprimary -C n -G ecc256
> > > =C2=A0 real=C2=A0=C2=A0=C2=A0 5m27.678s
> > > =C2=A0 user=C2=A0=C2=A0=C2=A0 0m0.059s
> > > =C2=A0 sys=C2=A0=C2=A0=C2=A0=C2=A0 0m0.009s
> > >=20
> > > =C2=A0 (after first command)
> > > =C2=A0 real=C2=A0=C2=A0=C2=A0 0m0.395s
> > > =C2=A0 user=C2=A0=C2=A0=C2=A0 0m0.040s
> > > =C2=A0 sys=C2=A0=C2=A0=C2=A0=C2=A0 0m0.015s
> > >=20
> > > =C2=A0 time tpm2_createprimary -C o -G ecc256
> > > =C2=A0 real=C2=A0=C2=A0=C2=A0 0m0.418s
> > > =C2=A0 user=C2=A0=C2=A0=C2=A0 0m0.049s
> > > =C2=A0 sys=C2=A0=C2=A0=C2=A0=C2=A0 0m0.009s
> >=20
> > That's interesting: it suggests the create primary is fast (as
> > expected) but that the TPM is blocked for some reason.=C2=A0 Is there
> > anything else in dmesg if you do
> >=20
> > dmesg|grep -i tpm
> >=20
> > ?
> >=20
> > Unfortunately we don't really do timeouts on our end (we have the TPM
> > do it instead), but we could instrument your kernel with command and
> > time sent and returned.=C2=A0 That may tell us where the problem lies.
>=20
> If there was possibility to use bpftrace it is trivial to get histogram
> of time used where. I can bake a script but I need to know first if it
> is available in the first place before going through that trouble.
>=20
> BR, Jarkko

I did run with ftrace, but need some more time to go through it.

Here the step I did:
kernel config:
  CONFIG_FUNCTION_TRACER
  CONFIG_FUNCTION_GRAPH_TRACER

ftrace:
  # set filters
  echo tpm* > set_ftrace_filter

  # set tracer
  echo function_graph > current_tracer

  # take the sample
  echo 1 > tracing_on; time modprobe tpm_tis_spi; echo 0 > tracing_on

regards,
Vitor Soares

