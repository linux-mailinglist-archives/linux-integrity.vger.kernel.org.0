Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C81E83011C
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2019 19:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfE3Req (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 May 2019 13:34:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52718 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfE3Req (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 May 2019 13:34:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UHOZjJ130601;
        Thu, 30 May 2019 17:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=dJo7cCnXIeD/X50mA4kUFP8kMfTj0oBfIk9X2rf+aRU=;
 b=SaTAsXR8KOUlqPXSkVM4/Z3seNHuwx8IGc3UFq8ep35aunh8p66hVk1em08MgeFehv9u
 5r/FzvZu8q/2nQFpu84W0uOx4JG7rd6ZRMZTpJVuxusMmSft5ruO2/b8V09iWidWKbQa
 71vG0OPbSWw2izRzPEheiban4L9EHxlQg90ZHGAMjLfDof+WKAlsYHjyjE04fpi5G2Ty
 856bBfuSTpy/YuUX+4OC4+VTEfJEg0NfplzJG88i2rDNRrjs5tbWQweZVmen7BpdyNMj
 AT9wqYdVUfdL0tqXnTd9u1iN0hqrwp5s8gikTrKA5Jddf0P2goaFHe1PgXcWcpPu6e8q eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2spw4tsn24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 17:34:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UHXPc3153508;
        Thu, 30 May 2019 17:34:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ss1fp6y4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 17:34:42 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4UHYfKb021509;
        Thu, 30 May 2019 17:34:42 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 May 2019 10:34:41 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: CAP_SYS_ADMIN requirement for updating IMA metadata
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1558617932.4347.160.camel@linux.ibm.com>
Date:   Thu, 30 May 2019 13:34:40 -0400
Cc:     linux-integrity@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9AFFF0FE-E8F3-4DBC-9731-D9018C1EC3A4@oracle.com>
References: <6FC12520-1B2F-46E8-B9B5-05FEA3147688@oracle.com>
 <1558538361.4347.35.camel@linux.ibm.com>
 <E66FAD82-34EF-45A2-9EDD-FD69541B36C5@oracle.com>
 <1558617932.4347.160.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300123
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> On May 23, 2019, at 9:25 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Wed, 2019-05-22 at 11:49 -0400, Chuck Lever wrote:
>>=20
>>> On May 22, 2019, at 11:19 AM, Mimi Zohar <zohar@linux.ibm.com> =
wrote:
>>>=20
>>> On Wed, 2019-05-22 at 10:54 -0400, Chuck Lever wrote:
>>>> Hi Mimi-
>>>>=20
>>>> I'm working on a section of draft-ietf-nfsv4-integrity-measurement =
that
>>>> discusses what kind of access permission is necessary to update a =
file's
>>>> IMA metadata. This is needed because every NFS operation has an =
associated
>>>> user ID -- an NFS server implementer needs to know which users are =
allowed
>>>> to alter the IMA metadata.
>>>>=20
>>>> On Linux, because the metadata is stored in "security.ima", =
CAP_SYS_ADMIN
>>>> is required.
>>>>=20
>>>> But on other NFS server implementations (ones that might not have a
>>>> capabilities system), IMA metadata could be stored via a mechanism =
that
>>>> does not require any special permission.
>>>>=20
>>>> And, it seems to me that if a user can alter the file content, =
there is
>>>> no additional harm in her being allowed to update the IMA metadata.
>>>>=20
>>>> Is there an architectural reason, other than that Linux stores IMA =
metadata
>>>> in a security.* xattr, for requiring a superuser privilege to =
update IMA
>>>> metadata?
>>>=20
>>> security.ima may contain either a file hash or signature.   The file
>>> hash should be protected via security.evm.[1]  Allowing anyone to
>>> update the file hash would defeat its purpose.
>>=20
>> I wasn't thinking that anyone would be allowed to update the hash, =
but
>> rather that a typical non-Linux NFS server might allow the file's =
owner
>> to update it, for example, since it might store IMA metadata via a
>> mechanism that does not require privilege.
>>=20
>> If privilege is a requirement, then the draft has to state it and a =
non-
>> Linux NFS server implementation itself will have to enforce the =
privilege
>> requirement explicitly. (For Linux that is done by the VFS's xattr =
code,
>> not by the NFS server implementation).

Thinking this through some more. Here's a common usage scenario.

Suppose we have a NetApp filer that serves a small community of NFS
clients. Suppose the filer can store IMA metadata using the NFS =
extension
I describe in draft-ietf-nfsv4-integrity-measurement. But note some
things about this NFS server:

 o There is no user execution environment on that server. The only way
that file content is accessed is via NFS.

 o The server does not have any native support for IMA metadata. It
just stores the metadata blob, and does not otherwise interpret it.

 o There is no secondary (EVM) protection of the IMA metadata.

In a software distribution scenario with an NFS server that does not
allow local (non-NFS) access to file contents, the clients must store
the file content and IMA metadata.

Each NFS operation sent by any NFS client has a user ID associated with
it, including operations to store and retrieve IMA metadata. Obviously,
retrieving IMA metadata can be done by anyone on any client that is
allowed to access the server's exports.

Typically the client passes update requests to the NFS server, which
is the final authority on when file content can be modified. The
question is, how does the server determine which clients and users
are allowed to modify IMA metadata?

Assuming a client is simply running some kind of package tool to
install files on an NFS mount, there is no local signing key, so there
is no issue about the writing user requiring a privilege to sign
these file's IMA metadata. The metadata already exists.

The server could authorize IMA metadata changes by user ID, or it could
allow only one of the clients to change IMA metadata. Another =
possibility
is to allow the file's ACL to determine who can update the metadata.

What is most comparable to local access controls?

My server prototype allows only the root user to update IMA metadata, on
any client that has write access to the export (controlled by =
/etc/exports).


>> I need to understand this better so I can write it up in the draft.
>> Can you further explain what "defeat its purpose" means?
>>=20
>> - If the hash is altered, the effect is the same as if the file =
content
>> is altered.
>>=20
>> - If the hash is altered, security.evm (which is not exposed via NFS)
>> would allow a local (non-NFS) accessor to notice the specific =
problem.
>>=20
>> Seems like the file content is protected in these cases even if the
>> hash is altered arbitrarily. ie, unwanted alteration is detected and
>> then someone has to restore the file content and hash.
>>=20
>> What am I missing?
>=20
> Updating security.ima, or for that matter any other EVM protected
> security xattrs/file metadata, causes the security.evm HMAC to be
> recalculated and written, unless security.evm is a portable &
> immutable signature.  To prevent against including other untrusted
> modifications from being included in the EVM HMAC, EVM first verifies
> the existing security.evm xattr is valid, before recalculating the
> HMAC and writing security.evm.
>=20
> The current design assumes that the file metadata would be included
> with the file data and distributed in software packages.  The package
> installer is privileged and would install both the file data and
> metadata.
>=20
> In terms of writing security.ima, a similar problem exists in
> containers, when root in the container is not the system root.  For
> NFS, in addition to the issue of security xattrs, we need to limit the
> permitted security.ima types.
>=20
> Mimi

--
Chuck Lever



