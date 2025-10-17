Return-Path: <linux-integrity+bounces-7474-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CFEBEBBDB
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 22:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D70A54F4C52
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 20:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26324263C8A;
	Fri, 17 Oct 2025 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KNMnkLWv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6E5233155
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734144; cv=none; b=kUoL12m/TjHyeHAgBrzvTil9jQQXSxp2UtboCxXwurE1R5OIxqYdRxyIqmklualNc3Ocop4f32OJJ/NwTiu2DPwA4yjcChA0dlrJBhijqVPrfTmskr7g5XC/lDa5HIKCMHUWE/kbT2Qsf2nMFEWYG6ZO5qpwtMgzHx5BEH1B6+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734144; c=relaxed/simple;
	bh=9Y2Zrx/Cr8b7TGO8ZCajAJplVcXFy71y4Cg1wFPKLBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I295BXxMZt6YZ3yg7adZyBKZctTLf4sZOLZOdCYXS8Rhj1a6G4rdTbAcnS8inQIkNe5JAzlXmJKRfzTFxmMCxZhsaD3Rebc/3EUGl5mbX3siU8YK0oVKc7sNieRKrgCDKfQYjAxnEWb2JFRXo57dOrCaQIW3ajA0nWUq7Ze/hk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KNMnkLWv; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-88f8e855b4eso201980885a.3
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 13:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760734140; x=1761338940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6P4WI6kq9TcSDMRGH/ZyspTQ080SiUOr/PdVMdw5Zw=;
        b=KNMnkLWvsn0Es8/GWBEbWyZZuwFNmsQavoylirNX8J0iNZUBSPiYygYpJ6GLcol6Yl
         /SG9U6ZNSbtObzQmsS8/2W+S7b2Ig5RJQebdSJMpxDqtWNB6fGv9CFmuQj7fQIU9AjIj
         7SxENS9Vh8H4Km6chRGY6sRkq51OVq12t+Vwe3LX00FXq6y14md6YexrwWm4SOA+gvu6
         T5a1UVw2rsKszw/gfQplRMUBEzpA+zbvWjLMlLrOB/EtQeyZABL6jkquBKv/+73A08bx
         MTdfFtZfkV3OjIcuUaKNdEQoKa2OVAS9g4Q2I6TSXjprLKTO/HL4jlREZKwnHK6gkgn5
         UlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734140; x=1761338940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6P4WI6kq9TcSDMRGH/ZyspTQ080SiUOr/PdVMdw5Zw=;
        b=lbuvbKUq4JLoyp78DMjjSJ6D8tXidPlKC4B7bsLoWHmbQIm96sZkMcW0ZSSv8rLurt
         4ho2SD4X7gFcLWcjrHOrDJtOO5P7by2Vb8CQBeRNpgypXO0bnhQrZoYdUL5Kf77GoRRA
         xMUCWSu4o13uoZC4upvXs9ZsUnmGczDKIfvoYw08MC0vKIVO5HMZ6sPsKmTRP3fPimg6
         uUbGTdpB6jCQBMPc4HrN4343PQT2SbObNXYf4UxBX3GXQwit8ISidh4eavbw6ZcZj5FS
         8BTVJo+hq3wnBbF4UYOj792hJVbtHpKsg8rezlL7qUXTwVqd0im7mlKmz8vTEnaGAtEd
         FQ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV89txdWValVYjXdeBNX4MXXaHMEkhXbHsuiG5C7aWC2jMTxamcc9CuL9ga31ib+3BnZl26X4WC3EIgTU4IIJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5w68BPckhX8W+RkF1vidEXxK/4ld/goeGin/iUC1D702QM4ng
	+5Pv/ZqjNHmEEnhuJgE7/akopLnPeh+X/ZoQom6MyJURnwOjxo9QzQMaspxdxcepeg==
X-Gm-Gg: ASbGncs5aS5oXpyig5l2oZoiQjmvoUWiPTujeVbPO47sQNTe95oSKuSR5QIpG+MKbqG
	3k9Ozn5mRUoTbnc+o1XCFuHomk1uLV8TzqR4pr1rXQz2e63t30s/WHtEtgS7cWM7XfV1a6ap956
	jaiMxQwE3Svz9iokFzVKtYAZRKk14iCGBwUK8vnMqwFrOxlc9IcnDLMs5SJgLrjAGYZzuJIvr7I
	lqmlzx07PeRFmsjIwatJZUgZzA83YDpy9+ZJ8VXb3YqwpINeQX5gNI+ByGpo6J5vl8fzTAAmlQ2
	xNYGtfzRCAmSgmJmtm5SdX9fEGdexh/XWc4OdvGvWXzlDVTgzdBLR6jxmSsPelZ3aTnyk6UFYnd
	fVDHQTExg9YaKMkRUm5Mw+WLQVVNLJWw11HfublDOXbvnct6mosrw/HQJ3Gi+Jk92j9VMImDCmf
	ajFdea4C1J6DvtuFRp+Skc2ruS8vYOskmi16c+i1MDc1jvyg==
