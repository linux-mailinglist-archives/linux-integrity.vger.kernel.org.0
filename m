Return-Path: <linux-integrity+bounces-9153-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id j/4sJE9Z2GlxcQgAu9opvQ
	(envelope-from <linux-integrity+bounces-9153-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Apr 2026 03:58:39 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAABD3D1428
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Apr 2026 03:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3515A3008774
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Apr 2026 01:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0806831F99B;
	Fri, 10 Apr 2026 01:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PQLwy4i3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B1D31E85B;
	Fri, 10 Apr 2026 01:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775786303; cv=none; b=h+x8McajWnz/deXSrJIeuXdratF5NRdqb5OkLXfA48TkzVpYDkVAcUAA1ZH+UvnTA6rfISx9dUg9wDB9wOoGW/s1LtBxz7lUB3ahU4tA3YGCTA8tDK0KvNI+Hb/k5L/sb3UdXSDSH2wt1pt0zNryfyoD0I0Inl+5ebwiNOmOA0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775786303; c=relaxed/simple;
	bh=0Jexb/ZMubjHOzDcHUapO893VmlNg0yu95HrTu+JPRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tCTb/nq+Nm4+apGJKmSegAOvbR8XL/5TINDHe8NsIUCjm3mM8Bk8inB3Siil8AKLhfF9w+1a6TMnYxIZlucIiL5jKIfR7wNJ+OreNsDmJngxtaMhslgKvnwKlbn+DSIQ9tlLvykljL6j8KlpyitYfh/bkSB5ecaHpq1L05Jf3HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PQLwy4i3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775786302; x=1807322302;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0Jexb/ZMubjHOzDcHUapO893VmlNg0yu95HrTu+JPRQ=;
  b=PQLwy4i3zHZeXLiHCJ46Eq//MMypBkaoWkMTRyhVB4/CIozCYIv4zcPO
   m0uRwfi1VhZhgNifnI2agnHVyeV00Uuug8xXhMsZ582IWJxnH5onMNce4
   Z8JHhJlij7rotpC46SITw91rpDeH48fEOzK2qREQ7dAhjqwbuukT9Ba6T
   hpuZLdK20sH9cl9EaJhFCQ+Wy7wEHjAXO0F6BKQA8xkjb1bw2VAT1vbzV
   ZYIyJ7kOKu2tNd7k9AOwROBYNxzzuwZjsmtcXySbPM+7HzG6itJ8Eu8Zg
   yFAVjfbGIwmOiETUpssKZ2oPeD16/ncAcAfyCx8UQLPEEFX6SEBDg11sV
   A==;
X-CSE-ConnectionGUID: /Z8PIE2cSsmMrtXjcPgVtQ==
X-CSE-MsgGUID: o+dRy1IaTtOytBF1AGJtiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76923702"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="76923702"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 18:58:22 -0700
X-CSE-ConnectionGUID: HomnxG9fTcemmYZ5NlmU5w==
X-CSE-MsgGUID: uZKtv1DSRjOuQCMRDZohww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="233963751"
Received: from emr-371.sh.intel.com ([10.67.116.154])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 18:58:19 -0700
From: "Baoli.Zhang" <baoli.zhang@linux.intel.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Serge Hallyn <serge@hallyn.com>
Cc: "Baoli.Zhang" <baoli.zhang@linux.intel.com>,
	"lili . li" <lili.li@intel.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] tpm: restore timeout for key creation commands
Date: Fri, 10 Apr 2026 09:49:39 +0800
Message-ID: <20260410014940.3557934-1-baoli.zhang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9153-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org,ziepe.ca,hallyn.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[baoli.zhang@linux.intel.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DAABD3D1428
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After the per-command duration map was introduced, TPM2 key creation
commands (`CREATE_PRIMARY`, `CREATE`, `CREATE_LOADED`) were limited to
30 seconds.

On some platforms this is not sufficient and key creation can time out.
Commit 207696b17f38 ("tpm: use a map for tpm2_calc_ordinal_duration()")
inadvertently reduced these command timeouts from 300 seconds to 30
seconds. Restore them to 300 seconds to avoid spurious failures.

Fixes: 207696b17f38 ("tpm: use a map for tpm2_calc_ordinal_duration()")

Signed-off-by: Baoli.Zhang <baoli.zhang@linux.intel.com>
Co-developed-by: lili.li <lili.li@intel.com>
---
 drivers/char/tpm/tpm2-cmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 3a77be7ebf4aa..430022f695f24 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -71,9 +71,9 @@ static const struct {
 	{TPM2_CC_HIERARCHY_CHANGE_AUTH, 2000},
 	{TPM2_CC_GET_CAPABILITY, 750},
 	{TPM2_CC_NV_READ, 2000},
-	{TPM2_CC_CREATE_PRIMARY, 30000},
-	{TPM2_CC_CREATE, 30000},
-	{TPM2_CC_CREATE_LOADED, 30000},
+	{TPM2_CC_CREATE_PRIMARY, 300000},
+	{TPM2_CC_CREATE, 300000},
+	{TPM2_CC_CREATE_LOADED, 300000},
 };
 
 /**
-- 
2.43.0


