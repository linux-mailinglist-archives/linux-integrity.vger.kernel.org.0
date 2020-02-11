Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 007E4159D21
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2020 00:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbgBKXYJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Feb 2020 18:24:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727786AbgBKXYI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Feb 2020 18:24:08 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BNKYVF186049
        for <linux-integrity@vger.kernel.org>; Tue, 11 Feb 2020 18:24:07 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y3wxs0ent-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 11 Feb 2020 18:24:07 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 11 Feb 2020 23:24:05 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Feb 2020 23:24:02 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01BNO1Gv57147548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Feb 2020 23:24:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 245B5AE045;
        Tue, 11 Feb 2020 23:24:01 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC249AE057;
        Tue, 11 Feb 2020 23:23:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.128.4])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Feb 2020 23:23:59 +0000 (GMT)
Subject: Re: [PATCH 1/2] crypto: rename sm3-256 to sm3 in hash_algo_name
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        ebiggers@kernel.org
Cc:     linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 11 Feb 2020 18:23:59 -0500
In-Reply-To: <1581457759.5125.18.camel@linux.ibm.com>
References: <20200210124440.23929-1-tianjia.zhang@linux.alibaba.com>
         <20200210124440.23929-2-tianjia.zhang@linux.alibaba.com>
         <1581457759.5125.18.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021123-4275-0000-0000-000003A0404F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021123-4276-0000-0000-000038B47942
Message-Id: <1581463439.5125.72.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-11_07:2020-02-11,2020-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110149
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-02-11 at 16:49 -0500, Mimi Zohar wrote:
> On Mon, 2020-02-10 at 20:44 +0800, Tianjia Zhang wrote:
> > The name sm3-256 is defined in hash_algo_name in hash_info, but the
> > algorithm name implemented in sm3_generic.c is sm3, which will cause
> > the sm3-256 algorithm to be not found in some application scenarios of
> > the hash algorithm, and an ENOENT error will occur. For example,
> > IMA, keys, and other subsystems that reference hash_algo_name all use
> > the hash algorithm of sm3.
> > 
> > Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> 
> The "hash_map" needs to be updated to reflect this change.
> 
> static struct tpm2_hash tpm2_hash_map[] = {
>         {HASH_ALGO_SHA1, TPM_ALG_SHA1},
>         {HASH_ALGO_SHA256, TPM_ALG_SHA256},
>         {HASH_ALGO_SHA384, TPM_ALG_SHA384},
>         {HASH_ALGO_SHA512, TPM_ALG_SHA512},
>         {HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
> };

Never mind, the enum name "HASH_ALGO_SM3_256" didn't change.  Just the
string changed.

Mimi

