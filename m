Return-Path: <linux-integrity+bounces-6960-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5044B3F3B9
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 06:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926EA480BDA
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Sep 2025 04:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E6F2E03EC;
	Tue,  2 Sep 2025 04:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFM/4JbZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E0225EFBB
	for <linux-integrity@vger.kernel.org>; Tue,  2 Sep 2025 04:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756787125; cv=none; b=qNEnPqRxR5YE/dWvqHqbPKAZSjN1ryzlKBqhfs8SlLEieIEq02JheCiCjYzjD1oUiKPLrYKb99iLsCLcTbSsqyD4ADwUyGpm7ZJTywWU9y8POKMFyVK/s9ZJe0f/YUFAP1CLbHx3aqon9kNGXdtcLEUoWaGsLgHEpTL89Xu9u1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756787125; c=relaxed/simple;
	bh=KGVqkd0oWHkbJ+ZQ3pjCuoMltYbH2zy2sVQQCrEM91U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bR6YuyoTTgM450liTcftvJGOSUtbm7ZhOTNjKQejyt4igqN7vsIjfjQrhPQlmzgky6CgcKu3tUs4PhNDXIY16GvzCCOXVRqcXlZHVghT3g/p3QMMjqzW3XdcouNas/Dgl6uJ8Se8zveUmvKmgllAy3kTKLn8+HDOAkGR3j6cLVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YFM/4JbZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756787121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yceXk2CDlZjXkspmIbhQrCudqcmdaHsA3xCQZcIxoPY=;
	b=YFM/4JbZXLGb8uZsNcQK0sjGid36RSc6J2zAWSP9PtRaDa/V1Wb/bsMZmUiHPmDVbnnvIB
	IvrQVecYPFFtQAHM6O67Osyu5jqdR3gQykXbmsmnxRWPiHDyYVec4OeDdZmQpHUmouVUck
	F8i7Z3RMU0HoJI6Of7a9mIOGSf3SsoM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-MuddI9_zPXOwDulgP98Fpw-1; Tue, 02 Sep 2025 00:25:20 -0400
X-MC-Unique: MuddI9_zPXOwDulgP98Fpw-1
X-Mimecast-MFC-AGG-ID: MuddI9_zPXOwDulgP98Fpw_1756787119
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24458345f5dso55724235ad.3
        for <linux-integrity@vger.kernel.org>; Mon, 01 Sep 2025 21:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756787119; x=1757391919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yceXk2CDlZjXkspmIbhQrCudqcmdaHsA3xCQZcIxoPY=;
        b=EJziAngl6UC10bwd/Yjp+baT7qLjD0o7JRGcPKXmktJLkFiNksXQ9wHCIZi5eNa7Np
         +m5EFoS3CZE82+2E32RBPSOlPDNXWZdeQ53P223cE8IDfWl5ev5vas/TmlKvQu7z15kM
         c90QhV/kbJquR10fYINJ/vknyofUyTMHaw7RpKylMfNB4rFlQrt+aEnO35HO+A6cQR1O
         3YLJbnUzdpBGbWZxA1b1HcrQ/BgRT10ZlRWf0IHJz4AN5Q04umPgPqWqgJ01MmRKUMnK
         QS3sIllR3O80OFChur0FeoUeZUo086RK0sWZBZ50L9QUCSd6gbVTZp7yb1ffAyyV4OG2
         pRJg==
X-Gm-Message-State: AOJu0YxQyvavP04q+NB0abl0KCk3JXaADUDUgTGf6c2VUHBhTdzFJ1na
	rfR9K239Baby8QL02Qp76VknnTdvqUokhLptkJFLXpvzfEF4t9wsNvtjJcuLoYaqqf1xSwnDTHz
	Zixi0PloCSKX72q/k6H0TeTPHrLk0V80Uk/US9mSy8TYtmXYq+vPAWdyZ4g8PK537PpfMCOOpMc
	3uAJNKIARErYSGoZEd6ymX2Ja8KJXSlU1BYo8tx3wwRax0QQmh4TI4lw==
X-Gm-Gg: ASbGncti3XXDOcJiAWjfNucPMVo/cseSKcQzthmdAfGY9gIK3eEOiOjvSmZ4gTyjKIO
	P22tpN9QbI4RH3ObN3djWp4lEKxX2oYlkRjgA/V8Tvn7wm9oGrox2Ru9jjjjtLM8TJypW2n2W9p
	4xBH8Px38sOI9HSkfChaZ+KlFt08YnxfoB3xZUkGltyf77jPM4PnC+CryWNE1S5kpV/AE3AO/K2
	I6deP4vLrA6UVVpZtYnnt6ItnxYjeDVXOyX5A0MN58b8FensbBaj/7sUvqvO3wWEikHvZVakrBu
	X5iEEhiAdtCzPxDxqHqWCtBzAMYu1GU=
X-Received: by 2002:a17:903:ac8:b0:248:9b68:f522 with SMTP id d9443c01a7336-24944ac8802mr119741195ad.43.1756787119236;
        Mon, 01 Sep 2025 21:25:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6qHS5CaJlgiiZHBDHXTwlaeAvO21OpILjrDjJxhf0jrDdLhZ4exXvJAzU8wyGG8a51R9XhA==
X-Received: by 2002:a17:903:ac8:b0:248:9b68:f522 with SMTP id d9443c01a7336-24944ac8802mr119740845ad.43.1756787118749;
        Mon, 01 Sep 2025 21:25:18 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249037285b9sm120009035ad.44.2025.09.01.21.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 21:25:18 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ima: don't clear IMA_DIGSIG flag when setting non-IMA xattr
Date: Tue,  2 Sep 2025 12:25:14 +0800
Message-ID: <20250902042515.759750-1-coxu@redhat.com>
X-Mailer: git-send-email 2.51.0
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
 security/integrity/ima/ima_appraise.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index f435eff4667f..fc82161f8b30 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -708,7 +708,7 @@ static void ima_reset_appraise_flags(struct inode *inode, int digsig)
 	set_bit(IMA_CHANGE_XATTR, &iint->atomic_flags);
 	if (digsig)
 		set_bit(IMA_DIGSIG, &iint->atomic_flags);
-	else
+	else if (digsig != -1)
 		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
 }
 
@@ -794,6 +794,8 @@ static int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		digsig = (xvalue->type == EVM_IMA_XATTR_DIGSIG);
 	} else if (!strcmp(xattr_name, XATTR_NAME_EVM) && xattr_value_len > 0) {
 		digsig = (xvalue->type == EVM_XATTR_PORTABLE_DIGSIG);
+	} else if (result != 1) {
+		digsig = -1;
 	}
 	if (result == 1 || evm_revalidate_status(xattr_name)) {
 		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
-- 
2.51.0


