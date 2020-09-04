Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7301B25E32D
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Sep 2020 23:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgIDVHR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Sep 2020 17:07:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726842AbgIDVHQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Sep 2020 17:07:16 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 084L30bv087878;
        Fri, 4 Sep 2020 17:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=8FlX3a6DPha2xksiaAE2jDylhVSKzOfJeYPqLS0veX0=;
 b=llpr8v4zLAHPa+By1H2EBroqfRSkTEl6ftjFyLnOw7x96RiRSW6+MfyC2QW02xbZlTyw
 1SkcrAYsn45sN7JulKA1Y0acuYJPpU/+Vk/tp/1vncf9a/64/YypLvxCpo0KOk9Pcf2G
 L8n5vfhRkCJU/xaZIdogdmeYA3L90EQmr+4bZ8RQkL/kXkcHfdykaonQV7aWoByJLAS8
 va0R37V4bxX4dH+4JhvlgSsUnLUabsFhlcVKRRwZ92W9IN0S1Vs9nk667se+Je0+opHU
 G9XbJDSpuuxFMWCMVs/90r2lVyfNgD7mX+TK6cBj19lqvAkG8d8+GX69oJoC9FVbJgO6 gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33bt7ucd35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 17:07:15 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 084L4FGC094948;
        Fri, 4 Sep 2020 17:07:15 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33bt7ucd2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 17:07:15 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 084L1r7G015742;
        Fri, 4 Sep 2020 21:07:13 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 337en878gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 21:07:12 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 084L7AE659441650
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Sep 2020 21:07:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A69CA4C052;
        Fri,  4 Sep 2020 21:07:10 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A02D64C044;
        Fri,  4 Sep 2020 21:07:09 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.87.223])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Sep 2020 21:07:09 +0000 (GMT)
Message-ID: <f6b04ff269d3f5f72ee6b005bb97e6ac7b73b43e.camel@linux.ibm.com>
Subject: Re: [PATCH v2 3/4] ima: limit secure boot feedback scope for
 appraise
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 04 Sep 2020 17:07:08 -0400
In-Reply-To: <20200904194100.761848-4-bmeneg@redhat.com>
References: <20200904194100.761848-1-bmeneg@redhat.com>
         <20200904194100.761848-4-bmeneg@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-04_15:2020-09-04,2020-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=993 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040182
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Bruno,

> +	bool sb_state = arch_ima_get_secureboot();
> +	int appraisal_state = ima_appraise;
>  
>  	if (strncmp(str, "off", 3) == 0)
> -		ima_appraise = 0;
> +		appraisal_state = 0;
>  	else if (strncmp(str, "log", 3) == 0)
> -		ima_appraise = IMA_APPRAISE_LOG;
> +		appraisal_state = IMA_APPRAISE_LOG;
>  	else if (strncmp(str, "fix", 3) == 0)
> -		ima_appraise = IMA_APPRAISE_FIX;
> +		appraisal_state = IMA_APPRAISE_FIX;
>  	else if (strncmp(str, "enforce", 7) == 0)
> -		ima_appraise = IMA_APPRAISE_ENFORCE;
> +		appraisal_state = IMA_APPRAISE_ENFORCE;
>  	else
>  		pr_err("invalid \"%s\" appraise option", str);
> +
> +	/* If appraisal state was changed, but secure boot is enabled,
> +	 * keep its default */
> +	if (sb_state) {
> +		if (!(appraisal_state & IMA_APPRAISE_ENFORCE))
> +			pr_info("Secure boot enabled: ignoring ima_appraise=%s option",
> +				str);
> +		else
> +			ima_appraise = appraisal_state;
> +	}

Shouldn't the "else" clause be here.   No need to re-post the entire
patch set.

thanks,

Mimi

>  #endif
>  	return 1;
>  }


