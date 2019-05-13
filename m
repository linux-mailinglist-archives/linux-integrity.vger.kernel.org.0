Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFAA1B679
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2019 14:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbfEMMyk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 May 2019 08:54:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39247 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfEMMyj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 May 2019 08:54:39 -0400
Received: by mail-lj1-f194.google.com with SMTP id a10so2867325ljf.6;
        Mon, 13 May 2019 05:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/OasKaK8trru7E4rpuopnZXhAHikdiab0mVyv+wSaEY=;
        b=MuFITepIez4h6wo9/OA/es6WJGylkwB7T+8DCT+6yIsyj0DBFE18e4mDsnYc/rl3Du
         /fB7Y6/cyfE8iEkHuogqGapXqCyhEEFSY69FBG96e8mlnCSOK6Ix08wNfplumkH/T2yG
         sBPxnajy8tKiEzLDPiTLwkUe+Do0xtrk8f6VtcbkHaysMGmhc89by4Irw2/6YUHhukfe
         +qxi7IBqzViMVJ1stGGdYTChStX1W2fjAzBlys8NoT00a88cmGGf6iduJVJSgt9FZckx
         9ROs+1XDYK1QSweiMFxW35OFzmrWQ8uQWd3yp6tT9e9OnzZn4KLUqW4FhdK+KsRXtIRa
         f0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/OasKaK8trru7E4rpuopnZXhAHikdiab0mVyv+wSaEY=;
        b=FvY7kejrtJAjsKCXcsjH59/mqUJ8v/yJZk31RSW6APBU7rVz76P2nprW+2OboB61VV
         vxq8q+CQHFiK7k7uJB2B8eCYH9OsS7ttFoW+cvLu4KqJArIQvTUqC/hmx0dsXlC5oTkL
         FSwvZ6VuP7pimkMihWV2o/uifBPNaJ8toTBKd29w3EWq2Yw28zZvatKJxE9/WxlgE/2U
         ChRelj9yFW37E1Vw3eGO3rYq/RXhlMHkpdngLfOeW7+bnsUklNnez5NwOPKvWEgeYIqE
         FLLdQg9ImI2G8spBoE8MjVAcnuFeubT+6I68z3KbxgfR7UDahNMt2Ft58e15CsjgO6B/
         9wsw==
X-Gm-Message-State: APjAAAUxTH41gfyg4SuEPzQqZ5im2G99/Phtl6iWlKuI5Ssc5vPNn1LQ
        3ba7oVEMGTB2JmLNFP8KkpI3C1VIZ30=
X-Google-Smtp-Source: APXvYqzmI6bu/aF+fXadcpT0jAcGTq2LMmg5wvMVjVSBAwnNrGyynelsuFwRzlWy8KnJm71or44haA==
X-Received: by 2002:a2e:80d5:: with SMTP id r21mr1793058ljg.43.1557752077035;
        Mon, 13 May 2019 05:54:37 -0700 (PDT)
Received: from localhost.localdomain (mobile-user-2e84ba-11.dhcp.inet.fi. [46.132.186.11])
        by smtp.gmail.com with ESMTPSA id t22sm3202924lje.58.2019.05.13.05.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 05:54:36 -0700 (PDT)
From:   Janne Karhunen <janne.karhunen@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com
Cc:     Janne Karhunen <janne.karhunen@gmail.com>,
        Konsta Karsisto <konsta.karsisto@gmail.com>
Subject: [PATCH 4/5] integrity: measure the file on sync
Date:   Mon, 13 May 2019 15:53:53 +0300
Message-Id: <20190513125354.23126-5-janne.karhunen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513125354.23126-1-janne.karhunen@gmail.com>
References: <20190513125354.23126-1-janne.karhunen@gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When user requests a file sync, make sure that the IMA
measurement reflects the state of the data being sync'd.

Depends on commit c8213962517e ("integrity: keep the integrity state of open files up to date")'

Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
Signed-off-by: Konsta Karsisto <konsta.karsisto@gmail.com>
---
 fs/sync.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/sync.c b/fs/sync.c
index b54e0541ad89..90353f9ed931 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -16,6 +16,7 @@
 #include <linux/pagemap.h>
 #include <linux/quotaops.h>
 #include <linux/backing-dev.h>
+#include <linux/ima.h>
 #include "internal.h"
 
 #define VALID_FLAGS (SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE| \
@@ -194,6 +195,8 @@ int vfs_fsync_range(struct file *file, loff_t start, loff_t end, int datasync)
 		return -EINVAL;
 	if (!datasync && (inode->i_state & I_DIRTY_TIME))
 		mark_inode_dirty_sync(inode);
+	ima_file_update(file);
+
 	return file->f_op->fsync(file, start, end, datasync);
 }
 EXPORT_SYMBOL(vfs_fsync_range);
-- 
2.17.1

