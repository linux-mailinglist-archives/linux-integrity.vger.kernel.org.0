Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22B82478DB
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 23:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgHQVbs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 17:31:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726634AbgHQVbr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 17:31:47 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07HLVO69090850;
        Mon, 17 Aug 2020 17:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+nm5Nsmsy/OTc99Ozqqqkn9dcRVL+LpUb4N0T+s2fss=;
 b=trm6KuAvcokWjpj8iiSIbOg3u1mqZQAvWuz3O37brBYaa0wnh7ZSwuR4874PN9jCShWj
 uVLybnxrS6JyaBM6mp+s7bvU82VcT6Yh2oh/9zvHJMIS56dE5qNJaYLeF416lATBd0Os
 olCUBt5zCVt/XjJwtTIuYN3P7UZf2geEz4i1uo0jVisYxWKfOduwk71KWE/f8LOJ7EpN
 hoeHRNNsM661KEv+B05pt0sxnG24VIJBbsn+m2b6RZ9ZJGRmd7wZ51Hi9jEOgsKB2chg
 mo6+njcNAvN6pn2z6U57b9k2UbDJzVixAt/rZX0ePhB2LRyxFtmyW3IKVEqp+IE79qJH cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32y7nhg0rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 17:31:40 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07HLVe1n092054;
        Mon, 17 Aug 2020 17:31:40 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32y7nhg0r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 17:31:39 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07HLGGmi024497;
        Mon, 17 Aug 2020 21:31:38 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 32x7b81me9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 21:31:38 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07HLVZVc23200134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Aug 2020 21:31:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B06164C04A;
        Mon, 17 Aug 2020 21:31:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AECD4C046;
        Mon, 17 Aug 2020 21:31:33 +0000 (GMT)
Received: from sig-9-65-192-88.ibm.com (unknown [9.65.192.88])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Aug 2020 21:31:33 +0000 (GMT)
Message-ID: <3679df359c35561f5bf6608911f96cc0292c7854.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] SELinux: Measure state and hash of policy using IMA
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Aug 2020 17:31:27 -0400
In-Reply-To: <CAEjxPJ7uWee5jjALtQ3azMvKRMk8pxFiYByWmYVhjgJiMNZ8ww@mail.gmail.com>
References: <20200813170707.2659-1-nramas@linux.microsoft.com>
         <20200813170707.2659-3-nramas@linux.microsoft.com>
         <5f738fd8-fe28-5358-b3d8-b671b45caa7f@gmail.com>
         <7315b7e8-2c53-2555-bc2e-aae42e16aaa2@linux.microsoft.com>
         <CAEjxPJ6sZdm2w=bbkL0uJyEkHw0gCT_y812WQBZPtLCJzO6r3A@mail.gmail.com>
         <e935c06f-09e2-a2f7-f97f-768bc017f477@linux.microsoft.com>
         <CAEjxPJ7uWee5jjALtQ3azMvKRMk8pxFiYByWmYVhjgJiMNZ8ww@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-17_15:2020-08-17,2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 suspectscore=3 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008170144
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-08-13 at 14:13 -0400, Stephen Smalley wrote:
> On Thu, Aug 13, 2020 at 2:03 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
> > On 8/13/20 10:58 AM, Stephen Smalley wrote:
> > > On Thu, Aug 13, 2020 at 1:52 PM Lakshmi Ramasubramanian
> > > <nramas@linux.microsoft.com> wrote:
> > > > On 8/13/20 10:42 AM, Stephen Smalley wrote:
> > > > 
> > > > > > diff --git a/security/selinux/measure.c b/security/selinux/measure.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..f21b7de4e2ae
> > > > > > --- /dev/null
> > > > > > +++ b/security/selinux/measure.c
> > > > > > @@ -0,0 +1,204 @@
> > > > > > +static int selinux_hash_buffer(void *buf, size_t buf_len,
> > > > > > +                   void **buf_hash, int *buf_hash_len)
> > > > > > +{
> > > > > > +    struct crypto_shash *tfm;
> > > > > > +    struct shash_desc *desc = NULL;
> > > > > > +    void *digest = NULL;
> > > > > > +    int desc_size;
> > > > > > +    int digest_size;
> > > > > > +    int ret = 0;
> > > > > > +
> > > > > > +    tfm = crypto_alloc_shash("sha256", 0, 0);
> > > > > > +    if (IS_ERR(tfm))
> > > > > > +        return PTR_ERR(tfm);
> > > > > Can we make the algorithm selectable via kernel parameter and/or writing
> > > > > to a new selinuxfs node?
> > > > 
> > > > I can add a kernel parameter to select this hash algorithm.
> > > 
> > > Also can we provide a Kconfig option for the default value like IMA does?
> > > 
> > 
> > Would we need both - Kconfig and kernel param?
> > 
> > The other option is to provide an IMA function to return the current
> > hash algorithm used for measurement. That way a consistent hash
> > algorithm can be employed by both IMA and the callers. Would that be better?
> 
> This is why I preferred just passing the serialized policy buffer to
> IMA and letting it handle the hashing.  But apparently that approach
> wouldn't fly.  IMA appears to support both a Kconfig option for
> selecting a default algorithm and a kernel parameter for overriding
> it.  I assume the idea is that the distros can pick a reasonable
> default and then the end users can override that if they have specific
> requirements.  I'd want the same for SELinux.  If IMA is willing to
> export its hash algorithm to external components, then I'm willing to
> reuse that but not sure if that's a layering violation.

With the new ima_measure_critical_data() hook, I agree with you and
Casey it doesn't make sense for each caller to have to write their own
function.  Casey suggested exporting IMA's hash function or defining a
new common hash function.   There's nothing specific to IMA.  Should
the common hash function be prefixed with "security_"?

Like when we add a new security hook call, the new LSM call is separate
from any other change.   Please break up this patch with the SELinux
specific pieces separated from the ima_measure_critical_data() call as
much as possible.

thanks,

Mimi

