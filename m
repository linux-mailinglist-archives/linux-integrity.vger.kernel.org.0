Return-Path: <linux-integrity+bounces-4133-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B41B9D2329
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2024 11:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC93C1F216F1
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2024 10:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EB71C07C2;
	Tue, 19 Nov 2024 10:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QO9usa61"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170E919C57C
	for <linux-integrity@vger.kernel.org>; Tue, 19 Nov 2024 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011254; cv=none; b=jVg3ccV/wUKpzSIjjYt7zB15sFGsC+dbsd3Ja6H8ig60FLKoftm8odfSbpIOQ9ILAeSIN5ZrlhhqIHYDzqD1B6foAjILAWER6iHv7dLpEy3Q0JVlSwsOx/Lx/toWYUDZvn9LaEBpZfFHuFs6UpuDeroZBGUp7bI6akHNuQ8hsc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011254; c=relaxed/simple;
	bh=uE5/tWJnhOhQhiAsX5OyGOy9W0JUC1ktyipkyHvGqPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EDjUCHgVOTEiYmstBbZizVbDeiA44PjwuwgcJblutjDWHj8rXGuhgnBNeGIPsG/h+VA1q0BNelUJwUerl2XlIS1YitbiOurLGbTeRfry1BfToh9aGKn2pfhjbvNcM7VniSnJgpIE455FG7JfOv2yg0jebrBRYI7s2+7MorI9xiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QO9usa61; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732011252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ueASQKJafuwZGIhDR5ZXwdNvgqXWFXHgTxgMIzhnJvE=;
	b=QO9usa61SUhrFABK1ABAHcJpGIaLQu/WD+My7QIVDl8WTCVadqiQ7VyvDBHMgOGAWzceKr
	GCnTFz0mDM4KXPlQAu1x1oXgADpQuuV/TPcraU8Qzg/IdZG/Q41+Ofx4kau+Q60Z9nn3On
	Km+6rhjoS7NYskMFcV8mKb0s37QGmLk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-brqBwNqKMSq91r47n6S4vg-1; Tue,
 19 Nov 2024 05:14:10 -0500
X-MC-Unique: brqBwNqKMSq91r47n6S4vg-1
X-Mimecast-MFC-AGG-ID: brqBwNqKMSq91r47n6S4vg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A93EF1955BD2;
	Tue, 19 Nov 2024 10:14:09 +0000 (UTC)
Received: from xiubli-thinkpadp16vgen1.rmtcn.com (unknown [10.72.112.22])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 383391955F40;
	Tue, 19 Nov 2024 10:14:06 +0000 (UTC)
From: xiubli@redhat.com
To: ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org,
	Xiubo Li <xiubli@redhat.com>
Subject: [PATCH] doc: correct the build steps for open_posix_testsuite
Date: Tue, 19 Nov 2024 18:13:57 +0800
Message-ID: <20241119101357.951813-1-xiubli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Xiubo Li <xiubli@redhat.com>

'./configure' is needed just before generating the Makefiles.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 doc/users/quick_start.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/users/quick_start.rst b/doc/users/quick_start.rst
index 1581b1f0c..e80c1c244 100644
--- a/doc/users/quick_start.rst
+++ b/doc/users/quick_start.rst
@@ -54,6 +54,7 @@ generated first:
 .. code-block:: console
 
    $ cd testcases/open_posix_testsuite/
+   $ ./configure
    $ make generate-makefiles
    $ cd conformance/interfaces/foo
    $ make
-- 
2.46.0


