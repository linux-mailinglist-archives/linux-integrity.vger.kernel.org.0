Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C34B21647E
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 05:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgGGDTE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 23:19:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726540AbgGGDTD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 23:19:03 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06734d4W100927;
        Mon, 6 Jul 2020 23:18:52 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 324f7dj9j2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 23:18:52 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06734lgh101458;
        Mon, 6 Jul 2020 23:18:52 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 324f7dj9hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 23:18:52 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0673G8uZ023109;
        Tue, 7 Jul 2020 03:18:49 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 322hd7tx1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 03:18:49 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0673Il293735930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jul 2020 03:18:47 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9351911C052;
        Tue,  7 Jul 2020 03:18:47 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 810DD11C04A;
        Tue,  7 Jul 2020 03:18:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.174.194])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Jul 2020 03:18:46 +0000 (GMT)
Message-ID: <1594091925.23056.36.camel@linux.ibm.com>
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
Date:   Mon, 06 Jul 2020 23:18:45 -0400
In-Reply-To: <20200706131845.GI4694@sequoia>
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
         <20200626223900.253615-10-tyhicks@linux.microsoft.com>
         <1593558449.5057.12.camel@linux.ibm.com> <20200702221656.GH4694@sequoia>
         <1593785732.23056.16.camel@linux.ibm.com> <20200706131845.GI4694@sequoia>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_01:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015
 cotscore=-2147483648 mlxscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007070023
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-07-06 at 08:18 -0500, Tyler Hicks wrote:
> On 2020-07-03 10:15:32, Mimi Zohar wrote:
> > On Thu, 2020-07-02 at 17:16 -0500, Tyler Hicks wrote:
> > > On 2020-06-30 19:07:29, Mimi Zohar wrote:
> > > > On Fri, 2020-06-26 at 17:38 -0500, Tyler Hicks wrote:
> > > > > Use ima_validate_rule() to ensure that the combination of a hook
> > > > > function and the keyrings conditional is valid and that the keyrings
> > > > > conditional is not specified without an explicit KEY_CHECK func
> > > > > conditional. This is a code cleanup and has no user-facing change.
> > > > > 
> > > > > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > > > > ---
> > > > > 
> > > > > * v2
> > > > >   - Allowed IMA_DIGSIG_REQUIRED, IMA_PERMIT_DIRECTIO,
> > > > >     IMA_MODSIG_ALLOWED, and IMA_CHECK_BLACKLIST conditionals to be
> > > > >     present in the rule entry flags for non-buffer hook functions.
> > > > > 
> > > > >  security/integrity/ima/ima_policy.c | 13 +++++++++++--
> > > > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > > > > index 8cdca2399d59..43d49ad958fb 100644
> > > > > --- a/security/integrity/ima/ima_policy.c
> > > > > +++ b/security/integrity/ima/ima_policy.c
> > > > > @@ -1000,6 +1000,15 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
> > > > >  		case KEXEC_KERNEL_CHECK:
> > > > >  		case KEXEC_INITRAMFS_CHECK:
> > > > >  		case POLICY_CHECK:
> > > > > +			if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
> > > > > +					     IMA_UID | IMA_FOWNER | IMA_FSUUID |
> > > > > +					     IMA_INMASK | IMA_EUID | IMA_PCR |
> > > > > +					     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
> > > > > +					     IMA_PERMIT_DIRECTIO |
> > > > > +					     IMA_MODSIG_ALLOWED |
> > > > > +					     IMA_CHECK_BLACKLIST))
> > > > 
> > > > Other than KEYRINGS, this patch should continue to behave the same.
> > > >  However, this list gives the impressions that all of these flags are
> > > > permitted on all of the above flags, which isn't true.
> > > > 
> > > > For example, both IMA_MODSIG_ALLOWED & IMA_CHECK_BLACKLIST are limited
> > > > to appended signatures, meaning KERNEL_CHECK and KEXEC_KERNEL_CHECK.
> > > 
> > > Just to clarify, are both IMA_MODSIG_ALLOWED and IMA_CHECK_BLACKLIST
> > > limited to KEXEC_KERNEL_CHECK, KEXEC_INITRAMFS_CHECK, and MODULE_CHECK?
> > > That's what ima_hook_supports_modsig() suggests.
> > 
> > Theoretically that is true, but I have no idea how you would append a
> > signature to the kexec boot command line.  The only users of appended
> > signatures are currently kernel modules and the kexec'ed kernel image.
> 
> The discrepancy was with KEXEC_INITRAMFS_CHECK, not KEXEC_CMDLINE. I now
> see that there's no support for initramfs signature verification in the
> kexec code so I'll assume that ima_hook_supports_modsig() is wrong and
> limit IMA_MODSIG_ALLOWED and IMA_CHECK_BLACKLIST to the
> KEXEC_KERNEL_CHECK and MODULE_CHECK actions, as you originally
> suggested.

My mistake.  Yes, both the kexec kernel image and the initramfs read
the respective file into memory and can be signed either with an
imasig or modsig.  Refer to kernel_read_file_from_fd().

Mimi
