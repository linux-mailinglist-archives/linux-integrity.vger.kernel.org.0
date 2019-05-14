Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 598C41E531
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2019 00:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfENWhO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 May 2019 18:37:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55464 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726148AbfENWhO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 May 2019 18:37:14 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4EMauVB102469
        for <linux-integrity@vger.kernel.org>; Tue, 14 May 2019 18:37:13 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sg2xy0dhd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 14 May 2019 18:37:12 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 14 May 2019 23:37:10 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 May 2019 23:37:07 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4EMb6Mq35192840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 22:37:06 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AEF9A4069;
        Tue, 14 May 2019 22:37:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9942AA4068;
        Tue, 14 May 2019 22:37:05 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 May 2019 22:37:05 +0000 (GMT)
Subject: Re: [PATCH] ima: fix wrong signed policy requirement when not
 appraising
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Date:   Tue, 14 May 2019 18:37:05 -0400
In-Reply-To: <20190514220845.408-1-pvorel@suse.cz>
References: <20190514220845.408-1-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051422-4275-0000-0000-00000334CBDE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051422-4276-0000-0000-000038444D69
Message-Id: <1557873425.4139.79.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905140148
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-05-15 at 00:08 +0200, Petr Vorel wrote:
> Kernel booted just with ima_policy=tcb (not with
> ima_policy=appraise_tcb) shouldn't require signed policy.
> 
> Regression found with LTP test ima_policy.sh.
> 
> Fixes: c52657d93b05 ("ima: refactor ima_init_policy()")
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
> 
> assuming behavior prior c52657d93b05 was correct.
> BTW I admit that using global variable inside helper function is nasty.
> 
> Kind regards,
> Petr
> 
>  security/integrity/ima/ima_policy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index e0cc323f948f..df0e6a1b063b 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -500,7 +500,7 @@ static void add_rules(struct ima_rule_entry *entries, int count,
>  		}
>  		if (entries[i].action == APPRAISE)
>  			temp_ima_appraise |= ima_appraise_flag(entries[i].func);
> -		if (entries[i].func == POLICY_CHECK)
> +		if (ima_use_appraise_tcb && entries[i].func == POLICY_CHECK)
>  			temp_ima_appraise |= IMA_APPRAISE_POLICY;

Instead of also testing "ima_use_appraise_tcb", try including the
POLICY_CHECK as part of the APPRAISE condition.

thanks!

Mimi

>  	}
>  }

