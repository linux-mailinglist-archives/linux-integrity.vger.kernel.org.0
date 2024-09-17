Return-Path: <linux-integrity+bounces-3620-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A08E97B242
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2024 17:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FCC2B29C64
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2024 15:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56ED0193094;
	Tue, 17 Sep 2024 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h10eRDi1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A811925B8;
	Tue, 17 Sep 2024 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726587890; cv=none; b=Z5+Gl7lhnBz4pKytketbl43RuJLyY5Vy6v7yqho/rHyJ+0TGGHHpEID+VyoxfSH6C/Ahav9ar4HCnb2gARsXMPQiKvfouhSyRl0IXh2Jd6UAfV5Je2nv50pOwfYbeJcow6S+1/ehLU56s2o06AxahFXvE/AhRPjYihnED0A/Y10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726587890; c=relaxed/simple;
	bh=t6fzqa0dX9J8NmFoel5FRlQUYfEGPG0alB9LerBgwg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tbLzrcordKFW1Bfn2apBfcMxyD1jMAuE7m2qi4I4WEkQDyuhgOJ96EKEZj/ORBws0VkLYSngBh9LiZNTh69QvggMz5o4ywwnhKo35L9joWTR6G8pEof7KmZ/9C2EzMeUu4ts9g0v0jkyghfZfes8G6h/wbF/zGSlJHt3CFboQlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h10eRDi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DB6C4CED4;
	Tue, 17 Sep 2024 15:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726587889;
	bh=t6fzqa0dX9J8NmFoel5FRlQUYfEGPG0alB9LerBgwg0=;
	h=From:To:Cc:Subject:Date:From;
	b=h10eRDi1dewRa21JdYUwM0rGXesQvN9jyUp+PfK4tcJP/JMEWbVh+epwJgfkA11Oq
	 0E/CBMiMJA9MZbXUpbNdv+4nd8ZexuvW5tCut703mENBXntUM89Gdaiz0VuBI+Mw6v
	 sjsFKTapI5lhTpZH99G7uDFY/JzM8KSW6627GpjpVEqPKqADmX5gSw+SsaEXaNgSTq
	 woF2yC9unMkeeMfJepfoLPPx94GjFyDIBfqW1suC74asVFO1znPd0xxtNIVAKQYp7U
	 9trToyOlJh0ZQIuDYRCY0xfip+UnUOm3AcyvcGu9mFSnnmR/eNjwFcT1HZbZ2wqgA8
	 H2gZQVsxFPNIw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	roberto.sassu@huawei.com,
	mapengyu@gmail.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] Lazy flush for the auth session
Date: Tue, 17 Sep 2024 18:44:29 +0300
Message-ID: <20240917154444.702370-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the sake of: 
https://bugzilla.kernel.org/show_bug.cgi?id=219229

v2:
https://lore.kernel.org/linux-integrity/20240916110714.1396407-1-jarkko@kernel.org/
v1:
https://lore.kernel.org/linux-integrity/20240915180448.2030115-1-jarkko@kernel.org/

Jarkko Sakkinen (7):
  tpm: Remove the top-level documentation tpm2-sessions.c
  tpm: Return on tpm2_create_null_primary() failure
  tpm: Return on tpm2_create_primary() failure in tpm2_load_null()
  tpm: flush the null key only when /dev/tpm0 is accessed
  tpm: Allocate chip->auth in tpm2_start_auth_session()
  tpm: flush the auth session only when /dev/tpm0 is open
  tpm: open code tpm2_create_null_primary()

 drivers/char/tpm/tpm-chip.c       |  14 +++
 drivers/char/tpm/tpm-dev-common.c |   8 ++
 drivers/char/tpm/tpm-interface.c  |  10 +-
 drivers/char/tpm/tpm2-cmd.c       |   3 +
 drivers/char/tpm/tpm2-sessions.c  | 196 +++++++++++-------------------
 include/linux/tpm.h               |   2 +
 6 files changed, 109 insertions(+), 124 deletions(-)

-- 
2.46.0


