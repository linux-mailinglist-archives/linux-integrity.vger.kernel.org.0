Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7FF14EE0B
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2020 14:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAaN6h (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jan 2020 08:58:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1192 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728726AbgAaN6h (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jan 2020 08:58:37 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VDspoU102046
        for <linux-integrity@vger.kernel.org>; Fri, 31 Jan 2020 08:58:36 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xvfy95py9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 31 Jan 2020 08:58:36 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 31 Jan 2020 13:58:33 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 31 Jan 2020 13:58:30 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00VDvbgW32440784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 13:57:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7413152050;
        Fri, 31 Jan 2020 13:58:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.193.32])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 91D605204F;
        Fri, 31 Jan 2020 13:58:28 +0000 (GMT)
Subject: Re: [PATCH 5/8] ima: allocate and initialize tfm for each PCR bank
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
Date:   Fri, 31 Jan 2020 08:58:28 -0500
In-Reply-To: <17b00b78aa2249f19ba376c7613cfb38@huawei.com>
References: <20200127170443.21538-1-roberto.sassu@huawei.com>
         <20200127170443.21538-6-roberto.sassu@huawei.com>
         <1580473133.6104.48.camel@linux.ibm.com>
         <17b00b78aa2249f19ba376c7613cfb38@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20013113-0008-0000-0000-0000034E933D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013113-0009-0000-0000-00004A6F175D
Message-Id: <1580479108.6104.73.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-31_03:2020-01-31,2020-01-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001310120
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-01-31 at 13:42 +0000, Roberto Sassu wrote:
> > -----Original Message-----
> > From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
> > owner@vger.kernel.org] On Behalf Of Mimi Zohar
> > Sent: Friday, January 31, 2020 1:19 PM
> > To: Roberto Sassu <roberto.sassu@huawei.com>;
> > jarkko.sakkinen@linux.intel.com;
> > james.bottomley@hansenpartnership.com; linux-integrity@vger.kernel.org
> > Cc: linux-security-module@vger.kernel.org; linux-kernel@vger.kernel.org;
> > Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
> > Subject: Re: [PATCH 5/8] ima: allocate and initialize tfm for each PCR bank
> > 
> > On Mon, 2020-01-27 at 18:04 +0100, Roberto Sassu wrote:
> > > This patch creates a crypto_shash structure for each allocated PCR bank
> > and
> > > for SHA1 if a bank with that algorithm is not currently allocated.
> > >
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > <snip>
> > 
> > > +int __init ima_init_crypto(void)
> > > +{
> > > +	enum hash_algo algo;
> > > +	long rc;
> > > +	int i;
> > > +
> > > +	rc = ima_init_ima_crypto();
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	ima_algo_array = kmalloc_array(ima_tpm_chip-
> > >nr_allocated_banks + 1,
> > > +				       sizeof(*ima_algo_array), GFP_KERNEL);
> > 
> > Perhaps instead of hard coding "nr_allocated_banks + 1", create a
> > variable for storing the number of "extra" banks.  Walk the banks
> > setting ima_sha1_idx and, later, in a subsequent patch set
> > ima_hash_algo_idx.
> 
> I could store the indexes in an array and add ARRAY_SIZE of that array.

Your current patches are straight forward and easy to review.  I
really like that.  What I'm proposing is a minor change, at least I
think it is a minor change.  I trust whatever change you decide to
make will be just as easy to review.

Before re-posting, please define ima_sha1_idx and ima_hash_algo_idx as
__ro_after_init.

thanks,

Mimi

