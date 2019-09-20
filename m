Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD51DB93B2
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Sep 2019 17:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389978AbfITPJD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Sep 2019 11:09:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:11659 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387614AbfITPJD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Sep 2019 11:09:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2019 08:09:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,528,1559545200"; 
   d="scan'208";a="194715589"
Received: from eergin-mobl.ger.corp.intel.com (HELO localhost) ([10.252.40.12])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Sep 2019 08:08:59 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] keys: Add Jarkko Sakkinen as co-maintainer
Date:   Fri, 20 Sep 2019 18:08:12 +0300
Message-Id: <20190920150826.18847-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

To address a major procedural concern on Linus's part the keyrings needs
a co-maintainer.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: David Howells <dhowells@redhat.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c76be7aaaf74..4e8ff0af9580 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8945,6 +8945,7 @@ F:	include/keys/trusted.h
 
 KEYS/KEYRINGS:
 M:	David Howells <dhowells@redhat.com>
+M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
 L:	keyrings@vger.kernel.org
 S:	Maintained
 F:	Documentation/security/keys/core.rst
-- 
2.20.1

