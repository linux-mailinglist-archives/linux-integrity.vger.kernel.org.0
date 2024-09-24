Return-Path: <linux-integrity+bounces-3688-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B41E984AAD
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 20:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B6C28694A
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 18:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE6D1AC43B;
	Tue, 24 Sep 2024 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZOcuDMh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B2E1581F8;
	Tue, 24 Sep 2024 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727201247; cv=none; b=u+rpkSBRQ6gW9hdDxR3xbth6RGtYjZ5MXZvnkXrzSIMXtenGoDpc99BLrIFy34ix4NN6+1tFibEafn7nXejyQF68BLKaIOngXQVCw7eqzxz5uEKI/zEPxyK3o17Y/tCHu/8fet3f8iCG9viTtDmGuoehJ8O4/thFO9Pw7uhWoq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727201247; c=relaxed/simple;
	bh=r0Qo7isWNui7uOUPcqe/GIVDS+0O7xChj8EAgM3CfL4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=leheBKrIrwIBwSWu/rE1SrKl53eOFQuVdPKB8/8oq2S/+dH2WGLx62ilae21ZALNgsQsnoVgQVw3LVVvjCSKDR3ursNhAdc4CSZAnjKVmAGQTaWjjhaxH8qdq5UYAeP3SINdbw2+rU8uyaLFnqgrD6erAakrKLECtQzZrV0Ko0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZOcuDMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C879FC4CEC4;
	Tue, 24 Sep 2024 18:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727201247;
	bh=r0Qo7isWNui7uOUPcqe/GIVDS+0O7xChj8EAgM3CfL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZOcuDMhxbB1s/qyEZ8igBAUEiz7OhlJ3PVgm70oWsmkfJvU/w2LaRlIuqMUZtsGZ
	 U2UB7gFzauQoUe9hovN/7MSUuvkukYSkmEMRvHNK7RBMVY6Ch/N0QJocsbm3OvZ+LO
	 ZE2KoutzxG8KTMkm7YAr0i/09DcjTMarmjClZ88SHalWjbQWTGgKZG0jNoXyVdPN+Q
	 d+S3i7cXfgH9C6UPLTsZO57kiodxg6T6Eh2Ahf6y/9vNkFPMlF6Tgbt1hZzY+IP1IQ
	 bBa3C7pTZp8p/ZgL2Z9enTkkz8YDzprUCHpXqR8bUreg2Yb9YExLMZKyt+2ipeMI/n
	 MP3PSheqMiGyQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Sep 2024 21:07:23 +0300
Message-Id: <D4EPQPFA8RGN.2PO6UNTDFI6IT@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Cc: <roberto.sassu@huawei.com>, <mapengyu@gmail.com>,
 <stable@vger.kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Peter
 Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/5] tpm: flush the auth session only when /dev/tpm0
 is open
X-Mailer: aerc 0.18.2
References: <20240921120811.1264985-1-jarkko@kernel.org>
 <20240921120811.1264985-6-jarkko@kernel.org>
 <00cf0bdb3ebfaec7c4607c8c09e55f2e538402f1.camel@HansenPartnership.com>
In-Reply-To: <00cf0bdb3ebfaec7c4607c8c09e55f2e538402f1.camel@HansenPartnership.com>

On Tue Sep 24, 2024 at 4:43 PM EEST, James Bottomley wrote:
> On Sat, 2024-09-21 at 15:08 +0300, Jarkko Sakkinen wrote:
> > Instead of flushing and reloading the auth session for every single
> > transaction, keep the session open unless /dev/tpm0 is used. In
> > practice this means applying TPM2_SA_CONTINUE_SESSION to the session
> > attributes. Flush the session always when /dev/tpm0 is written.
>
> Patch looks fine but this description is way too terse to explain how
> it works.
>
> I would suggest:
>
> Boot time elongation as a result of adding sessions has been reported
> as an issue in https://bugzilla.kernel.org/show_bug.cgi?id=3D219229
>
> The root cause is the addition of session overhead to
> tpm2_pcr_extend().  This overhead can be reduced by not creating and
> destroying a session for each invocation of the function.  Do this by
> keeping a session resident in the TPM for reuse by any session based
> TPM command.  The current flow of TPM commands in the kernel supports
> this because tpm2_end_session() is only called for tpm errors because
> most commands don't continue the session and expect the session to be
> flushed on success.  Thus we can add the continue session flag to
> session creation to ensure the session won't be flushed except on
> error, which is a rare case.

I need to disagree on this as I don't even have PCR extends in my
boot sequence and it still adds overhead. Have you verified this
from the reporter?

There's bunch of things that use auth session, like trusted keys.
Making such claim that PCR extend is the reason is nonsense.

BR, Jarkko

