Return-Path: <linux-integrity+bounces-9807-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id scGsN8tWNGo2VQYAu9opvQ
	(envelope-from <linux-integrity+bounces-9807-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2026 22:36:27 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 478BD6A2963
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2026 22:36:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=h8eWgbdY;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9807-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9807-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF8E43079CA0
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2026 20:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EAF34F46F;
	Thu, 18 Jun 2026 20:34:22 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872A434FF78
	for <linux-integrity@vger.kernel.org>; Thu, 18 Jun 2026 20:34:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814862; cv=none; b=DYh5nmgm3jNli0gN6Q+gElFw9Q+L5CnnFeMlFiH6mDX8CPOz3ZLIH6X2T3hHknwbmU6opHHTTYUvKKo2nPun0EIpbDBWOsufN4j/IQgsHsncgLMx+K/A3aTAMa+ppP8UEdSEHxzJoUmV+i12xINNf6L2sRhaDlVyoVufKCjy0mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814862; c=relaxed/simple;
	bh=r4h8PrTc14+Jb9KVCjREjZqooDGZDEoHV/lbqWozPiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbIKWYz+qDc4lsox2K7I4BgZCooP2hvscbXRTP6sfXNtUel3JqenVFPXLdGfM4W+bkSbtJh8GXnRTe4E3hrOfL6bMLLu2pUp152tGkMxMTLUmNBa8jj8Cm51k8NWwTHZSdkT+44LnL/WBWQfPJBj/Ht5mrOdKKGijkdtQ7wRJBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8eWgbdY; arc=none smtp.client-ip=209.85.160.182
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-519e7faecf1so1021691cf.0
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jun 2026 13:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781814858; x=1782419658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RMN0VH8IUwxnA/+jZ+RRwIijY8+Uf8ufr9lR4CaAaM=;
        b=h8eWgbdYfhT2dD7tpv5RKpSig598hqCPw+srqbVABP75cvdSdnl7WtCxvemAWxJ5tI
         96eDRhNGgHwxfFkEYuKgEAfGw6yWD0Y65KWH0vl1Ttn+1V3LaKhDt7HCm51KW0bFl2TI
         MhkH9GfrgbMVjoynjBC5YRP3kRk/DZtRm1JxDtWkELlz5QRLY4u/k05x/utxY/uPAi9y
         Qw4lEb8FDfDcXdZoyOFlb6mFa094pBXiDAMfxLu0EGuOOzt3IxWa4GG6FIiqbSyY0v43
         nnZRdnEE0eSxI79FWcEV2+q6FYPmw86L5AEsHKeC3K+8RwV+Ibx8GDQLHgppsydbzivB
         rpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781814858; x=1782419658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6RMN0VH8IUwxnA/+jZ+RRwIijY8+Uf8ufr9lR4CaAaM=;
        b=QaSuktu3B4Ao6OwaVkj00oKHro4GAkomYaotDWFo4FZaI8YoZCN7WNKcx8jNqKU6lG
         yMNpryF7PicoTERJw1wxh44BSyamuoxGOlCODUphVqoLzlJuEHNVPEARWTWn8mCF8SZ2
         Ilk8n0LqrXjm5vEUTtuom1WTrRisvxhwU0Er/ch5hmaY+3XyA1D9AfYejIyJqwWO5k1x
         5m/cOU9KBco87U95V0NwGJMtOI1WVgjbzI+9tah4jTxobnscSy07RhWWwFz/NvEH5J7q
         A3PAty6zvwf1TvFjVdG1ylFfdyK/XIPk190h72PFsr9K5qtEAGvNar3GNpk+cm0yOEcm
         27Qg==
X-Forwarded-Encrypted: i=1; AFNElJ9IE0VlAcOJCdcbNA53ZxT+t6HW2V0miVr80S45DQ6FXQSn8+nWO2ZNzlfTeoApWVYt95X2A7vF9Yz49wLlE1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1eNEo87GKAzunCeK2ZuQfCBperzT+GEryxBG6Kk/x03DKuR2V
	y0pFEH6qwwS19TztdYMBUoLRPvglrUzWo9qlh+BIn0a8wNclkFIsLN8z
X-Gm-Gg: AfdE7clGXph0e+xQ/HTPNfjyWcibVSqXyk4ZXQGEdzth94OYV76vQqJQ+5g6xvLI5oM
	LYrJcuYSPEvktDq4TPC9Y24slzEJ3aEyEEHv4CEjorsXZFRI0wym9Wro1CFnycfM8g9MUFsRVJJ
	oGittnyrGnbk/MIR0LFSJLOml/jKlqjuzpH0NhGLUqcB37Hl0J5pwbY5dJVfOMrf1Y8/konh6Zm
	91xyaYdA/Z7gOHsKaEUJz+4LD/qj+whNc6kADR1XH87ze+b4zeZACOcy74ge8Ua39tYj17YuSag
	K/+qfrevIQCfEJ8S1siQ2k07uhvMQHJLSOLjZBS/acX4VIYdGjfy+aADJzvkbmLuN2EZRfCIs30
	BlL7ypFWkNb4V8qESD50JkNUk8gOjGaaCklIwc/IKuF4P985Bog7/YfA3UrdynqZYgieOw6BF+i
	6Xy0GupBP61uzz+arDpa5WQvt0b9QLOIzoCAO1W5eSebB2M2mBltHATlIq/kq3Ygky/P8v2/hhZ
	Sbx/6/DsSe4jbqBYGnJkDXcow==
X-Received: by 2002:a05:622a:14:b0:516:e249:e30f with SMTP id d75a77b69052e-519e4c94b36mr11943751cf.42.1781814858266;
        Thu, 18 Jun 2026 13:34:18 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8de5e12d1c3sm2176166d6.10.2026.06.18.13.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 13:34:17 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	casey@schaufler-ca.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: add tests for bpf_init_inode_xattr kfunc
Date: Thu, 18 Jun 2026 16:34:11 -0400
Message-ID: <20260618203411.73917-3-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618203411.73917-1-dwindsor@gmail.com>
References: <20260618203411.73917-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9807-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,google.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,oracle.com,redhat.com,schaufler-ca.com];
	FORGED_SENDER(0.00)[dwindsor@gmail.com,linux-integrity@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:kpsingh@kernel.org,m:mattbobrowski@google.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:casey@schaufler-ca.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:dwindsor@gmail.com,m:johnfastabend@gmail.com,m:dmitrykasatkin@gmail.com,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwindsor@gmail.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 478BD6A2963

Test bpf atomic inode xattr labeling in inode_init_security.

Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 105 +++++++++++++++++-
 .../bpf/progs/test_init_inode_xattr.c         |  31 ++++++
 3 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_init_inode_xattr.c

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index ae71e9b69051..69d3641ee2d8 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -92,4 +92,9 @@ extern int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__str,
 				const struct bpf_dynptr *value_p, int flags) __ksym __weak;
 extern int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name__str) __ksym __weak;
 
