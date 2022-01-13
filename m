Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B86248DEE2
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jan 2022 21:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiAMU1m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jan 2022 15:27:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233962AbiAMU1l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jan 2022 15:27:41 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20DJqSkc013854;
        Thu, 13 Jan 2022 20:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ekJceOCGGfrfqidGwbkAICrvPbuqId4Hsmd1njqfLJk=;
 b=CVVZWX64KgNK5kNxwk3inMsOw2YHB0pyRTJWaapWzRWltp+bYgL2qFjgBWWYEMeOvbjD
 r9huVHLHNL2p6IgSjwP0t5RhU8VWIuYjptu286UTJXW1I6LOHipQ19ykC0kZGTUhys4M
 OGufcDLlF4SLUTSwlnykGIHnyuaGJouUOupsNdA2hJuMW+yrnnylMQ8hcPu4UFrXZtb+
 Utv51F1l9kJTLF+8w0CNL21Kuc5Sw6F2CNoSozykq6BVbo5FBNzUwd8fiRxE5DQ2L9Wb
 dDJXqAaw+KtuLxBTjR1FcrPI/kwndCCe8sHX48VsnhwUceRsUOm5d/6LssW4y6lbHvWU 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djtme0un5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 20:27:29 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20DKHt04028762;
        Thu, 13 Jan 2022 20:27:29 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djtme0um4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 20:27:28 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20DK8VUO016020;
        Thu, 13 Jan 2022 20:27:25 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3df1vjrb9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 20:27:25 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20DKRMDV45678910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 20:27:22 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 051D0A4066;
        Thu, 13 Jan 2022 20:27:22 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5F2EA4069;
        Thu, 13 Jan 2022 20:27:19 +0000 (GMT)
Received: from sig-9-65-68-109.ibm.com (unknown [9.65.68.109])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jan 2022 20:27:19 +0000 (GMT)
Message-ID: <df3d903ee6c1313a4158ccc958e80f8deafa7a0d.camel@linux.ibm.com>
Subject: Re: [PATCH v8 05/19] ima: Move measurement list related variables
 into ima_namespace
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Thu, 13 Jan 2022 15:27:19 -0500
In-Reply-To: <20220104170416.1923685-6-stefanb@linux.vnet.ibm.com>
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
         <20220104170416.1923685-6-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5P5LSXaSszP--ZQYwMzlroIJLIb499nq
X-Proofpoint-ORIG-GUID: bTHZtkn2DhQmylMtQ0sPkDyge_mhrhh_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_09,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201130126
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

On Tue, 2022-01-04 at 12:04 -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Move measurement list related variables into the ima_namespace. This way a
> front-end like SecurityFS can show the measurement list inside an IMA
> namespace.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  security/integrity/ima/ima.h             |  5 +++--
>  security/integrity/ima/ima_fs.c          |  6 ++++--
>  security/integrity/ima/ima_init_ima_ns.c |  5 +++++
>  security/integrity/ima/ima_kexec.c       | 12 +++++++-----
>  security/integrity/ima/ima_queue.c       | 24 ++++++++++--------------
>  5 files changed, 29 insertions(+), 23 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 68d8a8e6fd1d..ee16ce5050c8 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -106,7 +106,6 @@ struct ima_queue_entry {
>  	struct list_head later;		/* place in ima_measurements list */
>  	struct ima_template_entry *entry;
>  };
> -extern struct list_head ima_measurements;	/* list of all measurements */
>  
>  /* Some details preceding the binary serialized measurement list */
>  struct ima_kexec_hdr {
> @@ -134,6 +133,8 @@ struct ima_namespace {
>  	int ima_policy_flag;
>  
>  	struct ima_h_table ima_htable;
> +	struct list_head ima_measurements;
> +	unsigned long binary_runtime_size;

Please add a comment indicating binary_runtime_size is only applicable
to ns_ima_init.


>  } __randomize_layout;
>  extern struct ima_namespace init_ima_ns;


> @@ -124,12 +119,13 @@ static int ima_add_digest_entry(struct ima_namespace *ns,
>   * entire binary_runtime_measurement list, including the ima_kexec_hdr
>   * structure.
>   */
> -unsigned long ima_get_binary_runtime_size(void)
> +unsigned long ima_get_binary_runtime_size(struct ima_namespace *ns)
>  {
> -	if (binary_runtime_size >= (ULONG_MAX - sizeof(struct ima_kexec_hdr)))
> +	if (ns->binary_runtime_size >=
> +				(ULONG_MAX - sizeof(struct ima_kexec_hdr)))
>  		return ULONG_MAX;
>  	else
> -		return binary_runtime_size + sizeof(struct ima_kexec_hdr);
> +		return ns->binary_runtime_size + sizeof(struct ima_kexec_hdr);
>  }
>  

Please update the function description indicating that either carrying
the measurement list across kexec is limited to ns_ima_init or not
supported by namespaces.

thanks,

Mimi

