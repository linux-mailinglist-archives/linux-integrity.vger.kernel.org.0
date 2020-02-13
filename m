Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2828015B5F8
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2020 01:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbgBMAix (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Feb 2020 19:38:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729366AbgBMAix (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Feb 2020 19:38:53 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01D0cqbW135437
        for <linux-integrity@vger.kernel.org>; Wed, 12 Feb 2020 19:38:52 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y4j8axjvj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 12 Feb 2020 19:38:51 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 13 Feb 2020 00:38:35 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Feb 2020 00:38:31 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01D0cUga52887748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 00:38:30 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7163AA405C;
        Thu, 13 Feb 2020 00:38:30 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73DB8A4054;
        Thu, 13 Feb 2020 00:38:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.191.187])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Feb 2020 00:38:29 +0000 (GMT)
Subject: Re: [PATCH v3 3/3] IMA: Add module name and base name prefix to log.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        joe@perches.com, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 12 Feb 2020 19:38:28 -0500
In-Reply-To: <d428f807-7e67-a173-183d-f2ab15bdef9e@linuxfoundation.org>
References: <20200211231414.6640-1-tusharsu@linux.microsoft.com>
         <20200211231414.6640-4-tusharsu@linux.microsoft.com>
         <1581517770.8515.35.camel@linux.ibm.com>
         <1581521161.3494.7.camel@HansenPartnership.com>
         <d428f807-7e67-a173-183d-f2ab15bdef9e@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021300-0016-0000-0000-000002E6472F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021300-0017-0000-0000-0000334945E0
Message-Id: <1581554308.8515.108.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_10:2020-02-12,2020-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130004
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-02-12 at 15:52 -0700, Shuah Khan wrote:
> On 2/12/20 8:26 AM, James Bottomley wrote:
> > On Wed, 2020-02-12 at 09:29 -0500, Mimi Zohar wrote:
> >> On Tue, 2020-02-11 at 15:14 -0800, Tushar Sugandhi wrote:
> >>> The #define for formatting log messages, pr_fmt, is duplicated in
> >>> the
> >>> files under security/integrity.
> >>>
> >>> This change moves the definition to security/integrity/integrity.h
> >>> and
> >>> removes the duplicate definitions in the other files under
> >>> security/integrity. Also, it adds KBUILD_MODNAME and
> >>> KBUILD_BASENAME prefix
> >>> to the log messages.
> >>>
> >>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> >>> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> >>> Suggested-by: Joe Perches <joe@perches.com>
> >>> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> >>
> >> <snip>
> >>
> >>> diff --git a/security/integrity/integrity.h
> >>> b/security/integrity/integrity.h
> >>> index 73fc286834d7..b1bb4d2263be 100644
> >>> --- a/security/integrity/integrity.h
> >>> +++ b/security/integrity/integrity.h
> >>> @@ -6,6 +6,12 @@
> >>>    * Mimi Zohar <zohar@us.ibm.com>
> >>>    */
> >>>   
> >>> +#ifdef pr_fmt
> >>> +#undef pr_fmt
> >>> +#endif
> >>> +
> >>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " KBUILD_BASENAME ": " fmt
> >>> +
> >>>   #include <linux/types.h>
> >>>   #include <linux/integrity.h>
> >>>   #include <crypto/sha.h>
> >>
> >> Joe, Shuah, including the pr_fmt() in integrity/integrity.h not only
> >> affects the integrity directory but everything below it.  Adding
> >> KBUILD_BASENAME to pr_fmt() modifies all of the existing IMA and EVM
> >> kernel messages.  Is that ok or should there be a separate pr_fmt()
> >> for the subdirectories?
> > 
> 
> > Log messages are often consumed by log monitors, which mostly use
> > pattern matching to find messages they're interested in, so you have to
> > take some care when changing the messages the kernel spits out and you
> > have to make sure any change gets well notified so the distributions
> > can warn about it.
> > 
> > For this one, can we see a "before" and "after" message so we know
> > what's happening?
> > 
> 
> Mimi and James,
> 
> My suggestion was based on thinking that simplifying this by removing
> duplicate defines. Some messages are missing modules names, adding
> module name to them does change the messages.
> 
> If using one pr_fmt for all modules changes the world and makes it
> difficult for log monitors, I would say it isn't a good change.
> 
> I will leave this totally up to Mimi to decide. Feel free to throw
> out my suggestion if it leads more trouble than help. :)

Thanks, Shuah.  Tushar, I don't see any need for changing the existing
IMA/EVM messages.  Either remove the KBUILD_BASENAME from the format
or limit the new format to the integrity directory.

thanks,

Mimi

