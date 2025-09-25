Return-Path: <linux-integrity+bounces-7278-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E92FBA1FD1
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Sep 2025 01:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262C6563C76
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Sep 2025 23:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A6F220694;
	Thu, 25 Sep 2025 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rIkBulRx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C655F54F81
	for <linux-integrity@vger.kernel.org>; Thu, 25 Sep 2025 23:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758843924; cv=none; b=RJ566YLEvinQu5UbAscy4tMcGE/VwqdyOSNygH4wfjj5u0YQSEw50MZ8gREK6hu0Hj17dNeiBO/UOooa9K4XAUIfj/SG8YMkTJDBfKf0X5PC/BOsuPN2NF2Z++qn0IYDrzghQXCe/Qe4Iewvpk6B87P4+DNMTCKzuaNZ1iKx3Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758843924; c=relaxed/simple;
	bh=I6Ydgfc2v7hNN8vU0Z4GiGF59ehBkmOfll0Wv6sZitY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F7+8stM7LI48g5sHCSWz4N77w53OoqY4BGsCLQFx5U7G9YHpRU8iyOwcn+NOk7hmkUj4OxXLg7rU+dQ+jUXSazCOuuq+ZlV8aQZw3+oyQcv+cBOP9jEQSb2gr84OZQwIuwzYgpafFZSy2o+U4FoRek4MJndFnJT4z70vmAjlV58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rIkBulRx; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e3bcf272aso20555e9.0
        for <linux-integrity@vger.kernel.org>; Thu, 25 Sep 2025 16:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758843921; x=1759448721; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dGC41HLAdfIjYQifpR0ZqqtXMnDJzzLlr+J9hH+QMsc=;
        b=rIkBulRx8kVw9J/s5ZsSJhOjG3AMvkLWiO1Pva2MuJ9KHUQ704YRZCG0dDO4w4hdLq
         hpbetgC8/WccL5ZMP4DSUys8pySx7dbrst4Tk6KfFzQ0hgDPKPb0HD4SoBie0geeKq/F
         30cUFe6Q+5/mGbvLodQrr47BOZ89EPhEQC3g8xya2I8WCGZp6PfuujpdLr1rrshtK1LE
         tsEfwgj5nUBIGPsFjc9w12zwMJcppRxYigQGI022ZlKCPTEOlVXTwgkybeo6PMa3xwqz
         wQadhqqlZ6SfNE+dOgXZmrp4ySM4h+mmDfcrY4Dg77FeaakfelXujKihRqwmkyV5zFR1
         YRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758843921; x=1759448721;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dGC41HLAdfIjYQifpR0ZqqtXMnDJzzLlr+J9hH+QMsc=;
        b=bR0PNaEv8VepY6rIkLSL3lL9wdI1ql8Nf2s+4rAhpkOON64MOE2f5RqwHxJsjxqmsl
         +SAF/I4nDjhR4zp3cnSr36DIQVTgCvwVPk4ZfIcbJUA4MGAzedus0c0aN9ZGZd119ynh
         i82kTxGUO0p1nhgZedCPml1ZvdMlWu0hoKZV3MQVCEmqe/ih50rlgnCdmkgvdSsbC46S
         7NA4eA097ZY6I+HqmeMTWW6EAQn1dMX2vG5Wp7atEK59/lstGqeOf2yUclFP06yGQAb6
         WhB9Q451MOWKF4Io0uqwsM2p9bwiNbAhrH7XbqFOpAJgtu2Gi6jkximsi4RmpIkMdmEJ
         etxg==
X-Forwarded-Encrypted: i=1; AJvYcCVo3TrGUXKp52xg5HOiIR8fk6eo3tCQHgd2UHmKb5ppfYsXlHyNGhx0gaohfPJmlPvn4o/1416uSJZpIYJ8wXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqrEdMe8N3hqHhG3lZmMOuXFbtxVtF/X1QDcnU1L4cHXUd9SVr
	l5dP2sg6IDOscNt87l6WRACVoo4At60cBOOvLQPxHnjSLVCuD7dDHf3P32SDEqNcag==
