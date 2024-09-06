Return-Path: <linux-integrity+bounces-3480-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B0996EFED
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 11:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25741C24CE8
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 09:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015621CB120;
	Fri,  6 Sep 2024 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0ArQOjW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F8041A8F;
	Fri,  6 Sep 2024 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615679; cv=none; b=P9NA4ee/EzE1SQPscRkzhHWUs64PBKZvmumsm13a/Ws77kQkU26adO5Ve0/624TeIDHtbAF5ug6tGo8JHxlBdKIKnG/OVNMybncYJft95S/GCf0fKIgMaeN0VcQbh4LfISYfB4VPdDopRRLDfgkseC1cCGfzzuiLlIhTDy19sVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615679; c=relaxed/simple;
	bh=JjZqL1RBvc1s+B2BTVxk55OHAym/Yiv/iFO6lEqdluE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TBSHCvg5zQPRH4qKsRFZS9XtNrLvfPEkRs4TihfBTx499SCDqKgvhLLuwpDZ1jP8tOWoOhTNF3BLWmOE9OxQDvhdpE4yYQq0VB72Hd/lmZ4iak8x6AQNtM7RYCbrYAuQlEVjeLY5CbsZI051wsmFt0xYU+9d/PogYnvkaOtK61c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0ArQOjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E16C4CEC4;
	Fri,  6 Sep 2024 09:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725615679;
	bh=JjZqL1RBvc1s+B2BTVxk55OHAym/Yiv/iFO6lEqdluE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=r0ArQOjWtiyHI4/hED/moftheKLDoEokqe9ctJAKLq+r6O1jthYwK7TBMulN677/g
	 pdj3xAZFgKEJDF3sVN2leTV4EVZO4o9dVR+STYV2T+8fBmDmwrHaRlHdCxd0ZvIO9W
	 Ckw+kmPemqyZl+J5s0sfd5rnF5W8LyvHkChxDBcIxWRgqMn+bppIi1brUC2IyDgOlT
	 DI4UM9ZcUV7YyhryVyA5XOVQzeYJ/PFhjH8cv4MIqoZiI2sYrSLFYcLxEBqarehb98
	 luIBEnO+HnLB1EL5FlpRtAXdARBelLC+zy1EXRLkZIeqZtpcQtDLeKOdJsKv6TaOLn
	 arPjWdlYzpt/g==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Sep 2024 12:41:15 +0300
Message-Id: <D3Z3PDARWOV4.1CBB4U4NW846J@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <wufan@linux.microsoft.com>, <pbrobinson@gmail.com>, <zbyszek@in.waw.pl>,
 <hch@lst.de>, <mjg59@srcf.ucam.org>, <pmatilai@redhat.com>,
 <jannh@google.com>, <dhowells@redhat.com>, <jikos@kernel.org>,
 <mkoutny@suse.com>, <ppavlu@suse.com>, <petr.vorel@gmail.com>,
 <mzerqung@0pointer.de>, <kgold@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>
Subject: Re: [RFC][PATCH v3 01/10] ima: Introduce hook DIGEST_LIST_CHECK
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, <corbet@lwn.net>,
 <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
 <eric.snowberg@oracle.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
 <serge@hallyn.com>
X-Mailer: aerc 0.18.2
References: <20240905152512.3781098-1-roberto.sassu@huaweicloud.com>
 <20240905152512.3781098-2-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240905152512.3781098-2-roberto.sassu@huaweicloud.com>

On Thu Sep 5, 2024 at 6:25 PM EEST, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Introduce a new hook to check the integrity of digest lists.

"Introduce DIGEST_LIST_CHECK, a new hook..."

>
> The new hook is invoked during a kernel read with file type

"with the file type"


> READING_DIGEST LIST, which is done by the Integrity Digest Cache when it =
is
> populating a digest cache with a digest list.

The patch creates a new struct imap_rule_entry instance when it parses
the corresponding rule, which means that there are couple slices of
information missing here:

1. The commit message does not tell what the code change effectively
   is. I scavenged this information from [1].
2. The commit message does no effort to connect the dots between the
   effective change and the expected goal.

I'd put a lot of effort to this commit message assuming that the new
hook is at the center of the goals of this patch set.

[1] https://elixir.bootlin.com/linux/v6.10-rc4/source/security/integrity/im=
a/ima_policy.c#L1404

BR, Jarkko

