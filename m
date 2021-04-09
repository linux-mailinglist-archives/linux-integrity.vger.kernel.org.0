Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2994F35A654
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Apr 2021 20:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhDISze (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Apr 2021 14:55:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234746AbhDISzd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Apr 2021 14:55:33 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 139IWPIr024926;
        Fri, 9 Apr 2021 14:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=25PuWItDWJshlEFpNgfjWsdNElevbU+n1ExVbrqD2fM=;
 b=ZtGk/AoZgJKU30a4XrTUJd+GPspQX++bjjmK/RaPyMARF1PrNPH3k4tJ0ma08Ou4gSaD
 +YUh9A5x6/Mgse2ENDFRWR8gqnyZ0y6K0IiW6B0QBd2THtSmXZxP4zTDxkpuc1Dhuzm+
 AvCx9h20BMcUcDRTT95xFad5bFvsp1xZ744xZ6aL+fGtOyCq9jk//s+XSMGjOeF2/jDF
 AQ8bxDY29B4m/d29yHmV82xPegxH8KEH29eG3RlU2nmxsyiMUNlraaE6UOnE1gtxJO5Z
 QF/hOly0PinomB35BBSaFd2ulgxuJD5FwXZuws05/WD439U6CIfo4wzoTHmWP69HAidB Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37tuwu90p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 14:55:19 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 139IWiQI025410;
        Fri, 9 Apr 2021 14:55:19 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37tuwu90nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 14:55:18 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 139Im075006777;
        Fri, 9 Apr 2021 18:55:17 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 37rvc1heh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 18:55:16 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 139Isr7h25166120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Apr 2021 18:54:53 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8732552051;
        Fri,  9 Apr 2021 18:55:14 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.54.65])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B58CC5204E;
        Fri,  9 Apr 2021 18:55:12 +0000 (GMT)
Message-ID: <cb640adf4fe93e054d7a8c148fea601048bfd562.camel@linux.ibm.com>
Subject: Re: [PATCH v2] integrity: Add declarations to init_once void
 arguments.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jiele Zhao <unclexiaole@gmail.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Date:   Fri, 09 Apr 2021 14:55:11 -0400
In-Reply-To: <20210407014438.39516-1-unclexiaole@gmail.com>
References: <20210407014438.39516-1-unclexiaole@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LCl46-grENM0ezmZcNjvG7NwgbjigjgS
X-Proofpoint-GUID: gVrNu-qGf7as0Oopr-ffI3Tah2YC0qq4
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_07:2021-04-09,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090133
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jiele,

On Wed, 2021-04-07 at 01:44 +0000, Jiele Zhao wrote:
> init_once is a callback to kmem_cache_create. The parameter
> type of this function is void *, so it's better to give a
> explicit cast here.
> 
> Signed-off-by: Jiele Zhao <unclexiaole@gmail.com>
> ---
>  security/integrity/iint.c         | 2 +-
>  security/integrity/ima/ima_main.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 0ba01847e836..fca8a9409e4a 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -160,7 +160,7 @@ void integrity_inode_free(struct inode *inode)
>  
>  static void init_once(void *foo)
>  {
> -	struct integrity_iint_cache *iint = foo;
> +	struct integrity_iint_cache *iint = (struct integrity_iint_cache *) foo;
>  
>  	memset(iint, 0, sizeof(*iint));
>  	iint->ima_file_status = INTEGRITY_UNKNOWN;
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 9ef748ea829f..03bef720ab44 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -482,7 +482,7 @@ int ima_bprm_check(struct linux_binprm *bprm)
>  }
>  
>  /**
> - * ima_path_check - based on policy, collect/store measurement.
> + * ima_file_check - based on policy, collect/store measurement.
>   * @file: pointer to the file to be measured
>   * @mask: contains MAY_READ, MAY_WRITE, MAY_EXEC or MAY_APPEND
>   *

This change was already posted as "ima: Fix function name error in
comment".  I've dropped this hunk.  In the future, please review your
patch line by line before posting.

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git 
next-integrity

thanks,

Mimi

