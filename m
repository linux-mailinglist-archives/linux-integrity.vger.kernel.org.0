Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4D8213BAA
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jul 2020 16:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGCOPu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jul 2020 10:15:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41344 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726035AbgGCOPu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jul 2020 10:15:50 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 063E2DsI145405;
        Fri, 3 Jul 2020 10:15:39 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 322144rw0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jul 2020 10:15:39 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 063E2FJd145553;
        Fri, 3 Jul 2020 10:15:39 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 322144rvyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jul 2020 10:15:39 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 063E6ksY001304;
        Fri, 3 Jul 2020 14:15:36 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 31wwcguf0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jul 2020 14:15:36 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 063EFYpJ52232204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jul 2020 14:15:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0303B11C04C;
        Fri,  3 Jul 2020 14:15:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBA3511C050;
        Fri,  3 Jul 2020 14:15:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.174.143])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Jul 2020 14:15:32 +0000 (GMT)
Message-ID: <1593785732.23056.16.camel@linux.ibm.com>
Subject: Re: [PATCH v2 09/11] ima: Move validation of the keyrings
 conditional into ima_validate_rule()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Fri, 03 Jul 2020 10:15:32 -0400
In-Reply-To: <20200702221656.GH4694@sequoia>
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
         <20200626223900.253615-10-tyhicks@linux.microsoft.com>
         <1593558449.5057.12.camel@linux.ibm.com> <20200702221656.GH4694@sequoia>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-03_09:2020-07-02,2020-07-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 cotscore=-2147483648
 suspectscore=0 adultscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007030095
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-07-02 at 17:16 -0500, Tyler Hicks wrote:
> On 2020-06-30 19:07:29, Mimi Zohar wrote:
> > On Fri, 2020-06-26 at 17:38 -0500, Tyler Hicks wrote:
> > > Use ima_validate_rule() to ensure that the combination of a hook
> > > function and the keyrings conditional is valid and that the keyrings
> > > conditional is not specified without an explicit KEY_CHECK func
> > > conditional. This is a code cleanup and has no user-facing change.
> > > 
> > > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > > ---
> > > 
> > > * v2
> > >   - Allowed IMA_DIGSIG_REQUIRED, IMA_PERMIT_DIRECTIO,
> > >     IMA_MODSIG_ALLOWED, and IMA_CHECK_BLACKLIST conditionals to be
> > >     present in the rule entry flags for non-buffer hook functions.
> > > 
> > >  security/integrity/ima/ima_policy.c | 13 +++++++++++--
> > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > > index 8cdca2399d59..43d49ad958fb 100644
> > > --- a/security/integrity/ima/ima_policy.c
> > > +++ b/security/integrity/ima/ima_policy.c
> > > @@ -1000,6 +1000,15 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
> > >  		case KEXEC_KERNEL_CHECK:
> > >  		case KEXEC_INITRAMFS_CHECK:
> > >  		case POLICY_CHECK:
> > > +			if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
> > > +					     IMA_UID | IMA_FOWNER | IMA_FSUUID |
> > > +					     IMA_INMASK | IMA_EUID | IMA_PCR |
> > > +					     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
> > > +					     IMA_PERMIT_DIRECTIO |
> > > +					     IMA_MODSIG_ALLOWED |
> > > +					     IMA_CHECK_BLACKLIST))
> > 
> > Other than KEYRINGS, this patch should continue to behave the same.
> >  However, this list gives the impressions that all of these flags are
> > permitted on all of the above flags, which isn't true.
> > 
> > For example, both IMA_MODSIG_ALLOWED & IMA_CHECK_BLACKLIST are limited
> > to appended signatures, meaning KERNEL_CHECK and KEXEC_KERNEL_CHECK.
> 
> Just to clarify, are both IMA_MODSIG_ALLOWED and IMA_CHECK_BLACKLIST
> limited to KEXEC_KERNEL_CHECK, KEXEC_INITRAMFS_CHECK, and MODULE_CHECK?
> That's what ima_hook_supports_modsig() suggests.

Theoretically that is true, but I have no idea how you would append a
signature to the kexec boot command line.  The only users of appended
signatures are currently kernel modules and the kexec'ed kernel image.

> 
> >  Both should only be allowed on APPRAISE action rules.
> 
> For completeness, it looks like DONT_APPRAISE should not be allowed.

Good point.  

> 
> > IMA_PCR should be limited to MEASURE action rules.
> 
> It looks like DONT_MEASURE should not be allowed.

The TPM PCR isn't a file attribute.

> 
> > IMA_DIGSIG_REQUIRED should be limited to APPRAISE action rules.
> 
> It looks like DONT_APPRAISE should not be allowed.

Right, in all of these cases the DONT_XXXX isn't applicable.

Mimi
