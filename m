Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB4A28427F
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Oct 2020 00:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgJEW20 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Oct 2020 18:28:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726006AbgJEW2Z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Oct 2020 18:28:25 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095M6hTm093669
        for <linux-integrity@vger.kernel.org>; Mon, 5 Oct 2020 18:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : from : subject :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=FkCH3FM1AVI7gY82K+Lx3cOjIz4Z83WeYiroHlOjBgg=;
 b=X9R/hXmpeqTA8B7EC4hV73VGxCX4tu2+m/EZLkqo+zkmF9Ubjxe0Nf0rMURYqyxxwlmE
 8ubbEizElRlCC2E1bUzp25+diKuUBMFzgno2iRZ/l/UhdxkV6WKvDIxpZKxXkiaNP0oc
 Kx2zImgZW7qpDNuKcdCajPlpi3utOI8Kxc3ImwITtmGRGUhpxQUdgroX38yu6tHTh8mY
 pVswtWy5qsfqzvL/g9zsOJwy0zxVttYsv/IuXWog+fXD8PywqPID1bXjWKNWGhPBN/4f
 ZYjCVfNfvWnk5uOkVB1SuzgaWYd6/cAbtaKZqdWOiMjoptU9gEGkSky3cZABfaRk0Kc1 8A== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 340b7nsdmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 05 Oct 2020 18:28:25 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 095MRGMU009029
        for <linux-integrity@vger.kernel.org>; Mon, 5 Oct 2020 22:28:24 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 33xgx9av0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 05 Oct 2020 22:28:24 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 095MSNOM53805478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Mon, 5 Oct 2020 22:28:23 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33AA3C6059
        for <linux-integrity@vger.kernel.org>; Mon,  5 Oct 2020 22:28:23 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07B58C6055
        for <linux-integrity@vger.kernel.org>; Mon,  5 Oct 2020 22:28:22 +0000 (GMT)
Received: from [9.85.186.165] (unknown [9.85.186.165])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP
        for <linux-integrity@vger.kernel.org>; Mon,  5 Oct 2020 22:28:22 +0000 (GMT)
To:     Linux Integrity <linux-integrity@vger.kernel.org>
From:   Ken Goldman <kgold@linux.ibm.com>
Subject: [PATCH 3/6] ima-evm-utils: When using the IBM TSS, link in its
 library
Message-ID: <136e154e-16bc-9d6e-90a3-075cc67be333@linux.ibm.com>
Date:   Mon, 5 Oct 2020 18:28:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_16:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050156
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is a prerequisite for the code change that uses the TSS rather
than the command line tools.

Signed-off-by: Ken Goldman <kgoldman@us.ibm.com>
---
  src/Makefile.am | 1 +
  1 file changed, 1 insertion(+)

diff --git a/src/Makefile.am b/src/Makefile.am
index d6c779f..bf18caf 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -26,6 +26,7 @@ if USE_PCRTSS
  evmctl_SOURCES += pcr_tss.c
  else
  evmctl_SOURCES += pcr_tsspcrread.c
+evmctl_LDADD += -libmtss
  endif

  AM_CPPFLAGS = -I$(top_srcdir) -include config.h
-- 
2.25.1

