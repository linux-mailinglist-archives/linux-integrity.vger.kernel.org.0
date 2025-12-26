Return-Path: <linux-integrity+bounces-8138-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBBCCDEADC
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Dec 2025 13:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4C7F3005F3C
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Dec 2025 12:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2D431CA4C;
	Fri, 26 Dec 2025 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgXTLw/G"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DFD2BD5AF
	for <linux-integrity@vger.kernel.org>; Fri, 26 Dec 2025 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766750978; cv=none; b=NOUCDo+bEPIMDffR1rXg8CsLIkJRFjBY6baE7PjBI4jHw8Xwssy9YH5Em3sfw3pR4AmSNi2YK1mbJWoosGtuNGLOvHD9V3U13zFLRAxvuL+PHsnmv6l0oNo5X5y8EX07LfMFvJbxH3TCi2LxoCwOs0sBvGPAoFwmDBustELxFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766750978; c=relaxed/simple;
	bh=P+0Qx3sZetbkSWiOm2AFC37FSFNQ4o+XGqGdVw99zqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XesZx/Uue1hBMNiAfKbpoIy9e8ueN7j+8jJcSol8zwDp2vJDWnskrpp5apSjP9UPS80HxyQOCjq1YAiqSCkTUmu3A9QalM44nd85h4wx1xmwRm5yIfWfE4PlOdy/dlaZPOncKnotKw3UqK172ODmZhX9pkd18ybhY/BeR2PxutQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgXTLw/G; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5942bac322dso8000129e87.0
        for <linux-integrity@vger.kernel.org>; Fri, 26 Dec 2025 04:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766750975; x=1767355775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6V2FKk+nq/UWbVzWV/SlXvxgESiQ13Hs+bkW8OxV61k=;
        b=JgXTLw/GIgJVX9S3HI2fMuGQ3t+B+aeniUCmz0B12f4f3cTLeRaeyzoQbwIXhKNk5f
         bir5XXwVarjSQmEMlrCCQ/2qMaqkGcR4KLnu/6jP6BhvDTgD5r2THPHE1LxvpbyOnvPj
         Y9s5S3e5l9TsH4HsC2PSHsX7gfbOvo6faV6Emsv3J3NdMAIoOC4dc+prkS30mu7AeSjf
         f0cozoeN0f/ogl2n/9teTcqE7GNVelGwDhxHnQOMuhDft62atD0+545vS3b2MlXabL+A
         fO8DarkE4FsC7byvuSW7mUb7eNOPf9BaCv1HW152AmYdqryhh0RXFigm3VZBkCr1i+6m
         sQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766750975; x=1767355775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6V2FKk+nq/UWbVzWV/SlXvxgESiQ13Hs+bkW8OxV61k=;
        b=RiGdJFPo6vT7FMvs/28n2jjNoYgo+fmipfX5Mn+Cj3KFolZn0VHyEmXYitlW/Ma52s
         SFQBc+Y36DqRFCDiZDPt2HG1ijljDYUoPICD8BwLXIzGfF+hfTht9Ha6qbamoq31jw7Y
         YP75SqAbiT7C2aEKqbcHK19fLXtWe9B3SftRy4ieHX/+LgTBMbrBOxeoJ9xTJLIMk8zp
         Ua4vIUjzKAlRZfyV4vCLPorrLJLN1XdsJ9VmKmc6pjG0N+xDAyrGjIBMGRdtgZ59oTqO
         sLA/qv9wtibcJaKzNqltJzaSBuoEo8B3xpww0yidKS6R+3cPCi+XanUNJtMPvHZNrXdR
         yGtg==
X-Forwarded-Encrypted: i=1; AJvYcCWUX6/G5JAzSVihFu0mqYlERrWSCfmVwVlaIIJekvmMNraiO7rNYM8Z9j3MStfULM4lsGmYdcTNdxsJHxCtcL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrpR0XY2W3HsNuSsAI56+Iw3FHSp+RDqQSEy1Z/k/z6q4PEs/C
	WknSC1wq6treSTVOzw4C1Um23Wg622P1t76RHPpeSuv3DV2JLQwJyzQm
X-Gm-Gg: AY/fxX4XqhyOGYAc/yWK0BHoCrozw67kOORLozm6qfJbXy4Cg8QwzjBZPPG/Og9NJBA
	3+l0uqMz00OF+mkx+zUbGBRHGIDVrJucIesjtHOVJ6tuEjk3hoekKYZqz2WHTxt0kNnwAZgmA3h
	jmME8mUHuCjWO30Y604DwLVxEcFbYP23drZQ5V+ewY1jVvjKdh+rHSB1JXkKNICTTKeR0IDK5qc
	x2AaPeH+I2yJtylQWWMek/oWNdJ//EIo36KmlveF98RUsa/a5aeMh2nLEKN3H/0DgQrBxG17vfG
	UwhGu6/iVrdaxTc8vFD+VP3xJTz22R+R8/Z5/6BxIY6FJHVFtQHrvE5PBjxKCnzfLBLdoRQbEZN
	jwjEFMLG4apW0c1Xgyynabh3+GJSf3u5smm9T4kvzGHbXiXi1fnIij+9frHN0AyMPYyMYn++PK6
	2b1PUj71c7xHZs0JeNWBhHi0CF/dw=
X-Google-Smtp-Source: AGHT+IFfEKBr6eBl7ykv4GEdX7LpO80HMpB4K8mx96ZtUwr8pKVo/di8GIolUfkR36Y/Dp8fDlINjg==
X-Received: by 2002:a05:6512:3f10:b0:594:2e7e:7897 with SMTP id 2adb3069b0e04-59a17d3b3demr7599475e87.29.1766750974420;
        Fri, 26 Dec 2025 04:09:34 -0800 (PST)
Received: from localhost.localdomain ([176.33.65.121])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18618abbsm6832456e87.50.2025.12.26.04.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 04:09:34 -0800 (PST)
From: Alper Ak <alperyasinak1@gmail.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: Alper Ak <alperyasinak1@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Christophe Ricard <christophe.ricard@gmail.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: st33zp24: Fix missing cleanup on get_burstcount() error
Date: Fri, 26 Dec 2025 15:09:27 +0300
Message-ID: <20251226120929.61630-1-alperyasinak1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_burstcount() can return -EBUSY on timeout. When this happens,
st33zp24_send() returns directly without releasing the locality
acquired earlier.

Use goto out_err to ensure proper cleanup when get_burstcount() fails.

Fixes: bf38b8710892 ("tpm/tpm_i2c_stm_st33: Split tpm_i2c_tpm_st33 in 2 layers (core + phy)")
Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
---
 drivers/char/tpm/st33zp24/st33zp24.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index 2ed7815e4899..e2b7451ea7cc 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -328,8 +328,10 @@ static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
 
 	for (i = 0; i < len - 1;) {
 		burstcnt = get_burstcount(chip);
-		if (burstcnt < 0)
-			return burstcnt;
+		if (burstcnt < 0) {
+			ret = burstcnt;
+			goto out_err;
+		}
 		size = min_t(int, len - i - 1, burstcnt);
 		ret = tpm_dev->ops->send(tpm_dev->phy_id, TPM_DATA_FIFO,
 					 buf + i, size);
-- 
2.43.0


