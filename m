Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F558CEC82
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Oct 2019 21:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfJGTMe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Oct 2019 15:12:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728116AbfJGTMe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Oct 2019 15:12:34 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x97J7IE0052493;
        Mon, 7 Oct 2019 15:12:22 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vg8jbdx8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 15:12:22 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x97J7TjD053309;
        Mon, 7 Oct 2019 15:12:21 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vg8jbdx7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 15:12:21 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x97JA5jg004030;
        Mon, 7 Oct 2019 19:12:21 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02dal.us.ibm.com with ESMTP id 2vejt6r9yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 19:12:20 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x97JCHsF60162346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Oct 2019 19:12:19 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AC33136252;
        Mon,  7 Oct 2019 19:12:15 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACD66136272;
        Mon,  7 Oct 2019 19:12:10 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.184.117])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  7 Oct 2019 19:12:10 +0000 (GMT)
Message-ID: <1570475528.4242.2.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] tpm: Use GFP_KERNEL for allocating struct tpm_buf
From:   James Bottomley <jejb@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 07 Oct 2019 12:12:08 -0700
In-Reply-To: <20191006095005.GA7660@linux.intel.com>
References: <20191003185103.26347-1-jarkko.sakkinen@linux.intel.com>
         <20191003185103.26347-2-jarkko.sakkinen@linux.intel.com>
         <1570148716.10818.19.camel@linux.ibm.com>
         <20191006095005.GA7660@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=997 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910070165
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH] tpm: use GFP kernel for tpm_buf allocations

The current code uses GFP_HIGHMEM, which is wrong because GFP_HIGHMEM
(on 32 bit systems) is memory ordinarily inaccessible to the kernel
and should only be used for allocations affecting userspace.  In order
to make highmem visible to the kernel on 32 bit it has to be kmapped,
which consumes valuable entries in the kmap region.  Since the tpm_buf
is only ever used in the kernel, switch to using a GFP_KERNEL
allocation so as not to waste kmap space on 32 bits.

Fixes: a74f8b36352e (tpm: introduce tpm_buf)
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index a7fea3e0ca86..b4f1cbf344b6 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -284,7 +284,6 @@ enum tpm_buf_flags {
 };
 
 struct tpm_buf {
-	struct page *data_page;
 	unsigned int flags;
 	u8 *data;
 };
@@ -300,20 +299,18 @@ static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
 
 static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
 {
-	buf->data_page = alloc_page(GFP_HIGHUSER);
-	if (!buf->data_page)
+	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
+	if (!buf->data)
 		return -ENOMEM;
 
 	buf->flags = 0;
-	buf->data = kmap(buf->data_page);
 	tpm_buf_reset(buf, tag, ordinal);
 	return 0;
 }
 
 static inline void tpm_buf_destroy(struct tpm_buf *buf)
 {
-	kunmap(buf->data_page);
-	__free_page(buf->data_page);
+	free_page(buf->data);
 }
 
 static inline u32 tpm_buf_length(struct tpm_buf *buf)
-- 
2.16.4

