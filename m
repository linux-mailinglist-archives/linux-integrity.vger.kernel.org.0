Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90EB36469B
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Apr 2021 17:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239426AbhDSPC2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Apr 2021 11:02:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239230AbhDSPC2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Apr 2021 11:02:28 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JEXaGJ163702
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=i7xSg+IbdMpmjqrYFkVAixmAX3RMkRKSN0mg2fs8yWA=;
 b=J0LigPIps0BiVn+S6kLtK9DkT334mk24FezdqrHiSMMnHwohg06zj4FnitMH0hw+7atC
 5Qwm/YLYUg2Ks0gGxWvFXdKM3tUKFSBKhupB3KWsR/JfCsp4HUp9DucN8Ev4YQnFOZ3J
 qj7j+6zVw1cyLqHQfm4JMDJ+oOEwQaGcCgEhqEw80e95/hsCvEQAbV7bkfQ1bXwWKvhu
 cNWASOP90jXsdr9eRXs8q+2UfEvKNvb30OnNonOjEmA+w4mjWBE54ZFr92vXZbl1F65W
 9wRd3uLNVL3GPsSdhC4uVyGPgRgcJIMmL4NLfOCXMtYNWXcS+rYUnbQWov6HyJcIaWEO XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 380cmkmhu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:01:58 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13JEXaVV163743
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:01:58 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 380cmkmhtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 11:01:58 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13JErSWu028432;
        Mon, 19 Apr 2021 15:01:57 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03dal.us.ibm.com with ESMTP id 37yqa9yc4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 15:01:57 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13JF1t9024445384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 15:01:55 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8707E136051;
        Mon, 19 Apr 2021 15:01:55 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22D9E13605D;
        Mon, 19 Apr 2021 15:01:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.155])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 19 Apr 2021 15:01:54 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 0/6] ima-evm-utils: Some cleanups and bugfixes
Date:   Mon, 19 Apr 2021 11:01:45 -0400
Message-Id: <20210419150151.236409-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fUaYrmumoeWkMShF59klxa2tjn4EbEAA
X-Proofpoint-ORIG-GUID: dFLontTMAvd_Bm7-zhN5s25VBZqucRYZ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_10:2021-04-19,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=788 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190100
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This PR contains some cleanups and bugfixes for libimaevm of ima-evm-utils.

   Stefan

Stefan Berger (6):
  libimaevm: Properly check for error returned by EVP_DigestUpdate
  libimaevm: Remove unused off variable
  libimaevm: Rename variable returned from readlink to len
  libimaevm: Rename variable from cr to newline
  libimaevm: Report unsupported filetype using log_err
  libimaevm: Use function parameter algo for name of hash

 src/libimaevm.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

-- 
2.30.2

