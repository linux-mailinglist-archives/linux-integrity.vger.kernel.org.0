Return-Path: <linux-integrity+bounces-3233-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1D393AAC5
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jul 2024 03:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059D61F23452
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jul 2024 01:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A13C8E9;
	Wed, 24 Jul 2024 01:56:57 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D1CC156;
	Wed, 24 Jul 2024 01:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721786217; cv=none; b=X3sO5Bhb/18vLZpe03QE+exaTjuWUIoI/GQMagyApDIzbrwvsxBrREy1TZkbX+lCFDEih8xuMTHuSGZDEPMQ+GgBP0ecWD4gWLcszPSjLHiVYb/B0jZP3VmVEP7rBywbLZYqtjWETxWAfqSGF+RshyC5FYHfPuGfZGhV+8Savks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721786217; c=relaxed/simple;
	bh=UQJ+55jwzMY3RMPrkREMJWDnNHzLUS4fHtHSMzgV0JE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YyGetm3YOT+N7B8/aiNTN8ZR1PnUj509ren9ejofG1Dgxpovt+CwZ8bitqDCVfbS/oGVZGtfcIkYinE2TjofKSWDTKmwTO4dS728p8sBpOda2EqIoL6iF3gNi/Qs0UHwTaX8927qQONend2BZrUbEJpRr9MLhLMI/D+VAY++EKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WTHF3483Zz4f3jsH;
	Wed, 24 Jul 2024 09:56:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 00F361A07BA;
	Wed, 24 Jul 2024 09:56:51 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP1 (Coremail) with SMTP id cCh0CgDXw3VgX6BmaKTZAw--.12072S2;
	Wed, 24 Jul 2024 09:56:49 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-integrity@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	James Morris <jmorris@namei.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v1 0/2] Refactor return value of two lsm hooks
Date: Wed, 24 Jul 2024 10:06:57 +0800
Message-Id: <20240724020659.120353-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDXw3VgX6BmaKTZAw--.12072S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyfZFy7GryUAFWktr1xAFb_yoW8WFyUpF
	4SkF13Arn8uFyxZrn3CF17Ca1Fk3yrGF1jy39rtw1093WqvF1UGF17Kw409ryxuFyfKr10
	yF429rs8AFyDJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU17KsUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

The BPF LSM program may cause a kernel panic if it returns an
unexpected value, such as a positive value on the hook
file_alloc_security.

To fix it, series [1] refactored the LSM hook return values and
added BPF return value checks.

[1] used two methods to refactor hook return values:

- converting positive return value to negative error code

- adding additional output parameter to store odd return values

Based on discussion in [1], only two hooks refactored with the
second method may be acceptable. Since the second method requires
extra work on BPF side to ensure that the output parameter is
set properly, the extra work does not seem worthwhile for just
two hooks. So this series includes only the two patches refactored
with the first method.

Changes to [1]:
- Drop unnecessary patches
- Rebase
- Remove redundant comments in the inode_copy_up_xattr patch

[1] https://lore.kernel.org/bpf/20240711111908.3817636-1-xukuohai@huaweicloud.com
    https://lore.kernel.org/bpf/20240711113828.3818398-1-xukuohai@huaweicloud.com

Xu Kuohai (2):
  lsm: Refactor return value of LSM hook vm_enough_memory
  lsm: Refactor return value of LSM hook inode_copy_up_xattr

 fs/overlayfs/copy_up.c            |  6 +++---
 include/linux/lsm_hook_defs.h     |  2 +-
 include/linux/security.h          |  2 +-
 security/commoncap.c              | 11 +++--------
 security/integrity/evm/evm_main.c |  2 +-
 security/security.c               | 22 ++++++++--------------
 security/selinux/hooks.c          | 19 ++++++-------------
 security/smack/smack_lsm.c        |  6 +++---
 8 files changed, 26 insertions(+), 44 deletions(-)

-- 
2.39.2


