Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D971B5096
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2020 00:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgDVW7w (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Apr 2020 18:59:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48192 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725839AbgDVW7w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Apr 2020 18:59:52 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MMXTYe037401
        for <linux-integrity@vger.kernel.org>; Wed, 22 Apr 2020 18:59:52 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30js45th94-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 22 Apr 2020 18:59:51 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 22 Apr 2020 23:59:25 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Apr 2020 23:59:22 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03MMxjv156557718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Apr 2020 22:59:45 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97B474C040;
        Wed, 22 Apr 2020 22:59:45 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B00984C044;
        Wed, 22 Apr 2020 22:59:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.162.195])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Apr 2020 22:59:44 +0000 (GMT)
Subject: Re: [PATCH 5/5] ima: Remove unused build_ima_appraise variable
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.struczynski@huawei.com,
        silviu.vlasceanu@huawei.com
Date:   Wed, 22 Apr 2020 18:59:44 -0400
In-Reply-To: <20200325161455.7610-2-roberto.sassu@huawei.com>
References: <20200325161116.7082-1-roberto.sassu@huawei.com>
         <20200325161455.7610-1-roberto.sassu@huawei.com>
         <20200325161455.7610-2-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20042222-0012-0000-0000-000003A97B84
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042222-0013-0000-0000-000021E6CDBA
Message-Id: <1587596384.5165.31.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_08:2020-04-22,2020-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004220170
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto, Krzysztof,

On Wed, 2020-03-25 at 17:14 +0100, Roberto Sassu wrote:
> From: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
> 
> After adding the new add_rule() function in commit c52657d93b05
> ("ima: refactor ima_init_policy()"), all appraisal flags are added to the
> temp_ima_appraise variable. Remove build_ima_appraise that is not set
> anymore.
> 
> Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
> ---
>  security/integrity/ima/ima_policy.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index ea9b991f0232..fcc26bddd7fc 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -48,7 +48,6 @@
>  
>  int ima_policy_flag;
>  static int temp_ima_appraise;
> -static int build_ima_appraise __ro_after_init;
>  
>  #define MAX_LSM_RULES 6
>  enum lsm_rule_types { LSM_OBJ_USER, LSM_OBJ_ROLE, LSM_OBJ_TYPE,
> @@ -606,7 +605,7 @@ void ima_update_policy_flag(void)
>  			ima_policy_flag |= entry->action;
>  	}
>  
> -	ima_appraise |= (build_ima_appraise | temp_ima_appraise);
> +	ima_appraise |= temp_ima_appraise;

You're correct that build_ima_appraise isn't being used any longer,
but ima_appraise isn't defined as __ro_after_init.  Instead of
removing build_ima_appraise, does it make sense to set it?

Mimi

>  	if (!ima_appraise)
>  		ima_policy_flag &= ~IMA_APPRAISE;
>  }

