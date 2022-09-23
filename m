Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEE15E83F5
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Sep 2022 22:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbiIWUf3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Sep 2022 16:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbiIWUeB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Sep 2022 16:34:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B3F14D30F;
        Fri, 23 Sep 2022 13:28:46 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NKPDua007507;
        Fri, 23 Sep 2022 20:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=C1ePJ8Mf307F7nByJ7BtKcM8WaOumNsqo6SgWuWLwEw=;
 b=Xzb0PKVSMLpfwtNDd4ZmIgKg6KYRwRWpQYVfhC8USQLDiyZrvilCdgpwLCdlGM32a1As
 iXu9bmQ2286Z0uXLI6QV8+zPdDTeym/eKx2tDiqiV1Gk6TQsDhIKhIpElC6p4vqJz21C
 sEjpG19MY8HoLIA2GWagHijQH5teyNaJnmQgZyY1YRhQwKZk9Iq46TmL/WHwXUtibcOz
 hCO9Lzzhw3WCL4gUih28SQ8SrUub13FKNWQRiR9kaiGZAJY/CSHxQwOhKEezslEFTVoR
 bs0ewsqo9RNILomoX6jp+l/vgUvAsAGM3T2d9VEbNP+YoJhSlPjM7Ju0aH1cu3QyHll2 ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jsktj02w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 20:28:33 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28NKPWwo009551;
        Fri, 23 Sep 2022 20:28:32 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jsktj02vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 20:28:32 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28NKL9TY024646;
        Fri, 23 Sep 2022 20:28:31 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 3jn5vamg9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 20:28:31 +0000
Received: from smtpav04.wdc07v.mail.ibm.com ([9.208.128.116])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28NKSUlT7340554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 20:28:30 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B69358054;
        Fri, 23 Sep 2022 20:28:30 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E0B958058;
        Fri, 23 Sep 2022 20:28:29 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.173.46])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 23 Sep 2022 20:28:29 +0000 (GMT)
Message-ID: <0f9387c9ceec0819de7bdb8b3635af8fa8236973.camel@linux.ibm.com>
Subject: Re: [PATCH -next 1/4] ima: Use DECLARE_FLEX_ARRAY() helper in
 ima_modsig
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 23 Sep 2022 16:28:28 -0400
In-Reply-To: <20220905075837.1083216-2-cuigaosheng1@huawei.com>
References: <20220905075837.1083216-1-cuigaosheng1@huawei.com>
         <20220905075837.1083216-2-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -EumnrV6P_ZEykrDwuIzUAun3irb-r9e
X-Proofpoint-ORIG-GUID: 1VEcZepvLU4jde-VqGfHDtl1Nq8N4AiX
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_08,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 bulkscore=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230130
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Gaosheng,

Thank you for the patches.

On Mon, 2022-09-05 at 15:58 +0800, Gaosheng Cui wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members instead. So, replace zero-length array
> declaration with the new DECLARE_FLEX_ARRAY() helper macro in struct
> modsig.
> 
> This helper allows for a flexible-array member in a union.
> 
> Link: KSPP#21
> Link: KSPP#193
> Link: KSPP#197

The above shortened link is a bit confusing.  The #193 complete link is
mentioned in the cover letter.  In all cases being modified the "[]" 
notation is used.  Is this a boiler plate patch description or are all
three of these links really applicable to each of the patches?  

- Eliminate fake flexible arrays from the kernel ("variable length"
one-element and zero-length arrays) #21
- Replace fake flexible-array declarations with the
DECLARE_FLEX_ARRAY() helper macro #193
- Address -Wzero-length-array warnings reported by Clang #197

> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html

Shouldn't this link be in the cover letter?  And the applicable
link(s), as shown in the cover letter, here in the patches?

-- 
thanks,

Mimi

> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  security/integrity/ima/ima_modsig.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
> index fb25723c65bc..d132383dbb64 100644
> --- a/security/integrity/ima/ima_modsig.c
> +++ b/security/integrity/ima/ima_modsig.c
> @@ -29,7 +29,7 @@ struct modsig {
>  	 * storing the signature.
>  	 */
>  	int raw_pkcs7_len;
> -	u8 raw_pkcs7[];
> +	DECLARE_FLEX_ARRAY(u8, raw_pkcs7);
>  };
>  
>  /*


