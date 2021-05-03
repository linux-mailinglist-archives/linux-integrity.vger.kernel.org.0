Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FA137213B
	for <lists+linux-integrity@lfdr.de>; Mon,  3 May 2021 22:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhECU0H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 May 2021 16:26:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229472AbhECU0G (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 May 2021 16:26:06 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 143K4Rhj018305;
        Mon, 3 May 2021 16:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=D8snbhs9Ja2wTdrLhyhuisfg816IeGOFFy8jzgSZLhc=;
 b=rLI8LY9EZgNrkH+4WGlUetoUdzpNB/SuzqXowZKJwqIy14fcCkk61uoV7tj6IO1vjqu/
 Rfv2VKe24ygJ1SIaMsymwuz1K7BrTpcSLJQn1WdPtBVxuSIJfVHif/4r127nuXxOVXyn
 SoPz8YT000/he/HaQeMeKjSVyOWUmKJFDyhHVYXdQujCPvuqR3Sy6dL3rsKNRiqCpPIb
 O1067rC+HdorS6FY3VgTX0BqXC/zJ7NJvChek9Ne2xPFASRdWJI5SZUENFrRSzn/fl75
 m1rb2bhOpP3oxOlQNIXa46Mxw9Kc7KbkPCBlMu9kG6zjK+wu1bcaRyAc57tnemX5rQYt sA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38amhee34w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 16:25:11 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 143KI1tG067659;
        Mon, 3 May 2021 16:25:10 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38amhee34r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 16:25:10 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 143KHZuH011604;
        Mon, 3 May 2021 20:25:10 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04wdc.us.ibm.com with ESMTP id 388xm8rm7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 20:25:10 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 143KP9d827001094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 May 2021 20:25:09 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FC776E052;
        Mon,  3 May 2021 20:25:09 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D008E6E056;
        Mon,  3 May 2021 20:25:08 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  3 May 2021 20:25:08 +0000 (GMT)
Subject: Re: [RFC PATCH] ima-evm-utils: Allow manual setting keyid for signing
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20210430201334.3643230-1-vt@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <f9e2296e-3b84-c440-8486-f2c8bd9fde60@linux.ibm.com>
Date:   Mon, 3 May 2021 16:25:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210430201334.3643230-1-vt@altlinux.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0dh_diK0cWSr3zgtz8Wks1mlF3-tMdqQ
X-Proofpoint-GUID: pgzbdH97XtkjyTxbM1PQOmXXY4qnYETa
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-03_19:2021-05-03,2021-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030137
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/30/21 4:13 PM, Vitaly Chikunov wrote:
> Allow user to set signature's keyid using `--keyid' option. Keyid should
> correspond to SKID in certificate, when keyid is calculated using SHA-1
> in libimaevm it may mismatch keyid extracted by the kernel from SKID of
> certificate (the way public key is presented to the kernel), thus making
> signatures not verifiable. This may happen when certificate is using non
> SHA-1 SKID (see rfc7093) or just 'unique number' (see rfc5280 4.2.1.2).
> As a last resort user may specify arbitrary keyid using the new option.
>
> This commit creates backward compatible ABI change for libimaevm,
> because of adding additional parameter to imaevm_params - older
> libimaevm can work with newer client.
>
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>
> +		case 143:
> +			errno = 0;
> +			keyid = strtoul(optarg, &eptr, 16);
> +			if (errno || eptr - optarg != strlen(optarg) ||
> +			    keyid > UINT_MAX || keyid == 0) {
> +				log_err("Invalid keyid value.\n");
> +				exit(1);
> +			}
> +			imaevm_params.keyid = htonl(keyid);


I would leave it in native format here ...


>   		log_err("sign_hash_v2: hash is null\n");
> @@ -932,8 +931,10 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
>   		return -1;
>   	}
>   
> -	calc_keyid_v2(&keyid, name, pkey);
> -	hdr->keyid = keyid;
> +	if (imaevm_params.keyid)
> +		hdr->keyid = imaevm_params.keyid;


... and convert it to big endian here when you write it out and where it 
needs to be in big endian format.


