Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7B5C12AD04
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Dec 2019 15:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfLZO2G (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Dec 2019 09:28:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49770 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726074AbfLZO2F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Dec 2019 09:28:05 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBQEMQM6001309
        for <linux-integrity@vger.kernel.org>; Thu, 26 Dec 2019 09:28:04 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2x3mduxf2k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 26 Dec 2019 09:28:04 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 26 Dec 2019 14:28:02 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 26 Dec 2019 14:27:59 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBQERwFt58392792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Dec 2019 14:27:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2AF342047;
        Thu, 26 Dec 2019 14:27:58 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00A5242042;
        Thu, 26 Dec 2019 14:27:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.135.90])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 26 Dec 2019 14:27:57 +0000 (GMT)
Subject: Re: [RFC PATCH integrity] IMA: ima_queue_key() can be static
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-integrity@vger.kernel.org
Date:   Thu, 26 Dec 2019 09:27:57 -0500
In-Reply-To: <c31a5f8b-2db9-f8ad-51f6-b6e471b05737@linux.microsoft.com>
References: <201912251234.hUAOr3cc%lkp@intel.com>
         <20191225045416.34tsl75acckhabsr@4978f4969bb8>
         <c31a5f8b-2db9-f8ad-51f6-b6e471b05737@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19122614-0028-0000-0000-000003CBFD20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19122614-0029-0000-0000-0000248F5E7B
Message-Id: <1577370477.4487.11.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-26_04:2019-12-24,2019-12-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912260133
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-12-24 at 22:43 -0800, Lakshmi Ramasubramanian wrote:
> Hi Mimi,
> 
> On 12/24/2019 8:54 PM, kbuild test robot wrote:
> > 
> > Fixes: 466a4c055a9b ("IMA: Define workqueue for early boot "key" measurements")
> > Signed-off-by: kbuild test robot <lkp@intel.com>
> > ---
> >   ima_asymmetric_keys.c |    4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >   
> > -bool ima_queue_key(struct key *keyring, const void *payload,
> > -		   size_t payload_len)
> > +static bool ima_queue_key(struct key *keyring, const void *payload,
> > +			  size_t payload_len)
> >   {
> >   	bool queued = false;
> >   	struct ima_key_entry *entry;
> > 
> 
> I'd defined ima_queue_key() as non-static when it could have been 
> defined as static.
> 
>  From this patch I understand this change is done. Is there anything I 
> need to do to address this issue?

No, I'll squash this patch with the original patch, adding the
requested tags.

Mimi

