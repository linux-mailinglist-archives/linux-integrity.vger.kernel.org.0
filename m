Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D09914EE48
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2020 15:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgAaOWR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jan 2020 09:22:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728752AbgAaOWO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jan 2020 09:22:14 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VEKBdp118653
        for <linux-integrity@vger.kernel.org>; Fri, 31 Jan 2020 09:22:13 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xvkxcm94n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 31 Jan 2020 09:22:13 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 31 Jan 2020 14:22:11 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 31 Jan 2020 14:22:07 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00VEM61T52559894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 14:22:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9C3DA4040;
        Fri, 31 Jan 2020 14:22:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F32F7A4057;
        Fri, 31 Jan 2020 14:22:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.193.32])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 31 Jan 2020 14:22:05 +0000 (GMT)
Subject: Re: [PATCH 7/8] ima: use ima_hash_algo for collision detection in
 the measurement list
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "james.bottomley@hansenpartnership.com" 
        <james.bottomley@hansenpartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Fri, 31 Jan 2020 09:22:05 -0500
In-Reply-To: <44c1b3f6d3fe414e914317ef8e5c6f8f@huawei.com>
References: <20200127170443.21538-1-roberto.sassu@huawei.com>
         <20200127170443.21538-8-roberto.sassu@huawei.com>
         <1580423169.6104.18.camel@linux.ibm.com>
         <44c1b3f6d3fe414e914317ef8e5c6f8f@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20013114-0028-0000-0000-000003D6478B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013114-0029-0000-0000-0000249A99D3
Message-Id: <1580480525.6104.88.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-31_03:2020-01-31,2020-01-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1911200001
 definitions=main-2001310123
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-01-31 at 14:02 +0000, Roberto Sassu wrote:
> > -----Original Message-----
> > From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
> > owner@vger.kernel.org] On Behalf Of Mimi Zohar
> > Sent: Thursday, January 30, 2020 11:26 PM
> > To: Roberto Sassu <roberto.sassu@huawei.com>;
> > jarkko.sakkinen@linux.intel.com;
> > james.bottomley@hansenpartnership.com; linux-integrity@vger.kernel.org
> > Cc: linux-security-module@vger.kernel.org; linux-kernel@vger.kernel.org;
> > Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
> > Subject: Re: [PATCH 7/8] ima: use ima_hash_algo for collision detection in
> > the measurement list
> > 
> > On Mon, 2020-01-27 at 18:04 +0100, Roberto Sassu wrote:
> > > Before calculating a digest for each PCR bank, collisions were detected
> > > with a SHA1 digest. This patch includes ima_hash_algo among the
> > algorithms
> > > used to calculate the template digest and checks collisions on that digest.
> > >
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Definitely needed to protect against a sha1 collision attack.
> > 
> > <snip>
> > 
> > >
> > > diff --git a/security/integrity/ima/ima_api.c
> > b/security/integrity/ima/ima_api.c
> > > index ebaf0056735c..a9bb45de6db9 100644
> > > --- a/security/integrity/ima/ima_api.c
> > > +++ b/security/integrity/ima/ima_api.c
> > > @@ -51,7 +51,7 @@ int ima_alloc_init_template(struct ima_event_data
> > *event_data,
> > >  	if (!*entry)
> > >  		return -ENOMEM;
> > >
> > > -	(*entry)->digests = kcalloc(ima_tpm_chip->nr_allocated_banks + 1,
> > > +	(*entry)->digests = kcalloc(ima_tpm_chip->nr_allocated_banks + 2,
> > >  				    sizeof(*(*entry)->digests), GFP_NOFS);
> > >  	if (!(*entry)->digests) {
> > >  		result = -ENOMEM;
> > 
> > I would prefer not having to allocate and use "nr_allocated_banks + 1"
> > everywhere, but I understand the need for it.  I'm not sure this patch
> > warrants allocating +2.  Perhaps, if a TPM bank doesn't exist for the
> > IMA default hash algorithm, use a different algorithm or, worst case,
> > continue using the ima_sha1_idx.
> 
> We could introduce a new option called ima_hash_algo_tpm to specify
> the algorithm of an allocated bank. We can use this for boot_aggregate
> and hash collision detection.

I don't think that would work in the case where the IMA default hash
is set to sha256, but the system has a TPM 1.2 chip.  We would be left
using SHA1 for the file hash collision detection.

With my suggestion of defining an "extra" variable, I kind of back
tracked here.  There are two problems that I'm trying to address -
hard coding the number of additional "banks" and unnecessarily
allocating more memory than necessary.  By pre-walking the list,
calculating the "extra" banks, you'll resolve both issues.

Mimi

