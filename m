Return-Path: <linux-integrity+bounces-7030-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC341B48ABF
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 12:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C0B16E518
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Sep 2025 10:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3993226D14;
	Mon,  8 Sep 2025 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSpLr0gT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1996821CC55
	for <linux-integrity@vger.kernel.org>; Mon,  8 Sep 2025 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329115; cv=none; b=BkNY5n/zD1eue23Bq/D+dDZqi0jdcPCKUqYMZV3XAn1n9SeCO6kz593KqzH+mdv7QCKGDbatqnFV707GG5hHfnyE8DlAFpfRKN9yaL20Kk2NL0W1ObfQvSX2AEpOuzi7WdO11eJMUU/bGTVRJA+BG6xBKncVHSWZps3skwNE8vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329115; c=relaxed/simple;
	bh=G44EIqcHlPc0MPwbyXEzw8SRNF12eQUABiDDCqEXD9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KraV9UUCP9pCMcpzshta9lfn2ZNC59//JcMuSoRRHQoQr6g/kVi5mXXhVpDAT+O5Rb4wcCL/q0J7n001rTx9CNl6ZE2fq4EL9uBLiCqJCLW2XwVuFKBAb7mgQx7joE4pBavVJkj+8fOmXHLU11qRvZjgo8Y1hrrC2D0hLwFO+1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RSpLr0gT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757329111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myamu423IxjnsnsnK8n7lFRHcKeofu6ER79sc7yqpzA=;
	b=RSpLr0gTZdmrQJ+eXTKzXSMMEllq3oG59wfyO31CsLytE5uqdEXPwhTh7yce/tQdIcchBg
	ftrSVeJzatNpYKFMfqbwgl2vU2boJrMOgkppDi5xvzGnFg/f2NQLL36mIXnJkK8uoDnr42
	iPC+q0pR6Nn/o3YYcj/2KBVusPV+ckE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-YRSScLrdOhe37fJvjEE0Lw-1; Mon, 08 Sep 2025 06:58:30 -0400
X-MC-Unique: YRSScLrdOhe37fJvjEE0Lw-1
X-Mimecast-MFC-AGG-ID: YRSScLrdOhe37fJvjEE0Lw_1757329110
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77253535b2cso4188742b3a.3
        for <linux-integrity@vger.kernel.org>; Mon, 08 Sep 2025 03:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757329109; x=1757933909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myamu423IxjnsnsnK8n7lFRHcKeofu6ER79sc7yqpzA=;
        b=WvgsmVvVnhx6PGStsRKV29QYNmZlloxZ95+w/KVCNVSOF8DiWI/Nv6/fxP0qiA0le5
         69gXfli4dDWXd8PYOrjO6DJeb5L9EUmLmPGHmCztCWEzMgUTl4C4P9QusHa0zy5ShYKl
         3LZUuPOrCi77uH/V6FFBoG9A5+X+oiH65HGFVQXefmQIgEGWdIFh5D6kK+T1Qg/a+ZkD
         Bep7cZIJlhpt0rXXFt7UIUP8CxW+KUZLJRSHU02s8XJ5VtN7EdAH9HOfDWQ/io8dl+SZ
         SsPBjzqsD3X1FPd0yzOcHVE14H8vi+OwvzUfpmdaP0uluogxJfD0hnub35SBzTZlH9e0
         kgew==
X-Gm-Message-State: AOJu0YzWnUfFEoiDfm3+uaOjqbdzOyB8IIqLnC3pzET0X6yt6oCy+wfH
	2lqUJpnvVmlBNl4auJqKzndbnmPU0cPdRsrgwwbx7JVZIVct/arDpND4DP02IbI20dCmg6s0Bp2
	5Cb4w117OPVxbgTnwIPKF4hr9nUPLcrjYuXoWB0kGm+D2KJ9Fmo5JfMiAzaE7ZajNGtm4Jf9ddy
	PGXVB8rgUlXlEej6EGdglH8GiepH39mCv9SpaTrcHyqNM4RpxwmLN4IQ==
X-Gm-Gg: ASbGncuvM4lYFeQ6WBBb3aB78IHvt22UHH4D3UDQ5HQrXCRdDi4rRCkX7+dMjwG0j6b
	N2uaDaxgegLtMwHyEe2osjcnR/LX+5Hm46MwWkO8Zhoummw8jbSp1/8FpYylecJZLTQeYlm/D8k
	a7HBgC2yVbo3SCStbMZgPuLxIZ/mSAytMQCK1kOvFP7/oeh+KzI8+b8hLkRIQBNvQp4KeRgz/0r
	6gXXXC14BpUgFQBDt2Kt8xPAReiqVPvTAVPJsa6p8f+eaGBmimQOzQrmSJvsHSMWPT8nre1PGfD
	gcYlhIRZE+7u2TlnLDoNl11//oM4hWw=
