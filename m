Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6F03D7CE7
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 19:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhG0R5r (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 13:57:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231646AbhG0R5q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 13:57:46 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16RHh3DS131771;
        Tue, 27 Jul 2021 13:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=/0t9FhgYnXPLoo0Fh4xtTavLb+bVg0SLdNQus7YoXAw=;
 b=h8dTGdpYmjvfhrsK1I7XqV4+CNkOSKlHENcUDC3pcS9/8DniARLSSArOx6n7oIamO4a0
 vj4gDKxzdZv5JrJ+XtY0zeMo/ITeQ3RKJYepFdP7URmMCd8EsmBBffq++uMqhoZRQpwC
 jY56M1owZ8pb0JBqNSV8gsq0gVshH+h/YRPMwwDg5UlknXD2oH6gGH5PY8MzDw71smN4
 ucYZPMtU64E5jsqkRnjaNcTaStdc0FCa//UE53gUf8rsRN13kviTSANKV2671f71U2Id
 2BSZtO7AyDEsia+OKVTq8jQUPujbeOTsSnifxSriSKReXvH+N/rFYOfHAO6itPhOca0q 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a2psp8d2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 13:57:45 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16RHhovR134400;
        Tue, 27 Jul 2021 13:57:45 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a2psp8d2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 13:57:45 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16RHqatO020742;
        Tue, 27 Jul 2021 17:57:43 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3a235kgk66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 17:57:43 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16RHvfn525756148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 17:57:41 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E5D8AE055;
        Tue, 27 Jul 2021 17:57:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F13EAE04D;
        Tue, 27 Jul 2021 17:57:40 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.85.52])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Jul 2021 17:57:39 +0000 (GMT)
Message-ID: <01510e984cbef37193f43840776e073f8ace7917.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/5] IMA: remove the dependency on CRYPTO_MD5
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Date:   Tue, 27 Jul 2021 13:57:39 -0400
In-Reply-To: <20210727163330.790010-2-simon.thoby@viveris.fr>
References: <20210727163330.790010-1-simon.thoby@viveris.fr>
         <20210727163330.790010-2-simon.thoby@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 777AcF7uVhRWcwn5fUTZvYOIoe2WQrEn
X-Proofpoint-ORIG-GUID: KvKnKQLm9hoBc22P9OOatK791vTildy9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-27_10:2021-07-27,2021-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270105
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On Tue, 2021-07-27 at 16:33 +0000, THOBY Simon wrote:
<snip>

> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 287b90509006..d171764230b7 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -53,8 +53,10 @@ static int __init hash_setup(char *str)
>  	if (strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) == 0) {
>  		if (strncmp(str, "sha1", 4) == 0) {
>  			ima_hash_algo = HASH_ALGO_SHA1;
> +#ifdef CONFIG_CRYPTO_MD5

As much as possible ifdef's should be avoided in C code.   If
necessary, using the IS_ENABLED macro is preferred.

>  		} else if (strncmp(str, "md5", 3) == 0) {
>  			ima_hash_algo = HASH_ALGO_MD5;
> +#endif
>  		} else {
>  			pr_err("invalid hash algorithm \"%s\" for template \"%s\"",
>  				str, IMA_TEMPLATE_IMA_NAME);

thanks,

Mimi

