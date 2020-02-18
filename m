Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF864162813
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2020 15:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgBROZC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Feb 2020 09:25:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726442AbgBROZC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Feb 2020 09:25:02 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01IEOvU7125976
        for <linux-integrity@vger.kernel.org>; Tue, 18 Feb 2020 09:25:00 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y6b56v7fc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 18 Feb 2020 09:24:59 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 18 Feb 2020 14:24:50 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Feb 2020 14:24:46 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01IEOjkQ40108542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 14:24:45 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A24611C058;
        Tue, 18 Feb 2020 14:24:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBCC411C052;
        Tue, 18 Feb 2020 14:24:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.142.171])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Feb 2020 14:24:43 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] crypto: fix mismatched hash algorithm name
 sm3-256 to sm3
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko.sakkinen@linux.intel.com, ebiggers@kernel.org,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Feb 2020 09:24:43 -0500
In-Reply-To: <f26b221c-f2e1-a14b-46cb-cae03f1357aa@linux.alibaba.com>
References: <20200217093649.97938-1-tianjia.zhang@linux.alibaba.com>
         <20200217093649.97938-2-tianjia.zhang@linux.alibaba.com>
         <1581989598.8515.233.camel@linux.ibm.com>
         <f26b221c-f2e1-a14b-46cb-cae03f1357aa@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021814-0016-0000-0000-000002E7FAD5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021814-0017-0000-0000-0000334B0F1B
Message-Id: <1582035883.4576.8.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_02:2020-02-17,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180112
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-02-18 at 10:34 +0800, Tianjia Zhang wrote:
> On 2020/2/18 9:33, Mimi Zohar wrote:
> > On Mon, 2020-02-17 at 17:36 +0800, Tianjia Zhang wrote:
> >> The name sm3-256 is defined in hash_algo_name in hash_info, but the
> >> algorithm name implemented in sm3_generic.c is sm3, which will cause
> >> the sm3-256 algorithm to be not found in some application scenarios of
> >> the hash algorithm, and an ENOENT error will occur. For example,
> >> IMA, keys, and other subsystems that reference hash_algo_name all use
> >> the hash algorithm of sm3.
> >>
> >> According to https://tools.ietf.org/id/draft-oscca-cfrg-sm3-01.html,
> >> SM3 always produces a 256-bit hash value and there are no plans for
> >> other length development, so there is no ambiguity in the name of sm3.
> >>
> >> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> >> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > The previous version of this patch set is queued in the next-
> > integrity-testing branch.  That version of this patch didn't
> > change TPM_ALG_SM3_256.  Unless the TPM standard was modified, the TPM
> > spec refers to it as TPM_ALG_SM3_256.  Has that changed?
> >
> > Mimi
> 
> The definition in the TPM specification is still TPM_ALG_SM3_256, please
> ignore the modification to the TPM definition in this patch.

Ok.  Just confirming that I should ignore v2 of this patch set.
 Upstreaming the original version, as queued in next-integrity-
testing, is fine.

thanks,

Mimi

