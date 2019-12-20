Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7534F128287
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Dec 2019 20:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfLTTB5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Dec 2019 14:01:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727482AbfLTTB4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Dec 2019 14:01:56 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBKIwjNC121956
        for <linux-integrity@vger.kernel.org>; Fri, 20 Dec 2019 14:01:56 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x0y9yht17-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 20 Dec 2019 14:01:55 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 20 Dec 2019 19:01:53 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 20 Dec 2019 19:01:49 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBKJ1mUp41353236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Dec 2019 19:01:48 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D082A4053;
        Fri, 20 Dec 2019 19:01:48 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C44FA404D;
        Fri, 20 Dec 2019 19:01:47 +0000 (GMT)
Received: from dhcp-9-31-103-79.watson.ibm.com (unknown [9.31.103.79])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 Dec 2019 19:01:47 +0000 (GMT)
Subject: Re: [PATCH v5 0/2] IMA: Deferred measurement of keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Fri, 20 Dec 2019 14:01:46 -0500
In-Reply-To: <20191218164434.2877-1-nramas@linux.microsoft.com>
References: <20191218164434.2877-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19122019-0012-0000-0000-0000037700B6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19122019-0013-0000-0000-000021B2F8BE
Message-Id: <1576868506.5241.65.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-20_05:2019-12-17,2019-12-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=3
 bulkscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912200139
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-12-18 at 08:44 -0800, Lakshmi Ramasubramanian wrote:
> This patchset extends the previous version[1] by adding support for
> deferred processing of keys.
> 
> With the patchset referenced above, the IMA subsystem supports
> measuring asymmetric keys when the key is created or updated.
> But keys created or updated before a custom IMA policy is loaded
> are currently not measured. This includes keys added to, for instance,
> .builtin_trusted_keys which happens early in the boot process.
> 
> This change adds support for queuing keys created or updated before
> a custom IMA policy is loaded. The queued keys are processed when
> a custom policy is loaded. Keys created or updated after a custom policy
> is loaded are measured immediately (not queued).
> 
> If the kernel is built with both CONFIG_IMA and
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE enabled then the IMA policy
> must be applied as a custom policy. Not providing a custom policy
> in the above configuration would result in asymmeteric keys being queued
> until a custom policy is loaded. This is by design.

I didn't notice the "This is by design" here, referring to the memory
never being freed.  "This is by design" was suppose to refer to
requiring a custom policy for measuring keys.

For now, these two patches are queued in the next-integrity-testing
branch, but I would appreciate your addressing not freeing the memory
associated with the keys, if a custom policy is not loaded.

Please note that I truncated the 2/2 patch description, as it repeats
the existing verification example in commit ("2b60c0ecedf8 IMA: Read
keyrings= option from the IMA policy").

thanks,

Mimi

