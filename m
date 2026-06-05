Return-Path: <linux-integrity+bounces-9765-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ePIuG/UOI2p9hQEAu9opvQ
	(envelope-from <linux-integrity+bounces-9765-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Jun 2026 20:01:25 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7AD64A653
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Jun 2026 20:01:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9765-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9765-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9B7A308B9F2
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jun 2026 17:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EA42E1C4E;
	Fri,  5 Jun 2026 17:25:55 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C092F7EE1;
	Fri,  5 Jun 2026 17:25:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680355; cv=none; b=kRzgDWwo52p816CCBg+MlZLjG6xJ7zhFO6yyDWyboO4QCNewjtH8kP5mLKJttwOqeK9S3KBdviOsEuWLDD9f7htmGuYbPKsc+5UhgP7hS5iOopeiuoLNd5At4ovLIsAldpgykbGcMZsDIo10Xt7bpfGCAHYFblPPJjn0cRgxwbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680355; c=relaxed/simple;
	bh=L0gUMkOe3CEUdn9+ggxOpmkji8Fi1cuMFRNBlHHMXgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kx7KxEIAxNJK56YQoBL+u4/c205v8nU80K19n5Hdy1UyvsKdXncuPkNXO1nXmCAbS7HamViQQsPY9crgGBxyVhBWt0vytmGOafz9rENvmIyCj3p0MbIQUVmeYelblS+tHq+0RATTh1InFsJJQxzkkMC7e7o8e0bnXBKXsAB+bJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gX7W20GvKzsT0g;
	Sat,  6 Jun 2026 01:20:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 35BFA40572;
	Sat,  6 Jun 2026 01:25:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCXWY9+BiNqCg9lAA--.44013S4;
	Fri, 05 Jun 2026 18:25:44 +0100 (CET)
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
Subject: [PATCH v7 12/12] doc: security: Add documentation of exporting and deleting IMA measurements
Date: Fri,  5 Jun 2026 19:22:36 +0200
Message-ID: <20260605172236.2042045-13-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605172236.2042045-1-roberto.sassu@huaweicloud.com>
References: <20260605172236.2042045-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwCXWY9+BiNqCg9lAA--.44013S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Cr48GrW7JFWrJF4UJFW8JFb_yoWDKw1rpa
	9aga4Ikwn5Ja4fAw1kJw1xJr4rZ3yrKa1UGrn3Jw1xAFn8Wryvyr4akrWY9FZxKr1vvryj
	v3ZFvr45Aa1qqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07Ud5rcUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBGoiOzcKlQAAsS
X-Rspamd-Action: add header
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:from_mime,huaweicloud.com:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-9765-lists,linux-integrity=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_RECIPIENTS(0.00)[m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:zohar@linux.ibm.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:gregorylumen@linux.microsoft.com,m:chenste@linux.microsoft.com,m:nramas@linux.microsoft.com,m:roberto.sassu@huawei.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_TO(0.00)[lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A7AD64A653
X-Spam: Yes

From: Roberto Sassu <roberto.sassu@huawei.com>

Add the documentation of exporting and deleting IMA measurements in
Documentation/security/IMA-export-delete.rst.

Also add the missing Documentation/security/IMA-templates.rst file in
MAINTAINERS.

Link: https://github.com/linux-integrity/linux/issues/1
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/IMA-export-delete.rst | 203 +++++++++++++++++++
 Documentation/security/index.rst             |   1 +
 MAINTAINERS                                  |   2 +
 3 files changed, 206 insertions(+)
 create mode 100644 Documentation/security/IMA-export-delete.rst

diff --git a/Documentation/security/IMA-export-delete.rst b/Documentation/security/IMA-export-delete.rst
new file mode 100644
index 000000000000..1600ead03b03
--- /dev/null
+++ b/Documentation/security/IMA-export-delete.rst
@@ -0,0 +1,203 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+IMA Measurements Export and Delete
+==================================
+
+
+Introduction
+============
+
+The IMA measurements list is currently stored in the kernel memory. Memory
+occupation grows linearly with the number of records, and can become a
+problem especially in environments with reduced resources.
+
+While there is an advantage in keeping the IMA measurements list in kernel
+memory, so that it is always available for reading from the securityfs
+interfaces, storing it elsewhere would make it possible to free precious
+memory for other kernel usage.
+
+The IMA measurements list needs to be retained and safely stored for new
+attestation servers to validate it. Assuming the IMA measurements list is
+properly saved, storing it outside the kernel does not introduce security
+issues, since its integrity is anyway protected by the TPM.
+
+Hence, the new IMA staging mechanism is introduced to export IMA
+measurements to user space and delete them from kernel space.
+
+Staging consists in atomically moving the current measurements list to a
+temporary list, so that measurements can be deleted afterwards. The staging
+operation locks the hot path (racing with addition of new measurements) for
+a very short time, only for swapping the list pointers. Deletion of the
+measurements instead is done locklessly, away from the hot path.
+
+There are two flavors of the staging mechanism. In the staging with prompt,
+all current measurements are staged, read and deleted upon confirmation. In
+the staging and deleting flavor, N measurements are staged from the
+beginning of the current measurements list and immediately deleted without
+confirmation.
+
+
+Management of Staged Measurements
+=================================
+
+Since with the staging mechanism measurement records are removed from the
+kernel, the staged measurements need to be saved in a storage and
+concatenated together, so that they can be presented during remote
+attestation as if staging was never done. This task can be accomplished by
+a remote attestation agent modified to support staging, or a system
+service.
+
+Coordination is necessary in the case where there are multiple actors
+requesting measurements to be staged.
+
+In the staging with prompt case, the measurement interfaces can be accessed
+only by one actor (writer) at a time, so the others will get an error until
+the former closes it. Since the actors don't care about N, when they gain
+access to the interface, they will get all the staged measurements at the
+time of their request.
+
+In the case of staging and deleting, coordination is more important, since
+there is the risk that two actors unaware of each other compute the value N
+on the current measurements list and request IMA to stage N twice.
+
+
+Remote Attestation Agent Workflow
+=================================
+
+Remote attestation agents can be configured to always present all the
+measurements to the remote verifiers or, alternatively, to only provide the
+measurements that have not been verified yet by the remote verifiers.
+
+In the latter case, determining which measurements need to be sent and
+verified must solely depend on the remote verifier. The remote attestation
+agent can proactively send partial measurements, at the condition that they
+are the ones that the remote verifier needs.
+
+An agent can rely on one of the supported staging methods to proactively
+send to a remote verifier the measurements since the previous request up
+to the ones that verify the TPM quote obtained in the current request.
+The workflow with each staging method is the following.
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
+presents the new N measurement records to the remote attestation server.
+
+With the staging and deleting method, the agent reads the current
+measurements list, calculates N and requests IMA to delete only those. The
+measurements in excess are kept in the IMA measurements list and can be
+retrieved at the next remote attestation request.
+
+While keeping only the excess measurements in the storage could be
+sufficient to serve the requests of a remote verifier, it is advised to
+keep all the obtained measurements locally, as they might be needed for the
+attestation with a different remote verifier.
+
+
+Usage
+=====
+
+The IMA staging mechanism can be enabled from the kernel configuration with
+the CONFIG_IMA_STAGING option. This option prevents inadvertently removing
+the IMA measurement list on systems which do not properly save it.
+
+If the option is enabled, IMA duplicates the current securityfs
+measurements interfaces (both binary and ASCII), by adding the ``_staged``
+file suffix. Both the original and the staging interfaces gain the write
+permission for the root user and group, but require the process to have
+CAP_SYS_ADMIN set.
+
+The staging mechanism supports two flavors.
+
+
+Staging with prompt
+~~~~~~~~~~~~~~~~~~~
+
+The current measurements list is moved to a temporary staging area,
+allowing it to be saved to external storage, before being deleted upon
+confirmation.
+
+This staging process is achieved with the following steps.
+
+ 1. ``echo A > <_staged interface>``: the user requests IMA to stage the
+    entire measurements list;
+ 2. ``cat <_staged interface>``: the user reads the staged measurements;
+ 3. ``echo D > <_staged interface>``: the user requests IMA to delete
+    staged measurements.
+
+
+Staging and deleting
+~~~~~~~~~~~~~~~~~~~~
+
+N measurements are staged to a temporary staging area, and immediately
+deleted without further confirmation.
+
+This staging process is achieved with the following steps.
+
+ 1. ``cat <original interface>``: the user reads the current measurements
+    list and determines what the value N for staging should be;
+ 2. ``echo N > <original interface>``: the user requests IMA to delete N
+    measurements from the current measurements list.
+
+
+Interface Access
+================
+
+In order to avoid the IMA measurements list being suddenly truncated by the
+staging mechanism during a read, or having multiple concurrent staging, a
+semaphore-like locking scheme has been implemented on all the measurements
+list interfaces.
+
+Multiple readers can access concurrently the original and staged
+interfaces, and they can be in mutual exclusion with one writer. In order
+to see the same state across all the measurement interfaces, the same
+writer is allowed to open multiple interfaces for write or read/write.
+
+If an illegal access occurs, the open to the measurements list interface is
+denied.
+
+
+Kexec
+=====
+
+In the event a kexec() system call occurs between staging and deleting, the
+staged measurement records are marshalled before the current measurements
+list, so that they are both available when the secondary kernel starts.
+
+If measurement is suspended before requesting to delete staged or current
+measurements, IMA returns an error to user space to let it know that
+marshalling is already in progress, so that it does not save the
+measurements twice.
+
+IMA also disallows staging when suspending measurement, to avoid the
+situation where neither measurements are carried over to the secondary
+kernel, nor they are saved by user space to the storage.
+
+
+Hash table
+==========
+
+By default, the template digest of staged measurement records are kept in
+kernel memory (only template data are freed), to be able to detect
+duplicate records independently of staging.
+
+The new kernel option ``ima_flush_htable`` has been introduced to
+explicitly request a complete deletion of the staged measurements, for
+maximum kernel memory saving. If the option has been specified, duplicate
+records are still avoided on records of the current measurements list,
+but there can be duplicates between different groups of staged
+measurements.
+
+Flushing the hash table is supported only for the staging with prompt
+flavor. For the staging and deleting flavor, it would have been necessary
+to lock the hot path adding new measurements for the time needed to remove
+each selected measurement individually.
diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index 3e0a7114a862..00650dcf38cb 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -8,6 +8,7 @@ Security Documentation
    credentials
    snp-tdx-threat-model
    IMA-templates
+   IMA-export-delete
    keys/index
    lsm
    lsm-development
diff --git a/MAINTAINERS b/MAINTAINERS
index 461a3eed6129..70ff6bae3493 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12752,6 +12752,8 @@ R:	Eric Snowberg <eric.snowberg@oracle.com>
 L:	linux-integrity@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
+F:	Documentation/security/IMA-export-delete.rst
+F:	Documentation/security/IMA-templates.rst
 F:	include/linux/secure_boot.h
 F:	security/integrity/
 F:	security/integrity/ima/
-- 
2.43.0


