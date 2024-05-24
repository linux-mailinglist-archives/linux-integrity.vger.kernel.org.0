Return-Path: <linux-integrity+bounces-2633-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12D88CEB3B
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 22:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABC91C213D5
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 20:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3FB131188;
	Fri, 24 May 2024 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Og3njbcH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F97130A42;
	Fri, 24 May 2024 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716583625; cv=none; b=HbN82VvNdZj/u4jqt7HtCkHpOnqPObTMUo13olVDFwZlBbPn+0Fio1u+FhTf3H1lQf5czE48yS3RpdiO1/iACRa598tDt8tgRsRRR6Cqzb1xnSpwYcof8+vk7pxACinJnDNSll67rprlyu8/B8Q9vKjiTwvPkdjRMPCeCOS/LMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716583625; c=relaxed/simple;
	bh=GizpAfm1IpenhhFafNhib8CpRwvRdfoMJkdr5Y8ekEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Ln22WTd+oVFjT7i5UshUx8hg3grK4F+zBmwsY6Nc5er+n6jTxpanHEcWH5eJOsySU3G8iCfig61mZgNnyK5tcfdww5M8mkA6n4DkBtZ2kj1+BFLpaellMjiimNUFU/+tl0Nyd6+J0ZIZZ4NgReF+qjGXCdbk8qFlxyYrXj4MkS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Og3njbcH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id 3F0BB20BE5BA; Fri, 24 May 2024 13:46:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F0BB20BE5BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1716583612;
	bh=xupUS2KScsLMukfv7xMJ85Oj64bo6lAeojCZyO6+ito=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Og3njbcHpWNB41xLjNmIdrwkSdnPYoyX/8TBUzaGynjxaaS8Xcv7QTh0MIGTjXY8S
	 0KI5F0QEMn/fHJdxeUAqUGeFM9dwmVC7oMelNTOnzLbsLLUFE/ebHznm/SNT65aaEo
	 GzpG3yrdXoKSLyyCrqXgoGuvPBBFRpRKr1cz9rOU=
From: Fan Wu <wufan@linux.microsoft.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	jmorris@namei.org,
	serge@hallyn.com,
	tytso@mit.edu,
	ebiggers@kernel.org,
	axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	eparis@redhat.com,
	paul@paul-moore.com
Cc: linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <wufan@linux.microsoft.com>
Subject: [PATCH v19 20/20] MAINTAINERS: ipe: add ipe maintainer information
Date: Fri, 24 May 2024 13:46:49 -0700
Message-Id: <1716583609-21790-21-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1716583609-21790-1-git-send-email-wufan@linux.microsoft.com>
References: <1716583609-21790-1-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

Update MAINTAINERS to include ipe maintainer information.

Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

--
v1-v16:
  + Not present

v17:
  + Introduced

v18:
  + No changes

v19:
  + No changes
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27367ad339ea..1479783a6841 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10934,6 +10934,16 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 F:	security/integrity/
 F:	security/integrity/ima/
 
+INTEGRITY POLICY ENFORCEMENT (IPE)
+M:	Fan Wu <wufan@linux.microsoft.com>
+L:	linux-security-module@vger.kernel.org
+S:	Supported
+T:	git https://github.com/microsoft/ipe.git
+F:	Documentation/admin-guide/LSM/ipe.rst
+F:	Documentation/security/ipe.rst
+F:	scripts/ipe/
+F:	security/ipe/
+
 INTEL 810/815 FRAMEBUFFER DRIVER
 M:	Antonino Daplas <adaplas@gmail.com>
 L:	linux-fbdev@vger.kernel.org
-- 
2.44.0


