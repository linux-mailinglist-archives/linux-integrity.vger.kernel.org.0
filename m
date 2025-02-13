Return-Path: <linux-integrity+bounces-4810-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B36A33740
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2025 06:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8FF188BAA0
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2025 05:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDEA2066EF;
	Thu, 13 Feb 2025 05:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VyAiXhOb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBC686325
	for <linux-integrity@vger.kernel.org>; Thu, 13 Feb 2025 05:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739424694; cv=none; b=GEvDCGwGXb9yaKi0VZhlNzkApWCf2GDfL2KFA8HEqJGjKs4pJqYQI4MMlxHX098r1pyKyuWQz1gsOe8PhxArDE9NTvSc8B5wsP21ON0KdFNoYnQyPO1EbzmcdvOPCxQTVCrJrslZyEbxPQWYI3LTDRNYY3jRsOUJO+lqRbo8DeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739424694; c=relaxed/simple;
	bh=cnl2m4eSSFzUd2FI5RbArgk7aO/6MxFZUQsO6v5J5lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqIyo/mWS8Ez7fxnqJ3JVuva8M6cn9lUfjl/17c8VrPtblEyys3IBtrNt9nx7/rVhjfDK7wLd3ELmEOr0VWM/7lXt5hxsDhvl5bt3e7t6dl7Eq5VVHFTDxCqqlj9lf41NZffx2O2Bjphx50Qqba17sSWklO31rUyxHP5CK+gglY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VyAiXhOb; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4bbef8a5633so339640137.1
        for <linux-integrity@vger.kernel.org>; Wed, 12 Feb 2025 21:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739424691; x=1740029491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4Vx7h+AT1hd02pbPgDY1t0vIhjDwtSi7eGcVZkGc6A8=;
        b=VyAiXhOboCruzyZg0WmhtOqWcSocuOliKA1bYpi4T10kzluScfFmftE0BQ2M9cUsfq
         cqLrmul82UAo6T/ffNrQuErQ6/zgZpQ5XcUenbEGQTwhcONoj6+3rI6kIzvw6YgmJA34
         mWbjrhi9BpwTu0CEWT1FInP2PRq15N2A13RyVqX6OG/+0mPNwjGbZRiMuhdb+IHuDoJN
         97y+LY6WUwH2WNu2dMJ6I/Gjkc9xZGr4OJB3fNzGoBuk5QitdYD1evdJwIRdBROKh0T4
         zJd0sAmuFl5IQIpz68FaJqI7i+r5pcPb6hhe9cCXtURAnbeIFtTd0NJVYER0/hlh1gTk
         asVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739424691; x=1740029491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Vx7h+AT1hd02pbPgDY1t0vIhjDwtSi7eGcVZkGc6A8=;
        b=SH4ohts1B/U9WNSbJ1OHInWiRjSqJNlfyY0+qPYnT4FG1HNv+OuNk4rAPwd1/2oZWs
         x9GToIAzNKDFR/Tu6fdVD+J5C51T7daV6xGlJobNZPCneaR20Iv/eQSaYCfuqMHG+Mhp
         fF9e4kbkkl5Y3LRy7uLHJxuo7sjGYDXNNUpZtdt8klrNQxs67IsJDqHP4VvvIpirzN7l
         KSwXQBEiqzoAZA2Nm8V9a7K917ro5EEwHji8/ukYHRw3V5tdozjcXcHA8fwHKzNChyoJ
         WXHDHuR/7bTufk+fEz6Fo/yAusZqqp8f/DZAIOiVdBLZM6RTdu/eEn4FjLOUEHpPVJKL
         yIrA==
X-Gm-Message-State: AOJu0YxMgb9yhSPLV/7x2Sh99uqBjwXxDaATojOzbBnglbEC9NbrqXy/
	yZ/BaQro0Mb5QMRS2wscIAr8yJ3RbtTzx3SAmgB3oKIxE8BOTINN9ZX8ulrJBx7OeaqfQtM1jRE
	ck5s3qxjEBNc5htTOee6PWCGdEFZceZVUFORjSg==
X-Gm-Gg: ASbGncuWRAJWs2Zgkd7+P63QX0h5CqF1hKg8NSQcYqj4In+BeCrfvi6suyC/E8eMNej
	qp3UpLBLH3K2yJoTabaqRjpsYqGp0qM3eb/FvHKk4vtuehXg7u/dLrAJGsl5TZtoLsbNAjCs1SC
	E=