X-Google-Smtp-Source: AGHT+IGEKeIk1mH7UjWm0L+4D1j3Z5SFblT+9YG1M1mQSzQraCNCKG1c8R97qqMFLE4kXWs5QXuoVA==
X-Received: by 2002:a05:620a:4621:b0:865:cacf:e11d with SMTP id af79cd13be357-8906e8aff83mr726508085a.12.1760734140485;
        Fri, 17 Oct 2025 13:49:00 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cf58ede4sm41969385a.42.2025.10.17.13.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:48:59 -0700 (PDT)
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
Subject: [PATCH v5 05/11] safesetid: move initcalls to the LSM framework
Date: Fri, 17 Oct 2025 16:48:19 -0400
Message-ID: <20251017204815.505363-16-paul@paul-moore.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888; i=paul@paul-moore.com; h=from:subject; bh=9Y2Zrx/Cr8b7TGO8ZCajAJplVcXFy71y4Cg1wFPKLBs=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qucbD3hqsn007tssjS8Pw6v4x1QocL1W4pVP /T+zQ0MUw+JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKrnAAKCRDqIPLalzeJ cwTID/9d8707/NwnMIb0EAR7uaqqYuf1JO2bnmAyPlZC4haQVENWGQ2TGjn79Il8LSCgMaM0gnu eF6Y0U0lMWhROvyUVgvkrNnGmR2lj9wxG0QrvL5sDHZI4Ao6NGi+5zhDEd2I4rgBAIbdSSt9Q67 KqJNgUlN+4i3Ckauym5QCUpVtm09QlVIHLSdY6gY0OzLITgldomNntpEK5BrzPQhzZ3KuKNRk37 6bNTi1VRYn5FOO38cinEWpFeuH0+i9+do7FyjmCTU5eisH5RCF0Y5nDQPCfQ8Cn7SyUL69IjUsq sObQXxq0yJH9KH775vIAPzV6gu0977mcCMR+vLR5Os9liS44kXZyRnuTXq82JKOSpgFRCe4IKFD rGdS6Q1YzaZlawAJi+I0N7gsHLFUsQ3GbZMjn5ZA/6g1zF/NXZYPdoyTVYVm2xdgx2o3dAjud37 vu3dxcCs3JzOiTbPdGsO5ZF3UGNs3xai2hNnPS8Q54nFZySdPJnMQoUQJzzi37HbyqM8JVUR5g0 Se2bB6lChCoKzRpXNsv3VTM4IcCf/EqSV0voNeYZq0jnwE7dh7I7m+rmXJsLICAbWF64jtQLdcR pzy8xjgYP6S+alwXGdL39YELmxEiWLmZeg1iHMUtTquN6UL0XiU6jWHictF8wNfIc+wKxFMyvOF HcmRgdXkjtaLEGQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Acked-by: Micah Morton <mortonm@chromium.org>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/safesetid/lsm.c        | 1 +
 security/safesetid/lsm.h        | 2 ++
 security/safesetid/securityfs.c | 3 +--
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 9a7c68d4e642..d5fb949050dd 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -289,4 +289,5 @@ static int __init safesetid_security_init(void)
 DEFINE_LSM(safesetid_security_init) = {
 	.id = &safesetid_lsmid,
 	.init = safesetid_security_init,
+	.initcall_fs = safesetid_init_securityfs,
 };
diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
index d346f4849cea..bf5172e2c3f7 100644
--- a/security/safesetid/lsm.h
+++ b/security/safesetid/lsm.h
@@ -70,4 +70,6 @@ enum sid_policy_type _setid_policy_lookup(struct setid_ruleset *policy,
 extern struct setid_ruleset __rcu *safesetid_setuid_rules;
 extern struct setid_ruleset __rcu *safesetid_setgid_rules;
 
+int safesetid_init_securityfs(void);
+
 #endif /* _SAFESETID_H */
diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index 8e1ffd70b18a..ece259f75b0d 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -308,7 +308,7 @@ static const struct file_operations safesetid_gid_file_fops = {
 	.write = safesetid_gid_file_write,
 };
 
-static int __init safesetid_init_securityfs(void)
+int __init safesetid_init_securityfs(void)
 {
 	int ret;
 	struct dentry *policy_dir;
@@ -345,4 +345,3 @@ static int __init safesetid_init_securityfs(void)
 	securityfs_remove(policy_dir);
 	return ret;
 }
-fs_initcall(safesetid_init_securityfs);
-- 
2.51.1.dirty


