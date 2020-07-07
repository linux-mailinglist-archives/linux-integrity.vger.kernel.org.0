Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87D1216404
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 04:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGGC2E (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 22:28:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726900AbgGGC2D (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 22:28:03 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06723Tkm091375;
        Mon, 6 Jul 2020 22:27:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 324f7dha4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 22:27:59 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06723oDe092160;
        Mon, 6 Jul 2020 22:27:59 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 324f7dha3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 22:27:59 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0672QZc4025234;
        Tue, 7 Jul 2020 02:27:54 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 322hd82wrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 02:27:54 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0672QbjY54984864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jul 2020 02:26:37 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 232754C046;
        Tue,  7 Jul 2020 02:26:37 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 454F04C040;
        Tue,  7 Jul 2020 02:26:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.174.194])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Jul 2020 02:26:36 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>,
        Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH 0/6] ima-evm-utils: miscellanous code clean up and bug fixes 
Date:   Mon,  6 Jul 2020 22:26:25 -0400
Message-Id: <1594088791-27370-1-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_20:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=1 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015
 cotscore=-2147483648 mlxscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=808 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007070010
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The IMA LTP and standalone tests supported a number of features
properly, but were not carried forward in ima-evm-utils.  For example,
hard coding "fixing" file time of measure, time of use (ToMToU)
violations, rather than requiring the "--validate" command option.
Similarly, verifying the template data digest against the template data
should be optional ("--verify").

On some older systems, the Linux kernel header package does not include
"hash_info.h", which results in the crypto algorithm strings not being
defined.  To address this problem, hash_info.gen defines a "heredoc" to
generate the "hash_info.h" file.

The remaining changes are simple bug fixes.

Mimi

Mimi Zohar (6):
  ima-evm-utils: fix PCRAggr error message
  ima-evm-utils: fix measurement violation checking
  ima-evm-utils: don't hardcode validating the IMA measurement list
  ima-evm-utils: calculate and verify the template data digest
  ima-evm-utils: use uint32_t for template length
  ima-evm-utils: define a basic hash_info.h file

 src/Makefile.am   |  2 +-
 src/evmctl.c      | 38 ++++++++++++++++++++++++++++----------
 src/hash_info.gen | 43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 11 deletions(-)

-- 
2.7.5

