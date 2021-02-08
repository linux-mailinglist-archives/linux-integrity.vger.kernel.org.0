Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9763140E2
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Feb 2021 21:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhBHUtF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Feb 2021 15:49:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37186 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233512AbhBHUqi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Feb 2021 15:46:38 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 118KWXgA050385;
        Mon, 8 Feb 2021 15:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=USpxUQd0VGEWjHopywgNAUX7w1A/s/fmhQc03dwNPds=;
 b=OIEDAoMsQyk0NbOF7l7V4lhSPyQXlN8cij9YNPHTX2k0FNwGGetWZp42hgL7aZvITJyA
 WTpVp+xoBhUeE8XaI/Df+6ngjv+FI/JdaFYFFPUjQId46JFF1aBhKOPBJZ686u6yM0zy
 GUDMcJMejXpNbJyqV8YB1g6iwBc3BM9Vy6eIlwiaWZFDR9J99P6P7WTl6ivHLjXPj6l2
 KdsGDEGdW2waGODzVSs5ylroIFFXfn4lX4Tptp8GfYYg93UyjpjRQIHHziYkZAX6nOsU
 /Th5IrCvE8me76yfEXTTp+MKYkpc8Ubhya3iK7oZrwj/MgZ6WGqN9J5uErj4LrZ7FHXw Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36kbpw1d73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 15:45:37 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 118KWcVO050839;
        Mon, 8 Feb 2021 15:45:36 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36kbpw1d6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 15:45:36 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 118K8gOT011901;
        Mon, 8 Feb 2021 20:45:34 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 36hqda26b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 20:45:34 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 118KjVg147251940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Feb 2021 20:45:31 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C485B4203F;
        Mon,  8 Feb 2021 20:45:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6712E42041;
        Mon,  8 Feb 2021 20:45:28 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.48.239])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Feb 2021 20:45:28 +0000 (GMT)
Message-ID: <059e77ffa861680ccac7fd94251fedc7cffe7a7e.camel@linux.ibm.com>
Subject: Re: [PATCH 1/3] IMA: add policy condition to measure duplicate
 critical data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Mon, 08 Feb 2021 15:45:27 -0500
In-Reply-To: <20210130004519.25106-2-tusharsu@linux.microsoft.com>
References: <20210130004519.25106-1-tusharsu@linux.microsoft.com>
         <20210130004519.25106-2-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-08_13:2021-02-08,2021-02-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 phishscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080119
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

On Fri, 2021-01-29 at 16:45 -0800, Tushar Sugandhi wrote:
> IMA needs to support duplicate measurements of integrity
> critical data to accurately determine the current state of that data
> on the system.  Further, since measurement of duplicate data is not
> required for all the use cases, it needs to be policy driven.
> 
> Define "allow_dup", a new IMA policy condition, for the IMA func
> CRITICAL_DATA to allow duplicate buffer measurement of integrity
> critical data.
> 
> Limit the ability to measure duplicate buffer data when action is
> "measure" and func is CRITICAL_DATA.

Why?!

> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 9b45d064a87d..b89eb768dd05 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -35,6 +35,7 @@
>  #define IMA_FSNAME	0x0200
>  #define IMA_KEYRINGS	0x0400
>  #define IMA_LABEL	0x0800
> +#define IMA_ALLOW_DUP	0x1000
>  
>  #define UNKNOWN		0
>  #define MEASURE		0x0001	/* same as IMA_MEASURE */
> @@ -87,6 +88,7 @@ struct ima_rule_entry {
>  	char *fsname;
>  	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
>  	struct ima_rule_opt_list *label; /* Measure data grouped under this label */

Defining a new boolean entry shouldn't be necessary.    The other
boolean values are just stored in "flags".

>  	struct ima_template_desc *template;
>  };

thanks,

Mimi

