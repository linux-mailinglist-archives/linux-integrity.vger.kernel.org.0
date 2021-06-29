Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43F73B745A
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jun 2021 16:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbhF2OdD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Jun 2021 10:33:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234285AbhF2OdC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jun 2021 10:33:02 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TE3p2k051986;
        Tue, 29 Jun 2021 10:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=8nHEd+heVjgNDMISNu6kEs8agcHs9+hSuqstlJ6JRO0=;
 b=G52GVhgLiU1JuKXKo4X91yq82gDpqqgA3FgITLOnlZdNnyrlk7RSuXLuvShAF82xX/Ug
 H8zlXblkKvzYIvaJc4b+tOcsqZFkDl6mToo4Ki6WsZSNh6Vztl+i30da8XWbrFWx/U/g
 mmnCJPM71SFH2HUBvsu8TYO9LwHWjeqkdOUKBTaD86O1sZLMn6hVFbyWGHJh0a1tqmho
 SwejBtXLE1AZNHIqKlQsnpsvpDPtvMBgGCsG29X7628h0hf6MGo1AXvsJx3RFRDfuSm/
 y09UYFJ6H+JcTJXtMzddv+rideuzfcrEomVsklZjkiRuyxbSvCydDnbOHS/i7jjZswgT MA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39g4v1gy2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 10:30:29 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15TE5IOv063910;
        Tue, 29 Jun 2021 10:30:28 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39g4v1gy1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 10:30:28 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15TEPDnT024205;
        Tue, 29 Jun 2021 14:30:25 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 39dughhbg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 14:30:25 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15TESnuJ30671160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 14:28:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D96084207C;
        Tue, 29 Jun 2021 14:30:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E192A420A0;
        Tue, 29 Jun 2021 14:30:20 +0000 (GMT)
Received: from sig-9-65-193-149.ibm.com (unknown [9.65.193.149])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Jun 2021 14:30:20 +0000 (GMT)
Message-ID: <fe6c853842425e675024731525e0f244da368e8e.camel@linux.ibm.com>
Subject: Re: [PATCH] IMA: remove -Wmissing-prototypes warning
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Austin Kim <austindh.kim@gmail.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, austin.kim@lge.com,
        Petko Manolov <petkan@mip-labs.com>
Date:   Tue, 29 Jun 2021 10:30:20 -0400
In-Reply-To: <20210629135050.GA1373@raspberrypi>
References: <20210629135050.GA1373@raspberrypi>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cqNRqupwFie-nSLx9WuTAUc7dwbrRhjb
X-Proofpoint-GUID: wQrpsWgRP5VglZKz47mpfDj5TWxCrHQB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_06:2021-06-28,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1011 suspectscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106290095
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc: Petko Manolov <petkan@mip-labs.com>]

Hi Austin,

On Tue, 2021-06-29 at 14:50 +0100, Austin Kim wrote:
> From: Austin Kim <austin.kim@lge.com>
> 
> With W=1 build, the compiler throws warning message as below:
> 
>    security/integrity/ima/ima_mok.c:24:12: warning:
>    no previous prototype for ‘ima_mok_init’ [-Wmissing-prototypes]
>        __init int ima_mok_init(void)
> 
> Silence the warning by adding static keyword to ima_mok_init().
> 
> Signed-off-by: Austin Kim <austin.kim@lge.com>
> ---
>  security/integrity/ima/ima_mok.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_mok.c b/security/integrity/ima/ima_mok.c
> index 1e5c01916173..95cc31525c57 100644
> --- a/security/integrity/ima/ima_mok.c
> +++ b/security/integrity/ima/ima_mok.c
> @@ -21,7 +21,7 @@ struct key *ima_blacklist_keyring;
>  /*
>   * Allocate the IMA blacklist keyring
>   */
> -__init int ima_mok_init(void)
> +static __init int ima_mok_init(void)
>  {
>  	struct key_restriction *restriction;
>  

Thank you for the patch, which does fix the warning.   The .ima_mok
keyring was removed a while ago.  With all the recent work on the
system blacklist, I'm wondering if anyone is still using the IMA
blacklist keyring or whether it should be removed as well.

thanks,

Mimi

