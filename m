Return-Path: <linux-integrity+bounces-7480-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A90BEBBEE
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 22:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CC2588153
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 20:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DD327CB35;
	Fri, 17 Oct 2025 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Va/+6G0Z"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1139027B4FB
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734154; cv=none; b=oNWT4vEe93vpBqkXdHEwI5sWRLjGLw35/iuQAl6JexVzKGbLhqTxtJ1/H/r576nasAA/nE8YqKRX8mSbGjj93sOCOc1wDK0ttYNZXxGqeL0fH6dGd2POI6l0JAwHnMq/PmJr1Guj64Vr3yZ61m45NUpZMCM8Ia7FBJt7eQnMdqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734154; c=relaxed/simple;
	bh=WKicIXmz7bnIQGhAXSwDfAouRuhWgFryW5dnjoIl1Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIf8TIN9mD55uzRZFnd2XcLUdEC+OkBJt/1cus0noJzprTvVvIKzucrltBFWuXLjohI9qqGNCmbosOdJUAIBfzKndFDxghTWVffTOd6BI6shC88z6FMcu39C3ufJjEifsq9LVt4StPTc1vpFTNBvcjfo0xWr5IpJkANmU2huHQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Va/+6G0Z; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-88e1a22125bso324991985a.2
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 13:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760734152; x=1761338952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKtz/vkc290/v3y7dFkvXfjVdcrtyl+E7FWTxNg0D5A=;
        b=Va/+6G0Zj56SaC38gysg7S+eb+skTwu7auy03obW0Z5qPB2XTruqVQb+D1UW4i4ovH
         Cule3L7QynhW2TudzCK3Fj5PO4yGwO7MhZO6YSLD6QlvUkHrOimxEdfhrj1YKviMGwOa
         GFONhMgAhfd9LWoBDPaWoLFXi/VhUZ0pt2x9sitPfDLA0MrpuPetstL4YYG+DTk3+5kV
         qYV9sNQLQZlmrofmNvZcS3eFwTBAIaaYw+LSaD//UX3PYg8Dlxss2ie6tSDETuaMDemK
         qHdnlKP52Pd8Lrao63e2MSkB3omxjGyoWW2PdJgcmmgX6PJItVZEsO9CTWZSGCnSMqRy
         z74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734152; x=1761338952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKtz/vkc290/v3y7dFkvXfjVdcrtyl+E7FWTxNg0D5A=;
        b=RGAu6+FzOlv9VeKclrLGkH5vbY4Stb2f9eo4d7ZZwOrrBpdj5j9zV1ANfRFFsj+iUr
         O+8ccrrVKee7ZIfJjbpT6wnijL5UFydph917rZro0fYQjeEgRCgbShBz/d50D1vqElj/
         MWXBPxPOERTn6MAyu246Xq6hOHdTc6P80QJ0Ja/sGG21PXqux6ZWAB2Pbf8eAEWNt4XK
         dokihey763XWzLc/01MCI7urtYF31SI/Pe+E/dXSYsX5Skgc2C6USx+EBjdSFO7sHtFm
         H2gJk5BiywVplIB/WQ+qn/8VJi9mToTF+1ElUuvFNOeLl9lhF9gDJE0+23KcxG21LY3F
         vQ8w==
X-Forwarded-Encrypted: i=1; AJvYcCWE1bgyrKuCUUUdVrHpBKo4id78qOEaaPoH9pxYFhTupAgCC5Ge1kibZ1diXuIAPFUsUwEuGOOY0FhWGLYXuOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPi/VH6FOBIbgp6kH+zv+s2JATfDCSsGst6/OFP6987UkBTP8q
	cswZlzLJutxvIleY6uYj3qPtFvG+HMlIk2AptR857W9fc0s8l+uIm1QkUiUD2Oei+w==
X-Gm-Gg: ASbGncs6sfZCxaU88qPQTJ5LX2kSIIRDGDK84RX8n0o5DmxTAix4zYxVqw2zZ4VtoXM
	VJE4lWwnqSGDg4T+5wR63Uq6sGEx/U5Fc3JzpyGVBLujzbFs6YNXPlyY0FccPrz+9NX3Z2/NM65
	NExrsvJ/rYTDZZ+1nSVTTyAbybdDxku+ACYlTlc9CW98ltCRIWX9Su2LCp/in7IVy+FDa6o5Sii
	q1RtRuzl9KGbZH2Eozb70Rd7n215jaDsRQZL3L9CxaWyaRjOb6JbQkdKpgI4GvenlwTY2zZLLZo
	ZyE4c+lM26a+rl+MxtQT7f7WfHmv+7OxOSq6Yr2Z57WZiaaXmo7GQ4RWVhqWw5aUt5M70O6Sgk4
	ieqsGGfPoWBZsoHb3c2MQbSkKy0XGcIfcSQgCajUunvEuH4zjVurSAzZUsGrytyiD2Vp2TstcHT
	0CND36DZcGmVraKkSwGEj17is93C7jg364bmI8R10cqFcbaMzstPvnYe7U
