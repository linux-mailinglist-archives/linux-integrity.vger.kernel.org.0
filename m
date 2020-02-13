Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C23C15B5C1
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2020 01:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgBMAWE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Feb 2020 19:22:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729132AbgBMAWC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Feb 2020 19:22:02 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01D0J11f071175
        for <linux-integrity@vger.kernel.org>; Wed, 12 Feb 2020 19:22:00 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y4j8ax5mj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 12 Feb 2020 19:21:59 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 13 Feb 2020 00:21:58 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Feb 2020 00:21:54 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01D0Lrd658720472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 00:21:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A81D11C050;
        Thu, 13 Feb 2020 00:21:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D97411C05C;
        Thu, 13 Feb 2020 00:21:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.191.187])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Feb 2020 00:21:52 +0000 (GMT)
Subject: Re: [PATCH v3 2/3] IMA: Add log statements for failure conditions.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>, joe@perches.com,
        skhan@linuxfoundation.org, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 12 Feb 2020 19:21:51 -0500
In-Reply-To: <ce89d382-8e8b-71d0-5271-4db83d324f94@linux.microsoft.com>
References: <20200211231414.6640-1-tusharsu@linux.microsoft.com>
         <20200211231414.6640-3-tusharsu@linux.microsoft.com>
         <1581518823.8515.49.camel@linux.ibm.com>
         <ce89d382-8e8b-71d0-5271-4db83d324f94@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021300-0020-0000-0000-000003A9992F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021300-0021-0000-0000-00002201815E
Message-Id: <1581553311.8515.96.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_10:2020-02-12,2020-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=772 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130001
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-02-12 at 14:30 -0800, Tushar Sugandhi wrote:
> 
> On 2020-02-12 6:47 a.m., Mimi Zohar wrote:
> > Hi Tushar,
> > 
> > Please remove the period at the end of the  Subject line.
> Thanks. I will fix it in the next iteration.
> > 
> > On Tue, 2020-02-11 at 15:14 -0800, Tushar Sugandhi wrote:
> >> process_buffer_measurement() does not have log messages for failure
> >> conditions.
> >>
> >> This change adds a log statement in the above function.
> > 
> > I agree some form of notification needs to be added.  The question is
> > whether the failure should be audited or a kernel message emitted.
> >   IMA emits audit messages (integrity_audit_msg) for a number of
> > reasons - on failure to calculate a file hash, invalid policy rules,
> > failure to communicate with the TPM, signature verification errors,
> > etc.
> I believe both IMA audit messages and kernel message should be emitted -
> for better discoverability and diagnosability.

Like file measurement failures, failure to measure a key or the boot
command line should be audited as well.  For debugging purposes, you
could make this message pr_devel.

Mimi

