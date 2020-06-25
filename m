Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA8620A7C7
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 23:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390596AbgFYVwH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 17:52:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389705AbgFYVwG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 17:52:06 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05PLVvxT189559;
        Thu, 25 Jun 2020 17:52:01 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31vts13ecq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 17:52:01 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05PLVvwj189585;
        Thu, 25 Jun 2020 17:52:01 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31vts13ec1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 17:52:00 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PLpweL022074;
        Thu, 25 Jun 2020 21:51:58 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 31uusps2un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 21:51:58 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05PLpuEb41484542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 21:51:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F6814C059;
        Thu, 25 Jun 2020 21:51:56 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDF504C046;
        Thu, 25 Jun 2020 21:51:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.142.225])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jun 2020 21:51:54 +0000 (GMT)
Message-ID: <1593121914.27152.411.camel@linux.ibm.com>
Subject: Re: [PATCH 05/12] ima: Fail rule parsing when buffer hook functions
 have an invalid action
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Thu, 25 Jun 2020 17:51:54 -0400
In-Reply-To: <20200623003236.830149-6-tyhicks@linux.microsoft.com>
References: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
         <20200623003236.830149-6-tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-25_16:2020-06-25,2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 adultscore=0 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006250124
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-06-22 at 19:32 -0500, Tyler Hicks wrote:
> Buffer based hook functions, such as KEXEC_CMDLINE and KEY_CHECK, can
> only measure. The process_buffer_measurement() function quietly ignores
> all actions except measure so make this behavior clear at the time of
> policy load.
> 
> The parsing of the keyrings conditional had a check to ensure that it
> was only specified with measure actions but the check should be on the
> hook function and not the keyrings conditional since
> "appraise func=KEY_CHECK" is not a valid rule.
> 
> Fixes: b0935123a183 ("IMA: Define a new hook to measure the kexec boot command line arguments")
> Fixes: 5808611cccb2 ("IMA: Add KEY_CHECK func to measure keys")
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_policy.c | 36 +++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index ee5152ecd3d9..ecc234b956a2 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -979,6 +979,39 @@ static void check_template_modsig(const struct ima_template_desc *template)
>  #undef MSG
>  }
>  
> +static bool ima_validate_rule(struct ima_rule_entry *entry)
> +{
> +	if (entry->action == UNKNOWN)
> +		return false;
> +
> +	if (entry->flags & IMA_FUNC) {
> +		switch (entry->func) {
> +		case NONE:
> +		case FILE_CHECK:
> +		case MMAP_CHECK:
> +		case BPRM_CHECK:
> +		case CREDS_CHECK:
> +		case POST_SETATTR:
> +		case MODULE_CHECK:
> +		case FIRMWARE_CHECK:
> +		case KEXEC_KERNEL_CHECK:
> +		case KEXEC_INITRAMFS_CHECK:
> +		case POLICY_CHECK:
> +			break;
> +		case KEXEC_CMDLINE:
> +		case KEY_CHECK:
> +			if (entry->action & ~(MEASURE | DONT_MEASURE))
> +				return false;
> +
> +			break;
> +		default:
> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +

Good idea.  There are a couple of other examples that could be cleaned
up as well.  For example, for performance reasons
"appraise_flag=check_blacklist" is limited to files with appended
signatures, like kernel modules and the kexec kernel image
(OpenPower).

Mimi
