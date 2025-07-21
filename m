Return-Path: <linux-integrity+bounces-6659-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A559B0CA9F
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jul 2025 20:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A3F3A2566
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jul 2025 18:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A20289825;
	Mon, 21 Jul 2025 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcJDcvKt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF04A2874E5;
	Mon, 21 Jul 2025 18:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753122983; cv=none; b=SBcmKArjcy5izGZUDGy/GY7FEW+GXH2sqI6yIWLHgAFB4EUvzgOeNh6vEkiIFeWWGZHwMAtQRo/pzWEmpdDp8fJxOft1ewm6np2wUlVj/Ea4JnI3MADAKdT9TAmzWA3XLtY/FR6gopncij1GNdMa2SHmjuRQ10t8YchDrAM/LD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753122983; c=relaxed/simple;
	bh=ycTC4xuTP+WaCYXRa8ljBlPHPxs3ERnbBaTjk1n1zp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xu++w1RzIqTeCH9CnEW2VEvZAc92rDvWGZMmlfgnFbi1y+6DEg0fhV2y42qGJWhBwukUPxfJjqzti5CD4kp3PdAkvXWb29/j+usqqrsTMUYOpEWZLYHEQmx5A+lKtn2nSIEXdmbkKiP5lAeecRDJaT7INXmCFZQgWZHpks0XFbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcJDcvKt; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74b52bf417cso3064955b3a.0;
        Mon, 21 Jul 2025 11:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753122981; x=1753727781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v/2UfY2eFJOXMg2iswE/ydWS6gI2JFX4kskloIzskMs=;
        b=FcJDcvKtuqhtb1LeyRCUbuvClpk/DONoJlAhU2ZXLh+taOTUhNK4pLjoJgEiGGYHCA
         gcB9jXwIBLmC11BuQw3oNoEgDBQnaZsF1AeAvvhzkCVtM9wb8I60uynmoCMevqpnGM9G
         u7TI4mnxUc17VCeMDKDJj1Sd/4RKVsCOaqNuQP6Pexf43uPTImYlTtgtMnsy6wEhmpv+
         djoeCLvQ8iGHsTtoAxUIH3HGl7zcvwt7mqbzTEOWoM2g9gexN2iHPsDH7xLS6A3ww3DI
         RIgRoOUyt5CKQc717Voukhzxuk6RU2GS0rtuQTlfbNepleV9RcbkjKkRQA2WxUVVIwxy
         L+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753122981; x=1753727781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/2UfY2eFJOXMg2iswE/ydWS6gI2JFX4kskloIzskMs=;
        b=wTAkHq6E2f+T59RxariRIIPfl8qmy5JcRUQwZG9+DjMAdxT4PIfb9REi7+vUAyMPsh
         ZTdlbIBk0+xUHt49nXpeEtfnJuYf8xG190dnYgAxOZEFBdNBPBV88BjhPCrykC06tUnl
         /5tp2sAVguXd1/IYdf2R2qtwWQDvGRqcl48OGoyatEL8xcFoWrkt9uZUtC8jaPFf5yYs
         ThHiFehrXLKruEAdpxlzA5cyfJwBG1ZLxIwxTDAXhPvNfStaTZNKmwjQGRfcZa/uHRmi
         p5IrKrQ2ZnHQGI0qB6o1hmpRCX+EqnLdbK3mfZLUvclR8tDrFrOeJg66NjX4zfk2AQVe
         ev7g==
X-Forwarded-Encrypted: i=1; AJvYcCUxfKKJMDa7XfkBep1Fdh/qxM/Lv3iVZ1wudYoD/du2yTF+8bOdlsmiQC+9Z9jYqcfNzh5HNuBkug2efgUj@vger.kernel.org, AJvYcCXz3vPwbuqC27d10p1IMTMq4Kh5DsO8niiBwmLl9tObczuF9p0Vn0tKTGhfAHF9BJlorYr3tV9KvBtjyKz7HKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs9tMUsezQbo8wBpac3u8ZBqIAib4I1fR6OE5wh2iW/1KtByEH
	61MTWgg6CywWmBxmAf0OpJC/Ai+dujbYV4KIOwplhhD522d8iYHw+NRkSGrTSpVDF4Ouzw==
