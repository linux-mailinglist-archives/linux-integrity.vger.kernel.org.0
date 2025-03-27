Return-Path: <linux-integrity+bounces-5485-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E161AA7365C
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 17:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F88A1888CCB
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 16:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D816B1A238D;
	Thu, 27 Mar 2025 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="T1QWWaMg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F1618BB8E
	for <linux-integrity@vger.kernel.org>; Thu, 27 Mar 2025 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743091769; cv=none; b=qSbtezxIAXOuBGEP2hv8nx3KWSSsfzeeKcUiZK0eb0u0Wjdp/AfKa3O2CoL8bHN+vNdRvJ/HHhygy4xFDVmn5sAY9ZmgpF6s7yZFmpLgTK+NXIIIBcKI7FYtCAJRe25QGPL/HabYUXAv0Z7EGOtwDSxS15pd/EM0PXGJyCnb0ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743091769; c=relaxed/simple;
	bh=Iv1t8vhll1NnfJAVcvohsPup3KoMa8DNYAHImENq+hY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UAjwqB4129z0vaE8cJbr+H3EzzNiPG6hgOvBgceTHYyDdaPQGDMS4d5EzTMSL/V2fn18QaX2wox1JF2OYKEepP/TC0DdoSMJXM6wFBBCIfUaM6DXqGS7sowZ/NvYYBRFCTwfsShpJ3afHNCu/0InQvEhKtI5kyYKF5q/fU4ioBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=T1QWWaMg; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85e1b1f08a5so33102539f.2
        for <linux-integrity@vger.kernel.org>; Thu, 27 Mar 2025 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1743091767; x=1743696567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lc9tpoqy6nWDYPuOoCnxwnYnaP2wtDpP4dKKDjWcgOM=;
        b=T1QWWaMg861Yv9Jw3i3+lACFSA3Qz3b5nG8s0Ze5Fmc5zuzynrs/1ZIMVErAfvuE8R
         Y6ShHmLkiSJ8VitH1BSIWLgNI/f7ZBqTrjHC78/owDZ9iTAsWlh/3CMNKkDC77xdxR4S
         Ls11a8f3CuTCVJh2usKWn4hV2b62nuKKxhu6C6aMAOgYGe+vL5P+bHxn6FqX2O1eEvuN
         40I44yXX26RCHcjNmpY6S9TgxOYWLM2dOX+b3cLqdqrgCNQq3kiesf87YyvJo0O44a6/
         deXJz0G1W2l5Q0URaedxSgNyrT/tcVY4DmONC6aWvjaLgLCUDNaoXvHPanV8k+GgrEYv
         X3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743091767; x=1743696567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lc9tpoqy6nWDYPuOoCnxwnYnaP2wtDpP4dKKDjWcgOM=;
        b=V7Tgkv/vPsrS/eJsGbRQo0mFxpsaAbJB0rVtBQ9h6sFLywX/JmpCdZc3YHCkALq9MA
         O5SYZkxKO5oEVQsar3CbeHNr0WkGF924FibiXMesOBsk2gBZtWGYRUWE6WY3gho11yLy
         9SzAX2AFl/Ua6ImlQ8fOpOy4TWdcfdSh9x464CKbTNByn5pfzbMMJ1uObYGvsdbcBZks
         FtJzooTd2HoF0Wq4xz6YoQOJ9OzhriMNBiWBcKRkU2x/Wfcbd/wLtuumNuRDrS6kB9PM
         kTh6m1fV0viO1RBbpwGAja8crjKXCd93mWQDp/6hwt/Rn9sGZ4sxbZxsUApDGMj7XTPb
         6P2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVytk+O/q4ppcDyWtBnM8v+h/z8kfwGbLk/KShRvd9/sUmrOicd2RwU3vCAXe+g5NdTlFkK4mgrZUgAkLBwdGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3QvcDxfAOB74Tn8qIiivACqXMi/KapRgqnyy/kWDoERXc4j2A
	cOVo+exTvrfNzYdiZCDfO/8lKlkgQkfvuZZBwsaQGnWEUyiMKr6firS+IeaOgnA=
X-Gm-Gg: ASbGncviXwwD3c6JWgisS+mw6bgKZdWd7w2X9UGQ8fITr4N1LX681Qd2WWSCLDnw5tQ
	O3+1dETlyBMAhX9xZqNNa6lXcMVDRj4K3MjQoX2uteXd9zatD5matsoz/k3ez5JCGSRszD2zpUx
	WNrqkMZ8HAazjWeg4D1HZyaXdgPdgRW7xdB6py+UJtDTY33Pt7zRjpouugdXVIKWwwlhiT/BRS4
	vfL5obL4LiyQzsBE5ITsL9Dkm/HCV1ZeCMN3urDT8PUCIbFslf6SR4OlyURKklgTJrsdB7d5Bo/
	6PWA8qt12wywsVHN9OBH0TLwF0+hmXUxSFzLz44=
X-Google-Smtp-Source: AGHT+IFIyIjqN7KRfbbaU5gWpkJAPN98hiWDLVUjmx28XhdIkaVpn/ZdT5fnt+0q+a+MgIWRytnq6A==
X-Received: by 2002:a05:6602:3798:b0:85d:f74b:f8a8 with SMTP id ca18e2360f4ac-85e820551afmr551444139f.2.1743091766522;
        Thu, 27 Mar 2025 09:09:26 -0700 (PDT)
Received: from CMGLRV3.. ([2a09:bac5:8152:1b37::2b6:1])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85e8ff7f50asm1804639f.9.2025.03.27.09.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 09:09:25 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-ima-devel@lists.sourceforge.net,
	linux-integrity@vger.kernel.org,
	linux-ima-user@lists.sourceforge.net,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudfalre.com,
	Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v3] ima: process_measurement() needlessly takes inode_lock() on MAY_READ
Date: Thu, 27 Mar 2025 11:09:11 -0500
Message-ID: <20250327160916.279090-1-fred@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On IMA policy update, if a measure rule exists in the policy,
IMA_MEASURE is set for ima_policy_flags which makes the violation_check
variable always true. Coupled with a no-action on MAY_READ for a
FILE_CHECK call, we're always taking the inode_lock().

This becomes a performance problem for extremely heavy read-only workloads.
Therefore, prevent this only in the case there's no action to be taken.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
Changes since v2:
- s/mask & MAY_WRITE/file->f_mode & FMODE_WRITE/

Changes since v1:
- Add MAY_WRITE && action check to violation_check to avoid MAY_READ
  only situations
---
 security/integrity/ima/ima_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9b87556b03a7..bc453f5a7531 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -237,7 +237,9 @@ static int process_measurement(struct file *file, const struct cred *cred,
 				&allowed_algos);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
 			    func == MMAP_CHECK_REQPROT) &&
-			   (ima_policy_flag & IMA_MEASURE));
+			   (ima_policy_flag & IMA_MEASURE) &&
+			   ((action & IMA_MEASURE) ||
+			    (file->f_mode & FMODE_WRITE)));
 	if (!action && !violation_check)
 		return 0;
 
-- 
2.43.0


