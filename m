Return-Path: <linux-integrity+bounces-7304-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EDEBAAFD0
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 04:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B243C5ACF
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 02:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63C121B196;
	Tue, 30 Sep 2025 02:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlaVBDgy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B625A21B9C1
	for <linux-integrity@vger.kernel.org>; Tue, 30 Sep 2025 02:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199229; cv=none; b=f2Noskb/hYhayvq6djIVOKjJcmGSQ9IWGX17+t2C7fhRW6/wsVUVpxyC83XRyIu59mxiMWJa1NgqfrBfATaluYfk83pdLbdPXGXxz0JAYf0SBlXI4JwL50NUty5DIZ4/J8PB/GO6NtaMcg83ws6Xsd9CpsY2Ko+lxgZrYZfeoVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199229; c=relaxed/simple;
	bh=6RVM/NL0ZDYk67kJzkhFeoTVqrVSQZgDBYioTsdcFlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=opn99DsVjMUT4qii6CQ0givcPar6z2hJVgp6enjA/baJfsEk8ZJH56Gb82ZQo1U+lFUq84RFgfl21lxk3DbvTXCIQm4RL+FZ8rCdHHvBSkmPgdp7rTfwyfK3DR46zEvdYs3C5hWumtalN3e4Iu9XSApxNQzgBrG/0YO+2S8SLTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NlaVBDgy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759199226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sg4kvyN9cH3Ka6BbQeKrM7RCNfTYVS9zo7EtNkElASs=;
	b=NlaVBDgyimR6gWQUn/6KL06S4d+VGMFck7UzrU0PqexoA/n6tvn1e0lOxWAU//lpwAhUgz
	1SHuw0JaHas4eDAMHr3rUyXPOHgOnfhVIuzA8V5Rk2nJoX0hcEfccnDgBBFLvS2UsCC3nG
	+ofN+5VjnhF1efz8gzcwmq0FjkAZqRQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-YDkoqXP9OfCHhFudNoKzqw-1; Mon, 29 Sep 2025 22:27:04 -0400
X-MC-Unique: YDkoqXP9OfCHhFudNoKzqw-1
X-Mimecast-MFC-AGG-ID: YDkoqXP9OfCHhFudNoKzqw_1759199224
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-27eed7bdff0so37051245ad.0
        for <linux-integrity@vger.kernel.org>; Mon, 29 Sep 2025 19:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759199223; x=1759804023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sg4kvyN9cH3Ka6BbQeKrM7RCNfTYVS9zo7EtNkElASs=;
        b=ealNPugs/S4LpMow3Lh6pawyhCGzhgC7P4XVf57aqZUR8kaI54rTUL5xY7yLwV7ubX
         FK4iRKWuOKB5gZ7b4ETO7geh75GYpsln431RS4Av7s3Uz13bmOnZ5Bjbv5W0wwmIan7w
         fFjX2DN8SwWwKPSFTIes0nNuT3oxp1xJdjLNsVbjVava5M2Djm1taS+dKdyDLKNM0Ikx
         ubGSsceAdsJZifMy98jgW7hVSCO2BTIUzQ0JS1Vofy5IUWxks6gfvUMS5Y2du/4kczHQ
         RmbjyIQeWOQc3tBM3YMl5hOPwjCpSn1rQLHrSQmAouTB+nOZIoS+JZqOUqkZzdy7kYii
         iR7g==
X-Gm-Message-State: AOJu0YxQMOdvVD0ZIMcHHQ0YTbIxlieuyx7NZkwjVahHrhejWE9/HjGd
	/2s3CbsVpLU9vLkoXecB0ywssogsmMGVWZXH3mV1IFWIoi6H5kUcAxLS5UdmnY6YpV+govaFjRm
	EU1sU/AzceqjvGWMSqVPx9/NlPetYkFwjFDgtwDFWYxwRCuTTvp5jVUCp08xpxZgwN3e3kZMBpv
	UDzkz7i2yBZaDCbT1QxH1sOChJKosFt0yIzAvTO+KhWi3nhkR1Vdg=
