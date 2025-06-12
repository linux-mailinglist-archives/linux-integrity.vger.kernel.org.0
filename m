Return-Path: <linux-integrity+bounces-6437-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B009AD65FA
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jun 2025 05:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47CE41BC1FCA
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jun 2025 03:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26A71F0E50;
	Thu, 12 Jun 2025 03:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qY5OBroL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8049C1DDA1B;
	Thu, 12 Jun 2025 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749697919; cv=none; b=rqlETlhBRPDv5grbDLMj8lGxAkj5JQsKIMXSvfmhDaHgdVHl7+Rlg89j5qL2xaOEaar7rH7AH3gOGGkswzaDvQ5ZOl6qeVqDbYmxXmuhHDDyhgP8dSw1toV8fGRfE7+CuPlFOqLpyCVkwjurK3ihbyjoD5pcDzde71ET4DxBv/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749697919; c=relaxed/simple;
	bh=OymY9QzL8UQrdlep7zoz5wac7XhoPoXJOXBvdvZyv7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSBRp56qMXR0HCvvEH5P9po93mFYnZNZDAs/oPPDtQsts5ZoSz/BLXrhl6TCTrN4Ka5+2RNUoXlWwmPr3Ls1yBb0zkYkpDpsl06IZbzLBhxXCSyNna4fN4TNi+KGP4S/V2dE35NNDfjMcpfZtidGRe+5qXkJRJZ9419n/IYp3/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qY5OBroL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SkVjDJonN1zi4kxLzBYaZk3udCTfMpOBYkpZ9uo2vyc=; b=qY5OBroLYZZRcKWjae5dewJU89
	NcJm2KY3xoLOhpWbWbxN5wX4iBzj1NooVXq04FsprtX853YeoNwtCTkY2NE3umV/tTST1sfx8b5ZF
	rZsMsUR272nSpaLVFNCanSQ8bEjz3vDrifQC+sLkufydQRJelXQb4oeQCItf+Qcy7jAYk5obbs3UO
	Q/O4vG0Dp4zvQRSiOkGSiDZUwq8CaVKB+4Kl6AGyfwiUEcpXS4trss+NgvDJueN3ZF7x8qRqlY3nq
	g1XQkxxr3SweEzqzXl+XEA1E1ige9cdkAeRQ5MZ+hpMJnxkKf5ZVFAZcBWAv6c718xkZfFYFGim5u
	0JbVwCJA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPYM6-00000009gel-3EJD;
	Thu, 12 Jun 2025 03:11:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Subject: [PATCH 01/10] securityfs: don't pin dentries twice, once is enough...
Date: Thu, 12 Jun 2025 04:11:45 +0100
Message-ID: <20250612031154.2308915-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612030951.GC1647736@ZenIV>
References: <20250612030951.GC1647736@ZenIV>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

incidentally, securityfs_recursive_remove() is broken without that -
it leaks dentries, since simple_recursive_removal() does not expect
anything of that sort.  It could be worked around by dput() in
remove_one() callback, but it's easier to just drop that double-get
stuff.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index 3913501621fa..93460eab8216 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -159,7 +159,6 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 		inode->i_fop = fops;
 	}
 	d_instantiate(dentry, inode);
-	dget(dentry);
 	inode_unlock(dir);
 	return dentry;
 
@@ -306,7 +305,6 @@ void securityfs_remove(struct dentry *dentry)
 			simple_rmdir(dir, dentry);
 		else
 			simple_unlink(dir, dentry);
-		dput(dentry);
 	}
 	inode_unlock(dir);
 	simple_release_fs(&mount, &mount_count);
-- 
2.39.5


