Return-Path: <linux-integrity+bounces-4780-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1E7A303C3
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2025 07:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 591067A1F2F
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2025 06:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A5C1D47A6;
	Tue, 11 Feb 2025 06:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ugolflmu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB1B190674
	for <linux-integrity@vger.kernel.org>; Tue, 11 Feb 2025 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739256334; cv=none; b=C00RA7hIBQCPu156ZGrY6KH3x74x/665arjksx14loNp8myf6qTuBEf/Nl8JgBUGikXXmnVW3A8PVR4jupDnK42gH6sL+0EatBJdx+q6/nuK0AB5Vq8kwUhsEigxDMZIwQxSrsCDOzN3uz5tZL1eGYUF+6YhMmu+J5NnmdeqSeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739256334; c=relaxed/simple;
	bh=nVfG0++mT1ID/WJVtPd975t5UPGFo2kbmky6L/bL4xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDzKiUfTYaWhj1F64zKU6PcrbWwWNg1MHqj3GIsXIqzxV/sAEmxtel6Cz+hhxeAfkkKddhYLCg28PMuZNCZiUEWFaHXoK7MKbiFbyFKcEPOsvXMPzqomfUWSl+UwEW8DFHp/PAMwKiNpu74IqC95y00+SY/bdfRLyYxQes0q+1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ugolflmu; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4ba9680271fso2140842137.1
        for <linux-integrity@vger.kernel.org>; Mon, 10 Feb 2025 22:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739256332; x=1739861132; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1QiFCUT3qvEQvHwez3VPpjFS/OoBwVp/3j9UJxOxrlI=;
        b=UgolflmuQBP0lJQq/x0bG/yRl6xEGSnrQt/HkVI078Z0b5HRB2CexuUv3JLe1xQS9Q
         +Gzelmm7gf6Cjsr2hC7tXcB88DxU5L5JsnamRkOrInEOem7vgex2hWgR0+mAn4JtVzHc
         EXlZRkTFq6gCYBX/CPGu66ylQIkQvKGFHrk+xwFNIYPZ/5KChcOuAm6ou0QXRrmIijd4
         e+OqQ80CoeLg10nqSmxPY3Cf7HlRMNCxHClyc+Xn0uC8v30NIMURHxx8zq/dYXNFXb73
         i9ohCT+/q7uOvYvtk03+Rqn7adhLosTa/Hl4ETDgpkZKOIx6ZhZ2RnIxbHECUbjnHkcQ
         F2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739256332; x=1739861132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1QiFCUT3qvEQvHwez3VPpjFS/OoBwVp/3j9UJxOxrlI=;
        b=hfP8lUjgnP8tcgDt4/nGF5LLZKOInYIp9RgPjiCAjm32KufmHO6ltbGjLgUr6I5Tx/
         MpgcWbRyRdL643T6Z39HPCrvQRv0VuB6HWP26c97gEZr/RhoGyCYVvAAd2PBNns01tjJ
         rnPSlKYje/BFHPCoaKCtbLaah6JM/Wlq25wEArKcYz9VmbnkzzYb8Q6TcI9rn26BadLT
         if7K/P5cq8yp96Tds5Q/vGNHx264qZwXEL9G1G6duv0NYq+3ArIDQGoot5EWhUfvOyHO
         D8h60EPa1YnjZccWBtBiJEMzcpTQH+EZBWifi/lYpm8Kji7tf1Oe8IEBF5IdVngKXHll
         CXTA==
X-Gm-Message-State: AOJu0YwkDhrQCFYtHwysFeb+HkUssoT726gP+jYmvULmWp3htu2679e1
	8knlRnT34Zh0r45gPFfFvh/2sLgYp2JsD5ExkJYqFCRQBpn7LuAAC1XM+T5n7cksFSR+3tqwdj1
	hOho2jaHXztfvzzTzxxNuMuu/OmkWiAZiLOWChw==