X-Google-Smtp-Source: AGHT+IE1b09Y0oh2SgYAlecKTFu/d9b/vl21w0WdHCnWjWmlZjDq81Lo0AiehcZEq4EZhisIZQ80PeR271tttdICELo=
X-Received: by 2002:a05:6102:1620:b0:4bb:d062:422 with SMTP id
 ada2fe7eead31-4bbf209b9eemr6518734137.3.1739424690944; Wed, 12 Feb 2025
 21:31:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210232227.97761-1-stuart.yoder@arm.com> <CAFA6WYM7K4_toy5_n1arW4po4SOX0R9624rCgO=_MvcMeySwUA@mail.gmail.com>
 <4bb3cefa-b843-45ca-82c5-d96b13454baa@arm.com> <CAFA6WYM3UA9+TE8L2U5Qd8FZfaGZnbba=QzWU7fEu3LKQVm-tw@mail.gmail.com>
 <fdaa9a58-790f-4839-8db7-1b9a81eb8edf@arm.com>
In-Reply-To: <fdaa9a58-790f-4839-8db7-1b9a81eb8edf@arm.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 13 Feb 2025 11:01:20 +0530
X-Gm-Features: AWEUYZkUe-JQu9WB8sdTJHZU0cqiP0txO2dUkC_k7zFWA78tOzalgc25rjYtTJQ
Message-ID: <CAFA6WYM0ANqc--ScYtJFRjOsCCjzO3NX46=F5V=rza_6Q-Q96g@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add support for the TPM FF-A start method
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, jarkko@kernel.org, peterhuewe@gmx.de, 
	jgg@ziepe.ca, sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jens Wiklander <jens.wiklander@linaro.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"

+ Rob

On Thu, 13 Feb 2025 at 03:25, Stuart Yoder <stuart.yoder@arm.com> wrote:
>
>
>
> On 2/12/25 1:39 AM, Sumit Garg wrote:
> > On Tue, 11 Feb 2025 at 21:39, Stuart Yoder <stuart.yoder@arm.com> wrote:
> >>
> >> Hi Sumit,
> >>
> >> On 2/11/25 12:45 AM, Sumit Garg wrote:
> >>> + Jens
> >>>
> >>> Hi Stuart,
> >>>
> >>> On Tue, 11 Feb 2025 at 04:52, Stuart Yoder <stuart.yoder@arm.com> wrote:
> >>>>
> >>>> These patches add support for the CRB FF-A start method defined
> >>>> in the TCG ACPI specification v1.4 and the FF-A ABI defined
> >>>> in the Arm TPM Service CRB over FF-A (DEN0138) specification.
> >>>> (https://developer.arm.com/documentation/den0138/latest/)
> >>>
> >>> Nice to have a specification standardizing interface to TPM
> >>> managed/implemented by the firmware. Care to add corresponding kernel
> >>> documentation under Documentation/security/tpm/.
> >>
> >> Yes, I can add some documentation there.
> >>
> >>> BTW, we already have drivers/char/tpm/tpm_ftpm_tee.c, so do you see
> >>> possibilities for an abstraction layer on top of communication channel
> >>> based on either FF-A or TEE or platform bus?
> >>
> >> I think the CRB and OP-TEE based messaging approaches for interacting
> >> with a TZ-based TPM are fundamentally different and I don't see how
> >> to harmonize them through some abstraction.
> >>
> >> The OP-TEE TPM protocol copies the TPM command into a temp shared memory
> >> buffer and sends a message to the TPM referencing that buffer.
> >>
> >> The CRB uses a permanently shared memory carve-out that in addition
> >> to the command/response data has other fields for locality control,
> >> command control, status, TPM idle, etc. The only 'message' needed is
> >> something to signal 'start'.  Any OS that is FF-A aware and has a
> >> CRB driver can simply add a new start method, which is what this
> >> patch series does.
> >
> > Okay, I see how the CRB driver is closely tied to the ACPI based
> > systems.
>
> The CRB driver is currently probed based on ACPI, but it fundamentally
> doesn't have to be.  If there was a DT binding for CRB-based
> TPMs the different start methods would be defined there and the
> CRB driver could support that.
>

Can't we rather enable the CRB driver itself probed based on FF-A bus
and rather dynamically discover the shared memory buffer via FF-A
instead? AFAIU, FF-A provides you with a discovery framework for
firmware bits. But if we still want to overload ACPI or DT with the
discoverable firmware bits then it seems like an overkill here.

> > I was expecting the FF-A based TPM interface to be
> > independent of ACPI or DT such that it's not constrained by the
> > hardware description a platform chooses to use. I suppose there will
> > be a different TPM FF-A driver or spec when someone wants to deploy it
> > on DT based systems, right?
>
> The CRB is just a shared memory buffer, with some architected semantics
> defined by TCG. The basic CRB usage model is that a client puts
> something in the CRB, such as the bytes of a TPM command, and then
> notifies the TPM that a change was made to the CRB. The CRB over
> FF-A spec just defines the message to perform that notification
> when FF-A is used.
>
> So, whether the fTPM was advertised via ACPI or DT, it doesn't matter.
> The FF-A based interface is only about the the notification messages
> needed for the OS driver to tell the TPM that something has changed
> in the CRB.

-Sumit

