Return-Path: <linux-integrity+bounces-4005-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8559BB17C
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 11:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D39D1C2161B
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 10:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F6F199FD3;
	Mon,  4 Nov 2024 10:47:24 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FD0290F;
	Mon,  4 Nov 2024 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717244; cv=none; b=homyDOZcd3efwyMxJu3+PPbsRlIAHMtC5JTd7DiKIQVF2i46UVUvTsjYMUihFrMrMyBS13cHSsB31SEyNDbuMb5pPdP0NNvoBQTW/S3L8uy65FnkEjanC6anZQUX8ilt7JGRLy8lTlScyLrKDTpfs99ycI01h4YbdnJEIFQFVHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717244; c=relaxed/simple;
	bh=fF/BJOYudXv+MdqZ0BpwPkVcSD5wC31ZfqhPishC4pM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nDF2Cpf+jK2+VRezfV1iu0o9vZloUbKrmnwOGShfx/eboB0q3MNWuYYPhTAf5bQ2qadC/wbwlnaSTOMuaK41JsQ/ii642SnozTUTz7zekT1LKb9rdqxcV6DGASfZEnmWJBbXa1Z6c4hYE6MeHs7mr3JxZLVBLiOVL2dEaQnJtsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99ebb390a5so927714566b.1;
        Mon, 04 Nov 2024 02:47:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730717241; x=1731322041;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQQEfUO1UteUr9ACef70Th0pKJE+Tg+KwybXseX/MFE=;
        b=SZDLl+TPQHMRUjE9JpCotzO8JiUYJoV0Z8eCgSMAdkeCUduiKd5tX7cCO6EOPipd1V
         z9ZTLvAGjPEszXZ74JjnPrXfiTJ0siIDtfWvIk64Sdyb5QyyyQuVhCJ30iHbhu22jZAO
         720XLEYPxe6fD1lAMo2s3Cj3uCf88oFeQyrDhERTDqnu20dCRjCrut1XAy3Fzoq82YoS
         GJ41beEi6pUCCYiqbkF45EUIghwjKwF5rXQ1errlEcWT9QQkiyynugvGTkVFLlWS2RCW
         2xpotnG48PaMnL+RttakLiKiC2FzALO73/cEIExoeRyBaDWa0kP+9on1N2c7Ay8XZGTC
         gpUg==
X-Forwarded-Encrypted: i=1; AJvYcCV8iYIIf8mTf+W0Oq30UMUmgyPEj2wElmmAS5bcn4YGuhdMyG6cqt9u/6PuKWDGSlK3kos5tA4q/yqpYrjb@vger.kernel.org, AJvYcCVGHq/TAj1hGWkiH5kZqNk8Orkv6J4q/pm9MJkZQDVLU9Q51EM2IVW44lDj7BiXjJARs69jKLdZg7VpqqVwTI/BSRG3qDs4@vger.kernel.org, AJvYcCWeAONJ8g428gpzU/9B5LlsVfls4zLex+nLj3HVTIdvbblCpv/Hdq3gC2QkoV0LHlU9TGBI5qYkWgXbUrnkEiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+qpy8Kli1QQZVGLwH3M4vnuEuLC/Z7OvtqW8t1Z1lDnzxU406
	ibTntYtJHzCaIX1/SxoOQMFbMy41Z7jpCEdEmDjIVNm28rXK4iy1F3zSRw==
X-Google-Smtp-Source: AGHT+IGJczchdEfg7PAI7b5vVk9OlDmJnRR0O1DDPuiuIWnFdZNY3LbItDcPyZsYPciUomWmnx1jMw==
X-Received: by 2002:a17:907:7205:b0:a99:facf:cfc with SMTP id a640c23a62f3a-a9e55a87862mr1278049966b.17.1730717240215;
        Mon, 04 Nov 2024 02:47:20 -0800 (PST)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e5663cd43sm544106866b.143.2024.11.04.02.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 02:47:19 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 04 Nov 2024 02:47:16 -0800
