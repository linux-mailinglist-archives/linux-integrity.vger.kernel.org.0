Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84993304DB
	for <lists+linux-integrity@lfdr.de>; Fri, 31 May 2019 00:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfE3Wka (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 May 2019 18:40:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbfE3Wk3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 May 2019 18:40:29 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UMbMFL003745
        for <linux-integrity@vger.kernel.org>; Thu, 30 May 2019 18:40:28 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stqf3shk4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 30 May 2019 18:40:28 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 30 May 2019 23:40:26 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 23:40:23 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UMeMOD58589202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 22:40:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C32611C099;
        Thu, 30 May 2019 22:40:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3FF511C09B;
        Thu, 30 May 2019 22:40:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.251])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 22:40:21 +0000 (GMT)
Subject: Re: CAP_SYS_ADMIN requirement for updating IMA metadata
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Matthew Garrett <mjg@redhat.com>
Date:   Thu, 30 May 2019 18:40:10 -0400
In-Reply-To: <9AFFF0FE-E8F3-4DBC-9731-D9018C1EC3A4@oracle.com>
References: <6FC12520-1B2F-46E8-B9B5-05FEA3147688@oracle.com>
         <1558538361.4347.35.camel@linux.ibm.com>
         <E66FAD82-34EF-45A2-9EDD-FD69541B36C5@oracle.com>
         <1558617932.4347.160.camel@linux.ibm.com>
         <9AFFF0FE-E8F3-4DBC-9731-D9018C1EC3A4@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19053022-0016-0000-0000-000002811C1D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053022-0017-0000-0000-000032DE3409
Message-Id: <1559256010.4008.115.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300158
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Roberto, Matthew for comment]

On Thu, 2019-05-30 at 13:34 -0400, Chuck Lever wrote:
> 
> > On May 23, 2019, at 9:25 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Wed, 2019-05-22 at 11:49 -0400, Chuck Lever wrote:
> >> 
> >>> On May 22, 2019, at 11:19 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>> 
> >>> On Wed, 2019-05-22 at 10:54 -0400, Chuck Lever wrote:
> >>>> Hi Mimi-
> >>>> 
> >>>> I'm working on a section of draft-ietf-nfsv4-integrity-measurement that
> >>>> discusses what kind of access permission is necessary to update a file's
> >>>> IMA metadata. This is needed because every NFS operation has an associated
> >>>> user ID -- an NFS server implementer needs to know which users are allowed
> >>>> to alter the IMA metadata.
> >>>> 
> >>>> On Linux, because the metadata is stored in "security.ima", CAP_SYS_ADMIN
> >>>> is required.
> >>>> 
> >>>> But on other NFS server implementations (ones that might not have a
> >>>> capabilities system), IMA metadata could be stored via a mechanism that
> >>>> does not require any special permission.
> >>>> 
> >>>> And, it seems to me that if a user can alter the file content, there is
> >>>> no additional harm in her being allowed to update the IMA metadata.
> >>>> 
> >>>> Is there an architectural reason, other than that Linux stores IMA metadata
> >>>> in a security.* xattr, for requiring a superuser privilege to update IMA
> >>>> metadata?
> >>> 
> >>> security.ima may contain either a file hash or signature.   The file
> >>> hash should be protected via security.evm.[1]  Allowing anyone to
> >>> update the file hash would defeat its purpose.
> >> 
> >> I wasn't thinking that anyone would be allowed to update the hash, but
> >> rather that a typical non-Linux NFS server might allow the file's owner
> >> to update it, for example, since it might store IMA metadata via a
> >> mechanism that does not require privilege.
> >> 
> >> If privilege is a requirement, then the draft has to state it and a non-
> >> Linux NFS server implementation itself will have to enforce the privilege
> >> requirement explicitly. (For Linux that is done by the VFS's xattr code,
> >> not by the NFS server implementation).
> 
> Thinking this through some more. Here's a common usage scenario.
> 
> Suppose we have a NetApp filer that serves a small community of NFS
> clients. Suppose the filer can store IMA metadata using the NFS extension
> I describe in draft-ietf-nfsv4-integrity-measurement. But note some
> things about this NFS server:
> 
>  o There is no user execution environment on that server. The only way
> that file content is accessed is via NFS.
> 
>  o The server does not have any native support for IMA metadata. It
> just stores the metadata blob, and does not otherwise interpret it.
> 
>  o There is no secondary (EVM) protection of the IMA metadata.
> 
> In a software distribution scenario with an NFS server that does not
> allow local (non-NFS) access to file contents, the clients must store
> the file content and IMA metadata.
> 
> Each NFS operation sent by any NFS client has a user ID associated with
> it, including operations to store and retrieve IMA metadata. Obviously,
> retrieving IMA metadata can be done by anyone on any client that is
> allowed to access the server's exports.
> 
> Typically the client passes update requests to the NFS server, which
> is the final authority on when file content can be modified. The
> question is, how does the server determine which clients and users
> are allowed to modify IMA metadata?
> 
> Assuming a client is simply running some kind of package tool to
> install files on an NFS mount, there is no local signing key, so there
> is no issue about the writing user requiring a privilege to sign
> these file's IMA metadata. The metadata already exists.
> 
> The server could authorize IMA metadata changes by user ID, or it could
> allow only one of the clients to change IMA metadata. Another possibility
> is to allow the file's ACL to determine who can update the metadata.
> 
> What is most comparable to local access controls?
> 
> My server prototype allows only the root user to update IMA metadata, on
> any client that has write access to the export (controlled by /etc/exports).

It's kind of ironic that Roberto's patch is requiring EVM, well only
for mutable files, while your scenario doesn't support EVM.  I agree
with you that if you have permission to write the file data, that you
should also have permission to write the file metadata.  Since you're
not interested in supporting EVM and are only interested in supporting
signed files, this makes it a lot easier.  IMA could be extended to
allow the file metadata be stored in xattr namespaces other than
security, based on policy.

Mimi

> 
> >> I need to understand this better so I can write it up in the draft.
> >> Can you further explain what "defeat its purpose" means?
> >> 
> >> - If the hash is altered, the effect is the same as if the file content
> >> is altered.
> >> 
> >> - If the hash is altered, security.evm (which is not exposed via NFS)
> >> would allow a local (non-NFS) accessor to notice the specific problem.
> >> 
> >> Seems like the file content is protected in these cases even if the
> >> hash is altered arbitrarily. ie, unwanted alteration is detected and
> >> then someone has to restore the file content and hash.
> >> 
> >> What am I missing?
> > 
> > Updating security.ima, or for that matter any other EVM protected
> > security xattrs/file metadata, causes the security.evm HMAC to be
> > recalculated and written, unless security.evm is a portable &
> > immutable signature.  To prevent against including other untrusted
> > modifications from being included in the EVM HMAC, EVM first verifies
> > the existing security.evm xattr is valid, before recalculating the
> > HMAC and writing security.evm.
> > 
> > The current design assumes that the file metadata would be included
> > with the file data and distributed in software packages.  The package
> > installer is privileged and would install both the file data and
> > metadata.
> > 
> > In terms of writing security.ima, a similar problem exists in
> > containers, when root in the container is not the system root.  For
> > NFS, in addition to the issue of security xattrs, we need to limit the
> > permitted security.ima types.
> > 
> > Mimi
> 
> --
> Chuck Lever
> 
> 
> 

