Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8FB313CC33
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jan 2020 19:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgAOSgP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jan 2020 13:36:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35536 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729297AbgAOSgO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jan 2020 13:36:14 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00FIMRVM146820
        for <linux-integrity@vger.kernel.org>; Wed, 15 Jan 2020 13:36:13 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xhbpsuc8u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 15 Jan 2020 13:36:12 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 15 Jan 2020 18:36:11 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 Jan 2020 18:36:09 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00FIa88u47972486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 18:36:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E6854C046;
        Wed, 15 Jan 2020 18:36:08 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84B074C04E;
        Wed, 15 Jan 2020 18:36:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.153.48])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Jan 2020 18:36:07 +0000 (GMT)
Subject: Re: [PATCH v2] ima: add the ability to query the hash of a given
 file.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
Cc:     linux-integrity@vger.kernel.org, mjg59@google.com,
        nramas@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Florent Revest <revest@google.com>
Date:   Wed, 15 Jan 2020 13:36:07 -0500
In-Reply-To: <20200113104830.GA28588@google.com>
References: <20200106162524.164650-1-revest@chromium.org>
         <20200113104830.GA28588@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20011518-0008-0000-0000-00000349AB4B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011518-0009-0000-0000-00004A6A0255
Message-Id: <1579113367.5032.19.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-15_02:2020-01-15,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=951 impostorscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001150141
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-01-13 at 11:48 +0100, KP Singh wrote:
> On 06-Jan 17:25, Florent Revest wrote:
> > From: Florent Revest <revest@google.com>
> > 
> > This allows other parts of the kernel (perhaps a stacked LSM allowing
> > system monitoring, eg. the proposed KRSI LSM [1]) to retrieve the hash
> > of a given file from IMA if it's present in the iint cache.
> > 
> > It's true that the existence of the hash means that it's also in the
> > audit logs or in /sys/kernel/security/ima/ascii_runtime_measurements,
> > but it can be difficult to pull that information out for every
> > subsequent exec.  This is especially true if a given host has been up
> > for a long time and the file was first measured a long time ago.
> > 
> > This is based on Peter Moody's patch:
> >  https://sourceforge.net/p/linux-ima/mailman/message/33036180/
> > 
> > [1] https://lkml.org/lkml/2019/9/10/393
> > 
> > Signed-off-by: Florent Revest <revest@google.com>
> 
> Thanks for adding this Florent!
> 
> Reviewed-by: KP Singh <kpsingh@chromium.org>

Thanks, this patch is now queued in next-integrity-testing.

Mimi