X-Gm-Gg: ASbGncukek2vYgvm0/FU0wU/RF6Eo40z/r+fVsc+XlO2Nj8aWi9ElPP9rDvAq47rRxm
	1ekCnLSExthqZ6yFj37iYaOeqdE7YeXdbV1p5xUNIW9Ou+vQ0By3adq/fnHO4r5tM9OYFIdw2n2
	85WfLD+PfZMVIprp+uxYm6beNIBMuYpoAZ0zlwDk19g553wW4UXFkaYdl/yVsUWbwslUCXd13sp
	Fg2w1Ic9gq+ZKuq7ectHCmbcsKFXbYv25GucTwZLtCdnWXxDH9PARYiL2H44vFDSy/XYyFSKjML
	ILWr1aGlc1slb4EkiN2DEBdpPD7OUA++Thm2
X-Received: by 2002:a17:903:2448:b0:278:f46b:d49c with SMTP id d9443c01a7336-28d16e88acamr27573435ad.9.1759199223158;
        Mon, 29 Sep 2025 19:27:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw7cypH/nZLG0Swdh9MGBzOSAdgylrCMgf2ZcGSHw42AyW3kmcjyYfNc4ncFIysi/zvSQhvg==
X-Received: by 2002:a17:903:2448:b0:278:f46b:d49c with SMTP id d9443c01a7336-28d16e88acamr27572975ad.9.1759199222299;
        Mon, 29 Sep 2025 19:27:02 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69bd869sm145301875ad.120.2025.09.29.19.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:27:02 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v2 1/2] evm: fix security.evm for a file with IMA signature
Date: Tue, 30 Sep 2025 10:26:56 +0800
Message-ID: <20250930022658.4033410-1-coxu@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When both IMA and EVM fix modes are enabled, accessing a file with IMA
signature but missing EVM HMAC won't cause security.evm to be fixed.

Add a function evm_fix_hmac which will be explicitly called to fix EVM
HMAC for this case.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/evm.h                   |  8 ++++++++
 security/integrity/evm/evm_main.c     | 28 +++++++++++++++++++++++++++
 security/integrity/ima/ima_appraise.c |  5 +++++
 3 files changed, 41 insertions(+)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index ddece4a6b25d..913f4573b203 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -18,6 +18,8 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
 					     const char *xattr_name,
 					     void *xattr_value,
 					     size_t xattr_value_len);
+int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
+		 const char *xattr_value, size_t xattr_value_len);
 int evm_inode_init_security(struct inode *inode, struct inode *dir,
 			    const struct qstr *qstr, struct xattr *xattrs,
 			    int *xattr_count);
@@ -51,6 +53,12 @@ static inline enum integrity_status evm_verifyxattr(struct dentry *dentry,
 {
 	return INTEGRITY_UNKNOWN;
 }
+
+static inline int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
+			       const char *xattr_value, size_t xattr_value_len)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 0add782e73ba..1b3edc6d26e9 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -787,6 +787,34 @@ bool evm_revalidate_status(const char *xattr_name)
 	return true;
 }
 
+/**
+ * evm_fix_hmac - Calculate the HMAC and add it to security.evm for fix mode
+ * @dentry: pointer to the affected dentry which doesn't yet have security.evm
+ *          xattr
+ * @xattr_name: pointer to the affected extended attribute name
+ * @xattr_value: pointer to the new extended attribute value
+ * @xattr_value_len: pointer to the new extended attribute value length
+ *
+ * Expects to be called with i_mutex locked.
+ *
+ * Return: 0 on success, -EPERM/-ENOMEM/-EOPNOTSUPP on failure
+ */
+int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
+		 const char *xattr_value, size_t xattr_value_len)
+
+{
+	if (!evm_fixmode || !evm_revalidate_status((xattr_name)))
+		return -EPERM;
+
+	if (!(evm_initialized & EVM_INIT_HMAC))
+		return -EPERM;
+
+	if (is_unsupported_hmac_fs(dentry))
+		return -EOPNOTSUPP;
+
+	return evm_update_evmxattr(dentry, xattr_name, xattr_value, xattr_value_len);
+}
+
 /**
  * evm_inode_post_setxattr - update 'security.evm' to reflect the changes
  * @dentry: pointer to the affected dentry
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index f435eff4667f..f48ef5ec185e 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -601,6 +601,11 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
 			if (!ima_fix_xattr(dentry, iint))
 				status = INTEGRITY_PASS;
+		} else if (status == INTEGRITY_NOLABEL) {
+			if (!evm_fix_hmac(dentry, XATTR_NAME_IMA,
+					  (const char *)xattr_value,
+					  xattr_len))
+				status = INTEGRITY_PASS;
 		}
 
 		/*

base-commit: e129e479f2e444eaccd822717d418119d39d3d5c
-- 
2.51.0


