Return-Path: <linux-integrity+bounces-3612-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A82979FE9
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2024 13:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2291F22328
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2024 11:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2286D14E2C2;
	Mon, 16 Sep 2024 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0z1UcmH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41F2149C57;
	Mon, 16 Sep 2024 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726484843; cv=none; b=e9CUaxyn3nE6T7FR8DiZXxf0APqUK7BrtlLTrBn0zMDnU69ex4oHbNcD2ZIXokjhCazhTSux/gPYx+PsmxLkE2RPaRjvSoAPsr/tj8eZrJa8MxpfUCfHK3KfRzYQ50xwpmU1THM0kaCgdIs6mH/rqVFLuOtLeSaJDwi7Glu29u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726484843; c=relaxed/simple;
	bh=ogSCCoY7jR/x8U8CbOuThlk91uW2EgWoR2oxnB104Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pIJu9MJWAH49JtOwXaLsTNRQvajGeSsMVWMt16lidh1GULKhA7zhJ5qpxhfw+ZDHORD4QAn75HEkM0qfoX596b5AAYvckASbq8CWVQdWdU9CNX+P/9Qz7vkx4ISsQ8iKYfVKAZNONxTpf/lRAoDgxUEu6lLfzwKbbZgCSThzFIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0z1UcmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108E9C4CEC4;
	Mon, 16 Sep 2024 11:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726484842;
	bh=ogSCCoY7jR/x8U8CbOuThlk91uW2EgWoR2oxnB104Vw=;
	h=From:To:Cc:Subject:Date:From;
	b=V0z1UcmHv32AxILzPMSqkZFjbdtUCzZ55DUpXHkmgJ61fLg3dS4aZ4mI0fIwUkzrF
	 MRe+fUBtrmhNrKDZQ+wFxyAIWVmnLHP1Zb+mjTJ6+d5F7lTXA5GCBuyh4QqRnNLPse
	 BErXw9WjnVu4PPClDcq5tUzk2kCDxK9JoizH3F3Vf6dkZoIzS+AN3ov3AL2KSL6rJ5
	 SHZToTRtu2yNDig6gksCaCpJiGvmUZoh3+MXWBPbBgc4SguXTP1e3EwBQLhpL5l4S0
	 EbHmn604Bnar61uy97YGTV9Sbg4D2qD9IesFmoYz5GlT5iE1XonrybcCo/22DAHAIG
	 JmOcejQ75IbMQ==
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
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/6] lazy flush for the auth session
Date: Mon, 16 Sep 2024 14:07:05 +0300
Message-ID: <20240916110714.1396407-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set aims to address https://bugzilla.kernel.org/show_bug.cgi?id=219229

v1: https://lore.kernel.org/linux-integrity/20240915180448.2030115-1-jarkko@kernel.org/

Jarkko Sakkinen (6):
  tpm: Remove documentation from the header of tpm2-sessions.c
  tpm: Return on tpm2_create_null_primary() failure
  tpm: Return on tpm2_create_primary() failure in tpm2_load_null()
  tpm: flush the null key only when /dev/tpm0 is accessed
  tpm: Allocate chip->auth in tpm2_start_auth_session()
  tpm: flush the auth session only when /dev/tpm0 is open

 drivers/char/tpm/tpm-chip.c       |  14 +++
 drivers/char/tpm/tpm-dev-common.c |   8 ++
 drivers/char/tpm/tpm-interface.c  |  10 +-
 drivers/char/tpm/tpm2-cmd.c       |   3 +
 drivers/char/tpm/tpm2-sessions.c  | 156 ++++++++++++------------------
 include/linux/tpm.h               |   2 +
 6 files changed, 98 insertions(+), 95 deletions(-)

-- 
2.46.0


