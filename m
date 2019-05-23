Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4DEA27E0F
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2019 15:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbfEWNZy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 May 2019 09:25:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47410 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730081AbfEWNZx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 May 2019 09:25:53 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4ND5FE0130241
        for <linux-integrity@vger.kernel.org>; Thu, 23 May 2019 09:25:51 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2snt6yp067-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 23 May 2019 09:25:50 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 23 May 2019 14:25:47 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 May 2019 14:25:44 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4NDPhfO42991794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 May 2019 13:25:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB788A405C;
        Thu, 23 May 2019 13:25:43 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E0B6A4054;
        Thu, 23 May 2019 13:25:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.80.124])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 May 2019 13:25:43 +0000 (GMT)
Subject: Re: CAP_SYS_ADMIN requirement for updating IMA metadata
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-integrity@vger.kernel.org
Date:   Thu, 23 May 2019 09:25:32 -0400
In-Reply-To: <E66FAD82-34EF-45A2-9EDD-FD69541B36C5@oracle.com>
References: <6FC12520-1B2F-46E8-B9B5-05FEA3147688@oracle.com>
         <1558538361.4347.35.camel@linux.ibm.com>
         <E66FAD82-34EF-45A2-9EDD-FD69541B36C5@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052313-0012-0000-0000-0000031EB038
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052313-0013-0000-0000-000021576996
Message-Id: <1558617932.4347.160.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-23_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=509 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905230092
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-05-22 at 11:49 -0400, Chuck Lever wrote:
> 
> > On May 22, 2019, at 11:19 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Wed, 2019-05-22 at 10:54 -0400, Chuck Lever wrote:
> >> Hi Mimi-
> >> 
> >> I'm working on a section of draft-ietf-nfsv4-integrity-measurement that
> >> discusses what kind of access permission is necessary to update a file's
> >> IMA metadata. This is needed because every NFS operation has an associated
> >> user ID -- an NFS server implementer needs to know which users are allowed
> >> to alter the IMA metadata.
> >> 
> >> On Linux, because the metadata is stored in "security.ima", CAP_SYS_ADMIN
> >> is required.
> >> 
> >> But on other NFS server implementations (ones that might not have a
> >> capabilities system), IMA metadata could be stored via a mechanism that
> >> does not require any special permission.
> >> 
> >> And, it seems to me that if a user can alter the file content, there is
> >> no additional harm in her being allowed to update the IMA metadata.
> >> 
> >> Is there an architectural reason, other than that Linux stores IMA metadata
> >> in a security.* xattr, for requiring a superuser privilege to update IMA
> >> metadata?
> > 
> > security.ima may contain either a file hash or signature.   The file
> > hash should be protected via security.evm.[1]  Allowing anyone to
> > update the file hash would defeat its purpose.
> 
> I wasn't thinking that anyone would be allowed to update the hash, but
> rather that a typical non-Linux NFS server might allow the file's owner
> to update it, for example, since it might store IMA metadata via a
> mechanism that does not require privilege.
> 
> If privilege is a requirement, then the draft has to state it and a non-
> Linux NFS server implementation itself will have to enforce the privilege
> requirement explicitly. (For Linux that is done by the VFS's xattr code,
> not by the NFS server implementation).
> 
> I need to understand this better so I can write it up in the draft.
> Can you further explain what "defeat its purpose" means?
> 
> - If the hash is altered, the effect is the same as if the file content
> is altered.
> 
> - If the hash is altered, security.evm (which is not exposed via NFS)
> would allow a local (non-NFS) accessor to notice the specific problem.
> 
> Seems like the file content is protected in these cases even if the
> hash is altered arbitrarily. ie, unwanted alteration is detected and
> then someone has to restore the file content and hash.
> 
> What am I missing?

Updating security.ima, or for that matter any other EVM protected
security xattrs/file metadata, causes the security.evm HMAC to be
recalculated and written, unless security.evm is a portable &
immutable signature.  To prevent against including other untrusted
modifications from being included in the EVM HMAC, EVM first verifies
the existing security.evm xattr is valid, before recalculating the
HMAC and writing security.evm.

The current design assumes that the file metadata would be included
with the file data and distributed in software packages.  The package
installer is privileged and would install both the file data and
metadata.

In terms of writing security.ima, a similar problem exists in
containers, when root in the container is not the system root.  For
NFS, in addition to the issue of security xattrs, we need to limit the
permitted security.ima types.

Mimi