X-Gm-Gg: ASbGnct3oXK6sJF7Rhz0OK0aAIwcz9K11kt/F7neqif0Qlb6Yd+Gh+pKWy+/oH8cm1G
	vKYrYj0gp3ApdSQTN0ANeNsM83D5tjxmt1hHejHe64qsQ0PLUDRWn38mqDaKjd0EpH6xhZWEig8
	nL7GGR12UAlwsr7I9S/CxdPMQzRLuRaYEZZVDeXuL6L8qFL1t6kC/+CvijZWAIRJP/vzE/mUbFs
	HA6qHDGLd4kJT7u6radQJwJvNpK4ECuprnw80RdolXMANpU0Va01/CAu2+T1X6YRScWcblIY/bF
	o/1t6y1zwhEF+UrHLO5N8q4RRfSnBezkRuFMPKi5MSHzXWXPga9n783XInHSPx/rPv2HryUapKP
	pA1mKW2yTZG9Jj+xgbQ==
X-Google-Smtp-Source: AGHT+IFW+K/NGydmot5DfKK68l9tdnpwSIK5cgXaxZI8zhEwRTxPDW93Kj6jmV0U/7IUYCXMapMmtg==
X-Received: by 2002:a05:600c:1516:b0:45f:2949:7aa9 with SMTP id 5b1f17b1804b1-46e3b009caemr429065e9.6.1758843920952;
        Thu, 25 Sep 2025 16:45:20 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:802b:ac1b:7bf0:4c9a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e2ab31bdesm92177255e9.11.2025.09.25.16.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 16:45:20 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH 0/2] ima: add dont_audit and fs_subtype to policy language
Date: Fri, 26 Sep 2025 01:45:05 +0200
Message-Id: <20250926-ima-audit-v1-0-64d75fdc8fdc@google.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAHU1WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyNT3czcRN3E0pTMEl2LpBQjQ8uU5GSzNDMloPqCotS0zAqwWdGxtbU
 ArMIBRFsAAAA=
X-Change-ID: 20250925-ima-audit-8bd219dcc6f6
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>
Cc: Frank Dinoff <fdinoff@google.com>, linux-kernel@vger.kernel.org, 
 linux-integrity@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758843915; l=1259;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=I6Ydgfc2v7hNN8vU0Z4GiGF59ehBkmOfll0Wv6sZitY=;
 b=TR67dF00Kbu3UTSn/q8bhk4Mhq2kSm9KMuTlj7mIMngL7XF5pp5tQpE1zzflNubEt0whBKh8N
 kBplw/6C8hcB7s308R9QAz+OBWDekRZqQpN+Dl3X6AHnXqu0WbjNpVL
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

This series adds a "dont_audit" action that cancels out following
"audit" actions (as we already have for other action types), and also
adds an "fs_subtype" that can be used to distinguish between FUSE
filesystems.

With these two patches applied, as a toy example, you can use the
following policy:
```
dont_audit fsname=fuse fs_subtype=sshfs
audit func=BPRM_CHECK fsname=fuse
```

I have tested that with this policy, executing a binary from a
"fuse-zip" FUSE filesystem results in an audit log entry:
```
type=INTEGRITY_RULE msg=audit([...]): file="/home/user/ima/zipmount/usr/bin/echo" hash="sha256:1d82e8[...]
```
while executing a binary from an "sshfs" FUSE filesystem does not
generate any audit log entries.

Signed-off-by: Jann Horn <jannh@google.com>
---
Jann Horn (2):
      ima: add dont_audit action to suppress audit actions
      ima: add fs_subtype condition for distinguishing FUSE instances

 Documentation/ABI/testing/ima_policy |  3 +-
 security/integrity/ima/ima_policy.c  | 57 ++++++++++++++++++++++++++++++++----
 2 files changed, 54 insertions(+), 6 deletions(-)
---
base-commit: 00642a06d60c897a8348784e1eee9e5369219ce5
change-id: 20250925-ima-audit-8bd219dcc6f6

--  
Jann Horn <jannh@google.com>


