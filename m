Return-Path: <linux-integrity+bounces-1669-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D514D875E52
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Mar 2024 08:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780521F22CE3
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Mar 2024 07:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2703FBAB;
	Fri,  8 Mar 2024 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="wY2EXBE3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D892D4EB42
	for <linux-integrity@vger.kernel.org>; Fri,  8 Mar 2024 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709882270; cv=none; b=sxtzQNVeZZet5CukIbrmGow/RrxJwsmF9O0ZFUzx6QnZqs9UdHgE8WKRmyIaGz7tPkqFK2Uo9U1PAyb55KYvWHwrifrDPsr9bLqQvAEzbrUhswY58Av1xDNK1qG6OXYa6pu0HllK33fEzLDWvirr4/T4ZCKyekIpm9j7KWT+pF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709882270; c=relaxed/simple;
	bh=7YvX8bPEV2BI0BpF/k+pwUbl0NZXlnKf36uLhchuK3c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tPadfrWSu7BaGqxISgpa9UB49xdClQArU9wtON9DTVZ+E4drg3rIWXS9gaJncz6FwkUvxVX1TUAw6YxltdEdQQJCGy0W84taBXYk/2b7yzfs7Cy5UVm+598VudYd3Z73+3nPPdsiHR2/rgTcjn30BUSUaPCUM0O74wpgNyNS7D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=wY2EXBE3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a44f2d894b7so246701566b.1
        for <linux-integrity@vger.kernel.org>; Thu, 07 Mar 2024 23:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1709882267; x=1710487067; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YvX8bPEV2BI0BpF/k+pwUbl0NZXlnKf36uLhchuK3c=;
        b=wY2EXBE3RgnvRgIRgvNXAu0XaxznWS/lRKYE/yZan4fyg5gNzBdcUrM04WdkGqHVB2
         mjQZaq4d1yfvCqEuFK90mCV88VaUxF7hXrtsiJjPs70czaeKzim1k14JncL+ocDaEgcn
         2UMDciaIaSSChda5IM78oSxkGOBtmHfXsGbWkkjYnG+UtJyMITmL+a21fGtdgm1LIFfY
         hoghNkLCbD0R3yj1h6fMTBEa4p6aP33cgR+h/MHI/v0YR7xWVh+rHKSLoF9D1/xZW6t1
         p6e3rtX0xTONQuGCN5B5niLgD3J4t9L8WA5FiopdLHuJjKJD31MDladddp3JQPUcIZ2M
         +I6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709882267; x=1710487067;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YvX8bPEV2BI0BpF/k+pwUbl0NZXlnKf36uLhchuK3c=;
        b=tnhSyUup0rbQ3Cs8wrf26uEGcsmm+JG80ne5aEChbzVElzXS1bsZCM5RdBDn/6kbG7
         YB52xKS2bzYIb8NvgqA0lhx3bbwTSvDNJN/Y8Aq2recr6Od7ZIsOxXcRRWZDp0zzlvnJ
         iYgI5BN0qzrTOIjJJuTYngqrLLC5odqogeaoNx7dxWSz2mMoj7XGZE2NCwLjV1oUTwQi
         Ti+ZPgSRFzN79pBRHt+bTpzDiAvc8HjIt+ymSlTc/RX7Pulp0ixPTK0rUYSXDZl9qdB9
         WvVz2bXpZatomtuZP62VTXpZ9Yw33KnmDdnYIvK4DcLvmAKL78JZZDC6SxluLOk7cDyj
         UJGw==
X-Forwarded-Encrypted: i=1; AJvYcCUQz0bmlfyc7cKtqHHw0ZroGd+FXOLZ+4nRB3B1tW/bqg8LuvTz+e5D4J9mxawkv9QPH9c8q8+R55+ON/RN39JCuAy3z9QoHNJg9x/5B5Hq
X-Gm-Message-State: AOJu0YxKXKi9uEhwSF/cmJ0IFbvdMRyibkm1WusM6dyfZU6wbCsIytAq
	58+iPCqleO/7A9i8QnvlPxokHyjvGXSFhWgqbzqV3Kw51LgbFnmOezK6buNORX8=
X-Google-Smtp-Source: AGHT+IGiGod9W2YM4YZ6sUKkrNh7qVjymDesOFOXF8mtdCcbqIFTzGM2YQaR07gH4KtP9j0849dGZQ==
X-Received: by 2002:a17:906:339a:b0:a44:ff95:3911 with SMTP id v26-20020a170906339a00b00a44ff953911mr11831490eja.66.1709882267100;
        Thu, 07 Mar 2024 23:17:47 -0800 (PST)
Received: from smtpclient.apple (clnet-p106-198.ikbnet.co.at. [83.175.106.198])
        by smtp.gmail.com with ESMTPSA id f27-20020a170906085b00b00a44ef54b6b6sm6582541ejd.58.2024.03.07.23.17.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2024 23:17:46 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v6 3/6] KEYS: trusted: Introduce NXP DCP-backed trusted
 keys
From: David Gstir <david@sigma-star.at>
In-Reply-To: <CZNRMR5YZPQO.1QBLW62A6S840@kernel.org>
Date: Fri, 8 Mar 2024 08:17:35 +0100
Cc: Mimi Zohar <zohar@linux.ibm.com>,
 James Bottomley <jejb@linux.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Shawn Guo <shawnguo@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 NXP Linux Team <linux-imx@nxp.com>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 sigma star Kernel Team <upstream+dcp@sigma-star.at>,
 David Howells <dhowells@redhat.com>,
 Li Yang <leoyang.li@nxp.com>,
 Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Tejun Heo <tj@kernel.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 linux-doc@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org,
 "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
 Richard Weinberger <richard@nod.at>,
 David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Content-Transfer-Encoding: quoted-printable
Message-Id: <655221B7-634C-4493-A781-CF014DFFC8BF@sigma-star.at>
References: <20240307153842.80033-1-david@sigma-star.at>
 <20240307153842.80033-4-david@sigma-star.at>
 <CZNRMR5YZPQO.1QBLW62A6S840@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3774.400.31)

Hi Jarkko,

> On 07.03.2024, at 20:30, Jarkko Sakkinen <jarkko@kernel.org> wrote:

[...]

>> +
>> +static int trusted_dcp_init(void)
>> +{
>> + int ret;
>> +
>> + if (use_otp_key)
>> + pr_info("Using DCP OTP key\n");
>> +
>> + ret =3D test_for_zero_key();
>> + if (ret) {
>> + pr_err("Test for zero'ed keys failed: %i\n", ret);
>=20
> I'm not sure whether this should err or warn.
>=20
> What sort of situations can cause the test the fail (e.g.
> adversary/interposer, bad configuration etc.).

This occurs when the hardware is not in "secure mode". I.e. it=E2=80=99s =
a bad configuration issue.
Once the board is properly configured, this will never trigger again.
Do you think a warning is better for this then?

Thanks,
- David


