Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 200116804B
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Jul 2019 18:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfGNQs0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 14 Jul 2019 12:48:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728065AbfGNQsZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 14 Jul 2019 12:48:25 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6EGkprV011364
        for <linux-integrity@vger.kernel.org>; Sun, 14 Jul 2019 12:48:24 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tqvnptsc1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 14 Jul 2019 12:48:24 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 14 Jul 2019 17:48:22 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 14 Jul 2019 17:48:21 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6EGmKle42598550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Jul 2019 16:48:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D0AE5204F;
        Sun, 14 Jul 2019 16:48:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.91])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8D1FF5204E;
        Sun, 14 Jul 2019 16:48:19 +0000 (GMT)
Subject: Re: [RFC PATCH] ima: fix ima_file_mmap circular locking dependency
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-integrity@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Date:   Sun, 14 Jul 2019 12:48:08 -0400
In-Reply-To: <20190712231339.GC701@sol.localdomain>
References: <1562964097-8578-1-git-send-email-zohar@linux.ibm.com>
         <20190712231339.GC701@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19071416-0016-0000-0000-0000029280E7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071416-0017-0000-0000-000032F04952
Message-Id: <1563122888.4539.119.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-14_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=797 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907140209
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Eric,

On Fri, 2019-07-12 at 16:13 -0700, Eric Biggers wrote:
> So I suggest just invalidating the report "possible deadlock in
> process_measurement" too, unless you think you think the older overlayfs-related
> deadlock report is still valid and actionable.  It doesn't have a reproducer
> and was last seen 5 months ago, so it *might* be stale:
> https://syzkaller.appspot.com/text?tag=CrashReport&x=1767eeef400000

Yes, please invalidate that one as well.

Mimi

