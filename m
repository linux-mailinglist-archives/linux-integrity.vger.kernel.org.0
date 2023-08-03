Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465E576F587
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Aug 2023 00:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjHCWQZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Aug 2023 18:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjHCWQY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Aug 2023 18:16:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1AD3A9C
        for <linux-integrity@vger.kernel.org>; Thu,  3 Aug 2023 15:16:19 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373MCDGd013093;
        Thu, 3 Aug 2023 22:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=O1B5KdsoDE1NcfTHcK1yj+kfd2jZwLNC8evbq4DKpPI=;
 b=h7ELUgcI+OFnnkc7NGTtUX6Ad7tTLKNynyAZjtifVC3eZLr2N6KSG2s+KHgK7P5e3hwz
 Fwn3AM9MJBuvKtPkR1Hjv/fA9mARWyZGfEjEFQbevHPQdpGzoZlL+qxPTF4x/cmP/KQW
 SzI4QCbgMs+gEp0kq5DCyU4IIOir23zA7ummT+PVew7Dv2uh6cm5QB/Ia0FxpJgF54MN
 iYcJ6pFLYzdH9JEkrFiDh1atAE2xygrySeoSFLDVaOJHjQpN3frzoRz5Jnnjxs8r675V
 94Jsm/8jSjmHnlkr/L978fFht5ROY5RaTq7cLBq3J2L09M66ZYP8L6/Npi508hBqrZpF dA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8mtr8260-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 22:15:59 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 373MFCF2023439;
        Thu, 3 Aug 2023 22:15:58 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8mtr825h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 22:15:58 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 373Krl7N018450;
        Thu, 3 Aug 2023 22:15:57 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s8kp4rg4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 22:15:57 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 373MFux845023566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Aug 2023 22:15:56 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4F1258056;
        Thu,  3 Aug 2023 22:15:56 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04E9058052;
        Thu,  3 Aug 2023 22:15:56 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.157.226])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  3 Aug 2023 22:15:55 +0000 (GMT)
Message-ID: <223d5c5a655fec263895c991550e4291d1bbd4c9.camel@linux.ibm.com>
Subject: Re: [PATCH 5/6] ima: measure TPM update counter at ima_init
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>, noodles@fb.com,
        bauermann@kolabnow.com, ebiederm@xmission.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date:   Thu, 03 Aug 2023 18:15:55 -0400
In-Reply-To: <20230801181917.8535-6-tusharsu@linux.microsoft.com>
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
         <20230801181917.8535-6-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dpDrD-ar3j94nXpTMb1pEbtJtVst3zSl
X-Proofpoint-ORIG-GUID: Ez4hbw6zPKDgtUGVo2uWf1omrPeBcOkQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_22,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030198
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-08-01 at 11:19 -0700, Tushar Sugandhi wrote:
> IMA log entries can be lost due to a variety of causes, such as code bugs
> or error conditions, leading to a mismatch between TPM PCRs and
> the IMA log.  Measuring TPM PCR update counter during ima_init would
> provide a baseline counter for the number of times the TPM PCRs are
> updated.  The remote attestation service can compare this baseline
> counter with a subsequent measured one (e.g., post-kexec soft-boot) to
> identify if there are any lost IMA log events.
> 
> Measure the TPM update counter at ima init.

No need for separate patches for one line changes like this.  Either
merge patches 5/6 and 6/6 or all three 4/6, 5/6, 6/6 together.

> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_init.c | 3 +++
>  security/integrity/ima/ima_main.c | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index 63979aefc95f..9bb18d6c2fd6 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -154,5 +154,8 @@ int __init ima_init(void)
>  				  UTS_RELEASE, strlen(UTS_RELEASE), false,
>  				  NULL, 0);
>  
> +	/* Measures TPM update counter at ima_init */
> +	ima_measure_update_counter("ima_init_tpm_update_counter");
> +

With "ima_policy=critical_data" on the boot command line, the IMA
measurement list record looks like:

6e190cc643ff0b718485966a0300473baedface735 ima_init_tpm_update_counter 7570646174655f636f756e7465723d3330383b

Please change the "ima_init_tpm_update_counter" to something shorter
and the hex encoded ascii string and pcr counter to something readable.
Perhaps name this critical-data "tpm" and "tpm-info", similar to the
SELinux "selinux" and "selinux-state".  Then again, if this is TPM
critical-data we should rethink what other info should be included.

>  	return rc;
>  }
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 1bcd45cc5a6a..93357c245e82 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1035,6 +1035,7 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>  				   buf, size, "kexec-cmdline", KEXEC_CMDLINE, 0,
>  				   NULL, false, NULL, 0);
>  	fdput(f);
> +
>  }
>  
>  /**

Unnecessary change.

-- 
thanks,

Mimi

