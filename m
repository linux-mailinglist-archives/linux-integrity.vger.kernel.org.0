Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63FF5B7FC3
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Sep 2019 19:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390179AbfISRNH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Sep 2019 13:13:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389131AbfISRNG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Sep 2019 13:13:06 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8JGva07076368
        for <linux-integrity@vger.kernel.org>; Thu, 19 Sep 2019 13:13:06 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v4ddt9472-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 19 Sep 2019 13:13:05 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 19 Sep 2019 18:13:03 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 19 Sep 2019 18:13:00 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8JHCxqv50331838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 17:12:59 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8828A405B;
        Thu, 19 Sep 2019 17:12:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7683A4054;
        Thu, 19 Sep 2019 17:12:58 +0000 (GMT)
Received: from dhcp-9-31-103-196.watson.ibm.com (unknown [9.31.103.196])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 19 Sep 2019 17:12:58 +0000 (GMT)
Subject: Re: [PATCH 0/1] KEYS: Measure keys in trusted keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        jamorris@linux.microsoft.com, kgoldman@us.ibm.com,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
Date:   Thu, 19 Sep 2019 13:12:58 -0400
In-Reply-To: <20190919131851.GA8171@sasha-vm>
References: <20190828002735.31025-1-nramas@linux.microsoft.com>
         <1567041083.6115.133.camel@linux.ibm.com>
         <ec8d7cd5-a83a-c344-eaa6-9bd2cef08772@linux.microsoft.com>
         <1567190507.10024.134.camel@linux.ibm.com>
         <2cd27f52-1029-bcea-c73b-7d3d002cf030@linux.microsoft.com>
         <1568035881.4614.347.camel@linux.ibm.com> <20190919131851.GA8171@sasha-vm>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19091917-0020-0000-0000-0000036F2CC8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091917-0021-0000-0000-000021C4DC46
Message-Id: <1568913178.4733.89.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909190148
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-09-19 at 09:18 -0400, Sasha Levin wrote:
> We do not restrict end use of the kernel; this is one of the main
> reasons that the kernel is licensed under GPLv2 rather than GPLv3.
> Please see https://lwn.net/Articles/200422/ .

That's from a licensing perspective.  Linus has full control of what
is upstreamed.

> 
> We'd love to work with you on the technical aspects of this code to make
> it acceptable to the IMA maintainers, but this work can't just be NACKed
> based on a perceived end use of it.

Perhaps if more people/companies thought about how technology could be
abused, before creating it, we, as a society, wouldn't be where we are
today.

On 9/1 I commented on this patch set from a technical perspective,
saying:

IMA measures, appraises, and audits files based on policy[1].  If
you're going to measure keys, all of the code should be within the IMA
subdirectory.  The only code outside of the IMA subdirectory is either
an LSM or IMA hook.  If an LSM hook already exists, use it.  If an LSM
hook doesn't exist and the location is generic that other LSMs would
be interested, define a new LSM hook, otherwise define a new IMA hook.

For example, to measure /boot/cmdline, the rule is "measure
func=KEXEC_CMDLINE template=ima-buf".  A similar rule for measuring
keys would look something like "measure func=KEYS template=ima-buf
pcr=<number>".

Remember "ifdef's" don't belong in C code[2].  Normally a stub
function is defined in an include file to avoid ifdefs.

Mimi

[1] Documentation/ABI/testing/ima_policy
[2] Refer to Documentation/process/coding-style.rst section "21)
Conditional Compilation".

