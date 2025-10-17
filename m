Return-Path: <linux-integrity+bounces-7445-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3631EBEB28E
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 20:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A031AE23A6
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 18:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A9732E159;
	Fri, 17 Oct 2025 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dl4OBVZl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BE132ABF3
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760724707; cv=none; b=snDGSWFsIIlS7ILsscd7DJUVeFJDecWoMbG1nQW4OGN/yx7MlQHpkiTPjG2Su7KhcXC0vIrRrPb5tr0YFjpzPh8QzsEetQW5rmciNJxaMinyorjmF7BxW17KqB2VFQ/QtBah3bX9vEt6yuifOhts88dlt4NVP9zvdPm3dVN5MyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760724707; c=relaxed/simple;
	bh=r3dihmDf7EmTwHyOQk7Zkgw4snf1eF5k1wp6/pUMG+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=coR4bUGyQm7QqFa/Thmy6rxand8Ib+EYZNGQIYWUfu6IwNAI7KIDJH5d/mZSrVyhQyQgPU/nTG4fq85/WMeYg6D6rbcxp8AtiYeRJhE/DgsAgj3vscb/VPbdcFLQpI779rYtZD9scLEHTaCVrFHaM2kZsyYij7GXtO3tNkr+3hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dl4OBVZl; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f67ba775aso3101363b3a.3
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760724704; x=1761329504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VFIEDJTAopNEIqPSdh3Jplcei1xeOHRhpzrjHf2iOMc=;
        b=dl4OBVZlGLH3QZINSVf9RfP3FLWtOp1hDEcpU56LB/ck2q7dy7iBk85r9prlZs01mb
         la8iwuKAsdssVw6rtHthQhzwF7EJCDa1Q9XEH8jnWt8DM3bRIz8QztQZuuFM5sRWW0yZ
         iTUnjGWqvle8X7tUtXd7uZEGIKnIC2u8uV5KvdOcI6HasgF4rYo3E1Hp244fHcpxGeBV
         k03ssilvPliiIgA6beHebkKRwRUDuFOcmVMfyoBNPj7Wmm6V0E7NIvs9BJolOQjj8cKC
         2/QbVuopRzIeIH+xsiAmoSl0sOShQZZfn8vo0hsuC/oG7WDjE6No/pmRsYQ0Ddyppt1J
         5ctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760724704; x=1761329504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFIEDJTAopNEIqPSdh3Jplcei1xeOHRhpzrjHf2iOMc=;
        b=Q9+Tz2GlLIlQbSjsEx70yJaxxq3SNBmG+J0wGqqmSaRt+M6lQ5P4OCnnQF1purqSEB
         ICBrIrpKZ6CjUVLw1j1JtxtpwMr6HWPjfrRPlScxw+1wAKL1rzni/fuef0pyRhVf+juT
         Q1+Dp9ND4m69EnWxy4VxOBRTg6PVhyTQKhx2wJqtQ1xVYZ7I00I3z4cFBOvw/AjOh7bs
         M5eIzXY5gS56pmY1ROL4+Az4j7Nirs0ryiyvjcElLIkkIhUUQz5qam6GCzJz5W39vS8E
         oXvzHte9/pSrlcI1tDSW7TjUIjwoHrDAPYK06cyAEnzAJGYGVXWvYV33Nrcc874v9UmO
         e3Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXhgQbEb170hqeLV5bc3pTwaJE6qdq7ovbmYbCh49A71/K3dd6iG62Czb6NUhzV1p2FrZ9nJgkGgNBLp6x73DY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKZ3IN0vh3sfUgrZKH+pmXwpNgouIfdnSy6HuY8YGHqhofr+2S
	8lZL1PzTW33HpjCCqNF78C3D8an80RQIEz8e/8TurjBB8sYrRmhDtjgQ
X-Gm-Gg: ASbGncuBKfQqHTLA2rPvymc2aAUseDoM/pR/u0h46wKFB2/j46H0j4en5KkXaZDCgmG
	1T3RnZGWXvJq2uOa/rLgApWJvXkoaUla36i3tNTJJej9kJxCCOFmdaI9pyrXx3hS7CAHxY8sD1b
	mld5qoY6ZZCLIBW3puFh/V1RzBtSygsWaF79xFIopxD53p3ZqRa1b6qTrxrwe5b/nnQPOP2yFrr
	GoaUD4ajvffGt1wh9fUEd/vllsfFeXyFeFo3TCj1p0rhIwb2+4Ip/AHhKhdQs13DipWwkY0ck09
	j2LBJ0U9+gEaB3cyLqaL/h9h0Ak6tiCF5Ayo2wMkG1HdcYxvsZ4qeH5Z99enyEvIPQ1QRrowwbD
	7HYw9TLV1bKfzLHV7DkG5F4DTKnVnEFZNTvvtVVZNe0dXWDsuc/qJ9gX1G5o++1zBIimra1RY4k
	04gPo7QcRVvlMW/FXBW4Y=
X-Google-Smtp-Source: AGHT+IE1h8o5AFVacUuJYOfSDEzDV+0FD/VCXQsxR8OMX32EA6L/ZDfNJDJ4BWWf59gxnTA0758alA==
X-Received: by 2002:a05:6a00:182a:b0:781:556:f41 with SMTP id d2e1a72fcca58-7a220b07183mr5214886b3a.19.1760724704302;
        Fri, 17 Oct 2025 11:11:44 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f24desm200093b3a.48.2025.10.17.11.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 11:11:43 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: zohar@linux.ibm.com,
	James.Bottomley@HansenPartnership.com,
	jarkko@kernel.org,
	corbet@lwn.net
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	khalid@kernel.org
Subject: [PATCH] docs: trusted-encrypted: fix htmldocs build error
Date: Fri, 17 Oct 2025 23:41:15 +0530
Message-ID: <20251017181135.354411-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running "make htmldocs" generates the following build error and
warning in trusted-encrypted.rst:

Documentation/security/keys/trusted-encrypted.rst:18: ERROR: Unexpected indentation.
Documentation/security/keys/trusted-encrypted.rst:19: WARNING: Block quote ends without a blank line; unexpected unindent.

Add a blank line before bullet list and fix the indentation of text to
fix the build error and resolve the warning.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---

Tested by running "make htmldocs" before and after the change,
ensuring that output renders correctly in browsers.

 Documentation/security/keys/trusted-encrypted.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 2bcaaa7d119b..eae6a36b1c9a 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -14,10 +14,11 @@ Trusted Keys as Protected key
 =============================
 It is the secure way of keeping the keys in the kernel key-ring as Trusted-Key,
 such that:
+
 - Key-blob, an encrypted key-data, created to be stored, loaded and seen by
-            userspace.
+  userspace.
 - Key-data, the plain-key text in the system memory, to be used by
-            kernel space only.
+  kernel space only.
 
 Though key-data is not accessible to the user-space in plain-text, but it is in
 plain-text in system memory, when used in kernel space. Even though kernel-space
-- 
2.43.0


