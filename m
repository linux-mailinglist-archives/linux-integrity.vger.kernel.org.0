Return-Path: <linux-integrity+bounces-8380-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CElvDUwzfWntQgIAu9opvQ
	(envelope-from <linux-integrity+bounces-8380-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 23:40:12 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0FEBF2EC
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 23:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D661B301F148
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 22:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A794838A9BA;
	Fri, 30 Jan 2026 22:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PwSiCF3t"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82EE38A9BD
	for <linux-integrity@vger.kernel.org>; Fri, 30 Jan 2026 22:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769812804; cv=none; b=acUJqZzrmKUsSU1Mou9twhC9iU9nUmR+gfmWXz099A/tMtED0J4x3Xq6C11VtLCxbU5NPE/iz9x90srxUsZ/g+jPl9CPZ2uAYuatcCQhWhxAOw5lkUk92x74hfrg9hMKzbUkvBANeRzXxhrmRDUrYboxrgw4Cv8FmKE3n3nBMB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769812804; c=relaxed/simple;
	bh=z6Lb6+ePLVA8CXO/fQsgr/T3R5dJYxJxOz7/MekKJTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O5RZIxHA9T2Swhs3g7ohmyuSkd09m9sO5kYE1RcIbpXjQ99DF0cQVlObPeJQnIeD5t2jj31eWkCvFu1NXYMt0QVT4iNKzp3YYm4EV/cpcoQOMgMVXDhbeWuoyxQt1v2D1n8gBLkaX08CaC/MUDtSb2qkVgdzDev+XfCg7nGaZ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PwSiCF3t; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45c9f47e1e8so1011816b6e.0
        for <linux-integrity@vger.kernel.org>; Fri, 30 Jan 2026 14:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769812801; x=1770417601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rU19TJuUpJsA3wTKDBviJ3u+aESdBzfWv1RhaMcQ8es=;
        b=PwSiCF3tykJ1mGz3PPdxd8c+Bo5lKfdjTA/UpkhSgy5qLZQfHejHhbY+sgiXO7WUT6
         oaaGAKEtkrEUv3okyFlKHsEcyN8AIxK/IQXbUpu6mVH+k+I8cAL1RC4I4AsAZCJ0gSuk
         e9OL2VD+KhsUW/VCMNhdAttfzk0xE6COvJL1MRHboIWLyJtatopw7jYJgZ3pNWxoB9Fp
         symvWZ7badmDQ+xFdQF71lTT0IWixss4UfeGNme6r5J9s1zs0TmBurA/niuFypLrFI/v
         t36BV5poUwEE/JGA80pgBBonhlP52vk1KAFaeBTVT4UMUD+snEf4M37VIr4hAGR4uZTH
         dH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812801; x=1770417601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rU19TJuUpJsA3wTKDBviJ3u+aESdBzfWv1RhaMcQ8es=;
        b=QXPLzpgtvp6NPMn3ZJgXvjruyMHtahOqiBDYKBxHFNvnTBSI5RejTSCm/JH+y4QfLa
         TQ6duCu4y6fFAs+pvqm18xu7ErXwaQGxHoTmakrVbaXauJd7DuAtZ0ss+RfNrxm6FepN
         rCcDsKSQweY4w7wTbJGLxy/ZMgabeLnrNy3TE2Dk2U2Pkx0RjhAvQi9pht54svuVqi00
         UiTXDRsc63sDTW4somLsdWq10afEKCS/1A6xLBL4ZaNcDrNwXexn4pBKZ+wHy8uv9dUg
         g6UMmqm8cJpGOb6YqCwINcDo3GgHcr5dFFqyh815yao1ceuHYSoE4fUWxWYIzWctOlm4
         jGfA==
X-Forwarded-Encrypted: i=1; AJvYcCXYIF8glwyCVrzZUl1jq7SwpLFH+dwu3P6qC1QOvQnfznd2p5pAUWJGkHEykG+qJkXdKvdO2h1CJw7Jedog1Gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMziwiZgOXD3QdRxFDrwmni3eE12Cv/9UmSPayWnobDjLqyxnu
	jmeQrT5eNLPFpfPvKA8NkEyiBRoc/c2T8sndPIlPyXx4rnCaKvFomNGMIOWEYL6uiqI=
X-Gm-Gg: AZuq6aIcNxynEHmF9xq1ConOGjI7S4b1Gv+li5dTtpLfM4y+6brxcjrkFPJoczmulXS
	qMxVS3wcuLhqdBhKOIzCVthQoGoO5+a3orWyt8grfzE0kulCwYhqbmYAOBlc7xQmhC7hMmHpfDx
	p4A4ewAGAYErif0gtR7y0bt528uaSixTTpxbyTy/zBbRZN8aE9dS6FA8PwIc+0s1w+3nkWzyZ1g
	90AR+rDCywBu5IdIp8oyOtBNtSxiI16O2aVDzGlkZo1FDU/RGBRJIV2k/dSxk2x+A03bLVAZN8l
	lfUK+jklgpMaYN2CKpjauOPgMRUD21+D7esDlnN5QBHUDsUTEFfLYXov1JnIpGhG828abLGn1tM
	l05/6NrDger1KPwd68naLoAy2mNbZ4V+VoEBV0+91UmZ0aLb1GHW/6nN9ugbiXzeWJlIbMnA=
X-Received: by 2002:a05:6808:1b0c:b0:455:db31:a680 with SMTP id 5614622812f47-45f34d8b8e1mr2058357b6e.63.1769812801483;
        Fri, 30 Jan 2026 14:40:01 -0800 (PST)
Received: from [127.0.1.1] ([2a09:bac5:947d:4e6::7d:80])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f08f20e38sm5400250b6e.10.2026.01.30.14.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:40:01 -0800 (PST)
From: Frederick Lawler <fred@cloudflare.com>
Date: Fri, 30 Jan 2026 16:39:55 -0600
Subject: [PATCH v5 2/3] ima: Make integrity_inode_attrs_changed() call into
 vfs
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-xfs-ima-fixup-v5-2-57e84ea91712@cloudflare.com>
References: <20260130-xfs-ima-fixup-v5-0-57e84ea91712@cloudflare.com>
In-Reply-To: <20260130-xfs-ima-fixup-v5-0-57e84ea91712@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org, kernel-team@cloudflare.com, 
 Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3748; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=z6Lb6+ePLVA8CXO/fQsgr/T3R5dJYxJxOz7/MekKJTg=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBpfTM9Qr4QWn0gskmoTP3gBCkBf94vdfd8ocQEE
 5Tb9icWCOWJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaX0zPQAKCRCrJbR2A5LT
 bVSdEADsVtc/TtKM1xv5L5y29nfE2m8qig/KZsYSTP9RTmNF9dR3e6EIQhN82zcgahKUZfIUI67
 zjZXk5EZOmIIU+LYlyS0bMZvMXY32bUqh4NW/eyeIFgzjhOlhFz7jh+X6WB48iIxTckn1MaBgLg
 juIBsHgrPE2/qnTDwwTopyYt3HiHrBpIYkOEwGo9yvHVcqfQI2xrsILzDhnB54Q+ZWFkmcIecXX
 4ClNt6vbDS5SHF52bkB4VK5B2lbovTnKwFDRH0kBq3yHLgczTYjWSlMQmcnjgnV5p/bHj8RXUv6
 bbyVVutlgd6sWbJ/KQLHObHimytWt80xDpmvkK4g8VmjJ5B5cpE2fPG3ydbTqETMKbcoFzZ6XYk
 19OenOYNIM/gkuHu+8whUnfuojNmCPtyvWXaypurq4GBN1VTRqfHK8PJm3PXv+YGyGTwLDyvXod
 9nx6uC/Whs9qrSTzWZPxCK324UzKtPsQ2xgnviEs2uX1D07KDByVTDtLy/njM4yL1txMpnwl/qu
 CXs0sNbCPd6/bEfIgCh++dtY25gjuuxohygL/0px3MtJVhRKWdBqQ0XjIukM73ZKrGpNenf7yk6
 ztFL9z59XlWoqmke38etUnpsC2prGRFONWkRW4X8wBrhKy8H2i8RH4wrIxDZYcxmf2Ali3jD2kJ
 AKEwEVsSn4YHxqQ==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8380-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,kernel.org,toxicpanda.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fred@cloudflare.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,cloudflare.com:dkim,cloudflare.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C0FEBF2EC
X-Rspamd-Action: no action

Align integrity_inode_attrs_changed() to ima_check_last_writer()'s
semantics when detecting changes.

For IMA, stacked file systems that do not set kstat.change_cookie,
integrity_inode_attrs_changed() will compare zero to zero, thus no
change detected. This is not dissimilar to what
ima_check_last_writer() does.

No logical change intended for EVM.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 include/linux/integrity.h         | 28 ++++++++++++++++++++++++----
 security/integrity/evm/evm_main.c |  5 ++---
 security/integrity/ima/ima_main.c |  5 ++---
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index beb9ab19fa6257e79266b58bcb5f55b0c5445828..382c783f0fa3ae4a938cdf9559291ba1903a378e 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -9,6 +9,7 @@
 
 #include <linux/fs.h>
 #include <linux/iversion.h>
+#include <linux/kernel.h>
 
 enum integrity_status {
 	INTEGRITY_PASS = 0,
@@ -62,14 +63,33 @@ integrity_inode_attrs_stat_changed
 
 /*
  * On stacked filesystems detect whether the inode or its content has changed.
+ *
+ * Must be called in process context.
  */
 static inline bool
 integrity_inode_attrs_changed(const struct integrity_inode_attributes *attrs,
-			      const struct inode *inode)
+			      struct file *file, struct inode *inode)
 {
-	return (inode->i_sb->s_dev != attrs->dev ||
-		inode->i_ino != attrs->ino ||
-		!inode_eq_iversion(inode, attrs->version));
+	struct kstat stat;
+
+	might_sleep();
+
+	if (inode->i_sb->s_dev != attrs->dev || inode->i_ino != attrs->ino)
+		return true;
+
+	/*
+	 * EVM currently relies on backing inode i_version. While IS_I_VERSION
+	 * is not a good indicator of i_version support, this still retains
+	 * the logic such that a re-evaluation should still occur for EVM, and
+	 * only for IMA if vfs_getattr_nosec() fails.
+	 */
+	if (!file || vfs_getattr_nosec(&file->f_path, &stat,
+				       STATX_CHANGE_COOKIE,
+				       AT_STATX_SYNC_AS_STAT))
+		return !IS_I_VERSION(inode) ||
+		       !inode_eq_iversion(inode, attrs->version);
+
+	return integrity_inode_attrs_stat_changed(attrs, &stat);
 }
 
 
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 73d500a375cb37a54f295b0e1e93fd6e5d9ecddc..6a4e0e246005246d5700b1db590c1759242b9cb6 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -752,9 +752,8 @@ bool evm_metadata_changed(struct inode *inode, struct inode *metadata_inode)
 	bool ret = false;
 
 	if (iint) {
-		ret = (!IS_I_VERSION(metadata_inode) ||
-		       integrity_inode_attrs_changed(&iint->metadata_inode,
-						     metadata_inode));
+		ret = integrity_inode_attrs_changed(&iint->metadata_inode,
+						    NULL, metadata_inode);
 		if (ret)
 			iint->evm_status = INTEGRITY_UNKNOWN;
 	}
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 6570ad10887b9ea1172c78274cf62482350e87ff..8cb17c9d446caaa5a98f5ec8f027c17ba7babca8 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -328,9 +328,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	real_inode = d_real_inode(file_dentry(file));
 	if (real_inode != inode &&
 	    (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
-		if (!IS_I_VERSION(real_inode) ||
-		    integrity_inode_attrs_changed(&iint->real_inode,
-						  real_inode)) {
+		if (integrity_inode_attrs_changed(&iint->real_inode,
+						  file, real_inode)) {
 			iint->flags &= ~IMA_DONE_MASK;
 			iint->measured_pcrs = 0;
 		}

-- 
2.43.0


