Return-Path: <linux-integrity+bounces-2657-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D76B68D06A6
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 17:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071E91C2223A
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 15:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED71A13B29B;
	Mon, 27 May 2024 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1llqXXV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C056B13AD05;
	Mon, 27 May 2024 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825108; cv=none; b=SsQzVGpzdpG5JDNg9GgWZg/2KLzsVQjk7tElwCgL6Pe6oyieE/2XqMMEW1KoG1kZG0FEEAOTjG0b+2gA9YtUbRXoFraB4l35tiJarYUhlJduX0BMYoFhCaxYwyB9puC/hKBBiGHbXbWy+MQBUXHqtE5S9rnbo0gl0gRw1g/LgeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825108; c=relaxed/simple;
	bh=j2rKURWHsVnV6Ucey0Bt0igo2eVco9EQuuWG5rZz4V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kX1nXgiWc5sOPIWAkS9ceF9p75xYEvp+kKtzGlDq+UB6SAVA/ekHshZwpON7dmb86nqhKkuOFKn4k5R/Wrugd+o1I7Y+G/nspIXCdjLZZwfe0aC9H2tIh+7DTR21wTRmL/wBoYuikZptO3utD9/O2FExPNtQIsv6wNPoVLYzvpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1llqXXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA49C2BBFC;
	Mon, 27 May 2024 15:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825108;
	bh=j2rKURWHsVnV6Ucey0Bt0igo2eVco9EQuuWG5rZz4V4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b1llqXXViRopiOmh21n+DKij66OdegYaZ2RLGkpB2oagknI/Ovyur5uC9J4clazZH
	 SviEBqhVNsvGQB6Wq2cfPeyP7nepAIare3kamx1zpQO9g6RRIAxjkAO9bkDDfGznyJ
	 2YlRNCMIy1GpZn/E1XIT4JLQLkxFwGOQFctIIIFpsqrPF+OAu6ARBG/w5nKchvohrs
	 JmytXZugnW9epma6eStzu7EwEBEl8agEozD3Wh4H0m5wu8BqcSX/otDdgMcUjjsWSq
	 uCU8ZONbpSuYt/H+Pjv35RLIFZLTyHqKoyKWeZBR1fzvdKcjLsaYtd7t3tsxXPlKbg
	 s3FKiu2uKL5Og==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 04/23] ima: Fix use-after-free on a dentry's dname.name
Date: Mon, 27 May 2024 11:50:05 -0400
Message-ID: <20240527155123.3863983-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155123.3863983-1-sashal@kernel.org>
References: <20240527155123.3863983-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
Content-Transfer-Encoding: 8bit

From: Stefan Berger <stefanb@linux.ibm.com>

[ Upstream commit be84f32bb2c981ca670922e047cdde1488b233de ]

->d_name.name can change on rename and the earlier value can be freed;
there are conditions sufficient to stabilize it (->d_lock on dentry,
->d_lock on its parent, ->i_rwsem exclusive on the parent's inode,
rename_lock), but none of those are met at any of the sites. Take a stable
snapshot of the name instead.

Link: https://lore.kernel.org/all/20240202182732.GE2087318@ZenIV/
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/ima/ima_api.c          | 16 ++++++++++++----
 security/integrity/ima/ima_template_lib.c | 17 ++++++++++++++---
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index b37d043d5748c..1856981e33df3 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -245,8 +245,8 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 	const char *audit_cause = "failed";
 	struct inode *inode = file_inode(file);
 	struct inode *real_inode = d_real_inode(file_dentry(file));
-	const char *filename = file->f_path.dentry->d_name.name;
 	struct ima_max_digest_data hash;
+	struct name_snapshot filename;
 	struct kstat stat;
 	int result = 0;
 	int length;
@@ -317,9 +317,13 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 		if (file->f_flags & O_DIRECT)
 			audit_cause = "failed(directio)";
 
+		take_dentry_name_snapshot(&filename, file->f_path.dentry);
+
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
-				    filename, "collect_data", audit_cause,
-				    result, 0);
+				    filename.name.name, "collect_data",
+				    audit_cause, result, 0);
+
+		release_dentry_name_snapshot(&filename);
 	}
 	return result;
 }
@@ -432,6 +436,7 @@ void ima_audit_measurement(struct ima_iint_cache *iint,
  */
 const char *ima_d_path(const struct path *path, char **pathbuf, char *namebuf)
 {
+	struct name_snapshot filename;
 	char *pathname = NULL;
 
 	*pathbuf = __getname();
@@ -445,7 +450,10 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *namebuf)
 	}
 
 	if (!pathname) {
-		strscpy(namebuf, path->dentry->d_name.name, NAME_MAX);
+		take_dentry_name_snapshot(&filename, path->dentry);
+		strscpy(namebuf, filename.name.name, NAME_MAX);
+		release_dentry_name_snapshot(&filename);
+
 		pathname = namebuf;
 	}
 
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 6cd0add524cdc..3b2cb8f1002e6 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -483,7 +483,10 @@ static int ima_eventname_init_common(struct ima_event_data *event_data,
 				     bool size_limit)
 {
 	const char *cur_filename = NULL;
+	struct name_snapshot filename;
 	u32 cur_filename_len = 0;
+	bool snapshot = false;
+	int ret;
 
 	BUG_ON(event_data->filename == NULL && event_data->file == NULL);
 
@@ -496,7 +499,10 @@ static int ima_eventname_init_common(struct ima_event_data *event_data,
 	}
 
 	if (event_data->file) {
-		cur_filename = event_data->file->f_path.dentry->d_name.name;
+		take_dentry_name_snapshot(&filename,
+					  event_data->file->f_path.dentry);
+		snapshot = true;
+		cur_filename = filename.name.name;
 		cur_filename_len = strlen(cur_filename);
 	} else
 		/*
@@ -505,8 +511,13 @@ static int ima_eventname_init_common(struct ima_event_data *event_data,
 		 */
 		cur_filename_len = IMA_EVENT_NAME_LEN_MAX;
 out:
-	return ima_write_template_field_data(cur_filename, cur_filename_len,
-					     DATA_FMT_STRING, field_data);
+	ret = ima_write_template_field_data(cur_filename, cur_filename_len,
+					    DATA_FMT_STRING, field_data);
+
+	if (snapshot)
+		release_dentry_name_snapshot(&filename);
+
+	return ret;
 }
 
 /*
-- 
2.43.0


