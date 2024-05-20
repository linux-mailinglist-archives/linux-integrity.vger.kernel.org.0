Return-Path: <linux-integrity+bounces-2483-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 385E58CA283
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 21:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D3C1C21277
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 19:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1139D137C4E;
	Mon, 20 May 2024 19:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBRHySU/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5425137C27;
	Mon, 20 May 2024 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716231902; cv=none; b=ZPEI1iWM1irGD+GXU7/yTnlLPbIH29QgZLjmGYEojLoyu+0HVN1RGmncZYCdmfLfeMlJu5Gul3Bzd6IrbxTmi+YhGRTAAjGG6Oxn01aOKwBROdJoDlZFDq8YV2drqUOr2AWPXCCpu+EqbqZuiKQ/E3+ufVfva222Q++O0YokQnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716231902; c=relaxed/simple;
	bh=2bofe4srdc7g/v+TH2JcderECmQbSv5VsRs5x7ADRJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdbH8xDm7MO55HWIHpo6WwD3ZrFy8X0GSFZqdp9fOLQvdEyH4QrkofOjsFNpuB0D9R8cPSTjivsX3tyz+7+BUxeJ+oh3Fy3xAjp2p8tdnAx/tIuuUHqjJuvHt1HmNhFYYhCeEUGAxUWfwH5Af3tWl8am//mZsC5r005Wrg0QKQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBRHySU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5326C2BD10;
	Mon, 20 May 2024 19:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716231901;
	bh=2bofe4srdc7g/v+TH2JcderECmQbSv5VsRs5x7ADRJY=;
	h=From:To:Cc:Subject:Date:From;
	b=eBRHySU/NF3dXIsJ5EBOukjYPr/RPuVxg/3/HuwfeMSIn4iLreyuNiX4hD8+deLjV
	 lcachPR3ep9RiXIe7I7HZTkp61cDseYPikysNl6Yn6onWgN3eYFLSmdKNV8FeqP9Be
	 3NA4bgEKOzK0Qv68R6JzE1J0E4FSiqRWRacH9yjLIdPw02QvI9c0wFkuN9c/QdvhQp
	 npG0LZ8KIM6srIkOb4CH4KA7Xw65xbSRsIF/T36gJ6e8+z2n/Ni9x+cShrCnjIERqt
	 jFXyU40I3eGbTsvgTvfFyMguW5nJcYguPa/Pfv85i7Af11MLj+6KRxgJkavJ9BM2aB
	 EpARyH3xvLYYQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org,
	James.Bottomley@HansenPartnership.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2]  KEYS: trusted: bug fixes for v6.10-rc2
Date: Mon, 20 May 2024 22:04:51 +0300
Message-ID: <20240520190454.28745-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accumulated bug fixes for trusted keys.

v2: 
Dropped a patch disabling hmac by default for now.

Jarkko Sakkinen (2):
  KEYS: trusted: Fix memory leak in tpm2_key_encode()
  KEYS: trusted: Do not use WARN when encode fails

 security/keys/trusted-keys/trusted_tpm2.c | 25 +++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

-- 
2.45.1


