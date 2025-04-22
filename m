Return-Path: <linux-integrity+bounces-5995-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A306A971D8
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Apr 2025 18:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97551189C4C1
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Apr 2025 16:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0422827815F;
	Tue, 22 Apr 2025 16:04:11 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC874284B51;
	Tue, 22 Apr 2025 16:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337850; cv=none; b=G2uuMuVi+sT4Qq/oiYGxJmMvxLfxEfXBNHyFBhPn3ccTcdmrUfTZIOJ89ZkUnrv+TmTPrRsBf/9PpxXf+Qnq2Hskc4zG7WJ6ZocACr/f3uHE0Hmukx3lC0v0BlMIrzCO6onGAc1cKBZyC3R/owAzeGDwNBlGaxHiB413meutn2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337850; c=relaxed/simple;
	bh=Q3FGj0NUnDmy7Sa2MUrcTAGYijhd3QOEr4vyd6qDpTw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hsEQw3MBmwiM8ljy9MF7+v0OHTfYoIMSBUJKz8BK8OmtgXqO8BYQkfPwmjOMiUhai0UDWfaUQP2DWVEldwPXLF8do+EBv0Hj0bc7U6AqpMM1s/FCMb5zAf8kk1tkXNJLZSFeLx4r1UzndJt4qGWhu/Ekl+okjxzPfZX/X0rWVOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4ZhmqQ1BrQzpV14;
	Tue, 22 Apr 2025 23:48:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 5FB3A140156;
	Tue, 22 Apr 2025 23:48:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwA37d9VugdoALKABg--.62087S2;
	Tue, 22 Apr 2025 16:48:42 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: torvalds@linux-foundation.org
Cc: zohar@linux.ibm.com,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [GIT PULL] Integrity fix for kernel 6.15-rc3
Date: Tue, 22 Apr 2025 17:48:05 +0200
Message-Id: <20250422154805.1817045-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwA37d9VugdoALKABg--.62087S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFWktr48tw4fJr1xCF17KFg_yoWDuFX_uF
	yktF18JrWUXr1kCw4Utr17Wr4rWryDGr15JryUGF42v347JwnxJ348GFWrXr1kXF4Dtr9r
	JrWkJr1DJw17ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb2AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkvb40E47kJMIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07bzjjgUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAGBGgHP+AHcgAAsG

From: Roberto Sassu <roberto.sassu@huawei.com>

Hi Linus

this pull request contains one performance improvement to avoid
unnecessarily taking the inode lock.

It has been tested by both me and Mimi.

Please pull, thanks!

Roberto

-- 

The following changes since commit 9c32cda43eb78f78c73aee4aa344b777714e259b:

  Linux 6.15-rc3 (2025-04-20 13:43:47 -0700)

are available in the Git repository at:

  https://github.com/linux-integrity/linux.git tags/integrity-6.15-rc3-fix

for you to fetch changes up to 30d68cb0c37ebe2dc63aa1d46a28b9163e61caa2:

  ima: process_measurement() needlessly takes inode_lock() on MAY_READ (2025-04-22 16:39:32 +0200)

----------------------------------------------------------------
Integrity fix for kernel 6.15-rc3

----------------------------------------------------------------
Frederick Lawler (1):
      ima: process_measurement() needlessly takes inode_lock() on MAY_READ

 security/integrity/ima/ima_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


