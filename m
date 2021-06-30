Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA9C3B8931
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Jun 2021 21:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbhF3Tg3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Jun 2021 15:36:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50734 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229700AbhF3Tg3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jun 2021 15:36:29 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UJ7KOS088961
        for <linux-integrity@vger.kernel.org>; Wed, 30 Jun 2021 15:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=a7epItxTWm7lcypRbb3j0rpdBBTOFAcikuVW2QOUxj0=;
 b=I8tXRN6RyaRQrPM9Z8jIabj2MC5CFn99H94pSy90YTVPe8OYZm5mYAShn6g5jbLIpro7
 8r+JWLHTjw0BIg4usjMZUEdff9aqLRZ+c8JNIlRVCBEA+rsyk2AS2Bp8e4YdYUiFmdqJ
 +myGRYw8E9jFWcHnZ01rFy3lEfKDIqI/sOfY3CceH6eaSv0JSMbunPe7jt0h2DBUmSwP
 S84Og3uZYV8XGH+UYeDpMM4S5EU+WGh2+tY9AaTpz4DCjjoSSabaG9bLBZhsF7akqnH2
 C0fdnMokE7eixF2Mt9OgY8vZQHTuKMLeudixLFOROxFMqlsZHwLy7B8e9iDXFEkDzwQC yw== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39gtqmr19c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 30 Jun 2021 15:34:00 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15UJXnGL030376
        for <linux-integrity@vger.kernel.org>; Wed, 30 Jun 2021 19:33:59 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03dal.us.ibm.com with ESMTP id 39duve1d0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 30 Jun 2021 19:33:54 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15UJXBrm33620472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 19:33:11 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8A47AC05B;
        Wed, 30 Jun 2021 19:33:10 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA17BAC059;
        Wed, 30 Jun 2021 19:33:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.155])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 30 Jun 2021 19:33:10 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils 0/3] libimaevm: Remove digest calculations not supported by IMA
Date:   Wed, 30 Jun 2021 15:33:00 -0400
Message-Id: <20210630193303.2531284-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y2pzzytU3tQin7QiIQFET2wPiSSZ5ZdT
X-Proofpoint-ORIG-GUID: y2pzzytU3tQin7QiIQFET2wPiSSZ5ZdT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-30_11:2021-06-30,2021-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=779 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300106
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Remove digest calculations over directories, symbolic links, and device files
since those and related signature verifications are not supported by IMA in
the kernel.

Regards,
   Stefan

Stefan Berger (3):
  libimaevm: Remove calculation of a digest over a device file
  libimaevm: Remove calculation of a digest over a directory
  libimaevm: Remove calculation of a digest over a symbolic link

 src/libimaevm.c | 68 -------------------------------------------------
 1 file changed, 68 deletions(-)

-- 
2.31.1

