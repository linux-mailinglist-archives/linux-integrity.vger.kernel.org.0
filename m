Return-Path: <linux-integrity+bounces-3882-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8801C9A59BA
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Oct 2024 07:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343D61F21E25
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Oct 2024 05:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1953B192D80;
	Mon, 21 Oct 2024 05:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAk52Tgy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ED7282F4;
	Mon, 21 Oct 2024 05:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729489169; cv=none; b=WxtPNV7IQiInhdG+aVHanMz7p6W9SLL27NaOUUjS8ZiW8c8FBi99GMVCoCaaa06XMnKdK0WNvo3qOEaXcgUPGoR2cASqKtRvROawOp/iU0SizMLx+FZ/d4YM8tEiO2YLTsjQMJ5+IuZfrxTYvMb2cI4Rz4PcUpsZwc1LkqZoGEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729489169; c=relaxed/simple;
	bh=Sy/1Xh6Cmsinz6jBvbMg0OFxnEdyuCFgaT5jk/uiOTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WG6yP8QSCWYEbzZ5tUBO5vQS59yiyAbdXoeh9paA2qHn76AMu/rbanNbFBbQTmt7EUNx5hcK4fa4mH6WBRckt78nOpFWI4RbFD7VcrE9kbeLuJTWH+3N6WUWRmpmuGj0kTfHd77HMrWGsklQbeRqmqpUKidm9oEAiXunTA6Er4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAk52Tgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EDFC4CEC3;
	Mon, 21 Oct 2024 05:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729489169;
	bh=Sy/1Xh6Cmsinz6jBvbMg0OFxnEdyuCFgaT5jk/uiOTM=;
	h=From:To:Cc:Subject:Date:From;
	b=FAk52TgyF785rVtjiW/kvuEYkApEKKKdGiIZpj4+zFI+rZJeMd5B2RFngr9ByeH6t
	 EPoZ6TdvIJqPNXrN8hVKxAL6/hc03T89+jEvEApZtUJDlhz6JaEZdArh/gHbrwSQ9u
	 vHQQwm3mJz17/GKs8efQqL/E9RwzmWL03ftonDB4ROBX9w8+IoRamsMnEUkeN82LRV
	 RotiAGvrA+pyP0/s3BNr6TOHo7VHQcFeeN1N62bGjaaAR1nZ2JroVjaCaECh7LNKwH
	 fQn6slRJLqeFPK50vMrLW3RXoUVcKzoxO8nlx/6V86/rI+jPwBam0Bg/COCY5rxDmA
	 r+ceK05Cn07hQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/5] Lazy flush for the auth session
Date: Mon, 21 Oct 2024 08:39:14 +0300
Message-ID: <20241021053921.33274-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cc: David Howells <dhowells@redhat.com> 
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219229

v6:
https://lore.kernel.org/linux-integrity/D501D1CY5SJ4.SUKXHV680B30@kernel.org/T/#t
v5:
https://lore.kernel.org/linux-integrity/D4WQ58T5O21X.CGFKGFKV630K@kernel.org/T/#m527d0466a02abaa448720999ff055de0540e7bb7
v4:
https://lore.kernel.org/linux-integrity/20240918203559.192605-1-jarkko@kernel.org/
v3:
https://lore.kernel.org/linux-integrity/20240917154444.702370-1-jarkko@kernel.org/
v2:
https://lore.kernel.org/linux-integrity/20240916110714.1396407-1-jarkko@kernel.org/
v1:
https://lore.kernel.org/linux-integrity/20240915180448.2030115-1-jarkko@kernel.org/

Jarkko Sakkinen (5):
  tpm: Return on tpm2_create_null_primary() failure
  tpm: Implement tpm2_load_null() rollback
  tpm: flush the null key only when /dev/tpm0 is accessed
  tpm: Allocate chip->auth in tpm2_start_auth_session()
  tpm: flush the auth session only when /dev/tpm0 is open

 drivers/char/tpm/tpm-chip.c       |  14 ++++
 drivers/char/tpm/tpm-dev-common.c |   8 +++
 drivers/char/tpm/tpm-interface.c  |  10 ++-
 drivers/char/tpm/tpm2-cmd.c       |   3 +
 drivers/char/tpm/tpm2-sessions.c  | 115 +++++++++++++++++++-----------
 include/linux/tpm.h               |   2 +
 6 files changed, 108 insertions(+), 44 deletions(-)

-- 
2.47.0


