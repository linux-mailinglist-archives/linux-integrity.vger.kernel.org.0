Return-Path: <linux-integrity+bounces-783-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDF482DF10
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jan 2024 19:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2695F283582
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jan 2024 18:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A67A182DA;
	Mon, 15 Jan 2024 18:19:24 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAF5182AF;
	Mon, 15 Jan 2024 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TDKm72nGkz9xGn0;
	Tue, 16 Jan 2024 02:04:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id BEDDA1407FA;
	Tue, 16 Jan 2024 02:19:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAXBCjzdqVl8DKbAA--.57127S4;
	Mon, 15 Jan 2024 19:19:10 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	dhowells@redhat.com,
	jarkko@kernel.org,
	stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
	casey@schaufler-ca.com,
	shuah@kernel.org,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v9 02/25] ima: Align ima_file_mprotect() definition with LSM infrastructure
Date: Mon, 15 Jan 2024 19:17:46 +0100
Message-Id: <20240115181809.885385-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwAXBCjzdqVl8DKbAA--.57127S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAryfJr4DurWftryDAr43Jrb_yoW5ZFWkpa
	n8KasrGrWxJFy09r97ZFW7ua43K3yIgw1UXa9ag340vFn0qFnYqr13AFy8ur1rZr9YyFn2
	y3y7trW5A3WDtrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFa9-UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBF1jj5iRxQABs6

From: Roberto Sassu <roberto.sassu@huawei.com>

Change ima_file_mprotect() definition, so that it can be registered
as implementation of the file_mprotect hook.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/ima.h               | 5 +++--
 security/integrity/ima/ima_main.c | 6 ++++--
 security/security.c               | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 910a2f11a906..b66353f679e8 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -23,7 +23,8 @@ extern void ima_post_create_tmpfile(struct mnt_idmap *idmap,
 extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long reqprot,
 			 unsigned long prot, unsigned long flags);
-extern int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot);
+extern int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
+			     unsigned long prot);
 extern int ima_load_data(enum kernel_load_data_id id, bool contents);
 extern int ima_post_load_data(char *buf, loff_t size,
 			      enum kernel_load_data_id id, char *description);
@@ -84,7 +85,7 @@ static inline int ima_file_mmap(struct file *file, unsigned long reqprot,
 }
 
 static inline int ima_file_mprotect(struct vm_area_struct *vma,
-				    unsigned long prot)
+				    unsigned long reqprot, unsigned long prot)
 {
 	return 0;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index cc1217ac2c6f..b3f5e8401056 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -455,7 +455,8 @@ int ima_file_mmap(struct file *file, unsigned long reqprot,
 /**
  * ima_file_mprotect - based on policy, limit mprotect change
  * @vma: vm_area_struct protection is set to
- * @prot: contains the protection that will be applied by the kernel.
+ * @reqprot: protection requested by the application
+ * @prot: protection that will be applied by the kernel
  *
  * Files can be mmap'ed read/write and later changed to execute to circumvent
  * IMA's mmap appraisal policy rules.  Due to locking issues (mmap semaphore
@@ -465,7 +466,8 @@ int ima_file_mmap(struct file *file, unsigned long reqprot,
  *
  * On mprotect change success, return 0.  On failure, return -EACESS.
  */
-int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
+int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
+		      unsigned long prot)
 {
 	struct ima_template_desc *template = NULL;
 	struct file *file;
diff --git a/security/security.c b/security/security.c
index 013c847b28d0..0608679478ea 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2837,7 +2837,7 @@ int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 	ret = call_int_hook(file_mprotect, 0, vma, reqprot, prot);
 	if (ret)
 		return ret;
-	return ima_file_mprotect(vma, prot);
+	return ima_file_mprotect(vma, reqprot, prot);
 }
 
 /**
-- 
2.34.1


