Return-Path: <linux-integrity+bounces-7496-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C555BBECEF1
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Oct 2025 14:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18A4C4E144F
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Oct 2025 12:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD811B4F1F;
	Sat, 18 Oct 2025 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBzlZTtH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A1116DEB1;
	Sat, 18 Oct 2025 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760789019; cv=none; b=fiwQndD3ALVUzcpVxNj3fiGqZ3r5IrGgRyng4bTmkr63mCgNE8Ryvehss0ZkBEl2hl7zzZRAo+prwqt+/wT/NzCKRSCK5LO5hR6/sWQ0SORG59s9Af7BTEd9Od8F+qqV9ofxIUg81LjlWQ1wHZIBG2qP6PPW6TVvMoFASW7C1OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760789019; c=relaxed/simple;
	bh=gYZBW/sWS31ilT+M/E2kXGN9eI1Lhq0dGc4w9/AS2iY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ekOHCqYeJBhHTg8ln7jeDt0/NQh/AdP32MZJImKzZquN8eoXxKn74KmXa4sNRHUiwWvYpvKB46bAYpRbS0jcOEXMZcdaPCmjW4U3Sa/wD8VaVeE0MKo0jUhbcEmuJtOpzYJqQLUwLVF8vDpoyTahkCOlryAWgFrWFadieba7oWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBzlZTtH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D50C4CEF8;
	Sat, 18 Oct 2025 12:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760789019;
	bh=gYZBW/sWS31ilT+M/E2kXGN9eI1Lhq0dGc4w9/AS2iY=;
	h=Date:From:To:Cc:Subject:From;
	b=NBzlZTtHgufiqmMRKOjNF3nci0n7fHcV6NwpfkopUpgS5lJcz1uQqsflYePLC2pT8
	 9KmAOliQbaqdsO63IFHncCDH8AGxacZTvNWMfKGKTFAviYwwQEivWkB+fETMOZjuyD
	 WbVGr38uAQ7AIywYGsUUZYc6ZNAB92ndT6Otzg4Z20f+SngJXdgg0ah63GUpHd/Hzx
	 8SNeJW6SYhsC5Fjkr6FE2vTDbp1Mke3HzQb74r0QV7Dao9Jy9ysPZUVfaQvLyxkLnY
	 h2xKVLDbW4EnNtpdklOs83rN8CoaV2muNgf50wTTteWdZ/OD1wRjWvxUHt4gUEgLW4
	 PLAYQbCyvAmpA==
Date: Sat, 18 Oct 2025 15:03:35 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stuart Yoder <stuart.yoder@arm.com>
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18-rc2
Message-ID: <aPOB9lMvnrXLf4ZD@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit f406055cb18c6e299c4a783fc1effeb16be41803:

  Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux (2025-10-17 13:04:21 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-v6.18-rc2

for you to fetch changes up to dbfdaeb381a49a7bc753d18e2876bc56a15e01cc:

  tpm_crb: Add idle support for the Arm FF-A start method (2025-10-18 14:33:22 +0300)

----------------------------------------------------------------
Hi,

If possible, could you still pick this change for v6.18 [1]? The change in
question  corrects the state transitions for ARM FF-A to match the spec and
how tpm_crb behaves on other platforms.

[1] https://lore.kernel.org/linux-integrity/aPN59bwcUrieMACf@kernel.org/

BR, Jarkko

----------------------------------------------------------------
Stuart Yoder (1):
      tpm_crb: Add idle support for the Arm FF-A start method

 drivers/char/tpm/tpm_crb.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

