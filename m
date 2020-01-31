Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C74C114ED64
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2020 14:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgAaNdV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jan 2020 08:33:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728598AbgAaNdU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jan 2020 08:33:20 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VDWARX082787
        for <linux-integrity@vger.kernel.org>; Fri, 31 Jan 2020 08:33:20 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xvkrfbuqc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 31 Jan 2020 08:33:19 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 31 Jan 2020 13:33:17 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 31 Jan 2020 13:33:14 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00VDXDXa41943252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 13:33:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 137CBAE04D;
        Fri, 31 Jan 2020 13:33:13 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96D83AE057;
        Fri, 31 Jan 2020 13:33:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.193.32])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 31 Jan 2020 13:33:11 +0000 (GMT)
Subject: Re: [PATCH 1/8] tpm: initialize crypto_id of allocated_banks to
 HASH_ALGO__LAST
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "james.bottomley@hansenpartnership.com" 
        <james.bottomley@hansenpartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Fri, 31 Jan 2020 08:33:10 -0500
In-Reply-To: <8c15cf66708a4d38916b8ca39f26b5f6@huawei.com>
References: <20200127170443.21538-1-roberto.sassu@huawei.com>
         <20200127170443.21538-2-roberto.sassu@huawei.com>
         <50afe1f50297b02af52621b6738ffff0c24f1bdf.camel@linux.intel.com>
         <8c15cf66708a4d38916b8ca39f26b5f6@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20013113-0020-0000-0000-000003A5D948
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013113-0021-0000-0000-000021FD933C
Message-Id: <1580477590.6104.61.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-31_03:2020-01-31,2020-01-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1911200001
 definitions=main-2001310117
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-01-30 at 16:11 +0000, Roberto Sassu wrote:
> > -----Original Message-----
> > From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
> > Sent: Thursday, January 30, 2020 9:48 AM
> > To: Roberto Sassu <roberto.sassu@huawei.com>; zohar@linux.ibm.com;
> > james.bottomley@hansenpartnership.com; linux-integrity@vger.kernel.org
> > Cc: linux-security-module@vger.kernel.org; linux-kernel@vger.kernel.org;
> > Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
> > Subject: Re: [PATCH 1/8] tpm: initialize crypto_id of allocated_banks to
> > HASH_ALGO__LAST
> > 
> > On Mon, 2020-01-27 at 18:04 +0100, Roberto Sassu wrote:
> > > chip->allocated_banks contains the list of TPM algorithm IDs of allocated
> > > PCR banks. It also contains the corresponding ID of the crypto subsystem,
> > > so that users of the TPM driver can calculate a digest for a PCR extend
> > > operation.
> > >
> > > However, if there is no mapping between TPM algorithm ID and crypto ID,
> > the
> > > crypto_id field in chip->allocated_banks remains set to zero (the array is
> > > allocated and initialized with kcalloc() in tpm2_get_pcr_allocation()).
> > > Zero should not be used as value for unknown mappings, as it is a valid
> > > crypto ID (HASH_ALGO_MD4).
> > >
> > > This patch initializes crypto_id to HASH_ALGO__LAST.
> > >
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>---
> > 
> > Remarks:
> > 
> > * After the subsystem tag, short summary starts with a capital lettter.
> > * Missing fixes tag and cc tag to stable.
> > * A struct called allocated_banks does not exist.
> > * Please prefer using an imperative sentence when describing the action
> >   to take e.g. "Thus, initialize crypto_id to HASH_ALGO__LAST".
> 
> Thanks. I will fix these issues in the next version of the patch set.

Jarkko, I realize this is a TPM patch, but this patch set is dependent
on it.  When this patch is ready, could you create a topic branch,
which both of us could merge?

thanks,

Mimi

