Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F0731BA57
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Feb 2021 14:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhBON2s (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Feb 2021 08:28:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229936AbhBON16 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Feb 2021 08:27:58 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11FD3Gch155296;
        Mon, 15 Feb 2021 08:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=PjXolwIlShtKDbNKhuhK4DaY0JwMHRasy/IXPyZfFpY=;
 b=o0Q/kpjvrTLYWX6+yzFkUWHSoR2Tam2SL4hi5hDeWEJPozdCTHIFyD/lNcda8W0o2oAy
 vNnpyp67o6I6TU1nbDFvY1lpA89RmxqcZ1xWSz0jfbBZdeQ8t+GmJfWiUqp1jXwBB+ak
 vxsMcGeZVOOjVPKHnuJXe5UTfhVubcGStDa/hG8+bqXttdLcozwWZj4XwqvcsdGU4cS3
 3dVfXvuPIN/vgmyg25Xn4F/T545faEOJ1jRbVQkRUA4oQNQlCSqBoKxEmw9pOMgdMWsM
 VhH8PjxKro+qrMxBn4miZjXrui/LKa5BIi8ygotm+Du1S25TSfpBVpVLFS1/PUtstc5r UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36qrbw46mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 08:27:04 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11FD3hIa157570;
        Mon, 15 Feb 2021 08:27:04 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36qrbw46kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 08:27:03 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11FDNRxP031630;
        Mon, 15 Feb 2021 13:27:02 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 36p61h9vga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 13:27:02 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11FDQxcs63766796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 13:27:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D38035204F;
        Mon, 15 Feb 2021 13:26:59 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.59.188])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 45DF752050;
        Mon, 15 Feb 2021 13:26:58 +0000 (GMT)
Message-ID: <fe83fb7572e0eea7a9a9981a15c63f1f7709d714.camel@linux.ibm.com>
Subject: Re: [PATCH] integrity/ima: Provide Kconfig option for ima-modsig
 template
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Michael =?ISO-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>
Cc:     linux-integrity@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 15 Feb 2021 08:26:57 -0500
In-Reply-To: <20210215102305.10722-1-michael.weiss@aisec.fraunhofer.de>
References: <20210215102305.10722-1-michael.weiss@aisec.fraunhofer.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-15_06:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 clxscore=1011 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102150104
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Michael,

On Mon, 2021-02-15 at 11:23 +0100, Michael Weiﬂ wrote:
> 'ima-modsig' was not in the list of selectable templates in Kconfig.
> The missing Kconfig options were added to support the ima-modsig
> template as default template.
> 
> Signed-off-by: Michael Weiﬂ <michael.weiss@aisec.fraunhofer.de>

Since 'ima-modsig' is only needed for appended signatures (e.g. kexec
kernel image on powerpc, kernel modules) a per policy rule "template="
option was defined.  There's also the 'ima_template=' boot command line
option.   Between these two options, I didn't see the need for making
it a build time default option.  Do you?

The patch itself looks good. 

thanks,

Mimi

> ---
>  security/integrity/ima/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 12e9250c1bec..32b9325f49bf 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -78,6 +78,8 @@ choice
>  		bool "ima-ng (default)"
>  	config IMA_SIG_TEMPLATE
>  		bool "ima-sig"
> +	config IMA_MODSIG_TEMPLATE
> +		bool "ima-modsig"
>  endchoice
>  
>  config IMA_DEFAULT_TEMPLATE
> @@ -86,6 +88,7 @@ config IMA_DEFAULT_TEMPLATE
>  	default "ima" if IMA_TEMPLATE
>  	default "ima-ng" if IMA_NG_TEMPLATE
>  	default "ima-sig" if IMA_SIG_TEMPLATE
> +	default "ima-modsig" if IMA_MODSIG_TEMPLATE
>  
>  choice
>  	prompt "Default integrity hash algorithm"


