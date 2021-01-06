Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92932EC0D8
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Jan 2021 17:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbhAFQGk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Jan 2021 11:06:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726915AbhAFQGk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Jan 2021 11:06:40 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 106G2mmU141209;
        Wed, 6 Jan 2021 11:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=e0LR1bikQ0rjbtDkgKcBL0U3OaVvoGToqMwtVDHU/BE=;
 b=JIFMt4hXW/uK0NtxQMbwuJhqXxy+xPNyszO+ZCOPP+5MZBObWdCZxNL/usL6BmWJH4EX
 xTM2Ddyz2s/ucF8PbN/ohHoFQw94yyzsziTByJZdC9qwqW2ug3gAU/MwfNOcMFsocmWP
 B3F6uH5qXBMH//mXchBTBQdebHMwa3b/r6C0mxm5UgctEivw4nTxO5l7H2wACNm2rar2
 xDxKaaG/g1WOUKiOUzVwUEhalTOgi22bnSQ6Q/ijrwLyTaHAKMPoRUHgK3Aex0J3QUg0
 3bjrBSX3XsF9Kekdky1XiBPJ+UagM8vf0iLZeU5rGdejczNBP685tnvQXq/l3OdykXoB mQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35wfbgaaxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jan 2021 11:05:49 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 106FqZqJ028762;
        Wed, 6 Jan 2021 16:05:21 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 35tgf7t3t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jan 2021 16:05:20 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 106G5Edg33292608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Jan 2021 16:05:15 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71968A41EF;
        Wed,  6 Jan 2021 16:05:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E712A40CC;
        Wed,  6 Jan 2021 16:05:15 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.71.18])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Jan 2021 16:05:15 +0000 (GMT)
Message-ID: <30c2657ff2f04d5a96e74702033687c9f188a1ca.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] travis: Use Ubuntu 20.10 groovy
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Date:   Wed, 06 Jan 2021 11:05:13 -0500
In-Reply-To: <20210105181120.31417-1-pvorel@suse.cz>
References: <20210105181120.31417-1-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_09:2021-01-06,2021-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101060098
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Tue, 2021-01-05 at 19:11 +0100, Petr Vorel wrote:
> Eoan is failing:
> 
> E: The repository 'http://security.ubuntu.com/ubuntu eoan-security Release' does not have a Release file.
> N: Updating from such a repository can't be done securely, and is therefore disabled by default.
> N: See apt-secure(8) manpage for repository creation and user configuration details.
> 
> And 20.04 LTS focal in Travis is still fails on debconf issue
> ("debconf: unable to initialize frontend: Dialog")
> 
> Old 16.04 LTS xenial is still supported and working in Travis,
> thus move to new groovy gives us good coverage both old and new releases.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Thanks!   This and "pcr_tsspcrread: Add missing new line" patches are
now in the #next-testing branch.

Mimi

