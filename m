Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C97012AD03
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Dec 2019 15:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfLZO1x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Dec 2019 09:27:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbfLZO1x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Dec 2019 09:27:53 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBQEMSAH139477
        for <linux-integrity@vger.kernel.org>; Thu, 26 Dec 2019 09:27:52 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x21rq27m0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 26 Dec 2019 09:27:51 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 26 Dec 2019 14:27:49 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 26 Dec 2019 14:27:46 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBQER1aa50397648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Dec 2019 14:27:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF76311C052;
        Thu, 26 Dec 2019 14:27:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DC3F11C04A;
        Thu, 26 Dec 2019 14:27:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.135.90])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 26 Dec 2019 14:27:45 +0000 (GMT)
Subject: Re: [integrity:next-integrity-testing 3/5]
 security/integrity/ima/ima_asymmetric_keys.c:70:6: sparse: sparse: symbol
 'ima_queue_key' was not declared. Should it be static?
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     kbuild test robot <lkp@intel.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-integrity@vger.kernel.org
Date:   Thu, 26 Dec 2019 09:27:44 -0500
In-Reply-To: <201912251234.hUAOr3cc%lkp@intel.com>
References: <201912251234.hUAOr3cc%lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19122614-4275-0000-0000-000003926E91
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19122614-4276-0000-0000-000038A64884
Message-Id: <1577370464.4487.10.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-26_04:2019-12-24,2019-12-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912260133
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-12-25 at 12:54 +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity-testing
> head:   11b771ffff8fc0bfc176b829d986896a7d97a44c
> commit: 466a4c055a9b9efc8704591bbfa9041c77f66c46 [3/5] IMA: Define workqueue for early boot "key" measurements
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-129-g341daf20-dirty
>         git checkout 466a4c055a9b9efc8704591bbfa9041c77f66c46
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
> >> security/integrity/ima/ima_asymmetric_keys.c:70:6: sparse: sparse: symbol 'ima_queue_key' was not declared. Should it be static?
> 
> Please review and possibly fold the followup patch.

Thank you for following next-integrity-testing branch and providing a fix.

Mimi

