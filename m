Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F27C4145455
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jan 2020 13:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgAVMXP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jan 2020 07:23:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19410 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728912AbgAVMXO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jan 2020 07:23:14 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MCMWfk062243
        for <linux-integrity@vger.kernel.org>; Wed, 22 Jan 2020 07:23:13 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xp95fecwn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 22 Jan 2020 07:23:13 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 22 Jan 2020 12:23:12 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Jan 2020 12:23:09 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00MCN8YR20512960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jan 2020 12:23:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B925FAE053;
        Wed, 22 Jan 2020 12:23:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B48CAE04D;
        Wed, 22 Jan 2020 12:23:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.146.245])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Jan 2020 12:23:07 +0000 (GMT)
Subject: Re: [PATCH] IMA: Turn IMA_MEASURE_ASYMMETRIC_KEYS off by default
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 22 Jan 2020 07:23:07 -0500
In-Reply-To: <1579636351.3390.35.camel@HansenPartnership.com>
References: <20200121171302.4935-1-nramas@linux.microsoft.com>
         <1579628090.3390.28.camel@HansenPartnership.com>
         <1579634035.5125.311.camel@linux.ibm.com>
         <1579636351.3390.35.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012212-4275-0000-0000-00000399E783
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012212-4276-0000-0000-000038ADF27D
Message-Id: <1579695787.5182.29.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001220114
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-01-21 at 11:52 -0800, James Bottomley wrote:
> On Tue, 2020-01-21 at 14:13 -0500, Mimi Zohar wrote:

> > This change permits disabling queueing certificates.  Whether the
> > default should be "disabled" is a separate question.  I'm open to
> > comments/suggestions.
> 
> I'm just giving the general rule of thumb for boolean config options. 
> If it's default Y there likely shouldn't be a config option and if it's
> default N the feature should likely not be in the kernel at all.

Thanks, James.  I'll keep this in mind when debating about defining a
new Kconfig option.

Mimi

