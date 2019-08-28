Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95063A089C
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Aug 2019 19:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfH1RgS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Aug 2019 13:36:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37324 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfH1RgS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Aug 2019 13:36:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SHYDMQ074693
        for <linux-integrity@vger.kernel.org>; Wed, 28 Aug 2019 17:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 to; s=corp-2019-08-05; bh=rXxBvwmoOTzIQTeWhGr+H6bSWuo1swMUWAflv8O2Bs0=;
 b=HcIOgMfqkqZNUEvocplaQT5UtxGe9Sz+dEaKPvjRLdzRL8nl0pyoNrHOBH6T6h4DysvD
 VDWJD2QmF0W12kYxT8WK6oo0I7l0WyXfO0nB7ZyvWqWP6HGxrCgZoJuRSWbePB2vX5HA
 wckUqUGYk5cw/LRwYGgzKWg0gT++PU4+EbuN7iHaxyupJ2+mdc4qJHpkB0wM0ibW+5UB
 xltVIkKPQ7zrMNCQnKKGmGMvxhxsFTED2C/gXY7fVgRG6dNtQVg0YworCr6R8LDiGuRQ
 oX22j8MFMB9EW7jvEUHYdo/lhr528nZVo+Gklzkhviw7sp9yxWTMenNpCHACoqpn2U5r UQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2unx4cg0en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Wed, 28 Aug 2019 17:36:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SHWw8W059486
        for <linux-integrity@vger.kernel.org>; Wed, 28 Aug 2019 17:36:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2untetm3t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Wed, 28 Aug 2019 17:36:16 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7SHaGid014451
        for <linux-integrity@vger.kernel.org>; Wed, 28 Aug 2019 17:36:16 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Aug 2019 10:36:16 -0700
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: IMA on remote file systems
Message-Id: <C867A0BA-1ACF-4600-8179-3E15A098846C@oracle.com>
Date:   Wed, 28 Aug 2019 13:36:15 -0400
To:     linux-integrity@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=876
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908280171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=939 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908280171
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Last week I presented at the Linux Security Summit on a proposal
for handling IMA metadata on NFS files. After the presentation,
Mimi Zohar pointed out that although the proposal extends protection
from an NFS file server to time-of-measurement on an NFS client,
there is still a protection gap between time-of-measurement and
time-of-use on that client.

My proposal enables storage of per-file IMA metadata via the
NFSv4 protocol. I have a prototype and an IETF nfsv4 Working
Group document that specifies a small protocol extension.

I would like to find a way to extend IMA protection all the way
to time-of-use on NFS clients. The consensus is that a per-file
Merkle tree would be the most desirable approach, as that is the
same mechanism used for fs-verity protection.

For a few important reasons, it will be challenging to plumb
support for durable Merkle trees into NFS, although that is an
eventual goal.

My thought was to use an ephemeral Merkle tree for NFS (and
possibly other remote filesystems, like FUSE, until these
filesystems support durable per-file Merkle trees). A tree would
be constructed when the client measures a file, but it would not
saved to the filesystem. Instead of a hash of the file's contents,
the tree's root signature is stored as the IMA metadata.

Once a Merkle tree is available, it can be used in exactly the
same way that a durable Merkle tree would, to verify the integrity
of individual pages as they are used, evicted, and then read back
from the server.

If the client needs to evict part or all of an ephemeral tree, it
can subsequently be reconstructed by measuring the file again and
verifying its root signature against the stored IMA metadata.

So the only difference here is that the latency-to-first-byte
benefit of a durable Merkle tree would be absent.

I'm interested in any thoughts or opinions about this approach.

--
Chuck Lever

