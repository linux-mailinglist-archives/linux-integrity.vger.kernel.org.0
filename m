Return-Path: <linux-integrity+bounces-4338-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5189EC160
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 02:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54EEC283E9E
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 01:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B25134AC;
	Wed, 11 Dec 2024 01:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iuqNb5t1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D242451D0
	for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2024 01:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733879812; cv=none; b=lxhCpDOT5JF0jrdghf47kNrXHKOMn3TmauNYU+Js2W2agyh8s+jkr+QpkL2IUAkWjffSChb7lMOYjdskg+0EBN6o65DyEgLLs7uu029IGxn3eeZuOTtZbCJbpT6wJEDd608pglj7mnhhXR+0qxWsAFoc1EfLmbljXf8kSTzkBV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733879812; c=relaxed/simple;
	bh=BV3jEasEuxZ64gS7gxbZqnRwW5dZ8b3qUpNZAp4rIek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJFXuiQvlmCe/J/usL0z9/kviyOZlNxUIoSCLX3pEWodLEa1uyHpxBAiys6DDcyDHfYO82f8R5oeJiVBHT6KiRdSahPfnCInJdddPFJYDpKacJgEw/7v6HhkyVJiCQUUli8rGgH0h/O/dfBwlSXC0wiamXJamP4Z7HWWuB/nP08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iuqNb5t1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733879808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oHGpBCqgacuTgNAdPBHWAn7Y5cTUtS6u2zviZxXY3hc=;
	b=iuqNb5t1W+lKzte2qAXEA89UoGzEf+94i+foaKSbz4iTFM5gg8TTlNQA02Z/FcDQ/VHOzs
	tzBznnuQyIUW+cOZvUGhxzRNh05zBXSCy1V37LNNblXnXCrCgkZDZj5KmIbyDSz4islMvJ
	YZBcwVhSMPCL/sewXbtPT/vrALvZ1q0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-iTHrxjH9NPCTYES_9HihwA-1; Tue,
 10 Dec 2024 20:16:45 -0500
X-MC-Unique: iTHrxjH9NPCTYES_9HihwA-1
X-Mimecast-MFC-AGG-ID: iTHrxjH9NPCTYES_9HihwA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3024219560AE;
	Wed, 11 Dec 2024 01:16:44 +0000 (UTC)
Received: from xiubli-thinkpadp16vgen1.rmtcn.com (unknown [10.72.112.22])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A28B19560A2;
	Wed, 11 Dec 2024 01:16:40 +0000 (UTC)
From: xiubli@redhat.com
To: ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org,
	chrubis@suse.cz,
	Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v3] doc: correct the build steps for open_posix_testsuite
Date: Wed, 11 Dec 2024 09:16:36 +0800
Message-ID: <20241211011636.499499-1-xiubli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Xiubo Li <xiubli@redhat.com>

'./configure --with-open-posix-testsuite' is needed just before
generating the Makefiles.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---

V3:
- switch to use --with-open-posix-testsuite option instead.

V2:
- a minor fixing about the order, thanks Cyril.


 doc/users/quick_start.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/users/quick_start.rst b/doc/users/quick_start.rst
index 1581b1f0c..8a25b9129 100644
--- a/doc/users/quick_start.rst
+++ b/doc/users/quick_start.rst
@@ -53,6 +53,7 @@ generated first:
 
 .. code-block:: console
 
+   $ ./configure --with-open-posix-testsuite
    $ cd testcases/open_posix_testsuite/
    $ make generate-makefiles
    $ cd conformance/interfaces/foo
-- 
2.47.0


