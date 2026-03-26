Return-Path: <linux-integrity+bounces-9103-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKW6AJlyxWkU+QQAu9opvQ
	(envelope-from <linux-integrity+bounces-9103-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 18:53:29 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3691F339874
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 18:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D27B30BBA0E
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 17:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE76426D29;
	Thu, 26 Mar 2026 17:33:42 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC1E426D0C;
	Thu, 26 Mar 2026 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546421; cv=none; b=TyLKsoPEU9YDVxv+N9VUETRjXiJ8PrtZVJUh1Z5kFl0G57X8iVaUzm6usmOL3eDoOy+dl99AvMpI2AJceSZmDcbcFlIW9qTJQB+X+2pSIvN4QBakeDNEUJVqDAS+ikiU8qy0jO77H4L882KOnB5kAaNeOxGSQh3YqgBjcqZkTGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546421; c=relaxed/simple;
	bh=UewnchpDPH9rlidyfqY8qQbygEMlLKHIwDEcYRg9y/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPU40ZJTAotPmlZxHtNO1xl2I1D1tes0bN34JrnUWAXyeMGsbzfePg71fQuJ2LmwY6ziuC34RhHEiIkYWsJU0ZstLhDn45WodbXX27mkjqHAO8AsCq5zDVR9ISV8qMXxnXCKvsC5EnG/tT9LJFWaPqc99MAsuKQ4tU4teJN4mBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fhW4C41z5z1HCK1;
	Fri, 27 Mar 2026 01:29:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id CE99440569;
	Fri, 27 Mar 2026 01:33:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCHcu_MbcVpXmwvAQ--.1493S5;
	Thu, 26 Mar 2026 18:33:34 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	skhan@linuxfoundation.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	gregorylumen@linux.microsoft.com,
	chenste@linux.microsoft.com,
	nramas@linux.microsoft.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 13/13] doc: security: Add documentation of the IMA staging mechanism
Date: Thu, 26 Mar 2026 18:30:11 +0100
Message-ID: <20260326173011.1191815-14-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326173011.1191815-1-roberto.sassu@huaweicloud.com>
References: <20260326173011.1191815-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwCHcu_MbcVpXmwvAQ--.1493S5
X-Coremail-Antispam: 1UD129KBjvJXoW3XFW7Xw18WrWrJF1rXF4Dtwb_yoW3tr45pa
	9IgFyfCwn5Ja4xJw1rJw1xGr1ru3yfGa1UCrn3tw1xtFn8Wryvvr4akrWY9FsxKr10vrWY
	v3ZFvr45Aw4qqFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07jSiihUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAEBGnEnSsT4AAAsp
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[huaweicloud.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9103-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huaweicloud.com:mid,huawei.com:email,oracle.com:email]
X-Rspamd-Queue-Id: 3691F339874
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Roberto Sassu <roberto.sassu@huawei.com>

Add the documentation of the IMA staging mechanism in
Documentation/security/IMA-staging.rst.

Also add the missing Documentation/security/IMA-templates.rst file in
MAINTAINERS.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/IMA-staging.rst | 159 +++++++++++++++++++++++++
 Documentation/security/index.rst       |   1 +
 MAINTAINERS                            |   2 +
 3 files changed, 162 insertions(+)
 create mode 100644 Documentation/security/IMA-staging.rst

