Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D50C14AF2
	for <lists+linux-integrity@lfdr.de>; Mon,  6 May 2019 15:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfEFNcO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 May 2019 09:32:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725813AbfEFNcN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 May 2019 09:32:13 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x46DRtW3036261
        for <linux-integrity@vger.kernel.org>; Mon, 6 May 2019 09:32:13 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2samgev1g6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 06 May 2019 09:32:12 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 6 May 2019 14:32:10 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 May 2019 14:32:08 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x46DW77N48890068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 May 2019 13:32:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F4015204F;
        Mon,  6 May 2019 13:32:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.145])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 77A2852057;
        Mon,  6 May 2019 13:32:06 +0000 (GMT)
Subject: Friendly reminder
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>
Date:   Mon, 06 May 2019 09:31:55 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19050613-0020-0000-0000-00000339D20E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050613-0021-0000-0000-0000218C6737
Message-Id: <1557149515.14288.145.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-06_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905060117
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi -

A number of people have recently joined this mailing list wanting to
contribute - participate in discussions, provide bugs fixes, and/or
add new features.  This is also a good reminder for seasoned kernel
developers as well.  Like with any community, Linux kernel development
defines certain conventions.  At minimum to participate in the
discussions, please find a mailer that doesn't mangle posts; and
remember to trim and inline/bottom post responses.

To fix bugs or submit new features to the linux-integrity subsystem
please read the kernel documentation [1,2] to understand the
process and expectations.  Patches pertaining to IMA, EVM, "trusted"
keys and "encrypted" keys, are upstreamed via the linux-security
tree.  Please make sure any patches posted, apply cleanly to the next-
integrity branch [3] or the next-queued-testing branch immediately
before, during, and after the open window.

For those submitting new features, please pay special attention to the
section titled "3) Separate your changes". [1]  Before posting patches
to the mailing list, please review your patches line by line, just as
people reviewing patches do.  The easier it is to read and review the
patches, the more likely they will be reviewed/upstreamed.

Before extending IMA/EVM, please consider the security/integrity
implications of the proposed new feature, not only in the context of
your environment, but the bigger picture - how others are currently
using existing features.  Remember changes may never break userspace
[4] and, additionally for the linux-integrity subsystem, userspace
expectations.

Most importantly, reviewing patches should not only be the
maintainer's responsibility, it simply doesn't scale very well, but is
the community's responsibility.  You don't need to be a subject expert
to review/comment on patches.  Patches can be reviewed at multiple
levels - patch descriptions, coding style, security, integrity, etc.  
Please take the time to review and comment on other people's patches.

Thanks!

Mimi

[1] Documentation/process/submitting-patches.rst
[2] Documentation/process/submit-checklist.rst
[3] next-integrity branch (https://git.kernel.org/pub/scm/linux/kernel
/git/zohar/linux-integrity.git)
[4] Linus' edict "Never break userspace"

