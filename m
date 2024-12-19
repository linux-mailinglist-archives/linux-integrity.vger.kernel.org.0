Return-Path: <linux-integrity+bounces-4421-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7EE9F7E43
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Dec 2024 16:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09982188BF84
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Dec 2024 15:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641E4154C04;
	Thu, 19 Dec 2024 15:41:03 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD7C13A41F;
	Thu, 19 Dec 2024 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734622863; cv=none; b=XrEOiTjJekqvY39PrXeQnxI45iYG3I+n+igECRo/nluMSqgkoK1phv91mJrD65q3UbtP4Lt71MX6fUite5tokQWr1ir40jWTNuR5CBzLflrDiJA08MF8Rz2uQ4RZV2OnGsT7ICYO1MQvajEpDT3bxntO9roYGh+WjZBih34a60o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734622863; c=relaxed/simple;
	bh=+W/zVKU4tB/dlYY0Ks3Uc6fmjP244L0WS3CUCvPU4BI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=tFRkGuFYidNtX6DO6lc9T++3FdJLjUStBrr4LxVvKK32yqBfbG/rwBdFKZ5soBLMwE4QWfN2EwUI0QJA7texXb0QI+5yn8bAwk7m5tMHPWSqmRL6npNUIgzMMTIvGRTAAh5H1OyzskYakjzodvlAO9cBKYh5d/AkWmJMk1pvoUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2426EC4CECE;
	Thu, 19 Dec 2024 15:41:01 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Dec 2024 17:40:58 +0200
Message-Id: <D6FSHG5Z9UJQ.CWQTAANBVIQQ@iki.fi>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
From: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
To: "Stefano Garzarella" <sgarzare@redhat.com>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, "James Bottomley" <james.bottomley@hansenpartnership.com>
Cc: <linux-coco@lists.linux.dev>, "Borislav Petkov" <bp@alien8.de>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, "Peter Huewe" <peterhuewe@gmx.de>,
 "H. Peter Anvin" <hpa@zytor.com>, <linux-integrity@vger.kernel.org>,
 <x86@kernel.org>, "Joerg Roedel" <jroedel@suse.de>, "Jarkko Sakkinen"
 <jarkko@kernel.org>, <linux-kernel@vger.kernel.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Thomas Gleixner" <tglx@linutronix.de>, "Claudio
 Carvalho" <cclaudio@linux.ibm.com>, "Dov Murik" <dovmurik@linux.ibm.com>,
 "Tom Lendacky" <thomas.lendacky@amd.com>
X-Mailer: aerc 0.18.2
References: <20241210143423.101774-1-sgarzare@redhat.com>
 <20241210143423.101774-4-sgarzare@redhat.com>
 <20241210144025.GG1888283@ziepe.ca>
 <50a2e1d29b065498146f459035e447851a518d1a.camel@HansenPartnership.com>
 <20241210150413.GI1888283@ziepe.ca>
 <CAGxU2F6yzqb0o_pQDakBbCj3RdKy_XfZfzGsiywnYL65g6WeGg@mail.gmail.com>
 <20241211150048.GJ1888283@ziepe.ca>
 <CAGxU2F7QjQTnXsqYeKc0q03SQCoW+BHbej9Q2Z8gxbgu-3O2fA@mail.gmail.com>
In-Reply-To: <CAGxU2F7QjQTnXsqYeKc0q03SQCoW+BHbej9Q2Z8gxbgu-3O2fA@mail.gmail.com>

On Thu Dec 19, 2024 at 5:35 PM EET, Stefano Garzarella wrote:
> So to use them directly in sev, we would have to move these definitions=
=20
> into include/linux/tpm.h or some other file in inlcude/. Is this=20
> acceptable for TPM maintainers?

There's only me.

I don't know.

What you want to put to include/linux/tpm.h anyway? I have not followed
this discussion.

BR, Jarkko

