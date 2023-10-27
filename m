Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6497D9C56
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Oct 2023 16:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346132AbjJ0O4p (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Oct 2023 10:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346152AbjJ0O4o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Oct 2023 10:56:44 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B7D116
        for <linux-integrity@vger.kernel.org>; Fri, 27 Oct 2023 07:56:42 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39REeDNr012376;
        Fri, 27 Oct 2023 14:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=LMWTIJQBAHemhoLoCoFLK4T1pPVRNppY6I+46f8louc=;
 b=OMr37hwgFPq7JjOa+xaXw1HKVgm+4MRdmQzPfOlUuoo+uFg+6LMXHQuoTsrnka8Vl7w5
 nfMFqM2ccDOxCX0fw/4XD9qWxL7N5XeDP8gMLP51ZxYk2djBTnSghztdwmQc11c9vXfy
 mDGnDPgxozcIiGnHzLcv4iaZtLGRYWu9GT7zq+TxfMciJ8BXwhgwDEZcmLCd+JHGrkx4
 gF2r+qIjOU0WcebYLyeHP6gXUlMhmOE6LS2zR3CjspEE/mH9/HNTNoSn1WwFQIVb65am
 XejCmsYRG0cGutD8PRYasV4hj6MDYHOQ6LjEw44JxnAMJ4mye2STla0VleKNU5ULmadg ZQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u0f5w0fpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 14:56:21 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDGnQO026905;
        Fri, 27 Oct 2023 14:56:20 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tywqrns90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 14:56:20 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39REuKSC46465738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 14:56:20 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5760158055;
        Fri, 27 Oct 2023 14:56:20 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9DDC58043;
        Fri, 27 Oct 2023 14:56:19 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.185.59])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Oct 2023 14:56:19 +0000 (GMT)
Message-ID: <2b95e8b9ebe10a24c7cb6fc90cb2d1342a157ed5.camel@linux.ibm.com>
Subject: Re: [PATCH v2 7/7] ima: record log size at kexec load and execute
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date:   Fri, 27 Oct 2023 10:56:19 -0400
In-Reply-To: <20231005182602.634615-8-tusharsu@linux.microsoft.com>
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
         <20231005182602.634615-8-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6GpTrI0eKrgjbZsmY8cJ7TfGGU4qHI95
X-Proofpoint-ORIG-GUID: 6GpTrI0eKrgjbZsmY8cJ7TfGGU4qHI95
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2310270128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

On Thu, 2023-10-05 at 11:26 -0700, Tushar Sugandhi wrote:
> The window between kexec 'load' and 'execute' could be arbitrarily long.
> Even with the large chunk of memory allocated at kexec 'load', it may
> run out which would result in missing events in IMA log after the system
> soft reboots to the new Kernel.  This would result in IMA measurements
> getting out of sync with the TPM PCR quotes which would result in remote
> attestation failing for that system.  There is currently no way for the
> new Kernel to know if the IMA log TPM PCR quote out of sync problem is
> because of the missing measurements during kexec.
> 
> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be 
> measured at kexec 'load' and 'execute' respectively.
> 
> IMA measures 'boot_aggregate' as the first event when the system boots - 
> either cold boot or kexec soft boot.  In case when the system goes
> through multiple soft reboots, the number of 'boot_aggregate' events in
> IMA log corresponds to total number of boots (cold boot plus multiple
> kexec soft reboots).  With this change, there would be additional 
> 'kexec_load' and 'kexec_execute' events in between the two 
> 'boot_aggregate' events.  In rare cases, when the system runs out of
> memory during kexec soft reboot, 'kexec_execute' won't be copied since
> its one of the very last event measured just before kexec soft reboot.
> The absence of the event 'kexec_execute' in between the two 
> boot_aggregate' events would signal the attestation service that the IMA
> log on the system is out of sync with TPM PCR quotes and the system needs
> to be cold booted for the remote attestation to succeed again.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

Adding a new type of critical data is fine.  The patch description
should describe the reason for it.  Please update the Subject line and
the patch description accordingly.

> ---
>  security/integrity/ima/ima_kexec.c | 35 +++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 6cd5f46a7208..0f9c424fe808 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -17,6 +17,8 @@
>  #include "ima.h"
>  
>  #ifdef CONFIG_IMA_KEXEC
> +#define IMA_KEXEC_EVENT_LEN 128
> +
>  struct seq_file ima_kexec_file;
>  struct ima_kexec_hdr ima_khdr;
>  static void *ima_kexec_buffer;
> @@ -34,6 +36,8 @@ void ima_clear_kexec_file(void)
>  
>  static int ima_alloc_kexec_buf(size_t kexec_segment_size)
>  {
> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
> +
>  	if ((kexec_segment_size == 0) ||
>  	    (kexec_segment_size == ULONG_MAX) ||
>  	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
> @@ -64,6 +68,12 @@ static int ima_alloc_kexec_buf(size_t kexec_segment_size)
>  	memset(&ima_khdr, 0, sizeof(ima_khdr));
>  	ima_khdr.version = 1;
>  
> +	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
> +		  "kexec_segment_size=%lu;", kexec_segment_size);
> +
> +	ima_measure_critical_data("ima_kexec", "kexec_load", ima_kexec_event,
> +				  strlen(ima_kexec_event), false, NULL, 0);
> +
>  	return 0;
>  }
>  
> @@ -198,6 +208,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>  static int ima_update_kexec_buffer(struct notifier_block *self,
>  				   unsigned long action, void *data)
>  {
> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
>  	void *buf = NULL;
>  	size_t buf_size;
>  	bool resume = false;
> @@ -213,9 +224,31 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
>  		return NOTIFY_OK;
>  	}
>  
> +	buf_size = ima_get_binary_runtime_size();
> +	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
> +		  "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;",
> +		  kexec_segment_size, buf_size);
> +
> +	/*
> +	 * This is one of the very last events measured by IMA before kexec
> +	 * soft rebooting into the new Kernal.
> +	 * This event can be used as a marker after the system soft reboots
> +	 * to the new Kernel to check if there was sufficient memory allocated
> +	 * at kexec 'load' to capture the events measured between the window
> +	 * of kexec 'load' and 'execute'.
> +	 * This event needs to be present in the IMA log, in between the two
> +	 * 'boot_aggregate' events that are logged for the previous boot and
> +	 * the current soft reboot. If it is not present after the system soft
> +	 * reboots into the new Kernel, it would mean the IMA log is not
> +	 * consistent with the TPM PCR quotes, and the system needs to be
> +	 * cold-booted for the attestation to succeed again.
> +	 */

Comments like this don't belong in the code.  Please refer to section
"8) Commenting" of Documentation/process/coding-style.rst.

> +	ima_measure_critical_data("ima_kexec", "kexec_execute",
> +				  ima_kexec_event, strlen(ima_kexec_event),
> +				  false, NULL, 0);
> +
>  	ima_measurements_suspend();
>  
> -	buf_size = ima_get_binary_runtime_size();
>  	ret = ima_dump_measurement_list(&buf_size, &buf,
>  					kexec_segment_size);
>  
-- 
thanks,

Mimi

