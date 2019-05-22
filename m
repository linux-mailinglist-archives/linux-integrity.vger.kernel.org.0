Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5AE266C6
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2019 17:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbfEVPTi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 May 2019 11:19:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729583AbfEVPTi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 May 2019 11:19:38 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4MFI3jY135494
        for <linux-integrity@vger.kernel.org>; Wed, 22 May 2019 11:19:37 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sn8du9v4n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 22 May 2019 11:19:37 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 22 May 2019 16:19:35 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 May 2019 16:19:33 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4MFJXDa28115052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 May 2019 15:19:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E298BAE04D;
        Wed, 22 May 2019 15:19:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 431BDAE053;
        Wed, 22 May 2019 15:19:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.204])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 May 2019 15:19:32 +0000 (GMT)
Subject: Re: CAP_SYS_ADMIN requirement for updating IMA metadata
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-integrity@vger.kernel.org
Date:   Wed, 22 May 2019 11:19:21 -0400
In-Reply-To: <6FC12520-1B2F-46E8-B9B5-05FEA3147688@oracle.com>
References: <6FC12520-1B2F-46E8-B9B5-05FEA3147688@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052215-0020-0000-0000-0000033F5896
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052215-0021-0000-0000-000021923E5B
Message-Id: <1558538361.4347.35.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-22_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=764 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905220107
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-05-22 at 10:54 -0400, Chuck Lever wrote:
> Hi Mimi-
> 
> I'm working on a section of draft-ietf-nfsv4-integrity-measurement that
> discusses what kind of access permission is necessary to update a file's
> IMA metadata. This is needed because every NFS operation has an associated
> user ID -- an NFS server implementer needs to know which users are allowed
> to alter the IMA metadata.
> 
> On Linux, because the metadata is stored in "security.ima", CAP_SYS_ADMIN
> is required.
> 
> But on other NFS server implementations (ones that might not have a
> capabilities system), IMA metadata could be stored via a mechanism that
> does not require any special permission.
> 
> And, it seems to me that if a user can alter the file content, there is
> no additional harm in her being allowed to update the IMA metadata.
> 
> Is there an architectural reason, other than that Linux stores IMA metadata
> in a security.* xattr, for requiring a superuser privilege to update IMA
> metadata?

security.ima may contain either a file hash or signature.   The file
hash should be protected via security.evm.[1]  Allowing anyone to
update the file hash would defeat its purpose.

Mimi

[1] Refer to Roberto's proposed change "[PATCH 3/4] ima: don't ignore
INTEGRITY_UNKNOWN EVM status"

