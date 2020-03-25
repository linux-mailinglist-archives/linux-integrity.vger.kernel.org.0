Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C89A71933D7
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2020 23:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgCYWo1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Mar 2020 18:44:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17108 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727358AbgCYWo0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Mar 2020 18:44:26 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02PMY4cD039106
        for <linux-integrity@vger.kernel.org>; Wed, 25 Mar 2020 18:44:26 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ywbuxa5up-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 25 Mar 2020 18:44:25 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 25 Mar 2020 22:44:19 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Mar 2020 22:44:16 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02PMhIk930081466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 22:43:18 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E1A5A4064;
        Wed, 25 Mar 2020 22:44:20 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8E74A405C;
        Wed, 25 Mar 2020 22:44:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.132.168])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 25 Mar 2020 22:44:19 +0000 (GMT)
Subject: Re: [PATCH] ima-evm-utils: Fix compatibility with LibreSSL
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Mikhail Novosyolov <m.novosyolov@rosalinux.ru>,
        linux-integrity@vger.kernel.org
Cc:     Vitaly Chikunov <vt@altlinux.org>
Date:   Wed, 25 Mar 2020 18:44:19 -0400
In-Reply-To: <fd03f51c-edec-328c-0f53-71a4bd4f35ac@rosalinux.ru>
References: <85a96cad-dc04-a617-abfa-fb9427412e52@rosalinux.ru>
         <1585083940.5188.304.camel@linux.ibm.com>
         <fd03f51c-edec-328c-0f53-71a4bd4f35ac@rosalinux.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20032522-0020-0000-0000-000003BB68F0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032522-0021-0000-0000-00002213F0D2
Message-Id: <1585176259.5188.323.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_13:2020-03-24,2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=1 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250169
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

I've just pushed out the "next-testing" topic branch[1].  Please base
your changes on this branch.  There might need to be some additional
changes.

thanks,

Mimi

[1] https://git.code.sf.net/p/linux-ima/ima-evm-utils

