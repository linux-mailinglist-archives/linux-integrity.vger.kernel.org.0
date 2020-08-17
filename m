Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68426247AFF
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 01:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgHQXMK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 19:12:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726228AbgHQXMJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 19:12:09 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07HN37eD091832;
        Mon, 17 Aug 2020 19:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=UCJWVIK28veYaPIDUqNW8719rMbBrhSOt+H9AZPG+9c=;
 b=bVyVISx1k+MOf81qf9OWkTEb5L5Zr26h2lfHM5TNnR5Elmo2trfJlzwSQB5ET8r96A+h
 6mtfhfz1tgBIMJxvoP8mDZ2JS/F5T6Zyj6jjHdp+Cmr4tzpszVmaC+Cc+K4PF0LUaIUd
 igLsB9Phe6nMlTq1McFJGDlade4KrY45BCGJ/E1mKdoyryYY1In1YpyNEKAjn2U4yPkh
 QA3nxU2YmNXvfRH+EzZ2STwORJq5kD8AXbbK1dyXrS72tfRnZi5dF6prga4Ayb+j79si
 1fFVKfG+vMsD0r+RP+DunXw0RSy0GQ2EPoFJtbMZD8bedWxx67JvIUnYzvesDN3R/q1t Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32yy8enuta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 19:12:02 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07HN6Cr6103395;
        Mon, 17 Aug 2020 19:12:02 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32yy8enust-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 19:12:02 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07HN4pJm030578;
        Mon, 17 Aug 2020 23:12:00 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 32x7b7hp23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 23:12:00 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07HNBwIe23200160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Aug 2020 23:11:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D74DA405F;
        Mon, 17 Aug 2020 23:11:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABA91A405B;
        Mon, 17 Aug 2020 23:11:54 +0000 (GMT)
Received: from sig-9-65-192-88.ibm.com (unknown [9.65.192.88])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Aug 2020 23:11:54 +0000 (GMT)
Message-ID: <082a4311cd9211475df4c694f310f652d51e5d64.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] SELinux: Measure state and hash of policy using IMA
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Aug 2020 19:11:53 -0400
In-Reply-To: <089ca24d-863b-ca84-4859-d2d6e4f09b4c@linux.microsoft.com>
References: <20200813170707.2659-1-nramas@linux.microsoft.com>
         <20200813170707.2659-3-nramas@linux.microsoft.com>
         <5f738fd8-fe28-5358-b3d8-b671b45caa7f@gmail.com>
         <7315b7e8-2c53-2555-bc2e-aae42e16aaa2@linux.microsoft.com>
         <CAEjxPJ6sZdm2w=bbkL0uJyEkHw0gCT_y812WQBZPtLCJzO6r3A@mail.gmail.com>
         <e935c06f-09e2-a2f7-f97f-768bc017f477@linux.microsoft.com>
         <CAEjxPJ7uWee5jjALtQ3azMvKRMk8pxFiYByWmYVhjgJiMNZ8ww@mail.gmail.com>
         <3679df359c35561f5bf6608911f96cc0292c7854.camel@linux.ibm.com>
         <57f972a7-26f1-3ac7-4001-54c0bc7e12a8@schaufler-ca.com>
         <089ca24d-863b-ca84-4859-d2d6e4f09b4c@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-17_15:2020-08-17,2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=3 impostorscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008170154
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-08-17 at 15:33 -0700, Lakshmi Ramasubramanian wrote:
> On 8/17/20 3:00 PM, Casey Schaufler wrote:
> > On 8/17/2020 2:31 PM, Mimi Zohar wrote:
> > > On Thu, 2020-08-13 at 14:13 -0400, Stephen Smalley wrote:
> > > > On Thu, Aug 13, 2020 at 2:03 PM Lakshmi Ramasubramanian
> > > > <nramas@linux.microsoft.com> wrote:
> > > > > On 8/13/20 10:58 AM, Stephen Smalley wrote:
> > > > > > On Thu, Aug 13, 2020 at 1:52 PM Lakshmi Ramasubramanian
> > > > > > <nramas@linux.microsoft.com> wrote:
> > > > > > > On 8/13/20 10:42 AM, Stephen Smalley wrote:
> > > > > > > 
> > > > > > > > > diff --git a/security/selinux/measure.c b/security/selinux/measure.c
> > > > > > > > > new file mode 100644
> > > > > > > > > index 000000000000..f21b7de4e2ae
> > > > > > > > > --- /dev/null
> > > > > > > > > +++ b/security/selinux/measure.c
> > > > > > > > > @@ -0,0 +1,204 @@
> > > > > > > > > +static int selinux_hash_buffer(void *buf, size_t buf_len,
> > > > > > > > > +                   void **buf_hash, int *buf_hash_len)
> > > > > > > > > +{
> > > > > > > > > +    struct crypto_shash *tfm;
> > > > > > > > > +    struct shash_desc *desc = NULL;
> > > > > > > > > +    void *digest = NULL;
> > > > > > > > > +    int desc_size;
> > > > > > > > > +    int digest_size;
> > > > > > > > > +    int ret = 0;
> > > > > > > > > +
> > > > > > > > > +    tfm = crypto_alloc_shash("sha256", 0, 0);
> > > > > > > > > +    if (IS_ERR(tfm))
> > > > > > > > > +        return PTR_ERR(tfm);
> > > > > > > > Can we make the algorithm selectable via kernel parameter and/or writing
> > > > > > > > to a new selinuxfs node?
> > > > > > > I can add a kernel parameter to select this hash algorithm.
> > > > > > Also can we provide a Kconfig option for the default value like IMA does?
> > > > > > 
> > > > > Would we need both - Kconfig and kernel param?
> > > > > 
> > > > > The other option is to provide an IMA function to return the current
> > > > > hash algorithm used for measurement. That way a consistent hash
> > > > > algorithm can be employed by both IMA and the callers. Would that be better?
> > > > This is why I preferred just passing the serialized policy buffer to
> > > > IMA and letting it handle the hashing.  But apparently that approach
> > > > wouldn't fly.  IMA appears to support both a Kconfig option for
> > > > selecting a default algorithm and a kernel parameter for overriding
> > > > it.  I assume the idea is that the distros can pick a reasonable
> > > > default and then the end users can override that if they have specific
> > > > requirements.  I'd want the same for SELinux.  If IMA is willing to
> > > > export its hash algorithm to external components, then I'm willing to
> > > > reuse that but not sure if that's a layering violation.
> > > With the new ima_measure_critical_data() hook, I agree with you and
> > > Casey it doesn't make sense for each caller to have to write their own
> > > function.  Casey suggested exporting IMA's hash function or defining a
> > > new common hash function.   There's nothing specific to IMA.
> > 
> > Except that no one is going to use the function unless they're
> > doing an IMA operation.
> 
> Can we do the following instead:
> 
> In ima_measure_critical_data() IMA hook, we can add another param for 
> the caller to indicate whether
> 
>   => The contents of "buf" needs to be measured
>      OR
>   => Hash of the contents of "buf" needs to be measured.
> 
> This way IMA doesn't need to export any new function to meet the hashing 
> requirement.

I'm not sure overloading the parameters is a good idea, but extending
ima_measure_critical_data() to calculate a simple buffer hash should be
fine.

Mimi

