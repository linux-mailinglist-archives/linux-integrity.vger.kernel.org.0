Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036121D390E
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 20:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgENSWR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 14:22:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726075AbgENSWQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 14:22:16 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EIJAGZ051328;
        Thu, 14 May 2020 14:21:57 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 310x56a4xb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 14:21:57 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04EIB0Ih019287;
        Thu, 14 May 2020 18:21:55 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3100ubc5h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 18:21:55 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04EILrK665733002
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 May 2020 18:21:53 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74F104C044;
        Thu, 14 May 2020 18:21:53 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 511364C04E;
        Thu, 14 May 2020 18:21:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.165.117])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 May 2020 18:21:52 +0000 (GMT)
Message-ID: <1589480510.4757.5.camel@linux.ibm.com>
Subject: Re: [PATCH v2] evm: Fix a small race in init_desc()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Krzysztof Struczynski <krzysztof.struczynski@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@nokia.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Date:   Thu, 14 May 2020 14:21:50 -0400
In-Reply-To: <19452750e36d462088f4fca3d627a090@huawei.com>
References: <c7743ab21a574eeeac40d783e0b8581c@huawei.com>
         <20200512174706.GA298379@mwanda>
         <a30fdceccef443b0a6ac8e0b06b83efc@huawei.com>
         <19452750e36d462088f4fca3d627a090@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_05:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 adultscore=0 clxscore=1011 cotscore=-2147483648 lowpriorityscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140156
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-05-14 at 07:11 +0000, Krzysztof Struczynski wrote:
> > > From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> > > This patch avoids a kernel panic due to accessing an error pointer set
> > > by crypto_alloc_shash(). It occurs especially when there are many
> > > files that require an unsupported algorithm, as it would increase the
> > > likelihood of the following race condition.
> > >
> > > Imagine we have two threads and in the first thread
> > > crypto_alloc_shash() fails and returns an error pointer.
> > >
> > > 		*tfm = crypto_alloc_shash(algo, 0, CRYPTO_NOLOAD);
> > > 		if (IS_ERR(*tfm)) {
> > > 			rc = PTR_ERR(*tfm); <--- FIRST THREAD HERE!
> > > 			pr_err("Can not allocate %s (reason: %ld)\n", algo, rc);
> > > 			*tfm = NULL;
> > >
> > > And the second thread is here:
> > >
> > > 	if (*tfm == NULL) {  <--- SECOND THREAD HERE!
> > > 		mutex_lock(&mutex);
> > > 		if (*tfm)
> > > 			goto out;
> > >
> > > Since "*tfm" is non-NULL, we assume that it is valid and that leads to
> > > a crash when it dereferences "*tfm".
> > >
> > > 	desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
> > >                                                              ^^^^
> > >
> > > This patch fixes the problem by introducing a temporary "tmp_tfm" and
> > > only setting "*tfm" at the very end after everything has succeeded.
> > > The other change is that I reversed the initial "if (!*tfm) {"
> > > condition and pull the code in one indent level.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: d46eb3699502b ("evm: crypto hash replaced by shash")
> > > Reported-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Reported-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > Acked-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Acked-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>

Thanks, Roberto and Krzysztof.

This patch is now queued in the "fixes" branch.

Mimi
