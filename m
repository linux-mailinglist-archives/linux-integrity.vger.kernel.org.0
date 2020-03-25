Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEE90191E8D
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2020 02:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgCYBV1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Mar 2020 21:21:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29542 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727102AbgCYBV1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Mar 2020 21:21:27 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02P0Y06e069467
        for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2020 20:48:14 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ywbuw3dah-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2020 20:48:14 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 25 Mar 2020 00:48:10 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Mar 2020 00:48:09 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02P0mAtj59375842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 00:48:10 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C382A4054;
        Wed, 25 Mar 2020 00:48:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C546A405C;
        Wed, 25 Mar 2020 00:48:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.132.168])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 25 Mar 2020 00:48:09 +0000 (GMT)
Subject: Re: [PATCH] ima-evm-utils: Fix compatibility with LibreSSL
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Mikhail Novosyolov <m.novosyolov@rosalinux.ru>,
        linux-integrity@vger.kernel.org
Cc:     Vitaly Chikunov <vt@altlinux.org>
Date:   Tue, 24 Mar 2020 20:48:08 -0400
In-Reply-To: <fd03f51c-edec-328c-0f53-71a4bd4f35ac@rosalinux.ru>
References: <85a96cad-dc04-a617-abfa-fb9427412e52@rosalinux.ru>
         <1585083940.5188.304.camel@linux.ibm.com>
         <fd03f51c-edec-328c-0f53-71a4bd4f35ac@rosalinux.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20032500-0008-0000-0000-0000036352E3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032500-0009-0000-0000-00004A84C0E1
Message-Id: <1585097288.5188.311.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_10:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=18 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003240119
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-03-25 at 01:17 +0300, Mikhail Novosyolov wrote:
> 25.03.2020 00:05, Mimi Zohar пишет:
> > Hi Mikhail,
> >
> > On Wed, 2019-12-04 at 01:41 +0300, Mikhail Novosyolov wrote:
> >> P.S. Patch is against commit 3eab1f93 "ima-evm-utils: Release
> >> version 1.2.1", I did not find newer git.
> > This patch doesn't apply to my current working branch or to that tag.
> >
> > Mimi
> >
> Mimi, sorry for not replying for long, I was going to send a new
> version of the patch in the next few days. Please point me to your
> working branch, I failed to find it at sourceforge.

The next branch is fine.  Everything else is still being reviewed.
 Please remember to include in the patch description the hint on
compiling ima-evm-utils with libressl.

Mimi 