Subject: [PATCH] ima: kexec: Add RCU read lock protection for
 ima_measurements list traversal
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-ima_rcu-v1-1-5157460c5907@debian.org>
X-B4-Tracking: v=1; b=H4sIADOmKGcC/x3MWwqAIBAF0K0M9ztBy0jcSkRITjUfPVCKINx70
 FnAeZE5CWd4epH4lizHDk+mIkxr2BdWEuEJta6tMdoq2cKYpksxuyYG10XdalSEM/Eszz/1Qyk
 f4oMEhFkAAAA=
X-Change-ID: 20241104-ima_rcu-ee83da87d050
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 "Eric W. Biederman" <ebiederm@xmission.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 noodles@earth.li, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1553; i=leitao@debian.org;
 h=from:subject:message-id; bh=fF/BJOYudXv+MdqZ0BpwPkVcSD5wC31ZfqhPishC4pM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnKKY2QG3u+OgeyzQ7/nyKXGqN7uUqwCWc8KKBw
 mJZtFtrgoqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZyimNgAKCRA1o5Of/Hh3
 bWm5D/9G8GgbraopxFjvSPKhpNSrDcdPCB6JtFhbwfB66HfjNAzUjHTniPUsdVoa5k48TAGDLOT
 KC/yclvHcV6QMeCO/gy2wzY08zJKbVOnQFrnpZCSu24asHu5wh6+pCpp8cqzh7MpubsX/8a7n8m
 OGNxbzwsEOjuMUbX5rzYS28rYzA31buPYNtxNM9uThJxuAu98h56SHMqphZVKjkztI5Dmo1qaZa
 rvacn92tx64qGEggNHnnomdQSKTqprXD6T8heGGAojWPyzTb3O3JfdwOwbgDa2N59MTUjUwvST3
 BfcC1CNi7kUWIFl3rP2eS1vr2UoMvxDaV40FN5UQLGotapuhC1mRm7XjInIcZlSzB8NUJvZ3K4l
 ZIZ6dwUIpuZnoSzAhvE4Ajw8elOoUoZbs5kaKxBFcbtum3Ws4kVuR1EoTyNS/NJc+OdUiqWw4eC
 SmxOjrBBMq32t7RCsmumWDFa9F2QUZz77wYRdTxKFqt1s3wXbMiPtQDt2z/F6O39bWuLXwoOrvk
 ZaA/fLrfccODWB4p0gwiCKFq7+PGThcsX1TyfFhDZ2Sl3YYiOSIb9LOrc6E/IYM0OBa9kdXPuEq
 3rRS+8lsoWaMDVtDsIVxzgdNfLsg8hBychDn7AcSAM+XhwRe4jq6/Xsb4PYkhnIC1Vo3ofm96ep
 SkADklTj+UUWUMg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Fix a potential RCU issue where ima_measurements list is traversed using
list_for_each_entry_rcu() without proper RCU read lock protection. This
caused warnings when CONFIG_PROVE_RCU was enabled:

  security/integrity/ima/ima_kexec.c:40 RCU-list traversed in non-reader section!!

Add rcu_read_lock() before iterating over ima_measurements list to ensure
proper RCU synchronization, consistent with other RCU list traversals in
the codebase.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: 7b8589cc29e7 ("ima: on soft reboot, save the measurement list")
---
 security/integrity/ima/ima_kexec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 52e00332defed39774c9e23e045f1377cfa30d0c..3b17ddb91d35ac806aedd2ee970ff365675dac0b 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -37,6 +37,7 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 
 	memset(&khdr, 0, sizeof(khdr));
 	khdr.version = 1;
+	rcu_read_lock();
 	list_for_each_entry_rcu(qe, &ima_measurements, later) {
 		if (file.count < file.size) {
 			khdr.count++;
@@ -46,6 +47,7 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 			break;
 		}
 	}
+	rcu_read_unlock();
 
 	if (ret < 0)
 		goto out;

---
base-commit: f488649e40f8900d23b86afeab7d4b78c063d5d1
change-id: 20241104-ima_rcu-ee83da87d050

Best regards,
-- 
Breno Leitao <leitao@debian.org>