X-Google-Smtp-Source: AGHT+IHGZu78yRyhIKfalS/+sm4s6XszeQNLh4vmUvi7QqFzyQmuCMuSpemEdlt2MRk8WCsOPnaUQQ==
X-Received: by 2002:ac8:5707:0:b0:4dd:ca89:8d7d with SMTP id d75a77b69052e-4e89d3a27dcmr76029711cf.56.1760734152046;
        Fri, 17 Oct 2025 13:49:12 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028a9987sm5018766d6.44.2025.10.17.13.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:49:10 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: john.johansen@canonical.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	wufan@kernel.org,
	mic@digikod.net,
	gnoack@google.com,
	kees@kernel.org,
	mortonm@chromium.org,
	casey@schaufler-ca.com,
	penguin-kernel@I-love.SAKURA.ne.jp,
	nicolas.bouchinet@oss.cyber.gouv.fr,
	xiujianfeng@huawei.com
Subject: [PATCH v5 11/11] lsm: add a LSM_STARTED_ALL notification event
Date: Fri, 17 Oct 2025 16:48:25 -0400
Message-ID: <20251017204815.505363-22-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017204815.505363-12-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
 <20251017204815.505363-12-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136; i=paul@paul-moore.com; h=from:subject; bh=WKicIXmz7bnIQGhAXSwDfAouRuhWgFryW5dnjoIl1Z4=; b=kA0DAAoB6iDy2pc3iXMByyZiAGjyq6+ghB3O3BYguG+6jVCkggcsRoWS+8eeqUiOeWQsm4zWI IkCMwQAAQoAHRYhBEtCqM8H8pnVVJd+7+og8tqXN4lzBQJo8quvAAoJEOog8tqXN4lz4uIQAMhf t1D9gT3dBoizePCN9guhDI5Dz5nrvexVFzSF+5Ry9flh2HBkmO1QUy8OXtndsXa/76/yKY9UPF7 q632ClOg56jdniSVdfcVfwoFO4lizUTBLkIOfuf/LZy5f4dZHDrRHMUC1h4DmqTQWvSnwWyYYhx NJOaTYTcPxObVnE+3dVNvmOiD1baRVgZNiBs5iV46+mwZqUoHqDAynp6JuI53jgQCJdJkr7m37b 3YxgMPmqVbxLWDDwuQP9HrRT8ZKHpUWvxVU12NjBOnkOVcdGQG269vB6dIF8sEEuGLYM8+YIngp NbltnD3w3eQLTnaWa7m2DUlrNdUIvOKg3iKCcvxigKEKshMTyGBRZ+kFy9g7HCWm4JcRxO42Ywm 8yOBvHex8RMVG1xJRFCjM06PzEm1vL5YAcEua9YDlGydnIn2c52Yje7IWIfSSnW6DKx2wLILP/C sSl4ZIMfiLrfoVUO1UEyTD5AvkBSU75xB4OFDZrE6/EV1ZoMENUCzBT0Om68W7bN+Nmmk+EmoDK 6KWfyQX3Lw2ZWdARXMDydi/CdjDVlVO6ILKzQNFH90NgIKo1evEIlOXwLU1HKYjD1MweSH+/NBV 7tQTirmn8wPbfUniGN3mlB7+7kIZoWWGiRVfYmutFXI/FC24cfGwUAvY8ERLT3quHblGSlssfnN QWPH7
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Add a new LSM notifier event, LSM_STARTED_ALL, which is fired once at
boot when all of the LSMs have been started.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h | 1 +
 security/lsm_init.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 556890ea2e83..eb36451ce41f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -85,6 +85,7 @@ struct timezone;
 
 enum lsm_event {
 	LSM_POLICY_CHANGE,
+	LSM_STARTED_ALL,
 };
 
 struct dm_verity_digest {
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 0f668bca98f9..6bb67d41ce52 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -556,6 +556,7 @@ static int __init security_initcall_late(void)
 
 	rc = lsm_initcall(late);
 	lsm_pr_dbg("all enabled LSMs fully activated\n");
+	call_blocking_lsm_notifier(LSM_STARTED_ALL, NULL);
 
 	return rc;
 }
-- 
2.51.1.dirty


