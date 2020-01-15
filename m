Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE0313CCDD
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jan 2020 20:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgAOTKG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jan 2020 14:10:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25770 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726474AbgAOTKE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jan 2020 14:10:04 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00FJ8NSr035653
        for <linux-integrity@vger.kernel.org>; Wed, 15 Jan 2020 14:10:01 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xhq3304tw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 15 Jan 2020 14:10:01 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 15 Jan 2020 19:10:00 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 Jan 2020 19:09:55 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00FJ9sij41680902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 19:09:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C520152054;
        Wed, 15 Jan 2020 19:09:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.153.48])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D7C705204E;
        Wed, 15 Jan 2020 19:09:53 +0000 (GMT)
Subject: Re: [PATCH v2] ima: add the ability to query the hash of a given
 file.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Florent Revest <revest@chromium.org>,
        KP Singh <kpsingh@chromium.org>
Cc:     linux-integrity@vger.kernel.org, mjg59@google.com,
        nramas@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Florent Revest <revest@google.com>
Date:   Wed, 15 Jan 2020 14:09:53 -0500
In-Reply-To: <b88cbb1fb39175611e4b31e12a47df240a46dd48.camel@chromium.org>
References: <20200106162524.164650-1-revest@chromium.org>
         <20200113104830.GA28588@google.com>
         <1579113367.5032.19.camel@linux.ibm.com>
         <b88cbb1fb39175611e4b31e12a47df240a46dd48.camel@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20011519-0020-0000-0000-000003A0F88C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011519-0021-0000-0000-000021F873A7
Message-Id: <1579115393.5032.21.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-15_02:2020-01-15,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=989 mlxscore=0 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001150146
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-01-15 at 19:45 +0100, Florent Revest wrote:
> On Wed, 2020-01-15 at 13:36 -0500, Mimi Zohar wrote:
> > On Mon, 2020-01-13 at 11:48 +0100, KP Singh wrote:
> > > On 06-Jan 17:25, Florent Revest wrote:
> > > > From: Florent Revest <revest@google.com>
> > > > 
> > > > This allows other parts of the kernel (perhaps a stacked LSM
> > > > allowing
> > > > system monitoring, eg. the proposed KRSI LSM [1]) to retrieve the
> > > > hash
> > > > of a given file from IMA if it's present in the iint cache.
> > > > 
> > > > It's true that the existence of the hash means that it's also in
> > > > the
> > > > audit logs or in
> > > > /sys/kernel/security/ima/ascii_runtime_measurements,
> > > > but it can be difficult to pull that information out for every
> > > > subsequent exec.  This is especially true if a given host has
> > > > been up
> > > > for a long time and the file was first measured a long time ago.
> > > > 
> > > > This is based on Peter Moody's patch:
> > > >  https://sourceforge.net/p/linux-ima/mailman/message/33036180/
> > > > 
> > > > [1] https://lkml.org/lkml/2019/9/10/393
> > > > 
> > > > Signed-off-by: Florent Revest <revest@google.com>
> > > 
> > > Thanks for adding this Florent!
> > > 
> > > Reviewed-by: KP Singh <kpsingh@chromium.org>
> > 
> > Thanks, this patch is now queued in next-integrity-testing.
> 
> Good to hear Mimi! Thank you.
> 
> I would just like to make sure that you queued the v3 of this patch
> though...? (this thread is for the v2 :) ) The v3 includes a couple of
> comments you asked for.

Oops, yes v3 is queued.

Mimi

