Return-Path: <linux-integrity+bounces-9272-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uISNNSaz6GmIOwIAu9opvQ
	(envelope-from <linux-integrity+bounces-9272-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2026 13:38:14 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44303445809
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2026 13:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AE09305A403
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2026 11:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787D137F8A1;
	Wed, 22 Apr 2026 11:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2HgO5nQg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g9Oy0f36";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2HgO5nQg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g9Oy0f36"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9140F3D16ED
	for <linux-integrity@vger.kernel.org>; Wed, 22 Apr 2026 11:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776857700; cv=none; b=gdLvUWhVRVTZowV6OxzAD3o2cOYUlhfhFQl1+4c12ktNZOwRC6pZf1C3Y0M0WvlqLjQLnQJWMYZ9WtFY5RZePQJzTVmMdOYtYxpRr9SajMVmzKpbn505MJpysEbqm6SK4TA9ecd6EQFt2lp0XPxihPEH+Jv4Zm557XKtETi6PN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776857700; c=relaxed/simple;
	bh=Zae8UYhvuR0zUpHyomuN6iwdby3v3a4WwjvTptyXtIg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QHFBDgEicIOvwOUKxGWMDu0wEhnNTL2tmLQwHiGs/Bao8Pb9hiMY44RWIgjW1WYSj0usX668uMdHY2586Ln7sbKHOg9bPRm8qibgAAgDLZ7wNhLcqeyh2UBOvosCc803QFIPfZVvxKS7eLaOpn7LNwJNP7dOzvikgm+TtIbzShY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2HgO5nQg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g9Oy0f36; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2HgO5nQg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g9Oy0f36; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CDC086A81C
	for <linux-integrity@vger.kernel.org>; Wed, 22 Apr 2026 11:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776857696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=UuaRp8pPfWZuoNGnYQhMtcT/grFPuXCIcqbbzKptWts=;
	b=2HgO5nQgeHZb65xVrsbC3PMVj2CeCATIFf0aWj3jUfwKowUkk4YQ/pECGI4DBnktJGTsG1
	S6gwLYdJJiJQ6bswuKWYsEp2Y3gI1HvwwA0VfMHP29CnCjFb936U2a4BfxJ0Ok5WilbMdH
	POXwGMFDY/znDOraMUWtunAhBKEgkoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776857696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=UuaRp8pPfWZuoNGnYQhMtcT/grFPuXCIcqbbzKptWts=;
	b=g9Oy0f36vSo8Wk7oV8ZtokXM0hXYkGqoQsbOjupefAdHvvvsbLhL9Gi8rKi8Wev9FeglHb
	G2eOTBfQ3WrJGrBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776857696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=UuaRp8pPfWZuoNGnYQhMtcT/grFPuXCIcqbbzKptWts=;
	b=2HgO5nQgeHZb65xVrsbC3PMVj2CeCATIFf0aWj3jUfwKowUkk4YQ/pECGI4DBnktJGTsG1
	S6gwLYdJJiJQ6bswuKWYsEp2Y3gI1HvwwA0VfMHP29CnCjFb936U2a4BfxJ0Ok5WilbMdH
	POXwGMFDY/znDOraMUWtunAhBKEgkoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776857696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=UuaRp8pPfWZuoNGnYQhMtcT/grFPuXCIcqbbzKptWts=;
	b=g9Oy0f36vSo8Wk7oV8ZtokXM0hXYkGqoQsbOjupefAdHvvvsbLhL9Gi8rKi8Wev9FeglHb
	G2eOTBfQ3WrJGrBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9347D593AF
	for <linux-integrity@vger.kernel.org>; Wed, 22 Apr 2026 11:34:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rmK/HWCy6Gl2NQAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Apr 2026 11:34:56 +0000
Date: Wed, 22 Apr 2026 07:34:51 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-integrity@vger.kernel.org
Subject: [PATCH] ima: return error early if file xattr cannot be changed
Message-ID: <aposxvqsrlbe7gtyvtsdh5nyg5sgofimerqpt6ez4fbxhtqyjj@4u3othdcgipp>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9272-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rgoldwyn@suse.de,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim]
X-Rspamd-Queue-Id: 44303445809
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During early boot, the filesystem is read-only and any changes
to xattrs are not allowed. This fails in case of ext4 because
changing xattr starts an ext4 transaction which fails with the
following warning.

WARNING: fs/ext4/ext4_jbd2.c:75 at ext4_journal_check_start+0x63/0xa0 [ext4], CPU#1: systemd-sysroot/561
CPU: 1 UID: 0 PID: 561 Comm: systemd-sysroot Not tainted 6.19.12-1-default #1 PREEMPT(voluntary) openSUSE Tumbleweed  c2dfc3c9d9f6f1233251c5d4410574fe82a348ee
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
RIP: 0010:ext4_journal_check_start+0x63/0xa0 [ext4]
Call Trace:
  __ext4_journal_start_sb+0x3e/0x180 [ext4 6d025f3bc52c89a957b89a89d211fadf5e9434e1]
  ext4_xattr_set+0x104/0x150 [ext4 6d025f3bc52c89a957b89a89d211fadf5e9434e1]
  __vfs_setxattr+0x9a/0xd0
  __vfs_setxattr_noperm+0x76/0x1f0
  ima_appraise_measurement+0x23e/0xe40
  ima_d_path+0x5a/0xd0
  process_measurement+0xb29/0xc40
  ? copy_from_kernel_nofault+0x21/0xe0
  ? fscrypt_file_open+0xc0/0xe0
  ? ext4_file_open+0x60/0x490 [ext4 6d025f3bc52c89a957b89a89d211fadf5e9434e1]
  ? bpf_prog_31efb7c56239148b_restrict_filesystems+0xab/0x126
  ? __bpf_prog_exit+0x23/0xd0
  ? __bpf_tramp_exit+0xd/0x50
  ? bpf_trampoline_6442530367+0x9f/0xea
  ima_file_check+0x57/0x80
  security_file_post_open+0x50/0xf0
  path_openat+0x493/0x1650
  do_filp_open+0xc7/0x170

Detect the state of the file early and return the error.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 security/integrity/ima/ima_appraise.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 870dde67707b..6a4dda46114c 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -90,6 +90,11 @@ static int ima_fix_xattr(struct dentry *dentry,
 	int rc, offset;
 	u8 algo = iint->ima_hash->algo;
 
+	if (IS_RDONLY(d_inode(dentry)))
+		return -EROFS;
+	if (IS_IMMUTABLE(d_inode(dentry)))
+		return -EPERM;
+
 	if (algo <= HASH_ALGO_SHA1) {
 		offset = 1;
 		iint->ima_hash->xattr.sha1.type = IMA_XATTR_DIGEST;
-- 
2.53.0

