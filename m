Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92AB77E407
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Aug 2023 16:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbjHPOoF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Aug 2023 10:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343862AbjHPOn6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Aug 2023 10:43:58 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9F62D5F;
        Wed, 16 Aug 2023 07:43:46 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GEYkD8009111;
        Wed, 16 Aug 2023 14:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=eV6cfVJfXrjPrtlfw4ceYY4u5opv4sA1bvwtpNO8nAM=;
 b=sZO5Jsb9zlBtlDSl2L2yBRm1BOrpPG/NymbzPlN8RMqp/mBCKwl4aZ1ewMCiIFw/xwQE
 4oN65CV/dFvQ9zLp2tYvfNfH22QxugQrp2cbMJBa144uN3FtmntPgDlz2wKoxWlLAEs6
 ZGIqMS7WLBRjad4PVlGGYCT20kfjn8ZTTkk3g6iSscGw9LBaCSR/UfQ+fHMVlrunBLhM
 JVxAUhqLfIRG4hfdASznO9a8isKvFV7ra9102FZHnbKIz3V2TaJlxnCNWp/RfBncrQbi
 4acbpHa3nCfwn1PwF7yOS+2G35/5QCEeaKJH9TiziEj8FceN/Uj55ODkaaeYcCTU83SM 8g== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sh0bh0quc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 14:43:34 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37GE1Oxh018848;
        Wed, 16 Aug 2023 14:42:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3seq41ms9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 14:42:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37GEg4k953543262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 14:42:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A76E2004B;
        Wed, 16 Aug 2023 14:42:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2E8020040;
        Wed, 16 Aug 2023 14:42:02 +0000 (GMT)
Received: from [9.43.32.205] (unknown [9.43.32.205])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Aug 2023 14:42:02 +0000 (GMT)
Message-ID: <dc9a4271-8f26-5c2d-27e9-8a6e16abdf37@linux.ibm.com>
Date:   Wed, 16 Aug 2023 20:12:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v4 5/6] integrity: PowerVM machine keyring enablement
Content-Language: en-US
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-security-module@vger.kernel.org, inux-kernel@vger.kernel.org
References: <20230815112722.1591829-1-nayna@linux.ibm.com>
 <20230815112722.1591829-6-nayna@linux.ibm.com>
From:   R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20230815112722.1591829-6-nayna@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R2ruOT0bP3U2etym7pfgUh_qJh_ynTK9
X-Proofpoint-ORIG-GUID: R2ruOT0bP3U2etym7pfgUh_qJh_ynTK9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_14,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160125
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 15/08/23 4:57 pm, Nayna Jain wrote:
> Update Kconfig to enable machine keyring and limit to CA certificates
> on PowerVM. Only key signing CA keys are allowed.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-and-tested-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Tested with trustedcadb, moduledb scenarios
Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>

> ---
>   security/integrity/Kconfig | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
> index ec6e0d789da1..232191ee09e3 100644
> --- a/security/integrity/Kconfig
> +++ b/security/integrity/Kconfig
> @@ -67,7 +67,9 @@ config INTEGRITY_MACHINE_KEYRING
>   	depends on SECONDARY_TRUSTED_KEYRING
>   	depends on INTEGRITY_ASYMMETRIC_KEYS
>   	depends on SYSTEM_BLACKLIST_KEYRING
> -	depends on LOAD_UEFI_KEYS
> +	depends on LOAD_UEFI_KEYS || LOAD_PPC_KEYS
> +	select INTEGRITY_CA_MACHINE_KEYRING if LOAD_PPC_KEYS
> +	select INTEGRITY_CA_MACHINE_KEYRING_MAX if LOAD_PPC_KEYS
>   	help
>   	 If set, provide a keyring to which Machine Owner Keys (MOK) may
>   	 be added. This keyring shall contain just MOK keys.  Unlike keys

-- 
Thanks and Regards
R.Nageswara Sastry
