Return-Path: <linux-integrity+bounces-4798-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEF3A32011
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2025 08:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70A2B7A186E
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2025 07:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DF1204682;
	Wed, 12 Feb 2025 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sbF05qRL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660D42045B2
	for <linux-integrity@vger.kernel.org>; Wed, 12 Feb 2025 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739345977; cv=none; b=iHGYqdxFn4/UVK9VXTKwlqCcLPQqriPT3NgaPI8CNsL9fFW/HtK1CEs+s4nko5kKpa8/xxNLisb1O452B/APuXObgQCvcuEqCunqcDeeelSi63VwPoD1iEwlKWgXOkA1TMPFhp46TCcHU7MpvEJSFKnYN5YAupnSCZO7yb6FvaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739345977; c=relaxed/simple;
	bh=DDn3QJZLeVNQkdyCgloIeeFY8QjFE6nRBdjKBqMF2U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjmQhJERxQMu0dyl6JbaJpG94UIfKQINR5Z4ySzU5pUFb9XNbz4dg22kpSm/3HQMiUdjJ9iHh+qTbo/YK7+K9ildUiGV0j9PLvjh5lj10hFgDPC6HhWTjyszJt0M1soBKT5oVHlyGAzbDIxiqkDXjEBW1NvvwN16MxTvVyzEHcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sbF05qRL; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86708ac8e2cso990516241.3
        for <linux-integrity@vger.kernel.org>; Tue, 11 Feb 2025 23:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739345974; x=1739950774; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rPFpWXPkHcbJC5yJ8SZuPQTMyeFGoz+jsHD5hgwmaI4=;
        b=sbF05qRLTtCQvHLSrnkjcYb+0GaC8jUlgt51zDLxksWJR386CmQukuFfoCVB3BhTsU
         FsM0gYExpxCN0JkU+5HqpM+CLo7YShB2jXtO8dhrqRlYPAisjUM37hDJzmkE3aL5tOB1
         GaS7SH046cMmfjXqG9JyguZ6qUkQY2MtO13BI5H/zDw3gPzapO3z+HCuUMFtsFdYO53K
         3xR3qlli8Gr4dbtfybOh2B+HxXiMqtp++z6a30sU+ZncXU2PxIzxpgSpikhr3RksFD4m
         3jL8p5kLNtvVSnwT0hl2u/AesT3mOtTXNt0bgMrwALleMnJFYE/dfo9ysG2O/k0uxZKD
         s4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739345974; x=1739950774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPFpWXPkHcbJC5yJ8SZuPQTMyeFGoz+jsHD5hgwmaI4=;
        b=Qfbguomxi0f6+xHBdqy8s0lxwJFcPcGM45OyLaU4kNs/LZY5dWqIIfGyO3FC8hk1Wn
         xvmM+0v6n/uRd86M22Z3kpiMD4ldeJ5NQ634uCbDUeR8WhegcjXUXJM9FQTT0/8nE8w2
         Ka+9qSdqrGWbQi+loi1uzDT5gVUmNinuiexvQX6z59xLCPcB/D3sh9EI1mwp3MyC7RaH
         O9rYAw3z+CTNEP3gkAY+UrGUZMZWpBIAHDGI1DakqiOtzvcwJ7pHXMmAKbSGWPvMvLWc
         Yb4jfYx/8YNwozcvjNMooEiKEmoLyo7F5/E1RpXMq8kvsYa54fSznUQ0qbqE7LkY/B5u
         0ZEA==
X-Gm-Message-State: AOJu0Yz1ixMQ/tBpWmUWhMp7RtxyyiXUHQ7YBfAHSfurJCuFd0f9Gzey
	KTmXkC9Zz1faiaTKqIEUNkwR3JTwKKJMjmgnFeQ9KKTd6TTso6qxttfo42E/E11CGMIGSyPF23o
	WWpp33+1311WmfMCPDV8Yia5uBXUzTdAIgbyCFw==
X-Gm-Gg: ASbGncuEUAr06IMrwCuwz6O4AsoFl0lbdnj2kXwGsnCQizgDfM2otsDrdEaUOBqv0yi
	OZUEDyEaQ4u0uoDgZjAlekk4G1oH+bnLx1r4s14Q+jl9gMt9LSc4sKYkzjV1q1umyD/v1CV81tj
	8=
