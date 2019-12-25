Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D995012A5E5
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Dec 2019 05:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfLYEya (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Dec 2019 23:54:30 -0500
Received: from mga12.intel.com ([192.55.52.136]:24181 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfLYEy3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Dec 2019 23:54:29 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Dec 2019 20:54:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,353,1571727600"; 
   d="scan'208";a="417722317"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Dec 2019 20:54:28 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ijygm-0005BK-5a; Wed, 25 Dec 2019 12:54:28 +0800
Date:   Wed, 25 Dec 2019 12:54:16 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [RFC PATCH integrity] IMA: ima_queue_key() can be static
Message-ID: <20191225045416.34tsl75acckhabsr@4978f4969bb8>
References: <201912251234.hUAOr3cc%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201912251234.hUAOr3cc%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Fixes: 466a4c055a9b ("IMA: Define workqueue for early boot "key" measurements")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 ima_asymmetric_keys.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index d520a67180d89..745bb90f1604f 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -67,8 +67,8 @@ static struct ima_key_entry *ima_alloc_key_entry(
 	return entry;
 }
 
-bool ima_queue_key(struct key *keyring, const void *payload,
-		   size_t payload_len)
+static bool ima_queue_key(struct key *keyring, const void *payload,
+			  size_t payload_len)
 {
 	bool queued = false;
 	struct ima_key_entry *entry;
