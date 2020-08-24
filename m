Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFED2509CD
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Aug 2020 22:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgHXULb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Aug 2020 16:11:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725946AbgHXULb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Aug 2020 16:11:31 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07OK2QLj170470
        for <linux-integrity@vger.kernel.org>; Mon, 24 Aug 2020 16:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=CKfANHzRDOfLHw2sCNaooh2UtoJf1sAdqQhfgYgzP1s=;
 b=eS2pb58U6t6Ez0BkKsKTiF66jXHAEtdNRX9qmK5kamrvJFPuE6gEggnQTQ5ntL+husQv
 z4a03u+hdlkoVY/XUWEXDGlLq4CpVjHS1AO9BVpE2NpAb615tb0xKPM4injb0LFk29kX
 J2kU0r/6YALDKZ0Drpz1n9hlOp5LXzSXN6rbc9wuWvTieetLv+XJdLEY5FPN9zDB7vSj
 rIPGX1eVPsbnM1wK6P8lknKo8FhDVPiHBcgeEtOUZNvG5CIaspDaVI0WVvWDBDRdI42v
 o1SxGz2QCYH3G46awBClEDl+VTaq+FlwH0gPRxPBq0Cq0UirVksCXDM8zi3vv1+TNUpT hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 334kvygx1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 24 Aug 2020 16:11:28 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07OK2nfI172860
        for <linux-integrity@vger.kernel.org>; Mon, 24 Aug 2020 16:11:28 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 334kvygx10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 16:11:28 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07OK97OZ011954;
        Mon, 24 Aug 2020 20:11:26 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 332ujrsn18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 20:11:26 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07OK9s0W59965722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 20:09:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1932C11C04A;
        Mon, 24 Aug 2020 20:11:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4935511C04C;
        Mon, 24 Aug 2020 20:11:23 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.122.56])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Aug 2020 20:11:23 +0000 (GMT)
Message-ID: <25a0912802168cf104ffc7d8ac4f1b2ec12e054d.camel@linux.ibm.com>
Subject: Re: [PATCH 3/4] ima: limit secure boot feedback scope for appraise
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>,
        linux-integrity@vger.kernel.org
Date:   Mon, 24 Aug 2020 16:11:22 -0400
In-Reply-To: <20200817215233.95319-4-bmeneg@redhat.com>
References: <20200817215233.95319-1-bmeneg@redhat.com>
         <20200817215233.95319-4-bmeneg@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008240155
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-08-17 at 18:52 -0300, Bruno Meneguele wrote:
> Instead of print to kmsg any ima_appraise= option passed by the user in case
> of secure boot being enabled, first check if the state was really changed
> from its original "enforce" state, otherwise don't print anything.

Please reword this patch description, removing "Instead of print to
kmsg".

> 
> Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
> ---
>  security/integrity/ima/ima_appraise.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 2193b51c2743..000df14f198a 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -19,11 +19,7 @@
>  static int __init default_appraise_setup(char *str)
>  {
>  #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
> -	if (arch_ima_get_secureboot()) {
> -		pr_info("Secure boot enabled: ignoring ima_appraise=%s boot parameter option",
> -			str);
> -		return 1;
> -	}
> +	bool sb_state = arch_ima_get_secureboot();
>  
>  	if (strncmp(str, "off", 3) == 0)
>  		ima_appraise = 0;
> @@ -35,6 +31,16 @@ static int __init default_appraise_setup(char *str)
>  		ima_appraise = IMA_APPRAISE_ENFORCE;
>  	else
>  		pr_err("invalid \"%s\" appraise option", str);
> +
> +	/* If appraisal state was changed, but secure boot is enabled,
> +	 * reset it to enforced */
> +	if (sb_state) {
> +		if (!is_ima_appraise_enabled()) {
> +			pr_info("Secure boot enabled: ignoring ima_appraise=%s option",
> +				str);
> +			ima_appraise = IMA_APPRAISE_ENFORCE;
> +		}
> +	}

Instead of changing ima_appraise and then resetting it back to
enforcing, how about using a temporary variable instead?  Maybe
something like:

if (!is_ima_appraise_enabled())
	pr_info( ...)
else
   ima_appraise = temporary value

>  #endif
>  	return 1;
>  }


