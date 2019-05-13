Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8E51B677
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2019 14:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbfEMMyi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 May 2019 08:54:38 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42426 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730034AbfEMMyi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 May 2019 08:54:38 -0400
Received: by mail-lf1-f68.google.com with SMTP id w23so8956919lfc.9;
        Mon, 13 May 2019 05:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YDGj9rVkvE8XZld5lFXG+QIkeDeoJDurNDlY5dYrCpo=;
        b=XE04hlQkBchBUXgcGRWR4Jw6UPX9mcLpmQGKBKbZg8hioEveJttbj6pIDs5U43zi4f
         MnIG+a1pWRqCQHD93XoA0aXixI/0+g3ExLqNQt9orbk/pnyLnn9IDmsT1FdrNDVVtjm4
         3BSc0ouTluJwoihs10/h4PC5oWS7LcPsnazpgs6T16A4keFqk5ciw0P7AhYQUcMjmxIA
         fubKyAkGp2w54elwmf/8HYycLlWIe5vichCHGDLgYe3x39fIhfIcDFhyxXcnnY9Vhs87
         tLcXmARbjkdvyPmML3lJp54lZkQvdMLhapTpOXuzPoRNLOqF/Mf/12/BCqgUd+Sp9urF
         135g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YDGj9rVkvE8XZld5lFXG+QIkeDeoJDurNDlY5dYrCpo=;
        b=ZHL7O30hNhUFz73OmANpoFoqdicotyil4qHYzQbPrO/cKe1nrYrIGRUouyc4aW3U/o
         9pbUkvTCSFAQa4+DRFr3Iq7TG9R7ciMB1jN5j7tT5iUgksDZ7kfraq4FlfuIYO6Wu1ln
         6ISqhY8tZ5oZAoLd0NKFwPFIfC10MHqg2NN2TwukUzBTqEQ0gkC4Y4xUzDKImfAbPB4f
         OoUh3DY0NaYCicgzexkbpFjoBqRIUnsvGzLkpJSvyT5RuXdZFCfrdNfPNSMWjctPktYo
         149V+ZpuHIjpYwL7gskQkEJwO/bZ/5iYcet3H/KcTTkYtARt2YyxuoYIhj+8sce28bHK
         FSMg==
X-Gm-Message-State: APjAAAVPhlLjUs0UvUwMOHk9vGnQQD77A7hgcUQrtDKiZdnFgCGhZCr2
        6/NjbCHLbHv9+KAX2nMS9z+QPB7Z1r8=
X-Google-Smtp-Source: APXvYqzDO3AdUUpn1HJ9XHgficGSyDLCnABfId/VCfp8rMP+P4CjdKQj8qmGU1J0hA6BzHMdvS3Q8Q==
X-Received: by 2002:ac2:528f:: with SMTP id q15mr12733938lfm.37.1557752075897;
        Mon, 13 May 2019 05:54:35 -0700 (PDT)
Received: from localhost.localdomain (mobile-user-2e84ba-11.dhcp.inet.fi. [46.132.186.11])
        by smtp.gmail.com with ESMTPSA id t22sm3202924lje.58.2019.05.13.05.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 05:54:35 -0700 (PDT)
From:   Janne Karhunen <janne.karhunen@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com
Cc:     Janne Karhunen <janne.karhunen@gmail.com>,
        Konsta Karsisto <konsta.karsisto@gmail.com>
Subject: [PATCH 3/5] integrity: update the file measurement on write
Date:   Mon, 13 May 2019 15:53:52 +0300
Message-Id: <20190513125354.23126-4-janne.karhunen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513125354.23126-1-janne.karhunen@gmail.com>
References: <20190513125354.23126-1-janne.karhunen@gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When a file is being written, mark the file for IMA for delayed
re-measurement.

Depends on commit c8213962517e ("integrity: keep the integrity state of open files up to date")'

Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
Signed-off-by: Konsta Karsisto <konsta.karsisto@gmail.com>
---
 fs/read_write.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 177ccc3d405a..bfe10d6dc135 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -20,6 +20,7 @@
 #include <linux/compat.h>
 #include <linux/mount.h>
 #include <linux/fs.h>
+#include <linux/ima.h>
 #include "internal.h"
 
 #include <linux/uaccess.h>
@@ -481,12 +482,18 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
 static ssize_t __vfs_write(struct file *file, const char __user *p,
 			   size_t count, loff_t *pos)
 {
+	ssize_t sz;
+
 	if (file->f_op->write)
-		return file->f_op->write(file, p, count, pos);
+		sz = file->f_op->write(file, p, count, pos);
 	else if (file->f_op->write_iter)
-		return new_sync_write(file, p, count, pos);
+		sz = new_sync_write(file, p, count, pos);
 	else
 		return -EINVAL;
+
+	if (sz >= 1)
+		ima_delayed_update(file);
+	return sz;
 }
 
 ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
-- 
2.17.1

