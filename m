Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2933A45A0
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Jun 2021 17:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFKPnz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Jun 2021 11:43:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230373AbhFKPnz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Jun 2021 11:43:55 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15BFXo09101096;
        Fri, 11 Jun 2021 11:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=sIHlhEnNqZ4ONfMuHAGdc+iPb+qm+WDjDLJwBrclDdE=;
 b=b7fIZQ06GFGyzSuqjwDF5voT5+AnK+F0Un+tBTwahPrdM6esObtsq6C8l7/fCXg4Dftm
 D93Al5Wb7F8PsiJhzJzIlRtmS7rXPS0r9aoW7vHOwX6vR2GqFOpYTUBn7CnEO7DYTaeH
 CuJ556hj4IS6lI/I+1ZdFduSqEwMD7qvJRu9pY9iC049yA+K8u3QplrE6jiX1KYCOqx0
 BpZgv3Ui/G50aU0Ic7C1gk0cyPwf4o0CUEdbFt6n/3xHhVRQsS2LOZjEv5s2pqbWSM8Q
 dmrdq87cEicYlzxDTzgzyOTC0fCfvj9ugtnuZ+CqMl+NDnakpH+5jRZsa4HluPZSWLmY pg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 394aahrsuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 11:41:53 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15BFfoKN017488;
        Fri, 11 Jun 2021 15:41:50 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 3900w8syhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 15:41:50 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15BFfmG419792216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 15:41:48 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6278311C04C;
        Fri, 11 Jun 2021 15:41:48 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E44211C04A;
        Fri, 11 Jun 2021 15:41:46 +0000 (GMT)
Received: from sig-9-65-207-168.ibm.com (unknown [9.65.207.168])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Jun 2021 15:41:46 +0000 (GMT)
Message-ID: <0dc1d1305333a38f87029c3444fdb12c966c0906.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] ima: Fix warning: no previous prototype for
 function 'ima_add_kexec_buffer'
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        robh@kernel.org, bauerman@linux.ibm.com
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        tusharsu@linux.microsoft.com
Date:   Fri, 11 Jun 2021 11:41:45 -0400
In-Reply-To: <20210610171553.3806-1-nramas@linux.microsoft.com>
References: <20210610171553.3806-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nIZyly8vkyCkeqHMNY48iVKRMbHB_39K
X-Proofpoint-GUID: nIZyly8vkyCkeqHMNY48iVKRMbHB_39K
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-11_05:2021-06-11,2021-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=812 adultscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106110097
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-06-10 at 10:15 -0700, Lakshmi Ramasubramanian wrote:
> The function prototype for ima_add_kexec_buffer() is present
> in 'linux/ima.h'.  But this header file is not included in
> ima_kexec.c where the function is implemented.  This results
> in the following compiler warning when "-Wmissing-prototypes" flag
> is turned on:
> 
>   security/integrity/ima/ima_kexec.c:81:6: warning: no previous prototype
>   for function 'ima_add_kexec_buffer' [-Wmissing-prototypes]
> 
> Include the header file 'linux/ima.h' in ima_kexec.c to fix
> the compiler warning.
> 
> Fixes: dce92f6b11c3 (arm64: Enable passing IMA log to next kernel on kexec)
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

Thanks!

Applied to: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-
integrity.git next-integrity-testing and next-integrity branches.

Mimi

