Return-Path: <linux-integrity+bounces-3489-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C604896F714
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 16:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42BE7B2433A
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8421D0DD6;
	Fri,  6 Sep 2024 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FK3h2sxK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C35156880
	for <linux-integrity@vger.kernel.org>; Fri,  6 Sep 2024 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633645; cv=none; b=Iyyx9jj4ycmhy4LRqzoAovr+2gRzpDPR3oSUIG+rlVZd20sp8hQyu2+S9dnNqne7yN4E3SmqiJxfqzwhBRuweWMJDERkY4e5nfpuYEAOuZodQF4oris7/8S+6gVKNRtcHwYQkNBmBE1dkz9XhhY4bFX80CL8qJGABgKYwemkKc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633645; c=relaxed/simple;
	bh=eyJuTYjuEjD7ktVS2i3vhYEU9u4psLrUfooxM+9g2kA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=HNcRDulm+omCQWT5HrSlRFRapTmLWqyeUd/2Y3BsFQ92glpGxHccoe2UrcZJRtlfA1uBVhnIQWl63i3okh61r9ZR5Cm6pKDAF76wnkk0OYEXx6USGxL6zv97G8uCsdumVI5Nu3lLSpsT3y3+rdD9/VJStTFCQ2y79xbXkMea5aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FK3h2sxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69589C4CEC9;
	Fri,  6 Sep 2024 14:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725633644;
	bh=eyJuTYjuEjD7ktVS2i3vhYEU9u4psLrUfooxM+9g2kA=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=FK3h2sxKB4FLBlAgw5/r9E/scirGqn93WYBmhnXXUE4A0J3FWQq2/vQnRPU5SuXvz
	 6eVRPxWQ070RCtFbrjl5ac/XS4QCWfgmqrDTvcmXHKWpJRDpovvf2iYuKkPzBsH8N0
	 V/bZWG9CgcKJixZ99SBwHFIWDqJuPVWRdf/NNzgQq2p4O0PcHCwjzhpDkhLbtEJzYC
	 WqiUto3Q4K8t78LCka07ExDe9ZmUfNkGZBvxCOqRvYL08mzUxQKEmPlegevUn32Sfo
	 yqWhSOD/+sWatFsij7BsOVUcE56eLaKAdpVV3wC0/Ll9Ib53Vgacn+eWLvn6Gx2Hnw
	 YeKpkad1viC9g==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Sep 2024 17:40:40 +0300
Message-Id: <D3ZA2MOLUMUR.3NEU8TFVD30SP@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>
Cc: <linux-integrity@vger.kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>
Subject: Re: TPM HMAC (really) bad performance
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <b8a7b3566e6014ba102ab98e10ede0d574d8930e.camel@huaweicloud.com>
In-Reply-To: <b8a7b3566e6014ba102ab98e10ede0d574d8930e.camel@huaweicloud.com>

On Fri Sep 6, 2024 at 3:32 PM EEST, Roberto Sassu wrote:
> Hi all
>
> when running the benchmark on my new component, the Integrity Digest
> Cache, I ran into a serious performance issue.
>
> The benchmark is extending a TPM PCR with 12313 entries of the IMA
> measurement list, and calculating the time elapsed for the operation.
>
> Without TPM HMAC: 102.8 seconds
>
> With TPM HMAC: 1941.71 seconds
>
>
> Do you have already an idea on how to improve the situation?

Some missing details: CPU architecture and TPM chip type.

Would be possible to generate off-CPU flame graph?

For decent instructions:

https://www.singlestore.com/blog/linux-off-cpu-investigation/

You can do post-processing steps "offline" only capture step would
need to be done in-target.

>
> Thanks
>
> Roberto

BR, Jarkko

