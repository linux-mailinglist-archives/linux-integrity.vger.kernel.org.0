Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED361B67B
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2019 14:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbfEMMyk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 May 2019 08:54:40 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33471 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730034AbfEMMyk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 May 2019 08:54:40 -0400
Received: by mail-lf1-f67.google.com with SMTP id x132so8990026lfd.0;
        Mon, 13 May 2019 05:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bpMSvjltOUBlj6ILO+9LtMa6iMJna4vA44ohQNnfYy8=;
        b=OAdORtiP1OrPa74FypH7T44CXyJViT7H0BqwCh/WMEmFoRSlGIQf8mmxpk/+e37Wmx
         WTmR1+YMmaYBXlq8gX1wMghaZMvw6vORA3QFGX6MYca+HvW6UVY82WOgy4HzAvjtuUtE
         Mc4dp5fA+EFeZfkXpasbq1PVp9fi5oZaTs4rSSB9FuXE5aRhx99dE/VSRWxsajb+wwh2
         w21XPH0ghgioje+uounfFB4fb8SzJVJGmWzaDXY0b/EDMA1uz9NNJEljLHud8vCM7wYE
         /TnNjcCmHssxCybLEETPvW1WqYyV7R4jsnDHTTO92VnO0DJhbCzhj2gwk2+1LPn6X8lt
         OH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bpMSvjltOUBlj6ILO+9LtMa6iMJna4vA44ohQNnfYy8=;
        b=sgMMUwvgCCGtYB31Y+9I4EAKvCymiSHQCVgJgcZ35Zz42Xdfc/TD7AIWb5RClBh4G0
         Ty2GFbK+Yub7KV76DnX6zdyDKK9D9sFy5ytUBB4nlmV2u06lP9dcYhAPJVW3VVy0Bnlm
         0gKRBNrNnve7JNdNf1L09u0hL7mbGkSvKf0Ase2SyCW4R/hoH1s9IHyTvQeatJMRfVzA
         bbZfPZrsJKI9rmu+pKMbkndgqzFywKHomRL3rrraq28guaUHlCw1lWrt5Z3vIwabhXVQ
         2CbeGwDS7L4pRSlq3bOsUdRUe5joRdaREHm7A2c9s6fKOSSGADcmTnEAWex60JPWtTtH
         cK6A==
X-Gm-Message-State: APjAAAULxn49pZkAK41ghWKmlKmh6D0RL3vdQ4RStTObMF2sDD0O7S5h
        ruYHJ7+ACR+VjVGUUM1YsWx8Qe2bue8=
X-Google-Smtp-Source: APXvYqxaU93pAwRo1pF2T0rPh0blRlPymNqN4eGeRs0hM0thtRyzyqHsfvpx9Qhpgumdf00bzHJ1kQ==
X-Received: by 2002:a19:ca0e:: with SMTP id a14mr13347671lfg.3.1557752078166;
        Mon, 13 May 2019 05:54:38 -0700 (PDT)
Received: from localhost.localdomain (mobile-user-2e84ba-11.dhcp.inet.fi. [46.132.186.11])
        by smtp.gmail.com with ESMTPSA id t22sm3202924lje.58.2019.05.13.05.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 05:54:37 -0700 (PDT)
From:   Janne Karhunen <janne.karhunen@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com
Cc:     Janne Karhunen <janne.karhunen@gmail.com>,
        Konsta Karsisto <konsta.karsisto@gmail.com>
Subject: [PATCH 5/5] integrity: measure the file on msync
Date:   Mon, 13 May 2019 15:53:54 +0300
Message-Id: <20190513125354.23126-6-janne.karhunen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513125354.23126-1-janne.karhunen@gmail.com>
References: <20190513125354.23126-1-janne.karhunen@gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When user requests a file msync, make sure that the IMA
measurement reflects the state of the data being sync'd.

Depends on commit c8213962517e ("integrity: keep the integrity state of open files up to date")'

Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
Signed-off-by: Konsta Karsisto <konsta.karsisto@gmail.com>
---
 mm/msync.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/msync.c b/mm/msync.c
index ef30a429623a..5a256e08b49d 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -14,6 +14,7 @@
 #include <linux/file.h>
 #include <linux/syscalls.h>
 #include <linux/sched.h>
+#include <linux/ima.h>
 
 /*
  * MS_SYNC syncs the entire file - including mappings.
@@ -88,12 +89,18 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, len, int, flags)
 			get_file(file);
 			up_read(&mm->mmap_sem);
 			error = vfs_fsync_range(file, fstart, fend, 1);
+			if (!error)
+				ima_file_update(file);
+
 			fput(file);
 			if (error || start >= end)
 				goto out;
 			down_read(&mm->mmap_sem);
 			vma = find_vma(mm, start);
 		} else {
+			if (file)
+				ima_delayed_update(file);
+
 			if (start >= end) {
 				error = 0;
 				goto out_unlock;
-- 
2.17.1

