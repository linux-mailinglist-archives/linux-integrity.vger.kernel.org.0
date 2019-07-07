Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAACF61784
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Jul 2019 23:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfGGVAR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 7 Jul 2019 17:00:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727073AbfGGVAQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Jul 2019 17:00:16 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x67Kuthi016186
        for <linux-integrity@vger.kernel.org>; Sun, 7 Jul 2019 17:00:15 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tkh6qsnkn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 07 Jul 2019 17:00:15 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 7 Jul 2019 22:00:13 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 7 Jul 2019 22:00:12 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x67L0BmA59965564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 7 Jul 2019 21:00:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6A0CAE058;
        Sun,  7 Jul 2019 21:00:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30502AE057;
        Sun,  7 Jul 2019 21:00:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.89])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  7 Jul 2019 21:00:10 +0000 (GMT)
Subject: Re: Can we enforce "IMA Policy" based on file type
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kavitha Sivagnanam <kavi@juniper.net>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date:   Sun, 07 Jul 2019 16:59:59 -0400
In-Reply-To: <41610A39-BB93-4D64-8821-B59DCE72EE8D@juniper.net>
References: <BYAPR05MB39753CB3CA47513EEADC134CC1270@BYAPR05MB3975.namprd05.prod.outlook.com>
         <1556193529.3894.94.camel@linux.ibm.com>
         <41610A39-BB93-4D64-8821-B59DCE72EE8D@juniper.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19070721-0008-0000-0000-000002FAB7E4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070721-0009-0000-0000-0000226811DA
Message-Id: <1562533199.4106.9.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907070293
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-06-25 at 21:35 +0000, Kavitha Sivagnanam wrote:
> 
> ﻿On 4/25/19, 4:59 AM, "Mimi Zohar" <zohar@linux.ibm.com> wrote:
> 
> >    As Matthew indicated, you could define LSM labels on the squashfs file
> >   images.  Another option would be to extend IMA by implementing the LSM
> >    security_sb_mount hook.  The IMA policy rule would probably look
> >   something like:
> 
> We looked in to the security_sb_mount function. It receives the
> device name as string "const char *dev_name".  We need to do the IMA
> appraisal on the backing file (squashfs file) associated with this
> device.  However, based on this device name we were unable to get
> the backing_file associated with it in kernel space.
> Can you give some pointers? 
> 
> Also, we need to know if at the time when this function is called,
> if the backing file is associated with this device.
> 
> >    appraise func=MOUNT_CHECK fsname=squashfs appraise_type=imasig

When the squashfs file is loopback mounted, the backing file is set in
drivers/block/loop.c: loop_set_fd() and stored as lo->lo_backing_file.

Although security_sb_mount() is called after setting the backing file,
it seems to be too early.  You probably need to wait until after
fill_super().  Try using security_sb_kern_mount().

Mimi

