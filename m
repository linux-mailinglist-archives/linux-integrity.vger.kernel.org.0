Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA1D89508
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Aug 2019 02:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfHLARq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 11 Aug 2019 20:17:46 -0400
Received: from gateway23.websitewelcome.com ([192.185.49.184]:26439 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725870AbfHLARp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 11 Aug 2019 20:17:45 -0400
X-Greylist: delayed 1355 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Aug 2019 20:17:45 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id B7E8026C8
        for <linux-integrity@vger.kernel.org>; Sun, 11 Aug 2019 18:55:09 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id wxg5hF9ou2PzOwxg5hHSDX; Sun, 11 Aug 2019 18:55:09 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yKwbRY2mzkRaJ05KgpOoqO2JTy1EKQ64ZrdyRyqRkM8=; b=j7ccFO9QZypPjQRoMtoJIfjAZR
        7zJ7WUNAzwhixXYm3tR3Fcf0LU/ZSw/7IcF3SQLgAkz4APb0e23Yab0fYiQH+L9nT2xDDWdMwdQHf
        Z3K+eNfMR62JKvEQsbqPvWjoDtO/s8limUAlMq1jXbmN0RwMzaBXYLCR5wcS2TPUwaXQqeKUkK2ns
        Mdt7NVJJjAdnBGRaFMBK3QoJ6PFzM1FlfOr5gA0MkVjsHxfut8kICDpPUPsr7cPJ7VH9oSdG6OTZv
        vAPAThh3fyiy5SMNFhmIRrt36YXw2LydxWiThy+70zfdSDoGQhxeNccwcjAaf8tSrDNZcazSggRd5
        5oqGOV0w==;
Received: from [187.192.11.120] (port=51864 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hwxg4-002Qg0-ID; Sun, 11 Aug 2019 18:55:08 -0500
Date:   Sun, 11 Aug 2019 18:55:07 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] ima: ima_modsig: Fix use-after-free bug in
 ima_read_modsig
Message-ID: <20190811235507.GA9587@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hwxg4-002Qg0-ID
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:51864
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

hdr is being freed and then dereferenced by accessing hdr->pkcs7_msg

Fix this by copying the value returned by PTR_ERR(hdr->pkcs7_msg) into
automatic variable err for its safe use after freeing hdr.

Addresses-Coverity-ID: 1485813 ("Read from pointer after free")
Fixes: 39b07096364a ("ima: Implement support for module-style appended signatures")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 security/integrity/ima/ima_modsig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index c412e31d1714..e681d4326145 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -91,8 +91,9 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 
 	hdr->pkcs7_msg = pkcs7_parse_message(buf + buf_len, sig_len);
 	if (IS_ERR(hdr->pkcs7_msg)) {
+		int err = PTR_ERR(hdr->pkcs7_msg);
 		kfree(hdr);
-		return PTR_ERR(hdr->pkcs7_msg);
+		return err;
 	}
 
 	memcpy(hdr->raw_pkcs7, buf + buf_len, sig_len);
-- 
2.22.0

