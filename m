Return-Path: <linux-integrity+bounces-3152-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F01933AEB
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 12:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3323D282AAE
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 10:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FD817E90F;
	Wed, 17 Jul 2024 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCU5ySEv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014B217E8E6;
	Wed, 17 Jul 2024 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210883; cv=none; b=ZV2VHbW2U8FpOEZdrfPykwIyns3Xjm+QbcS5eYTox7qNYKgEK7iQb5r1XFsSo+R3c6DV4s6CpsxevNLysKSk0cD+6ZkiSUJO5Hd1rv2b9jQrnBf2btb7sH2R4IZbIDxjDi9dMZbGoYovujgYg/vQ+v56QRIXSRxZIjxKtCOLnVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210883; c=relaxed/simple;
	bh=mAN8Q6z21yaEw+RDCfZviFVij0V8meYpkEOj5xb/xXQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=FjKY24fXxT52Xa1TzaKZdiGTjHz+v6HN/s3TM1anlUUETPmaiMIP+GCa1JsmEKaGfY1Oge7tiMowNBJbMNmhTfvv9+CKsq1c9SONPRuj0JhiZSnoA8E5ykT8ZXpkoyIyoL87TJMAGfKqvRPLIh53KqDqrFVH67cY6UL3mRpF+nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCU5ySEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6A7C32782;
	Wed, 17 Jul 2024 10:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721210882;
	bh=mAN8Q6z21yaEw+RDCfZviFVij0V8meYpkEOj5xb/xXQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=gCU5ySEvWVLcKid2+BOLuzORFDRJ0gnEz/v7kuA8lAZ0j+EfQ6sSe7T4cUjqJf2yX
	 8jn2O0Kl4FZY6L9V0NxORWXGOXqkctg5w8twdui3xF43m0C1PmAOHmoTGdLfUe/UJ3
	 mMv0ShfSvomrp53oyjtLYHLG1kMwbs/9Y3laHgPVsMdc/pMIgDujahHTT8vogfeE4L
	 vANPEz3KKiOzRH8MShhZ+brWRxNqdC4hBUUoJZu0eRz91JeRieBEQEAxz92PkZPp+C
	 dI5J/11aT8JNQz7CLohQdIxpR0O9lRqTcIvMUYOk/s6T12WQV3D7n/1hKSwY2lAuLK
	 J8alN4xixRtuA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jul 2024 13:07:58 +0300
Message-Id: <D2RQC1H7N1JI.1W4JT8FI0R8L4@kernel.org>
Subject: Re: [PATCH 1/2] KEYS: trusted: fix DCP blob payload length
 assignment
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "David Gstir" <david@sigma-star.at>, "sigma star Kernel Team"
 <upstream+dcp@sigma-star.at>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "David Oberhollenzer"
 <david.oberhollenzer@sigma-star.at>, "Richard Weinberger" <richard@nod.at>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "kernel test robot" <lkp@intel.com>
X-Mailer: aerc 0.17.0
References: <20240703125353.46115-1-david@sigma-star.at>
In-Reply-To: <20240703125353.46115-1-david@sigma-star.at>

On Wed Jul 3, 2024 at 3:53 PM EEST, David Gstir wrote:
> The DCP trusted key type uses the wrong helper function to store
> the blob's payload length which can lead to the wrong byte order
> being used in case this would ever run on big endian architectures.
>
> Fix by using correct helper function.
>
> Signed-off-by: David Gstir <david@sigma-star.at>
> Suggested-by: Richard Weinberger <richard@nod.at>

You cannot suggest a change that you author yourself.

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405240610.fj53EK0q-lkp@i=
ntel.com/
> Fixes: 2e8a0f40a39c ("KEYS: trusted: Introduce NXP DCP-backed trusted key=
s")

Tags are in wrong order. For next round:

Cc: stable@vger.kernel.org # v6.10+
Fixes: 2e8a0f40a39c ("KEYS: trusted: Introduce NXP DCP-backed trusted keys"=
)
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405240610.fj53EK0q-lkp@int=
el.com/
Signed-off-by: David Gstir <david@sigma-star.at>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>


BR, Jarkko

