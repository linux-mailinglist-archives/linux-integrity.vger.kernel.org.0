Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECBA3F3571
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Aug 2021 22:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239307AbhHTUk7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Aug 2021 16:40:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229811AbhHTUk7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Aug 2021 16:40:59 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17KKbYRg103783;
        Fri, 20 Aug 2021 16:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=bdzy0qw0uLZwSG/Ec24VgKv4ya+aGMLknjqliBqgKoc=;
 b=kKd+HMORUY4lqaFmyk2FRLCYPhXPtnBeuGxkPtxy5CyM9m+w4mirvijCcAA0DbStIxxd
 xM5fqzCkxkCKM2msiSBzxHuFdZlyeAIU1mRoZ2U4ScssiuKVfK9Wascy9r3x+pkkCDE0
 +MSK/NGiWkVB8vaKbQJnexO10+z5xiMlJRhxNwECQqmOLc92QgPrv4XZvTir2bDtMDHP
 ZI32iY1mzMWya4/01PzfHdl1nqKEHEJFwGC07Nc8RvSnoO5DePT6lmUxNfTI59rIB3l0
 4Xz0SPkSXm4AnR+eHBEoOtPuD6LDxhd2AMifPuGcWqE2IO4r9QOIGkaMAbPEhdG2hp2u tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aj6smv9yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 16:40:19 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17KKeJiu112486;
        Fri, 20 Aug 2021 16:40:19 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aj6smv9xx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 16:40:19 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17KKTtZ9004079;
        Fri, 20 Aug 2021 20:40:16 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3ae53hh0t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 20:40:16 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17KKacaj56754576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 20:36:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2C4B42054;
        Fri, 20 Aug 2021 20:40:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3DFF42049;
        Fri, 20 Aug 2021 20:40:12 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.35.235])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 Aug 2021 20:40:12 +0000 (GMT)
Message-ID: <e6638458d82b767546b30d5c9c0cdde03d674e04.camel@linux.ibm.com>
Subject: Re: [PATCH] IMA: set a default value for unknown digsig algorithms
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     "syzbot+e8bafe7b82c739eaf153@syzkaller.appspotmail.com" 
        <syzbot+e8bafe7b82c739eaf153@syzkaller.appspotmail.com>
Date:   Fri, 20 Aug 2021 16:40:11 -0400
In-Reply-To: <20210820121847.34087-1-Simon.THOBY@viveris.fr>
References: <20210820121847.34087-1-Simon.THOBY@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QVGJYc-B4vpFtQtOnG_URikiT1fSidds
X-Proofpoint-ORIG-GUID: sRTFJWfca6Z4HwIlLbOyvraDJJ2zc_pJ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-20_08:2021-08-20,2021-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 phishscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108200115
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On Fri, 2021-08-20 at 12:18 +0000, THOBY Simon wrote:
> When adding new protections against writing invalid data in
> the security.ima xattr, I erroneously expected ima_get_hash_algo()
> to always return a valid 'enum hash_algo', but it turns out it trusts
> the user-supplied digital signatures and return it without any checks.
> It didn't affect process_measurement() because that function
> (indirectly) calls into ima_alloc_atfm() that fallback silently
> on the default hash algorithm, but it did affect ima_inode_setxattr
> as that new function didn't perform a bounds check.

Please update patch description something like:

The new function validate_hash_algo() assumed that ima_get_hash_algo()
always return a valid 'enum hash_algo', but returned the user-supplied hash algorithm from the digital signature without any checks.

> 
> Update ima_get_hash_algo() to always return a valid hash algorithm,
> defaulting on 'ima_hash_algo' when the user-supplied value inside
> the xattr is invalid.
> 
> This patch was successfully tested by syszbot, see
> https://syzkaller.appspot.com/bug?extid=e8bafe7b82c739eaf153.

Thank you for the pointer.
> 
> Signed-off-by: THOBY Simon <Simon.THOBY@viveris.fr>
> Reported-by: syzbot+e8bafe7b82c739eaf153@syzkaller.appspotmail.com
Fixes: 50f742dd9147 ("IMA: block writes of the security.ima xattr with
unsupported algorithms")

thanks,

Mimi

> ---
>  security/integrity/ima/ima_appraise.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 8f1eb7ef041e..dbba51583e7c 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -185,7 +185,8 @@ enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value,
>  	switch (xattr_value->type) {
>  	case EVM_IMA_XATTR_DIGSIG:
>  		sig = (typeof(sig))xattr_value;
> -		if (sig->version != 2 || xattr_len <= sizeof(*sig))
> +		if (sig->version != 2 || xattr_len <= sizeof(*sig)
> +		    || sig->hash_algo >= HASH_ALGO__LAST)
>  			return ima_hash_algo;
>  		return sig->hash_algo;
>  		break;


