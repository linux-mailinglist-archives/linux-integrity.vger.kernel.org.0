Return-Path: <linux-integrity+bounces-7815-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C79CA60F6
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Dec 2025 05:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 091B43030C8B
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Dec 2025 04:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09001F1518;
	Fri,  5 Dec 2025 04:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ue2gd0CV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878661E32D6;
	Fri,  5 Dec 2025 04:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764907230; cv=none; b=bKnbFo2qdRFE6kUls+x5N8Mqawowp1qj9zGYjhfhMH3YmnRdYLdkIyyyVe2ZsH9UZwvgyITD12QSXqeJ1TJo3oLofcGfQQqXTHS+8pQIT2Hhs9n2QlbdG7jgrzflejtg6s+msQ4VlHJnWtbftvi9rJeHGjj8sVxpx11wS5bJTmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764907230; c=relaxed/simple;
	bh=z03o42zGoDe+OthyWMPgp6ePsn+z3KR3xFOxfjDFFNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JNCtV5QftEP+dwvZKTl+uRDe27pXbGV+iOJyzm08FubDlQHnVJaaUdYhoxFbzDjhK6CyPl8199RU5roAp+cfNI+VTHoFMDNWIjP2xUCZxw6rwaNA8UCpiKa72EAcmKFWuQR+7x7EW7pZjWH/H5ZDRN3MIznIeVHRERZbI20NXXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ue2gd0CV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FE1C116D0;
	Fri,  5 Dec 2025 04:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764907230;
	bh=z03o42zGoDe+OthyWMPgp6ePsn+z3KR3xFOxfjDFFNE=;
	h=From:To:Cc:Subject:Date:From;
	b=Ue2gd0CVqfOxSxgeKr7GFbEeiUCmrIyGwTR4WmkBncHoZn9AHbNai6vfzHKab/uvZ
	 b+DPZ37hLq2Ja54vS6HuwR6L8esNDQ7oYNXPvD58v7TF3zarR9TNtHpgQTFGaFhifV
	 7BosVWHUz23Pbm59eT7mI8h8nV50snm8oP9NWodn/51ZrX6Je7K3uG8+UTKDs8vSrU
	 R3d0g31+sNV6ydSChuYZdkfdXIofurJMx44bzwyroTuTp3XNnxPYjHCiWjvIs8VYNa
	 HWc3dTUQpm6eNVGb56SQb49bI0lQ8mBa1smzguOjmWDrEcHjxOZacjD1an+lizXSVl
	 ENLBMOdCeGQeQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 0/2] KEYS: trusted: Optimize tpm2_read_public() calls
Date: Fri,  5 Dec 2025 06:00:18 +0200
Message-ID: <20251205040021.207369-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main goal is fairly straight-forwrd here.

The aim of these patches is optimize the number of tpm2_read_public()
calls to the bare minimum.

Jarkko Sakkinen (2):
  KEYS: trusted: Re-orchestrate tpm2_read_public() calls
  KEYS: trusted: Store parent's name to the encoded keys

 drivers/char/tpm/tpm2-cmd.c               |  93 +++++++++-
 drivers/char/tpm/tpm2-sessions.c          | 163 ++---------------
 include/linux/tpm.h                       |   3 +-
 security/keys/trusted-keys/tpm2key.asn1   |  17 +-
 security/keys/trusted-keys/trusted_tpm2.c | 207 +++++++++++++++-------
 5 files changed, 266 insertions(+), 217 deletions(-)

-- 
2.52.0


