Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9DE885FBC
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Aug 2019 12:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbfHHKdf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Aug 2019 06:33:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56120 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731038AbfHHKde (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Aug 2019 06:33:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x78ASfUh040131;
        Thu, 8 Aug 2019 10:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=owtx2/r1kl43RHps8TvfElN1G7GWDwn2fAmjeYOGRYw=;
 b=kvb8v7YR/VtEdWIORrB6EUE91dj6mxUqENm1/mN4hfxluTpVf7csUj/Nvyh1Gqiv0+hN
 jW3w4fxikjK4CjHqGFvK2GLA8BtnbPM8EDropcnIG68L8z3A15Yi+xvw9Q36Ca8XGaax
 UAHn1+eQPBTcMBhVGyvKBoOEWFgQwC507KeJcmnYvbeeJejSLE9FncNfG2FWJP4jjX0G
 kyAfFS4Ty6OuvROVqTn5EjAxtdX/vvZWLqrMelQdFCG1Ms8B+vUN7/pJRjIPsES8XVqA
 LEw16CJuM3zVHOiXbHtxTO6APhC7yKBkfymZlhTJDDBZ5jhYI96nhKN/LsPqdYnRPiX4 XQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=owtx2/r1kl43RHps8TvfElN1G7GWDwn2fAmjeYOGRYw=;
 b=dQITqwMcqzLkhSPmwxS8Od4xy5SDUO+VfnVXpwvoDY1eKBVT/beZ9GWypsqNjNnp8Bcb
 rrI18qTdg5Fxl/354KVT5t1JbpIM9htcs5SqaBLezHMcHV5+LovXiqy12eQKP1mgf6Qk
 7jFjGoYAp9y3HEY3BKpI6bX4XwhShQ/CpoH6V1v9Jt7E9cE3/QnYv48M2dVIniA0LPcm
 Z0600/esjnq7OqmhCDeDC8IiM0+gQLUzWQs1RVUY3b1PUStvtZUiiWHZ5spRuEUHTlQW
 IQsvQOgEq229B8VcFe00RcgIIVaOSZwV/y4oVUt/AbJCmyBs9b5GA70GDFM/K6q7dtjv Lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2u8hgp0841-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 10:33:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x78AWZld022152;
        Thu, 8 Aug 2019 10:33:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2u7668xafb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 10:33:20 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x78AXIoW030844;
        Thu, 8 Aug 2019 10:33:18 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Aug 2019 03:33:17 -0700
Date:   Thu, 8 Aug 2019 13:33:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] ima: Fix a use after free in ima_read_modsig()
Message-ID: <20190808103310.GC30506@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908080115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908080115
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This code frees "hdr" and then dereferences it on the next line to get
the error code.

Fixes: 39b07096364a ("ima: Implement support for module-style appended signatures")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 security/integrity/ima/ima_modsig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index c412e31d1714..d106885cc495 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -91,8 +91,9 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 
 	hdr->pkcs7_msg = pkcs7_parse_message(buf + buf_len, sig_len);
 	if (IS_ERR(hdr->pkcs7_msg)) {
+		rc = PTR_ERR(hdr->pkcs7_msg);
 		kfree(hdr);
-		return PTR_ERR(hdr->pkcs7_msg);
+		return rc;
 	}
 
 	memcpy(hdr->raw_pkcs7, buf + buf_len, sig_len);
-- 
2.20.1

