Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFBAB3CD7
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 16:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733154AbfIPOrt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 10:47:49 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51042 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfIPOrt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 10:47:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GEd5Ct023890;
        Mon, 16 Sep 2019 14:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=bdNUXllMNfxSFxVsGt4lFqyR/+b2kMvPW6JzOfX4s9U=;
 b=JZ4TlAH3DYYD9bFab348Jlxeo8dApnR5ExiAu9qBRAo8TmEoCvP2o/tnHZAVXo1ILULQ
 ZiKq1mXTqrP6BwrKgvvzIgCjW1gaX0DHjC6wNuX2YdBwhr8jWTwmCNTetxdIjp5aPE1u
 3rdkq+8WeB5xOFCE4oY5/STAbUvr2+5oVc/rhkUQ1gLI4U1dri28AukeGuQ6slzXiCj7
 aaWWl4L4xecQohkniyBkKyHSWzhCndICXwKvcyFj22wzZI/e3+CKpxEeKH2wDBGr24Hz
 xBRz4z5cQcooJ3bQKvBzkLbFs/GKFbDzRbI3J9wiT016tkQDcyD9ZQyu+ZfHCcnnvE4z iQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2v0r5p81jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 14:47:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GEcXqE046793;
        Mon, 16 Sep 2019 14:47:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2v0nb4t4pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 14:47:46 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8GEljcd000605;
        Mon, 16 Sep 2019 14:47:45 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Sep 2019 07:47:44 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: IMA on remote file systems
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAE=Ncrb=rh0LeDjnGYGuGJVPXG3Y1UpjD5Tw41s0zyOAaL1NKg@mail.gmail.com>
Date:   Mon, 16 Sep 2019 10:47:43 -0400
Cc:     linux-integrity@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1BF68F78-FA8E-4633-9AB4-AB6E0B10DCB8@oracle.com>
References: <C867A0BA-1ACF-4600-8179-3E15A098846C@oracle.com>
 <CAE=Ncrb=rh0LeDjnGYGuGJVPXG3Y1UpjD5Tw41s0zyOAaL1NKg@mail.gmail.com>
To:     Janne Karhunen <janne.karhunen@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9381 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909160151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9381 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909160151
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> On Sep 16, 2019, at 9:16 AM, Janne Karhunen <janne.karhunen@gmail.com> =
wrote:
>=20
> On Wed, Aug 28, 2019 at 8:36 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
>> My thought was to use an ephemeral Merkle tree for NFS (and
>> possibly other remote filesystems, like FUSE, until these
>> filesystems support durable per-file Merkle trees). A tree would
>> be constructed when the client measures a file, but it would not
>> saved to the filesystem. Instead of a hash of the file's contents,
>> the tree's root signature is stored as the IMA metadata.
>=20
> So the attack you are trying to guard against is that the pages that
> were evicted once and that are read back could still be integrity
> verified?

Yes, the idea would be to provide a generic mechanism for constructing
ephemeral trees such that it can be used for the purpose you describe
on behalf of file systems besides NFS; eg. FUSE, or other remote file
systems such as SMB.

In addition, I hope the mechanism would also be able to reconstruct a
partially evicted Merkle tree as well (in the cases where there is no
durable tree available).


> Handling this properly would be awesome. I don't think we have
> anything against this now, the pages that were once evicted are really
> not checked when read back.

--
Chuck Lever



