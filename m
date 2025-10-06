Return-Path: <linux-integrity+bounces-7375-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA7ABBD351
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Oct 2025 09:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D51EC348727
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Oct 2025 07:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BC823B604;
	Mon,  6 Oct 2025 07:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TsoJ18nV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68294231829
	for <linux-integrity@vger.kernel.org>; Mon,  6 Oct 2025 07:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759735600; cv=none; b=dLXqj8b+Gq5hGU2KQ1wK4CfN6QqcMTrjoDbXC/mcurS77q06S9iQ8kn0/zv3B+M1t68KW1Y/8mPCANA4003eAEGdLLh2Z4SeyurJq1x/j5RC40z69fobOyRf/ZGfJLDc5m+z5z0HXm1ls5NJR/0172X5pRwi8EcGGIe+ykKxcsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759735600; c=relaxed/simple;
	bh=q4XtfKIFy7egdQZ8O5c76y9F/lMwipzSkZTt+u6XlkQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=ATSGcGVuHrS+hC+PkxEkk799FOKzTDgqIoK4YmaDfPUXjHhvFncvLN8mmIpkwfZTNN+6+egFFNYMCg8k9aHEQdAQzHhUh1URHaL+sNsP1RYHiwtchwyyBD4SPtSHdjfqEvgRYxM1VRsDdJvQ01wfJV9Hvlu74gahmEze+zgOvYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TsoJ18nV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so3388060f8f.3
        for <linux-integrity@vger.kernel.org>; Mon, 06 Oct 2025 00:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759735597; x=1760340397; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTR0CyiAIr67VQqq00olrSMeF2cnaGO7A1U+4VJPX1o=;
        b=TsoJ18nVz3MG9KAdZIw/Aqz417rHzVSW70unw1+MoZVejQBzNCso/dKmX1LnAgcGzV
         Zfyyo258CxuCY3HAa0c8zpgz8vnSBngsG+sRIuSJeG0bZjmUKkiVtcRjVMSQUBZh3Y0f
         X2QdABh1Exyck5rnyUH4wCL0wLQHQ3XXovfBOG3OrOZejOf/KYCgkTfnDHDr5xDTsLno
         rMxaWfZCnLoDUOKUm9hJLTsSzargrKERNNxUsRsI4CNjN3bOFyK1RnxfNBI9FNvASouj
         xpJkxprdMAiJBDLLYqusrgNjHTfIBZBSubL29LpkMLFP+6D7F4GgYKGpbVcbnkzCXUOA
         XgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759735597; x=1760340397;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTR0CyiAIr67VQqq00olrSMeF2cnaGO7A1U+4VJPX1o=;
        b=fhA8XH+cP3OrDvAn4sluMUH+F7WwEwRVcF2KKMEZy760yZ4Gh0xqgkZWMhU+h3Dcow
         apViPlABjuVCLu8V0qFUER5CGizA+/tA3Zt+BeSfs4uchuIHjg1q67c66m0snU66kh3O
         8wC8CKQ4M/R8Wp2vvb4XD8kE+I9LCOms59haVaQ/shTK9nSZaKF0Gd8boCwEAp+Hqi5h
         dgLoOvLKOed1x+dFTuYo5HvEDtNctFgvSV6cZIt2V8v1LwGH0MbgcqaB1FBCfVb2P+Qn
         cGM3XIfNjAt2ORv6zELOKToU73H8mWBygIb6nIkKy1jdmgIf0N3BZKl9sysb4agD4Cju
         YBjA==
X-Gm-Message-State: AOJu0Yz2TAdI4yC0krE/UhO/xX0ZDqoOTYty/c284s3HILaEnQyUek/c
	DFEfk+fvTdc3Lg6A9VRtGrvYkzo4E9O7cVgA6oF8Y7HZdHk3nLMviR5YT6/TspU1B5I=
X-Gm-Gg: ASbGncs7ruLjkEaDrJKmC9MDXFkOLL5afq6Tina8HwnF5EYGD+z8ckW6QeKnEDKgFZg
	cdpqSIrkKdh+wQhVTlBFlKtFZ9v2LiwSyXqctbq6DWt5CQDsgYaxRHjIzoWP+jiosC+F+TrmLlK
	9I1hrEWIwWS5O/4CF5h+6Sg8Jhj8m2t6eCnsd1b3seW8kA4PboNQwQ36UqEBl5jdlgCZM99aDdL
	L1K63HXFjXTUwjZpcvIxjcdXbRhwkPJjDP5i5pvxPO2jPC7CSpvkoGWIlEY7rKEVZet9EW829Yg
	2MUXVDlbzAv99NoirCWhpY68nTCb/kElc/qPGqN1OCKozvUOFKqhIFLbf5ihoZUZyBPqAd75gQM
	k0cvAwTArQ2RHU7wRkyeQg73GvkZ6WNPxKFzka/mBL5AdyaijJz37xKfj7j8a7DrrJf0=
X-Google-Smtp-Source: AGHT+IFHEH19rfceHAnCRXrpoJGYzTt6CqW8DJ1a31IQ8jWN2W99GfnTaJf8FmBZ6mOHdQ4uPZ3N7w==
X-Received: by 2002:a05:6000:2010:b0:3eb:5245:7c1f with SMTP id ffacd0b85a97d-4256713ac87mr6945703f8f.2.1759735596677;
        Mon, 06 Oct 2025 00:26:36 -0700 (PDT)
Received: from localhost ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bb53b8absm108152536d6.22.2025.10.06.00.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 00:26:36 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Oct 2025 09:26:33 +0200
Message-Id: <DDB27F9FQ4B3.11FGF9PVV0DAE@suse.com>
Cc: <linux-integrity@vger.kernel.org>
Subject: Re: [LTP] [PATCH 2/4] ima_conditionals.sh: Split test by request
From: "Andrea Cervesato" <andrea.cervesato@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0
References: <20251002083701.315334-1-pvorel@suse.cz>
 <20251002083701.315334-3-pvorel@suse.cz>
In-Reply-To: <20251002083701.315334-3-pvorel@suse.cz>

Hi!

On Thu Oct 2, 2025 at 10:36 AM CEST, Petr Vorel wrote:
> This helps to run all testcases on systems without CONFIG_IMA_WRITE_POLIC=
Y=3Dy
> (disabled by default in mainline, therefore disabled for some distros,
> e.g. openSUSE Tumbleweed), if SUT reboots.
>
> The downside is creating user account 4x instead just once.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  runtest/ima                                   |  5 +-
>  .../integrity/ima/tests/ima_conditionals.sh   | 67 ++++++++++++-------
>  2 files changed, 47 insertions(+), 25 deletions(-)
>
> diff --git a/runtest/ima b/runtest/ima
> index 01942eefa3..c8d0c6801e 100644
> --- a/runtest/ima
> +++ b/runtest/ima
> @@ -6,5 +6,8 @@ ima_violations ima_violations.sh
>  ima_keys ima_keys.sh
>  ima_kexec ima_kexec.sh
>  ima_selinux ima_selinux.sh
> -ima_conditionals ima_conditionals.sh
> +ima_conditionals_uid ima_conditionals.sh -r uid
> +ima_conditionals_fowner ima_conditionals.sh -r fowner
> +ima_conditionals_gid ima_conditionals.sh -r gid
> +ima_conditionals_fgroup ima_conditionals.sh -r fgroup

Why not using multiple test cases inside the test?