X-Gm-Gg: ASbGncu8q/ykAFZnX6zyma9oExh9ih8lciZ80xAj+HBtKVBOhoskYfcPzIagmkwkjul
	jT7LXZFGLCnq/BHO08btYzgMlwRCL525PkNKYD7fftj9G/I9VIn2UyhUKcVbOY2LnX6223lsOVP
	A=
X-Google-Smtp-Source: AGHT+IHraUWItx7lyhs3RGJc1hMUxbfl9W9qX1eehSk1rDY3s6SNEwm4KmyNFqY9duS3Ua0mf2EDxT5evKNmccbGxaE=
X-Received: by 2002:a05:6102:2acf:b0:4bb:41c0:ea63 with SMTP id
 ada2fe7eead31-4bbe13bc505mr1500286137.8.1739256331732; Mon, 10 Feb 2025
 22:45:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210232227.97761-1-stuart.yoder@arm.com>
In-Reply-To: <20250210232227.97761-1-stuart.yoder@arm.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 11 Feb 2025 12:15:20 +0530
X-Gm-Features: AWEUYZmss9mgyyi4uduffWjEUtPdHOzBfArVxLUXxchfgmNTaYDr5MANoP7oRrI
Message-ID: <CAFA6WYM7K4_toy5_n1arW4po4SOX0R9624rCgO=_MvcMeySwUA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add support for the TPM FF-A start method
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, jarkko@kernel.org, peterhuewe@gmx.de, 
	jgg@ziepe.ca, sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"

+ Jens

Hi Stuart,

On Tue, 11 Feb 2025 at 04:52, Stuart Yoder <stuart.yoder@arm.com> wrote:
>
> These patches add support for the CRB FF-A start method defined
> in the TCG ACPI specification v1.4 and the FF-A ABI defined
> in the Arm TPM Service CRB over FF-A (DEN0138) specification.
> (https://developer.arm.com/documentation/den0138/latest/)

Nice to have a specification standardizing interface to TPM
managed/implemented by the firmware. Care to add corresponding kernel
documentation under Documentation/security/tpm/.

BTW, we already have drivers/char/tpm/tpm_ftpm_tee.c, so do you see
possibilities for an abstraction layer on top of communication channel
based on either FF-A or TEE or platform bus?

>
> FF-A is a messaging framework for Arm-based systems and in the
> context of the TPM driver is used to signal 'start' to a CRB-based
> TPM service which is hosted in an FF-A secure partition running in
> TrustZone.

Is there any open source implementation for such a secure partition
managing the TPM? Also, is that really a discrete TPM or firmware TPM
managed by the firmware?

If it supports firmware TPM, I would be interested to see how you plan
to handle cases related to secure storage.

-Sumit

>
> The first patch adds an FF-A driver to handle the FF-A messaging when
> communicating with a CRB-based TPM secure partition built on FF-A.
> The driver is probed when the TPM secure partition is discovered by
> the Linux FF-A infrastructure.
>
> The second patch consolidates the check for idle support in the CRB
> driver to one place.
>
> The third patch defines the new ACPI start method enumeration for
> CRB over FF-A.
>
> The fourth patch adds support for the FF-A ACPI start method to
> the TPM crb driver.
>
> Stuart Yoder (4):
>   tpm_crb: implement driver compliant to CRB over FF-A
>   tpm_crb: refactor check for idle support into TPM into inline function
>   ACPICA: add start method for Arm FF-A
>   tpm_crb: add support for the Arm FF-A start method
>
>  drivers/char/tpm/Kconfig   |   9 ++
>  drivers/char/tpm/Makefile  |   1 +
>  drivers/char/tpm/ffa_crb.c | 310 +++++++++++++++++++++++++++++++++++++
>  drivers/char/tpm/ffa_crb.h |  30 ++++
>  drivers/char/tpm/tpm_crb.c |  81 +++++++++-
>  include/acpi/actbl3.h      |   1 +
>  6 files changed, 426 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/char/tpm/ffa_crb.c
>  create mode 100644 drivers/char/tpm/ffa_crb.h
>
> --
> 2.34.1
>
>