diff --git a/Documentation/security/IMA-staging.rst b/Documentation/security/IMA-staging.rst
new file mode 100644
index 000000000000..d0c27c0435c0
--- /dev/null
+++ b/Documentation/security/IMA-staging.rst
@@ -0,0 +1,159 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+IMA Measurements Staging Mechanism
+==================================
+
+
+Introduction
+============
+
+The IMA measurements list is currently stored in the kernel memory. Memory
+occupation grows linearly with the number of entries, and can become a
+problem especially in environments with reduced resources.
+
+While there is an advantage in keeping the IMA measurements list in kernel
+memory, so that it is always available for reading from the securityfs
+interfaces, storing it elsewhere would make it possible to free precious
+memory for other kernel components.
+
+Storing the IMA measurements list outside the kernel does not introduce
+security issues, since its integrity is anyway protected by the TPM.
+
+Hence, the new IMA staging mechanism is introduced to allow user space
+to remove the desired portion of the measurements list from the kernel.
+
+
+Usage
+=====
+
+The IMA staging mechanism can be enabled from the kernel configuration with
+the CONFIG_IMA_STAGING option.
+
+If it is enabled, IMA duplicates the current measurements interfaces (both
+binary and ASCII), by adding the ``_staged`` file suffix. Unlike the
+existing counterparts, the ``_staged`` interfaces have write permission for
+the root user and group, and require the process to have CAP_SYS_ADMIN set.
+
+The staging mechanism supports two flavors.
+
+
+Staging with prompt
+~~~~~~~~~~~~~~~~~~~
+
+This staging process is achieved with the following steps.
+
+ 1. ``echo A > <_staged interface>``: the user requests IMA to stage the
+    entire measurements list;
+ 2. ``cat <_staged interface>``: the user reads the staged measurements;
+ 3. ``echo D > <_staged interface>`` : the user request IMA to delete
+    staged measurements.
+
+
+Staging and deleting
+~~~~~~~~~~~~~~~~~~~~
+
+This staging process is achieved with the following steps.
+
+ 1. ``cat <_non_staged interface>``: the user reads the current
+    measurements list and determines what the value N for staging should
+    be;
+ 2. ``echo N > <_staged interface>``: the user requests IMA to delete N
+    measurements from the current measurements list.
+
+
+Interface Access
+================
+
+In order to avoid the IMA measurements list be suddenly truncated by the
+staging mechanism during a read, or having multiple concurrent staging, a
+semaphore-like locking scheme has been implemented on all the measurements
+list interfaces.
+
+Multiple readers can access concurrently the non-staged interfaces, and
+they can be in mutual exclusion with one writer accessing the staged
+interfaces.
+
+If an illegal access occurs, the open to the measurements list interface is
+denied.
+
+
+Management of Staged Measurements
+=================================
+
+Since with the staging mechanism measurements entries are removed from the
+kernel, the user needs to save the staged ones in a storage and concatenate
+them together, so that it can present them to remote attestation agents as
+if staging was never done.
+
+Coordination is necessary in the case where there are multiple actors
+requesting measurements to be staged.
+
+In the staging with prompt case, the staging interface can be accessed only
+by one actor at time, so the others will get an error until the former
+closes it. Since the actors don't care about N, when they gain access to
+the interface, they will get all the staged measurements at the time of
+their request.
+
+In the case of staging and deleting, coordination is more important, since
+there is the risk that two actors unaware of each other compute the value N
+on the current measurements list and request IMA to stage N twice.
+
+
+Remote Attestation Agent Workflow
+=================================
+
+Users can choose the staging method they find more appropriate for their
+workflow.
+
+If, as an example, a remote attestation agent would like to present to the
+remote attestation server only the measurements that are required to
+verify the TPM quote, its workflow would be the following.
+
+With staging with prompt, the agent stages the current measurements list,
+reads and stores the measurements in a storage and immediately requests
+IMA to delete the staged measurements from kernel memory. Afterwards, it
+calculates N by replaying the PCR extend on the stored measurements until
+the calculated PCRs match the quoted PCRs. It then keeps the measurements
+in excess for the next attestation request.
+
+At the next attestation request, the agent performs the same steps above,
+and concatenates the new measurements to the ones in excess from the
+previous request. Also in this case, the agent replays the PCR extend until
+it matches the currently quoted PCRs, keeps the measurements in excess and
+presents the new N measurements entries to the remote attestation server.
+
+With the staging with deleting method, the agents reads the current
+measurements list, calculates N and requests IMA to delete only those. The
+measurements in excess are kept in the IMA measurements list and can be
+retrieved at the next remote attestation request.
+
+Kexec
+=====
+
+In the event a kexec() system call occurs between staging and deleting, the
+staged measurements entries are prepended to the current measurements lists,
+so that they are both available when the secondary kernel starts. In that
+case, IMA returns an error to the user when attempting to delete staged
+measurements to notify about their copy to the kexec buffer, so that the
+user does not store them twice.
+
+
+Hash table
+==========
+
+By default, the template digest of staged measurement entries are kept in
+kernel memory (only template data are freed), to be able to detect
+duplicate entries independently of staging.
+
+The new kernel option ``ima_flush_htable`` has been introduced to
+explicitly request a complete deletion of the staged measurements, for
+maximum kernel memory saving. If the option has been specified, duplicate
+entries are still avoided on entries of the current measurements list,
+but there can be duplicates between different groups of staged
+measurements.
+
+Flushing the hash table is supported only for the staging with prompt
+flavor. For the staging and deleting flavor, it would have been necessary
+to lock the hot path adding new measurements for the time needed to remove
+each staged measurement individually.
diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index 3e0a7114a862..cec064dc1c83 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -8,6 +8,7 @@ Security Documentation
    credentials
    snp-tdx-threat-model
    IMA-templates
+   IMA-staging
    keys/index
    lsm
    lsm-development
diff --git a/MAINTAINERS b/MAINTAINERS
index 04823afa8b74..e78dfb4f4482 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12668,6 +12668,8 @@ R:	Eric Snowberg <eric.snowberg@oracle.com>
 L:	linux-integrity@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
+F:	Documentation/security/IMA-staging.rst
+F:	Documentation/security/IMA-templates.rst
 F:	include/linux/secure_boot.h
 F:	security/integrity/
 F:	security/integrity/ima/
-- 
2.43.0


