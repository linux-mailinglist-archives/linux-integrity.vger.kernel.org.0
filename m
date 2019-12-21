Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30DC4128BE4
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Dec 2019 00:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfLUXkr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 21 Dec 2019 18:40:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726828AbfLUXkq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 21 Dec 2019 18:40:46 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBLNbGUf122334
        for <linux-integrity@vger.kernel.org>; Sat, 21 Dec 2019 18:40:45 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x1g55encc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sat, 21 Dec 2019 18:40:45 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sat, 21 Dec 2019 23:40:43 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 21 Dec 2019 23:40:39 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBLNeclA30212178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Dec 2019 23:40:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74882A404D;
        Sat, 21 Dec 2019 23:40:38 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EB19A4040;
        Sat, 21 Dec 2019 23:40:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.234.212])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 21 Dec 2019 23:40:37 +0000 (GMT)
Subject: Re: [PATCH] IMA: Defined timer to process queued keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Sat, 21 Dec 2019 18:40:36 -0500
In-Reply-To: <20191221015256.2775-1-nramas@linux.microsoft.com>
References: <20191221015256.2775-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19122123-0028-0000-0000-000003CAF3A4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19122123-0029-0000-0000-0000248E4B03
Message-Id: <1576971636.5241.95.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-21_07:2019-12-17,2019-12-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=906 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912210212
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-12-20 at 17:52 -0800, Lakshmi Ramasubramanian wrote:
> keys queued for measurement should still be processed even if
> a custom IMA policy was not loaded. Otherwise, the keys will
> remain queued forever consuming kernel memory.
> 
> This patch defines a timer to handle the above scenario. The timer
> is setup to expire 5 minutes after IMA initialization is completed.
> 
> If a custom IMA policy is loaded before the timer expires, the timer
> is removed and any queued keys are processed. But if a custom policy
> was not loaded, on timer expiration any queued keys are processed.
> 
> On timer expiration the keys are still processed. This will enable
> keys to be measured in case the built-in IMA policy defines a key
> measurement rule.

If there was a built-in policy rule for measuring the early boot keys,
then there wouldn't be a need for queueing the "key" measurements.
 Just free the queued keys.

Mimi

