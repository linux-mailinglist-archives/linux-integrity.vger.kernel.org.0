Return-Path: <linux-integrity+bounces-5422-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6B6A708E8
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Mar 2025 19:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264293A5A7F
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Mar 2025 18:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAD5190477;
	Tue, 25 Mar 2025 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Wt/ssl4h"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCDB2AD2D
	for <linux-integrity@vger.kernel.org>; Tue, 25 Mar 2025 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742926601; cv=none; b=dRpcvLAPseee1Y7ySm+SfY/iGjbQo/4zAVqJEOEPe6VquFFQ+nMzgVfGLK12u/0DW9M8uercnDHRaKlsJXEe+mMNPDiJRggTGv/M7Z1s9nJ+I63ObM6zR7+ATqx0Edc6wbY+OPHNyy4CWjN+w8YqClrqozEND/AVtErOt7o3EXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742926601; c=relaxed/simple;
	bh=esYfgx0cdDMN5ZaBBHor/lPAhpyh+4gBj/W9cpIjRxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KfrhA7w4V6yPCy6xD1FVZlenwyvFjPpR5DIy0706OQt05/p5bvUZB70r84HN7z97cwiXg+RNG/W4vfVNOSRzL+dEmlBQ63RTT77y88zha5Y7O4vcRdrx0sRh6NhgXYqncvICGNJ+RCZQuFZS0QJGpiwLAMWUs++lA+kq5Peys7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Wt/ssl4h; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c58974ed57so596305285a.2
        for <linux-integrity@vger.kernel.org>; Tue, 25 Mar 2025 11:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1742926598; x=1743531398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4H7GcC3ni0ITvlHddoWo0ZRS35tRQvYIbusVzXzsR1U=;
        b=Wt/ssl4hTb+V8ObCcMJIuOfK3rTcdeW1j/Qd1vXWy4+8IntCmvJDM1QHpGigZbt6XJ
         a5rh0DnwGLttZkWfNstRG5Llcrgj/ltoAe0a6bKz05YcD/Pnc0dM96JRTGz0+jPmEN6z
         3GIzqhWOUZxz3SqCA0znDn1ttVgxdqcV59A2W6tF25r3e8GUOuaTvYQojJ0qUqfy6fXS
         dott1LdQtilrXsdahnnRzNKSNPPJrKsEa3W1AU8Ia+TcLMXCvYxvNQxXP5ZSbEWBxOwb
         kH1Ab6qgHUqIt2+iDSe7ogBaKQ6Sr0Hu8hKvYp5Wg6MzoY03STJj9TMO8vXs5GLQUA08
         b3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742926598; x=1743531398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4H7GcC3ni0ITvlHddoWo0ZRS35tRQvYIbusVzXzsR1U=;
        b=N2HvAhiky5nHJBV3526EahL/WuV49ZDZ82hYqWJGw2byzgr7uBB5NmKTCyvWTDCytA
         mVSIj2m7gkOU9wgo9l9JLyxSBivAQNaFaHLXhB5FXT9edWBZZn0c53NnE/10uxvWxTA1
         l3mRTb4OiaD+/qKy9oAbgNQcKaYyZMureUKkhBtnj9W1yYOzcu/A8n4Hw8RFsx1WiiEI
         LQkXNU5dbIGmgKL299rsGyrXD9jlN3+b9E41klf5JWrxZJhyyGPmCA1IY2meRQO5xtVO
         shweYA9d+YAwEUi7u+yDlZ1o47gpoabxVLscv1VmLgllrjHHu8yFvVNR2U7j/nvqwHj4
         0V4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkQmXmU9keIysDlKRi0VuX512opmfJ898vS2mNkRhAEhQ+mKkS0om1oQEIPaHP66INFq9AjK30vQLnQaPHGQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6WtJp/lhhNlCVco38qVPObDOxJWwRy5+zkgCE1JNtWA1zWVxj
	KgmR+5N8VKkyGGXnGj7WcHliMEilCAdM6G1el116VmWXjOcNUd3snU4wlyiwkTe3Iw/m3p8ATOP
	uXmM=
X-Gm-Gg: ASbGncsgeJy3sru+GrpAulPJtH+b7dd/Lec6osTvztRCsP8II3DQ6PVqKQXVQ6tQv8H
	F9KU8HwamgXFucBa0a/SO1FtXJgy97/DOEVBoFniqTgnrQem6y8aQe+RU/z/cmcWrU+JMnjwgZb
	WVdGcxx/IYkQty9OhDw/Sv85KNW67y9/cyrTTZcXK0QTbtncCaG/rQRnB2ohdsVhNCVZv0YazvU
	jBUUfHRe7AoFk8L2PubN+SmmNas9Hy5i2nACM5XLLC8OJkPBkEsbdo+4jnTFs3Xiolms8iH1QQZ
	7ZoBGOh/QKTzL9O2sj7B0LJOfZyC
X-Google-Smtp-Source: AGHT+IHKUmFTlJlS488fjeGCyxmy728lgg3HbhLTJYyWpR7aP0o43Y/7GdzMIdEqqfoalzFAPGEA/w==
X-Received: by 2002:a05:6602:7218:b0:85b:5564:2d51 with SMTP id ca18e2360f4ac-85e2cc52346mr1871960339f.11.1742926587923;
        Tue, 25 Mar 2025 11:16:27 -0700 (PDT)
Received: from CMGLRV3.. ([2a09:bac5:8152:1b37::2b6:1])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85e2bc273a1sm224670139f.18.2025.03.25.11.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:16:26 -0700 (PDT)
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
Subject: [PATCH] ima: process_measurement() needlessly takes inode_lock() on MAY_READ
Date: Tue, 25 Mar 2025 13:15:03 -0500
Message-ID: <20250325181616.79540-2-fred@cloudflare.com>
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
Changes since v1:
- Add MAY_WRITE && action check to violation_check to avoid MAY_READ
  only situations
---
 security/integrity/ima/ima_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9b87556b03a7..11a91d9dae48 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -237,7 +237,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 				&allowed_algos);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
 			    func == MMAP_CHECK_REQPROT) &&
-			   (ima_policy_flag & IMA_MEASURE));
+			   (ima_policy_flag & IMA_MEASURE) &&
+			   ((action & IMA_MEASURE) || (mask & MAY_WRITE)));
 	if (!action && !violation_check)
 		return 0;
 
-- 
2.43.0


