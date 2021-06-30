Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9863B87CB
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Jun 2021 19:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhF3Rkk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Jun 2021 13:40:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229852AbhF3Rkk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jun 2021 13:40:40 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UHYSVg051011;
        Wed, 30 Jun 2021 13:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=EipoytTHxDxFAmnS0m0yUjiYvaQ4TLxY+bClW2/n6M4=;
 b=RZgF3kUHlDc66u5N+zPxlN0Bdqbr8PB6s9HKw3NNuKAqjvN6rw1meqZ1lINLZPR4qqtG
 CUjHUL9IomUoAJEIznGQblwvpdKCPIrnM3+06FZGyIY+Z29cBacp4oagJIuhshnlQoXM
 iqA9yod89x6LYmIhXPfnlpDIpGnv0uqxmmwjjWB+XQyMUS1R/zpuZcliXJrg6RhxuUjI
 XiGILdUW1tRk5duN+Y8T3jY7olaJ4ktOBUivfTt7Ede2YH9cIpR9sInIIrBEokrqBYIS
 46EOgVmrQp52j6t6zYQAh+ZL/k1KrkbHAGoZgA4Z3N6BoJwxWaRILed+TVfmz6hcKm5w xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39gvu9gjur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 13:38:09 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15UHYeNf056442;
        Wed, 30 Jun 2021 13:38:09 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39gvu9gju4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 13:38:08 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15UHV9T6015416;
        Wed, 30 Jun 2021 17:38:07 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 39g91yrg40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 17:38:07 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15UHaQUA35521020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 17:36:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0277F52063;
        Wed, 30 Jun 2021 17:38:05 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.114.126])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9DDB152057;
        Wed, 30 Jun 2021 17:38:03 +0000 (GMT)
Message-ID: <9e3eff6a1aecbf609bf3759addf32848177a08d9.camel@linux.ibm.com>
Subject: Re: [PATCH v6 3/3] ima-evm-utils: Read keyid from the cert appended
 to the key file
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 30 Jun 2021 13:38:02 -0400
In-Reply-To: <20210511115630.795208-4-vt@altlinux.org>
References: <20210511115630.795208-1-vt@altlinux.org>
         <20210511115630.795208-4-vt@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wawic55JtbFqt6I--AsfXys-84wdw4HG
X-Proofpoint-ORIG-GUID: _iIIoHGcx7APQdOGvNva32cKNfge8wTt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-30_08:2021-06-30,2021-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300097
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On Tue, 2021-05-11 at 14:56 +0300, Vitaly Chikunov wrote:
> 
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 1c03768..bfce7ef 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -1021,10 +1021,12 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
>  		return -1;
>  	}
> 
> -	if (imaevm_params.keyid)
> +	if (imaevm_params.keyid) {
>  		hdr->keyid = htonl(imaevm_params.keyid);
> -	else
> -		calc_keyid_v2(&hdr->keyid, name, pkey);
> +	} else {
> +		if (__read_keyid(&hdr->keyid, keyfile, KEYID_FILE_PEM_KEY))
> +			calc_keyid_v2(&hdr->keyid, name, pkey);
> +	}

If the call to  __read_keyid() was independent of the test and call to
calc_keyid_v2(), it would make reading code the easier to understand.

result = __read_keyid(...);
if (result  < 0)
    calc_keyid_v2(...);

thanks,

Mimi

> 
>  	st = "EVP_PKEY_CTX_new";
>  	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))