X-Received: by 2002:a05:6a20:430b:b0:243:ce0f:e809 with SMTP id adf61e73a8af0-2533e94f9b6mr10495792637.23.1757329109293;
        Mon, 08 Sep 2025 03:58:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4DVeHGcV8BCDHrKD5vIE00IOinovx4zFRGm8WoZlYfoY+Z0xsXFPf2zD23vpJ0Ng5ZtHbYw==
X-Received: by 2002:a05:6a20:430b:b0:243:ce0f:e809 with SMTP id adf61e73a8af0-2533e94f9b6mr10495760637.23.1757329108797;
        Mon, 08 Sep 2025 03:58:28 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd092e2aasm25702026a12.21.2025.09.08.03.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:58:28 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ima: don't clear IMA_DIGSIG flag when setting non-IMA xattr
Date: Mon,  8 Sep 2025 18:58:24 +0800
Message-ID: <20250908105825.1573222-1-coxu@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902042515.759750-1-coxu@redhat.com>
References: <20250902042515.759750-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently when both IMA and EVM are in fix mode, the IMA signature will
be reset to IMA hash if a program first stores IMA signature in
security.ima and then sets security.selinux for a file. For example, on
Fedora, after booting the kernel with "ima_appraise=fix evm=fix
ima_policy=appraise_tcb" and installing rpm-plugin-ima, reinstalling a
package will not make good reference IMA signature generated. Instead
IMA hash is generated,
    # getfattr -m - -d -e hex /usr/bin/bash
    # file: usr/bin/bash
    security.ima=0x0404...

This happens because when setting selinux.selinux, the IMA_DIGSIG flag
that had been set early was cleared. As a result, IMA hash is generated
when the file is closed.

Here's a minimal C reproducer,

    #include <stdio.h>
    #include <sys/xattr.h>
    #include <fcntl.h>
    #include <unistd.h>
    #include <string.h>
    #include <stdlib.h>

    int main() {
        const char* file_path = "/usr/sbin/test_binary";
        const char* hex_string = "030204d33204490066306402304";
        int length = strlen(hex_string);
        char* ima_attr_value;
        int fd;

        fd = open(file_path, O_WRONLY|O_CREAT|O_EXCL, 0644);
        if (fd == -1) {
            perror("Error opening file");
            return 1;
        }

        ima_attr_value = (char*)malloc(length / 2 );
        for (int i = 0, j = 0; i < length; i += 2, j++) {
            sscanf(hex_string + i, "%2hhx", &ima_attr_value[j]);
        }

        if (fsetxattr(fd, "security.ima", ima_attr_value, length/2, 0) == -1) {
            perror("Error setting extended attribute");
            close(fd);
            return 1;
        }

        const char* selinux_value= "system_u:object_r:bin_t:s0";
        if (fsetxattr(fd, "security.selinux", selinux_value, strlen(selinux_value), 0) == -1) {
            perror("Error setting extended attribute");
            close(fd);
            return 1;
        }

        close(fd);

        return 0;
    }

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 security/integrity/ima/ima_appraise.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index f435eff4667f..4e4750ea41ad 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -694,6 +694,15 @@ static int ima_protect_xattr(struct dentry *dentry, const char *xattr_name,
 	return 0;
 }
 
+/*
+ * ima_reset_appraise_flags - reset ima_iint_cache flags
+ *
+ * @digsig: whether to clear/set IMA_DIGSIG flag, tristate values
+ *          0: clear IMA_DIGSIG
+ *          1: set IMA_DIGSIG
+ *         -1: don't change IMA_DIGSIG
+ *
+ */
 static void ima_reset_appraise_flags(struct inode *inode, int digsig)
 {
 	struct ima_iint_cache *iint;
@@ -706,9 +715,9 @@ static void ima_reset_appraise_flags(struct inode *inode, int digsig)
 		return;
 	iint->measured_pcrs = 0;
 	set_bit(IMA_CHANGE_XATTR, &iint->atomic_flags);
-	if (digsig)
+	if (digsig == 1)
 		set_bit(IMA_DIGSIG, &iint->atomic_flags);
-	else
+	else if (digsig == 0)
 		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
 }
 
@@ -794,6 +803,8 @@ static int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		digsig = (xvalue->type == EVM_IMA_XATTR_DIGSIG);
 	} else if (!strcmp(xattr_name, XATTR_NAME_EVM) && xattr_value_len > 0) {
 		digsig = (xvalue->type == EVM_XATTR_PORTABLE_DIGSIG);
+	} else {
+		digsig = -1;
 	}
 	if (result == 1 || evm_revalidate_status(xattr_name)) {
 		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
-- 
2.51.0


