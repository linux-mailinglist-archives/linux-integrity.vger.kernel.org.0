Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32FF3A5354
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Sep 2019 11:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfIBJt3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Sep 2019 05:49:29 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46591 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731046AbfIBJt3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Sep 2019 05:49:29 -0400
Received: by mail-lf1-f68.google.com with SMTP id n19so9918894lfe.13;
        Mon, 02 Sep 2019 02:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k2z623VUchf7dmtqaMObbgBBjHMdeVEZr8ifyE6cuHk=;
        b=bda+Pq49ZaMyZ6CEUMoT3fIyEh6zav/dR6ldS9zbSe/FrYsD0HCe5Zln86t8joUO8w
         QutUneK+4J9JCMISfTsq1SsCGREtR83s6He7IH7XibySlaRZ2Pi9RGLB8BFdEii7d00+
         LUDueinKYAYAfYzqP5pma+V4b8QEq8ojkJ4QbU6u0LlKWpXgjuhUQqrRoWiOWeJ8te8Q
         3OOOG3OqANxeMhRy6zfdGTeuVFreb9yu5JzIvFAje+6KiG/8qPbw/+ftFgBi7QzL2fhM
         hWtO7lvp9KnnkedASb2/miDK9u43jOqF//6+GpL2ygQ0o/l8OYK+2q10ak2jl+UCKhXc
         f5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k2z623VUchf7dmtqaMObbgBBjHMdeVEZr8ifyE6cuHk=;
        b=JN6m619DKrTQvXdOPaNAt0Qkizhu3IB58bqQY2evt9Pf6GXE4sqxNlxPNA3UnAOQAx
         uDnb/Nk/xbuGIPWFFUheGZU1Cnbpa7s/CDRZKsFH7hjP7sX0r5O1we4d3Wh/GlJMbZ37
         g3Yi1wfPJTLHhxBIfjaCEq4UxJ+mL9PGq/GYh0FhGvxhovjOPXcIK+F1LgSbbHTUTw2t
         htgzWCsZEohvkqRnQZfhu/M1AGIEgMwALFZztzgAQbD9Drbns1PAIcckNQTtxHTNTa4k
         dj+4FKmjsnT6w8C5dshqWDoABxxYIv2uyFbfL98nDcX0u2HxDP3m93FJLoofYu0M1QCA
         cYXA==
X-Gm-Message-State: APjAAAV0g8q+oNutVov9scF5BbpCqliAD76xQ+IJpe3/kA3zJn46rsTi
        Ar04ds5cq3iKN7b7G2tch9iwFKFDUuw=
X-Google-Smtp-Source: APXvYqx/iUItC4YvD87H8Wb2U1ObFRvxrcV97Xh4Z56hWqhd8c+J/kBMLQ14dtNrD2hfhoFjtmpihA==
X-Received: by 2002:ac2:5297:: with SMTP id q23mr9787630lfm.78.1567417767019;
        Mon, 02 Sep 2019 02:49:27 -0700 (PDT)
Received: from localhost.localdomain (mobile-user-2e84ba-175.dhcp.inet.fi. [46.132.186.175])
        by smtp.gmail.com with ESMTPSA id h1sm771635lja.18.2019.09.02.02.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 02:49:26 -0700 (PDT)
From:   Janne Karhunen <janne.karhunen@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com,
        linux-mm@kvack.org, viro@zeniv.linux.org.uk
Cc:     Janne Karhunen <janne.karhunen@gmail.com>,
        Konsta Karsisto <konsta.karsisto@gmail.com>
Subject: [PATCH 2/3] ima: update the file measurement on truncate
Date:   Mon,  2 Sep 2019 12:45:39 +0300
Message-Id: <20190902094540.12786-2-janne.karhunen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190902094540.12786-1-janne.karhunen@gmail.com>
References: <20190902094540.12786-1-janne.karhunen@gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Let IMA know when a file is being opened with truncate
or truncated directly.

Depends on commit 72649b7862a7 ("ima: keep the integrity state of open files up to date")'

Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
Signed-off-by: Konsta Karsisto <konsta.karsisto@gmail.com>
---
 fs/namei.c | 5 ++++-
 fs/open.c  | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 209c51a5226c..0994fe26bef1 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3418,8 +3418,11 @@ static int do_last(struct nameidata *nd,
 		goto out;
 opened:
 	error = ima_file_check(file, op->acc_mode);
-	if (!error && will_truncate)
+	if (!error && will_truncate) {
 		error = handle_truncate(file);
+		if (!error)
+			ima_file_update(file);
+	}
 out:
 	if (unlikely(error > 0)) {
 		WARN_ON(1);
diff --git a/fs/open.c b/fs/open.c
index a59abe3c669a..98c2d4629371 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -63,6 +63,9 @@ int do_truncate(struct dentry *dentry, loff_t length, unsigned int time_attrs,
 	/* Note any delegations or leases have already been broken: */
 	ret = notify_change(dentry, &newattrs, NULL);
 	inode_unlock(dentry->d_inode);
+
+	if (filp)
+		ima_file_update(filp);
 	return ret;
 }
 
-- 
2.17.1

