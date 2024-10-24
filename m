Return-Path: <linux-integrity+bounces-3906-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 541FA9AE3B7
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2024 13:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1348E283CB6
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2024 11:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083F21CEAB1;
	Thu, 24 Oct 2024 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maYJeymI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3B61CDA1C;
	Thu, 24 Oct 2024 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729768942; cv=none; b=ZouIgyq28hEUKyr9Fq2R8lkyqn+8ysArzAXXFuoe9NeHuyqGFyA0eMmsXQO+O/WVWCtI1QdAkFe8aQOXMJrCyt/AakF8eEbqqk/opr9qG8O4L5pY3cLBXfL7ryYYsgydjiSRNBTKZdjNYZnRowqm7COxrio1XIwLzi5SfRqzh5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729768942; c=relaxed/simple;
	bh=CnUNKt4stBuax4eI8NnoLAFYCHPwGJdu2d5Qca/R/Nk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NPEj+40HURnZIHq335lM2Fx2Nk3k5pOuEiwTvEBzy3SPvKiZV3l32tpAiR1aCBMU/4WHohqugVp8gL6tZuVouqovQ0MEIYUymnAwaKXAa7bWcRtfUp3YWXkkkZLb3e4l2NekcCraHB/j9B6f68tW+cVtgx3MD+a1deMvb6xCP4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maYJeymI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD128C4CECD;
	Thu, 24 Oct 2024 11:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729768942;
	bh=CnUNKt4stBuax4eI8NnoLAFYCHPwGJdu2d5Qca/R/Nk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=maYJeymIdDhTuDsj/E+l/Hanp8AGmW7Wy4Vn8Y/SpvyTZGmGsh/A4LAhK/eIW67tn
	 wOrweEB+hNIRlIjuoEI9DeY2uiZeidSxPBW0V7aiBPjzgahyK6WlWKpv1F2fpS+ae8
	 s/k4tOpkleSY1CUFHvXDYAphCtaXlWpiNUlOnX9GzELfhW6PeNO77u3FzTr3Xu5LZm
	 rDNGI5Iq9aEpsNYAoiLQ4KWmEErgnAdsm4W2RMrNhf2Lf3yobw/iX6j+8lnQfnt3x5
	 V+A7Ev0E41Ws4Ywz6QAEICEAWuKDbIrJaU++FAaxqML88C7rUwYr4v5Al5Au0aJLXL
	 wtTqITGuukJrw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Oct 2024 14:22:17 +0300
Message-Id: <D53ZWVR69ZG1.3CT6HRHCJI68W@kernel.org>
Cc: "David Howells" <dhowells@redhat.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "Roberto Sassu" <roberto.sassu@huawei.com>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v7 1/5] tpm: Return on tpm2_create_null_primary()
 failure
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>
X-Mailer: aerc 0.18.2
References: <20241021053921.33274-1-jarkko@kernel.org>
 <20241021053921.33274-2-jarkko@kernel.org>
 <bb9ef4af-4a35-40e2-85cc-bcacae4f2dbc@linux.ibm.com>
In-Reply-To: <bb9ef4af-4a35-40e2-85cc-bcacae4f2dbc@linux.ibm.com>

On Wed Oct 23, 2024 at 8:46 PM EEST, Stefan Berger wrote:
>
>
> On 10/21/24 1:39 AM, Jarkko Sakkinen wrote:
> > tpm2_sessions_init() does not ignore the result of
> > tpm2_create_null_primary(). Address this by returning -ENODEV to the
> > caller. Given that upper layers cannot help healing the situation
>
> It looks like returning -ENODEV applied to a previous version of the patc=
h.
>
> > further, deal with the TPM error here by
>
> This sounds like an incomplete sentence...

It looks like totally corrupted, thanks for the remark.

"tpm2_sessions_init() ignores the return value of tpm2_create_null_primary(=
).
Fail early and return back to the caller if it fails. Fine-tune the error
message while at it."
=09
Is this sufficient?

BR, Jarkko

