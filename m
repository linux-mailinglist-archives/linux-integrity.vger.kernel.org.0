Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90ACC2673E
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2019 17:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfEVPtX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 May 2019 11:49:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37794 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbfEVPtX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 May 2019 11:49:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4MFiHYZ119357;
        Wed, 22 May 2019 15:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=yzxtf1+H6ONIfRF6EGsdKncjQkKme48riHWFYanUkMs=;
 b=OZ8KNAz58KLnLwaRxRD9UZUQ+PKTZIdXZAM8KsDPY/ISkaI2tJ556JLm8r9ainHMOkxG
 ljOEzmXE31dnszjUti4fyZHTzAorfD/bxbDOSYvUV/YLgKKcHpMgp03oReWwnB2jjHb9
 brBl9kFSzYQhvJWyphHLWCLgeth7V1J4r1as3V6eH4IOw3yVB5Jt9RUhE64wzbhunYXp
 iKadU3XGUYD1GcA2GZTEACJZsRjTWOtQWOkMC5SbDlrkgBOQDjA7z3Wzae09HwejiYhK
 Nxq/9/6QW3n2bVOq36voAHJkE+r6mEV9war6nL9viZ4fw6rRq10uGWpchLM/xIwJfIKu Pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2smsk54ru8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 May 2019 15:49:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4MFliEq002159;
        Wed, 22 May 2019 15:49:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2smsguxa87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 May 2019 15:49:19 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4MFnJnr010437;
        Wed, 22 May 2019 15:49:19 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 May 2019 15:49:18 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: CAP_SYS_ADMIN requirement for updating IMA metadata
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1558538361.4347.35.camel@linux.ibm.com>
Date:   Wed, 22 May 2019 11:49:12 -0400
Cc:     linux-integrity@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E66FAD82-34EF-45A2-9EDD-FD69541B36C5@oracle.com>
References: <6FC12520-1B2F-46E8-B9B5-05FEA3147688@oracle.com>
 <1558538361.4347.35.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905220111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905220111
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> On May 22, 2019, at 11:19 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Wed, 2019-05-22 at 10:54 -0400, Chuck Lever wrote:
>> Hi Mimi-
>>=20
>> I'm working on a section of draft-ietf-nfsv4-integrity-measurement =
that
>> discusses what kind of access permission is necessary to update a =
file's
>> IMA metadata. This is needed because every NFS operation has an =
associated
>> user ID -- an NFS server implementer needs to know which users are =
allowed
>> to alter the IMA metadata.
>>=20
>> On Linux, because the metadata is stored in "security.ima", =
CAP_SYS_ADMIN
>> is required.
>>=20
>> But on other NFS server implementations (ones that might not have a
>> capabilities system), IMA metadata could be stored via a mechanism =
that
>> does not require any special permission.
>>=20
>> And, it seems to me that if a user can alter the file content, there =
is
>> no additional harm in her being allowed to update the IMA metadata.
>>=20
>> Is there an architectural reason, other than that Linux stores IMA =
metadata
>> in a security.* xattr, for requiring a superuser privilege to update =
IMA
>> metadata?
>=20
> security.ima may contain either a file hash or signature.   The file
> hash should be protected via security.evm.[1]  Allowing anyone to
> update the file hash would defeat its purpose.

I wasn't thinking that anyone would be allowed to update the hash, but
rather that a typical non-Linux NFS server might allow the file's owner
to update it, for example, since it might store IMA metadata via a
mechanism that does not require privilege.

If privilege is a requirement, then the draft has to state it and a non-
Linux NFS server implementation itself will have to enforce the =
privilege
requirement explicitly. (For Linux that is done by the VFS's xattr code,
not by the NFS server implementation).

I need to understand this better so I can write it up in the draft.
Can you further explain what "defeat its purpose" means?

- If the hash is altered, the effect is the same as if the file content
is altered.

- If the hash is altered, security.evm (which is not exposed via NFS)
would allow a local (non-NFS) accessor to notice the specific problem.

Seems like the file content is protected in these cases even if the
hash is altered arbitrarily. ie, unwanted alteration is detected and
then someone has to restore the file content and hash.

What am I missing?


> Mimi
>=20
> [1] Refer to Roberto's proposed change "[PATCH 3/4] ima: don't ignore
> INTEGRITY_UNKNOWN EVM status"

Hm. I didn't entirely understand the patch description. Even so, what
concerns me is that EVM metadata is not exposed to NFS clients in the
current Linux NFS implementation. For NFS, then, either:

- a Linux server (or any server that has a local IMA implementation)
will have to validate an unsigned hash locally, and then the underlying
network transport will have to guarantee hash integrity during transit
via GSS krb5i, for example

or

- the the IMA metadata (here I mean what is stored in security.ima)
will have to be cryptographically signed such that the signature
is also stored in that metadata and not in security.evm so that it
is visible to NFS clients

Currently the draft assumes that the only deployment mode with NFS
will be the latter option.


--
Chuck Lever