X-Google-Smtp-Source: AGHT+IEMiel5s93FgOos2qqIpI//PpocZKIctdEX1cnUApU9jZKvSlLfCRn+pBXhNYid3bsEMoD6l+ZBxkgMxzRoTOk=
X-Received: by 2002:a05:6102:a4c:b0:4bb:d394:46cc with SMTP id
 ada2fe7eead31-4bbf54922d5mr859998137.2.1739345974277; Tue, 11 Feb 2025
 23:39:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210232227.97761-1-stuart.yoder@arm.com> <CAFA6WYM7K4_toy5_n1arW4po4SOX0R9624rCgO=_MvcMeySwUA@mail.gmail.com>
 <4bb3cefa-b843-45ca-82c5-d96b13454baa@arm.com>
In-Reply-To: <4bb3cefa-b843-45ca-82c5-d96b13454baa@arm.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 12 Feb 2025 13:09:23 +0530
X-Gm-Features: AWEUYZnA0hBKgdYHZkgK2av9Y3l6uKPbO9mL8_cp-1GkP_zm5MsWMPppld1Av2g
Message-ID: <CAFA6WYM3UA9+TE8L2U5Qd8FZfaGZnbba=QzWU7fEu3LKQVm-tw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add support for the TPM FF-A start method
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, jarkko@kernel.org, peterhuewe@gmx.de, 
	jgg@ziepe.ca, sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 21:39, Stuart Yoder <stuart.yoder@arm.com> wrote:
>
> Hi Sumit,
>
> On 2/11/25 12:45 AM, Sumit Garg wrote:
> > + Jens
> >
> > Hi Stuart,
> >
> > On Tue, 11 Feb 2025 at 04:52, Stuart Yoder <stuart.yoder@arm.com> wrote:
> >>
> >> These patches add support for the CRB FF-A start method defined
> >> in the TCG ACPI specification v1.4 and the FF-A ABI defined
> >> in the Arm TPM Service CRB over FF-A (DEN0138) specification.
> >> (https://developer.arm.com/documentation/den0138/latest/)
> >
> > Nice to have a specification standardizing interface to TPM
> > managed/implemented by the firmware. Care to add corresponding kernel
> > documentation under Documentation/security/tpm/.
>
> Yes, I can add some documentation there.
>
> > BTW, we already have drivers/char/tpm/tpm_ftpm_tee.c, so do you see
> > possibilities for an abstraction layer on top of communication channel
> > based on either FF-A or TEE or platform bus?
>
> I think the CRB and OP-TEE based messaging approaches for interacting
> with a TZ-based TPM are fundamentally different and I don't see how
> to harmonize them through some abstraction.
>
> The OP-TEE TPM protocol copies the TPM command into a temp shared memory
> buffer and sends a message to the TPM referencing that buffer.
>
> The CRB uses a permanently shared memory carve-out that in addition
> to the command/response data has other fields for locality control,
> command control, status, TPM idle, etc. The only 'message' needed is
> something to signal 'start'.  Any OS that is FF-A aware and has a
> CRB driver can simply add a new start method, which is what this
> patch series does.

Okay, I see how the CRB driver is closely tied to the ACPI based
systems. I was expecting the FF-A based TPM interface to be
independent of ACPI or DT such that it's not constrained by the
hardware description a platform chooses to use. I suppose there will
be a different TPM FF-A driver or spec when someone wants to deploy it
on DT based systems, right?

>
> >>
> >> FF-A is a messaging framework for Arm-based systems and in the
> >> context of the TPM driver is used to signal 'start' to a CRB-based
> >> TPM service which is hosted in an FF-A secure partition running in
> >> TrustZone.
> >
> > Is there any open source implementation for such a secure partition
> > managing the TPM?
>
> Nothing yet, but something I am working towards.
>
> > Also, is that really a discrete TPM or firmware TPM
> > managed by the firmware?
>
> It could be either. It doesn't matter from the point of view of
> the OS CRB driver. For testing this patch series I used an
> internal proof-of-concept fTPM with a CRB interface.

Okay I see, having a real firmware managed TPM implementation will
really unlock the adoption of this specification.

>
> > If it supports firmware TPM, I would be interested to see how you plan
> > to handle cases related to secure storage.
>
> Yes, this is a challenge and there are various ways it could be
> implemented. For example, RPMB or if you have an internal root of
> trust with secure storage like an RSE that could play a role.
>

The RPMB kernel routing is what we have for the OP-TEE based fTPM but
I agree there are numerous ways to implement it given the platform's
capability.

-Sumit

> Thanks,
> Stuart
>
>

