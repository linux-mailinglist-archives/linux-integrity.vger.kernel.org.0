Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F854145CD1
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jan 2020 21:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgAVUDM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jan 2020 15:03:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23030 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725928AbgAVUDI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jan 2020 15:03:08 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MJwC3g010214
        for <linux-integrity@vger.kernel.org>; Wed, 22 Jan 2020 15:03:07 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xp1jhgs5r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 22 Jan 2020 15:03:07 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 22 Jan 2020 20:03:04 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Jan 2020 20:03:01 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00MK30TE54263984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jan 2020 20:03:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2906A4055;
        Wed, 22 Jan 2020 20:03:00 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A2C6A4040;
        Wed, 22 Jan 2020 20:03:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.146.245])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Jan 2020 20:03:00 +0000 (GMT)
Subject: Re: [PATCH] IMA: Turn IMA_MEASURE_ASYMMETRIC_KEYS off by default
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 22 Jan 2020 15:02:59 -0500
In-Reply-To: <ac6c559e-2d68-afcb-d316-6ac49a570831@linux.microsoft.com>
References: <20200121171302.4935-1-nramas@linux.microsoft.com>
         <1579628090.3390.28.camel@HansenPartnership.com>
         <1579634035.5125.311.camel@linux.ibm.com>
         <1579636351.3390.35.camel@HansenPartnership.com>
         <ac6c559e-2d68-afcb-d316-6ac49a570831@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012220-0012-0000-0000-0000037FC8B4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012220-0013-0000-0000-000021BC0D3A
Message-Id: <1579723379.5182.130.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-22_08:2020-01-22,2020-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001220169
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-01-21 at 12:38 -0800, Lakshmi Ramasubramanian wrote:
> On 1/21/2020 11:52 AM, James Bottomley wrote:
> 
> >> - really small devices/sensors being able to queue certificates
> > 
> > seems like the answer to this one would be don't queue.  I realise it's
> > after the submit design, but what about measuring when the key is added
> > if there's a policy otherwise measure the keyring when the policy is
> > added ... that way no queueing.
> 
> Without the "deferred key processing" changes, only keys added at 
> runtime were measured (if policy permitted).
> 
> "deferred key processing" enabled queuing keys added early in the boot 
> process and measured them when the policy is loaded.
> 
> We can make this (the queuing) optional through a config, but leave the 
> runtime key measurement auto-enabled (as is the config 
> IMA_MEASURE_ASYMMETRIC_KEYS now).

Thanks, Lakshmi.  This requires moving the code around.  Instead of
doing this on the current code base, I suggest posting a v9 version of
the entire "IMA: Deferred measurement of keys".

I suggest making the switch from spinlock to mutex, as you had it
originally, before posting v9.  The commit history will then be a lot
cleaner.

thanks,

Mimi

