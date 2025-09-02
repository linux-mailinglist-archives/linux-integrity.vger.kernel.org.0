Return-Path: <linux-integrity+bounces-6977-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ED8B40BFB
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 19:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA473A868B
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 17:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CC3341649;
	Tue,  2 Sep 2025 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="h3hp6qOw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03EB2FE599;
	Tue,  2 Sep 2025 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834003; cv=none; b=XJKDHNYnR1t4GIhQtWNLXRPZDHyJ3N1w+lMWOeqxXV2QSVKNZmXbDM6WkcpY9Fv8Y9IldT6A1c19HhRx73uBQYMmg2IA4/hyMactq5e25DsuBd/zmLhaFw7ZdtKihdb6lf/pzI/H/H2yIWSkq/RgHHoLtvSrsvEU8n4NAZQS0lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834003; c=relaxed/simple;
	bh=yQUsr4Z+mfsLxbLmx4Ar1fy8Ps09eItMkf+hi1MXtYI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Fq+HMLBXikCmvsgkw4Qs7Il3VGTkxrbHs38oZkm2zIt6HZGpKzp905GgFPZBf95yyUfrGWU2YFAl1fNmbkMoG5XPqbke1zSlbbCMQtENe5jIQs8TVivSyraXRlrLa4awAtd88UngzvVl+1Wfs0rhTtO7jRp1jxIIJv2io0aduEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=h3hp6qOw; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=TmVSFScaNbrRGyjqLpq02kRepZR1s+gbvl964ZLcX34=; b=h
	3hp6qOwcdfG53jG7Ppv4h6gbY/qCaehLSo/wcnLYXx712IsN1kXXweyz6xPpWNcVzCHSTWQdzY6Zh
	YB3debFPXYG+FwxefGe+df2iAaSJ09kKK56sr0JOTXljLEoFqpeQIdmBbxQdR30uB8tE6QzLUMc63
	wFTNOR2XxShQdd7YXnLbpbXXWfbS3+x2OoThZuLgc4W6joJYWLkwUIh4fde3LIQoMJUkKP+J7aKhR
	n/ajfVGoIJ4KKvVaEAreZdiau2sSYQcQC3l23WYmd/gyvAvUbexE8l2HRPy5Ed7GKKFoaarX6GL92
	zTEh6bQ+nztjakRqaUByAtAgEKDUp6OEQ==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1utUm8-002QVl-1A;
	Tue, 02 Sep 2025 18:26:32 +0100
Date: Tue, 2 Sep 2025 18:26:32 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] Re-establish ability for exclusive TPM access to
 userspace
Message-ID: <cover.1756833527.git.noodles@meta.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I hit a problem last week were ~ 1% of TPM firmware upgrades were
failing. Investigating revealed the issue was that although the upgrade
tool uses /dev/tpm0 this does not actually prevent access via
/dev/tpmrm0, nor internal kernel users. It *does* prevent access to
others via /dev/tpm0

So the upgrade process started, the HW RNG came in to get some
randomness in the middle, did the HMAC context dance, and confused
everything to the point the TPM was no longer visible to the OS even
after a reboot.

Thankfully I've been able to recover those devices, but really what I'd
like is the ability for a userspace tool to exclusively access the TPM
without something coming in behind it. Given the lightweight attempt at
locking that already exists I think this was the original intention.

As an initial approach I propose this patch set; I don't think the first
2 patches are controversial, but the blocking of kernel access + switch
to O_EXCEL in patches 3 + 4 might be. I'm open to alternative
suggestions about how to achieve this.

(I've sent a separate standalone patch that allows the TPM HW RNG to be
disabled at run time, but even with that I think something like this is
a good idea as well.)

Jonathan McDowell (4):
  tpm: Ensure exclusive userspace access when using /dev/tpm<n>
  tpm: Remove tpm_find_get_ops
  tpm: Allow for exclusive TPM access when using /dev/tpm<n>
  tpm: Require O_EXCL for exclusive /dev/tpm access

 drivers/char/tpm/tpm-chip.c       | 90 +++++++++++++++----------------
 drivers/char/tpm/tpm-dev-common.c |  8 +--
 drivers/char/tpm/tpm-dev.c        | 27 +++++++---
 drivers/char/tpm/tpm-dev.h        |  1 +
 drivers/char/tpm/tpm-interface.c  | 20 +++++--
 drivers/char/tpm/tpm.h            |  3 +-
 drivers/char/tpm/tpm2-space.c     |  5 +-
 drivers/char/tpm/tpm_tis_core.c   |  3 +-
 drivers/char/tpm/tpmrm-dev.c      | 20 ++++++-
 include/linux/tpm.h               |  3 +-
 10 files changed, 112 insertions(+), 68 deletions(-)

-- 
2.51.0


