Return-Path: <linux-integrity+bounces-4263-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CE89DF78A
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2024 02:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D05B20D3E
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2024 01:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0366C3D81;
	Mon,  2 Dec 2024 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IaVdlncj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A96E79FE
	for <linux-integrity@vger.kernel.org>; Mon,  2 Dec 2024 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733101235; cv=none; b=IkzOMBGMLGTqXf/IuQcs5i54gMOlDWDmGBJTERg0RK7XRt0zcj9JLRWr3P4WSykEkcSNmRHrVg9Sqfi9IDZ/lhOpWZChws8DJ0rHn+b6gvpTAgFmxbZ0I+si4E42FvLIYmmcXu7OagU+jMKai+5bLoosJHUfLB6106urGILxK50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733101235; c=relaxed/simple;
	bh=rbqBaTTjThP16TBbHbn5cd/kHbkmrKMU7+xwUQRiqjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rN2CBtUfaO+vCqaTA291mlCMzdRFhUr+INJOZ26syG74qpxGAv5f9N58gsbob2ivpXeDIpuholgNL8B+gqbKjdXeqVclTiPbEGvPDpicOK1izjNxBIitEFCLTVX066dxOLQkKoSQabgLDfohh6hn1NjxTljfp659cGltKbk2P8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IaVdlncj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733101233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a2tOABuxoSwQJFOm0ZseC/QgcSVsZUaBPE4FH0WJZnY=;
	b=IaVdlncjZtEH+K65LenV+Jz8C7Xgcvjngb12zVFTI02+ovYXtwIB749a/hGBDAsbxVzOgu
	9GeyKNpjpRNFNf3Tv8hZmEYQyfgqWts94HuKJ98tLxViKs5t8H8LDVyTUqdwCIDB04FJyX
	gFB2apisJTrl+vJ+AAQ079hsne+vzxE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-gmvFTkJtNJOHJYPemLp7Kw-1; Sun,
 01 Dec 2024 20:00:29 -0500
X-MC-Unique: gmvFTkJtNJOHJYPemLp7Kw-1
X-Mimecast-MFC-AGG-ID: gmvFTkJtNJOHJYPemLp7Kw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53C521956088;
	Mon,  2 Dec 2024 01:00:28 +0000 (UTC)
Received: from xiubli-thinkpadp16vgen1.rmtcn.com (unknown [10.72.112.98])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A279300018D;
	Mon,  2 Dec 2024 01:00:24 +0000 (UTC)
From: xiubli@redhat.com
To: ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org,
	chrubis@suse.cz,
	Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v2] doc: correct the build steps for open_posix_testsuite
Date: Mon,  2 Dec 2024 09:00:12 +0800
Message-ID: <20241202010012.1266775-1-xiubli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Xiubo Li <xiubli@redhat.com>

'./configure' is needed just before generating the Makefiles.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---

V2:
- a minor fixing about the order, thanks Cyril.

 doc/users/quick_start.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/users/quick_start.rst b/doc/users/quick_start.rst
index 1581b1f0c..598a95e2a 100644
--- a/doc/users/quick_start.rst
+++ b/doc/users/quick_start.rst
@@ -53,6 +53,7 @@ generated first:
 
 .. code-block:: console
 
+   $ ./configure
    $ cd testcases/open_posix_testsuite/
    $ make generate-makefiles
    $ cd conformance/interfaces/foo
-- 
2.47.0


