Return-Path: <linux-integrity+bounces-3265-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B23AF9467C5
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 08:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DCAF282601
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 06:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9FA152178;
	Sat,  3 Aug 2024 06:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ub40uW1o"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D54E14D446;
	Sat,  3 Aug 2024 06:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722665332; cv=none; b=d6xB4Sx3sXiwCs7V7VTX6q4tL1v6Yu7j3pMF6AecJdGPP5t1H55r8dFcVGGyPurnNbfuFBfF/2IH8ogSqIDW5UJvehP1FHHHvUa/Z2II1evrfCt+LnYvNzS7f9acZMkOOop9EjfBHwHRRFK7PcaQEjkDbWnTdhB6Aj+uYw71QM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722665332; c=relaxed/simple;
	bh=CbkbmnUWUSrzP2gjXcKpJOqFs5uUaC/FAOsJ2IBq8vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SIiMSFRg95Nr7gryERS81AX/ZgrXFQq9FKOjmSK8YZSLzP07V6V2AC/4Ybs9ZmuLjenlw95Y73tKot1QkUlIdaZ53VGX4pXfQz4lEMkvcW2oktO61ZfGUWdcyEMSETSLnJ3GZNs5ULtGOfICKOhto+Hu2StQ18KgiVqHVPq957o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ub40uW1o; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id 3FC4720B7414; Fri,  2 Aug 2024 23:08:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3FC4720B7414
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722665321;
	bh=m5ciDJgAqH3wb/sErRlgfAzvaeU/bz4zIL+9GOREwvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ub40uW1obUNH8UB+79CsNA5ldpgFrEsBtDxiEK6gnbbSoV1ZnSQ1/VoFf/dVePg2X
	 ppYzGmDMUS2txfMf0RpcKdAjv3Xn11bz0qAoSp2Quv5Iipb1IS+M7mDHZfgNgOlxwI
	 IHcWy2eS7Ls0RhcXvwGIWF36kYOr9l0cXTxGpc10=
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
Subject: [PATCH v20 20/20] MAINTAINERS: ipe: add ipe maintainer information
Date: Fri,  2 Aug 2024 23:08:34 -0700
Message-Id: <1722665314-21156-21-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
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

v20:
  + No changes
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8766f3e5e87e..4cdf2d5a2058 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11118,6 +11118,16 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
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


