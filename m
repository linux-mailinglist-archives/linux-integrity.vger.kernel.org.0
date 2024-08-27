Return-Path: <linux-integrity+bounces-3410-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE589617F7
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Aug 2024 21:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA251F24B87
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Aug 2024 19:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491051CFEDC;
	Tue, 27 Aug 2024 19:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjPheou2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B70B77117;
	Tue, 27 Aug 2024 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724786898; cv=none; b=OUWFyRjVyCXKfFc2xVJ1bvZFGt3PqDmp9uVTyh44TP+LWcgIzDT1aRdcRPFaUqdgWZu6H1EMKSsCWeO7O4NzSxji2SugbDcnlC3IxLjS1IGo3aqKQ4St/0eyngT2AQCOyuL2CsZUzSec5Y63FTiKXnj5vxtewR69iqYUi0F5eu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724786898; c=relaxed/simple;
	bh=INQLM/QHDaLa8UQEb+hgn/bB/mse+eLCIi6nGDdtQKw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=i67WjjOm4tgcm0dyceENuiz4+vJp2wrnFWmdfRx+/KYNipihH7LZaoXvL5WMdw2/gehriQcnR1v82VWCcn16zcz3kOrvqQuZypwYgsrOc2LDWKf1GWEWAEE+rocJvX9b3Nz7sDRuDT07auvq7bK37DpwZ3HRdxYLPsmgyTREHhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjPheou2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E946C32782;
	Tue, 27 Aug 2024 19:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724786897;
	bh=INQLM/QHDaLa8UQEb+hgn/bB/mse+eLCIi6nGDdtQKw=;
	h=Date:Cc:Subject:From:To:From;
	b=AjPheou23EfD4GpR4IOajaTvychmmtPZUtlg2rf19WovRMTVDiocYIhIqptzPPFd2
	 FkSCDZHhNP2U7MphblDPD/k/SNrc6Yho1Bha1XBVZU+3zPhTeWzMs8d8zDVYhjtagj
	 qbRsgvg0VqdFZTeHXQWaBZK6ZcW4EM50wua4Kb3BgLsEgut9auUUlibFLElp1xZDjd
	 cUl24xSgTiT3ApwKgpb1wofV80eXD+9IiCgFnut2Z8zAUWrLODGe8JB2hYpYu5wpUG
	 sbY3bjh1Jk47Oy9RMtaDCIsE6zENWT9GxZhWM49kcit7AZNcFIf2aHC35KS/DpzBuY
	 Q3Vu+HrLLNW0A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Aug 2024 22:28:13 +0300
Message-Id: <D3QXXCFHY73S.26C2JS9ZOV7IQ@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "David Howells" <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Stefan
 Berger" <stefanb@linux.ibm.com>
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.11-rc6
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.17.0

The following changes since commit 3e9bff3bbe1355805de919f688bef4baefbfd436=
:

  Merge tag 'vfs-6.11-rc6.fixes' of gitolite.kernel.org:pub/scm/linux/kerne=
l/git/vfs/vfs (2024-08-27 16:57:35 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/tpmdd-next-6.11-rc6

for you to fetch changes up to 08d08e2e9f0ad1af0044e4747723f66677c35ee9:

  tpm: ibmvtpm: Call tpm2_sessions_init() to initialize session support (20=
24-08-27 21:11:44 +0300)

----------------------------------------------------------------
Hi,

Contains a bug fix for tpm_ibmvtpm driver so that it will take the bus
encryption into use.

BR, Jarkko

----------------------------------------------------------------
Stefan Berger (1):
      tpm: ibmvtpm: Call tpm2_sessions_init() to initialize session support

 drivers/char/tpm/tpm_ibmvtpm.c | 4 ++++
 1 file changed, 4 insertions(+)

