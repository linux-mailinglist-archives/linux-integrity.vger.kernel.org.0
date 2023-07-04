Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A4E7471F5
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jul 2023 14:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGDM50 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jul 2023 08:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjGDM5X (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jul 2023 08:57:23 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD89710CE;
        Tue,  4 Jul 2023 05:57:18 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 364Clq1L030500;
        Tue, 4 Jul 2023 12:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=iTDv4VPTfZqUZ7AKCiQnqMYiZmFlxHkGxEf8+CPNWo8=;
 b=F2z63e/OYzNaCShNERNgVClfVfXi3YLv77s28P2rmWpDMlYrvMKUrWpvHmbMbuYA16Mv
 usDaskLOxXN2ssxtqJGUWHL+C83KmR3jbibqzp4PPB0FgQUbYPp4/ZInIJT7ybrSzu5O
 vGPrSTWJEA7hC4YjiCgiPA8wl9VIjd29ZHYYeWdXLePTSETfWsxrHQ1CvtBEmLR8Q7CL
 62NI/8kVSECLXFWIeQUmGTIUqnIr9uYX2dAUXC/rSeNSfnp/87WKQmgmY9wA1fqUS0Rg
 stGyEZMiJr9jh3GdcAD48XIyUoIzjl/U1h7OjnBquq7UgTwNaJCAAJmZrxABNM5k6XXo 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmkr887x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 12:57:15 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 364CnP0p003018;
        Tue, 4 Jul 2023 12:57:14 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmkr887wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 12:57:14 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 364A6PWf008595;
        Tue, 4 Jul 2023 12:57:14 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3rjbs5ys1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 12:57:13 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 364CvCMW25297190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jul 2023 12:57:12 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EACE458055;
        Tue,  4 Jul 2023 12:57:11 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33E0F5805E;
        Tue,  4 Jul 2023 12:57:11 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.36.177])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jul 2023 12:57:11 +0000 (GMT)
Message-ID: <b61fedf214cbe72de063a3bf516dd72f80595219.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: require signed IMA policy when UEFI secure boot is
 enabled
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Coiby Xu <coxu@redhat.com>, linux-integrity@vger.kernel.org
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 04 Jul 2023 08:57:10 -0400
In-Reply-To: <20230703115442.129725-1-coxu@redhat.com>
References: <20230703115442.129725-1-coxu@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TAr0e02RnOj9NLIdD-orsSF3sFfLLkK4
X-Proofpoint-GUID: kHJ-0h6YRVkkA6xkvOne638UU5eyQSgX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_07,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307040106
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-07-03 at 19:54 +0800, Coiby Xu wrote:
> With the introduction of the .machine keyring for UEFI-based systems,
> users are able to add custom CAs keys via MOK. This allow users to sign
> their own IMA polices. For the sake of security, mandate signed IMA
> policy when UEFI secure boot is enabled.
> 
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  security/integrity/ima/ima_efi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
> index 9db66fe310d4..bb2881759505 100644
> --- a/security/integrity/ima/ima_efi.c
> +++ b/security/integrity/ima/ima_efi.c
> @@ -58,6 +58,9 @@ static const char * const sb_arch_rules[] = {
>  #if !IS_ENABLED(CONFIG_MODULE_SIG)
>  	"appraise func=MODULE_CHECK appraise_type=imasig",
>  #endif
> +#if IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) && IS_ENABLED(CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY)
> +	"appraise func=POLICY_CHECK appraise_type=imasig",
> +#endif /* CONFIG_INTEGRITY_MACHINE_KEYRING && IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY */
>  	"measure func=MODULE_CHECK",
>  	NULL
>  };

Thanks, Coiby.

Using IS_ENABLED() is not wrong, but unnecessary.  IS_BUILTIN()
suffices.

-- 
thanks,

Mimi

