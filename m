Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88305145D5B
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jan 2020 21:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgAVUzH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jan 2020 15:55:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725827AbgAVUzH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jan 2020 15:55:07 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MKqLe8087956
        for <linux-integrity@vger.kernel.org>; Wed, 22 Jan 2020 15:55:06 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xp2jg86qk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 22 Jan 2020 15:55:05 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 22 Jan 2020 20:55:04 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Jan 2020 20:55:01 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00MKt0cN56295660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jan 2020 20:55:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E25011C052;
        Wed, 22 Jan 2020 20:55:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5250111C050;
        Wed, 22 Jan 2020 20:54:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.143.97])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Jan 2020 20:54:59 +0000 (GMT)
Subject: Re: [PATCH] IMA: Turn IMA_MEASURE_ASYMMETRIC_KEYS off by default
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 22 Jan 2020 15:54:58 -0500
In-Reply-To: <fa7ec770-6552-7538-7393-c23410b3a1ba@linux.microsoft.com>
References: <20200121171302.4935-1-nramas@linux.microsoft.com>
         <1579628090.3390.28.camel@HansenPartnership.com>
         <1579634035.5125.311.camel@linux.ibm.com>
         <1579636351.3390.35.camel@HansenPartnership.com>
         <ac6c559e-2d68-afcb-d316-6ac49a570831@linux.microsoft.com>
         <1579723379.5182.130.camel@linux.ibm.com>
         <fa7ec770-6552-7538-7393-c23410b3a1ba@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012220-0020-0000-0000-000003A31B8E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012220-0021-0000-0000-000021FAB225
Message-Id: <1579726498.4644.4.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-22_08:2020-01-22,2020-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001220178
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-01-22 at 12:05 -0800, Lakshmi Ramasubramanian wrote:
> On 1/22/20 12:02 PM, Mimi Zohar wrote:
> 
> > 
> > Thanks, Lakshmi.  This requires moving the code around.  Instead of
> > doing this on the current code base, I suggest posting a v9 version of
> > the entire "IMA: Deferred measurement of keys".
> > 
> > I suggest making the switch from spinlock to mutex, as you had it
> > originally, before posting v9.  The commit history will then be a lot
> > cleaner.
> > 
> > thanks,
> > 
> > Mimi
> > 
> 
> Sure Mimi - I'll post an update to the patch set shortly.

I just pushed out the next-integrity-testing branch without the
"Deferred measurement of keys" patches.  I've kept the "IMA: pre-
allocate buffer to hold keyrings string" patch, though it probably
isn't required.

thanks,

Mimi