+struct xattr_ctx;
+extern int bpf_init_inode_xattr(struct xattr_ctx *xattr_ctx,
+				const char *name__str,
+				const struct bpf_dynptr *value_p) __ksym __weak;
+
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
index 43a26ec69a8e..0898898fb125 100644
--- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
@@ -9,9 +9,10 @@
 #include <test_progs.h>
 #include "test_get_xattr.skel.h"
 #include "test_set_remove_xattr.skel.h"
+#include "test_init_inode_xattr.skel.h"
 #include "test_fsverity.skel.h"
 
-static const char testfile[] = "/tmp/test_progs_fs_kfuncs";
+static const char testfile[] = "/tmp/labelme";
 
 static void test_get_xattr(const char *name, const char *value, bool allow_access)
 {
@@ -268,6 +269,102 @@ static void test_fsverity(void)
 	remove(testfile);
 }
 
+static void test_init_inode_xattr(void)
+{
+	struct test_init_inode_xattr *skel = NULL;
+	int fd = -1, err;
+	char value_out[64];
+	const char *testfile_new = "/tmp/test_progs_fs_kfuncs_new";
+
+	skel = test_init_inode_xattr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_init_inode_xattr__open_and_load"))
+		return;
+
+	skel->bss->monitored_pid = getpid();
+	err = test_init_inode_xattr__attach(skel);
+	if (!ASSERT_OK(err, "test_init_inode_xattr__attach"))
+		goto out;
+
+	/* Trigger inode_init_security */
+	fd = open(testfile_new, O_CREAT | O_RDWR, 0644);
+	if (!ASSERT_GE(fd, 0, "create_file"))
+		goto out;
+
+	ASSERT_EQ(skel->data->init_result, 0, "init_result");
+
+	/* initxattrs prepends "security." to the name. */
+	err = getxattr(testfile_new, "security.bpf.test_label", value_out,
+		       sizeof(value_out));
+	if (err < 0 && errno == ENODATA) {
+		printf("%s:SKIP:filesystem did not apply LSM xattrs\n",
+		       __func__);
+		test__skip();
+		goto out;
+	}
+	if (!ASSERT_GE(err, 0, "getxattr"))
+		goto out;
+
+	ASSERT_EQ(err, (int)sizeof(skel->data->xattr_value), "xattr_size");
+	ASSERT_EQ(strncmp(value_out, "unconfined_u:object_r:user_home_t:s0",
+			  sizeof("unconfined_u:object_r:user_home_t:s0")), 0,
+		  "xattr_value");
+
+out:
+	close(fd);
+	test_init_inode_xattr__destroy(skel);
+	remove(testfile_new);
+}
+
+/* Keep in sync with BPF_LSM_INODE_INIT_XATTRS in include/linux/bpf_lsm.h. */
+#define INIT_INODE_XATTR_MAX 4
+
+/* At most INIT_INODE_XATTR_MAX programs can attach to inode_init_security. */
+static void test_init_inode_xattr_attach_cap(void)
+{
+	struct test_init_inode_xattr *skel[INIT_INODE_XATTR_MAX + 1] = {};
+	struct bpf_link *link[INIT_INODE_XATTR_MAX + 1] = {};
+	struct bpf_link *extra = NULL;
+	int i, err;
+
+	/* Fill all available xattr slots */
+	for (i = 0; i < INIT_INODE_XATTR_MAX; i++) {
+		skel[i] = test_init_inode_xattr__open_and_load();
+		if (!ASSERT_OK_PTR(skel[i], "open_and_load"))
+			goto out;
+
+		link[i] = bpf_program__attach_lsm(skel[i]->progs.test_init_inode_xattr);
+		if (!ASSERT_OK_PTR(link[i], "attach_within_cap"))
+			goto out;
+	}
+
+	skel[INIT_INODE_XATTR_MAX] = test_init_inode_xattr__open_and_load();
+	if (!ASSERT_OK_PTR(skel[INIT_INODE_XATTR_MAX], "open_and_load_extra"))
+		goto out;
+
+	/* New additions fail with -E2BIG */
+	extra = bpf_program__attach_lsm(skel[INIT_INODE_XATTR_MAX]->progs.test_init_inode_xattr);
+	err = -errno;
+	if (!ASSERT_ERR_PTR(extra, "attach_over_cap_should_fail")) {
+		bpf_link__destroy(extra);
+		goto out;
+	}
+	ASSERT_EQ(err, -E2BIG, "attach_over_cap_errno");
+
+	bpf_link__destroy(link[0]);
+	link[0] = NULL; /* avoid double free in cleanup */
+
+	/* Freeing a slot lets the extra program attach */
+	extra = bpf_program__attach_lsm(skel[INIT_INODE_XATTR_MAX]->progs.test_init_inode_xattr);
+	ASSERT_OK_PTR(extra, "attach_after_detach");
+
+out:
+	bpf_link__destroy(extra);
+	for (i = 0; i <= INIT_INODE_XATTR_MAX; i++) {
+		bpf_link__destroy(link[i]);
+		test_init_inode_xattr__destroy(skel[i]);
+	}
+}
+
 void test_fs_kfuncs(void)
 {
 	/* Matches xattr_names in progs/test_get_xattr.c */
@@ -286,6 +383,12 @@ void test_fs_kfuncs(void)
 	if (test__start_subtest("set_remove_xattr"))
 		test_set_remove_xattr();
 
+	if (test__start_subtest("init_inode_xattr"))
+		test_init_inode_xattr();
+
+	if (test__start_subtest("init_inode_xattr_attach_cap"))
+		test_init_inode_xattr_attach_cap();
+
 	if (test__start_subtest("fsverity"))
 		test_fsverity();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_init_inode_xattr.c b/tools/testing/selftests/bpf/progs/test_init_inode_xattr.c
new file mode 100644
index 000000000000..6f0e8b02ff88
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_init_inode_xattr.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Cisco Systems, Inc. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+__u32 monitored_pid;
+int init_result = -1;
+
+static const char xattr_name[] = "bpf.test_label";
+char xattr_value[] = "unconfined_u:object_r:user_home_t:s0";
+
+SEC("lsm.s/inode_init_security")
+int BPF_PROG(test_init_inode_xattr, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, struct xattr_ctx *xattr_ctx)
+{
+	struct bpf_dynptr value_ptr;
+	__u32 pid;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid != monitored_pid)
+		return 0;
+
+	bpf_dynptr_from_mem(xattr_value, sizeof(xattr_value), 0, &value_ptr);
+	init_result = bpf_init_inode_xattr(xattr_ctx, xattr_name, &value_ptr);
+
+	return 0;
+}
-- 
2.53.0