X-Gm-Gg: ASbGncvIVUsN9ssZPvOLeFYE+95LtPUfhkvF+0UHBGwRd1F+wSR1V+oqCQ8Zp0ZnFX6
	zohcOiZqGmjZNfs+a4gl/wl9fjD6RxqAZd7DVF0/VeWX1dxDQXm+qbyt5ECmiK6UhKNZAk9WU2J
	TQAJHdZsOFqfbFn0rHA3s0+G39+/gz+Bs9XJJEY5VNXLsTxzrKbeJKAG0qwscrhsa18YnhN85KS
	oCyZQJ7TYZi/+4CRx+CaFF5Ge2kkiuCLFRT46eOSJNEeY5s+IAWoGhAbevB6WIfjUHQCWs3e2U+
	EAxQANP8MXEYD4t/caofEEjL3imESmHVz6/QoX+r1PGfldyoMvOLuuMJUbHx9usaQF73LgYTPfy
	+gL1jKJin9IIPklymqKb5d6fg6ka1vGBKodnECzrDtFTl
X-Google-Smtp-Source: AGHT+IEIdhuEVpt+w0ZuMxR1N+y9ghj+KB5dyBAaH5deGHns7RoXPEDNgL+P9lfYFIntOf0qRQVuqg==
X-Received: by 2002:a05:6a20:3c8d:b0:222:1802:2ddb with SMTP id adf61e73a8af0-23810667018mr32063924637.8.1753122980922;
        Mon, 21 Jul 2025 11:36:20 -0700 (PDT)
Received: from fedora ([106.77.141.186])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2ff62972sm4797162a12.40.2025.07.21.11.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 11:36:20 -0700 (PDT)
From: Praveen Rajendran <praveenrajendran2009@gmail.com>
To: jarkko@kernel.org
Cc: peterhuewe@gmx.de,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Praveen Rajendran <praveenrajendran2009@gmail.com>
Subject: [PATCH] tpm: crb: Fix typo in function name __tpm_crb_ffa_send_receive
Date: Tue, 22 Jul 2025 00:03:57 +0530
Message-ID: <20250721183357.25039-1-praveenrajendran2009@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes a minor spelling error in the internal helper function
__tpm_crb_ffa_send_recieve, which has been renamed to
__tpm_crb_ffa_send_receive for correctness.

All call sites have been updated accordingly.

Signed-off-by: Praveen Rajendran <praveenrajendran2009@gmail.com>
---
 drivers/char/tpm/tpm_crb_ffa.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 4ead61f01..089d1e54b 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -178,7 +178,7 @@ int tpm_crb_ffa_init(void)
 }
 EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
 
-static int __tpm_crb_ffa_send_recieve(unsigned long func_id,
+static int __tpm_crb_ffa_send_receive(unsigned long func_id,
 				      unsigned long a0,
 				      unsigned long a1,
 				      unsigned long a2)
@@ -251,7 +251,7 @@ int tpm_crb_ffa_get_interface_version(u16 *major, u16 *minor)
 
 	guard(mutex)(&tpm_crb_ffa->msg_data_lock);
 
-	rc = __tpm_crb_ffa_send_recieve(CRB_FFA_GET_INTERFACE_VERSION, 0x00, 0x00, 0x00);
+	rc = __tpm_crb_ffa_send_receive(CRB_FFA_GET_INTERFACE_VERSION, 0x00, 0x00, 0x00);
 	if (!rc) {
 		if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
 			*major = CRB_FFA_MAJOR_VERSION(tpm_crb_ffa->direct_msg_data2.data[1]);
@@ -289,7 +289,7 @@ int tpm_crb_ffa_start(int request_type, int locality)
 
 	guard(mutex)(&tpm_crb_ffa->msg_data_lock);
 
-	return __tpm_crb_ffa_send_recieve(CRB_FFA_START, request_type, locality, 0x00);
+	return __tpm_crb_ffa_send_receive(CRB_FFA_START, request_type, locality, 0x00);
 }
 EXPORT_SYMBOL_GPL(tpm_crb_ffa_start);
 
-- 
2.50.1


