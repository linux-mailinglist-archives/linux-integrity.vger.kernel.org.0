Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E25018F6B7
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2020 15:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgCWOXv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Mar 2020 10:23:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31930 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725807AbgCWOXv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Mar 2020 10:23:51 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02NE6w1V022464
        for <linux-integrity@vger.kernel.org>; Mon, 23 Mar 2020 10:23:50 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ywf2fur9n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 23 Mar 2020 10:23:49 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 23 Mar 2020 14:23:47 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Mar 2020 14:23:45 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02NENi1e20775074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 14:23:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBC7CA4062;
        Mon, 23 Mar 2020 14:23:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26585A4066;
        Mon, 23 Mar 2020 14:23:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.197.207])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Mar 2020 14:23:43 +0000 (GMT)
Subject: Re: [PATCH v7] ima-evm-utils: Add some tests for evmctl
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date:   Mon, 23 Mar 2020 10:23:42 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20032314-0020-0000-0000-000003B98F53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032314-0021-0000-0000-000022120B25
Message-Id: <1584973422.5188.247.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-23_05:2020-03-21,2020-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003230078
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

I really appreciate your creating this set of tests!  However, when
you first posted this patch, I asked you to break it up into more
manageable pieces to review.  I understand this isn't the Linux
kernel, "just" some tests, but there is good reason that the Linux
kernel development requires large patches be broken up into more
manageable small, logical changes.

I've recently asked a few people to help review this patch.  I
understand that it is a lot of work to break this patch up into
smaller patches, but it will simplify review.

If I was to break up this patch, I would start by making the test
driver and each of the tests a separate patch.  The test driver patch
description should reference the GNU documentation, with an
explanation as to why a custom driver is preferred[1].

thanks,

Mimi

[1] https://www.gnu.org/software/automake/manual/html_node/Generalitie
s-about-Testing.html#Generalities-about-Testing

