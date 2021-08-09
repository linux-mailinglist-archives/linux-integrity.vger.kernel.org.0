Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B1D3E4BD3
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 20:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhHISFr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 14:05:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231357AbhHISFp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 14:05:45 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179I3VdR049592;
        Mon, 9 Aug 2021 14:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=M02X9rtfG0vl21oVlXLkgSd09SEheklWhI+d8oXVjxE=;
 b=F1ZqmUVrFKyr1si5SVVqXYReZF54N/D+ewC6JcqKJTvTwyt8Cg8m0/LBFzjjtvdcx7xH
 jFh5YldRunRZfDUizVOnrRlLLx7WETsXJQj9BLlr2K8HCtuXV4mHYFecUxhgHyQi3XNx
 QikBfoghRJvK1lnuFr7DfaX6joEV6mNiHGpymvlcZx5CWW9Qnfm3RxnrpiQxzgQX9kc7
 OP8zsL0Q1UDrZkmvTfh+O1X/XQJpHD5BR7nZ1k51YCa7M6zh28o7I6HrtPFmKyp9QPKv
 s3ynXzk4yM6k9WebQM2CqDK+1hwbWdvMpSo4kn6CurYi1aBFlSGOkjba2k8y2856FmqY JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aam0mcmfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 14:05:24 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 179I4gIX054281;
        Mon, 9 Aug 2021 14:05:24 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aam0mcme4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 14:05:24 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 179I4K2i000363;
        Mon, 9 Aug 2021 18:05:22 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3a9ht8vfvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 18:05:21 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 179I5JZ256689002
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Aug 2021 18:05:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6132F11C080;
        Mon,  9 Aug 2021 18:05:19 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AAB911C05C;
        Mon,  9 Aug 2021 18:05:18 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.79.43])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Aug 2021 18:05:18 +0000 (GMT)
Message-ID: <1b478497bca97f8d5ecd3876d26cf01faac08937.camel@linux.ibm.com>
Subject: Re: [PATCH v6 4/5] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Date:   Mon, 09 Aug 2021 14:05:17 -0400
In-Reply-To: <20210804092010.350372-5-simon.thoby@viveris.fr>
References: <20210804092010.350372-1-simon.thoby@viveris.fr>
         <20210804092010.350372-5-simon.thoby@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KBC4h8auERVrHnDGPH_6F0ta6qBHkoO-
X-Proofpoint-ORIG-GUID: O820In1fywHoh18uT0SmshzZYA5TykBU
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_06:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 bulkscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090128
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-08-04 at 09:20 +0000, THOBY Simon wrote:

> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 070779e8d836..aeb622698047 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -27,7 +27,7 @@ Description:
>  			lsm:	[[subj_user=] [subj_role=] [subj_type=]
>  				 [obj_user=] [obj_role=] [obj_type=]]
>  			option:	[[appraise_type=]] [template=] [permit_directio]
> -				[appraise_flag=] [keyrings=]
> +				[appraise_flag=] [appraise_hash=] [keyrings=]

Continuing the suggestion from 3/5, perhaps the new option should be
named "appraise_algo=".

>  		  base:
>  			func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
>  			        [FIRMWARE_CHECK]
> @@ -55,6 +55,10 @@ Description:
>  			label:= [selinux]|[kernel_info]|[data_label]
>  			data_label:= a unique string used for grouping and limiting critical data.
>  			For example, "selinux" to measure critical data for SELinux.
> +			appraise_hash:= comma-separated list of hash algorithms
> +			For example, "sha256,sha512" to only accept to appraise
> +			files where the security.ima xattr was hashed with one
> +			of these two algorithms.
>  
>  		  default policy:
>  			# PROC_SUPER_MAGIC

thanks,

Mimi

